import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/di/service_locator.dart';
import '../../../core/env/env.dart';
import '../../../core/env/env_manager.dart';
import '../providers/auth_provider.dart';
import '../providers/auth_state.dart';

@RoutePage()
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _apiKeyController = TextEditingController();
  final _apiSecretController = TextEditingController();
  bool _obscureSecret = true;
  // Default to whatever env the app is currently configured with — that's
  // either the persisted env (post-restore) or the --dart-define fallback.
  late BinanceEnv _selectedEnv = sl<EnvManager>().current.env;

  @override
  void dispose() {
    _apiKeyController.dispose();
    _apiSecretController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthState>(authProvider, (_, state) {
      if (state is AuthError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.message),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    });

    final authState = ref.watch(authProvider);
    final isLoading = authState is AuthAuthenticating;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Binance',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Enter your API credentials',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 32),
                  _EnvPicker(
                    selected: _selectedEnv,
                    enabled: !isLoading,
                    onChanged: (env) => setState(() => _selectedEnv = env),
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _apiKeyController,
                    decoration: const InputDecoration(
                      labelText: 'API Key',
                      prefixIcon: Icon(Icons.key_outlined),
                    ),
                    validator: _validateRequired,
                    enabled: !isLoading,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _apiSecretController,
                    decoration: InputDecoration(
                      labelText: 'API Secret',
                      prefixIcon: const Icon(Icons.lock_outlined),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureSecret
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () =>
                            setState(() => _obscureSecret = !_obscureSecret),
                      ),
                    ),
                    obscureText: _obscureSecret,
                    validator: _validateRequired,
                    enabled: !isLoading,
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: isLoading ? null : _submit,
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('Connect'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? _validateRequired(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    ref
        .read(authProvider.notifier)
        .login(
          apiKey: _apiKeyController.text.trim(),
          apiSecret: _apiSecretController.text.trim(),
          env: _selectedEnv,
        );
  }
}

class _EnvPicker extends StatelessWidget {
  const _EnvPicker({
    required this.selected,
    required this.enabled,
    required this.onChanged,
  });

  final BinanceEnv selected;
  final bool enabled;
  final ValueChanged<BinanceEnv> onChanged;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<BinanceEnv>(
      segments: const [
        ButtonSegment<BinanceEnv>(
          value: BinanceEnv.mainnet,
          label: Text('Mainnet'),
          icon: Icon(Icons.public),
        ),
        ButtonSegment<BinanceEnv>(
          value: BinanceEnv.testnet,
          label: Text('Testnet'),
          icon: Icon(Icons.science_outlined),
        ),
      ],
      selected: <BinanceEnv>{selected},
      onSelectionChanged: enabled ? (set) => onChanged(set.first) : null,
    );
  }
}

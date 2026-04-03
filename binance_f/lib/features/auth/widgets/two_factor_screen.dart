import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/router/app_router.dart';
import '../data/models/two_factor_request.dart';
import '../providers/auth_provider.dart';
import '../providers/auth_state.dart';

@RoutePage()
class TwoFactorScreen extends ConsumerStatefulWidget {
  const TwoFactorScreen({
    required this.twoFactorToken,
    required this.type,
    super.key,
  });

  final String twoFactorToken;
  final TwoFactorType type;

  @override
  ConsumerState<TwoFactorScreen> createState() => _TwoFactorScreenState();
}

class _TwoFactorScreenState extends ConsumerState<TwoFactorScreen> {
  final _codeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthState>(authProvider, (_, state) {
      switch (state) {
        case AuthAuthenticated():
          context.router.replaceAll([const HomeRoute()]);
        case AuthError(:final message):
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        case AuthUnauthenticated():
        case AuthAuthenticating():
        case AuthRequiresTwoFactor():
          break;
      }
    });

    final authState = ref.watch(authProvider);
    final isLoading = authState is AuthAuthenticating;

    final typeLabel = switch (widget.type) {
      TwoFactorType.totp => 'Google Authenticator',
      TwoFactorType.sms => 'SMS',
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Two-Factor Authentication'),
        leading: BackButton(
          onPressed: () {
            ref.read(authProvider.notifier).logout();
            context.router.maybePop();
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  widget.type == TwoFactorType.totp
                      ? Icons.security
                      : Icons.sms,
                  size: 64,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 24),
                Text(
                  'Enter the code from $typeLabel',
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                TextFormField(
                  controller: _codeController,
                  decoration: const InputDecoration(
                    labelText: 'Verification code',
                    prefixIcon: Icon(Icons.pin),
                  ),
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall,
                  validator: (value) {
                    if (value == null || value.length != 6) {
                      return 'Enter a 6-digit code';
                    }
                    return null;
                  },
                  enabled: !isLoading,
                ),
                const SizedBox(height: 24),
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
                        : const Text('Verify'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    ref
        .read(authProvider.notifier)
        .verifyTwoFactor(
          code: _codeController.text.trim(),
          type: widget.type,
          twoFactorToken: widget.twoFactorToken,
        );
  }
}

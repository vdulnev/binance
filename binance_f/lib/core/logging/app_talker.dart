import 'package:talker/talker.dart';

Talker createAppTalker() {
  return Talker(
    settings: TalkerSettings(useConsoleLogs: true),
    filter: _RedactingFilter(),
  );
}

class _RedactingFilter extends TalkerFilter {
  static const _sensitiveKeys = [
    'token',
    'password',
    'secret',
    'apiKey',
    'api_key',
    'signature',
    'credential',
  ];

  static final _pattern = RegExp(
    '(${_sensitiveKeys.join('|')})["\']?\\s*[:=]\\s*["\']?([^"\'\\s,}]+)',
    caseSensitive: false,
  );

  @override
  bool filter(TalkerData item) {
    if (_containsSensitive(item.message ?? '')) {
      return false;
    }
    return true;
  }

  static bool _containsSensitive(String text) {
    return _pattern.hasMatch(text);
  }
}

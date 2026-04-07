import 'package:talker/talker.dart';

/// Single Talker instance for the whole app. Redaction of secrets happens
/// in the Dio logging interceptor (`RedactingDioLogger`) before any data is
/// handed to Talker, so no filter is needed here.
Talker createAppTalker() {
  return Talker(settings: TalkerSettings(useConsoleLogs: true));
}

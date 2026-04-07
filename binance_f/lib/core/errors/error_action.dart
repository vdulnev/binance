import 'package:freezed_annotation/freezed_annotation.dart';

part 'error_action.freezed.dart';

/// What the UI should do in response to an [AppException]. Computed by
/// `errorActionFor` and dispatched at the app shell level.
@freezed
sealed class ErrorAction with _$ErrorAction {
  const factory ErrorAction.showSnackbar(String message) = ShowSnackbar;
  const factory ErrorAction.showDialog({
    required String title,
    required String message,
  }) = ShowDialog;
  const factory ErrorAction.forceRelogin(String reason) = ForceRelogin;
  const factory ErrorAction.blockUi(String reason) = BlockUi;
}

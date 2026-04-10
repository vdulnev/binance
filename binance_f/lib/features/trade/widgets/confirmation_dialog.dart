import 'package:flutter/material.dart';

/// Shared confirmation dialog for destructive actions (FR-5.4, NFR-10).
///
/// Returns `true` if the user confirms, `false` or `null` on dismiss.
/// Trade providers call `showConfirmationDialog` and only proceed when
/// the returned future resolves to `true`.
Future<bool?> showConfirmationDialog({
  required BuildContext context,
  required String title,
  required Widget content,
  String confirmLabel = 'Confirm',
  String cancelLabel = 'Cancel',
  bool destructive = false,
}) {
  return showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: content,
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(cancelLabel),
        ),
        FilledButton(
          style: destructive
              ? FilledButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.error,
                  foregroundColor: Theme.of(context).colorScheme.onError,
                )
              : null,
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(confirmLabel),
        ),
      ],
    ),
  );
}

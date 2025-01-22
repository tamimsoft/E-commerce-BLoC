import 'package:flutter/material.dart';

Future<void> showConfirmationDialog({
  required BuildContext context,
  required String title,
  required String content,
  required VoidCallback onConfirm,
  VoidCallback? onCancel,
}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () {
              if (onCancel != null) onCancel();
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              onConfirm();
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text(
              'Confirm',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      );
    },
  );
}

Future<dynamic> showCustomDialog({
  required BuildContext context,
  required String title,
  required String content,
  required VoidCallback onConfirm,
  VoidCallback? onCancel,
  String? cancelBtnLabel,
  String? confirmBtnLabel,
  IconData? icon,
}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          onCancel != null
              ? TextButton(
                  onPressed: () {
                    onCancel();
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text(cancelBtnLabel ?? 'Cancel'),
                )
              : SizedBox(),
          TextButton(
            onPressed: () {
              onConfirm();
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text(
              confirmBtnLabel ?? 'Confirm',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      );
    },
  );
}

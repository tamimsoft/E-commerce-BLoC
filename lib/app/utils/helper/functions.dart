import 'package:flutter/material.dart';

// import '../../features/common/widgets/app_alert_dialog.dart';
import '../../core/constants/app_colors.dart';

extension EmailValidator on String {
  bool get isEmail {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

Widget loading() {
  return const Center(
    child: CircularProgressIndicator(
      color: AppColors.primary,
      // strokeWidth: 2,
    ),
  );
}

Widget buttonLoading({Color? color}) {
  return SizedBox(
    width: 24,
    height: 24,
    child: CircularProgressIndicator(
      color: color ?? Colors.white,
      strokeWidth: 2,
    ),
  );
}

// void deleteDialog({
//   required VoidCallback onConfirm,
//   String? message,
// }) {
//   GenericAlertDialog.show(
//     title: 'Delete Confirmation',
//     message: message ?? 'Are you sure you want to Delete this task?',
//     confirmText: 'Delete',
//     cancelText: 'Cancel',
//     onConfirm: onConfirm,
//     onCancel: () {
//       // Handle cancel action
//     },
//   );
// }

Color getColorFromName(String name) {
  switch (name.toLowerCase()) {
    case 'red':
      return Colors.red;
    case 'blue':
      return Colors.blue;
    case 'green':
      return Colors.green;
    case 'black':
      return Colors.black;
    case 'white':
      return Colors.white;
    case 'yellow':
      return Colors.yellow;
    case 'purple':
      return Colors.purple;
    case 'orange':
      return Colors.orange;
    case 'pink':
      return Colors.pink;
    case 'brown':
      return Colors.brown;
    default:
      return Colors.black;
    // throw ArgumentError("Color name '$name' is not recognized.");
  }
}

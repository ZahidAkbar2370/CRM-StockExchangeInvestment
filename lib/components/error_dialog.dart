import 'package:flutter/material.dart';
import '../settings.dart';

void showErrorDialog(BuildContext context, String title, String content) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: AppStyle.dangerColor,
        title: Text(
          title,
          style: TextStyle(
            color: AppStyle.whiteTextColor,
          ),
        ),
        content: Text(
          content,
          style: TextStyle(
            color: AppStyle.whiteTextColor,
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}

void showSuccessDialog(BuildContext context, String title, String content) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: AppStyle.successColor,
        title: Text(
          title,
          style: TextStyle(
            color: AppStyle.whiteTextColor, // Error Dialog Title Color
          ),
        ),
        content: Text(
          content,
          style: TextStyle(
            color: AppStyle.whiteTextColor, // Error Dialog Description Color
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}

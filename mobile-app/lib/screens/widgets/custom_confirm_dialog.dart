import 'package:flutter/material.dart';

class CustomConfirmDialog {
  late BuildContext context;

  show(BuildContext context, void Function()? onPressed) {
    // set up the buttons
    Widget okButton = ElevatedButton(
      child: const Text("Ok"),
      onPressed: onPressed,
    );
    Widget cancelButton = ElevatedButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop(); // dismiss dialog
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Notice"),
      content: const Text(
          "Launching this missile will destroy the entire universe. Is this what you intended to do?"),
      actions: [
        cancelButton,
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  dismiss() {
    Navigator.of(context).pop();
  }
}

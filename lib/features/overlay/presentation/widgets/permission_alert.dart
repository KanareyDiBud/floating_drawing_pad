import 'package:flutter/material.dart';

Future<void> showPermissionAlert(BuildContext context, VoidCallback onRequestPermission) async {
  return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Overlay permission'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('To ensure the normal functioning of the "Overlay Drawing Board" floating window feature, please enable the "Display over other apps" permission.'),
                Text('You can disable or manage this permission in system settings at any time.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Back')
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  onRequestPermission();
                },
                child: Text('To Settings')
            ),
          ],
        );
      }
  );
}
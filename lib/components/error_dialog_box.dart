import 'package:flutter/material.dart';

Future<dynamic> dialogBox(context, String e) async {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      icon: const Icon(
        Icons.error,
        color: Colors.red,
      ),
      title: const Text("Error"),
      content: Text(
        e,
        textAlign: TextAlign.center,
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: const Text(
            'Okay',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ],
    ),
  );
}

///this will display a dialog box whenever logout button is clicked
void showDialogOnLogout(BuildContext context,
    {required String content,
    required Function onPressCallBack,
    required String title,
    required buttonText}) async {
  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      icon: const Icon(Icons.error),
      iconColor: Colors.red,
      title: Text(title),
      content: Text(
        content,
        textAlign: TextAlign.center,
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: const Text(
            'cancel',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            onPressCallBack();
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: const BorderSide(
                color: Color(0xff3B82F6),
              ),
            ),
          ),
          child: Text(
            buttonText,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
        ),
      ],
    ),
  );
}

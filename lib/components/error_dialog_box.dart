import 'package:flutter/material.dart';

Future<dynamic> dialogBox(context, e) async {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      icon: const Icon(
        Icons.error,
        color: Colors.red,
      ),
      title: const Text("Error"),
      content: Text(
        e.toString(),
        textAlign: TextAlign.center,
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(
                      color: Theme.of(context).colorScheme.primary))),
          child: const Text(
            'Okay',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
        )
      ],
    ),
  );
}

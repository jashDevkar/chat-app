import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final Map<String, dynamic> data;

  final void Function() onTapCallBack;
  const UserTile({super.key, required this.data, required this.onTapCallBack});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapCallBack,
      child: Card(
        color: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
          child: Row(
            children: [
              ///icon
              Icon(
                Icons.person,
                color: Theme.of(context).colorScheme.primary,
              ),

              const SizedBox(
                width: 10.0,
              ),

              ///email
              Text(data['email'])
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String email;
  final void Function() onTapCallBack;
  const UserTile({super.key, required this.email, required this.onTapCallBack});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapCallBack,
      child: Container(
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Theme.of(context).colorScheme.tertiary,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        child: Row(
          children: [
            ///icon
            const Icon(Icons.person),

            SizedBox(
              width: 10.0,
            ),

            ///email
            Text(email)
          ],
        ),
      ),
    );
  }
}

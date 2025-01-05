import 'package:chat_app/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserTile extends StatelessWidget {
  final Map<String, dynamic> data;

  final void Function() onTapCallBack;
  const UserTile({super.key, required this.data, required this.onTapCallBack});

  @override
  Widget build(BuildContext context) {
    bool isDark = Provider.of<ThemeProvider>(context).isDarkMode;

    return GestureDetector(
      onTap: onTapCallBack,
      child: Card(
        color: Theme.of(context).cardColor,
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 25, bottom: 25),
          child: Row(
            children: [
              ///icon
              Icon(Icons.person,
                  color: isDark
                      ? Colors.white
                      : Theme.of(context).colorScheme.primary),

              const SizedBox(
                width: 10.0,
              ),

              ///email
              Text(
                data['email'],
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

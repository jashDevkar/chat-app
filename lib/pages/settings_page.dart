import 'package:chat_app/pages/blocked_user_page.dart';
import 'package:chat_app/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        children: [
          //mode toggle
          Card(
            margin: const EdgeInsets.only(left: 25, right: 25),
            elevation: 4.0,
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Theme.of(context).cardColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Dark mode'),
                  Switch(
                      activeColor: Colors.blue,
                      value: Provider.of<ThemeProvider>(context).isDarkMode,
                      onChanged: (val) {
                        Provider.of<ThemeProvider>(context, listen: false)
                            .toggleMode();
                      })
                ],
              ),
            ),
          ),

          // blocked users
          Card(
            margin: const EdgeInsets.only(left: 25, right: 25, top: 10),
            elevation: 4.0,
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Theme.of(context).cardColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Blocked Users'),
                  IconButton(
                      onPressed: () => Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: BlockedUserPage(),
                            ),
                          ),
                      icon: const Icon(Icons.arrow_forward))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

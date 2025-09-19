import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("settings".tr())),
      body: ListView(
        children: [
          ListTile(
            title: Text("language".tr()),
            trailing: const Icon(Icons.language),
            onTap: () {
              if (context.locale == const Locale('en')) {
                context.setLocale(const Locale('ar'));
              } else {
                context.setLocale(const Locale('en'));
              }
            },
          ),
        ],
      ),
    );
  }
}

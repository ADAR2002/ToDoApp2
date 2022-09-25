import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_app/db/db_helper.dart';
import 'services/notification_services.dart';
import 'services/theme_services.dart';
import 'ui/pages/home_page.dart';

import 'ui/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DBHelper.initDB();
  NotifyHelper().initializeNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Themes.lightMode,
      darkTheme: Themes.darkMode,
      themeMode: ThemeServices().theme,
      home: const HomePage(),
    );
  }
}

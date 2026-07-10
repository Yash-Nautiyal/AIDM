import 'package:aidm/feature/home/presentation/pages/home_page.dart';
import 'package:aidm/feature/recordings/presentation/pages/recordings_page.dart';
import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'core/utils/app_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AppScreenScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AIDM',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const RecordingsPage(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'providers/todo_provider.dart';
import 'providers/theme_provider.dart';
import 'screens/home_screen.dart';
import 'services/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await HiveService().init(); // Initialize Hive
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => TodoProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return AnimatedTheme(
      data: themeProvider.themeData,
      duration: Duration(milliseconds: 300),
      child: MaterialApp(
        title: 'To-Do',
        theme: themeProvider.themeData,
        home: HomeScreen(),
      ),
    );
  }
}
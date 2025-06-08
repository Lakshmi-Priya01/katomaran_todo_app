import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart'; // ✅ Needed for MultiProvider
import 'providers/task_provider.dart';   // ✅ Your TaskProvider file
import 'screens/login_screen.dart';
import 'screens/task_edit_screen.dart';
import 'screens/home_screen.dart';
// Make sure this file exists

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Must initialize Firebase before runApp
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => TaskProvider()),
    ],
    child: const MyApp(),
  ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Katomaran Todo App',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const LoginScreen(),
      routes: {
        '/home': (_) => const HomeScreen(),
        '/add': (_) => const TaskEditScreen(),
      },
    );
  }
}


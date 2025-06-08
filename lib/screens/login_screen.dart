import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = AuthService();

    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final user = await auth.signInWithGoogle();
            print('User signed in: ${user?.email}');

            if (user != null) {
              // ✅ Go to HomeScreen if login is successful
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const HomeScreen()),
              );
            } else {
              // Optional: Show message if login failed
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Login failed")),
              );
            }
          },
          child: const Text('Sign in with Google'),
        ),
      ),
    );
  }
}

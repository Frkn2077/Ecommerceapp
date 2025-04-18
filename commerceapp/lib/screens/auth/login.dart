import 'package:flutter/material.dart';
import 'package:commerceapp/services/auth_service.dart';
import 'package:commerceapp/screens/home_screen.dart';

class LoginScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final authService = AuthService();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Giriş Yap")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'E-mail'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Şifre'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () async {
                final user = await authService.signInWithEmailAndPassword(
                  emailController.text,
                  passwordController.text,
                );
                if (user != null) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const HomeScreen()),
                  );
                }
              },
              child: const Text("Giriş Yap"),
            ),
            TextButton(
              child: const Text("Kayıt Ol"),
              onPressed: () {
                Navigator.pushNamed(context, "/register");
              },
            ),
          ],
        ),
      ),
    );
  }
}

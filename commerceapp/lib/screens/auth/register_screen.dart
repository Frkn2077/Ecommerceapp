import 'package:flutter/material.dart';
import 'package:commerceapp/services/auth_service.dart';

class RegisterScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final authService = AuthService();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kayıt Ol")),
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
                final user = await authService.registerWithEmailAndPassword(
                  emailController.text,
                  passwordController.text,
                );
                if (user != null) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text("Kayıt başarılı!")));
                  Navigator.pop(context);
                }
              },
              child: const Text("Kayıt Ol"),
            ),
          ],
        ),
      ),
    );
  }
}

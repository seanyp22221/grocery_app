import 'package:flutter/material.dart';
import 'package:grocery_app/screens/grocery_screen.dart';
import 'package:grocery_app/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  final AuthService auth;
  const LoginScreen({required this.auth, super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLogin = true;

  @override
  void initState() {
    super.initState();

    // 🔄 Automatically redirect if already logged in
    final user = widget.auth.currentUser;
    if (user != null) {
      Future.microtask(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const GroceryScreen()),
        );
      });
    }
  }

  void handleSubmit() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (isLogin) {
      final user = await widget.auth.login(email, password);
      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const GroceryScreen()),
        );
      } else {
        showError('Login failed');
      }
    } else {
      final user = await widget.auth.register(email, password);
      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const GroceryScreen()),
        );
      } else {
        showError('Registration failed');
      }
    }
  }

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    // No need to check current user here anymore
    return Scaffold(
      appBar: AppBar(title: const Text('Grocery App')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password"),
            ),
            ElevatedButton(
              onPressed: handleSubmit,
              child: Text(isLogin ? 'Login' : 'Register'),
            ),
            TextButton(
              onPressed: () => setState(() => isLogin = !isLogin),
              child: Text(isLogin ? 'Need an account?' : 'Have an account?'),
            ),
          ],
        ),
      ),
    );
  }
}
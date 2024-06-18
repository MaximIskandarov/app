import 'package:flutter/material.dart';
import '../firebase_service.dart'; // Обновленный путь для firebase_service
import '../widgets/auth_form.dart'; // Обновленный путь для формы аутентификации
import 'user_info_screen.dart'; // Обновленный путь для экрана информации о пользователе
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Добавьте этот импорт
import '../firebase_service.dart';


class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = false;
  final FirebaseService firebaseService = FirebaseService();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _onAuthSuccess(User user) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => UserInfoScreen(user: user),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final onAuth = isLogin
        ? () async {
      User? user = await firebaseService.onLogin(
        email: emailController.text,
        password: passwordController.text,
      );
      if (user != null) {
        _onAuthSuccess(user);
      }
    }
        : () async {
      User? user = await firebaseService.onRegister(
        email: emailController.text,
        password: passwordController.text,
      );
      if (user != null) {
        _onAuthSuccess(user);
      }
    };
    final buttonText = isLogin ? 'Login' : 'Register';

    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase $buttonText'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            AuthForm(
              authButtonText: buttonText,
              onAuth: onAuth,
              emailController: emailController,
              passwordController: passwordController,
            ),
            TextButton(
              child: Text(isLogin ? 'Switch to Register' : 'Switch to Login'),
              onPressed: () {
                setState(() {
                  isLogin = !isLogin;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

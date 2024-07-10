import 'package:chatter/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:chatter/components/my_textfield.dart';
import 'package:chatter/components/my_button.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final void Function() onTap;

  LoginPage({
    super.key,
    required this.onTap
  });

  void login(BuildContext context) async {
    final authService = AuthService();

    try {
      await authService.signInWithEmailPassword(_emailController.text, _passwordController.text);
    }

    catch (e) {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString(),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.message, size: 60,
            color: Theme.of(context).colorScheme.primary),

            const SizedBox(height: 50),
            
            Text(
              "Welcome back, you've been missed",
              style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 16
              ),
            ),

            const SizedBox(height: 25),

            MyTextField(
              hintText: "example@email.com",
              obscureText: false,
              controller: _emailController,
            ),

            const SizedBox(height: 10),

            MyTextField(
              hintText: "Your password",
              obscureText: true,
              controller: _passwordController,
            ),

            const SizedBox(height: 25),


            MyButton(
              text: "Login",
              onTap: () => login(context),
            ),

            const SizedBox(height: 25),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Not a member yet?",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
                ),

                const SizedBox(height: 5),

                GestureDetector(
                  onTap: onTap,
                  child: const Text(
                    "Register now",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      )
    );
  }
}
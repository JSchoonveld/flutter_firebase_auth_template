import 'package:chatter/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:chatter/components/my_textfield.dart';
import 'package:chatter/components/my_button.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  void Function()? onTap;

  RegisterPage({
    super.key,
    required this.onTap
  });

  void register(BuildContext context) {
    final authService = AuthService();

    if (_passwordController.text == _confirmPasswordController.text) {
      try {
        authService.signUpWithEmailAndPassword(
            _emailController.text, _passwordController.text
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) =>
              AlertDialog(
                title: Text(e.toString(),
                ),
              ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) =>
            const AlertDialog(
              title: Text("Passwords don't match"),
            ),
      );
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
              "Let's create an account for you!",
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

            const SizedBox(height: 10),

            MyTextField(
              hintText: "Confirm password",
              obscureText: true,
              controller: _confirmPasswordController,
            ),

            const SizedBox(height: 25),


            MyButton(
              text: "Register",
              onTap: () => register(context),
            ),

            const SizedBox(height: 25),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already a member?",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
                ),

                const SizedBox(height: 5),

                GestureDetector(
                  onTap: onTap,
                  child: const Text(
                    "Login now",
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
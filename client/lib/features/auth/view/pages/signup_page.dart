import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:music_app/core/theme/app_pallete.dart';
import 'package:music_app/core/widgets/custom_field.dart';
import 'package:music_app/features/auth/repositories/auth_remote_repository.dart';
import 'package:music_app/features/auth/view/pages/login_page.dart';
import 'package:music_app/features/auth/view/widgets/auth_gradient_button.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Sign Up.',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  CustomField(hintText: 'Name', controller: nameController),
                  const SizedBox(height: 15),
                  CustomField(hintText: 'Email', controller: emailController),
                  const SizedBox(height: 15),
                  CustomField(
                    hintText: 'Password',
                    controller: passwordController,
                    isObscureText: true,
                  ),
                  const SizedBox(height: 20),
                  AuthGradientButton(
                    buttonText: 'Sign up',
                    onTap: () async {
                      // if (formKey.currentState.validate()) {
                      // Call the API to register
                      final res = await AuthRemoteRepository().signup(
                        name: nameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                      );
                      final val = switch (res) {
                        Left(value: final l) => l,
                        Right(value: final r) => r.toString(),
                      };
                      print(val);
                      // }
                    },
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                    child: RichText(
                      text: TextSpan(
                        text: 'Already have an account? ',
                        style: Theme.of(context).textTheme.titleMedium,
                        children: const [
                          TextSpan(
                            text: 'Sign In',
                            style: TextStyle(
                              color: Pallete.gradient3,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

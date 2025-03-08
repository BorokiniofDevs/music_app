import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/core/theme/app_pallete.dart';
import 'package:music_app/core/utils.dart';
import 'package:music_app/core/widgets/custom_field.dart';
import 'package:music_app/core/widgets/loader.dart';
import 'package:music_app/features/auth/view/pages/signup_page.dart';
import 'package:music_app/features/auth/view/widgets/auth_gradient_button.dart';
import 'package:music_app/features/auth/view_model/auth_view_model.dart';
import 'package:music_app/features/home/view/page/home__page.dart';
import 'package:music_app/features/home/view/page/upload_song_page.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(
      authViewModelProvider.select((val) => val?.isLoading == true),
    );

    ref.listen(authViewModelProvider, (_, next) {
      next?.when(
        loading: () {},
        data: (data) {
          showSnackbar(context, 'User logged in successfully!');
          // TODO: Navigate to the home page
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const UploadSongPage()),
            (_) => false,
          );
        },
        error: (error, st) {
          showSnackbar(context, error.toString());
        },
      );
    });
    return Scaffold(
      appBar: AppBar(),
      body:
          isLoading
              ? const Loader()
              : Padding(
                padding: const EdgeInsets.all(15.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Sign In.',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 30),
                          CustomField(
                            hintText: 'Email',
                            controller: emailController,
                          ),
                          const SizedBox(height: 15),
                          CustomField(
                            hintText: 'Password',
                            controller: passwordController,
                            isObscureText: true,
                          ),
                          const SizedBox(height: 20),
                          AuthGradientButton(
                            buttonText: 'Sign in',
                            onTap: () async {
                              if (formKey.currentState!.validate()) {
                                // Call the API to login
                                ref
                                    .read(authViewModelProvider.notifier)
                                    .loginUser(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                              }
                            },
                          ),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignupPage(),
                                ),
                              );
                            },
                            child: RichText(
                              text: TextSpan(
                                text: 'Don\'t have an account? ',
                                style: Theme.of(context).textTheme.titleMedium,
                                children: const [
                                  TextSpan(
                                    text: 'Sign Up',
                                    style: TextStyle(
                                      color: Pallete.gradient2,
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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/core/provider/current_user_notifier.dart';
import 'package:music_app/core/theme/theme.dart';
import 'package:music_app/features/auth/view/pages/signup_page.dart';
import 'package:music_app/features/auth/view_model/auth_view_model.dart';
import 'package:music_app/features/home/view/page/home__page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final container = ProviderContainer();
  await container.read(authViewModelProvider.notifier).initSharedPreferences();
  await container.read(authViewModelProvider.notifier).getData();
  // final userModel =
  //     await container.read(authViewModelProvider.notifier).getData();
  // print(userModel);

  runApp(UncontrolledProviderScope(container: container, child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserNotifierProvider);
    return MaterialApp(
      title: 'Music_App',
      theme: AppTheme.darkThemeMode,
      home: currentUser == null ? const SignupPage() : const HomePage(),
    );
  }
}

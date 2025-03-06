import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/core/provider/current_user_notifier.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserNotifierProvider);
    print(user);
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text('Welcome to the home page! ${user?.name}')),
    );
  }
}

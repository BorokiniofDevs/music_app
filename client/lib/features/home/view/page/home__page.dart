import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/core/provider/current_user_notifier.dart';
import 'package:music_app/core/theme/app_pallete.dart';
import 'package:music_app/features/home/view/page/library_page.dart';
import 'package:music_app/features/home/view/page/songs_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int selectedIndex = 0;

  final pages = const [SongsPage(), LibraryPage()];

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserNotifierProvider);
    print(user);
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              selectedIndex == 0
                  ? 'assets/images/home_filled.png'
                  : 'assets/images/home_unfilled.png',
              color:
                  selectedIndex == 0
                      ? Pallete.whiteColor
                      : Pallete.inactiveBottomBarItemColor,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/library.png',
              color:
                  selectedIndex == 1
                      ? Pallete.whiteColor
                      : Pallete.inactiveBottomBarItemColor,
            ),
            label: 'Library',
          ),
        ],
      ),
    );
  }
}

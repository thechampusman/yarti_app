import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yatri_cabs/screens/AccountScreen.dart';
import 'package:yatri_cabs/screens/MoreScreen.dart';
import 'package:yatri_cabs/screens/TripScreen.dart';

import 'HomeScreen.dart';

// Define the selectedIndexProvider in this file where navigation state is handled
final selectedIndexProvider = StateProvider<int>((ref) => 0);

class Bottomnavbar extends ConsumerWidget {
  final List<Widget> _screens = [
    HomeScreen(),
    Tripscreen(),
    Accountscreen(),
    Morescreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex =
        ref.watch(selectedIndexProvider); // Watch navigation state

    return Scaffold(
      body: _screens[selectedIndex], // Show the selected screen
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.green,
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.green,
          currentIndex: selectedIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.white,
          onTap: (index) {
            ref.read(selectedIndexProvider.notifier).state =
                index; // Update state on tap
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.directions_car),
              label: 'My Trip',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Account',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.more_horiz),
              label: 'More+',
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yatri_cabs/screens/BottomNavBar.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Yatri Cabs',
        theme: ThemeData(
          bottomNavigationBarTheme:
              BottomNavigationBarThemeData(backgroundColor: Colors.green),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
          useMaterial3: false,
        ),
        home: Bottomnavbar());
  }
}

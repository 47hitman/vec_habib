import 'package:flutter/material.dart';

import 'screens/spalshScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'vec_habib',
      theme: ThemeData(
        primaryColor: const Color(0xFF13AAD4),
        appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF13AAD4)),
      ),
      initialRoute: SplashScreen.id,
      routes: {
        // MenuScreen.id: (context) => const MenuScreen(),
        // HomeScreens.id: (context) => const HomeScreens(),
        SplashScreen.id: (context) => const SplashScreen(),
      },
    );
  }
}

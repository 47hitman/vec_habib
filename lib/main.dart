import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vec_habib/token_porvider.dart';

import 'screens/spalshScreen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TokenProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'vec_habib',
      // theme: ThemeData(
      //   primaryColor: const Color(0xFF13AAD4),
      //   appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF13AAD4)),
      // ),
      initialRoute: SplashScreen.id,
      routes: {
        // MenuScreen.id: (context) => const MenuScreen(),
        // HomeScreens.id: (context) => const HomeScreens(),
        SplashScreen.id: (context) => const SplashScreen(),
      },
    );
  }
}

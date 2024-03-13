import 'package:flutter/material.dart';
import 'views/home_view.dart';
import 'views/login_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App',
      initialRoute: '/login',
      routes: {
        '/': (BuildContext context) => const HomeView(),
        '/login': (BuildContext context) => const LoginView(),
      },
    );
  }
}

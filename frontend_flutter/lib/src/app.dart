import 'package:flutter/material.dart';
import 'dashboard_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Web Expense App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DashboardPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

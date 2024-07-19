import 'package:flutter/material.dart';
import 'package:trofeo/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.lightGreen,
          tabBarTheme: TabBarTheme(
            labelColor: Colors.white,
            indicatorColor: Colors.grey[300],
            unselectedLabelColor: Colors.grey,
            indicator: BoxDecoration(color: Colors.green[100]),
          )),
      home: CustomerListScreen(),
    );
  }
}

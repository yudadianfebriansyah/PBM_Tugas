import 'package:flutter/material.dart';
import 'list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant APP',
      theme: ThemeData(
       primarySwatch: Colors.blue,
      ),
      home: const Restaurant(),
      debugShowCheckedModeBanner: false,
    );
  }
}

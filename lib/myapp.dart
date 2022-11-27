import 'package:flutter/material.dart';

import 'UI/screens/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Library Package Assignment',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Library Package Assignment'),
      debugShowCheckedModeBanner: false,
    );
  }
}
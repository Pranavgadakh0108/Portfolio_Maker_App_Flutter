import 'package:flutter/material.dart';
import 'package:portfolio_creator/ui/myhome_page.dart';
//import 'package:portfolio_creator/ui/profile_page.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}
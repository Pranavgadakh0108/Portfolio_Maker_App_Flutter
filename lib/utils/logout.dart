import 'package:flutter/material.dart';
import 'package:portfolio_creator/ui/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void logout(BuildContext context) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  sharedPreferences.remove('email');
  ScaffoldMessenger.of(
    context,
  ).showSnackBar(SnackBar(content: Text('You are Logged Out..!!')));
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => LoginPage()),
  );
}

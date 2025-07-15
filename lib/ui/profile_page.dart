// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:portfolio_creator/ui/login_page.dart';
import 'package:portfolio_creator/ui/page1.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    void logout() async{
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

      sharedPreferences.remove('email');
       ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('You are Logged Out..!!')));
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
      
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(
          'Portfolio Maker',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        
        centerTitle: true,
        elevation: 3,
        actions: [
          IconButton(
            onPressed: logout,
            icon: Icon(Icons.logout_outlined, size: 25, color: Colors.white),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PersonalDetails()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple.shade600,
                foregroundColor: Colors.white,
              ),
              child: Text("Make Portfolio"),
            ),
          ],
        ),
      ),
    );
  }
}

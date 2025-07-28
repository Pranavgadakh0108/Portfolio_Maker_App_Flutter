// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import 'package:portfolio_creator/ui/page1.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
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
    );
  }
}

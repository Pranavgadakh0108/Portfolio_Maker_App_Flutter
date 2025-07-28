// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class BuildSocialButton extends StatelessWidget {
  IconData icon;
  VoidCallback onPressed;
  BuildSocialButton({super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, size: 26),
      onPressed: onPressed,
      color: Colors.grey[700],
    );
  }
}

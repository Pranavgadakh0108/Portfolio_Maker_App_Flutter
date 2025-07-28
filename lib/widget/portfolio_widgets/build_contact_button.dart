// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class BuildContactButton extends StatelessWidget {
  IconData icon;
  VoidCallback onPressed;
  BuildContactButton({super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, size: 24),
      onPressed: onPressed,
      color: Colors.purple,
    );
  }
}

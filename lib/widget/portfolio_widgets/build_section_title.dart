// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class BuildSectionTitle extends StatelessWidget {
  String title;

  BuildSectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.purple,
      ),
    );
  }
}

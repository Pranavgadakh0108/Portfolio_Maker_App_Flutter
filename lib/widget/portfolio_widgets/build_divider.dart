import 'package:flutter/material.dart';

class BuildDivider extends StatelessWidget {
  const BuildDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(height: 15, thickness: 1, color: Colors.grey[300]);
  }
}

import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.items,
    required this.onChanged,
    required this.icon,
  });

  final String? labelText;
  final String? hintText;
  final IconData? icon;
  final List<DropdownMenuItem<dynamic>>? items;
  final void Function(dynamic)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      //padding: const EdgeInsets.all(16.0),
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.04,
        vertical: MediaQuery.of(context).size.height * 0.01,
      ),
      child: DropdownButtonFormField<dynamic>(
        dropdownColor: Colors.white,
        isExpanded: true,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          label: Text(labelText ?? ""),
          prefixIcon: Icon(icon),

          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black45),
            borderRadius: BorderRadius.circular(12),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black38),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.purple, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        items: items,
        onChanged: onChanged,
      ),
    );
  }
}

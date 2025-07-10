import 'package:flutter/material.dart';

class CustomPassword extends StatefulWidget {
  const CustomPassword({
    super.key,
    required this.controller,
    this.hintText,
    this.labelText,
    this.icon,
    this.onChanged,
    this.keyboardType,
    this.validator,
  });

  final TextEditingController controller;
  final String? hintText;
  final String? labelText;
  final IconData? icon;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  @override
  State<CustomPassword> createState() => _CustomPasswordState();
}

class _CustomPasswordState extends State<CustomPassword> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      //padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.04,
        vertical: MediaQuery.of(context).size.height * 0.012,
      ),
      child: TextFormField(
        obscureText: _obscureText,
        autocorrect: true,
        controller: widget.controller,
        cursorColor: Colors.blue,
        decoration: InputDecoration(
          // contentPadding: const EdgeInsets.symmetric(
          //   vertical: 16,
          //   horizontal: 12,
          // ),
          contentPadding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.02,
            horizontal: MediaQuery.of(context).size.width * 0.03,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
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
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: Colors.black26, fontSize: 14),
          labelText: widget.labelText,
          labelStyle: const TextStyle(color: Colors.black, fontSize: 16),
          prefixIcon: Icon(widget.icon),
          suffixIcon: IconButton(
            icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
        ),
        onChanged: widget.onChanged,
        keyboardType: widget.keyboardType,
        validator: widget.validator,
      ),
    );
  }
}

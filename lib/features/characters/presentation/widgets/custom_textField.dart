import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final bool divider;
  final bool filterIcon;
  const CustomTextField(
      {super.key,
      required this.labelText,
      required this.divider,
      required this.filterIcon});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xffF2F2F2),
        prefixIcon: const Icon(Icons.search),
        labelText: labelText,
        suffixIcon:const Icon(Icons.filter_alt_rounded),
        
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide:const BorderSide(color: Colors.transparent),
        ),
      ),
    );
  }
}

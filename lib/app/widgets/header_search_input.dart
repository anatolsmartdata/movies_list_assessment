import 'package:flutter/material.dart';

class HeaderSearchInput extends StatelessWidget {
  const HeaderSearchInput({
    super.key,
    this.hintText,
    this.onChanged,
    this.icon,
    this.controller,
  });

  final String? hintText;
  final Function(String)? onChanged;
  final IconData? icon;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        maxLines: 1,
        decoration: InputDecoration(
          isDense: true,
          prefixIconConstraints:BoxConstraints(
              minWidth: 23,
              maxHeight: 16),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(
                right: 10,
                left: 10),
            child: Icon(
              icon ?? Icons.search,
              color: Colors.black87,
            ),
          ),
          hintText: hintText ?? 'Search movies',
          hintStyle:TextStyle(
              color: Colors.black87,
              fontSize: 14),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none
          ),
          fillColor: Colors.white,
          filled: true,
          contentPadding: EdgeInsets.symmetric(vertical: 8),
        ),
      ),
    );
  }
}
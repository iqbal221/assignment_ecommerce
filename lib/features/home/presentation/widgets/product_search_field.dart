import 'package:flutter/material.dart';

class ProductSearchField extends StatelessWidget {
  const ProductSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search",
        prefixIcon: Icon(Icons.search, color: Colors.grey),
        fillColor: Colors.grey.withAlpha(30),
        filled: true,
        enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
      ),
    );
  }
}

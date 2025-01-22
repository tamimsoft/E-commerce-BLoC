
import 'package:flutter/material.dart';

class ProductSearchBar extends StatelessWidget {
  const ProductSearchBar({
    super.key
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SearchBar(

        padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 8.0)),
        elevation: const WidgetStatePropertyAll(0),
        leading: const Icon(Icons.search),
        hintText: 'Search',
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      ),
    );
  }
}
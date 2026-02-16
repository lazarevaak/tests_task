import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const SearchField({required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        labelText: 'Search',
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(),
      ),
      onChanged: onChanged,
    );
  }
}

import 'package:flutter/material.dart';

class DetailsHeader extends StatelessWidget {
  final String name;

  const DetailsHeader({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

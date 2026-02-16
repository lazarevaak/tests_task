import 'package:flutter/material.dart';

class DetailsInfo extends StatelessWidget {
  final String category;
  final String date;
  final bool isIncome;

  const DetailsInfo({
    super.key,
    required this.category,
    required this.date,
    required this.isIncome,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Category: $category'),
        const SizedBox(height: 8),
        Text('Date: $date'),
        const SizedBox(height: 8),
        Text(isIncome ? 'Type: Income' : 'Type: Loss'),
      ],
    );
  }
}

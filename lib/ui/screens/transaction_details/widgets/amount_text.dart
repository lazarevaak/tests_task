import 'package:flutter/material.dart';

class AmountText extends StatelessWidget {
  final double amount;
  final bool isIncome;

  const AmountText({
    super.key,
    required this.amount,
    required this.isIncome,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'Amount: ${isIncome ? '+' : '-'}${amount.toStringAsFixed(2)}',
      style: TextStyle(
        color: isIncome ? Colors.green : Colors.red,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

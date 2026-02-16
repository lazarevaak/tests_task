import 'package:flutter/material.dart';

class BalanceCard extends StatelessWidget {
  final double balance;

  const BalanceCard({required this.balance});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Text(
              'Balance',
              style: TextStyle(fontSize: 18),
            ),
            const Spacer(),
            Text(
              balance.toStringAsFixed(2),
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: balance >= 0 ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

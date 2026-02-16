import 'package:flutter/material.dart';
import 'package:tests_task/domain/entities/transaction.dart';
import '../../transaction_details/transaction_details_screen.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionsList({
    super.key,
    required this.transactions,
  });

  @override
  Widget build(BuildContext context) {
    if (transactions.isEmpty) {
      return const Center(
        child: Text('No transactions'),
      );
    }

    return ListView.separated(
      itemCount: transactions.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final item = transactions[index];
        final dateText =
            item.date.toLocal().toString().split(' ').first;

        return ListTile(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  TransactionDetailsScreen(item: item),
            ),
          ),
          title: Text(item.name),
          subtitle: Text(
            '${item.category} • $dateText',
          ),
          trailing: Text(
            (item.isIncome ? '+' : '-') +
                item.amount.toStringAsFixed(2),
            style: TextStyle(
              color:
                  item.isIncome ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }
}

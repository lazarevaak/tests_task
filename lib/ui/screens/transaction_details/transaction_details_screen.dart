import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tests_task/domain/entities/transaction.dart';
import 'transaction_details_cubit.dart';
import 'transaction_details_state.dart';
import 'widgets/amount_text.dart';
import 'widgets/details_header.dart';
import 'widgets/details_info.dart';

class TransactionDetailsScreen extends StatelessWidget {
  final Transaction item;

  const TransactionDetailsScreen({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          TransactionDetailsBloc(TransactionDetailsState(item)),
      child: const _TransactionDetailsView(),
    );
  }
}

class _TransactionDetailsView extends StatelessWidget {
  const _TransactionDetailsView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionDetailsBloc, TransactionDetailsState>(
      builder: (_, state) {
        final t = state.transaction;
        final dateText =
            t.date.toLocal().toString().split(' ').first;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Transaction Details'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DetailsHeader(name: t.name),
                    const SizedBox(height: 8),
                    DetailsInfo(
                      category: t.category,
                      date: dateText,
                      isIncome: t.isIncome,
                    ),
                    const SizedBox(height: 8),
                    AmountText(
                      amount: t.amount,
                      isIncome: t.isIncome,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

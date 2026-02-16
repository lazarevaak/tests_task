import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tests_task/domain/entities/transaction.dart';

import 'main_cubit.dart';
import 'main_state.dart';

import '../add_transaction/add_transaction_screen.dart';

import 'widgets/transactions_list.dart';
import 'widgets/balance_card.dart';
import 'widgets/search_field.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        final bloc = context.read<MainCubit>();

        return Scaffold(
          appBar: AppBar(
            title: const Text('Money Tracker'),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              final result = await Navigator.push<Transaction>(
                context,
                MaterialPageRoute(
                  builder: (_) => const AddTransactionScreen(),
                ),
              );

              if (result != null) {
                bloc.addTransaction(result);
              }
            },
            child: const Icon(Icons.add),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                BalanceCard(balance: state.balance),
                const SizedBox(height: 12),

                SearchField(onChanged: bloc.changeQuery),
                const SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(
                      child: ChoiceChip(
                        label: const Text('All'),
                        selected: state.filter == FilterType.all,
                        onSelected: (_) =>
                            bloc.changeFilter(FilterType.all),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ChoiceChip(
                        label: const Text('Income'),
                        selected: state.filter == FilterType.income,
                        onSelected: (_) =>
                            bloc.changeFilter(FilterType.income),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ChoiceChip(
                        label: const Text('Losses'),
                        selected: state.filter == FilterType.losses,
                        onSelected: (_) =>
                            bloc.changeFilter(FilterType.losses),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                Expanded(
                  child: TransactionsList(
                    transactions: state.filtered,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}


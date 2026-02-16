import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'add_transaction_cubit.dart';
import 'add_transaction_state.dart';
import 'widgets/transaction_type_picker.dart';

class AddTransactionScreen extends StatelessWidget {
  const AddTransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddTransactionBloc(),
      child: const _AddTransactionView(),
    );
  }
}

class _AddTransactionView extends StatelessWidget {
  const _AddTransactionView();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AddTransactionBloc>();
    final formKey = GlobalKey<FormState>();

    return BlocBuilder<AddTransactionBloc, AddTransactionState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Add Transaction'),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.stretch,
                    children: [

                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Name',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: bloc.changeName,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Category',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: bloc.changeCategory,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      TextFormField(
                        keyboardType:
                            const TextInputType
                                .numberWithOptions(
                                    decimal: true),
                        decoration:
                            const InputDecoration(
                          labelText: 'Amount',
                          border:
                              OutlineInputBorder(),
                        ),
                        onChanged: bloc.changeAmount,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty) {
                            return 'Required';
                          }

                          final parsed =
                              double.tryParse(
                                  value);

                          if (parsed == null ||
                              parsed <= 0) {
                            return 'Invalid amount';
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      TransactionTypePicker(
                        isIncome: state.isIncome,
                        onChanged: bloc.changeType,
                      ),

                      const SizedBox(height: 16),

                      OutlinedButton(
                        onPressed: () async {
                          final picked =
                              await showDatePicker(
                            context: context,
                            initialDate:
                                state.date,
                            firstDate:
                                DateTime(2000),
                            lastDate:
                                DateTime(2100),
                          );

                          if (picked != null) {
                            bloc.changeDate(
                                picked);
                          }
                        },
                        child: Text(
                          state.date
                              .toLocal()
                              .toString()
                              .split(' ')
                              .first,
                        ),
                      ),

                      const SizedBox(height: 24),

                      ElevatedButton(
                        onPressed: () {
                          if (formKey
                              .currentState!
                              .validate()) {

                            final entity =
                                state.toEntity();

                            if (entity != null) {
                              Navigator.pop(
                                  context,
                                  entity);
                            }
                          }
                        },
                        child: const Text('Add'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

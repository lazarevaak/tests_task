import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'core/provider.dart';
import 'ui/screens/main/main_cubit.dart';
import 'ui/screens/main/main_screen.dart';
import 'package:tests_task/domain/repositories/transactions_repository.dart';

void main() {
  runApp(const MoneyTrackerApp());
}

class MoneyTrackerApp extends StatelessWidget {
  const MoneyTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: AppProviders.providers,
      child: Builder(
        builder: (context) {
          return MaterialApp(
            title: 'Money Tracker',
            theme: ThemeData(
              colorScheme:
                  ColorScheme.fromSeed(seedColor: Colors.teal),
              useMaterial3: true,
            ),
            home: BlocProvider(
              create: (_) => MainCubit(
                context.read<TransactionsRepository>(),
              )..load(),
              child: const MainScreen(),
            ),
          );
        },
      ),
    );
  }
}

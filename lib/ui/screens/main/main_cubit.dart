import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tests_task/domain/entities/transaction.dart';
import 'package:tests_task/domain/repositories/transactions_repository.dart';
import 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  final TransactionsRepository repository;

  MainCubit(this.repository) : super(MainState.initial());

  Future<void> load() async {
    final data = await repository.getAll();
    emit(state.copyWith(transactions: data));
  }

  Future<void> addTransaction(Transaction tx) async {
    await repository.add(tx);

    final updated = await repository.getAll();

    emit(state.copyWith(transactions: updated));
  }

  void changeQuery(String query) {
    emit(state.copyWith(query: query));
  }

  void changeFilter(FilterType filter) {
    emit(state.copyWith(filter: filter));
  }
}

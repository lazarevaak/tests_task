import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tests_task/domain/entities/transaction.dart';
import 'package:tests_task/domain/repositories/transactions_repository.dart';
import 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  final TransactionsRepository repository;

  MainCubit(this.repository) : super(MainState.initial());

  /// Загружает данные из repository
  Future<void> load() async {
    final data = await repository.getAll();
    emit(state.copyWith(transactions: data));
  }

  /// Добавляет транзакцию и синхронизирует состояние
  Future<void> addTransaction(Transaction tx) async {
    await repository.add(tx);

    // 🔥 Перечитываем данные из repository
    final updated = await repository.getAll();

    emit(state.copyWith(transactions: updated));
  }

  /// Обновляет поисковый запрос
  void changeQuery(String query) {
    emit(state.copyWith(query: query));
  }

  /// Обновляет фильтр
  void changeFilter(FilterType filter) {
    emit(state.copyWith(filter: filter));
  }
}

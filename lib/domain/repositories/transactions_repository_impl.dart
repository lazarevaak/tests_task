import '../../domain/entities/transaction.dart';
import '../../domain/repositories/transactions_repository.dart';

import 'package:tests_task/data/dao/transactions_dao.dart';
import 'package:tests_task/data/dto/transaction_dto.dart';

class TransactionsRepositoryImpl implements TransactionsRepository {
  final TransactionsDao dao;

  TransactionsRepositoryImpl(this.dao);

  @override
  Future<List<Transaction>> getAll() async {
    final dtos = await dao.load();

    return dtos.map((dto) {
      return Transaction(
        name: dto.name,
        amount: dto.amount,
        isIncome: dto.isIncome,
        date: DateTime.parse(dto.date),
        category: dto.category,
      );
    }).toList();
  }

  @override
  Future<void> add(Transaction transaction) async {
    final current = await dao.load();

    final updated = [
      ...current,
      TransactionDto(
        name: transaction.name,
        amount: transaction.amount,
        isIncome: transaction.isIncome,
        date: transaction.date.toIso8601String(),
        category: transaction.category,
      ),
    ];

    await dao.save(updated);
  }

  @override
  Future<void> delete(Transaction transaction) async {
    final current = await dao.load();

    final updated = current.where((dto) {
      return !(dto.name == transaction.name &&
               dto.date == transaction.date.toIso8601String());
    }).toList();

    await dao.save(updated);
  }

  @override
  Future<void> update(Transaction transaction) async {
    final current = await dao.load();

    final updated = current.map((dto) {
      if (dto.name == transaction.name &&
          dto.date == transaction.date.toIso8601String()) {
        return TransactionDto(
          name: transaction.name,
          amount: transaction.amount,
          isIncome: transaction.isIncome,
          date: transaction.date.toIso8601String(),
          category: transaction.category,
        );
      }
      return dto;
    }).toList();

    await dao.save(updated);
  }
}

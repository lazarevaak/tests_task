import '../entities/transaction.dart';

abstract class TransactionsRepository {
  Future<List<Transaction>> getAll();
  Future<void> add(Transaction transaction);
  Future<void> delete(Transaction transaction);
  Future<void> update(Transaction transaction);
}
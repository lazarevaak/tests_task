import '../../domain/entities/transaction.dart';
import 'package:tests_task/data/dto/transaction_dto.dart';

class TransactionMapper {

  static Transaction toEntity(TransactionDto dto) {
    return Transaction(
      name: dto.name,
      amount: dto.amount,
      isIncome: dto.isIncome,
      date: DateTime.parse(dto.date),
      category: dto.category,
    );
  }

  static TransactionDto toDto(Transaction entity) {
    return TransactionDto(
      name: entity.name,
      amount: entity.amount,
      isIncome: entity.isIncome,
      date: entity.date.toIso8601String(),
      category: entity.category,
    );
  }
}

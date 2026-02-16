import 'package:flutter_test/flutter_test.dart';
import 'package:tests_task/ui/screens/main/main_cubit.dart';
import 'package:tests_task/domain/entities/transaction.dart';
import '../../../data/repositories/mock_transactions_repository.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late MainCubit bloc;
  late MockTransactionsRepository repository;

  final income = Transaction(
    name: 'Salary',
    category: 'Job',
    amount: 1000,
    isIncome: true,
    date: DateTime.now(),
  );

  final expense = Transaction(
    name: 'Coffee',
    category: 'Food',
    amount: 5,
    isIncome: false,
    date: DateTime.now(),
  );

  setUp(() {
    repository = MockTransactionsRepository();
    bloc = MainCubit(repository);
  });

  tearDown(() {
    bloc.close();
  });

  test('should search transactions by name', () async {
    when(() => repository.getAll())
        .thenAnswer((_) async => [income, expense]);

    await bloc.load();

    bloc.changeQuery('cof');

    expect(bloc.state.filtered.length, 1);
    expect(bloc.state.filtered.first.name, 'Coffee');
  });

  test('should search transactions by category', () async {
    when(() => repository.getAll())
        .thenAnswer((_) async => [income, expense]);

    await bloc.load();

    bloc.changeQuery('job');

    expect(bloc.state.filtered.length, 1);
    expect(bloc.state.filtered.first.category, 'Job');
  });

  test('should return empty list if no matches', () async {
    when(() => repository.getAll())
        .thenAnswer((_) async => [income, expense]);

    await bloc.load();

    bloc.changeQuery('car');

    expect(bloc.state.filtered.isEmpty, true);
  });
}

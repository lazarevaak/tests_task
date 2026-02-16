import 'package:flutter_test/flutter_test.dart';
import 'package:tests_task/ui/screens/main/main_cubit.dart';
import 'package:tests_task/ui/screens/main/main_state.dart';
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

  test('should filter income transactions', () async {
    when(() => repository.getAll())
        .thenAnswer((_) async => [income, expense]);

    await bloc.load();

    bloc.changeFilter(FilterType.income);

    expect(bloc.state.filtered.length, 1);
    expect(bloc.state.filtered.first.isIncome, true);
  });

  test('should filter expense transactions', () async {
    when(() => repository.getAll())
        .thenAnswer((_) async => [income, expense]);

    await bloc.load();

    bloc.changeFilter(FilterType.losses);

    expect(bloc.state.filtered.length, 1);
    expect(bloc.state.filtered.first.isIncome, false);
  });
}

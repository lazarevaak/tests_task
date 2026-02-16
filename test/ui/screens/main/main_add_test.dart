import 'package:flutter_test/flutter_test.dart';
import 'package:tests_task/ui/screens/main/main_cubit.dart';
import 'package:tests_task/domain/entities/transaction.dart';
import '../../../data/repositories/mock_transactions_repository.dart';
import 'package:mocktail/mocktail.dart';


void main() {
  late MainCubit bloc;
  late MockTransactionsRepository repository;

  setUp(() {
    repository = MockTransactionsRepository();
    bloc = MainCubit(repository);
  });

  tearDown(() {
    bloc.close();
  });

  test('should add transaction and update state', () async {
    final tx = Transaction(
      name: 'Coffee',
      category: 'Food',
      amount: 5,
      isIncome: false,
      date: DateTime.now(),
    );

    // mock поведение
    when(() => repository.add(tx))
        .thenAnswer((_) async {});
    when(() => repository.getAll())
        .thenAnswer((_) async => [tx]);

    await bloc.addTransaction(tx);

    verify(() => repository.add(tx)).called(1);

    expect(bloc.state.transactions.length, 1);
    expect(bloc.state.transactions.first.name, 'Coffee');
  });
}

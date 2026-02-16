import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../data/dao/transactions_dao.dart';
import 'package:tests_task/domain/repositories/transactions_repository_impl.dart';
import '../domain/repositories/transactions_repository.dart';

class AppProviders {
  static List<SingleChildWidget> providers = [
    Provider<TransactionsDao>(
      create: (_) => TransactionsDao(),
    ),
    ProxyProvider<TransactionsDao, TransactionsRepository>(
      update: (_, dao, __) =>
          TransactionsRepositoryImpl(dao),
    ),
  ];
}


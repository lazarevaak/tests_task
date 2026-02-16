import 'package:flutter_bloc/flutter_bloc.dart';
import 'add_transaction_state.dart';

class AddTransactionBloc extends Cubit<AddTransactionState> {
  AddTransactionBloc() : super(AddTransactionState.initial());

  void changeName(String value) =>
      emit(state.copyWith(name: value));

  void changeCategory(String value) =>
      emit(state.copyWith(category: value));

  void changeAmount(String value) =>
      emit(state.copyWith(amount: value));

  void changeDate(DateTime date) =>
      emit(state.copyWith(date: date));

  void changeType(bool isIncome) =>
      emit(state.copyWith(isIncome: isIncome));
}

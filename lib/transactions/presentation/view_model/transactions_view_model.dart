import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'transactions_event.dart';
part 'transactions_state.dart';

class TransactionsViewModel extends Bloc<TransactionsEvent, TransactionsState> {
  TransactionsViewModel() : super(const TransactionsState()) {
    on<TransactionsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

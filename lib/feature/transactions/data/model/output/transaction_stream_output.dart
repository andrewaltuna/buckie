// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:expense_tracker/common/enum/stream_operation.dart';

import 'package:expense_tracker/feature/transactions/data/model/entity/transaction.dart';

class TransactionStreamOutput extends Equatable {
  const TransactionStreamOutput({
    required this.operation,
    required this.newTransaction,
    required this.oldTransaction,
  });

  factory TransactionStreamOutput.insert(
    Transaction transaction,
  ) {
    return TransactionStreamOutput(
      operation: StreamOperation.insert,
      oldTransaction: null,
      newTransaction: transaction,
    );
  }

  factory TransactionStreamOutput.update(
    Transaction oldTransaction,
    Transaction newTransaction,
  ) {
    return TransactionStreamOutput(
      operation: StreamOperation.update,
      oldTransaction: oldTransaction,
      newTransaction: newTransaction,
    );
  }

  factory TransactionStreamOutput.delete(
    Transaction transaction,
  ) {
    return TransactionStreamOutput(
      operation: StreamOperation.delete,
      oldTransaction: transaction,
      newTransaction: null,
    );
  }

  final StreamOperation operation;
  final Transaction? newTransaction;
  final Transaction? oldTransaction;

  @override
  List<Object?> get props => [
        operation,
        newTransaction,
      ];
}

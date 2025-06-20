// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:expense_tracker/common/enum/stream_operation.dart';

import 'package:expense_tracker/feature/transactions/data/model/entity/transaction.dart';

class TransactionStreamOutput extends Equatable {
  const TransactionStreamOutput({
    required this.operation,
    required this.transaction,
  });

  factory TransactionStreamOutput.insert(
    Transaction transaction,
  ) {
    return TransactionStreamOutput(
      operation: StreamOperation.insert,
      transaction: transaction,
    );
  }

  factory TransactionStreamOutput.update(
    Transaction transaction,
  ) {
    return TransactionStreamOutput(
      operation: StreamOperation.update,
      transaction: transaction,
    );
  }

  factory TransactionStreamOutput.delete(
    Transaction transaction,
  ) {
    return TransactionStreamOutput(
      operation: StreamOperation.delete,
      transaction: transaction,
    );
  }

  final StreamOperation operation;
  final Transaction transaction;

  @override
  List<Object?> get props => [
        operation,
        transaction,
      ];
}

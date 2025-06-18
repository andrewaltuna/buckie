// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:expense_tracker/common/enum/stream_operation.dart';

import 'package:expense_tracker/feature/transactions/data/model/entity/transaction.dart';

class TransactionStreamOutput extends Equatable {
  const TransactionStreamOutput({
    required this.operation,
    this.deletedId,
    this.transaction,
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

  factory TransactionStreamOutput.delete(String id) {
    return TransactionStreamOutput(
      operation: StreamOperation.delete,
      deletedId: id,
    );
  }

  final StreamOperation operation;

  /// Id of the deleted transaction.
  final String? deletedId;

  /// Transaction object that was inserted or updated.
  final Transaction? transaction;

  @override
  List<Object?> get props => [
        operation,
        deletedId,
        transaction,
      ];
}

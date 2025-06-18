import 'package:expense_tracker/common/exception/custom_exception.dart';

sealed class TransactionException extends CustomException {
  const TransactionException({super.message});
}

class TransactionInvalidAmountException extends TransactionException {
  const TransactionInvalidAmountException({
    super.message = 'Invalid amount',
  });
}

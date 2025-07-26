import 'package:expense_tracker/common/exception/custom_exception.dart';

sealed class CategoriesException extends CustomException {
  const CategoriesException({super.message});
}

class CategoriesDuplicateException extends CategoriesException {
  const CategoriesDuplicateException({
    super.message = 'A category with this name already exists.',
  });
}

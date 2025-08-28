import 'package:expense_tracker/common/exception/custom_exception.dart';

sealed class CategoriesException extends CustomException {
  const CategoriesException({super.message});
}

class CategoriesEmptyNameException extends CategoriesException {
  const CategoriesEmptyNameException({
    super.message = 'Name is required',
  });
}

class CategoriesDuplicateException extends CategoriesException {
  const CategoriesDuplicateException({
    super.message = 'Category with name already exists',
  });
}

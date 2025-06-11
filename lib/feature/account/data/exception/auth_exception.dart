import 'package:expense_tracker/common/exception/custom_exception.dart';

sealed class AuthException extends CustomException {
  const AuthException({super.message});
}

class AuthDefaultException extends AuthException {
  const AuthDefaultException();
}

class AuthInvalidEmailException extends AuthException {
  const AuthInvalidEmailException({
    super.message = 'Invalid email address',
  });
}

class AuthPasswordMismatchException extends AuthException {
  const AuthPasswordMismatchException({
    super.message = 'Passwords do not match',
  });
}

class AuthWeakPasswordException extends AuthException {
  const AuthWeakPasswordException({
    super.message = 'Password is too weak',
  });
}

class AuthEmailAlreadyInUseException extends AuthException {
  const AuthEmailAlreadyInUseException({
    super.message = 'Email address already in use',
  });
}

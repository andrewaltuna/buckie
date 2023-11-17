sealed class RegistrationException implements Exception {
  const RegistrationException(String message);
}

class RegistrationInvalidEmailException extends RegistrationException {
  const RegistrationInvalidEmailException(String message) : super(message);
}

class RegistrationPasswordMismatchException extends RegistrationException {
  const RegistrationPasswordMismatchException(String message) : super(message);
}

class RegistrationWeakPasswordException extends RegistrationException {
  const RegistrationWeakPasswordException(String message) : super(message);
}

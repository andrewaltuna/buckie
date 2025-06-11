import 'package:equatable/equatable.dart';

class RegistrationExceptionOutput extends Equatable {
  const RegistrationExceptionOutput({
    this.emailException,
    this.passwordException,
  });

  final Exception? emailException;
  final Exception? passwordException;

  static const empty = RegistrationExceptionOutput();

  RegistrationExceptionOutput copyWith({
    Exception? emailException,
    Exception? passwordException,
  }) {
    return RegistrationExceptionOutput(
      emailException: emailException ?? this.emailException,
      passwordException: passwordException ?? this.passwordException,
    );
  }

  @override
  List<Object?> get props => [
        emailException,
        passwordException,
      ];
}

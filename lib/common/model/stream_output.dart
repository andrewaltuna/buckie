import 'package:equatable/equatable.dart';
import 'package:expense_tracker/common/enum/stream_operation.dart';

class StreamOutput<T> extends Equatable {
  const StreamOutput({
    required this.operation,
    required this.current,
    required this.previous,
  });

  factory StreamOutput.insert(
    T output,
  ) {
    return StreamOutput(
      operation: StreamOperation.insert,
      previous: null,
      current: output,
    );
  }

  factory StreamOutput.update(
    T previous,
    T current,
  ) {
    return StreamOutput(
      operation: StreamOperation.update,
      previous: previous,
      current: current,
    );
  }

  factory StreamOutput.delete(
    T output,
  ) {
    return StreamOutput(
      operation: StreamOperation.delete,
      previous: output,
      current: null,
    );
  }

  final StreamOperation operation;
  final T? current;
  final T? previous;

  @override
  List<Object?> get props => [
        operation,
        current,
        previous,
      ];
}

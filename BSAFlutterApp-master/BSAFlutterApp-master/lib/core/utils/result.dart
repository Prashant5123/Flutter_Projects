abstract class Result<T> {
  const Result();

  factory Result.success(T data) = Success<T>;
  factory Result.failure(Exception error) = Failure<T>;

  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is Failure<T>;

  T? get data => isSuccess ? (this as Success<T>).data : null;
  Exception? get error => isFailure ? (this as Failure<T>).error : null;

  void when({
    required void Function(T data) onSuccess,
    required void Function(Exception error) onFailure,
  }) {
    if (isSuccess) {
      onSuccess((this as Success<T>).data);
    } else {
      onFailure((this as Failure<T>).error);
    }
  }
}

class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);
}

class Failure<T> extends Result<T> {
  final Exception error;
  const Failure(this.error);
}

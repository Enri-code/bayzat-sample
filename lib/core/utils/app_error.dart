import 'dart:async';

import 'package:dartz/dartz.dart';

typedef ErrorOr<T> = FutureOr<Either<AppError, T>>;

class AppError {
  final String? errMessage;

  const AppError([this.errMessage]);
}

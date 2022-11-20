import 'package:bayzat_test/core/utils/app_error.dart';

/// Base interface for use cases, to ensure predictability
abstract class ApiUseCase<T> {
  const ApiUseCase();
  ErrorOr<T> call();
}

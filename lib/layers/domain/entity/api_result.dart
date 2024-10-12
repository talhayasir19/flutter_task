class ApiResult<T> {
  final T data;

  ApiResult(this.data);
}

class ApiError {
  final String message;
  ApiError({required this.message});
}

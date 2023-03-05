class RepoResult<T> {
  final bool success;
  final T result;

  RepoResult(this.success, this.result);
}

class RepoError {
  final String message;

  RepoError(this.message);
}

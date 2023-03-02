enum StatusTypeEnum {
  /// When the app is doing nothing
  idle,
  initial,
  loading,
  loadingMore,
  success,
  failure,
  finished,
  deleting,
  empty;

  bool isEqual(StatusTypeEnum compare) => compare == this;
}

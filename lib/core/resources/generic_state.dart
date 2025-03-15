class GenericState<T> {
  final String? failure;
  final bool? isSuccess;
  final bool? isLoading;
  final bool? isRefreshing;
  final T? data;

  GenericState({
    this.failure,
    this.isSuccess,
    this.isLoading,
    this.isRefreshing,
    this.data,
  });

  factory GenericState.initial() => GenericState();

  factory GenericState.loading() => GenericState(isLoading: true);

  factory GenericState.refreshing(T data) =>
      GenericState(isRefreshing: true, data: data);

  factory GenericState.success(T data) =>
      GenericState(isSuccess: true, data: data);

  factory GenericState.failure(String failure) =>
      GenericState(failure: failure);

  GenericState<T> copyWith({
    String? failure,
    bool? isSuccess,
    bool? isLoading,
    bool? isRefreshing,
    T? data,
  }) {
    return GenericState<T>(
      failure: failure ?? this.failure,
      isSuccess: isSuccess ?? this.isSuccess,
      isLoading: isLoading ?? this.isLoading,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      data: data ?? this.data,
    );
  }
}

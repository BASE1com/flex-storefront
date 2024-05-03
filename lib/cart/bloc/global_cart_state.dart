part of 'global_cart_bloc.dart';

final class GlobalCartState extends BlocState {
  final String anonymousCartGuid;
  final Cart? cart;

  GlobalCartState({
    required super.status,
    super.error,
    super.stackTrace,
    this.anonymousCartGuid = '',
    this.cart,
  });

  int get totalItems => cart?.totalItems ?? 0;

  GlobalCartState copyWith({
    Status? status,
    String? anonymousCartGuid,
    Cart? cart,
    Object? error,
    StackTrace? stackTrace,
  }) {
    return GlobalCartState(
      status: status ?? this.status,
      anonymousCartGuid: anonymousCartGuid ?? this.anonymousCartGuid,
      cart: cart ?? this.cart,
      error: error ?? this.error,
      stackTrace: stackTrace ?? this.stackTrace,
    );
  }

  @override
  String toString() {
    return 'GlobalCartState{status: $status, anonymousCartGuid: $anonymousCartGuid, cart: $cart}';
  }
}

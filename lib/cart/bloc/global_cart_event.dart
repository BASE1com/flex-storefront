part of 'global_cart_bloc.dart';

sealed class GlobalCartEvent {
  const GlobalCartEvent();
}

final class GlobalCartInitialize extends GlobalCartEvent {
  const GlobalCartInitialize();
}

final class GlobalCartRequested extends GlobalCartEvent {
  const GlobalCartRequested();
}

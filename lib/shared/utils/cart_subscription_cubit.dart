import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flex_storefront/cart/cart_repository.dart';
import 'package:flex_storefront/cart/models/cart.dart';
import 'package:flex_storefront/cart/models/cart_message.dart';
import 'package:get_it/get_it.dart';

abstract class CartSubscriptionCubit<T> extends Cubit<T> {
  late final StreamSubscription _cartStreamSubscription;
  late final StreamSubscription _cartMessageStreamSubscription;

  CartSubscriptionCubit(T initialState) : super(initialState) {
    _subscribe();
  }

  void _subscribe() {
    _cartStreamSubscription =
        GetIt.instance.get<CartRepository>().getCartStream().listen(
      (cart) {
        onCartData(cart);
      },
      onError: (err, stackTrace) {
        onCartError(err, stackTrace);
      },
    );

    _cartMessageStreamSubscription =
        GetIt.instance.get<CartRepository>().getCartMessageStream().listen(
      (message) {
        onCartMessage(message);
      },
      onError: (err, stackTrace) {
        onCartError(err, stackTrace);
      },
    );
  }

  void onCartData(Cart cart);
  void onCartMessage(CartMessage message) {}
  void onCartError(err, stackTrace);

  @override
  Future<void> close() {
    _cartStreamSubscription.cancel();
    _cartMessageStreamSubscription.cancel();
    return super.close();
  }
}

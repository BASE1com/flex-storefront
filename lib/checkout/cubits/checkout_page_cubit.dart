import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flex_storefront/cart/cart_repository.dart';
import 'package:flex_storefront/cart/models/cart_message.dart';
import 'package:flex_storefront/checkout/checkout_repository.dart';
import 'package:flex_storefront/checkout/cubits/checkout_page_state.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';
import 'package:get_it/get_it.dart';

// TODO: Better way to do this?
// Reminder: `stream.last` DOESN'T EMIT until the stream gets closed, which
// doesn't happen at that point
Future<CartMessage> readLastMessage() async {
  final completer = Completer<CartMessage>();

  final sub = GetIt.instance
      .get<CartRepository>()
      .getCartMessageStream()
      .listen((message) async {
    completer.complete(message);
  });

  return completer.future.then((message) async {
    await sub.cancel();
    return message;
  });
}

// TODO: Better way to do this?
Future<void> waitFor<T>() async {
  final completer = Completer<void>();

  final sub = GetIt.instance
      .get<CartRepository>()
      .getCartMessageStream()
      .listen((message) async {
    if (message is T) {
      completer.complete();
    }
  });

  return completer.future.then((_) async {
    await sub.cancel();
  });
}

class CheckoutPageCubit extends Cubit<CheckoutPageState> {
  late StreamSubscription _checkoutStreamSubscription;

  CheckoutPageCubit() : super(CheckoutPageState(status: Status.initial)) {
    _checkoutStreamSubscription =
        GetIt.instance.get<CheckoutRepository>().stream.listen((checkoutInfo) {
      emit(state.copyWith(
        status: Status.success,
        checkoutInfo: checkoutInfo,
      ));
    });
  }

  Future<void> loadCheckoutInfo() async {
    emit(state.copyWith(status: Status.pending));

    // If the cart is loading (likely to happen if the user just logged in),
    // then we wait for that loading to end so we can checkout the right cart.
    final lastMessage = await readLastMessage();
    if (lastMessage is CartLoading) {
      await waitFor<CartReady>();
    }

    final cartId = GetIt.instance.get<CartRepository>().currentCart.identifier;

    await GetIt.instance
        .get<CheckoutRepository>()
        .fetchCheckoutInfo(cartId: cartId);
  }

  @override
  Future<void> close() async {
    await _checkoutStreamSubscription.cancel();
    super.close();
  }
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:flex_storefront/cart/cart_repository.dart';
import 'package:flex_storefront/flex_ui/cubits/product_list_item_state.dart';
import 'package:flex_storefront/product_list/models/product.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';
import 'package:get_it/get_it.dart';

class ProductListItemCubit extends Cubit<ProductListItemState> {
  final Product product;

  ProductListItemCubit({
    required this.product,
  }) : super(ProductListItemState(status: Status.initial)) {
    _subscribe();
  }

  final _cartRepository = GetIt.instance.get<CartRepository>();
  late final StreamSubscription _cartStreamSubscription;

  Future<void> _subscribe() async {
    _cartStreamSubscription = _cartRepository.cartStream.listen(
      (cart) {
        emit(ProductListItemState(
          status: Status.success,
          quantity: cart.entries
                  .firstWhereOrNull(
                      (entry) => entry.product.code == product.code)
                  ?.quantity ??
              0,
        ));
      },
      onError: (err, stackTrace) {
        emit(ProductListItemState(status: Status.failure));
        addError(err, stackTrace);
      },
    );
  }

  Future<void> addToCart() async {
    emit(state.copyWith(status: Status.pending));

    try {
      await _cartRepository.addProductToCart(
        product: product,
        quantity: 1,
      );

      emit(state.copyWith(status: Status.success));
    } catch (e) {
      emit(state.copyWith(status: Status.failure));
    }
  }

  void changeQuantity(int quantity) {
    try {
      if (quantity <= 0) return;

      final entry = _cartRepository.currentCart.entries
          .firstWhereOrNull((entry) => entry.product.code == product.code);

      if (entry == null) return;

      _cartRepository.changeQuantityInCart(
        entry: entry,
        quantity: quantity,
      );

      emit(state.copyWith(quantity: quantity));
    } catch (error, stackTrace) {
      emit(state.copyWith(status: Status.failure));
      addError(error, stackTrace);
    }
  }

  @override
  Future<void> close() {
    _cartStreamSubscription.cancel();
    return super.close();
  }
}

import 'package:flex_storefront/cart/cubits/cart_icon_state.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';
import 'package:flex_storefront/shared/utils/cart_subscription_cubit.dart';

class CartIconCubit extends CartSubscriptionCubit<CartIconState> {
  CartIconCubit() : super(CartIconState(status: Status.initial));

  @override
  void onCartData(cart) {
    emit(CartIconState(
      status: Status.success,
      totalItems: cart.totalItems,
    ));
  }

  @override
  void onCartError(err, stackTrace) {
    emit(CartIconState(status: Status.failure));
    addError(err, stackTrace);
  }
}

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
      totalUnitCount: cart.totalUnitCount,
    ));
  }

  @override
  void onCartError(err, stackTrace) {
    emit(state.copyWith(
      status: Status.failure,
      totalItems: 0,
      totalUnitCount: 0,
    ));
    addError(err, stackTrace);
  }
}

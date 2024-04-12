import 'package:bloc/bloc.dart';
import 'package:flex_storefront/cart/apis/cart_api.dart';
import 'package:flex_storefront/cart/cubits/cart_state.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';

class CartCubit extends Cubit<CartState> {
  final CartApi cartApi = CartApi();

  CartCubit() : super(CartState(status: Status.pending));

  Future<void> loadCart({String? cartCode}) async {
    try {
      emit(CartState(status: Status.pending));

      final cart = await cartApi.fetchCart(cartCode: cartCode);

      emit(CartState(
        status: Status.success,
        cart: cart,
      ));
    } catch (err) {
      emit(CartState(status: Status.failure));
    }
  }
}

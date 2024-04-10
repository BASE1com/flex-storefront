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

      final testCart = await cartApi.fetchCart(
          cartCode: '1b2be4d8-c5c7-4b0a-a472-ac7df417d762');

      print(testCart);

      emit(CartState(
        status: Status.success,
        products: [],
        totalPrice: testCart.totalPrice,
      ));
    } catch (err) {
      print(err);
      emit(CartState(status: Status.failure));
    }
  }
}

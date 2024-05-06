import 'package:bloc/bloc.dart';
import 'package:flex_storefront/cart/apis/cart_api.dart';
import 'package:flex_storefront/cart/cart_repository.dart';
import 'package:flex_storefront/cart/cubits/cart_icon_state.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';
import 'package:get_it/get_it.dart';

class CartIconCubit extends Cubit<CartIconState> {
  final CartApi cartApi = CartApi();

  CartIconCubit() : super(CartIconState(status: Status.initial));

  Future<void> subscribe() async {
    GetIt.instance.get<CartRepository>().getCartStream().listen((cart) {
      emit(CartIconState(
        status: Status.success,
        totalItems: cart.totalItems,
      ));
    }).onError((err, stackTrace) {
      emit(CartIconState(status: Status.failure));
      addError(err, stackTrace);
    });

    GetIt.instance
        .get<CartRepository>()
        .getCartMessageStream()
        .listen((message) {
      print('Got message: $message');
    });
  }
}

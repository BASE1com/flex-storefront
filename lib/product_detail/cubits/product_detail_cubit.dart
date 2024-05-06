import 'package:bloc/bloc.dart';
import 'package:flex_storefront/cart/cart_repository.dart';
import 'package:flex_storefront/product_detail/apis/product_api.dart';
import 'package:flex_storefront/product_detail/cubits/product_detail_state.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';
import 'package:get_it/get_it.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  ProductDetailCubit() : super(ProductDetailState(status: Status.pending));

  final CartRepository _cartRepository = GetIt.instance.get<CartRepository>();

  Future<void> loadProduct({required String productId}) async {
    try {
      emit(ProductDetailState(status: Status.pending));

      final product = await GetIt.instance
          .get<ProductApi>()
          .fetchProduct(productId: productId);

      emit(ProductDetailState(
        status: Status.success,
        product: product,
      ));
    } catch (err) {
      emit(ProductDetailState(status: Status.failure));
    }
  }

  void changeQuantity({required int quantity}) {
    try {
      if (quantity <= 0) return;

      emit(state.copyWith(quantity: quantity));
    } catch (error, stackTrace) {
      emit(state.copyWith(status: Status.failure));
      addError(error, stackTrace);
    }
  }

  Future<void> addToCart() async {
    emit(state.copyWith(status: Status.pending));

    try {
      await _cartRepository.addProductToCart(
        productCode: state.product!.code,
        quantity: state.quantity,
      );

      emit(state.copyWith(status: Status.success));
    } catch (e) {
      emit(state.copyWith(status: Status.failure));
    }
  }
}

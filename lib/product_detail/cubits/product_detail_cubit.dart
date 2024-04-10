import 'package:bloc/bloc.dart';
import 'package:flex_storefront/product_detail/apis/product_api.dart';
import 'package:flex_storefront/product_detail/cubits/product_detail_state.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  final ProductApi productApi = ProductApi();

  ProductDetailCubit() : super(ProductDetailState(status: Status.pending));

  Future<void> loadProduct({required String productId}) async {
    try {
      emit(ProductDetailState(status: Status.pending));

      final product = await productApi.fetchProduct(productId: productId);

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
}

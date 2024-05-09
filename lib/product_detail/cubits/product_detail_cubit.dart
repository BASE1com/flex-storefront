import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flex_storefront/analytics/apis/analytics_api.dart';
import 'package:flex_storefront/analytics/models/analytics_events.dart';
import 'package:flex_storefront/cart/cart_repository.dart';
import 'package:flex_storefront/product_detail/apis/product_api.dart';
import 'package:flex_storefront/product_detail/cubits/product_detail_state.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';
import 'package:get_it/get_it.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  ProductDetailCubit() : super(ProductDetailState(status: Status.pending));

  Future<void> loadProduct({required String productId}) async {
    try {
      emit(ProductDetailState(status: Status.pending));

      final product = await GetIt.instance
          .get<ProductApi>()
          .fetchProduct(productId: productId);

      await GetIt.instance
          .get<AnalyticsApi>()
          .track(ViewItemEvent.fromProduct(product));

      emit(ProductDetailState(
        status: Status.success,
        product: product,
      ));
    } on DioException catch (error) {
      emit(ProductDetailState(
        status: Status.failure,
        error: error,
        stackTrace: error.stackTrace,
      ));
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
      await GetIt.instance.get<CartRepository>().addProductToCart(
            product: state.product!,
            quantity: state.quantity,
          );

      emit(state.copyWith(status: Status.success));
    } on DioException catch (error) {
      emit(ProductDetailState(
        status: Status.failure,
        error: error,
        stackTrace: error.stackTrace,
      ));
    }
  }
}

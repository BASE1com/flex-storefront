import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flex_storefront/product_detail/apis/product_api.dart';
import 'package:flex_storefront/product_list/apis/product_list_api.dart';
import 'package:flex_storefront/product_list/cubits/product_list_state.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';
import 'package:get_it/get_it.dart';

class ProductListCubit extends Cubit<ProductListState> {
  ProductListCubit() : super(ProductListState(status: Status.pending));

  Future<void> loadProductsFromIds({required List<String> productIds}) async {
    for (var id in productIds) {
      GetIt.instance
          .get<ProductApi>()
          .fetchProduct(productId: id, fields: LIST_PARAMS)
          .then((value) {
        emit(ProductListState(
          status: Status.success,
          products: [...state.products, value],
        ));
      });
    }
  }
}

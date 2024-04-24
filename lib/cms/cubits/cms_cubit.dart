import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flex_storefront/cms/apis/cms_api.dart';
import 'package:flex_storefront/cms/cubits/cms_state.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';
import 'package:get_it/get_it.dart';

class CmsCubit extends Cubit<CmsState> {
  CmsCubit() : super(CmsState(status: Status.pending));

  Future<void> loadHomepageContent({int? parentId}) async {
    try {
      emit(CmsState(status: Status.pending));

      final sections =
          await GetIt.instance.get<CmsApi>().fetchHomepageContent();

      emit(CmsState(
        status: Status.success,
        sections: sections,
      ));
    } on DioException catch (error) {
      emit(CmsState(
        status: Status.failure,
        error: error,
        stackTrace: error.stackTrace,
      ));
    }
  }
}

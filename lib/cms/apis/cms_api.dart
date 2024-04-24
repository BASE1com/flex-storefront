import 'package:dio/dio.dart';
import 'package:flex_storefront/cms/models/cms_models.dart';
import 'package:flex_storefront/init.dart';
import 'package:get_it/get_it.dart';

const DOMAIN = 'flex-cms-fpnplvnjqq-uc.a.run.app';
const PATH = '/api/homepage';

class CmsApi {
  Future<List<CmsData>> fetchHomepageContent() async {
    final queryString = {
      'populate[content][on][section.carousel][populate][items][populate]': '*',
    };

    final uri = Uri.https(DOMAIN, PATH, queryString);
    final response = await GetIt.instance
        .get<Dio>(instanceName: Singletons.strapiClient)
        .get(uri.toString());

    final result = <CmsData>[];
    final elements = response.data['data']['content'] as List<dynamic>;

    for (var i = 0; i < elements.length; i++) {
      final element = elements[i];

      switch (element['__component']) {
        case 'section.carousel':
          {
            result.add(CarouselData.fromJson(element));
          }
      }
    }

    return result;
  }
}

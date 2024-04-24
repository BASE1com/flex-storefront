import 'package:flex_storefront/cms/models/cms_models.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';

class CmsState extends BlocState {
  final List<CmsData> sections;

  CmsState({
    required super.status,
    super.error,
    super.stackTrace,
    this.sections = const [],
  });

  @override
  String toString() {
    return 'CmsState{status: $status, sections: ${sections.length}}';
  }
}

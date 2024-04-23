import 'package:flex_storefront/product_list/models/product.dart';
import 'package:flex_storefront/shared/utils/nested_reader.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_results.g.dart';

@JsonSerializable(createToJson: false)
class SearchResults {
  @NestedJsonKey(name: 'currentQuery.query')
  final SearchQuery currentQuery;
  final List<Facet> facets;
  final String freeTextSearch;
  final Pagination pagination;
  final List<Product> products;
  final List<Sort> sorts;

  SearchResults({
    required this.currentQuery,
    this.facets = const [],
    required this.freeTextSearch,
    required this.pagination,
    this.products = const [],
    this.sorts = const [],
  });
  factory SearchResults.fromJson(Map<String, dynamic> json) =>
      _$SearchResultsFromJson(json);

  @override
  String toString() {
    return 'SearchResults{facets: $facets, freeTextSearch: $freeTextSearch, pagination: $pagination, products: $products, sorts: $sorts}';
  }
}

@JsonSerializable(createToJson: false)
class Sort {
  final String code;
  final String name;
  final bool selected;

  Sort({
    required this.code,
    required this.name,
    required this.selected,
  });
  factory Sort.fromJson(Map<String, dynamic> json) => _$SortFromJson(json);

  @override
  String toString() {
    return 'Sort{code: $code, name: $name, selected: $selected}';
  }
}

@JsonSerializable(createToJson: false)
class Pagination {
  final int currentPage;
  final int pageSize;
  final String sort;
  final int totalPages;
  final int totalResults;

  Pagination({
    required this.currentPage,
    required this.pageSize,
    required this.sort,
    required this.totalPages,
    required this.totalResults,
  });
  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);
}

@JsonSerializable(createToJson: false)
class Facet {
  final bool category;
  final bool multiSelect;
  final String name;
  final int priority;
  final List<FacetValue> values;
  final bool visible;

  Facet({
    required this.category,
    required this.multiSelect,
    required this.name,
    required this.priority,
    this.values = const [],
    this.visible = false,
  });
  factory Facet.fromJson(Map<String, dynamic> json) => _$FacetFromJson(json);
}

@JsonSerializable(createToJson: false)
class FacetValue {
  final String name;
  final int count;
  final bool selected;

  FacetValue({
    required this.name,
    required this.count,
    required this.selected,
  });

  factory FacetValue.fromJson(Map<String, dynamic> json) =>
      _$FacetValueFromJson(json);
}

@JsonSerializable(createToJson: false)
class SearchQuery {
  final String value;

  SearchQuery({
    required this.value,
  });

  String get lastLeaf => value.split(':').last;

  factory SearchQuery.fromJson(Map<String, dynamic> json) =>
      _$SearchQueryFromJson(json);

  @override
  String toString() {
    return 'SearchQuery{value: $value}';
  }
}

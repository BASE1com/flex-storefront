import 'package:flex_storefront/product_list/models/product.dart';
import 'package:flex_storefront/shared/utils/nested_reader.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_results.g.dart';

@JsonSerializable(createToJson: false)
class SearchResults {
  final List<Breadcrumb> breadcrumbs;
  @NestedJsonKey(name: 'currentQuery.query')
  final SearchQuery currentQuery;
  final List<Facet> facets;
  final String freeTextSearch;
  final Pagination pagination;
  final List<Product> products;
  final List<Sort> sorts;

  SearchResults({
    this.breadcrumbs = const [],
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
    return 'SearchResults{breadcrumbs: $breadcrumbs, '
        'currentQuery: $currentQuery, facets: $facets, '
        'freeTextSearch: $freeTextSearch, pagination: $pagination, '
        'products: $products, sorts: $sorts}';
  }
}

@JsonSerializable(createToJson: false)
class Breadcrumb {
  final String facetCode;
  final String facetName;
  final String facetValueCode;
  final String? facetValueName;
  final SearchState? removeQuery;
  final SearchState? truncateQuery;

  Breadcrumb({
    required this.facetCode,
    required this.facetName,
    required this.facetValueCode,
    required this.facetValueName,
    this.removeQuery,
    this.truncateQuery,
  });

  factory Breadcrumb.fromJson(Map<String, dynamic> json) =>
      _$BreadcrumbFromJson(json);

  @override
  String toString() {
    return 'Breadcrumb{facetCode: $facetCode, facetName: $facetName, '
        'facetValueCode: $facetValueCode, facetValueName: $facetValueName}';
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

  factory Pagination.empty() => Pagination(
        currentPage: 0,
        pageSize: 0,
        sort: '',
        totalPages: 0,
        totalResults: 0,
      );

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

  @override
  String toString() {
    return 'Facet{name: $name, multiSelect: $multiSelect, visible: $visible}';
  }
}

@JsonSerializable(createToJson: false)
class FacetValue {
  final String name;
  final int count;
  final bool selected;
  @NestedJsonKey(name: 'query.query')
  final SearchQuery query;

  FacetValue({
    required this.name,
    required this.count,
    required this.selected,
    required this.query,
  });

  factory FacetValue.fromJson(Map<String, dynamic> json) =>
      _$FacetValueFromJson(json);

  @override
  String toString() {
    return 'FacetValue{name: $name, count: $count, selected: $selected}';
  }
}

@JsonSerializable(createToJson: false)
class SearchState {
  final SearchQuery query;
  final String? url;

  SearchState({
    required this.query,
    this.url,
  });

  factory SearchState.fromJson(Map<String, dynamic> json) =>
      _$SearchStateFromJson(json);

  @override
  String toString() {
    return 'SearchState{query: $query, url: $url}';
  }
}

/// Hybris search query is a string containing different parts separated by
/// semi-colons `:` :
/// 1. Search term ("mandatory" in a way, it could be empty string, in that
/// case, the query starts with a leading `:`)
/// 2. Sort value, (mandatory, default to "relevance")
/// 3. Zero, one, or more filters. Warning: the key/value separator is the same
///    semi-colon character `:`
/// Examples:
/// - `:relevance:allCategories:576`: All products from the category 576, sorted
///   by relevance
/// - `cyber:price-desc`: All products matching the term "cyber", sorted by
///   price (descending)
/// - `camera:name-asc:allCategories:584:availableInStores:Choshi:price:$200-$499.99`:
///   All products matching the term "camera", from the category 576, filtered
///   by store and price, sorted by name in alphabetical order.
@JsonSerializable(createToJson: false)
class SearchQuery {
  final String value;

  SearchQuery({
    required this.value,
  });

  String get searchTerm {
    return value.split(':')[0];
  }

  String get sort {
    return value.split(':')[1];
  }

  Map<String, String> get filters {
    final parts = value.split(':');
    var filters = <String, String>{};

    if (parts.length == 2) {
      // Just the sort. Example: `cybershot:relevance` or `:relevance`
      return {};
    }

    for (var i = 2; i < parts.length; i = i + 2) {
      filters[parts[i]] = parts[i + 1];
    }

    return filters;
  }

  String copyWithSort(String sort) {
    final parts = value.split(':');
    parts[1] = sort;

    return parts.join(':');
  }

  factory SearchQuery.fromJson(Map<String, dynamic> json) =>
      _$SearchQueryFromJson(json);

  @override
  String toString() {
    return 'SearchQuery{value: $value}';
  }
}

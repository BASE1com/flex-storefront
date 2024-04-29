// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_results.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResults _$SearchResultsFromJson(Map<String, dynamic> json) =>
    SearchResults(
      breadcrumbs: (json['breadcrumbs'] as List<dynamic>?)
              ?.map((e) => Breadcrumb.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      currentQuery: SearchQuery.fromJson(
          nestedReader(json, 'currentQuery.query') as Map<String, dynamic>),
      facets: (json['facets'] as List<dynamic>?)
              ?.map((e) => Facet.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      freeTextSearch: json['freeTextSearch'] as String,
      pagination:
          Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
      products: (json['products'] as List<dynamic>?)
              ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      sorts: (json['sorts'] as List<dynamic>?)
              ?.map((e) => Sort.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Breadcrumb _$BreadcrumbFromJson(Map<String, dynamic> json) => Breadcrumb(
      facetCode: json['facetCode'] as String,
      facetName: json['facetName'] as String,
      facetValueCode: json['facetValueCode'] as String,
      facetValueName: json['facetValueName'] as String,
      removeQuery: json['removeQuery'] == null
          ? null
          : SearchState.fromJson(json['removeQuery'] as Map<String, dynamic>),
      truncateQuery: json['truncateQuery'] == null
          ? null
          : SearchState.fromJson(json['truncateQuery'] as Map<String, dynamic>),
    );

Sort _$SortFromJson(Map<String, dynamic> json) => Sort(
      code: json['code'] as String,
      name: json['name'] as String,
      selected: json['selected'] as bool,
    );

Pagination _$PaginationFromJson(Map<String, dynamic> json) => Pagination(
      currentPage: json['currentPage'] as int,
      pageSize: json['pageSize'] as int,
      sort: json['sort'] as String,
      totalPages: json['totalPages'] as int,
      totalResults: json['totalResults'] as int,
    );

Facet _$FacetFromJson(Map<String, dynamic> json) => Facet(
      category: json['category'] as bool,
      multiSelect: json['multiSelect'] as bool,
      name: json['name'] as String,
      priority: json['priority'] as int,
      values: (json['values'] as List<dynamic>?)
              ?.map((e) => FacetValue.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      visible: json['visible'] as bool? ?? false,
    );

FacetValue _$FacetValueFromJson(Map<String, dynamic> json) => FacetValue(
      name: json['name'] as String,
      count: json['count'] as int,
      selected: json['selected'] as bool,
      query: SearchQuery.fromJson(
          nestedReader(json, 'query.query') as Map<String, dynamic>),
    );

SearchState _$SearchStateFromJson(Map<String, dynamic> json) => SearchState(
      query: SearchQuery.fromJson(json['query'] as Map<String, dynamic>),
      url: json['url'] as String?,
    );

SearchQuery _$SearchQueryFromJson(Map<String, dynamic> json) => SearchQuery(
      value: json['value'] as String,
    );

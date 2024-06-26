// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_results.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderResults _$OrderResultsFromJson(Map<String, dynamic> json) => OrderResults(
      orders: (json['orders'] as List<dynamic>)
          .map((e) => OrderSummary.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination:
          Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
      sorts: (json['sorts'] as List<dynamic>)
          .map((e) => OrderSort.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

OrderSort _$OrderSortFromJson(Map<String, dynamic> json) => OrderSort(
      code: json['code'] as String,
      name: json['name'] as String?,
      selected: json['selected'] as bool,
    );

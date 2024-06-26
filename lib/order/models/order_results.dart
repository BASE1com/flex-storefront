import 'package:flex_storefront/order/models/order.dart';
import 'package:flex_storefront/search/models/search_results.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_results.g.dart';

@JsonSerializable(createToJson: false)
class OrderResults {
  final List<OrderSummary> orders;
  final Pagination pagination;
  final List<OrderSort> sorts;

  OrderResults({
    required this.orders,
    required this.pagination,
    required this.sorts,
  });

  factory OrderResults.fromJson(Map<String, dynamic> json) =>
      _$OrderResultsFromJson(json);

  @override
  String toString() {
    return 'OrderResults{orders: $orders, pagination: $pagination, sorts: $sorts}';
  }
}

@JsonSerializable(createToJson: false)
class OrderSort {
  final String code;
  final String? name;
  final bool selected;

  OrderSort({
    required this.code,
    this.name,
    required this.selected,
  });
  factory OrderSort.fromJson(Map<String, dynamic> json) =>
      _$OrderSortFromJson(json);

  @override
  String toString() {
    return 'OrderSort{code: $code, name: $name, selected: $selected}';
  }
}

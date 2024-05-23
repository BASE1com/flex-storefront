import 'package:flex_storefront/shared/bloc_helper.dart';

class SuggestionState {
  final Status status;
  final List<String> suggestions;
  final String? query;

  SuggestionState._({
    required this.status,
    required this.suggestions,
    this.query,
  });

  factory SuggestionState.initial() {
    return SuggestionState._(
      status: Status.initial,
      suggestions: [],
    );
  }

  SuggestionState copyWith({
    Status? status,
    List<String>? suggestions,
    String? query,
  }) {
    return SuggestionState._(
      status: status ?? this.status,
      suggestions: suggestions ?? this.suggestions,
      query: query ?? this.query,
    );
  }
}

import 'package:bloc/bloc.dart';
import 'package:flex_storefront/search/apis/suggestion_api.dart';
import 'package:flex_storefront/search/cubits/suggestion_state.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';
import 'package:get_it/get_it.dart';

class SuggestionCubit extends Cubit<SuggestionState> {
  SuggestionCubit() : super(SuggestionState.initial());

  Future<void> loadSuggestions(String query) async {
    emit(state.copyWith(status: Status.pending, query: query));

    final suggestions = await GetIt.instance
        .get<SuggestionApi>()
        .fetchSuggestions(query: query, limit: 5);

    emit(state.copyWith(status: Status.success, suggestions: suggestions));
  }
}

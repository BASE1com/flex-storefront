import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flex_storefront/analytics/models/analytics_events.dart';
import 'package:get_it/get_it.dart';
import 'package:loggy/loggy.dart';

mixin AnalyticsApiLoggy implements LoggyType {
  @override
  Loggy<AnalyticsApiLoggy> get loggy =>
      Loggy<AnalyticsApiLoggy>('AnalyticsApiLoggy');
}

class AnalyticsApi with AnalyticsApiLoggy {
  Future<void> track(AnalyticsEvent event) async {
    loggy.info('Track Analytics event $event');
    if (event is ViewItemEvent) {
      await GetIt.instance.get<FirebaseAnalytics>().logViewItem(
            currency: event.currency,
            value: event.value,
            items: event.items,
            parameters: event.parameters,
          );
    } else if (event is SelectContentEvent) {
      await GetIt.instance.get<FirebaseAnalytics>().logSelectContent(
            itemId: event.itemId,
            contentType: event.contentType,
            parameters: event.parameters,
          );
    } else if (event is ViewCartEvent) {
      await GetIt.instance.get<FirebaseAnalytics>().logViewCart(
            currency: event.currency,
            value: event.value,
            items: event.items,
            parameters: event.parameters,
          );
    } else if (event is AddToCartEvent) {
      await GetIt.instance.get<FirebaseAnalytics>().logAddToCart(
            currency: event.currency,
            value: event.value,
            items: event.items,
            parameters: event.parameters,
          );
    } else if (event is RemoveFromCartEvent) {
      await GetIt.instance.get<FirebaseAnalytics>().logRemoveFromCart(
            currency: event.currency,
            value: event.value,
            items: event.items,
            parameters: event.parameters,
          );
    } else {
      loggy.warning('Unhandled event type: ${event.runtimeType}');
    }
  }

  Future<void> setUserId(String? userId) async {
    loggy.info('Set the userId to: $userId');
    await GetIt.instance.get<FirebaseAnalytics>().setUserId(id: userId);
  }
}

// Necessary for code-generation to work
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popina_test/models/order.dart';
import 'package:popina_test/services/api/restaurant_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'order_provider.g.dart';

/// This will create a provider named `orderProvider`
/// which will cache the result of this function.
@riverpod
Future<List<Order>> futureOrderList(Ref ref) async {
  // Using package:http, we fetch a the orders from the API.
  return await RestaurantApi.getOrders();
}

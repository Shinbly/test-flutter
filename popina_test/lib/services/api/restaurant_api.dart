import 'package:flutter/foundation.dart';
import 'package:popina_test/models/order.dart';
import 'package:popina_test/services/api/http_services.dart';

class RestaurantApi {
  static const String orderUrl =
      'https://raw.githubusercontent.com/popina/test-flutter/main/data.json';

  static Future<List<Order>> getOrders() async {
    Uri url = Uri.parse(orderUrl);
    try {
      Map<String, dynamic> orders = await HttpService.get(url);
      return parseOrders(orders);
    } catch (e) {
      if (kDebugMode) {
        print("error while fetching the orders $e");
      }
      rethrow;
    }
  }

  static List<Order> parseOrders(Map<String, dynamic> orders) {
    List<Order> ordersList = [];
    if (orders.containsKey("orders")) {
      ordersList = (orders["orders"] as List<dynamic>)
          .map((e) => Order.fromjson(e))
          .toList();
    }
    return ordersList;
  }
}

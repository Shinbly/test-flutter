import 'dart:convert';

import 'package:popina_test/extensions/orderExtension.dart';
import 'package:popina_test/models/order.dart';
import 'package:popina_test/providers/order_provider.dart';
import 'package:popina_test/services/api/restaurant_api.dart';
import 'package:riverpod/riverpod.dart';
import 'package:test/test.dart';

/// A testing utility which creates a [ProviderContainer] and automatically
/// disposes it at the end of the test.
ProviderContainer createContainer({
  ProviderContainer? parent,
  List<Override> overrides = const [],
  List<ProviderObserver>? observers,
}) {
  // Create a ProviderContainer, and optionally allow specifying parameters.
  final container = ProviderContainer(
    parent: parent,
    overrides: overrides,
    observers: observers,
  );

  // When the test ends, dispose the container.
  addTearDown(container.dispose);

  return container;
}

void main() {
  const String orderList = """{
  "object": "till",
  "orders":[
    {
      "object": "order",
      "id": 217,
      "table": "4",
      "guests": 3,
      "date": "",
      "items": [
        {
          "object": "item",
          "id": 217,
          "name": "Salade",
          "price": 900,
          "currency": "€",
          "color": "#73C399"
        },
        {
          "object": "item",
          "id": 218,
          "name": "Burger",
          "price": 1800,
          "currency": "€",
          "color": "#BD9B70"
        },
        {
          "object": "item",
          "id": 219,
          "name": "Tiramisù",
          "price": 800,
          "currency": "€",
          "color": "#FFAC69"
        }
      ]
    },
    {
      "object": "order",
      "id": 218,
      "table": "5",
      "guests": 1,
      "date": "",
      "items": [
        {
          "object": "item",
          "id": 220,
          "name": "Soupe",
          "price": 800,
          "currency": "€",
          "color": "#73C399"
        },
        {
          "object": "item",
          "id": 221,
          "name": "Pizza Napolitaine",
          "price": 1400,
          "currency": "€",
          "color": "#BD9B70"
        },
        {
          "object": "item",
          "id": 221,
          "name": "Pizza Napolitaine",
          "price": 1400,
          "currency": "€",
          "color": "#BD9B70"
        },
        {
          "object": "item",
          "id": 222,
          "name": "Mousse au Chocolat",
          "price": 900,
          "currency": "€",
          "color": "#FFAC69"
        }
      ]
    },
    {
      "object": "order",
      "id": 219,
      "table": "8",
      "guests": 2,
      "date": "",
      "items": [
        {
          "object": "item",
          "id": 223,
          "name": "Soupe Miso",
          "price": 600,
          "currency": "€",
          "color": "#73C399"
        },
        {
          "object": "item",
          "id": 224,
          "name": "Tataki de Thon",
          "price": 1900,
          "currency": "€",
          "color": "#BD9B70"
        },
        {
          "object": "item",
          "id": 225,
          "name": "Boules Coco",
          "price": 350,
          "currency": "€",
          "color": "#FFAC69"
        }
      ]
    }
  ]
}""";

  test('Test order provider', () async {
    // Create a ProviderContainer for this test.
    // DO NOT share ProviderContainers between tests.
    final container = createContainer();
    List<Order> expectedList = RestaurantApi.parseOrders(jsonDecode(orderList));
    List<Order> actualList = await container.read(orderListProvider.future);

    expect(actualList.deepEquals(expectedList), true);
  });
}

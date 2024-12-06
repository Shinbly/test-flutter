// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:popina_test/component/item_item.dart';
import 'package:popina_test/component/item_list.dart';
import 'package:popina_test/component/order_item.dart';

import 'package:popina_test/models/order.dart';
import 'package:popina_test/services/api/restaurant_api.dart';

void main() {
  const String orderList = """{
  "object": "till",
  "orders":[
    {
      "object": "order",
      "id": 217,
      "table": "4",
      "guests": 3,
      "date": "17:56",
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
        }
      ]
    }
  ]
}""";

  testWidgets('Test Order Widget', (WidgetTester tester) async {
    Order orderToTest = RestaurantApi.parseOrders(jsonDecode(orderList)).first;
    bool hasBeenTapped = false;

    // Build our app and trigger a frame.

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: OrderItem(
          order: orderToTest,
          onTap: () {
            hasBeenTapped = true;
          },
        ),
      ),
    ));

    ///test that the table number and the number of guests and the date are displayed
    expect(find.text(orderToTest.table), findsOneWidget);
    expect(find.text(orderToTest.guests.toString()), findsOneWidget);
    expect(find.text(orderToTest.date!), findsOneWidget);

    ///test that the onTap function is called when the widget is tapped
    expect(hasBeenTapped, false);
    await tester.tap(find.byType(OrderItem));
    await tester.pump();
    expect(hasBeenTapped, true);
  });

  testWidgets('Test Item Widget', (WidgetTester tester) async {
    Order orderToTest = RestaurantApi.parseOrders(jsonDecode(orderList)).first;
    // Build our app and trigger a frame.

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ItemList(
            order: orderToTest,
          ),
        ),
      ),
    );

    ///test if the item are merged
    expect(find.text("Salade"), findsOneWidget);
    expect(find.byType(ItemItem), findsExactly(2));
  });
}

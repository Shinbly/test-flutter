import 'package:flutter/material.dart';
import 'package:popina_test/component/order_item.dart';
import 'package:popina_test/models/order.dart';

///this widget will represent the list of order Given by the provider
class OrderList extends StatelessWidget {
  const OrderList({required this.orders, required this.onTap, super.key});

  final List<Order> orders;
  final Function(Order) onTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final Order order = orders[index];
        return OrderItem(
          onTap: () => onTap(order),
          order: order,
        );
      },
    );
  }
}

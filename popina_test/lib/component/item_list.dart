import 'package:flutter/material.dart';
import 'package:popina_test/component/item_item.dart';
import 'package:popina_test/models/item.dart';
import 'package:popina_test/models/order.dart';

class ItemList extends StatelessWidget {
  const ItemList({
    required this.order,
    super.key,
  });

  final Order order;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: order.quantityByItemId.entries.map(
        (MapEntry<int, int> itemIds) {
          Item item =
              order.items.firstWhere((element) => element.id == itemIds.key);
          int quantity = itemIds.value;
          return ItemItem(
            quantity: quantity,
            name: item.name,
            price: item.price * quantity,
            currency: item.currency,
            color: item.color,
          );
        },
      ).toList(growable: false),
    );
  }
}

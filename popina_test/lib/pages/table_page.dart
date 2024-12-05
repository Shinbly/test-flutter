import 'package:flutter/material.dart';
import 'package:popina_test/component/item_item.dart';
import 'package:popina_test/component/total_price.dart';
import 'package:popina_test/models/item.dart';
import 'package:popina_test/models/order.dart';

class TablePage extends StatelessWidget {
  const TablePage({super.key, required this.order});

  final Order order;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Table ${order.table}',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Text(
                  '${order.items.length} Produit${order.items.length > 1 ? 's' : ''}',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              Tab(
                icon: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: order.totalPrice.entries
                      .map(
                        (MapEntry<String, int> entry) => TotalPrice(
                          currency: entry.key,
                          price: entry.value,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      )
                      .toList(growable: false),
                ),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: ListView(
            children: [
              ...order.quantityByItemId.entries.map(
                (MapEntry<int, int> itemIds) {
                  Item item = order.items
                      .firstWhere((element) => element.id == itemIds.key);
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
            ],
          ),
        ),
      ),
    );
  }
}

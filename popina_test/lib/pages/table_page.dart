import 'package:flutter/material.dart';
import 'package:popina_test/component/item_list.dart';
import 'package:popina_test/component/total_price.dart';
import 'package:popina_test/models/order.dart';

class TablePage extends StatelessWidget {
  const TablePage({
    required this.order,
    super.key,
  });

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
          child: ItemList(order: order),
        ),
      ),
    );
  }
}

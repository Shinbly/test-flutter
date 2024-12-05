import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popina_test/component/order_list.dart';
import 'package:popina_test/models/order.dart';
import 'package:popina_test/pages/table_page.dart';
import 'package:popina_test/providers/order_provider.dart';

///this page is the page that will render all of the différents tables's order in the restaurant

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        // Read the orderListProvider. This will start the network request
        // if it wasn't already started.
        // By using ref.watch, this widget will rebuild whenever the
        // the activityProvider updates. This can happen when:
        // - The response goes from "loading" to "data/error"
        // - The request was refreshed
        // - The result was modified locally (such as when performing side-effects)
        // ...
        final AsyncValue<List<Order>> orders = ref.watch(orderListProvider);
        if (orders.isLoading) {
          return const CircularProgressIndicator();
        }
        if (orders.hasError) {
          return Center(
              child: const Text('Oops, something unexpected happened'));
        }
        return Scaffold(
          appBar: AppBar(
            title: Text('${orders.requireValue.length} Commandes'),
            centerTitle: true,
          ),
          body: Center(
            child: OrderList(
              onTap: (order) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => TablePage(order: order),
                ));
              },
              orders: orders.requireValue,
            ),
          ),
        );
      },
    );
  }
}

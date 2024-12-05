import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popina_test/models/order.dart';
import 'package:popina_test/providers/order_provider.dart';

///this page is the page that will render all of the différents tables's order in the restaurant

class TablePage extends StatelessWidget {
  const TablePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Table Page'),
      ),
      body: Center(
        child: Consumer(builder: (context, ref, child) {
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
            return const Text('Oops, something unexpected happened');
          }
          return ListView.builder(
            itemCount: orders.requireValue!.length,
            itemBuilder: (context, index) {
              final Order order = orders.requireValue![index];
              return ListTile(
                title: Text('Table ${order.table}'),
                subtitle: Text('Guests: ${order.guests}'),
                trailing: Text('Items: ${order.items.length}'),
              );
            },
          );
        }),
      ),
    );
  }
}

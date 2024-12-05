import 'package:flutter/material.dart';
import 'package:popina_test/component/total_price.dart';
import 'package:popina_test/extensions/date_extension.dart';
import 'package:popina_test/models/order.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({
    required this.order,
    required this.onTap,
    super.key,
  });

  final Order order;

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.01),
              blurRadius: 1,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: ListTile(
          onTap: onTap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          tileColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.01),
          leading: AspectRatio(
            aspectRatio: 1,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  order.table.toString(),
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                ),
              ),
            ),
          ),
          title: Row(
            children: [
              Icon(Icons.face_outlined),
              Text('${order.guests}'),
            ],
          ),
          subtitle: Text(
            (order.date ?? DateTime.now().time24Format()),
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: order.totalPrice.entries
                .map((MapEntry<String, int> entry) => TotalPrice(
                      currency: entry.key,
                      price: entry.value,
                    ))
                .toList(growable: false),
          ),
        ),
      ),
    );
  }
}

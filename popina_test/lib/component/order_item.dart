import 'package:flutter/material.dart';
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
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
              blurRadius: 1,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: ListTile(
          onTap: onTap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          tileColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.05),
          leading: AspectRatio(
            aspectRatio: 1,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  order.table.toString(),
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
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
            children:
                order.totalPrice.entries.map((MapEntry<String, int> entry) {
              final String price = (entry.value / 100).toStringAsFixed(2);
              String integer = price.split('.')[0];
              String decimal = ".${price.split('.')[1]}";
              return Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: integer,
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    TextSpan(
                      text: '$decimal  ${entry.key}',
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            fontWeight: FontWeight.w300,
                          ),
                    ),
                  ],
                ),
              );
            }).toList(growable: false),
          ),
        ),
      ),
    );
  }
}

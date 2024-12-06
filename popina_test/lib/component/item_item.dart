import 'package:flutter/material.dart';
import 'package:popina_test/component/total_price.dart';

///this widget represent the item that display the information of an item in the order
class ItemItem extends StatelessWidget {
  const ItemItem({
    required this.quantity,
    required this.name,
    required this.price,
    required this.currency,
    required this.color,
    super.key,
  });

  final int quantity;

  final String name;

  final int price;

  final String currency;

  final Color color;

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.headlineSmall?.copyWith(
          color: color,
        );

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ListTile(
        leading: AspectRatio(
          aspectRatio: 1,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: Text(
                '$quantity',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
        ),
        title: Text(
          name,
          style: textStyle?.copyWith(fontWeight: FontWeight.bold),
        ),
        trailing: TotalPrice(
          price: price,
          currency: currency,
          style: textStyle,
        ),
      ),
    );
  }
}

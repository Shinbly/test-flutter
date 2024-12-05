import 'package:flutter/material.dart';

///this widget will be used to display a total price

class TotalPrice extends StatelessWidget {
  const TotalPrice({
    required this.price,
    required this.currency,
    this.style,
    super.key,
  });

  ///the currency to display (it can be €, $, £, ...)
  final String currency;

  ///the price to display in cents (it will be divided by 100 to get the price in full )
  final int price;

  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = style ?? Theme.of(context).textTheme.displaySmall;
    String strprice = (price.toDouble() / 100).toStringAsFixed(2);
    String integer = strprice.split('.')[0];
    String decimal = ".${strprice.split('.')[1]}";
    return Hero(
      tag: strprice,
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: integer,
              style: textStyle?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: '$decimal  ${currency}',
              style: textStyle?.copyWith(
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:popina_test/extensions/colorExtension.dart';

/// this represent the model of the item entity parsed via json.
/// the item entity is the entity that represent the item in the list of items in the order
/// it can be for exemple this:
///  {
///   "object": "item",
///   "id": 217,
///   "name": "Salade",
///   "price": 900,
///   "currency": "€",
///   "color": "#73C399"
///  },

class Item {
  /// the constructor of the item entity
  Item._({
    required this.id,
    required this.name,
    required this.price,
    required this.currency,
    required this.color,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    List requiredFields = ['id', 'name', 'price', 'currency', 'color'];
    if (!requiredFields.every((element) => json.containsKey(element))) {
      throw ArgumentError('the json must contain all the required fields');
    }
    //first we parse the json to get the values of the item
    int id = json['id'] as int;
    String name = json['name'] as String;
    int price = json['price'] as int;
    String currency = json['currency'] as String;
    String hexColor = json['color'] as String;

    Color color = HexColor.fromHex(hexColor);

    return Item._(
      id: id,
      name: name,
      price: price,
      currency: currency,
      color: color,
    );
  }

  /// the id of the item
  final int id;

  /// the name of the item
  final String name;

  /// the currency of the item
  /// TODO : (maybe change it to an enum of currency)
  final String currency;

  /// the price of the item
  final int price;

  /// the color of the item
  final Color color;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Item &&
        other.id == id &&
        other.name == name &&
        other.currency == currency &&
        other.price == price &&
        other.color.value == color.value;
  }

  @override
  String toString() {
    return 'Item{id: $id, name: $name, currency: $currency, price: $price, color: $color}';
  }
}

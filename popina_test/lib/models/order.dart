import 'package:flutter/foundation.dart';
import 'package:popina_test/models/item.dart';

/// this represent the model of the order entity parsed via json.
/// the order entity is the entity that represent the order in the list of orders
/// it can be for exemple this:
///     "object": "order",
///      "id": 217,
///      "table": "4",
///      "guests": 3,
///      "date": "",
///      "items": [
///        ...list of items
///     ],
class Order {
  Order._({
    required this.id,
    required this.table,
    required this.guests,
    required this.date,
    required this.items,
  });

  factory Order.fromjson(Map<String, dynamic> json) {
    List requiredFields = ['id', 'table', 'guests', 'date', "items"];
    if (!requiredFields.every((element) => json.containsKey(element))) {
      throw ArgumentError('the json must contain all the required fields');
    }
    //first we parse the json to get the values of the order
    final int id = json['id'] as int;
    final String table = json['table'] as String;
    final int guests = json['guests'] as int;
    final String strDate = json['date'] as String;

    List<dynamic> items = json['items'] as List<dynamic>;
    List<Item> itemsList = [];
    try {
      itemsList = items.map((e) => Item.fromJson(e)).toList();
    } catch (e) {
      if (kDebugMode) {
        print("error while parsing the items list $e");
      }
      rethrow;
    }

    return Order._(
      id: id,
      table: table,
      guests: guests,
      date: strDate.isNotEmpty ? strDate : null,
      items: itemsList,
    );
  }

  /// the Id of the order
  final int id;

  /// the table number of the order
  /// TODO : (it's a string ?)
  final String table;

  /// the number of guests in the order
  final int guests;

  /// the date of the order (can be empty)
  /// TODO : (since no date is provided in the exemple we can't know the format of the date So I will keep it as a String not a DateTime)
  final String? date;

  /// the list of items in the order
  final List<Item> items;
}

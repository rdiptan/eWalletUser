import 'package:floor/floor.dart';

@entity
class Credit {
  @primaryKey
  final int? id;
  final String? name;
  final String? date;
  final String? amount;

  Credit({this.id, this.name, this.date, this.amount});
}

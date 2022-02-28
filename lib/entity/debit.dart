import 'package:floor/floor.dart';

@entity
class Debit {
  @primaryKey
  final int? id;
  final String? name;
  final String? date;
  final String? amount;

  Debit({this.id, this.name, this.date, this.amount});
}

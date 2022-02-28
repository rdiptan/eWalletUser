import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:e_wallet/dao/debitdao.dart';
import 'package:e_wallet/entity/debit.dart';

part 'debit_database.g.dart';

@Database(version: 1, entities: [Debit])
abstract class AppDatabase extends FloorDatabase {
  DebitDao get debitDao;
}

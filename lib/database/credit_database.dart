import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:e_wallet/dao/creditdao.dart';
import 'package:e_wallet/entity/credit.dart';

part 'credit_database.g.dart';

@Database(version: 1, entities: [Credit])
abstract class AppDatabase extends FloorDatabase {
  CreditDao get creditDao;
}

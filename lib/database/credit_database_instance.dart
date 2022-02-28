import 'package:e_wallet/database/credit_database.dart';

class CreditDatabaseInstance {
  static CreditDatabaseInstance? _instance;

  CreditDatabaseInstance._();
  static CreditDatabaseInstance get instance =>
      _instance ??= CreditDatabaseInstance._();

  Future<AppDatabase> getCreditDatabaseInstance() {
    return $FloorAppDatabase.databaseBuilder('credit_database.db').build();
  }
}

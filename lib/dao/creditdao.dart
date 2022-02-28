import 'package:floor/floor.dart';
import 'package:e_wallet/entity/credit.dart';

@dao
abstract class CreditDao {
  @Query('SELECT * FROM credit')
  Future<List<Credit>> getAllCredit();

  @Query('SELECT * FROM credit WHERE id = :id')
  Future<Credit?> findCreditById(int id);

  @insert
  Future<void> insertCredit(List<Credit> credits);

  @update
  Future<void> updateCredit(Credit credit);

  @Query('DELETE FROM credit')
  Future<void> deleteCredit();
}

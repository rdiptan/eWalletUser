import 'package:floor/floor.dart';
import 'package:e_wallet/entity/debit.dart';

@dao
abstract class DebitDao {
  @Query('SELECT * FROM credit')
  Future<List<Debit>> getAllDebit();

  @Query('SELECT * FROM credit WHERE id = :id')
  Future<Debit?> findDebitById(int id);

  @insert
  Future<void> insertDebit(Debit debit);

  @update
  Future<void> updateDebit(Debit debit);

  @delete
  Future<void> deleteDebit(Debit debit);
}

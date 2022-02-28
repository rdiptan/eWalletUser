// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debit_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  DebitDao? _debitDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Debit` (`id` INTEGER, `name` TEXT, `date` TEXT, `amount` TEXT, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  DebitDao get debitDao {
    return _debitDaoInstance ??= _$DebitDao(database, changeListener);
  }
}

class _$DebitDao extends DebitDao {
  _$DebitDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _debitInsertionAdapter = InsertionAdapter(
            database,
            'Debit',
            (Debit item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'date': item.date,
                  'amount': item.amount
                }),
        _debitUpdateAdapter = UpdateAdapter(
            database,
            'Debit',
            ['id'],
            (Debit item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'date': item.date,
                  'amount': item.amount
                }),
        _debitDeletionAdapter = DeletionAdapter(
            database,
            'Debit',
            ['id'],
            (Debit item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'date': item.date,
                  'amount': item.amount
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Debit> _debitInsertionAdapter;

  final UpdateAdapter<Debit> _debitUpdateAdapter;

  final DeletionAdapter<Debit> _debitDeletionAdapter;

  @override
  Future<List<Debit>> getAllDebit() async {
    return _queryAdapter.queryList('SELECT * FROM credit',
        mapper: (Map<String, Object?> row) => Debit(
            id: row['id'] as int?,
            name: row['name'] as String?,
            date: row['date'] as String?,
            amount: row['amount'] as String?));
  }

  @override
  Future<Debit?> findDebitById(int id) async {
    return _queryAdapter.query('SELECT * FROM credit WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Debit(
            id: row['id'] as int?,
            name: row['name'] as String?,
            date: row['date'] as String?,
            amount: row['amount'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> insertDebit(Debit debit) async {
    await _debitInsertionAdapter.insert(debit, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateDebit(Debit debit) async {
    await _debitUpdateAdapter.update(debit, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteDebit(Debit debit) async {
    await _debitDeletionAdapter.delete(debit);
  }
}

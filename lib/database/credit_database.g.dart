// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_database.dart';

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

  CreditDao? _creditDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `Credit` (`id` INTEGER, `name` TEXT, `date` TEXT, `amount` TEXT, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  CreditDao get creditDao {
    return _creditDaoInstance ??= _$CreditDao(database, changeListener);
  }
}

class _$CreditDao extends CreditDao {
  _$CreditDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _creditInsertionAdapter = InsertionAdapter(
            database,
            'Credit',
            (Credit item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'date': item.date,
                  'amount': item.amount
                }),
        _creditUpdateAdapter = UpdateAdapter(
            database,
            'Credit',
            ['id'],
            (Credit item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'date': item.date,
                  'amount': item.amount
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Credit> _creditInsertionAdapter;

  final UpdateAdapter<Credit> _creditUpdateAdapter;

  @override
  Future<List<Credit>> getAllCredit() async {
    return _queryAdapter.queryList('SELECT * FROM credit',
        mapper: (Map<String, Object?> row) => Credit(
            id: row['id'] as int?,
            name: row['name'] as String?,
            date: row['date'] as String?,
            amount: row['amount'] as String?));
  }

  @override
  Future<Credit?> findCreditById(int id) async {
    return _queryAdapter.query('SELECT * FROM credit WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Credit(
            id: row['id'] as int?,
            name: row['name'] as String?,
            date: row['date'] as String?,
            amount: row['amount'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deleteCredit() async {
    await _queryAdapter.queryNoReturn('DELETE FROM credit');
  }

  @override
  Future<void> insertCredit(List<Credit> credits) async {
    await _creditInsertionAdapter.insertList(credits, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateCredit(Credit credit) async {
    await _creditUpdateAdapter.update(credit, OnConflictStrategy.abort);
  }
}

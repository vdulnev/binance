// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CachedPortfolioTable extends CachedPortfolio
    with TableInfo<$CachedPortfolioTable, CachedPortfolioData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedPortfolioTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _fetchedAtMeta = const VerificationMeta(
    'fetchedAt',
  );
  @override
  late final GeneratedColumn<DateTime> fetchedAt = GeneratedColumn<DateTime>(
    'fetched_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _snapshotJsonMeta = const VerificationMeta(
    'snapshotJson',
  );
  @override
  late final GeneratedColumn<String> snapshotJson = GeneratedColumn<String>(
    'snapshot_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, fetchedAt, snapshotJson];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_portfolio';
  @override
  VerificationContext validateIntegrity(
    Insertable<CachedPortfolioData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('fetched_at')) {
      context.handle(
        _fetchedAtMeta,
        fetchedAt.isAcceptableOrUnknown(data['fetched_at']!, _fetchedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_fetchedAtMeta);
    }
    if (data.containsKey('snapshot_json')) {
      context.handle(
        _snapshotJsonMeta,
        snapshotJson.isAcceptableOrUnknown(
          data['snapshot_json']!,
          _snapshotJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_snapshotJsonMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CachedPortfolioData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedPortfolioData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      fetchedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fetched_at'],
      )!,
      snapshotJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}snapshot_json'],
      )!,
    );
  }

  @override
  $CachedPortfolioTable createAlias(String alias) {
    return $CachedPortfolioTable(attachedDatabase, alias);
  }
}

class CachedPortfolioData extends DataClass
    implements Insertable<CachedPortfolioData> {
  final int id;
  final DateTime fetchedAt;
  final String snapshotJson;
  const CachedPortfolioData({
    required this.id,
    required this.fetchedAt,
    required this.snapshotJson,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['fetched_at'] = Variable<DateTime>(fetchedAt);
    map['snapshot_json'] = Variable<String>(snapshotJson);
    return map;
  }

  CachedPortfolioCompanion toCompanion(bool nullToAbsent) {
    return CachedPortfolioCompanion(
      id: Value(id),
      fetchedAt: Value(fetchedAt),
      snapshotJson: Value(snapshotJson),
    );
  }

  factory CachedPortfolioData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedPortfolioData(
      id: serializer.fromJson<int>(json['id']),
      fetchedAt: serializer.fromJson<DateTime>(json['fetchedAt']),
      snapshotJson: serializer.fromJson<String>(json['snapshotJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'fetchedAt': serializer.toJson<DateTime>(fetchedAt),
      'snapshotJson': serializer.toJson<String>(snapshotJson),
    };
  }

  CachedPortfolioData copyWith({
    int? id,
    DateTime? fetchedAt,
    String? snapshotJson,
  }) => CachedPortfolioData(
    id: id ?? this.id,
    fetchedAt: fetchedAt ?? this.fetchedAt,
    snapshotJson: snapshotJson ?? this.snapshotJson,
  );
  CachedPortfolioData copyWithCompanion(CachedPortfolioCompanion data) {
    return CachedPortfolioData(
      id: data.id.present ? data.id.value : this.id,
      fetchedAt: data.fetchedAt.present ? data.fetchedAt.value : this.fetchedAt,
      snapshotJson: data.snapshotJson.present
          ? data.snapshotJson.value
          : this.snapshotJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedPortfolioData(')
          ..write('id: $id, ')
          ..write('fetchedAt: $fetchedAt, ')
          ..write('snapshotJson: $snapshotJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, fetchedAt, snapshotJson);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedPortfolioData &&
          other.id == this.id &&
          other.fetchedAt == this.fetchedAt &&
          other.snapshotJson == this.snapshotJson);
}

class CachedPortfolioCompanion extends UpdateCompanion<CachedPortfolioData> {
  final Value<int> id;
  final Value<DateTime> fetchedAt;
  final Value<String> snapshotJson;
  const CachedPortfolioCompanion({
    this.id = const Value.absent(),
    this.fetchedAt = const Value.absent(),
    this.snapshotJson = const Value.absent(),
  });
  CachedPortfolioCompanion.insert({
    this.id = const Value.absent(),
    required DateTime fetchedAt,
    required String snapshotJson,
  }) : fetchedAt = Value(fetchedAt),
       snapshotJson = Value(snapshotJson);
  static Insertable<CachedPortfolioData> custom({
    Expression<int>? id,
    Expression<DateTime>? fetchedAt,
    Expression<String>? snapshotJson,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fetchedAt != null) 'fetched_at': fetchedAt,
      if (snapshotJson != null) 'snapshot_json': snapshotJson,
    });
  }

  CachedPortfolioCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? fetchedAt,
    Value<String>? snapshotJson,
  }) {
    return CachedPortfolioCompanion(
      id: id ?? this.id,
      fetchedAt: fetchedAt ?? this.fetchedAt,
      snapshotJson: snapshotJson ?? this.snapshotJson,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (fetchedAt.present) {
      map['fetched_at'] = Variable<DateTime>(fetchedAt.value);
    }
    if (snapshotJson.present) {
      map['snapshot_json'] = Variable<String>(snapshotJson.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedPortfolioCompanion(')
          ..write('id: $id, ')
          ..write('fetchedAt: $fetchedAt, ')
          ..write('snapshotJson: $snapshotJson')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CachedPortfolioTable cachedPortfolio = $CachedPortfolioTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [cachedPortfolio];
}

typedef $$CachedPortfolioTableCreateCompanionBuilder =
    CachedPortfolioCompanion Function({
      Value<int> id,
      required DateTime fetchedAt,
      required String snapshotJson,
    });
typedef $$CachedPortfolioTableUpdateCompanionBuilder =
    CachedPortfolioCompanion Function({
      Value<int> id,
      Value<DateTime> fetchedAt,
      Value<String> snapshotJson,
    });

class $$CachedPortfolioTableFilterComposer
    extends Composer<_$AppDatabase, $CachedPortfolioTable> {
  $$CachedPortfolioTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fetchedAt => $composableBuilder(
    column: $table.fetchedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get snapshotJson => $composableBuilder(
    column: $table.snapshotJson,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CachedPortfolioTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedPortfolioTable> {
  $$CachedPortfolioTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fetchedAt => $composableBuilder(
    column: $table.fetchedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get snapshotJson => $composableBuilder(
    column: $table.snapshotJson,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CachedPortfolioTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedPortfolioTable> {
  $$CachedPortfolioTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get fetchedAt =>
      $composableBuilder(column: $table.fetchedAt, builder: (column) => column);

  GeneratedColumn<String> get snapshotJson => $composableBuilder(
    column: $table.snapshotJson,
    builder: (column) => column,
  );
}

class $$CachedPortfolioTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CachedPortfolioTable,
          CachedPortfolioData,
          $$CachedPortfolioTableFilterComposer,
          $$CachedPortfolioTableOrderingComposer,
          $$CachedPortfolioTableAnnotationComposer,
          $$CachedPortfolioTableCreateCompanionBuilder,
          $$CachedPortfolioTableUpdateCompanionBuilder,
          (
            CachedPortfolioData,
            BaseReferences<
              _$AppDatabase,
              $CachedPortfolioTable,
              CachedPortfolioData
            >,
          ),
          CachedPortfolioData,
          PrefetchHooks Function()
        > {
  $$CachedPortfolioTableTableManager(
    _$AppDatabase db,
    $CachedPortfolioTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedPortfolioTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedPortfolioTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedPortfolioTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> fetchedAt = const Value.absent(),
                Value<String> snapshotJson = const Value.absent(),
              }) => CachedPortfolioCompanion(
                id: id,
                fetchedAt: fetchedAt,
                snapshotJson: snapshotJson,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime fetchedAt,
                required String snapshotJson,
              }) => CachedPortfolioCompanion.insert(
                id: id,
                fetchedAt: fetchedAt,
                snapshotJson: snapshotJson,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CachedPortfolioTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CachedPortfolioTable,
      CachedPortfolioData,
      $$CachedPortfolioTableFilterComposer,
      $$CachedPortfolioTableOrderingComposer,
      $$CachedPortfolioTableAnnotationComposer,
      $$CachedPortfolioTableCreateCompanionBuilder,
      $$CachedPortfolioTableUpdateCompanionBuilder,
      (
        CachedPortfolioData,
        BaseReferences<
          _$AppDatabase,
          $CachedPortfolioTable,
          CachedPortfolioData
        >,
      ),
      CachedPortfolioData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CachedPortfolioTableTableManager get cachedPortfolio =>
      $$CachedPortfolioTableTableManager(_db, _db.cachedPortfolio);
}

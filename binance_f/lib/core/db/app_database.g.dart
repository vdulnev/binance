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

class $FavoritesTable extends Favorites
    with TableInfo<$FavoritesTable, Favorite> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoritesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _symbolMeta = const VerificationMeta('symbol');
  @override
  late final GeneratedColumn<String> symbol = GeneratedColumn<String>(
    'symbol',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _marketMeta = const VerificationMeta('market');
  @override
  late final GeneratedColumn<String> market = GeneratedColumn<String>(
    'market',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [symbol, market, position];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'favorites';
  @override
  VerificationContext validateIntegrity(
    Insertable<Favorite> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('symbol')) {
      context.handle(
        _symbolMeta,
        symbol.isAcceptableOrUnknown(data['symbol']!, _symbolMeta),
      );
    } else if (isInserting) {
      context.missing(_symbolMeta);
    }
    if (data.containsKey('market')) {
      context.handle(
        _marketMeta,
        market.isAcceptableOrUnknown(data['market']!, _marketMeta),
      );
    } else if (isInserting) {
      context.missing(_marketMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {symbol, market};
  @override
  Favorite map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Favorite(
      symbol: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}symbol'],
      )!,
      market: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}market'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
    );
  }

  @override
  $FavoritesTable createAlias(String alias) {
    return $FavoritesTable(attachedDatabase, alias);
  }
}

class Favorite extends DataClass implements Insertable<Favorite> {
  final String symbol;
  final String market;
  final int position;
  const Favorite({
    required this.symbol,
    required this.market,
    required this.position,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['symbol'] = Variable<String>(symbol);
    map['market'] = Variable<String>(market);
    map['position'] = Variable<int>(position);
    return map;
  }

  FavoritesCompanion toCompanion(bool nullToAbsent) {
    return FavoritesCompanion(
      symbol: Value(symbol),
      market: Value(market),
      position: Value(position),
    );
  }

  factory Favorite.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Favorite(
      symbol: serializer.fromJson<String>(json['symbol']),
      market: serializer.fromJson<String>(json['market']),
      position: serializer.fromJson<int>(json['position']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'symbol': serializer.toJson<String>(symbol),
      'market': serializer.toJson<String>(market),
      'position': serializer.toJson<int>(position),
    };
  }

  Favorite copyWith({String? symbol, String? market, int? position}) =>
      Favorite(
        symbol: symbol ?? this.symbol,
        market: market ?? this.market,
        position: position ?? this.position,
      );
  Favorite copyWithCompanion(FavoritesCompanion data) {
    return Favorite(
      symbol: data.symbol.present ? data.symbol.value : this.symbol,
      market: data.market.present ? data.market.value : this.market,
      position: data.position.present ? data.position.value : this.position,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Favorite(')
          ..write('symbol: $symbol, ')
          ..write('market: $market, ')
          ..write('position: $position')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(symbol, market, position);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Favorite &&
          other.symbol == this.symbol &&
          other.market == this.market &&
          other.position == this.position);
}

class FavoritesCompanion extends UpdateCompanion<Favorite> {
  final Value<String> symbol;
  final Value<String> market;
  final Value<int> position;
  final Value<int> rowid;
  const FavoritesCompanion({
    this.symbol = const Value.absent(),
    this.market = const Value.absent(),
    this.position = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FavoritesCompanion.insert({
    required String symbol,
    required String market,
    required int position,
    this.rowid = const Value.absent(),
  }) : symbol = Value(symbol),
       market = Value(market),
       position = Value(position);
  static Insertable<Favorite> custom({
    Expression<String>? symbol,
    Expression<String>? market,
    Expression<int>? position,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (symbol != null) 'symbol': symbol,
      if (market != null) 'market': market,
      if (position != null) 'position': position,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FavoritesCompanion copyWith({
    Value<String>? symbol,
    Value<String>? market,
    Value<int>? position,
    Value<int>? rowid,
  }) {
    return FavoritesCompanion(
      symbol: symbol ?? this.symbol,
      market: market ?? this.market,
      position: position ?? this.position,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (symbol.present) {
      map['symbol'] = Variable<String>(symbol.value);
    }
    if (market.present) {
      map['market'] = Variable<String>(market.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoritesCompanion(')
          ..write('symbol: $symbol, ')
          ..write('market: $market, ')
          ..write('position: $position, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CachedSymbolsTable extends CachedSymbols
    with TableInfo<$CachedSymbolsTable, CachedSymbol> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedSymbolsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _symbolMeta = const VerificationMeta('symbol');
  @override
  late final GeneratedColumn<String> symbol = GeneratedColumn<String>(
    'symbol',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _marketMeta = const VerificationMeta('market');
  @override
  late final GeneratedColumn<String> market = GeneratedColumn<String>(
    'market',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _baseAssetMeta = const VerificationMeta(
    'baseAsset',
  );
  @override
  late final GeneratedColumn<String> baseAsset = GeneratedColumn<String>(
    'base_asset',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quoteAssetMeta = const VerificationMeta(
    'quoteAsset',
  );
  @override
  late final GeneratedColumn<String> quoteAsset = GeneratedColumn<String>(
    'quote_asset',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _filtersJsonMeta = const VerificationMeta(
    'filtersJson',
  );
  @override
  late final GeneratedColumn<String> filtersJson = GeneratedColumn<String>(
    'filters_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    symbol,
    market,
    baseAsset,
    quoteAsset,
    status,
    filtersJson,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_symbols';
  @override
  VerificationContext validateIntegrity(
    Insertable<CachedSymbol> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('symbol')) {
      context.handle(
        _symbolMeta,
        symbol.isAcceptableOrUnknown(data['symbol']!, _symbolMeta),
      );
    } else if (isInserting) {
      context.missing(_symbolMeta);
    }
    if (data.containsKey('market')) {
      context.handle(
        _marketMeta,
        market.isAcceptableOrUnknown(data['market']!, _marketMeta),
      );
    } else if (isInserting) {
      context.missing(_marketMeta);
    }
    if (data.containsKey('base_asset')) {
      context.handle(
        _baseAssetMeta,
        baseAsset.isAcceptableOrUnknown(data['base_asset']!, _baseAssetMeta),
      );
    } else if (isInserting) {
      context.missing(_baseAssetMeta);
    }
    if (data.containsKey('quote_asset')) {
      context.handle(
        _quoteAssetMeta,
        quoteAsset.isAcceptableOrUnknown(data['quote_asset']!, _quoteAssetMeta),
      );
    } else if (isInserting) {
      context.missing(_quoteAssetMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('filters_json')) {
      context.handle(
        _filtersJsonMeta,
        filtersJson.isAcceptableOrUnknown(
          data['filters_json']!,
          _filtersJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_filtersJsonMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {symbol, market};
  @override
  CachedSymbol map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedSymbol(
      symbol: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}symbol'],
      )!,
      market: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}market'],
      )!,
      baseAsset: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}base_asset'],
      )!,
      quoteAsset: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}quote_asset'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      filtersJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}filters_json'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $CachedSymbolsTable createAlias(String alias) {
    return $CachedSymbolsTable(attachedDatabase, alias);
  }
}

class CachedSymbol extends DataClass implements Insertable<CachedSymbol> {
  final String symbol;
  final String market;
  final String baseAsset;
  final String quoteAsset;
  final String status;
  final String filtersJson;
  final DateTime updatedAt;
  const CachedSymbol({
    required this.symbol,
    required this.market,
    required this.baseAsset,
    required this.quoteAsset,
    required this.status,
    required this.filtersJson,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['symbol'] = Variable<String>(symbol);
    map['market'] = Variable<String>(market);
    map['base_asset'] = Variable<String>(baseAsset);
    map['quote_asset'] = Variable<String>(quoteAsset);
    map['status'] = Variable<String>(status);
    map['filters_json'] = Variable<String>(filtersJson);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CachedSymbolsCompanion toCompanion(bool nullToAbsent) {
    return CachedSymbolsCompanion(
      symbol: Value(symbol),
      market: Value(market),
      baseAsset: Value(baseAsset),
      quoteAsset: Value(quoteAsset),
      status: Value(status),
      filtersJson: Value(filtersJson),
      updatedAt: Value(updatedAt),
    );
  }

  factory CachedSymbol.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedSymbol(
      symbol: serializer.fromJson<String>(json['symbol']),
      market: serializer.fromJson<String>(json['market']),
      baseAsset: serializer.fromJson<String>(json['baseAsset']),
      quoteAsset: serializer.fromJson<String>(json['quoteAsset']),
      status: serializer.fromJson<String>(json['status']),
      filtersJson: serializer.fromJson<String>(json['filtersJson']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'symbol': serializer.toJson<String>(symbol),
      'market': serializer.toJson<String>(market),
      'baseAsset': serializer.toJson<String>(baseAsset),
      'quoteAsset': serializer.toJson<String>(quoteAsset),
      'status': serializer.toJson<String>(status),
      'filtersJson': serializer.toJson<String>(filtersJson),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CachedSymbol copyWith({
    String? symbol,
    String? market,
    String? baseAsset,
    String? quoteAsset,
    String? status,
    String? filtersJson,
    DateTime? updatedAt,
  }) => CachedSymbol(
    symbol: symbol ?? this.symbol,
    market: market ?? this.market,
    baseAsset: baseAsset ?? this.baseAsset,
    quoteAsset: quoteAsset ?? this.quoteAsset,
    status: status ?? this.status,
    filtersJson: filtersJson ?? this.filtersJson,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  CachedSymbol copyWithCompanion(CachedSymbolsCompanion data) {
    return CachedSymbol(
      symbol: data.symbol.present ? data.symbol.value : this.symbol,
      market: data.market.present ? data.market.value : this.market,
      baseAsset: data.baseAsset.present ? data.baseAsset.value : this.baseAsset,
      quoteAsset: data.quoteAsset.present
          ? data.quoteAsset.value
          : this.quoteAsset,
      status: data.status.present ? data.status.value : this.status,
      filtersJson: data.filtersJson.present
          ? data.filtersJson.value
          : this.filtersJson,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedSymbol(')
          ..write('symbol: $symbol, ')
          ..write('market: $market, ')
          ..write('baseAsset: $baseAsset, ')
          ..write('quoteAsset: $quoteAsset, ')
          ..write('status: $status, ')
          ..write('filtersJson: $filtersJson, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    symbol,
    market,
    baseAsset,
    quoteAsset,
    status,
    filtersJson,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedSymbol &&
          other.symbol == this.symbol &&
          other.market == this.market &&
          other.baseAsset == this.baseAsset &&
          other.quoteAsset == this.quoteAsset &&
          other.status == this.status &&
          other.filtersJson == this.filtersJson &&
          other.updatedAt == this.updatedAt);
}

class CachedSymbolsCompanion extends UpdateCompanion<CachedSymbol> {
  final Value<String> symbol;
  final Value<String> market;
  final Value<String> baseAsset;
  final Value<String> quoteAsset;
  final Value<String> status;
  final Value<String> filtersJson;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const CachedSymbolsCompanion({
    this.symbol = const Value.absent(),
    this.market = const Value.absent(),
    this.baseAsset = const Value.absent(),
    this.quoteAsset = const Value.absent(),
    this.status = const Value.absent(),
    this.filtersJson = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedSymbolsCompanion.insert({
    required String symbol,
    required String market,
    required String baseAsset,
    required String quoteAsset,
    required String status,
    required String filtersJson,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : symbol = Value(symbol),
       market = Value(market),
       baseAsset = Value(baseAsset),
       quoteAsset = Value(quoteAsset),
       status = Value(status),
       filtersJson = Value(filtersJson),
       updatedAt = Value(updatedAt);
  static Insertable<CachedSymbol> custom({
    Expression<String>? symbol,
    Expression<String>? market,
    Expression<String>? baseAsset,
    Expression<String>? quoteAsset,
    Expression<String>? status,
    Expression<String>? filtersJson,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (symbol != null) 'symbol': symbol,
      if (market != null) 'market': market,
      if (baseAsset != null) 'base_asset': baseAsset,
      if (quoteAsset != null) 'quote_asset': quoteAsset,
      if (status != null) 'status': status,
      if (filtersJson != null) 'filters_json': filtersJson,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedSymbolsCompanion copyWith({
    Value<String>? symbol,
    Value<String>? market,
    Value<String>? baseAsset,
    Value<String>? quoteAsset,
    Value<String>? status,
    Value<String>? filtersJson,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return CachedSymbolsCompanion(
      symbol: symbol ?? this.symbol,
      market: market ?? this.market,
      baseAsset: baseAsset ?? this.baseAsset,
      quoteAsset: quoteAsset ?? this.quoteAsset,
      status: status ?? this.status,
      filtersJson: filtersJson ?? this.filtersJson,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (symbol.present) {
      map['symbol'] = Variable<String>(symbol.value);
    }
    if (market.present) {
      map['market'] = Variable<String>(market.value);
    }
    if (baseAsset.present) {
      map['base_asset'] = Variable<String>(baseAsset.value);
    }
    if (quoteAsset.present) {
      map['quote_asset'] = Variable<String>(quoteAsset.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (filtersJson.present) {
      map['filters_json'] = Variable<String>(filtersJson.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedSymbolsCompanion(')
          ..write('symbol: $symbol, ')
          ..write('market: $market, ')
          ..write('baseAsset: $baseAsset, ')
          ..write('quoteAsset: $quoteAsset, ')
          ..write('status: $status, ')
          ..write('filtersJson: $filtersJson, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CachedOrdersTable extends CachedOrders
    with TableInfo<$CachedOrdersTable, CachedOrder> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedOrdersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _orderIdMeta = const VerificationMeta(
    'orderId',
  );
  @override
  late final GeneratedColumn<int> orderId = GeneratedColumn<int>(
    'order_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _symbolMeta = const VerificationMeta('symbol');
  @override
  late final GeneratedColumn<String> symbol = GeneratedColumn<String>(
    'symbol',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _marketMeta = const VerificationMeta('market');
  @override
  late final GeneratedColumn<String> market = GeneratedColumn<String>(
    'market',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _orderJsonMeta = const VerificationMeta(
    'orderJson',
  );
  @override
  late final GeneratedColumn<String> orderJson = GeneratedColumn<String>(
    'order_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _orderTimeMeta = const VerificationMeta(
    'orderTime',
  );
  @override
  late final GeneratedColumn<int> orderTime = GeneratedColumn<int>(
    'order_time',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
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
  @override
  List<GeneratedColumn> get $columns => [
    orderId,
    symbol,
    market,
    orderJson,
    orderTime,
    fetchedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_orders';
  @override
  VerificationContext validateIntegrity(
    Insertable<CachedOrder> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('order_id')) {
      context.handle(
        _orderIdMeta,
        orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta),
      );
    } else if (isInserting) {
      context.missing(_orderIdMeta);
    }
    if (data.containsKey('symbol')) {
      context.handle(
        _symbolMeta,
        symbol.isAcceptableOrUnknown(data['symbol']!, _symbolMeta),
      );
    } else if (isInserting) {
      context.missing(_symbolMeta);
    }
    if (data.containsKey('market')) {
      context.handle(
        _marketMeta,
        market.isAcceptableOrUnknown(data['market']!, _marketMeta),
      );
    } else if (isInserting) {
      context.missing(_marketMeta);
    }
    if (data.containsKey('order_json')) {
      context.handle(
        _orderJsonMeta,
        orderJson.isAcceptableOrUnknown(data['order_json']!, _orderJsonMeta),
      );
    } else if (isInserting) {
      context.missing(_orderJsonMeta);
    }
    if (data.containsKey('order_time')) {
      context.handle(
        _orderTimeMeta,
        orderTime.isAcceptableOrUnknown(data['order_time']!, _orderTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_orderTimeMeta);
    }
    if (data.containsKey('fetched_at')) {
      context.handle(
        _fetchedAtMeta,
        fetchedAt.isAcceptableOrUnknown(data['fetched_at']!, _fetchedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_fetchedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {orderId, market};
  @override
  CachedOrder map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedOrder(
      orderId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order_id'],
      )!,
      symbol: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}symbol'],
      )!,
      market: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}market'],
      )!,
      orderJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}order_json'],
      )!,
      orderTime: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order_time'],
      )!,
      fetchedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fetched_at'],
      )!,
    );
  }

  @override
  $CachedOrdersTable createAlias(String alias) {
    return $CachedOrdersTable(attachedDatabase, alias);
  }
}

class CachedOrder extends DataClass implements Insertable<CachedOrder> {
  final int orderId;
  final String symbol;
  final String market;
  final String orderJson;

  /// Order creation time in ms since epoch — used for date filtering.
  final int orderTime;
  final DateTime fetchedAt;
  const CachedOrder({
    required this.orderId,
    required this.symbol,
    required this.market,
    required this.orderJson,
    required this.orderTime,
    required this.fetchedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['order_id'] = Variable<int>(orderId);
    map['symbol'] = Variable<String>(symbol);
    map['market'] = Variable<String>(market);
    map['order_json'] = Variable<String>(orderJson);
    map['order_time'] = Variable<int>(orderTime);
    map['fetched_at'] = Variable<DateTime>(fetchedAt);
    return map;
  }

  CachedOrdersCompanion toCompanion(bool nullToAbsent) {
    return CachedOrdersCompanion(
      orderId: Value(orderId),
      symbol: Value(symbol),
      market: Value(market),
      orderJson: Value(orderJson),
      orderTime: Value(orderTime),
      fetchedAt: Value(fetchedAt),
    );
  }

  factory CachedOrder.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedOrder(
      orderId: serializer.fromJson<int>(json['orderId']),
      symbol: serializer.fromJson<String>(json['symbol']),
      market: serializer.fromJson<String>(json['market']),
      orderJson: serializer.fromJson<String>(json['orderJson']),
      orderTime: serializer.fromJson<int>(json['orderTime']),
      fetchedAt: serializer.fromJson<DateTime>(json['fetchedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'orderId': serializer.toJson<int>(orderId),
      'symbol': serializer.toJson<String>(symbol),
      'market': serializer.toJson<String>(market),
      'orderJson': serializer.toJson<String>(orderJson),
      'orderTime': serializer.toJson<int>(orderTime),
      'fetchedAt': serializer.toJson<DateTime>(fetchedAt),
    };
  }

  CachedOrder copyWith({
    int? orderId,
    String? symbol,
    String? market,
    String? orderJson,
    int? orderTime,
    DateTime? fetchedAt,
  }) => CachedOrder(
    orderId: orderId ?? this.orderId,
    symbol: symbol ?? this.symbol,
    market: market ?? this.market,
    orderJson: orderJson ?? this.orderJson,
    orderTime: orderTime ?? this.orderTime,
    fetchedAt: fetchedAt ?? this.fetchedAt,
  );
  CachedOrder copyWithCompanion(CachedOrdersCompanion data) {
    return CachedOrder(
      orderId: data.orderId.present ? data.orderId.value : this.orderId,
      symbol: data.symbol.present ? data.symbol.value : this.symbol,
      market: data.market.present ? data.market.value : this.market,
      orderJson: data.orderJson.present ? data.orderJson.value : this.orderJson,
      orderTime: data.orderTime.present ? data.orderTime.value : this.orderTime,
      fetchedAt: data.fetchedAt.present ? data.fetchedAt.value : this.fetchedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedOrder(')
          ..write('orderId: $orderId, ')
          ..write('symbol: $symbol, ')
          ..write('market: $market, ')
          ..write('orderJson: $orderJson, ')
          ..write('orderTime: $orderTime, ')
          ..write('fetchedAt: $fetchedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(orderId, symbol, market, orderJson, orderTime, fetchedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedOrder &&
          other.orderId == this.orderId &&
          other.symbol == this.symbol &&
          other.market == this.market &&
          other.orderJson == this.orderJson &&
          other.orderTime == this.orderTime &&
          other.fetchedAt == this.fetchedAt);
}

class CachedOrdersCompanion extends UpdateCompanion<CachedOrder> {
  final Value<int> orderId;
  final Value<String> symbol;
  final Value<String> market;
  final Value<String> orderJson;
  final Value<int> orderTime;
  final Value<DateTime> fetchedAt;
  final Value<int> rowid;
  const CachedOrdersCompanion({
    this.orderId = const Value.absent(),
    this.symbol = const Value.absent(),
    this.market = const Value.absent(),
    this.orderJson = const Value.absent(),
    this.orderTime = const Value.absent(),
    this.fetchedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedOrdersCompanion.insert({
    required int orderId,
    required String symbol,
    required String market,
    required String orderJson,
    required int orderTime,
    required DateTime fetchedAt,
    this.rowid = const Value.absent(),
  }) : orderId = Value(orderId),
       symbol = Value(symbol),
       market = Value(market),
       orderJson = Value(orderJson),
       orderTime = Value(orderTime),
       fetchedAt = Value(fetchedAt);
  static Insertable<CachedOrder> custom({
    Expression<int>? orderId,
    Expression<String>? symbol,
    Expression<String>? market,
    Expression<String>? orderJson,
    Expression<int>? orderTime,
    Expression<DateTime>? fetchedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (orderId != null) 'order_id': orderId,
      if (symbol != null) 'symbol': symbol,
      if (market != null) 'market': market,
      if (orderJson != null) 'order_json': orderJson,
      if (orderTime != null) 'order_time': orderTime,
      if (fetchedAt != null) 'fetched_at': fetchedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedOrdersCompanion copyWith({
    Value<int>? orderId,
    Value<String>? symbol,
    Value<String>? market,
    Value<String>? orderJson,
    Value<int>? orderTime,
    Value<DateTime>? fetchedAt,
    Value<int>? rowid,
  }) {
    return CachedOrdersCompanion(
      orderId: orderId ?? this.orderId,
      symbol: symbol ?? this.symbol,
      market: market ?? this.market,
      orderJson: orderJson ?? this.orderJson,
      orderTime: orderTime ?? this.orderTime,
      fetchedAt: fetchedAt ?? this.fetchedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (orderId.present) {
      map['order_id'] = Variable<int>(orderId.value);
    }
    if (symbol.present) {
      map['symbol'] = Variable<String>(symbol.value);
    }
    if (market.present) {
      map['market'] = Variable<String>(market.value);
    }
    if (orderJson.present) {
      map['order_json'] = Variable<String>(orderJson.value);
    }
    if (orderTime.present) {
      map['order_time'] = Variable<int>(orderTime.value);
    }
    if (fetchedAt.present) {
      map['fetched_at'] = Variable<DateTime>(fetchedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedOrdersCompanion(')
          ..write('orderId: $orderId, ')
          ..write('symbol: $symbol, ')
          ..write('market: $market, ')
          ..write('orderJson: $orderJson, ')
          ..write('orderTime: $orderTime, ')
          ..write('fetchedAt: $fetchedAt, ')
          ..write('rowid: $rowid')
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
  late final $FavoritesTable favorites = $FavoritesTable(this);
  late final $CachedSymbolsTable cachedSymbols = $CachedSymbolsTable(this);
  late final $CachedOrdersTable cachedOrders = $CachedOrdersTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    cachedPortfolio,
    favorites,
    cachedSymbols,
    cachedOrders,
  ];
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
typedef $$FavoritesTableCreateCompanionBuilder =
    FavoritesCompanion Function({
      required String symbol,
      required String market,
      required int position,
      Value<int> rowid,
    });
typedef $$FavoritesTableUpdateCompanionBuilder =
    FavoritesCompanion Function({
      Value<String> symbol,
      Value<String> market,
      Value<int> position,
      Value<int> rowid,
    });

class $$FavoritesTableFilterComposer
    extends Composer<_$AppDatabase, $FavoritesTable> {
  $$FavoritesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get symbol => $composableBuilder(
    column: $table.symbol,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get market => $composableBuilder(
    column: $table.market,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FavoritesTableOrderingComposer
    extends Composer<_$AppDatabase, $FavoritesTable> {
  $$FavoritesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get symbol => $composableBuilder(
    column: $table.symbol,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get market => $composableBuilder(
    column: $table.market,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FavoritesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FavoritesTable> {
  $$FavoritesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get symbol =>
      $composableBuilder(column: $table.symbol, builder: (column) => column);

  GeneratedColumn<String> get market =>
      $composableBuilder(column: $table.market, builder: (column) => column);

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);
}

class $$FavoritesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FavoritesTable,
          Favorite,
          $$FavoritesTableFilterComposer,
          $$FavoritesTableOrderingComposer,
          $$FavoritesTableAnnotationComposer,
          $$FavoritesTableCreateCompanionBuilder,
          $$FavoritesTableUpdateCompanionBuilder,
          (Favorite, BaseReferences<_$AppDatabase, $FavoritesTable, Favorite>),
          Favorite,
          PrefetchHooks Function()
        > {
  $$FavoritesTableTableManager(_$AppDatabase db, $FavoritesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FavoritesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FavoritesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FavoritesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> symbol = const Value.absent(),
                Value<String> market = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FavoritesCompanion(
                symbol: symbol,
                market: market,
                position: position,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String symbol,
                required String market,
                required int position,
                Value<int> rowid = const Value.absent(),
              }) => FavoritesCompanion.insert(
                symbol: symbol,
                market: market,
                position: position,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FavoritesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FavoritesTable,
      Favorite,
      $$FavoritesTableFilterComposer,
      $$FavoritesTableOrderingComposer,
      $$FavoritesTableAnnotationComposer,
      $$FavoritesTableCreateCompanionBuilder,
      $$FavoritesTableUpdateCompanionBuilder,
      (Favorite, BaseReferences<_$AppDatabase, $FavoritesTable, Favorite>),
      Favorite,
      PrefetchHooks Function()
    >;
typedef $$CachedSymbolsTableCreateCompanionBuilder =
    CachedSymbolsCompanion Function({
      required String symbol,
      required String market,
      required String baseAsset,
      required String quoteAsset,
      required String status,
      required String filtersJson,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$CachedSymbolsTableUpdateCompanionBuilder =
    CachedSymbolsCompanion Function({
      Value<String> symbol,
      Value<String> market,
      Value<String> baseAsset,
      Value<String> quoteAsset,
      Value<String> status,
      Value<String> filtersJson,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$CachedSymbolsTableFilterComposer
    extends Composer<_$AppDatabase, $CachedSymbolsTable> {
  $$CachedSymbolsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get symbol => $composableBuilder(
    column: $table.symbol,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get market => $composableBuilder(
    column: $table.market,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get baseAsset => $composableBuilder(
    column: $table.baseAsset,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get quoteAsset => $composableBuilder(
    column: $table.quoteAsset,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get filtersJson => $composableBuilder(
    column: $table.filtersJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CachedSymbolsTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedSymbolsTable> {
  $$CachedSymbolsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get symbol => $composableBuilder(
    column: $table.symbol,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get market => $composableBuilder(
    column: $table.market,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get baseAsset => $composableBuilder(
    column: $table.baseAsset,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get quoteAsset => $composableBuilder(
    column: $table.quoteAsset,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get filtersJson => $composableBuilder(
    column: $table.filtersJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CachedSymbolsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedSymbolsTable> {
  $$CachedSymbolsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get symbol =>
      $composableBuilder(column: $table.symbol, builder: (column) => column);

  GeneratedColumn<String> get market =>
      $composableBuilder(column: $table.market, builder: (column) => column);

  GeneratedColumn<String> get baseAsset =>
      $composableBuilder(column: $table.baseAsset, builder: (column) => column);

  GeneratedColumn<String> get quoteAsset => $composableBuilder(
    column: $table.quoteAsset,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get filtersJson => $composableBuilder(
    column: $table.filtersJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$CachedSymbolsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CachedSymbolsTable,
          CachedSymbol,
          $$CachedSymbolsTableFilterComposer,
          $$CachedSymbolsTableOrderingComposer,
          $$CachedSymbolsTableAnnotationComposer,
          $$CachedSymbolsTableCreateCompanionBuilder,
          $$CachedSymbolsTableUpdateCompanionBuilder,
          (
            CachedSymbol,
            BaseReferences<_$AppDatabase, $CachedSymbolsTable, CachedSymbol>,
          ),
          CachedSymbol,
          PrefetchHooks Function()
        > {
  $$CachedSymbolsTableTableManager(_$AppDatabase db, $CachedSymbolsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedSymbolsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedSymbolsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedSymbolsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> symbol = const Value.absent(),
                Value<String> market = const Value.absent(),
                Value<String> baseAsset = const Value.absent(),
                Value<String> quoteAsset = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> filtersJson = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedSymbolsCompanion(
                symbol: symbol,
                market: market,
                baseAsset: baseAsset,
                quoteAsset: quoteAsset,
                status: status,
                filtersJson: filtersJson,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String symbol,
                required String market,
                required String baseAsset,
                required String quoteAsset,
                required String status,
                required String filtersJson,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => CachedSymbolsCompanion.insert(
                symbol: symbol,
                market: market,
                baseAsset: baseAsset,
                quoteAsset: quoteAsset,
                status: status,
                filtersJson: filtersJson,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CachedSymbolsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CachedSymbolsTable,
      CachedSymbol,
      $$CachedSymbolsTableFilterComposer,
      $$CachedSymbolsTableOrderingComposer,
      $$CachedSymbolsTableAnnotationComposer,
      $$CachedSymbolsTableCreateCompanionBuilder,
      $$CachedSymbolsTableUpdateCompanionBuilder,
      (
        CachedSymbol,
        BaseReferences<_$AppDatabase, $CachedSymbolsTable, CachedSymbol>,
      ),
      CachedSymbol,
      PrefetchHooks Function()
    >;
typedef $$CachedOrdersTableCreateCompanionBuilder =
    CachedOrdersCompanion Function({
      required int orderId,
      required String symbol,
      required String market,
      required String orderJson,
      required int orderTime,
      required DateTime fetchedAt,
      Value<int> rowid,
    });
typedef $$CachedOrdersTableUpdateCompanionBuilder =
    CachedOrdersCompanion Function({
      Value<int> orderId,
      Value<String> symbol,
      Value<String> market,
      Value<String> orderJson,
      Value<int> orderTime,
      Value<DateTime> fetchedAt,
      Value<int> rowid,
    });

class $$CachedOrdersTableFilterComposer
    extends Composer<_$AppDatabase, $CachedOrdersTable> {
  $$CachedOrdersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get orderId => $composableBuilder(
    column: $table.orderId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get symbol => $composableBuilder(
    column: $table.symbol,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get market => $composableBuilder(
    column: $table.market,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get orderJson => $composableBuilder(
    column: $table.orderJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get orderTime => $composableBuilder(
    column: $table.orderTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fetchedAt => $composableBuilder(
    column: $table.fetchedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CachedOrdersTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedOrdersTable> {
  $$CachedOrdersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get orderId => $composableBuilder(
    column: $table.orderId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get symbol => $composableBuilder(
    column: $table.symbol,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get market => $composableBuilder(
    column: $table.market,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get orderJson => $composableBuilder(
    column: $table.orderJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get orderTime => $composableBuilder(
    column: $table.orderTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fetchedAt => $composableBuilder(
    column: $table.fetchedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CachedOrdersTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedOrdersTable> {
  $$CachedOrdersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get orderId =>
      $composableBuilder(column: $table.orderId, builder: (column) => column);

  GeneratedColumn<String> get symbol =>
      $composableBuilder(column: $table.symbol, builder: (column) => column);

  GeneratedColumn<String> get market =>
      $composableBuilder(column: $table.market, builder: (column) => column);

  GeneratedColumn<String> get orderJson =>
      $composableBuilder(column: $table.orderJson, builder: (column) => column);

  GeneratedColumn<int> get orderTime =>
      $composableBuilder(column: $table.orderTime, builder: (column) => column);

  GeneratedColumn<DateTime> get fetchedAt =>
      $composableBuilder(column: $table.fetchedAt, builder: (column) => column);
}

class $$CachedOrdersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CachedOrdersTable,
          CachedOrder,
          $$CachedOrdersTableFilterComposer,
          $$CachedOrdersTableOrderingComposer,
          $$CachedOrdersTableAnnotationComposer,
          $$CachedOrdersTableCreateCompanionBuilder,
          $$CachedOrdersTableUpdateCompanionBuilder,
          (
            CachedOrder,
            BaseReferences<_$AppDatabase, $CachedOrdersTable, CachedOrder>,
          ),
          CachedOrder,
          PrefetchHooks Function()
        > {
  $$CachedOrdersTableTableManager(_$AppDatabase db, $CachedOrdersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedOrdersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedOrdersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedOrdersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> orderId = const Value.absent(),
                Value<String> symbol = const Value.absent(),
                Value<String> market = const Value.absent(),
                Value<String> orderJson = const Value.absent(),
                Value<int> orderTime = const Value.absent(),
                Value<DateTime> fetchedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedOrdersCompanion(
                orderId: orderId,
                symbol: symbol,
                market: market,
                orderJson: orderJson,
                orderTime: orderTime,
                fetchedAt: fetchedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int orderId,
                required String symbol,
                required String market,
                required String orderJson,
                required int orderTime,
                required DateTime fetchedAt,
                Value<int> rowid = const Value.absent(),
              }) => CachedOrdersCompanion.insert(
                orderId: orderId,
                symbol: symbol,
                market: market,
                orderJson: orderJson,
                orderTime: orderTime,
                fetchedAt: fetchedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CachedOrdersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CachedOrdersTable,
      CachedOrder,
      $$CachedOrdersTableFilterComposer,
      $$CachedOrdersTableOrderingComposer,
      $$CachedOrdersTableAnnotationComposer,
      $$CachedOrdersTableCreateCompanionBuilder,
      $$CachedOrdersTableUpdateCompanionBuilder,
      (
        CachedOrder,
        BaseReferences<_$AppDatabase, $CachedOrdersTable, CachedOrder>,
      ),
      CachedOrder,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CachedPortfolioTableTableManager get cachedPortfolio =>
      $$CachedPortfolioTableTableManager(_db, _db.cachedPortfolio);
  $$FavoritesTableTableManager get favorites =>
      $$FavoritesTableTableManager(_db, _db.favorites);
  $$CachedSymbolsTableTableManager get cachedSymbols =>
      $$CachedSymbolsTableTableManager(_db, _db.cachedSymbols);
  $$CachedOrdersTableTableManager get cachedOrders =>
      $$CachedOrdersTableTableManager(_db, _db.cachedOrders);
}

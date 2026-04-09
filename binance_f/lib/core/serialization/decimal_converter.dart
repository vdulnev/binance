import 'package:decimal/decimal.dart';
import 'package:json_annotation/json_annotation.dart';

/// Converts between Binance's string-encoded numerics and [Decimal].
///
/// Binance always returns financial amounts (prices, quantities, balances)
/// as strings so decimal precision is preserved. Never parse them through
/// `double` — use [Decimal] end to end.
///
/// Accepts `String`, `num`, or `null` on the JSON side. Emits canonical
/// [Decimal.toString] on the way out.
class DecimalConverter implements JsonConverter<Decimal, Object> {
  const DecimalConverter();

  @override
  Decimal fromJson(Object json) {
    if (json is String) return Decimal.parse(json);
    if (json is int) return Decimal.fromInt(json);
    if (json is num) return Decimal.parse(json.toString());
    throw FormatException(
      'DecimalConverter: unsupported JSON type ${json.runtimeType}',
    );
  }

  @override
  Object toJson(Decimal object) => object.toString();
}

/// Nullable variant of [DecimalConverter]. Use on fields that Binance may
/// omit (e.g. `liquidationPrice` on a closed position).
class NullableDecimalConverter implements JsonConverter<Decimal?, Object?> {
  const NullableDecimalConverter();

  @override
  Decimal? fromJson(Object? json) {
    if (json == null) return null;
    if (json is String) {
      if (json.isEmpty) return null;
      return Decimal.parse(json);
    }
    if (json is int) return Decimal.fromInt(json);
    if (json is num) return Decimal.parse(json.toString());
    throw FormatException(
      'NullableDecimalConverter: unsupported JSON type ${json.runtimeType}',
    );
  }

  @override
  Object? toJson(Decimal? object) => object?.toString();
}

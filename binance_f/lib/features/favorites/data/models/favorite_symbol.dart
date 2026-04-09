import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorite_symbol.freezed.dart';
part 'favorite_symbol.g.dart';

/// A user's favorited trading symbol, persisted in the Drift `favorites`
/// table.
///
/// [market] is `'spot'` or `'futures'`. [position] controls the display
/// order in the favorites tab (lower = higher).
@Freezed(toJson: true, fromJson: true)
sealed class FavoriteSymbol with _$FavoriteSymbol {
  const factory FavoriteSymbol({
    required String symbol,
    required String market,
    required int position,
  }) = _FavoriteSymbol;

  factory FavoriteSymbol.fromJson(Map<String, dynamic> json) =>
      _$FavoriteSymbolFromJson(json);
}

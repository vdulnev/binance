import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/di/service_locator.dart';
import '../data/favorites_repository.dart';
import '../data/models/favorite_symbol.dart';

/// Provides the user's favorites list and exposes add/remove/reorder
/// actions.
final favoritesProvider =
    AsyncNotifierProvider<FavoritesNotifier, List<FavoriteSymbol>>(
      FavoritesNotifier.new,
    );

class FavoritesNotifier extends AsyncNotifier<List<FavoriteSymbol>> {
  late FavoritesRepository _repo;

  @override
  Future<List<FavoriteSymbol>> build() async {
    _repo = sl<FavoritesRepository>();
    final result = await _repo.getAll().run();
    return result.fold((err) => throw err, (list) => list);
  }

  Future<void> add(String symbol, String market) async {
    final result = await _repo.add(symbol, market).run();
    result.fold(
      (err) => null, // Silently log; TODO: surface error toast
      (_) => ref.invalidateSelf(),
    );
  }

  Future<void> remove(String symbol, String market) async {
    final result = await _repo.remove(symbol, market).run();
    result.fold((err) => null, (_) => ref.invalidateSelf());
  }

  Future<void> reorder(List<FavoriteSymbol> ordered) async {
    // Optimistic update: show the new order immediately.
    state = AsyncData(ordered);
    final result = await _repo.reorder(ordered).run();
    result.fold(
      // On error, re-fetch from DB to restore the truth.
      (err) => ref.invalidateSelf(),
      (_) {},
    );
  }

  Future<bool> isFavorite(String symbol, String market) async {
    final result = await _repo.isFavorite(symbol, market).run();
    return result.getOrElse((_) => false);
  }
}

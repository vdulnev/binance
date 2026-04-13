import 'package:decimal/decimal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/di/service_locator.dart';
import '../data/alerts_repository.dart';
import '../data/models/price_alert.dart';

/// Provides the full list of price alerts and exposes CRUD actions.
final alertsProvider = AsyncNotifierProvider<AlertsNotifier, List<PriceAlert>>(
  AlertsNotifier.new,
);

class AlertsNotifier extends AsyncNotifier<List<PriceAlert>> {
  late AlertsRepository _repo;

  @override
  Future<List<PriceAlert>> build() async {
    _repo = sl<AlertsRepository>();
    final result = await _repo.getAll().run();
    return result.fold((err) => throw err, (list) => list);
  }

  Future<void> createAlert({
    required String symbol,
    required String market,
    required AlertDirection direction,
    required Decimal targetPrice,
  }) async {
    final result = await _repo
        .create(
          symbol: symbol,
          market: market,
          direction: direction,
          targetPrice: targetPrice,
        )
        .run();
    result.fold((err) => null, (_) => ref.invalidateSelf());
  }

  Future<void> deleteAlert(int id) async {
    final result = await _repo.delete(id).run();
    result.fold((err) => null, (_) => ref.invalidateSelf());
  }

  Future<void> toggleEnabled(int id, {required bool enabled}) async {
    final result = await _repo.setEnabled(id, enabled: enabled).run();
    result.fold((err) => null, (_) => ref.invalidateSelf());
  }
}

import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/di/service_locator.dart';
import '../data/markets_repository.dart';
import '../data/models/symbol_info.dart';

/// Fetches and caches the exchange info symbol list for a given market.
///
/// Auto-disposes after 5 minutes via `ref.keepAlive()` timer so a rapid
/// tab switch between Spot/Futures doesn't re-fetch, but stale data is
/// eventually refreshed.
final exchangeInfoProvider = FutureProvider.family<List<SymbolInfo>, String>((
  ref,
  market,
) async {
  final repo = sl<MarketsRepository>();
  final link = ref.keepAlive();

  // Auto-dispose after 5 minutes so the next access triggers a refetch.
  final timer = Timer(const Duration(minutes: 5), link.close);
  ref.onDispose(timer.cancel);

  final result = await repo.getExchangeInfo(market: market).run();
  return result.fold((err) => throw err, (symbols) => symbols);
});

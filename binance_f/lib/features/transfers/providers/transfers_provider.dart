import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/di/service_locator.dart';
import '../data/models/deposit.dart';
import '../data/models/deposit_address.dart';
import '../data/models/withdrawal.dart';
import '../data/transfers_repository.dart';

/// Provides deposit history, sorted newest-first.
final depositsProvider =
    AsyncNotifierProvider<DepositsNotifier, List<Deposit>>(
      DepositsNotifier.new,
    );

class DepositsNotifier extends AsyncNotifier<List<Deposit>> {
  late TransfersRepository _repo;

  @override
  Future<List<Deposit>> build() async {
    _repo = sl<TransfersRepository>();
    final result = await _repo.getDeposits().run();
    return result.fold((err) => throw err, (list) => list);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final result = await _repo.getDeposits().run();
      return result.fold((err) => throw err, (list) => list);
    });
  }
}

/// Provides withdrawal history, sorted newest-first.
final withdrawalsProvider =
    AsyncNotifierProvider<WithdrawalsNotifier, List<Withdrawal>>(
      WithdrawalsNotifier.new,
    );

class WithdrawalsNotifier extends AsyncNotifier<List<Withdrawal>> {
  late TransfersRepository _repo;

  @override
  Future<List<Withdrawal>> build() async {
    _repo = sl<TransfersRepository>();
    final result = await _repo.getWithdrawals().run();
    return result.fold((err) => throw err, (list) => list);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final result = await _repo.getWithdrawals().run();
      return result.fold((err) => throw err, (list) => list);
    });
  }
}

/// Fetches the deposit address for a given coin.
///
/// Keyed by coin name so each coin is cached separately.
final depositAddressProvider =
    FutureProvider.family<DepositAddress, String>((ref, coin) async {
      final repo = sl<TransfersRepository>();
      final result = await repo.getDepositAddress(coin: coin).run();
      return result.fold((err) => throw err, (addr) => addr);
    });

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import '../../../core/auth/session_manager.dart';
import '../../../core/models/app_exception.dart';
import '../../auth/data/auth_repository.dart' show DioProvider;
import 'models/deposit.dart';
import 'models/deposit_address.dart';
import 'models/withdrawal.dart';

/// Data access for deposit/withdrawal history and deposit addresses
/// (Phase 10 — FR-8.1, FR-8.2).
///
/// All three endpoints live under `/sapi/v1/capital/` and are signed
/// with the spot Dio (the signing interceptor already allowlists them).
abstract class TransfersRepository {
  TaskEither<AppException, List<Deposit>> getDeposits({
    String? coin,
    int? status,
    DateTime? startTime,
    DateTime? endTime,
    int limit = 1000,
  });

  TaskEither<AppException, List<Withdrawal>> getWithdrawals({
    String? coin,
    int? status,
    DateTime? startTime,
    DateTime? endTime,
    int limit = 1000,
  });

  TaskEither<AppException, DepositAddress> getDepositAddress({
    required String coin,
    String? network,
  });
}

class BinanceTransfersRepository implements TransfersRepository {
  BinanceTransfersRepository({
    required DioProvider spotDio,
    SessionManager? sessionManager,
  }) : _spot = spotDio,
       _sessionManager = sessionManager;

  final DioProvider _spot;
  final SessionManager? _sessionManager;

  @override
  TaskEither<AppException, List<Deposit>> getDeposits({
    String? coin,
    int? status,
    DateTime? startTime,
    DateTime? endTime,
    int limit = 1000,
  }) {
    final cancelToken = CancelToken();
    _sessionManager?.registerCancelToken(cancelToken);

    return TaskEither<AppException, List<Deposit>>.tryCatch(() async {
      final params = <String, dynamic>{'limit': limit};
      if (coin != null) params['coin'] = coin;
      if (status != null) params['status'] = status;
      if (startTime != null) {
        params['startTime'] = startTime.millisecondsSinceEpoch;
      }
      if (endTime != null) {
        params['endTime'] = endTime.millisecondsSinceEpoch;
      }

      final response = await _spot().get<List<dynamic>>(
        '/sapi/v1/capital/deposit/hisrec',
        queryParameters: params,
        cancelToken: cancelToken,
      );
      final deposits =
          (response.data ?? const [])
              .whereType<Map<String, dynamic>>()
              .map(Deposit.fromJson)
              .toList(growable: false)
            ..sort((a, b) => b.insertTime.compareTo(a.insertTime));
      return deposits;
    }, _toAppException).bimap(_cleanup(cancelToken), _cleanup(cancelToken));
  }

  @override
  TaskEither<AppException, List<Withdrawal>> getWithdrawals({
    String? coin,
    int? status,
    DateTime? startTime,
    DateTime? endTime,
    int limit = 1000,
  }) {
    final cancelToken = CancelToken();
    _sessionManager?.registerCancelToken(cancelToken);

    return TaskEither<AppException, List<Withdrawal>>.tryCatch(() async {
      final params = <String, dynamic>{'limit': limit};
      if (coin != null) params['coin'] = coin;
      if (status != null) params['status'] = status;
      if (startTime != null) {
        params['startTime'] = startTime.millisecondsSinceEpoch;
      }
      if (endTime != null) {
        params['endTime'] = endTime.millisecondsSinceEpoch;
      }

      final response = await _spot().get<List<dynamic>>(
        '/sapi/v1/capital/withdraw/history',
        queryParameters: params,
        cancelToken: cancelToken,
      );
      final withdrawals =
          (response.data ?? const [])
              .whereType<Map<String, dynamic>>()
              .map(Withdrawal.fromJson)
              .toList(growable: false)
            ..sort((a, b) => b.applyDateTime.compareTo(a.applyDateTime));
      return withdrawals;
    }, _toAppException).bimap(_cleanup(cancelToken), _cleanup(cancelToken));
  }

  @override
  TaskEither<AppException, DepositAddress> getDepositAddress({
    required String coin,
    String? network,
  }) {
    final cancelToken = CancelToken();
    _sessionManager?.registerCancelToken(cancelToken);

    return TaskEither<AppException, DepositAddress>.tryCatch(() async {
      final params = <String, dynamic>{'coin': coin};
      if (network != null) params['network'] = network;

      final response = await _spot().get<Map<String, dynamic>>(
        '/sapi/v1/capital/deposit/address',
        queryParameters: params,
        cancelToken: cancelToken,
      );
      return DepositAddress.fromJson(response.data!);
    }, _toAppException).bimap(_cleanup(cancelToken), _cleanup(cancelToken));
  }

  T Function(T) _cleanup<T>(CancelToken token) {
    return (value) {
      _sessionManager?.unregisterCancelToken(token);
      return value;
    };
  }

  AppException _toAppException(Object err, StackTrace _) {
    if (err is AppException) return err;
    if (err is DioException && err.error is AppException) {
      return err.error! as AppException;
    }
    return AppException.unknown(message: err.toString());
  }
}

import 'package:dio/dio.dart';

import 'models/account_info.dart';

abstract class AccountRepository {
  Future<AccountInfo> getAccountInfo();
}

class BinanceAccountRepository implements AccountRepository {
  BinanceAccountRepository({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  Future<AccountInfo> getAccountInfo() async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/api/v3/account',
      queryParameters: {'omitZeroBalances': true},
    );
    return AccountInfo.fromJson(response.data!);
  }
}

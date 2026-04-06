import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/di/service_locator.dart';
import '../data/account_repository.dart';
import '../data/models/account_info.dart';

final accountProvider = AsyncNotifierProvider<AccountNotifier, AccountInfo>(
  AccountNotifier.new,
);

class AccountNotifier extends AsyncNotifier<AccountInfo> {
  late AccountRepository _repository;

  @override
  Future<AccountInfo> build() {
    _repository = sl<AccountRepository>();
    return _repository.getAccountInfo();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_repository.getAccountInfo);
  }
}

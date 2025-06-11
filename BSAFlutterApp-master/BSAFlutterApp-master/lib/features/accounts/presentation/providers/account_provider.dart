import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/injection.dart';
import '../../domain/repositories/account_repository.dart';
import '../../data/models/account_model.dart';

final accountRepositoryProvider = Provider<AccountRepository>((ref) {
  return getIt<AccountRepository>();
});

final accountNotifierProvider = StateNotifierProvider<AccountNotifier, AsyncValue<List<AccountModel>>>((ref) {
  return AccountNotifier(ref.read(accountRepositoryProvider));
});

class AccountNotifier extends StateNotifier<AsyncValue<List<AccountModel>>> {
  final AccountRepository _accountRepository;

  AccountNotifier(this._accountRepository) : super(const AsyncValue.loading());

  Future<void> loadAccounts() async {
    print('🏦 AccountNotifier: Starting to load accounts...');
    state = const AsyncValue.loading();
    
    try {
      final accounts = await _accountRepository.getAccounts();
      print('🏦 AccountNotifier: Successfully loaded ${accounts.length} accounts');
      state = AsyncValue.data(accounts);
    } catch (e, stackTrace) {
      print('🔴 AccountNotifier: Error loading accounts: $e');
      print('🔴 AccountNotifier: Stack trace: $stackTrace');
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> exportExcel(List<String> accountIds) async {
    try {
      print('🏦 AccountNotifier: Exporting ${accountIds.length} accounts to Excel...');
      await _accountRepository.exportExcel(accountIds);
      print('🏦 AccountNotifier: Excel export completed successfully');
      // Handle successful export (e.g., show success message)
    } catch (e, stackTrace) {
      print('🔴 AccountNotifier: Error exporting to Excel: $e');
      print('🔴 AccountNotifier: Stack trace: $stackTrace');
      // Handle export error
      rethrow;
    }
  }
}

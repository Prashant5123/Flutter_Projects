import '../../data/models/account_model.dart';

abstract class AccountRepository {
  Future<List<AccountModel>> getAccounts();
  Future<String> exportExcel(List<String> accountIds);
}

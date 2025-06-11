
import '../../../../core/network/api_client.dart';
import '../../domain/repositories/account_repository.dart';
import '../models/account_model.dart';

class AccountRepositoryImpl implements AccountRepository {
final ApiClient _apiClient;

AccountRepositoryImpl(this._apiClient);

@override
Future<List<AccountModel>> getAccounts() async {
try {
return await _apiClient.getAccounts();
} catch (e) {
print('🔴 Repository getAccounts error: $e');
rethrow;
}
}

@override
Future<String> exportExcel(List<String> accountIds) async {
try {
// Get the download URL
final downloadUrl = await _apiClient.exportExcel(accountIds);
return downloadUrl;
} catch (e) {
print('🔴 Repository exportExcel error: $e');
rethrow;
}
}
}

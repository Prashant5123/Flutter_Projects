
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/animated_button.dart';
import '../providers/account_provider.dart';
import '../../../../core/utils/logger.dart';
import '../../domain/repositories/account_repository.dart';

class ExportExcelScreen extends ConsumerStatefulWidget {
const ExportExcelScreen({super.key});

@override
ConsumerState<ExportExcelScreen> createState() => _ExportExcelScreenState();
}

class _ExportExcelScreenState extends ConsumerState<ExportExcelScreen> {
final Set<String> _selectedAccountIds = {};
bool _isExporting = false;

@override
void initState() {
super.initState();
WidgetsBinding.instance.addPostFrameCallback((_) {
ref.read(accountNotifierProvider.notifier).loadAccounts();
});
}

@override
Widget build(BuildContext context) {
final accountsState = ref.watch(accountNotifierProvider);

return Scaffold(
appBar: AppBar(
title: const Text('Export to Excel'),
leading: IconButton(
icon: const Icon(Icons.arrow_back),
onPressed: () => context.pop(),
),
),
body: Column(
children: [
// Header
Container(
width: double.infinity,
padding: const EdgeInsets.all(24),
decoration: BoxDecoration(
gradient: AppTheme.primaryGradient,
),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
'Select Accounts',
style: Theme.of(context).textTheme.headlineSmall?.copyWith(
color: Colors.white,
fontWeight: FontWeight.bold,
),
),
const SizedBox(height: 8),
Text(
'Choose accounts to export to Excel',
style: Theme.of(context).textTheme.bodyLarge?.copyWith(
color: Colors.white70,
),
),
],
),
).animate().slideY(duration: 600.ms),

// Account List
Expanded(
child: accountsState.when(
data: (accounts) {
if (accounts.isEmpty) {
return _buildEmptyState();
}

return AnimationLimiter(
child: ListView.separated(
padding: const EdgeInsets.all(16),
itemCount: accounts.length,
separatorBuilder: (context, index) => const SizedBox(height: 12),
itemBuilder: (context, index) {
final account = accounts[index];
final accountId = account.badId.toString();
final isSelected = _selectedAccountIds.contains(accountId);

return AnimationConfiguration.staggeredList(
position: index,
duration: const Duration(milliseconds: 600),
child: SlideAnimation(
verticalOffset: 50.0,
child: FadeInAnimation(
child: GlassCard(
child: CheckboxListTile(
value: isSelected,
onChanged: (value) {
setState(() {
if (value == true) {
_selectedAccountIds.add(accountId);
} else {
_selectedAccountIds.remove(accountId);
}
});
},
title: Text(
account.accountName,
style: const TextStyle(fontWeight: FontWeight.bold),
),
subtitle: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text('${account.bankName} • ${account.accountType}'),
Text('Account: ${account.accountNumber}'),
],
),
secondary: Container(
padding: const EdgeInsets.all(12),
decoration: BoxDecoration(
color: AppTheme.primaryTeal.withOpacity(0.1),
shape: BoxShape.circle,
),
child: Icon(
Icons.account_balance,
color: AppTheme.primaryTeal,
),
),
activeColor: AppTheme.accentGreen,
checkColor: Colors.white,
contentPadding: const EdgeInsets.all(16),
).animate().scale(
delay: Duration(milliseconds: 100 * index),
duration: 300.ms,
),
),
),
),
);
},
),
);
},
loading: () => const Center(
child: CircularProgressIndicator(),
),
error: (error, _) => Center(
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
Icon(
Icons.error_outline,
size: 64,
color: AppTheme.errorRed,
),
const SizedBox(height: 16),
Text(
'Failed to load accounts',
style: Theme.of(context).textTheme.titleMedium,
),
const SizedBox(height: 8),
Text(
error.toString(),
style: Theme.of(context).textTheme.bodySmall,
textAlign: TextAlign.center,
),
const SizedBox(height: 16),
ElevatedButton(
onPressed: () => ref.read(accountNotifierProvider.notifier).loadAccounts(),
child: const Text('Retry'),
),
],
),
),
),
),

// Export Button
Container(
padding: const EdgeInsets.all(16),
child: Column(
children: [
if (_selectedAccountIds.isNotEmpty)
Text(
'${_selectedAccountIds.length} account(s) selected',
style: Theme.of(context).textTheme.bodyMedium?.copyWith(
color: AppTheme.accentGreen,
fontWeight: FontWeight.bold,
),
).animate().fadeIn(duration: 300.ms),
const SizedBox(height: 16),
SizedBox(
width: double.infinity,
child: AnimatedButton(
onPressed: _selectedAccountIds.isEmpty || _isExporting ? null : _handleExport,
gradient: AppTheme.primaryGradient,
child: _isExporting
? const SizedBox(
height: 20,
width: 20,
child: CircularProgressIndicator(
strokeWidth: 2,
valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
),
)
    : const Row(
mainAxisAlignment: MainAxisAlignment.center,
children: [
Icon(Icons.file_download, color: Colors.white),
SizedBox(width: 8),
Text(
'Export to Excel',
style: TextStyle(
fontSize: 16,
fontWeight: FontWeight.bold,
color: Colors.white,
),
),
],
),
),
),
],
),
).animate().slideY(delay: 800.ms, duration: 400.ms),
],
),
);
}

Widget _buildEmptyState() {
return Center(
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
Icon(
Icons.account_balance_outlined,
size: 64,
color: Colors.grey[400],
),
const SizedBox(height: 16),
Text(
'No accounts found',
style: Theme.of(context).textTheme.titleMedium?.copyWith(
color: Colors.grey[600],
),
),
const SizedBox(height: 8),
Text(
'Upload your bank statements to get started',
style: Theme.of(context).textTheme.bodySmall?.copyWith(
color: Colors.grey[500],
),
textAlign: TextAlign.center,
),
const SizedBox(height: 16),
ElevatedButton(
onPressed: () => context.push('/upload'),
child: const Text('Upload File'),
),
],
),
);
}

Future<void> _handleExport() async {
setState(() {
_isExporting = true;
});

try {
await exportExcelWithDio(_selectedAccountIds.toList());
if (mounted) {
ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(
content: Text('Excel file download started!'),
backgroundColor: AppTheme.accentGreen,
),
);
context.pop();
}
} catch (e) {
if (mounted) {
//AppLogger.log('Export failed: $e');
ScaffoldMessenger.of(context).showSnackBar(
SnackBar(
content: Text('Export failed: $e'),
backgroundColor: AppTheme.errorRed,
),
);
}
} finally {
if (mounted) {
setState(() {
_isExporting = false;
});
}
}
}

Future<void> exportExcelWithDio(List<String> selectedAccountIds) async {
final accountRepository = ref.read(accountRepositoryProvider);

try {
// Get the download URL from the repository
final downloadUrl = await accountRepository.exportExcel(selectedAccountIds);

// Launch the URL in the browser
final uri = Uri.parse(downloadUrl as String);
if (await canLaunchUrl(uri)) {
  await launchUrl(uri, mode: LaunchMode.platformDefault);
} else {
throw Exception('Could not launch $downloadUrl');
}
} catch (e) {
//AppLogger.log('Export error: $e');
rethrow;
}
}
}

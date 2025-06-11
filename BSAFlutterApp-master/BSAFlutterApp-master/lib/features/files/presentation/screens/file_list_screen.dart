import 'package:dio/dio.dart';
import 'package:financial_analyzer/core/network/api_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/glass_card.dart';
import '../providers/file_provider.dart';

class FileListScreen extends ConsumerStatefulWidget {
  const FileListScreen({super.key});

  @override
  ConsumerState<FileListScreen> createState() => _FileListScreenState();
}

class _FileListScreenState extends ConsumerState<FileListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(fileListNotifierProvider.notifier).loadFiles();
    });
  }

  @override
  Widget build(BuildContext context) {
    final filesState = ref.watch(fileListNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Files'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.read(fileListNotifierProvider.notifier).loadFiles(),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(fileListNotifierProvider.notifier).loadFiles();
        },
        child: filesState.when(
          data: (files) {
            if (files.isEmpty) {
              return _buildEmptyState();
            }

            return AnimationLimiter(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: files.length,
                itemBuilder: (context, index) {
                  final file = files[index];
                  final fileName = file.filePath.split(RegExp(r'[\\/]')).last;
                  final uploadDate = DateTime.now().subtract(Duration(days: index)); // Replace with actual upload date if available

                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 600),
                    child: SlideAnimation(
                      child: FadeInAnimation(
                        child: GlassCard(

                          child: Row(
                            children: [
                              const Icon(Icons.insert_drive_file, size: 40, color: Colors.teal),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      fileName,
                                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Uploaded: ${uploadDate.toLocal().toString().split(" ").first}',
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.download, color: AppTheme.accentGreen),
                                onPressed: () => _launchDownload(file.fileId),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text('Error: $error')),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.folder_open, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text('No files uploaded', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey[600])),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: () => context.push('/upload'),
            icon: const Icon(Icons.upload_file),
            label: const Text('Upload File'),
          ),
        ],
      ),
    );
  }

  Future<void> _launchDownload(int fileId) async {
    Dio _dio = Dio();
    ApiClient pc = new ApiClient(_dio);
    try {
      final downloadUrl = await pc.getDownloadUrl(fileId);
      final uri = Uri.parse(downloadUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $downloadUrl';
      }
    } catch (e) {
      print('🔴 Failed to launch download: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to download file: $e')),
      );
    }
  }
}

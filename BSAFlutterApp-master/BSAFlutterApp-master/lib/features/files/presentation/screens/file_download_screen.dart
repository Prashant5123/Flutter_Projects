import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/animated_button.dart';
import '../providers/file_provider.dart';

class FileDownloadScreen extends ConsumerStatefulWidget {
  final String fileId;
  
  const FileDownloadScreen({
    super.key,
    required this.fileId,
  });

  @override
  ConsumerState<FileDownloadScreen> createState() => _FileDownloadScreenState();
}

class _FileDownloadScreenState extends ConsumerState<FileDownloadScreen> {
  @override
  Widget build(BuildContext context) {
    final downloadState = ref.watch(fileDownloadNotifierProvider);
    
    ref.listen(fileDownloadNotifierProvider, (previous, next) {
      next.whenOrNull(
        data: (result) {
          if (result != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('File downloaded successfully!'),
                backgroundColor: AppTheme.accentGreen,
              ),
            );
          }
        },
        error: (error, _) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error.toString()),
              backgroundColor: AppTheme.errorRed,
            ),
          );
        },
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Download File ${widget.fileId}'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // File Preview
              GlassCard(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(48),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryTeal.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.picture_as_pdf,
                          size: 80,
                          color: AppTheme.primaryTeal,
                        ),
                      ).animate().scale(duration: 600.ms),
                      
                      const SizedBox(height: 24),
                      
                      Text(
                        'File ${widget.fileId}',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      
                      const SizedBox(height: 8),
                      
                      Text(
                        'PDF Document',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ).animate().fadeIn(delay: 200.ms, duration: 600.ms),
              
              const SizedBox(height: 32),
              
              // Download Button
              SizedBox(
                width: double.infinity,
                child: AnimatedButton(
                  onPressed: downloadState.isLoading ? null : _handleDownload,
                  gradient: AppTheme.primaryGradient,
                  child: downloadState.isLoading
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
                            Icon(Icons.download, color: Colors.white),
                            SizedBox(width: 8),
                            Text(
                              'Download File',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                ),
              ).animate().slideY(delay: 400.ms, duration: 400.ms),
            ],
          ),
        ),
      ),
    );
  }

  void _handleDownload() async {
    await ref.read(fileDownloadNotifierProvider.notifier).downloadFile(widget.fileId);
  }
}

import 'dart:developer';
import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';

import 'core/di/injection.dart';
import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';
import 'core/utils/logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize logger
  AppLogger.init();

  // Setup dependency injection
  await setupDI();

  // Request permissions
  await _requestPermissions();

  runApp(
    const ProviderScope(
      child: FinancialAnalyzerApp(),
    ),
  );
}

// Function to request permissions with backward compatibility
Future<void> _requestPermissions() async {
  if (Platform.isAndroid) {
    // Check and request manage external storage (for Android 11+)
    final android11OrHigher = await Permission.manageExternalStorage.isGranted ||
        await Permission.manageExternalStorage.request().isGranted;

    final permissions = <Permission>[
      Permission.camera,
      Permission.storage,      // Covers legacy storage (up to API 32)
      Permission.photos,       // Scoped access Android 13+
      Permission.videos,
      Permission.audio,
    ];

    for (final permission in permissions) {
      final status = await permission.status;
      if (status.isDenied || status.isRestricted) {
        final result = await permission.request();
        if (result.isPermanentlyDenied) {
          await openAppSettings();
        }
      }
    }

    // Optionally log or handle manageExternalStorage
    if (!android11OrHigher) {
      // Notify user that access to full storage might be limited
    }
  }
}

// Check if legacy storage permissions are supported (pre-Android 13)
Future<bool> _isLegacyStorageSupported() async {
  // Android 13 (API 33) and above use granular media permissions
  if (Platform.isAndroid) {
    const android13ApiLevel = 33;
    // Note: DeviceInfoPlugin can be used for precise API level checking, but for simplicity, we assume legacy storage is needed for older devices
    return true; // Assume legacy storage is supported for broader compatibility
  }
  return false;
}

class FinancialAnalyzerApp extends ConsumerWidget {
  const FinancialAnalyzerApp({super.key});

  // Show dialog if permissions are denied
  Future<void> _showPermissionDeniedDialog(BuildContext context) async {
    final storageStatus = await Permission.storage.status;
    final photosStatus = await Permission.photos.status;
    final cameraStatus = await Permission.camera.status;

    if (storageStatus.isDenied || photosStatus.isDenied || cameraStatus.isDenied) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Permissions Required'),
          content: const Text(
            'This app needs camera and storage permissions to function properly. Please enable them in settings.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                await openAppSettings();
              },
              child: const Text('Open Settings'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    // Check permissions and show dialog if needed
    _showPermissionDeniedDialog(context);

    return MaterialApp.router(
      title: 'Financial Analyzer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: router,
      builder: (context, child) {
        // Add global error handling
        ErrorWidget.builder = (FlutterErrorDetails details) {
          return Material(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    color: AppTheme.errorRed,
                    size: 64,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Something went wrong',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    details.exception.toString(),
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Try to navigate back to login
                      router.go('/login');
                    },
                    child: const Text('Return to Login'),
                  ),
                ],
              ),
            ),
          );
        };

        return child ?? const Scaffold(
          body: Center(
            child: Text('Navigation Error'),
          ),
        );
      },
    );
  }
}
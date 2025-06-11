import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../../features/files/presentation/screens/file_upload_screen.dart';
import '../../features/files/presentation/screens/file_list_screen.dart';
import '../../features/files/presentation/screens/file_download_screen.dart';
import '../../features/accounts/presentation/screens/export_excel_screen.dart';
import '../providers/auth_provider.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final notifier = RouterNotifier(ref);
  
  return GoRouter(
    initialLocation: '/login',
    debugLogDiagnostics: true,
    refreshListenable: notifier,
    redirect: notifier._redirectLogic,
    routes: [
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) {
          print('🔄 Building LoginScreen');
          return const LoginScreen();
        },
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) {
          print('🔄 Building RegisterScreen');
          return const RegisterScreen();
        },
      ),
      GoRoute(
        path: '/dashboard',
        name: 'dashboard',
        builder: (context, state) {
          print('🔄 Building DashboardScreen');
          return const DashboardScreen();
        },
      ),
      GoRoute(
        path: '/upload',
        name: 'upload',
        builder: (context, state) => const FileUploadScreen(),
      ),
      GoRoute(
        path: '/files',
        name: 'files',
        builder: (context, state) => const FileListScreen(),
      ),
      GoRoute(
        path: '/download/:fileId',
        name: 'download',
        builder: (context, state) {
          final fileId = state.pathParameters['fileId']!;
          return FileDownloadScreen(fileId: fileId);
        },
      ),
      GoRoute(
        path: '/export',
        name: 'export',
        builder: (context, state) => const ExportExcelScreen(),
      ),
    ],
  );
});

class RouterNotifier extends ChangeNotifier {
  final Ref _ref;
  
  RouterNotifier(this._ref) {
    _ref.listen(authProvider, (_, __) {
      print('🔄 Auth state changed, refreshing router');
      notifyListeners();
    });
  }
  
  String? _redirectLogic(BuildContext context, GoRouterState state) {
    final user = _ref.read(authProvider);
    final isLoggedIn = user != null;
    final currentLocation = state.matchedLocation;
    
    print('🔄 Router redirect - Location: $currentLocation, LoggedIn: $isLoggedIn');
    
    // Define auth routes
    final authRoutes = ['/login', '/register'];
    final isAuthRoute = authRoutes.contains(currentLocation);
    
    // If not logged in and trying to access protected route, go to login
    if (!isLoggedIn && !isAuthRoute) {
      print('🔄 Redirecting to login - user not authenticated');
      return '/login';
    }
    
    // If logged in and on auth route, go to dashboard
    if (isLoggedIn && isAuthRoute) {
      print('🔄 Redirecting to dashboard - user already authenticated');
      return '/dashboard';
    }
    
    // No redirect needed
    print('🔄 No redirect needed for $currentLocation');
    return null;
  }
}

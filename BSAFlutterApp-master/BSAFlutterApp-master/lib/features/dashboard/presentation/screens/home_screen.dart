import 'package:financial_analyzer/core/providers/auth_provider.dart';
import 'package:financial_analyzer/core/theme/app_theme.dart';
import 'package:financial_analyzer/core/widgets/animated_button.dart';
import 'package:financial_analyzer/core/widgets/glass_card.dart';
import 'package:financial_analyzer/features/accounts/presentation/providers/account_provider.dart';
import 'package:financial_analyzer/features/auth/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authProvider);
    //final accountsState = ref.watch(accountNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: const ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Logout'),
                ),
                onTap: () => _showLogoutDialog(context),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildWelcomeSection(user!),
            const SizedBox(height: 24),
            Text(
              "Choose your preferred method to upload the bank statement.",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 24),

            Row(
              children: [
                GestureDetector(
                  onTap: () => context.push('/dashboard'),
                  
                  child: Container(
                    width: (MediaQuery.of(context).size.width - 56) / 2,
                    decoration: BoxDecoration(
                        gradient: AppTheme.primaryGradient,
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.upload_file,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Proceed with\npdf upload",
                            style:
                                Theme.of(context).textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 24),



                 GestureDetector(
                  onTap: () => context.push('/neworder'),
                  
                  child: Container(
                    width: (MediaQuery.of(context).size.width - 56) / 2,
                    decoration: BoxDecoration(
                        gradient: AppTheme.primaryGradient,
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                      child: Column(
                       
                        children: [
                          const Icon(
                             Icons.camera_alt_rounded,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Proceed with\ncamera",
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Row(
            //   children: [
            //     SizedBox(
            //       width: (MediaQuery.of(context).size.width - 56) / 2,
            //       child: AnimatedButton(
            //         onPressed: () => context.push('/dashboard'),
            //         gradient: AppTheme.primaryGradient,
            //         child: Column(
            //           children: [
            //             const Icon(
            //               Icons.upload_file,
            //             ),
            //             const SizedBox(
            //               height: 10,
            //             ),
            //             Text(
            //               "Proceed with pdf upload",
            //               style:
            //                   Theme.of(context).textTheme.titleMedium?.copyWith(
            //                         fontWeight: FontWeight.bold,
            //                       ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //     // GlassCard(
            //     //   child: InkWell(
            //     //     onTap: () => context.push('/dashboard'),
            //     //     borderRadius: BorderRadius.circular(20),
            //     //     child: Padding(
            //     //       padding: const EdgeInsets.all(16),
            //     //       child: Row(
            //     //         children: [
            //     //           Container(
            //     //             padding: const EdgeInsets.all(6),
            //     //             decoration: BoxDecoration(
            //     //               color: AppTheme.primaryBlue.withOpacity(0.1),
            //     //               shape: BoxShape.circle,
            //     //             ),
            //     //             child: const Icon(
            //     //               Icons.upload_file,
            //     //               color: AppTheme.primaryBlue,
            //     //             ),
            //     //           ),
            //     //           const SizedBox(
            //     //             width: 10,
            //     //           ),
            //     //           Text(
            //     //             "Proceed with pdf upload",
            //     //             style:
            //     //                 Theme.of(context).textTheme.titleMedium?.copyWith(
            //     //                       fontWeight: FontWeight.bold,
            //     //                     ),
            //     //           ),
            //     //         ],
            //     //       ),
            //     //     ),
            //     //   ),
            //     // ),
            //     const SizedBox(width: 24),

            //     SizedBox(
            //       width: (MediaQuery.of(context).size.width - 56) / 2,
            //       child: AnimatedButton(
            //         onPressed: () => context.push('/neworder'),
            //         gradient: AppTheme.primaryGradient,
            //         child: Column(
            //           children: [
            //             const Icon(
            //               Icons.camera_alt_rounded,
            //             ),
            //             const SizedBox(
            //               height: 10,
            //             ),
            //             Text(
            //               "Proceed with camera",
            //               style:
            //                   Theme.of(context).textTheme.titleMedium?.copyWith(
            //                         fontWeight: FontWeight.bold,
            //                       ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //   ],
            // ),

            // GlassCard(
            //   child: InkWell(
            //     onTap: () => context.push('/neworder'),
            //     borderRadius: BorderRadius.circular(20),
            //     child: Padding(
            //       padding: const EdgeInsets.all(16),
            //       child: Row(
            //         children: [
            //           Container(
            //             padding: const EdgeInsets.all(6),
            //             decoration: BoxDecoration(
            //               color: AppTheme.primaryBlue.withOpacity(0.1),
            //               shape: BoxShape.circle,
            //             ),
            //             child: const Icon(
            //               Icons.camera_alt_rounded,
            //               color: AppTheme.primaryBlue,
            //             ),
            //           ),
            //           const SizedBox(
            //             width: 10,
            //           ),
            //           Text(
            //             "Proceed with camera",
            //             style:
            //                 Theme.of(context).textTheme.titleMedium?.copyWith(
            //                       fontWeight: FontWeight.bold,
            //                     ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeSection(UserModel user) {
    return GlassCard(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: AppTheme.primaryGradient,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome Back!',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              user.email,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.white70,
                  ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 600.ms).slideY();
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ref.read(authProvider.notifier).logout();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.errorRed,
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}

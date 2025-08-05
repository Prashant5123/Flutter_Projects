import 'package:financial_analyzer/core/theme/app_theme.dart';
import 'package:financial_analyzer/core/widgets/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class NewOrder extends StatefulWidget {
  const NewOrder({super.key});

  @override
  State<NewOrder> createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: const Text('Dashboard'),

          ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Image Capture ",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              "Please click on the 'Create New Order'  button to start capturing and scanning bank statements.",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),

            const SizedBox(
              height: 24,
            ),
            SizedBox(
              width: double.infinity,
              child: AnimatedButton(
                onPressed: () => context.push('/orderdetails'),
                gradient: AppTheme.primaryGradient,
                child: Center(
                  child: Text(
                    "Create New Order",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

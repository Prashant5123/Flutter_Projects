import 'package:financial_analyzer/core/theme/app_theme.dart';
import 'package:financial_analyzer/core/widgets/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({super.key});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  final TextEditingController _namesController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
        
      ),


      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Please enter the below details to continue.",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),

            const SizedBox(
              height: 24,
            ),


            Text(
              "Customer Name",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),

            const SizedBox(
              height: 10,
            ),





            TextFormField(
          controller: _namesController,
          decoration: const InputDecoration(
            labelText: 'Customer Name',
            prefixIcon: Icon(Icons.person),
          ),
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return 'Please enter account holder names';
            }
            return null;
          },
        ),


        const SizedBox(
              height: 24,
            ),



        SizedBox(
              width: double.infinity,
              child: AnimatedButton(
                onPressed: (){},
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
import 'dart:developer';
import 'package:flutter/material.dart';

class ResponsiveAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final Color? color;
  final double height;

  ResponsiveAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.color,
  }) : height = _calculateHeight();

  // Static method to calculate height without context
  static double _calculateHeight() {
    // Return default height as a fallback
    return kToolbarHeight;
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final Orientation orientation = MediaQuery.of(context).orientation;

    double dynamicHeight;
    if (screenHeight < 600) {
      dynamicHeight = 40.0; // Split screen or small display
    } else if (orientation == Orientation.landscape) {
      dynamicHeight = 56.0;
    } else {
      log("$screenHeight");
      dynamicHeight = 80.0;
    }

    return PreferredSize(
      preferredSize: Size.fromHeight(dynamicHeight),
      child: AppBar(
        title: Text(title),
        centerTitle: true,
        backgroundColor: color,
        leading: leading,
        actions: actions,
      ),
    );
  }

  @override
  Size get preferredSize {
    // This is used by Flutter to layout the AppBar
    // We will return a dummy value here because actual height is passed in build method
    return const Size.fromHeight(kToolbarHeight);
  }
}

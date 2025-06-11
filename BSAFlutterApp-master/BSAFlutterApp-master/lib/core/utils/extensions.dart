import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

extension StringExtensions on String {
  bool get isNullOrEmpty => this == null || isEmpty;
  
  bool get isNotNullOrEmpty => !isNullOrEmpty;
  
  String capitalize() {
    if (isNullOrEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
  
  String truncate(int maxLength) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}...';
  }
}

extension DateTimeExtensions on DateTime {
  String format(String pattern) {
    return DateFormat(pattern).format(this);
  }
  
  String get formattedDate => format('MMM dd, yyyy');
  
  String get formattedDateTime => format('MMM dd, yyyy HH:mm');
  
  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}

extension ContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);
  
  TextTheme get textTheme => theme.textTheme;
  
  ColorScheme get colorScheme => theme.colorScheme;
  
  Size get screenSize => MediaQuery.of(this).size;
  
  double get screenWidth => screenSize.width;
  
  double get screenHeight => screenSize.height;
  
  bool get isSmallScreen => screenWidth < 600;
  
  bool get isMediumScreen => screenWidth >= 600 && screenWidth < 900;
  
  bool get isLargeScreen => screenWidth >= 900;
  
  void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }
}

extension AsyncValueExtensions on AsyncValue {
  bool get isLoading => this is AsyncLoading;
  
  bool get hasError => this is AsyncError;
  
  bool get hasData => this is AsyncData;
}

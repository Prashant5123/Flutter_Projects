import 'package:flutter/material.dart';
import 'package:task/video_feed_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: VideoFeedScreen());
  }
}

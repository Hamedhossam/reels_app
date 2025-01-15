import 'package:flutter/material.dart';
import 'package:reels/modules/home/presentation/screens/video_list_screen.dart';

void main() {
  runApp(const ReelsApp());
}

class ReelsApp extends StatelessWidget {
  const ReelsApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: VideoListScreen(),
    );
  }
}

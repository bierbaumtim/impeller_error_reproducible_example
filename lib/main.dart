import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

import 'image_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late bool showPerformanceOverlay;

  @override
  void initState() {
    super.initState();

    showPerformanceOverlay = false;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: ImagePage(
        onToggleShowPerformanceOverlay: () =>
            setState(() => showPerformanceOverlay = !showPerformanceOverlay),
      ),
      showPerformanceOverlay: showPerformanceOverlay,
    );

    // return MaterialApp(
    //   theme: ThemeData.light(useMaterial3: true),
    //   darkTheme: ThemeData.dark(useMaterial3: true),
    //   home: const ImagePage(),
    // );
  }
}

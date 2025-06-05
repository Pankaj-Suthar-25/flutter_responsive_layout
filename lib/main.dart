import 'package:flutter/material.dart';
import 'widgets/dashboard_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      'text 1',
      'text 2',
      'text 3',
      'text 4',
      'text 5',
      'text 6',
      'text 7',
      'text 8',
      'text 9',
      'text 10',
      'text 11',
    ];

    return MaterialApp(
      title: 'Flutter Responsive Layouts',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DashboardPage(items: items),
    );
  }
}

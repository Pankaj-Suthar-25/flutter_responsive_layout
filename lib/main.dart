import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Responsive Layout',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ResponsiveCardLayout(
        items: ['text 1', 'text 2','text 1', 'text 2','text 1', 'text 2','text 1', 'text 2','text 1', 'text 2',],
      ),
    );
  }
}

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: Text('Responsive Layout')),
      body: screenWidth > 600 ? _buildRow() : _buildColumn(),
    );
  }

  Widget _buildRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text('Text Widget 1'),
        Text('Text Widget 2'),
      ],
    );
  }

  Widget _buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text('Text Widget 1'),
        Text('Text Widget 2'),
      ],
    );
  }
}

class AnimatedResponsiveLayout extends StatelessWidget {
  final List<String> items;

  const AnimatedResponsiveLayout({super.key, required this.items});

  Widget _buildRowLayout() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: items.map((item) => _buildTextWidget(item)).toList(),
    );
  }

  Widget _buildColumnLayout() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: items.map((item) => _buildTextWidget(item)).toList(),
    );
  }

  Widget _buildTextWidget(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(fontSize: 24),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: const Text('Animated Responsive Layout')),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 900),
        child: (screenWidth > 600) ? _buildRowLayout() : _buildColumnLayout(),
      ),
    );
  }
}

class ResponsiveCardLayout extends StatelessWidget {
  const ResponsiveCardLayout({super.key, required this.items});

  final List<String> items;

  Widget _buildCard(String text) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  Widget _buildRowLayout() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: items.map((item) => _buildCard(item)).toList(),
      ),
    );
  }

  Widget _buildColumnLayout() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: items.map((item) => _buildCard(item)).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: const Text('Responsive Card Layout')),
      body: (screenWidth > 600) ? _buildRowLayout() : _buildColumnLayout(),
    );
  }
}
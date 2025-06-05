import 'package:flutter/material.dart';

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

import 'package:flutter/material.dart';

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

import 'package:flutter/material.dart';

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

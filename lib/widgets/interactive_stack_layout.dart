import 'package:flutter/material.dart';

import 'responsive_card_layout.dart';

class InteractiveStackLayout extends StatefulWidget {
  const InteractiveStackLayout({super.key, required this.items});

  final List<String> items;

  @override
  State<InteractiveStackLayout> createState() => _InteractiveStackLayoutState();
}

class _InteractiveStackLayoutState extends State<InteractiveStackLayout> {
  bool _isExpanded = false;

  Widget _buildStackedCard(String text, int index) {
    return Positioned(
      top: index * 10.0,
      left: index * 10.0,
      child: GestureDetector(
        onTap: () => setState(() => _isExpanded = true),
        child: Card(
          elevation: 4,
          child: Container(
            width: 150,
            height: 100,
            alignment: Alignment.center,
            child: Text(
              text,
              style: const TextStyle(fontSize: 24),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExpandedLayout() {
    return ResponsiveCardLayout(items: widget.items);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Interactive Stack Layout')),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 900),
        child: _isExpanded
            ? _buildExpandedLayout()
            : Stack(
          children: List.generate(
            widget.items.length,
                (index) => _buildStackedCard(widget.items[index], index),
          ),
        ),
      ),
    );
  }
}

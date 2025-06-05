import 'package:flutter/material.dart';

import 'responsive_card_layout.dart';

class AnimatedGradientLayout extends StatefulWidget {
  const AnimatedGradientLayout({super.key, required this.items});

  final List<String> items;

  @override
  State<AnimatedGradientLayout> createState() => _AnimatedGradientLayoutState();
}

class _AnimatedGradientLayoutState extends State<AnimatedGradientLayout> {
  bool _isExpanded = false;

  Widget _buildAnimatedCard(String text) {
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green, Colors.yellow],
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      width: 150,
      height: 100,
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(fontSize: 24, color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      decoration: BoxDecoration(
        gradient: _isExpanded
            ? LinearGradient(colors: [Colors.blue, Colors.purple])
            : LinearGradient(colors: [Colors.red, Colors.orange]),
      ),
      child: Center(
        child: GestureDetector(
          onTap: () => setState(() => _isExpanded = !_isExpanded),
          child: _isExpanded
              ? ResponsiveCardLayout(items: widget.items)
              : Stack(
              children: List.generate(widget.items.length, (index) {
                return Positioned(
                  top: index * 10.0,
                  left: index * 10.0,
                  child: _buildAnimatedCard(widget.items[index]),
                );
              })),
        ),
      ),
    );
  }
}

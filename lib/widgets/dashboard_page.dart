import 'package:flutter/material.dart';
import 'responsive_layout.dart';
import 'animated_responsive_layout.dart';
import 'responsive_card_layout.dart';
import 'interactive_stack_layout.dart';
import 'animated_gradient_layout.dart';
import 'animated_gradient_cards_page.dart';

class DashboardPage extends StatelessWidget {
  final List<String> items;
  const DashboardPage({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildNavigationButton(context, 'Responsive Layout', ResponsiveLayout()),
          _buildNavigationButton(context, 'Animated Responsive Layout', AnimatedResponsiveLayout(items: items)),
          _buildNavigationButton(context, 'Responsive Card Layout', ResponsiveCardLayout(items: items)),
          _buildNavigationButton(context, 'Interactive Stack Layout', InteractiveStackLayout(items: items)),
          _buildNavigationButton(context, 'Animated Gradient Layout', AnimatedGradientLayout(items: items)),
          _buildNavigationButton(context, 'Animated Gradient Cards Page', AnimatedGradientCardsPage(items: items)),
        ],
      ),
    );
  }

  Widget _buildNavigationButton(BuildContext context, String title, Widget page) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        child: Text(title, style: const TextStyle(fontSize: 18.0)),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => page),
        ),
      ),
    );
  }
}
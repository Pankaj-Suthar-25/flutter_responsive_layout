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
      home: AnimatedGradientLayout(
        items: [
          'text 1',
          'text 2',
          'text 1',
          'text 2',
          'text 1',
          'text 2',
          'text 1',
          'text 2',
          'text 1',
          'text 2',
        ],
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

class AnimatedGradientLayout extends StatefulWidget {
  const AnimatedGradientLayout({super.key, required this.items});

  final List<String> items;

  @override
  State<AnimatedGradientLayout> createState() => _AnimatedGradientLayoutState();
}

class _AnimatedGradientLayoutState extends State<AnimatedGradientLayout> {
  bool _isExpanded = false;

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
                    child: Card(
                      elevation: 4,
                      child: Container(
                        width: 150,
                        height: 100,
                        alignment: Alignment.center,
                        child: Text(
                          widget.items[index],
                          style: const TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                  );
                })),
        ),
      ),
    );
  }
}

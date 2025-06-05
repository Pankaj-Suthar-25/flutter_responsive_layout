import 'package:flutter/material.dart';

class AnimatedGradientCardsPage extends StatefulWidget {
  final List<String> items;
  const AnimatedGradientCardsPage({super.key, required this.items});

  @override
  State<AnimatedGradientCardsPage> createState() =>
      _AnimatedGradientCardsPageState();
}

class _AnimatedGradientCardsPageState extends State<AnimatedGradientCardsPage> {
  bool _isExpanded = false;

  Gradient get _backgroundGradient => _isExpanded
      ? const LinearGradient(colors: [Colors.blue, Colors.purple])
      : const LinearGradient(colors: [Colors.red, Colors.orange]);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated Gradient Cards'),
        centerTitle: true,
      ),
      body: AnimatedContainer(
        duration: const Duration(seconds: 1),
        decoration: BoxDecoration(gradient: _backgroundGradient),
        child: Center(
          child: GestureDetector(
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 600),
                switchInCurve: Curves.easeInOut,
                switchOutCurve: Curves.easeInOut,
                child: _isExpanded
                    ? ResponsiveCardsLayout(
                  key: const ValueKey('expanded'),
                  items: widget.items,
                  screenWidth: screenWidth,
                )
                    : StackedCardsLayout(
                  key: const ValueKey('stacked'),
                  items: widget.items,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class StackedCardsLayout extends StatelessWidget {
  final List<String> items;
  const StackedCardsLayout({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180.0,
      height: 160.0 + (items.length - 1) * 10,
      child: Stack(
        clipBehavior: Clip.none,
        children: List.generate(items.length, (index) {
          return Positioned(
            top: index * 10.0,
            left: index * 10.0,
            child: AnimatedGradientCard(
              text: items[index],
              width: 150.0,
              height: 100.0,
              fromColors: [Colors.orange, Colors.red],
              toColors: [Colors.yellow, Colors.deepOrange],
              animationDelay: Duration(milliseconds: index * 100),
            ),
          );
        }),
      ),
    );
  }
}

class ResponsiveCardsLayout extends StatelessWidget {
  final List<String> items;
  final double screenWidth;
  const ResponsiveCardsLayout(
      {super.key, required this.items, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    bool useRow = screenWidth > 600;

    Widget content = useRow
        ? SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: items.map((item) {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: AnimatedGradientCard(
              text: item,
              width: 150,
              height: 100,
              fromColors: [Colors.blue, Colors.purple],
              toColors: [Colors.blue, Colors.purple],
              animationDelay: Duration.zero,
            ),
          );
        }).toList(),
      ),
    )
        : SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: items.map((item) {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: AnimatedGradientCard(
              text: item,
              width: 150.0,
              height: 100.0,
              fromColors: [Colors.blue, Colors.purple],
              toColors: [Colors.blue, Colors.purple],
              animationDelay: Duration.zero,
            ),
          );
        }).toList(),
      ),
    );
    return SizedBox(
      width: double.infinity,
      height: 300,
      child: content,
    );
  }
}

class AnimatedGradientCard extends StatefulWidget {
  final String text;
  final double width;
  final double height;
  final List<Color> fromColors;
  final List<Color> toColors;
  final Duration animationDelay;

  const AnimatedGradientCard({
    super.key,
    required this.text,
    this.width = 150.0,
    this.height = 100.0,
    required this.fromColors,
    required this.toColors,
    required this.animationDelay,
  });

  @override
  State<AnimatedGradientCard> createState() => _AnimatedGradientCardState();
}

class _AnimatedGradientCardState extends State<AnimatedGradientCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _color1;
  late Animation<Color?> _color2;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    _color1 = ColorTween(begin: widget.fromColors[0], end: widget.toColors[0])
        .animate(_controller);
    _color2 = ColorTween(begin: widget.fromColors[1], end: widget.toColors[1])
        .animate(_controller);

    Future.delayed(widget.animationDelay, () {
      if (mounted) {
        _controller.repeat(reverse: true);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: [
                _color1.value ?? Colors.blue,
                _color2.value ?? Colors.purple
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(2, 4),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            widget.text,
            style: const TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  blurRadius: 4,
                  color: Colors.black54,
                  offset: Offset(1, 1),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

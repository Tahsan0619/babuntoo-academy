import 'dart:math';
import 'package:flutter/material.dart';

class CircularLogoMenu extends StatefulWidget {
  final List<IconData> icons;
  final List<String> titles;
  final List<VoidCallback> actions;

  const CircularLogoMenu({
    required this.icons,
    required this.titles,
    required this.actions,
    Key? key,
  }) : super(key: key);

  @override
  State<CircularLogoMenu> createState() => _CircularLogoMenuState();
}

class _CircularLogoMenuState extends State<CircularLogoMenu> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool isOpen = false;

  @override
  void initState() {
    _controller = AnimationController(
        duration: const Duration(milliseconds: 520), vsync: this);
    super.initState();
  }

  void toggleMenu() {
    setState(() {
      isOpen = !isOpen;
      if (isOpen) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final iconRadius = 28.0;
    final menuItemMargin = 16.0;
    final minMainAxis = size.shortestSide;
    final maxAllowedRadius = (minMainAxis / 2) - iconRadius - menuItemMargin;
    final baseRadius = maxAllowedRadius.clamp(60.0, minMainAxis / 2 - 8.0);

    final centerDiameter = 120.0; // center logo button diameter

    return SizedBox(
      width: centerDiameter + baseRadius * 2,
      height: centerDiameter + baseRadius * 2,
      child: Stack(
        alignment: Alignment.center,
        children: [
          for (int i = 0; i < widget.icons.length; i++)
            AnimatedBuilder(
              animation: _controller,
              builder: (_, __) {
                final double angle = (2 * pi / widget.icons.length) * i - pi / 2;
                final double iconOffset = baseRadius + centerDiameter / 2;
                final double x = iconOffset * cos(angle) * _controller.value;
                final double y = iconOffset * sin(angle) * _controller.value;
                return Positioned(
                  left: (centerDiameter / 2) + x - iconRadius,
                  top: (centerDiameter / 2) + y - iconRadius,
                  child: Opacity(
                    opacity: _controller.value,
                    child: GestureDetector(
                      onTap: widget.actions[i],
                      child: Tooltip(
                        message: widget.titles[i],
                        child: CircleAvatar(
                          radius: iconRadius,
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          child: Icon(widget.icons[i], color: Colors.white, size: 30),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          GestureDetector(
            onTap: toggleMenu,
            child: Container(
              width: centerDiameter,
              height: centerDiameter,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 14,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(13),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                      text: "B",
                      style: TextStyle(fontSize: 44, fontWeight: FontWeight.bold, color: Colors.red[800]),
                    ),
                    TextSpan(
                      text: "A",
                      style: TextStyle(fontSize: 44, fontWeight: FontWeight.bold, color: Colors.blue[800]),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

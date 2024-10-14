import 'package:flutter/material.dart';

final class BlinkWidget extends StatefulWidget {
  final List<Widget> children;

  const BlinkWidget({
    required this.children,
    super.key,
  });

  @override
  State<BlinkWidget> createState() => _BlinkWidgetState();
}

class _BlinkWidgetState extends State<BlinkWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _currentWidget = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _controller
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            if (++_currentWidget == widget.children.length) {
              _currentWidget = 0;
            }
          });
          _controller.forward(from: 0.0);
        }
      })
      ..forward(from: 0.0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.children[_currentWidget];
}

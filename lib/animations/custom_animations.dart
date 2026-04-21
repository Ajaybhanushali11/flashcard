// Yeh file pre-built animated widgets provide karti hai.

import 'package:flashcardapp/animations/animations.dart';
import 'package:flutter/material.dart';

class FadeInWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const FadeInWidget({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
  }) : super(key: key);

  @override
  _FadeInWidgetState createState() => _FadeInWidgetState();
}

class _FadeInWidgetState extends State<FadeInWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationControllerUtils.createController(this, duration: widget.duration);
    _animation = AnimationControllerUtils.createCurvedAnimation(_controller);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AppAnimations.fadeTransition(widget.child, _animation);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class SlideInWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Offset begin;

  const SlideInWidget({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.begin = const Offset(1.0, 0.0),
  }) : super(key: key);

  @override
  _SlideInWidgetState createState() => _SlideInWidgetState();
}

class _SlideInWidgetState extends State<SlideInWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationControllerUtils.createController(this, duration: widget.duration);
    _animation = AnimationControllerUtils.createCurvedAnimation(_controller);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: widget.begin,
        end: Offset.zero,
      ).animate(_animation),
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
import 'package:flutter/material.dart';

class AppAnimations {
  // Fade Animation
  static Widget fadeTransition(Widget child, Animation<double> animation) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }

  // Slide Animation
  static Widget slideTransition(Widget child, Animation<double> animation, {Offset begin = const Offset(1.0, 0.0)}) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: begin,
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }

  // Scale Animation
  static Widget scaleTransition(Widget child, Animation<double> animation) {
    return ScaleTransition(
      scale: animation,
      child: child,
    );
  }

  // Flip Animation - Flashcard ke liye perfect
  static Widget flipTransition(Widget front, Widget back, Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        final double value = animation.value;
        final double angle = value * 3.14159; // 180 degrees in radians
        
        // Front side - 0 to 90 degrees
        if (value < 0.5) {
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001) // Perspective
              ..rotateY(angle),
            child: Opacity(
              opacity: (0.5 - value) * 2, // Fade out front
              child: front,
            ),
          );
        } 
        // Back side - 90 to 180 degrees  
        else {
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001) // Perspective
              ..rotateY(angle - 3.14159), // Adjust for back side
            child: Opacity(
              opacity: (value - 0.5) * 2, // Fade in back
              child: back,
            ),
          );
        }
      },
    );
  }

  // Bounce Animation
  static Widget bounceTransition(Widget child, Animation<double> animation) {
    return ScaleTransition(
      scale: CurvedAnimation(
        parent: animation,
        curve: Curves.elasticOut,
      ),
      child: child,
    );
  }
}

class AnimationControllerUtils {
  static AnimationController createController(TickerProvider vsync, {Duration duration = const Duration(milliseconds: 300)}) {
    return AnimationController(
      duration: duration,
      vsync: vsync,
    );
  }

  static Animation<double> createCurvedAnimation(AnimationController controller, {Curve curve = Curves.easeInOut}) {
    return CurvedAnimation(
      parent: controller,
      curve: curve,
    );
  }
}
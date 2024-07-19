import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PageTransition extends CustomTransitionPage {
  PageTransition({
    required LocalKey super.key,
    required super.child,
    bool rtl = true,
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.easeInOut,
  }) : super(
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: curve,
            );
            return SlideTransition(
              position: Tween<Offset>(
                begin: rtl ? const Offset(1, 0) : const Offset(0, 1),
                end: Offset.zero,
              ).animate(curvedAnimation),
              child: child,
            );
          },
          transitionDuration: duration,
        );
}

import 'package:flutter/material.dart';

class CheckoutPageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;
  final bool reverse;

  CheckoutPageRoute({required this.page, this.reverse = false})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOutCubic;

            var tween = Tween(
              begin: reverse ? -begin : begin,
              end: end,
            ).chain(CurveTween(curve: curve));

            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
          transitionDuration: const Duration(milliseconds: 300),
        );
}

import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final double size;
  final bool showText;
  final Color? color;

  const Logo({
    super.key,
    this.size = 24,
    this.showText = true,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size * 1.2,
          height: size * 1.2,
          decoration: BoxDecoration(
            color: color ?? const Color(0xFF21D4B4),
            borderRadius: BorderRadius.circular(size * 0.3),
          ),
          child: Center(
            child: Text(
              'B',
              style: TextStyle(
                fontSize: size * 0.8,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        if (showText) ...[
          const SizedBox(width: 4),
          Text(
            'ORDERLESS',
            style: TextStyle(
              fontSize: size,
              fontWeight: FontWeight.bold,
              color: color ?? Colors.black,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ],
    );
  }
}

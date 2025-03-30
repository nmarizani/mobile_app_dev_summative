import 'package:flutter/material.dart';

class ToastNotification extends StatelessWidget {
  final String message;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? iconColor;
  final Duration duration;
  final VoidCallback? onDismiss;

  const ToastNotification({
    super.key,
    required this.message,
    this.icon,
    this.backgroundColor,
    this.textColor,
    this.iconColor,
    this.duration = const Duration(seconds: 3),
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: (backgroundColor ?? const Color(0xFF21D4B4)).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              color: iconColor ?? const Color(0xFF21D4B4),
              size: 20,
            ),
            const SizedBox(width: 8),
          ],
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: textColor ?? const Color(0xFF21D4B4),
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static void show(
    BuildContext context, {
    required String message,
    IconData? icon,
    Color? backgroundColor,
    Color? textColor,
    Color? iconColor,
    Duration? duration,
    VoidCallback? onDismiss,
  }) {
    final overlay = Overlay.of(context);
    final toast = ToastNotification(
      message: message,
      icon: icon,
      backgroundColor: backgroundColor,
      textColor: textColor,
      iconColor: iconColor,
      duration: duration ?? const Duration(seconds: 3),
      onDismiss: onDismiss,
    );

    final entry = OverlayEntry(
      builder: (context) => Positioned(
        top: 16,
        left: 24,
        right: 24,
        child: FadeTransition(
          opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: ModalRoute.of(context)?.animation ??
                  const AlwaysStoppedAnimation(1),
              curve: Curves.easeInOut,
            ),
          ),
          child: toast,
        ),
      ),
    );

    overlay.insert(entry);

    Future.delayed(duration ?? const Duration(seconds: 3), () {
      entry.remove();
      onDismiss?.call();
    });
  }
}

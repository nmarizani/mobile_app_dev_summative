import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isOutlined;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double height;
  final Widget? icon;
  final bool isIconButton;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isOutlined = false,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height = 56,
    this.icon,
    this.isIconButton = false,
  });

  @override
  Widget build(BuildContext context) {
    final buttonStyle = isOutlined
        ? OutlinedButton.styleFrom(
            foregroundColor: textColor ?? Colors.black,
            side: BorderSide(color: Colors.grey[300]!),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.zero,
          )
        : ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ?? Colors.black,
            foregroundColor: textColor ?? Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            disabledBackgroundColor:
                (backgroundColor ?? Colors.black).withOpacity(0.5),
            padding: EdgeInsets.zero,
          );

    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: isIconButton
          ? ElevatedButton.icon(
              onPressed: isLoading ? null : onPressed,
              style: buttonStyle,
              icon: icon!,
              label: Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color:
                      textColor ?? (isOutlined ? Colors.black : Colors.white),
                ),
              ),
            )
          : ElevatedButton(
              onPressed: isLoading ? null : onPressed,
              style: buttonStyle,
              child: isLoading
                  ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          textColor ??
                              (isOutlined ? Colors.black : Colors.white),
                        ),
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
                      text,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: textColor ??
                            (isOutlined ? Colors.black : Colors.white),
                      ),
                    ),
            ),
    );
  }
}

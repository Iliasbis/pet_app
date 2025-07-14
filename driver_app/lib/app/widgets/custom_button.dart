import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/utils/app_constants.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color? backgroundColor;
  final Gradient? gradient;
  final Color? textColor;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final double? elevation;
  final Widget? icon;
  final ButtonSize size;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.backgroundColor,
    this.gradient,
    this.textColor,
    this.padding,
    this.borderRadius,
    this.elevation,
    this.icon,
    this.size = ButtonSize.medium,
  });

  @override
  Widget build(BuildContext context) {
    final buttonPadding = _getButtonPadding();
    final buttonTextStyle = _getButtonTextStyle(context);

    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
        color: gradient == null ? (backgroundColor ?? AppColors.primaryTurquoise) : null,
        borderRadius: BorderRadius.circular(borderRadius ?? AppConstants.borderRadius),
        boxShadow: [
          if (elevation != null || gradient != null)
            BoxShadow(
              color: (gradient != null ? AppColors.primaryTurquoise : backgroundColor ?? AppColors.primaryTurquoise)
                  .withOpacity(0.3),
              blurRadius: elevation ?? AppConstants.cardElevation,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(borderRadius ?? AppConstants.borderRadius),
          child: Container(
            padding: padding ?? buttonPadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isLoading) ...[
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        textColor ?? Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                ],
                if (icon != null && !isLoading) ...[
                  icon!,
                  const SizedBox(width: 8),
                ],
                Text(
                  text,
                  style: buttonTextStyle.copyWith(
                    color: textColor ?? Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  EdgeInsetsGeometry _getButtonPadding() {
    switch (size) {
      case ButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
      case ButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal: 24, vertical: 12);
      case ButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 32, vertical: 16);
    }
  }

  TextStyle _getButtonTextStyle(BuildContext context) {
    switch (size) {
      case ButtonSize.small:
        return Theme.of(context).textTheme.labelMedium!.copyWith(
          fontWeight: FontWeight.w600,
        );
      case ButtonSize.medium:
        return Theme.of(context).textTheme.titleMedium!.copyWith(
          fontWeight: FontWeight.w600,
        );
      case ButtonSize.large:
        return Theme.of(context).textTheme.titleLarge!.copyWith(
          fontWeight: FontWeight.w600,
        );
    }
  }
}

enum ButtonSize { small, medium, large }
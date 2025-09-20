import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_fonts.dart';

enum SnackBarType {
  success,
  error,
  warning,
  info,
  custom,
}

class AppSnackBar {
  static SnackBar show({
    required String message,
    SnackBarType type = SnackBarType.info,
    Duration duration = const Duration(seconds: 3),
    String? actionLabel,
    VoidCallback? onActionPressed,
    bool showCloseIcon = true,
    String? title,
    Widget? icon,
    Color? customColor,
  }) {
    return SnackBar(
      content: _SnackBarContent(
        message: message,
        type: type,
        title: title,
        icon: icon,
        customColor: customColor,
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      duration: duration,
      margin: const EdgeInsets.all(16),
      padding: EdgeInsets.zero,
      action: actionLabel != null
          ? SnackBarAction(
              label: actionLabel,
              onPressed: onActionPressed ?? () {},
              textColor: _getActionColor(type, customColor),
            )
          : null,
      showCloseIcon: showCloseIcon,
      closeIconColor: _getTextColor(type, customColor),
    );
  }

  static void showSuccess(
    BuildContext context, {
    required String message,
    String? title,
    Duration duration = const Duration(seconds: 3),
    String? actionLabel,
    VoidCallback? onActionPressed,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      show(
        message: message,
        title: title ?? 'Succès',
        type: SnackBarType.success,
        duration: duration,
        actionLabel: actionLabel,
        onActionPressed: onActionPressed,
      ),
    );
  }

  static void showError(
    BuildContext context, {
    required String message,
    String? title,
    Duration duration = const Duration(seconds: 4),
    String? actionLabel,
    VoidCallback? onActionPressed,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      show(
        message: message,
        title: title ?? 'Erreur',
        type: SnackBarType.error,
        duration: duration,
        actionLabel: actionLabel,
        onActionPressed: onActionPressed,
      ),
    );
  }

  static void showWarning(
    BuildContext context, {
    required String message,
    String? title,
    Duration duration = const Duration(seconds: 3),
    String? actionLabel,
    VoidCallback? onActionPressed,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      show(
        message: message,
        title: title ?? 'Attention',
        type: SnackBarType.warning,
        duration: duration,
        actionLabel: actionLabel,
        onActionPressed: onActionPressed,
      ),
    );
  }

  static void showInfo(
    BuildContext context, {
    required String message,
    String? title,
    Duration duration = const Duration(seconds: 3),
    String? actionLabel,
    VoidCallback? onActionPressed,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      show(
        message: message,
        title: title ?? 'Information',
        type: SnackBarType.info,
        duration: duration,
        actionLabel: actionLabel,
        onActionPressed: onActionPressed,
      ),
    );
  }

  static void showCustom(
    BuildContext context, {
    required String message,
    String? title,
    Widget? icon,
    Color? color,
    Duration duration = const Duration(seconds: 3),
    String? actionLabel,
    VoidCallback? onActionPressed,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      show(
        message: message,
        title: title,
        type: SnackBarType.custom,
        icon: icon,
        customColor: color,
        duration: duration,
        actionLabel: actionLabel,
        onActionPressed: onActionPressed,
      ),
    );
  }

  static Color _getBackgroundColor(SnackBarType type, Color? customColor) {
    if (customColor != null) return customColor;

    switch (type) {
      case SnackBarType.success:
        return AppColors.success;
      case SnackBarType.error:
        return AppColors.error;
      case SnackBarType.warning:
        return AppColors.warning;
      case SnackBarType.info:
        return AppColors.info;
      case SnackBarType.custom:
        return AppColors.primary;
    }
  }

  static Color _getTextColor(SnackBarType type, Color? customColor) {
    return AppColors.white;
  }

  static Color _getActionColor(SnackBarType type, Color? customColor) {
    return AppColors.white.withOpacity(0.9);
  }

  static IconData _getIcon(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return Icons.check_circle_outline;
      case SnackBarType.error:
        return Icons.error_outline;
      case SnackBarType.warning:
        return Icons.warning_amber_outlined;
      case SnackBarType.info:
        return Icons.info_outline;
      case SnackBarType.custom:
        return Icons.notifications_outlined;
    }
  }
}

class _SnackBarContent extends StatefulWidget {
  final String message;
  final SnackBarType type;
  final String? title;
  final Widget? icon;
  final Color? customColor;

  const _SnackBarContent({
    required this.message,
    required this.type,
    this.title,
    this.icon,
    this.customColor,
  });

  @override
  State<_SnackBarContent> createState() => _SnackBarContentState();
}

class _SnackBarContentState extends State<_SnackBarContent>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = AppSnackBar._getBackgroundColor(widget.type, widget.customColor);
    final textColor = AppSnackBar._getTextColor(widget.type, widget.customColor);

    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: backgroundColor.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              // Icon
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: textColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: widget.icon ??
                    Icon(
                      AppSnackBar._getIcon(widget.type),
                      color: textColor,
                      size: 20,
                    ),
              ),

              const SizedBox(width: 12),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.title != null) ...[
                      Text(
                        widget.title!,
                        style: AppFonts.urbanist(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 2),
                    ],
                    Text(
                      widget.message,
                      style: AppFonts.urbanist(
                        fontSize: 13,
                        color: textColor.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
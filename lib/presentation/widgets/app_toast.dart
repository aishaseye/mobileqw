import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_fonts.dart';

enum ToastType {
  success,
  error,
  warning,
  info,
  custom,
}

class AppToast {
  static FToast? _fToast;

  static void init(BuildContext context) {
    _fToast = FToast();
    _fToast!.init(context);
  }

  // Basic toast using fluttertoast package
  static void showBasic({
    required String message,
    ToastType type = ToastType.info,
    Toast length = Toast.LENGTH_SHORT,
    ToastGravity gravity = ToastGravity.BOTTOM,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: length,
      gravity: gravity,
      backgroundColor: _getBackgroundColor(type),
      textColor: _getTextColor(type),
      fontSize: 14.0,
    );
  }

  // Custom animated toast
  static void show(
    BuildContext context, {
    required String message,
    ToastType type = ToastType.info,
    Duration duration = const Duration(seconds: 2),
    String? title,
    Widget? icon,
    Color? customColor,
    ToastPosition position = ToastPosition.bottom,
    bool dismissible = true,
  }) {
    init(context);

    Widget toast = _ToastWidget(
      message: message,
      type: type,
      title: title,
      icon: icon,
      customColor: customColor,
      dismissible: dismissible,
      onDismiss: () => _fToast?.removeCustomToast(),
    );

    _fToast?.showToast(
      child: toast,
      gravity: _getGravity(position),
      toastDuration: duration,
    );
  }

  static void showSuccess(
    BuildContext context, {
    required String message,
    String? title,
    Duration duration = const Duration(seconds: 2),
    ToastPosition position = ToastPosition.bottom,
  }) {
    show(
      context,
      message: message,
      title: title ?? '✅ Succès',
      type: ToastType.success,
      duration: duration,
      position: position,
    );
  }

  static void showError(
    BuildContext context, {
    required String message,
    String? title,
    Duration duration = const Duration(seconds: 3),
    ToastPosition position = ToastPosition.bottom,
  }) {
    show(
      context,
      message: message,
      title: title ?? '❌ Erreur',
      type: ToastType.error,
      duration: duration,
      position: position,
    );
  }

  static void showWarning(
    BuildContext context, {
    required String message,
    String? title,
    Duration duration = const Duration(seconds: 2),
    ToastPosition position = ToastPosition.bottom,
  }) {
    show(
      context,
      message: message,
      title: title ?? '⚠️ Attention',
      type: ToastType.warning,
      duration: duration,
      position: position,
    );
  }

  static void showInfo(
    BuildContext context, {
    required String message,
    String? title,
    Duration duration = const Duration(seconds: 2),
    ToastPosition position = ToastPosition.bottom,
  }) {
    show(
      context,
      message: message,
      title: title ?? 'ℹ️ Info',
      type: ToastType.info,
      duration: duration,
      position: position,
    );
  }

  static void showCustom(
    BuildContext context, {
    required String message,
    String? title,
    Widget? icon,
    Color? color,
    Duration duration = const Duration(seconds: 2),
    ToastPosition position = ToastPosition.bottom,
  }) {
    show(
      context,
      message: message,
      title: title,
      type: ToastType.custom,
      icon: icon,
      customColor: color,
      duration: duration,
      position: position,
    );
  }

  // Loading toast
  static void showLoading(
    BuildContext context, {
    String message = 'Chargement...',
    Duration? duration,
  }) {
    show(
      context,
      message: message,
      type: ToastType.custom,
      customColor: AppColors.textSecondary,
      icon: const SizedBox(
        width: 16,
        height: 16,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
        ),
      ),
      duration: duration ?? const Duration(minutes: 5), // Long duration for loading
      dismissible: false,
    );
  }

  static void hideLoading() {
    _fToast?.removeCustomToast();
  }

  // Party/celebration toast with animations
  static void showParty(
    BuildContext context, {
    required String message,
    String title = '🎉 Félicitations !',
    Duration duration = const Duration(seconds: 3),
  }) {
    show(
      context,
      message: message,
      title: title,
      type: ToastType.custom,
      customColor: AppColors.primary,
      duration: duration,
      icon: const _PartyIcon(),
    );
  }

  static Color _getBackgroundColor(ToastType type) {
    switch (type) {
      case ToastType.success:
        return AppColors.success;
      case ToastType.error:
        return AppColors.error;
      case ToastType.warning:
        return AppColors.warning;
      case ToastType.info:
        return AppColors.info;
      case ToastType.custom:
        return AppColors.primary;
    }
  }

  static Color _getTextColor(ToastType type) {
    return AppColors.white;
  }

  static ToastGravity _getGravity(ToastPosition position) {
    switch (position) {
      case ToastPosition.top:
        return ToastGravity.TOP;
      case ToastPosition.center:
        return ToastGravity.CENTER;
      case ToastPosition.bottom:
        return ToastGravity.BOTTOM;
    }
  }

  static IconData _getIcon(ToastType type) {
    switch (type) {
      case ToastType.success:
        return Icons.check_circle;
      case ToastType.error:
        return Icons.error;
      case ToastType.warning:
        return Icons.warning;
      case ToastType.info:
        return Icons.info;
      case ToastType.custom:
        return Icons.notifications;
    }
  }
}

enum ToastPosition {
  top,
  center,
  bottom,
}

class _ToastWidget extends StatefulWidget {
  final String message;
  final ToastType type;
  final String? title;
  final Widget? icon;
  final Color? customColor;
  final bool dismissible;
  final VoidCallback? onDismiss;

  const _ToastWidget({
    required this.message,
    required this.type,
    this.title,
    this.icon,
    this.customColor,
    this.dismissible = true,
    this.onDismiss,
  });

  @override
  State<_ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _scaleController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    ));

    _slideController.forward();
    Future.delayed(const Duration(milliseconds: 100), () {
      _scaleController.forward();
    });
  }

  @override
  void dispose() {
    _slideController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = widget.customColor ?? AppToast._getBackgroundColor(widget.type);
    final textColor = AppToast._getTextColor(widget.type);

    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: backgroundColor.withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 6),
                spreadRadius: 2,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: textColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: widget.icon ??
                    Icon(
                      AppToast._getIcon(widget.type),
                      color: textColor,
                      size: 18,
                    ),
              ),

              const SizedBox(width: 12),

              // Content
              Flexible(
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

              // Dismiss button
              if (widget.dismissible) ...[
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: widget.onDismiss,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: textColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Icon(
                      Icons.close,
                      size: 16,
                      color: textColor,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _PartyIcon extends StatefulWidget {
  const _PartyIcon();

  @override
  State<_PartyIcon> createState() => _PartyIconState();
}

class _PartyIconState extends State<_PartyIcon>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 2,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Transform.rotate(
            angle: _rotationAnimation.value * 3.14159,
            child: const Text(
              '🎉',
              style: TextStyle(fontSize: 16),
            ),
          ),
        );
      },
    );
  }
}
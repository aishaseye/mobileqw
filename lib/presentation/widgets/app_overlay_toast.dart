import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_fonts.dart';

enum OverlayToastType {
  success,
  error,
  warning,
  info,
  celebration,
  loading,
}

class AppOverlayToast {
  static OverlayEntry? _overlayEntry;
  static bool _isShowing = false;

  static void show(
    BuildContext context, {
    required String message,
    OverlayToastType type = OverlayToastType.info,
    Duration duration = const Duration(seconds: 3),
    String? title,
    Widget? customIcon,
    Color? customColor,
    Alignment alignment = Alignment.topCenter,
    EdgeInsets margin = const EdgeInsets.only(top: 100),
    bool dismissible = true,
    VoidCallback? onTap,
  }) {
    // Remove existing toast if showing
    if (_isShowing) {
      hide();
    }

    _isShowing = true;

    _overlayEntry = OverlayEntry(
      builder: (context) => _OverlayToastWidget(
        message: message,
        type: type,
        title: title,
        customIcon: customIcon,
        customColor: customColor,
        alignment: alignment,
        margin: margin,
        dismissible: dismissible,
        onTap: onTap,
        onDismiss: hide,
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);

    // Auto dismiss after duration
    if (type != OverlayToastType.loading) {
      Future.delayed(duration, () {
        hide();
      });
    }
  }

  static void hide() {
    if (_isShowing && _overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
      _isShowing = false;
    }
  }

  static void showSuccess(
    BuildContext context, {
    required String message,
    String? title,
    Duration duration = const Duration(seconds: 2),
    VoidCallback? onTap,
  }) {
    show(
      context,
      message: message,
      title: title ?? 'Succès',
      type: OverlayToastType.success,
      duration: duration,
      onTap: onTap,
    );
  }

  static void showError(
    BuildContext context, {
    required String message,
    String? title,
    Duration duration = const Duration(seconds: 3),
    VoidCallback? onTap,
  }) {
    show(
      context,
      message: message,
      title: title ?? 'Erreur',
      type: OverlayToastType.error,
      duration: duration,
      onTap: onTap,
    );
  }

  static void showWarning(
    BuildContext context, {
    required String message,
    String? title,
    Duration duration = const Duration(seconds: 3),
    VoidCallback? onTap,
  }) {
    show(
      context,
      message: message,
      title: title ?? 'Attention',
      type: OverlayToastType.warning,
      duration: duration,
      onTap: onTap,
    );
  }

  static void showInfo(
    BuildContext context, {
    required String message,
    String? title,
    Duration duration = const Duration(seconds: 2),
    VoidCallback? onTap,
  }) {
    show(
      context,
      message: message,
      title: title ?? 'Information',
      type: OverlayToastType.info,
      duration: duration,
      onTap: onTap,
    );
  }

  static void showLoading(
    BuildContext context, {
    String message = 'Chargement en cours...',
    String? title,
  }) {
    show(
      context,
      message: message,
      title: title,
      type: OverlayToastType.loading,
      dismissible: false,
      alignment: Alignment.center,
    );
  }

  static void showCelebration(
    BuildContext context, {
    required String message,
    String title = 'Félicitations !',
    Duration duration = const Duration(seconds: 4),
    VoidCallback? onTap,
  }) {
    show(
      context,
      message: message,
      title: title,
      type: OverlayToastType.celebration,
      duration: duration,
      onTap: onTap,
    );
  }

  // Special floating bubble toast
  static void showFloatingBubble(
    BuildContext context, {
    required String message,
    OverlayToastType type = OverlayToastType.info,
    Duration duration = const Duration(seconds: 2),
  }) {
    show(
      context,
      message: message,
      type: type,
      duration: duration,
      alignment: Alignment.topCenter,
      margin: const EdgeInsets.only(top: 60),
    );
  }
}

class _OverlayToastWidget extends StatefulWidget {
  final String message;
  final OverlayToastType type;
  final String? title;
  final Widget? customIcon;
  final Color? customColor;
  final Alignment alignment;
  final EdgeInsets margin;
  final bool dismissible;
  final VoidCallback? onTap;
  final VoidCallback onDismiss;

  const _OverlayToastWidget({
    required this.message,
    required this.type,
    this.title,
    this.customIcon,
    this.customColor,
    required this.alignment,
    required this.margin,
    required this.dismissible,
    this.onTap,
    required this.onDismiss,
  });

  @override
  State<_OverlayToastWidget> createState() => _OverlayToastWidgetState();
}

class _OverlayToastWidgetState extends State<_OverlayToastWidget>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _progressController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _progressController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.3,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _progressController,
      curve: Curves.linear,
    ));

    _animationController.forward();

    if (widget.type == OverlayToastType.loading) {
      _progressController.repeat();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Positioned.fill(
          child: Align(
            alignment: widget.alignment,
            child: Container(
              margin: widget.margin,
              child: SlideTransition(
                position: _slideAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: FadeTransition(
                    opacity: _opacityAnimation,
                    child: _buildToastContent(),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildToastContent() {
    final backgroundColor = widget.customColor ?? _getBackgroundColor();
    final textColor = _getTextColor();

    Widget content = Container(
      constraints: const BoxConstraints(maxWidth: 320),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: backgroundColor.withOpacity(0.3),
            blurRadius: 16,
            offset: const Offset(0, 8),
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildIcon(textColor),
          const SizedBox(width: 12),
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
                  const SizedBox(height: 4),
                ],
                Text(
                  widget.message,
                  style: AppFonts.urbanist(
                    fontSize: 13,
                    color: textColor.withOpacity(0.9),
                  ),
                ),
                if (widget.type == OverlayToastType.loading) ...[
                  const SizedBox(height: 8),
                  AnimatedBuilder(
                    animation: _progressAnimation,
                    builder: (context, child) {
                      return LinearProgressIndicator(
                        value: _progressAnimation.value,
                        backgroundColor: textColor.withOpacity(0.3),
                        valueColor: AlwaysStoppedAnimation<Color>(textColor),
                      );
                    },
                  ),
                ],
              ],
            ),
          ),
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
    );

    if (widget.onTap != null) {
      content = GestureDetector(
        onTap: widget.onTap,
        child: content,
      );
    }

    return content;
  }

  Widget _buildIcon(Color textColor) {
    if (widget.customIcon != null) {
      return widget.customIcon!;
    }

    Widget icon;
    switch (widget.type) {
      case OverlayToastType.success:
        icon = Icon(Icons.check_circle, color: textColor, size: 24);
        break;
      case OverlayToastType.error:
        icon = Icon(Icons.error, color: textColor, size: 24);
        break;
      case OverlayToastType.warning:
        icon = Icon(Icons.warning, color: textColor, size: 24);
        break;
      case OverlayToastType.info:
        icon = Icon(Icons.info, color: textColor, size: 24);
        break;
      case OverlayToastType.loading:
        icon = SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(textColor),
          ),
        );
        break;
      case OverlayToastType.celebration:
        icon = _CelebrationIcon(color: textColor);
        break;
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: textColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: icon,
    );
  }

  Color _getBackgroundColor() {
    switch (widget.type) {
      case OverlayToastType.success:
        return AppColors.success;
      case OverlayToastType.error:
        return AppColors.error;
      case OverlayToastType.warning:
        return AppColors.warning;
      case OverlayToastType.info:
        return AppColors.info;
      case OverlayToastType.loading:
        return AppColors.textSecondary;
      case OverlayToastType.celebration:
        return AppColors.primary;
    }
  }

  Color _getTextColor() {
    return AppColors.white;
  }
}

class _CelebrationIcon extends StatefulWidget {
  final Color color;

  const _CelebrationIcon({required this.color});

  @override
  State<_CelebrationIcon> createState() => _CelebrationIconState();
}

class _CelebrationIconState extends State<_CelebrationIcon>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceOut,
    ));

    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 4,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
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
            angle: _rotationAnimation.value * 3.14159 / 2,
            child: Icon(
              Icons.celebration,
              color: widget.color,
              size: 24,
            ),
          ),
        );
      },
    );
  }
}
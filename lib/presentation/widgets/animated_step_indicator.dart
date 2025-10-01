import 'package:flutter/material.dart';
import 'package:qualywatchmobile/core/constants/app_colors.dart';
import 'package:qualywatchmobile/core/constants/app_fonts.dart';

class AnimatedStepIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const AnimatedStepIndicator({
    Key? key,
    required this.currentStep,
    required this.totalSteps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        totalSteps * 2 - 1,
        (index) {
          if (index.isEven) {
            // Step circle
            final stepNumber = (index ~/ 2) + 1;
            final isActive = stepNumber <= currentStep;
            final isCompleted = stepNumber < currentStep;
            return _buildStepCircle(stepNumber, isActive, isCompleted);
          } else {
            // Connector line
            final stepNumber = (index ~/ 2) + 1;
            final isActive = stepNumber < currentStep;
            return _buildConnectorLine(isActive);
          }
        },
      ),
    );
  }

  Widget _buildStepCircle(int stepNumber, bool isActive, bool isCompleted) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      tween: Tween(begin: 0.0, end: isActive ? 1.0 : 0.0),
      builder: (context, value, child) {
        return Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: isActive
                ? LinearGradient(
                    colors: [
                      AppColors.primary,
                      AppColors.primary.withOpacity(0.8),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            color: isActive ? null : Colors.white,
            border: Border.all(
              color: isActive ? AppColors.primary : AppColors.grey.withOpacity(0.5),
              width: 2.5,
            ),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.3 * value),
                      blurRadius: 12 * value,
                      offset: Offset(0, 4 * value),
                    ),
                  ]
                : [],
          ),
          child: Center(
            child: isCompleted
                ? TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.elasticOut,
                    tween: Tween(begin: 0.0, end: 1.0),
                    builder: (context, scaleValue, child) {
                      return Transform.scale(
                        scale: scaleValue,
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 24,
                        ),
                      );
                    },
                  )
                : Text(
                    '$stepNumber',
                    style: AppFonts.urbanist(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: isActive ? Colors.white : AppColors.grey,
                    ),
                  ),
          ),
        );
      },
    );
  }

  Widget _buildConnectorLine(bool isActive) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      tween: Tween(begin: 0.0, end: isActive ? 1.0 : 0.0),
      builder: (context, value, child) {
        return Container(
          width: 48,
          height: 3,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            gradient: LinearGradient(
              colors: [
                isActive ? AppColors.primary : AppColors.grey.withOpacity(0.3),
                isActive
                    ? AppColors.primary.withOpacity(0.6)
                    : AppColors.grey.withOpacity(0.3),
              ],
              stops: [value, value],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        );
      },
    );
  }
}
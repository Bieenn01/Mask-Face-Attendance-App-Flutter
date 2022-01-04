import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/constants.dart';
import '../../core/themes/text.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    required this.label,
    required this.onTap,
    this.isLoading = false,
    this.width,
    this.margin,
    this.padding,
    this.height,
    this.suffixIcon,
    this.prefixIcon,
    this.backgroundColor,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    this.disableBorderRadius = false,
    this.isButtonDisabled = false,
    this.fontSize,
  }) : super(key: key);

  final String label;
  final void Function() onTap;
  final bool isLoading;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Icon? suffixIcon;
  final Icon? prefixIcon;
  final MainAxisAlignment mainAxisAlignment;
  final bool disableBorderRadius;
  final bool isButtonDisabled;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading || isButtonDisabled ? null : onTap,
      borderRadius: AppDefaults.defaulBorderRadius,
      child: AnimatedContainer(
        height: height,
        duration: AppDefaults.defaultDuration,
        margin: margin ?? const EdgeInsets.all(8),
        alignment: Alignment.center,
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: isButtonDisabled
              ? Colors.grey
              : backgroundColor ?? context.theme.primaryColor,
          borderRadius:
              disableBorderRadius ? null : AppDefaults.defaulBorderRadius,
        ),
        width: width,
        child: isLoading
            ? const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 3,
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: mainAxisAlignment,
                children: [
                  prefixIcon != null
                      ? Container(
                          margin: const EdgeInsets.only(right: 5),
                          child: prefixIcon)
                      : const SizedBox(),
                  Text(
                    label,
                    style: AppText.b1.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: fontSize,
                    ),
                  ),
                  suffixIcon != null
                      ? Container(
                          margin: const EdgeInsets.only(left: 5),
                          child: suffixIcon,
                        )
                      : const SizedBox(),
                ],
              ),
      ),
    );
  }
}

class AppButtonOutline extends StatelessWidget {
  const AppButtonOutline({
    Key? key,
    required this.label,
    required this.onTap,
    this.isLoading = false,
    this.width,
    this.margin,
    this.padding,
    this.height,
    this.suffixIcon,
    this.prefixIcon,
    this.color,
  }) : super(key: key);

  final String label;
  final void Function() onTap;
  final bool isLoading;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final Icon? suffixIcon;
  final Icon? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppDefaults.defaulBorderRadius,
      child: AnimatedContainer(
        height: height,
        duration: AppDefaults.defaultDuration,
        margin: margin ?? const EdgeInsets.all(8),
        alignment: Alignment.center,
        padding: padding ??
            const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 14,
            ),
        decoration: BoxDecoration(
          color: Get.theme.canvasColor,
          borderRadius: AppDefaults.defaulBorderRadius,
          border: Border.all(
            color: color ?? context.theme.primaryColor,
          ),
        ),
        width: width,
        child: isLoading
            ? const AspectRatio(
                aspectRatio: 1 / 1,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  prefixIcon != null
                      ? Container(
                          margin: const EdgeInsets.only(right: 5),
                          child: prefixIcon)
                      : const SizedBox(),
                  Text(
                    label,
                    style: AppText.b1.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  suffixIcon != null
                      ? Container(
                          margin: const EdgeInsets.only(left: 5),
                          child: suffixIcon)
                      : const SizedBox(),
                ],
              ),
      ),
    );
  }
}

class CircleIconButton extends StatelessWidget {
  const CircleIconButton({
    Key? key,
    required this.icon,
    required this.onTap,
    this.backgroundColor = AppColors.primaryColor,
  }) : super(key: key);

  final void Function() onTap;
  final Icon icon;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSizes.defaultPadding - 8),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primaryColor,
        ),
        child: icon,
      ),
    );
  }
}
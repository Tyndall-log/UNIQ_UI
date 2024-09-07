import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

export 'package:toastification/toastification.dart';

//https://github.com/payam-zahedi/toastification 참고

class SampleToast {
  static ToastificationItem show({
    required BuildContext context,
    AlignmentGeometry? alignment,
    Duration? autoCloseDuration,
    OverlayState? overlayState,
    ToastificationAnimationBuilder? animationBuilder,
    required ToastificationType type,
    ToastificationStyle style = ToastificationStyle.flat,
    required String title,
    Duration? animationDuration,
    required String description,
    Widget? icon,
    Color? primaryColor,
    Color? backgroundColor,
    Color? foregroundColor,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    BorderRadiusGeometry? borderRadius,
    BorderSide? borderSide,
    List<BoxShadow>? boxShadow,
    TextDirection? direction,
    bool? showProgressBar,
    ProgressIndicatorThemeData? progressBarTheme,
    CloseButtonShowType? closeButtonShowType,
    bool? closeOnClick,
    bool? dragToClose,
    bool? showIcon,
    DismissDirection? dismissDirection,
    bool? pauseOnHover,
    bool? applyBlurEffect,
    ToastificationCallbacks callbacks = const ToastificationCallbacks(),
  }) {
    return toastification.show(
      context: context,
      overlayState: overlayState,
      alignment: alignment ?? Alignment.bottomRight,
      direction: direction,
      autoCloseDuration: autoCloseDuration ?? const Duration(seconds: 5),
      animationBuilder: animationBuilder ??
          (
            context,
            animation,
            alignment,
            child,
          ) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
      animationDuration: animationDuration,
      type: type,
      style: style,
      title: Text(title),
      description: Text(description),
      icon: icon,
      primaryColor: primaryColor,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      padding: padding,
      margin: margin,
      borderRadius: borderRadius ?? BorderRadius.circular(12.0),
      borderSide: borderSide,
      boxShadow: boxShadow,
      showIcon: showIcon,
      showProgressBar: showProgressBar ?? false,
      progressBarTheme: progressBarTheme,
      closeButtonShowType: closeButtonShowType ?? CloseButtonShowType.onHover,
      closeOnClick: closeOnClick ?? true,
      dragToClose: dragToClose ?? true,
      dismissDirection: dismissDirection,
      pauseOnHover: pauseOnHover,
      applyBlurEffect: applyBlurEffect ?? true,
      callbacks: callbacks,
    );
  }
}

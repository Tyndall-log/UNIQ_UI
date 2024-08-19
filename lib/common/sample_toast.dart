import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

export 'package:toastification/toastification.dart';

//https://github.com/payam-zahedi/toastification 참고

class SampleToast {
  static void show({
    required BuildContext context,
    required String title,
    required String description,
    required ToastificationType type,
    int duration = 5,
  }) {
    toastification.show(
      context: context,
      type: type,
      style: ToastificationStyle.flat,
      title: Text(title),
      description: Text(description),
      alignment: Alignment.bottomRight,
      autoCloseDuration: Duration(seconds: duration),
      animationBuilder: (
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
      borderRadius: BorderRadius.circular(12.0),
      // boxShadow: highModeShadow,
      showProgressBar: false,
      closeButtonShowType: CloseButtonShowType.onHover,
      closeOnClick: true,
      dragToClose: true,
      applyBlurEffect: true,
    );
  }
}

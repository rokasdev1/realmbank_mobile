import 'dart:async';
import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:realmbank_mobile/data/enums/toast_type.dart';
import 'package:realmbank_mobile/main.dart';
import 'package:realmbank_mobile/presentation/common/utils/extensions.dart';

class MessageToaster {
  static bool _isShowingToast = false;
  static Timer? _timer;
  static FToast? _fToast;

  static void showMessage({
    required String message,
    required ToastType toastType,
    ToastGravity toastGravity = ToastGravity.TOP,
    String? secondaryMessage,
    Function()? onDismiss,
  }) {
    final context = router.router.routerDelegate.navigatorKey.currentContext;
    if (context == null) return;
    void hideToast() {
      _fToast?.removeCustomToast();
      _isShowingToast = false;
      _timer?.cancel();
    }

    if (_isShowingToast) {
      hideToast();
    }

    final Color color;
    IconData toastIcon;
    switch (toastType) {
      case ToastType.success:
        color = Colors.green;
        toastIcon = Icons.check;
      case ToastType.error:
        color = Colors.red;
        toastIcon = Icons.error_outline;
      case ToastType.warning:
        color = Colors.orange.shade300;
        toastIcon = Icons.warning_amber_rounded;
      case ToastType.info:
        color = Colors.blue;
        toastIcon = Icons.info_outline;
    }

    _fToast = FToast();
    _fToast!.init(context).showToast(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: GestureDetector(
              onTap: () {
                hideToast();
                if (onDismiss != null) onDismiss();
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: color,
                      ),
                      child: Icon(
                        toastIcon,
                        color: Colors.white,
                      ),
                    ),
                    16.widthBox,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            message,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          if (secondaryMessage != null)
                            Text(
                              secondaryMessage,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                        ],
                      ),
                    ),
                    if (onDismiss != null)
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.black,
                        size: 16,
                      ),
                  ],
                ),
              ),
            ),
          ),
          gravity: toastGravity,
          toastDuration: const Duration(seconds: 3),
        );

    _isShowingToast = true;
    _timer = Timer.periodic(
      const Duration(seconds: 3),
      (timer) {
        _isShowingToast = false;
        timer.cancel();
      },
    );
  }
}

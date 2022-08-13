import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'constraints.dart';

bool isProgressOpen = false;

class Utils {
  static showProgress(
    BuildContext context, [
    bool? useRoot,
    String? msg,
    Function()? onCancel,
  ]) {
    if (isProgressOpen) {
      return false;
    }
    isProgressOpen = true;

    showDialog(
      useRootNavigator: (useRoot == null) ? false : useRoot,
      barrierDismissible: false,
      context: context,
      builder: (_) => Material(
        color: Colors.transparent,
        child: WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Container(
            width: 200,
            height: 200,
            margin: const EdgeInsets.only(
              left: 24,
              right: 24,
            ),
            decoration: const BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.all(
                Radius.circular(3),
              ),
            ),
            child: Image.asset(
              imgLoader,
            ),
          ),
        ),
      ),
    ).then((value) {
      isProgressOpen = false;
    });
  }

  static void dismissProgress(
    BuildContext context, [
    bool? useRoot,
  ]) {
    if (isProgressOpen) {
      Navigator.of(context, rootNavigator: (useRoot == null) ? false : useRoot)
          .pop();
    }
  }

  static showAlert({
    required String strMsg,
    required BuildContext context,
    Color? textColor,
  }) {
    showDialog(
      context: context,
      builder: (bContext) {
        return PlatformAlertDialog(
          title: Text(
            strMsg,
            style: TextStyle(
              color: (textColor == null) ? Colors.black : textColor,
            ),
          ),
          actions: [
            PlatformDialogAction(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

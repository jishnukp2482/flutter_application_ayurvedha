import 'package:flutter/material.dart';
import 'package:get/get.dart';

void customAlertDialogue({
  required String title,
  required String content,
  String? txtbuttonName1,
  Function? txtbutton1Action,
  String? txtbuttonName2,
  Function? txtbutton2Action,
  bool? errorField = false,
  IconData? icon,
}) {
  // Create animation controller with navigator as vsync
  final animationController = AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: Navigator.of(Get.context!),
  );

  Get.dialog(
    barrierDismissible: false,
    PopScope(
      canPop: false,
      child: Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: ScaleTransition(
          scale: CurvedAnimation(
            parent: animationController,
            curve: Curves.elasticInOut,
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Get.theme.colorScheme.background,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  spreadRadius: 3,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null)
                  Container(
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                      color:
                          errorField == true
                              ? Colors.red.withOpacity(0.1)
                              : Get.theme.primaryColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon,
                      size: 30,
                      color:
                          errorField == true
                              ? Colors.red
                              : Get.theme.primaryColor,
                    ),
                  ),
                Text(
                  title,
                  style: Get.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color:
                        errorField == true
                            ? Colors.red
                            : Get.theme.primaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
                Text(
                  content,
                  style: Get.textTheme.bodyMedium?.copyWith(
                    color:
                        errorField == true
                            ? Colors.red.shade700
                            : Get.theme.colorScheme.onBackground.withOpacity(
                              0.8,
                            ),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (txtbutton1Action != null)
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.withOpacity(0.2),
                          foregroundColor: Get.theme.colorScheme.onBackground,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                        ),
                        onPressed: () {
                          txtbutton1Action();
                        },
                        child: Text(txtbuttonName1 ?? 'Cancel'),
                      ),
                    if (txtbutton1Action != null && txtbutton2Action != null)
                      const SizedBox(width: 15),
                    if (txtbutton2Action != null)
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              errorField == true
                                  ? Colors.red
                                  : Get.theme.primaryColor,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                        ),
                        onPressed: () {
                          txtbutton2Action();
                        },
                        child: Text(txtbuttonName2 ?? 'OK'),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );

  // Start animation when dialog appears
  animationController.forward();
}

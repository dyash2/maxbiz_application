import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:maxbazaar/core/themes.dart';

class Utils {
  /// Show location permission modal
  static void showPermissionModal(BuildContext context) {
    bool permanentlyDenied = false;

    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                "assets/lottie/locationUser.json",
                height: 100,
                width: 100,
              ),
              const SizedBox(height: 16),
              Text(
                "Your Device's Location Service Is Off.",
                style: AppFonts.lexendExtraBold.copyWith(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                "To ensure the best delivery service, please enable location permission",
                textAlign: TextAlign.center,
                style: AppFonts.lexendBold.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.shade700,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () async {
                    Navigator.pop(context);

                    final status = await Permission.location.request();

                    if (status.isGranted) {
                      debugPrint("✅ Location granted after retry");
                    } else if (status.isPermanentlyDenied) {
                      permanentlyDenied = true;
                      await openAppSettings();
                    } else {
                      Future.delayed(
                        const Duration(milliseconds: 300),
                        () => showPermissionModal(context),
                      );
                    }
                  },
                  child: Text(
                    permanentlyDenied ? "Open Settings" : "Use My Location",
                    style: AppFonts.lexendBold.copyWith(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

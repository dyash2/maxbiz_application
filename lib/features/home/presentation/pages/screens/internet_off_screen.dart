import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:maxbazaar/core/themes.dart';
import 'package:maxbazaar/core/utils/snackbar_utils.dart';
import 'package:maxbazaar/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:maxbazaar/features/auth/presentation/bloc/auth_state.dart';
import 'package:maxbazaar/features/auth/presentation/widgets/custom_button.dart';
import 'package:maxbazaar/features/home/presentation/pages/home_page.dart';

class InternetOffScreen extends StatefulWidget {
  const InternetOffScreen({super.key});

  @override
  State<InternetOffScreen> createState() => _InternetOffScreenState();
}

class _InternetOffScreenState extends State<InternetOffScreen> {
  bool _isChecking = false;

  Future<bool> _checkInternet() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  void _retry() async {
    setState(() => _isChecking = true);

    final hasInternet = await _checkInternet();

    setState(() => _isChecking = false);

    if (hasInternet) {
      if (context.mounted) {
        SnackBarUtils.showSuccess(context, "You are back online!");

        // You can now re-trigger your Auth event or navigate back
        Navigator.pop(context);
      }
    } else {
      if (context.mounted) {
        SnackBarUtils.showError(
          context,
          "Still offline. Please check your connection.",
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        // Example: navigate to home if authenticated
        if (state is AuthAuthenticatedState) {
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(builder: (context) => HomePage()),
          // );
        } else if (state is AuthErrorState) {
          // SnackBarUtils.showError(context, state.message);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.05,
              vertical: height * 0.02,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Current State :${state}"),
                  // Responsive Lottie
                  Lottie.asset(
                    "assets/lottie/offline.json",
                    height: height * 0.35,
                    width: width * 0.7,
                  ),

                  SizedBox(height: height * 0.03),

                  // Text block
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                    child: Column(
                      children: [
                        Text(
                          "NO INTERNET CONNECTION!",
                          style: AppFonts.lexendExtraBold.copyWith(
                            fontSize: width * 0.05,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: height * 0.01),
                        Text(
                          "It seems that you are offline. Please connect to a network. Offline services are not available.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: width * 0.04,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: height * 0.04),

                  // Retry Button
                  CustomButton(
                    bgColor: AppColors.primaryColor,
                    text: _isChecking ? "Checking..." : "Retry",
                    onPressed: _isChecking ? null : _retry,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

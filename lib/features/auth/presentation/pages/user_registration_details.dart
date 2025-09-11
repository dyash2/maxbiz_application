import 'package:flutter/material.dart';
import 'package:maxbazaar/core/themes.dart';
import 'package:maxbazaar/core/utils/snackbar_utils.dart';
import 'package:maxbazaar/features/auth/presentation/widgets/custom_button.dart';
import 'package:maxbazaar/features/auth/presentation/widgets/textfield_widget.dart';

class RegistrationDetails extends StatefulWidget {
  const RegistrationDetails({super.key});

  @override
  State<RegistrationDetails> createState() => _RegistrationDetailsState();
}

class _RegistrationDetailsState extends State<RegistrationDetails> {
  final TextEditingController _firstNameCtrl = TextEditingController();
  final TextEditingController _lastNameCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      resizeToAvoidBottomInset: true, // ✅ lets the screen adjust for keyboard
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: constraints.maxHeight * 0.05, // responsive top padding
                bottom:
                    MediaQuery.of(context).viewInsets.bottom +
                    20, // space for keyboard
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight * 0.9,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 🟢 Title
                      Text(
                        "Almost done ✨",
                        style: AppFonts.lexendBold.copyWith(
                          fontSize: 26,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // 🟢 Subtitle
                      Text(
                        "It only takes a minute to join us",
                        style: AppFonts.lexendMedium.copyWith(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 32),

                      // 🟢 Form Fields
                      CustomTextField(
                        primaryText: "Enter Your First Name",
                        controller: _firstNameCtrl,
                        requiredField: true,
                        hintText: "First Name",
                        prefixIcon: Icons.person,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        primaryText: "Enter Your Last Name",
                        controller: _lastNameCtrl,
                        hintText: "Last Name",
                        prefixIcon: Icons.person_outline,
                      ),
                      const SizedBox(height: 16),

                      SizedBox(
                        width: double.infinity,
                        child: CustomButton(
                          bgColor: Colors.orange.shade400,
                          text: "Continue",
                          onPressed: () {
                            if (_firstNameCtrl.text.trim().isEmpty) {
                              SnackBarUtils.showError(
                                context,
                                "Please enter your first name",
                              );
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

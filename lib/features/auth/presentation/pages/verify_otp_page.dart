import 'package:flutter/material.dart';
import 'package:maxbiz_app/core/themes.dart';

class VerifyOtpPage extends StatefulWidget {
  const VerifyOtpPage({super.key});

  @override
  State<VerifyOtpPage> createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends State<VerifyOtpPage> {
  final TextEditingController _otpController = TextEditingController();
  int _secondsRemaining = 60;
  int? otp = 6906;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (_secondsRemaining == 0) return false;
      setState(() {
        _secondsRemaining--;
      });
      return true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.orange),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              const SizedBox(height: 20),

              // Title
              Text(
                "Verify OTP",
                style: AppFonts.lexendExtraBold.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: 10),

              // Phone Number
              Text(
                "+91 9190*****07",
                style: AppFonts.lexendExtraBold.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                  fontSize: 20,
                ),
              ),

              const SizedBox(height: 10),
              // OTP Number
              Text(
                otp != null ? "$otp" : "",
                style: AppFonts.lexendBold.copyWith(
                  fontWeight: FontWeight.bold,

                  fontSize: 20,
                ),
              ),

              const SizedBox(height: 60),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                spacing: 10,
                children: List.generate(4, (index) {
                  return Expanded(
                    child: AspectRatio(
                      aspectRatio: 1, // square
                      child: TextField(
                        maxLength: 1, // only one digit
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        cursorColor: index == 0 ? Colors.white : Colors.orange,
                        style: AppFonts.lexendExtraBold.copyWith(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: index == 0 ? Colors.white : Colors.orange,
                        ),
                        decoration: InputDecoration(
                          counterText: "",
                          filled: true,
                          fillColor: index == 0
                              ? Colors.orange[700]
                              : Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),

              // const SizedBox(height: 20),

              // Didn't receive OTP?
              Center(
                child: Text(
                  "Didn't receive OTP?",
                  style: AppFonts.lexendBold.copyWith(
                    fontSize: 14,
                    color: Colors.grey.shade500,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Timer
              Center(
                child: Text(
                  "00:${_secondsRemaining.toString().padLeft(2, '0')}",
                  style: AppFonts.lexendBold.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),

              const Spacer(),

              // Verify OTP Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey.shade300,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Verify OTP",
                    style: AppFonts.lexendExtraBold.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

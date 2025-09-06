import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maxbiz_app/features/auth/domain/usecases/login_user.dart';
import 'package:maxbiz_app/features/auth/domain/usecases/logout_user.dart';
import 'package:maxbiz_app/features/auth/domain/usecases/register_user.dart';
import 'package:maxbiz_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:maxbiz_app/features/auth/presentation/pages/register_page.dart';
import 'package:maxbiz_app/features/auth/presentation/pages/verify_otp_page.dart';
import 'package:maxbiz_app/injection_dependency.dart';

void main() {
  // Intialize Flutter before build
  WidgetsFlutterBinding.ensureInitialized();

  // Inject the DI
  setup();

  // entry point of the application
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(
            loginUser: LoginUser(locator()),
            registerUser: RegisterUser(locator()),
            logoutUser: LogoutUser(locator()),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Max Bazaar',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: VerifyOtpPage(),
      ),
    );
  }
}

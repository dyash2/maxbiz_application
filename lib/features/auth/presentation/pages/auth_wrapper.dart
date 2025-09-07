// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:maxbiz_app/features/auth/presentation/bloc/auth_bloc.dart';
// import 'package:maxbiz_app/features/auth/presentation/bloc/auth_state.dart';
// import 'package:maxbiz_app/features/auth/presentation/pages/login_page.dart';
// import 'package:maxbiz_app/features/auth/presentation/pages/register_page.dart';
// import 'package:maxbiz_app/features/auth/presentation/pages/splash_page.dart';
// import 'package:maxbiz_app/features/presentation/pages/home_page.dart';
// import 'package:maxbiz_app/features/presentation/pages/screen/error_screen.dart';

// class AuthWrapper extends StatelessWidget {
//   const AuthWrapper({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AuthBloc, AuthState>(
//       builder: (context, state) {
//         switch (state.status) {
//           case AuthStatus.initial:
//             return const SplashPage();

//           case AuthStatus.loading:
//             return const Scaffold(
//               body: Center(child: CircularProgressIndicator()),
//             );
//           case AuthStatus.register:
//             return const RegisterPage();

//           case AuthStatus.authenticated:
//             return const HomePage();

//           case AuthStatus.unauthenticated:
//             return LoginPage();

//           case AuthStatus.error:
//             return ErrorScreen(message: state.errorMessage);
//         }
//       },
//     );
//   }
// }

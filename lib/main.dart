import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maxbazaar/core/themes.dart';
import 'package:maxbazaar/features/auth/presentation/pages/splash_page.dart';

import 'package:maxbazaar/injection_dependency.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';

void main() async {
  // Intialize the flutter binding
  WidgetsFlutterBinding.ensureInitialized();

  // Inject the DI
  await setup();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<AuthBloc>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashPage(),
        title: 'Max Bazaar',
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: AppColors.primaryColor,
          fontFamily: 'Lexend',
        ),
      ),
    );
  }
}

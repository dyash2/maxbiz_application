import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maxbiz_app/features/auth/domain/entities/user.dart';
import 'package:maxbiz_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:maxbiz_app/features/auth/presentation/bloc/auth_event.dart';


class HomePage extends StatelessWidget {
  final User user;
  const HomePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome ${user.username}'),
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthBloc>().add(const LogoutRequestedEvent());
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Email: ${user.email}'),
            const SizedBox(height: 8),
            Text(
              'Access token (truncated): ${user.accessToken.substring(0, 16)}...',
            ),
            const SizedBox(height: 8),
            Text(
              'Refresh token (truncated): ${user.refreshToken.substring(0, 16)}...',
            ),
            const SizedBox(height: 24),
            const Text(
              'Try making any authorized Dio request.\n'
              'If the server returns 401, the interceptor auto-refreshes and retries.',
            ),
          ],
        ),
      ),
    );
  }
}

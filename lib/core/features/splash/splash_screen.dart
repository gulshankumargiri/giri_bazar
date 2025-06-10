import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giri_bazar/core/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:giri_bazar/core/features/auth/presentation/bloc/auth_event.dart';

import '../auth/presentation/bloc/auth_state.dart';
import '../auth/presentation/login_page.dart';
import '../auth/user_profile.dart';

class SplashScreen extends StatelessWidget {
  final String? initalToken;

  const SplashScreen({super.key, this.initalToken, String? initialToken});

  @override
  Widget build(BuildContext context) {
    if (initalToken != null && initalToken!.isNotEmpty) {
      Future.microtask(() {
        context.read<AuthBloc>().add(CheckLoginStatus());
      });
    }

    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => UserProfile(userData: state.user),
              ),
            );
          } else if (state is AuthInitial || state is AuthFailure) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => LoginPage()),
            );
          }
        },
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}


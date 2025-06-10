import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giri_bazar/core/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:giri_bazar/core/features/auth/presentation/bloc/auth_event.dart';
import 'package:giri_bazar/core/features/auth/presentation/bloc/auth_state.dart';
import 'package:giri_bazar/core/features/auth/presentation/login_page.dart';
import 'package:giri_bazar/core/test_page.dart';

class AuthCheckGate extends StatefulWidget {
  const AuthCheckGate({super.key});

  @override
  State<AuthCheckGate> createState() => _AuthCheckGateState();
}

class _AuthCheckGateState extends State<AuthCheckGate> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(CheckLoginStatus());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AuthSuccess) {
            return TestPage(userData: state.user);
          } else {
            return LoginPage();
          }
        },
      ),
    );
  }
}

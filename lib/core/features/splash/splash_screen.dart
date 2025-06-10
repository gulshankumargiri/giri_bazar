import 'package:flutter/material.dart';
import 'package:giri_bazar/core/features/auth/auth_chec_gate.dart';

class SplashScreen extends StatelessWidget {
  final String? initalToken;
  const SplashScreen({super.key, this.initalToken});

  @override
  Widget build(BuildContext context) {
    Future.microtask(() {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const AuthCheckGate()),
      );
    });

    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

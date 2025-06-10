import 'package:flutter/material.dart';

import 'features/auth/user_profile.dart';

class TestPage extends StatelessWidget {
  final Map<String, dynamic> userData;
  const TestPage({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Test Page')),
      body: const Center(child: Text('This is test page')),
      drawer: UserProfile(userData: userData), // ✅ pass actual user data here
    );
  }
}

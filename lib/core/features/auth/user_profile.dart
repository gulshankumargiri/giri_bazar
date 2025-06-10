import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  final Map<String, dynamic> userData;

  const UserProfile({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Profile')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("👤 Name: ${userData['firstName']} ${userData['lastName']}"),
            Text("📧 Email: ${userData['email']}"),
            Text("🔑 Token: ${userData['token']}"),
          ],
        ),
      ),
    );
  }
}

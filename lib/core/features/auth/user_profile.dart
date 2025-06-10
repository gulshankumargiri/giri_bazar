import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  final Map<String, dynamic> userData;

  const UserProfile({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40)),
        const SizedBox(height: 20),
        Text('Name: ${userData['firstName']} ${userData['lastName']}'),
        Text('Email: ${userData['email']}'),
        Text('Username: ${userData['username']}'),
      ],
    );
  }
}

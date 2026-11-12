import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(
              child: CircleAvatar(
                radius: 48,
                backgroundColor: Colors.indigo,
                child: Icon(
                  Icons.person,
                  size: 52,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'LOURDE VINCENT M. PABLO',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              'BSIT — CCE106L (3447)',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[700],
                  ),
            ),
            const SizedBox(height: 24),
            Card(
              elevation: 2,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.person_outline, color: Colors.indigo),
                    title: Text('Full Name'),
                    subtitle: Text('LOURDE VINCENT M. PABLO'),
                  ),
                  Divider(height: 1),
                  ListTile(
                    leading: Icon(Icons.badge_outlined, color: Colors.indigo),
                    title: Text('Student ID'),
                    subtitle: Text('553470'),
                  ),
                  Divider(height: 1),
                  ListTile(
                    leading: Icon(Icons.school_outlined, color: Colors.indigo),
                    title: Text('Course and Section'),
                    subtitle: Text('BSIT — CCE106L (3447)'),
                  ),
                  Divider(height: 1),
                  ListTile(
                    leading: Icon(Icons.email_outlined, color: Colors.indigo),
                    title: Text('Email Address'),
                    subtitle: Text('lourdevincentpablo26@gmail.com'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

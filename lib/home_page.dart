import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.home,
              size: 72,
              color: Colors.indigo,
            ),
            const SizedBox(height: 16),
            Text(
              'Welcome, Student!',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Use the navigation bar below to explore the app.',
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
                    leading: Icon(Icons.calculate, color: Colors.indigo),
                    title: Text(
                      'Calculator',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text('Perform basic arithmetic operations.'),
                  ),
                  Divider(height: 1),
                  ListTile(
                    leading: Icon(Icons.person, color: Colors.indigo),
                    title: Text(
                      'Profile',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text('View your student information.'),
                  ),
                  Divider(height: 1),
                  ListTile(
                    leading: Icon(Icons.share, color: Colors.indigo),
                    title: Text(
                      'Social Media',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text('View your sample social accounts.'),
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

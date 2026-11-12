import 'package:flutter/material.dart';

class SocialMediaPage extends StatelessWidget {
  const SocialMediaPage({super.key});

  void showAccount(BuildContext context, String platform, String username) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('Selected account: $platform: $username'),
        ),
      );
  }

  Widget _buildAccountCard({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String platform,
    required String username,
  }) {
    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: Icon(icon, color: iconColor, size: 32),
        title: Text(
          platform,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(username),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => showAccount(context, platform, username),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Social Media'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Connect With Me',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Tap an account to display its username.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[700],
                  ),
            ),
            const SizedBox(height: 24),
            _buildAccountCard(
              context: context,
              icon: Icons.facebook,
              iconColor: Colors.blue,
              platform: 'Facebook',
              username: 'Lourde Vincent',
            ),
            const SizedBox(height: 12),
            _buildAccountCard(
              context: context,
              icon: Icons.camera_alt,
              iconColor: Colors.pink,
              platform: 'Instagram',
              username: '@lrdvncnt_',
            ),
            const SizedBox(height: 12),
            _buildAccountCard(
              context: context,
              icon: Icons.play_circle,
              iconColor: Colors.red,
              platform: 'YouTube',
              username: '@VtechChannel',
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil Pengguna')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [AppColors.accent, AppColors.accentStrong],
                ),
              ),
              child: const CircleAvatar(
                radius: 48,
                backgroundColor: AppColors.surface,
                child: Icon(Icons.person, size: 48, color: Colors.white),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Mahasiswa Unigal',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              'Universitas Galuh',
              style: TextStyle(color: AppColors.textSoft),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE53888),
              ),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
                );
              },
              icon: const Icon(Icons.logout),
              label: const Text('Keluar (Logout)'),
            ),
          ],
        ),
      ),
    );
  }
}
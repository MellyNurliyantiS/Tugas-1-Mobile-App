import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/gradient_background.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard Unigal')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.accentStrong, Color(0xFF5B2A9A)],
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: AppColors.accentStrong.withValues(alpha: 0.4),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: const Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Selamat Datang di',
                          style: TextStyle(color: Colors.white70)),
                      SizedBox(height: 4),
                      Text(
                        'Unigal Apps!',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Semua info kampus dalam satu aplikasi.',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.school, size: 56, color: Colors.white54),
              ],
            ),
          ),
          const SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.25,
            children: const [
              _MenuCard(icon: Icons.campaign, label: 'Pengumuman'),
              _MenuCard(icon: Icons.calendar_month, label: 'Jadwal Kuliah'),
            ],
          ),
        ],
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  final IconData icon;
  final String label;

  const _MenuCard({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.accentStrong.withValues(alpha: 0.35),
              ),
              child: Icon(icon, size: 28, color: Colors.white),
            ),
            const SizedBox(height: 10),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
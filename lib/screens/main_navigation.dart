import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/gradient_background.dart';
import 'crud_screen.dart';
import 'dashboard_screen.dart';
import 'post_page.dart';
import 'profile_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    DashboardScreen(),
    PostPage(),
    CrudScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        // IndexedStack: data tiap tab tidak hilang saat pindah tab
        body: IndexedStack(index: _selectedIndex, children: _screens),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _selectedIndex,
          backgroundColor: AppColors.bgBottom.withValues(alpha: 0.95),
          indicatorColor: AppColors.accentStrong.withValues(alpha: 0.55),
          onDestinationSelected: (i) => setState(() => _selectedIndex = i),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.dashboard_outlined),
              selectedIcon: Icon(Icons.dashboard),
              label: 'Dashboard',
            ),
            NavigationDestination(
              icon: Icon(Icons.newspaper),
              label: 'Berita',
            ),
            NavigationDestination(
              icon: Icon(Icons.edit_note),
              label: 'Kelola Data',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
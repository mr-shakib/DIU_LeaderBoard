import 'package:flutter/material.dart';
import 'package:flutter_first/Screens/main_screens/academic_performance.dart';
import 'package:flutter_first/Screens/main_screens/ai_recommendations.dart';
import 'package:flutter_first/Screens/main_screens/home.dart';
import 'package:flutter_first/Screens/main_screens/profile.dart';
import 'package:flutter_first/Screens/main_screens/settings_view.dart';
import '../../models/student_model.dart';
import '../../services/auth_service.dart';


class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  final _auth = AuthService();
  int _selectedIndex = 2;
  
  // Temporary mock student info - replace with actual data later
  final studentInfo = StudentInfo(
    studentId: '201-15-3000',
    studentName: 'John Doe',
    programName: 'BSc in CSE',
    departmentName: 'CSE',
    batchNo: '201',
    shift: 'Day',
  );
  
  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      AIRecommendationsPage(userId: _auth.getCurrentUserId() ?? ''),
      const AcademicPerformancePage(),
      const HomePage(),
      const SettingsView(),
      const ProfilePage(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        height: size.height * 0.08, // 8% of screen height
        child: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: _onItemTapped,
          backgroundColor: NavigationBarTheme.of(context).backgroundColor,
          indicatorColor: NavigationBarTheme.of(context).indicatorColor,
          surfaceTintColor: Colors.transparent,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          destinations: [
            _buildNavigationDestination(
              icon: Icons.analytics,
              label: 'Analyze',
              size: size,
            ),
            _buildNavigationDestination(
              icon: Icons.assignment,
              label: 'Results',
              size: size,
            ),
            _buildNavigationDestination(
              icon: Icons.leaderboard,
              label: 'Leaderboard',
              size: size,
            ),
            _buildNavigationDestination(
              icon: Icons.settings,
              label: 'Settings',
              size: size,
            ),
            _buildNavigationDestination(
              icon: Icons.person,
              label: 'Profile',
              size: size,
            ),
          ],
        ),
      ),
    );
  }

  NavigationDestination _buildNavigationDestination({
    required IconData icon,
    required String label,
    required Size size,
  }) {
    return NavigationDestination(
      icon: Icon(
        icon, 
        color: Theme.of(context).colorScheme.onSurface,
        size: size.width * 0.06, // 6% of screen width
      ),
      selectedIcon: Icon(
        icon,
        color: Colors.white,
        size: size.width * 0.065, // Slightly larger when selected
      ),
      label: label,
    );
  }
} 
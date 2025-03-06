import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:leave_management/apply/page1.dart';
import 'package:leave_management/profile/page1.dart'; // Import ProfilePage

void main() {
  runApp(const LeaveApp());
}

class LeaveApp extends StatelessWidget {
  const LeaveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Raleway-Medium',
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 16),
          titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      home: const Page1(),
    );
  }
}

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  int _selectedIndex = 0;
  double _opacity = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const ApplyPage(),
    const NotificationPage(),
    const ProfilePage1(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 0), () {
      setState(() {
        _opacity = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: AnimatedOpacity(
        opacity: _opacity,
        duration: const Duration(milliseconds: 1000),
        child: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
      ),
      bottomNavigationBar: _CustomNavigationButtons(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Good Morning,',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Kamal',
                  style: TextStyle(
                    color: Colors.teal[400],
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: double.infinity,
                  child: Image.asset(
                    'assets/images/background.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 18),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  children: [
                    _buildInfoCard('08:45 AM', 'Checked in', Colors.teal[400]!, Colors.black),
                    _buildInfoCard('01:30 PM', 'Lunch in', Colors.grey[800]!, Colors.white),
                    _buildInfoCard('02:00 PM', 'Lunch out', Colors.grey[800]!, Colors.white),
                    _buildInfoCard('05:15 PM', 'Checked out', Colors.grey[800]!, Colors.white),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.grey[400]),
                      const SizedBox(width: 8),
                      const Text(
                        'Salzer Electronics Limited Unit II',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String subtitle, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              color: textColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              color: textColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          'Notification Page',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          'Profile Page',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _CustomNavigationButtons extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _CustomNavigationButtons({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            offset: const Offset(4.0, 4.0),
            blurRadius: 10,
            spreadRadius: 1.0,
          ),
          const BoxShadow(
            color: Color.fromARGB(255, 0, 0, 0),
            offset: Offset(-4.0, -4.0),
            blurRadius: 10,
            spreadRadius: 1.0,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavButton('assets/svgs/home.svg', 'Home', 0),
          _buildNavButton('assets/svgs/apply.svg', 'Apply', 1),
          _buildNavButton('assets/svgs/notification.svg', 'Notification', 2),
          _buildNavButton('assets/svgs/profile.svg', 'Profile', 3),
        ],
      ),
    );
  }

  Widget _buildNavButton(String iconPath, String label, int index) {
    final isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: isSelected
                ? BoxDecoration(
                    color: AppColors.color1.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(16),
                  )
                : null,
            child: SvgPicture.asset(
              iconPath,
              width: 24,
              height: 24,
              color: isSelected ? const Color.fromARGB(255, 0, 0, 0) : Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? const Color.fromARGB(255, 0, 0, 0) : Colors.grey,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

class AppColors {
  static const Color color1 = Color(0xFF008080);
  static const Color iconColor2 = Color(0xFF000000);
}

import 'package:flutter/material.dart';
import 'package:portfolio_creator/ui/profile_page.dart';
import 'package:portfolio_creator/ui/view_profile.dart';
import 'package:portfolio_creator/utils/logout.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int selectedIndex = 0;

  List<Widget> screens = [ProfilePage(), ViewProfile()];

  void onTapSelectItem(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Portfolio Maker',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.purple,
        elevation: 5,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              logout(context);
            },
            icon: Icon(Icons.logout_outlined, size: 25, color: Colors.white),
          ),
        ],
      ),
      body: screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.purple,
        elevation: 2,
        currentIndex: selectedIndex,
        selectedItemColor: Colors.white,
        onTap: onTapSelectItem,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Portfolio"),
        ],
      ),
    );
  }
}

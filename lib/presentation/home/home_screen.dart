import 'package:busha_app/gen/assets.gen.dart';
import 'package:busha_app/presentation/home/explore/explore_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  void _setCurrentIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: GoogleFonts.inter(
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        elevation: 10,
        onTap: _setCurrentIndex,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            activeIcon: Icon(Icons.explore, color: Colors.black),
            label: "Explore",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(Assets.svg.icWalletOutlined, width: 20),
            label: "Portfolio",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(Assets.svg.icPercentOutline, width: 20),
            label: "Earn",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(Assets.svg.icSpendOutline, width: 20),
            label: "Spend",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(Assets.svg.icConnect, width: 20),
            label: "Connect",
          ),
        ],
      ),
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex,
          children: [
            const ExploreScreen(),
            for(int i =0; i < 4; i++)
              Container()
          ],
        ),
      ),
    );
  }
}

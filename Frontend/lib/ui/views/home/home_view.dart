import 'package:bottom_bar/bottom_bar.dart';
import 'package:distanciapp/constants/colors.dart';
import 'package:distanciapp/ui/views/home/alertsH.dart';
import 'package:distanciapp/ui/views/home/network.dart';
import 'package:distanciapp/ui/views/home/profile.dart';
import 'package:distanciapp/ui/views/home/map.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import "package:salomon_bottom_bar/salomon_bottom_bar.dart";
// colores https://api.flutter.dev/flutter/material/Colors-class.html
class HomeView extends StatefulWidget {
  static const title = 'salomon_bottom_bar';
  const HomeView({Key? key, required User user})
      : _user = user,
        super(key: key);

  final User _user;
  _HomeView createState() => _HomeView();
}
class _HomeView extends State<HomeView> {
  late User _user;
  int _currentIndex = 0;
  final _pageController = PageController();
  int _currentPage = 0;
  @override
  void initState() {
    _user = widget._user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(
        //title: Text("Distance Alert!"),
        //automaticallyImplyLeading: false,
        //backgroundColor: AppColors.mainColor,
        //elevation: 0,
      //),
      body: PageView(
        controller: _pageController,
        children: [
          nearbyU(),
          Network(),
          Maps(),
          Profile(user: _user,),
        ],
        onPageChanged: (index) {
          setState(() => _currentPage = index);
        },
      ),

      bottomNavigationBar: BottomBar(
        selectedIndex: _currentPage,
        onTap: (int index) {
          _pageController.jumpToPage(index);
          setState(() => _currentPage = index);
        },
        items: <BottomBarItem>[
          BottomBarItem( //Icons.notifications_active_rounded
            icon: Icon(Icons.supervisor_account_rounded),
            title: Text('Alerts History'),
            activeColor: Colors.blue,
          ),
          BottomBarItem(
            icon: Icon(Icons.network_check_rounded ),
            title: Text('Network Data'),
            activeColor: Colors.red,
            darkActiveColor: Colors.red.shade400,
          ),
          BottomBarItem(
            icon: Icon(Icons.map_rounded ),
            title: Text("View Map"),
            activeColor: Colors.greenAccent.shade700,
            darkActiveColor: Colors.greenAccent.shade400,
          ),
          BottomBarItem(
            icon: Icon(Icons.person),
            title: Text("User Profile"),
            activeColor: Colors.orange,
          ),
        ],
      ),
    );
  }
}
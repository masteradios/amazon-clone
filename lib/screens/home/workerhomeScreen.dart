import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:hiten/account/accountScreen.dart';
import 'package:hiten/admin/screens/attendanceGraph.dart';
import 'package:hiten/admin/screens/upload_task_screen.dart';
import 'package:hiten/models/user.dart';
import 'package:hiten/screens/home/workerTaskscreen.dart';
import 'package:iconsax/iconsax.dart';

import '../../widgets/buildShimmer.dart';
import '../chatScreen.dart';

class WorkerHomePage extends StatefulWidget {
  static const routeName = '/adminHome';
  const WorkerHomePage({super.key});

  @override
  State<WorkerHomePage> createState() => _WorkerHomePageState();
}

class _WorkerHomePageState extends State<WorkerHomePage> {
  ModelUser user = ModelUser(email: '', uid: '', phoneNumber: '', name: '');
  List pages = [
    WorkersTasksScreen(),
    AttendancePage(),
    ChatScreen(),
    UserAccountScreen()
  ];
  int _bottomNavIndex = 0;

  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Color activeNavigationBarColor = Colors.green;
  bool isActive = false;
  Color notActiveNavigationBarColor = Colors.black;
  List<IconData> iconList = [
    Iconsax.task_square,
    Iconsax.calendar,
    Iconsax.message,
    Icons.person,
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final itemHeight = 150.0;
    final itemCount = (screenHeight / itemHeight).ceil();
    return (!isLoading)
        ? Scaffold(
            floatingActionButton: MyFloatingActionButton(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            body: PageView(
              children: [pages[_bottomNavIndex]],
            ),
            bottomNavigationBar: AnimatedBottomNavigationBar.builder(
              itemCount: iconList.length,
              tabBuilder: (int index, bool isActive) {
                return Icon(
                  iconList[index],
                  size: 28,
                  color: isActive
                      ? activeNavigationBarColor
                      : notActiveNavigationBarColor,
                );
              },
              activeIndex: _bottomNavIndex,
              gapLocation: GapLocation.center,
              notchSmoothness: NotchSmoothness.verySmoothEdge,
              leftCornerRadius: 0,
              rightCornerRadius: 0,
              onTap: (newVal) {
                setState(() {
                  _bottomNavIndex = newVal;
                });
              },
            ),
          )
        : Scaffold(
            body: SafeArea(
              child: ListView.builder(
                  itemCount: itemCount,
                  itemBuilder: (context, index) {
                    return BuildShimmer();
                  }),
            ),
          );
  }
}

class MyFloatingActionButton extends StatefulWidget {
  @override
  _MyFloatingActionButtonState createState() => _MyFloatingActionButtonState();
}

class _MyFloatingActionButtonState extends State<MyFloatingActionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isRotated = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animation = Tween<double>(begin: 0, end: 0.5).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // void _rotateIcon() {
  //   if (_isRotated) {
  //     _controller.reverse();
  //   } else {
  //     _controller.forward();
  //     // Show bottom modal sheet when icon rotates forward
  //   }
  //   _isRotated = !_isRotated;
  // }

  Future<void> doSomething() async {
    // showDialog(
    //     context: context,
    //     builder: (context) {
    //       return LoadingScreen();
    //     });
    //
    // await Future.delayed(Duration(seconds: 3));

    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return AddProductScreen();
    }));
    // setState(() {
    //   _isRotated = true;
    //   //_rotateIcon();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: CircleBorder(),
      onPressed: () {
        //_rotateIcon();
        doSomething();
      },
      child: RotationTransition(
        turns: _animation,
        child: Icon(Icons.add),
      ),
    );
  }
}

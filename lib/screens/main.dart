import 'package:flutter/material.dart';
import 'package:turnkey_solution/shared/button_menu.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int activeButton = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        // floatingActionButton: FloatingActionButton(
        //   child: Icon(
        //     Icons.add,
        //   ),
        //   onPressed: () {},
        // ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white.withOpacity(0.8),
          shape: CircularNotchedRectangle(),
          child: Container(
            height: 80,
            //color: Colors.white.withOpacity(0.5),
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ButtonMenu(
                    icon: (Icons.swap_horiz_rounded),
                    onPress: () {
                      setState(() {
                        activeButton = 0;
                      });
                    },
                    text: 'TOURNAMENT',
                    active: activeButton == 0 ? true : false,
                    disabled: activeButton == 0 ? true : false,
                  ),
                  ButtonMenu(
                    icon: (Icons.insert_chart_outlined),
                    onPress: () {
                      setState(() {
                        activeButton = 1;
                      });
                    },
                    text: 'RATING',
                    active: activeButton == 1 ? true : false,
                    disabled: activeButton == 1 ? true : false,
                  ),
                  ButtonMenu(
                    icon: (Icons.group_rounded),
                    onPress: () {
                      setState(() {
                        activeButton = 2;
                      });
                    },
                    text: 'FRIENDS',
                    active: activeButton == 2 ? true : false,
                    disabled: activeButton == 2 ? true : false,
                  ),
                  ButtonMenu(
                    icon: (Icons.person),
                    onPress: () {
                      setState(() {
                        activeButton = 3;
                      });
                    },
                    text: 'PROFILE',
                    active: activeButton == 3 ? true : false,
                    disabled: activeButton == 3 ? true : false,
                  ),
                ],
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.only(left: 12, right: 12, top: 10),
            child: Stack(children: [
              Offstage(
                offstage: activeButton != 0,
                //child: Tournament(),
              ),
              Offstage(
                offstage: activeButton != 1,
                child: Container(
                  child: Text('Empty Body 1'),
                ),
              ),
              Offstage(
                offstage: activeButton != 2,
                //child: Friends(),
              ),
              Offstage(
                offstage: activeButton != 3,
                //child: Profile(),
              ),
            ]),
          ),
        ));
  }
}
import 'package:flutter/material.dart';
import 'package:turnkey_solution/config/theme.dart';
import 'package:turnkey_solution/screens/my_services.dart';
import 'package:turnkey_solution/screens/profile.dart';
import 'package:turnkey_solution/screens/services_page.dart';
import 'package:turnkey_solution/screens/support_page.dart';
import 'package:turnkey_solution/services/auth.dart';
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
          color: PlayColors.allWhiteText.withOpacity(0.8),
          shape: CircularNotchedRectangle(),
          child: Container(
            height: 85,

            //color: PlayColors.allWhiteText.withOpacity(0.5),
            child: Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
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
                    text: 'Полисы',
                    active: activeButton == 0,
                    disabled: activeButton == 0,
                  ),
                  ButtonMenu(
                    icon: (Icons.insert_chart_outlined),
                    onPress: () {
                      setState(() {
                        activeButton = 1;
                      });
                    },
                    text: 'Услуги',
                    active: activeButton == 1,
                    disabled: activeButton == 1,
                  ),
                  ButtonMenu(
                    icon: (Icons.group_rounded),
                    onPress: () {
                      setState(() {
                        activeButton = 2;
                      });
                    },
                    text: 'Поддержка',
                    active: activeButton == 2,
                    disabled: activeButton == 2,
                  ),
                  ButtonMenu(
                    icon: (Icons.person),
                    onPress: () {
                      setState(() {
                        activeButton = 3;
                      });
                    },
                    text: 'Профиль',
                    active: activeButton == 3,
                    disabled: activeButton == 3,
                  ),
                ],
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.only(left: 12, right: 12, top: 10),
            child: Stack(alignment: Alignment.bottomCenter, children: [
              Offstage(
                offstage: activeButton != 0,
                child: MyServices(),
              ),
              Offstage(
                offstage: activeButton != 1,
                child: Container(
                  child: ServicesPage(),
                ),
              ),
              Offstage(
                offstage: activeButton != 2,
                child: SupportPage(),
              ),
              Offstage(
                offstage: activeButton != 3,
                child: Profile(),
              ),
            ]),
          ),
        ));
  }
}

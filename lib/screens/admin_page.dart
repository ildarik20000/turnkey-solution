import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turnkey_solution/config/theme.dart';
import 'package:turnkey_solution/model/user.dart';
import 'package:turnkey_solution/services/auth.dart';
import 'package:turnkey_solution/services/database.dart';
import 'package:turnkey_solution/shared/button_icon.dart';
import 'package:url_launcher/url_launcher.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key key}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  UserApp user;
  List<UserApp> userNotBuy = [];
  bool loading = false;
  DatabaseService db = DatabaseService();

  @override
  void initState() {
    loadingInf();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        backgroundColor: PlayColors.background,
        appBar: AppBar(
          backgroundColor: PlayColors.background,
          title: Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Админ панель'),
              IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  setState(() {
                    AuthService().logOut();
                  });
                },
              )
            ],
          )),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                text: "Без покупок полисов",
              ),
              Tab(
                text: "Динамика покупок",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Center(
              child: Container(
                child: Column(
                  children: [
                    Container(
                      child: Expanded(
                        child: userNotBuy.length > 0
                            ? ListView.builder(
                                padding: const EdgeInsets.all(8),
                                itemCount: userNotBuy.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                      child: (userNotBuy[index].dms.length ==
                                                  0 &&
                                              userNotBuy[index].sons.length ==
                                                  0 &&
                                              userNotBuy[index].osago.length ==
                                                  0 &&
                                              userNotBuy[index].kasko.length ==
                                                  0)
                                          ? _blockInfo(
                                              userNotBuy[index].lastName ?? "",
                                              userNotBuy[index].name ?? "",
                                              userNotBuy[index].seName ?? "",
                                              userNotBuy[index].email ?? "",
                                              userNotBuy[index].number ?? "",
                                            )
                                          : Container());
                                })
                            : _notInfo(),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Center(
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }

  loadingInf() {
    loadData();
  }

  loadData() async {
    var stream = db.getInfoAll();
    stream.listen((List<UserApp> data) {
      setState(() {
        userNotBuy = data;
      });
    });
  }

  Widget _notInfo() {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: Text(
          "Все пользователи приобрели полисы",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22, color: PlayColors.red),
        ),
      ),
    );
  }

  Widget _blockInfo(String seName, String name, String lastName, String email,
      String number) {
    return Container(
      margin: EdgeInsets.only(top: 9),
      //alignment: Alignment.topLeft,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Container(
        padding: EdgeInsets.all(9),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              seName + " " + name + " " + lastName,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: ButtonWithIcon(
                color: Colors.black,
                icon: Icons.phone_callback,
                text: ("Телефон: " + number),
                onPress: () {
                  launch("tel://${8800555555}");
                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: ButtonWithIcon(
                color: Colors.black,
                icon: Icons.mail,
                text: ("email: " + email),
                onPress: () {
                  launch("mailto:${email.trim()}");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

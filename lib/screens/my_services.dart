import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:turnkey_solution/config/theme.dart';
import 'package:turnkey_solution/model/user.dart';
import 'package:turnkey_solution/services/auth.dart';
import 'package:turnkey_solution/services/database.dart';
import 'package:turnkey_solution/shared/button_autorization.dart';
import 'package:turnkey_solution/shared/header.dart';
import 'package:turnkey_solution/shared/profile_info.dart';

class MyServices extends StatefulWidget {
  MyServices({Key key}) : super(key: key);

  @override
  _MyServicesState createState() => _MyServicesState();
}

class _MyServicesState extends State<MyServices> {
  UserApp user;
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
      length: 4,
      child: Scaffold(
        backgroundColor: PlayColors.background,
        appBar: AppBar(
          backgroundColor: PlayColors.background,
          title: const Text('Мои полисы'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                text: "ОСАГО",
              ),
              Tab(
                text: "КАСКО",
              ),
              Tab(
                text: "ДМС",
              ),
              Tab(
                text: "СОНС",
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
                        child: user.osago.length > 0
                            ? ListView.builder(
                                padding: const EdgeInsets.all(8),
                                itemCount: user.osago.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return _blockInfo(
                                    user.osago[index].car,
                                    user.osago[index].city,
                                    user.osago[index].date,
                                    user.osago[index].price ?? "",
                                  );
                                })
                            : _notInfo(),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Center(
              child: Container(
                child: Column(
                  children: [
                    Container(
                      child: Expanded(
                          child: user.kasko.length > 0
                              ? ListView.builder(
                                  padding: const EdgeInsets.all(8),
                                  itemCount: user.kasko.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return _blockInfo(
                                      user.kasko[index].car,
                                      user.kasko[index].city,
                                      user.kasko[index].date,
                                      user.kasko[index].price ?? "",
                                    );
                                  })
                              : _notInfo()),
                    )
                  ],
                ),
              ),
            ),
            Center(
              child: Container(
                child: Column(
                  children: [
                    Container(
                      child: Expanded(
                          child: user.dms.length > 0
                              ? ListView.builder(
                                  padding: const EdgeInsets.all(8),
                                  itemCount: user.dms.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return _blockDmsInfo(
                                      user.dms[index].city,
                                      user.dms[index].age,
                                      user.dms[index].price ?? "",
                                    );
                                  })
                              : _notInfo()),
                    )
                  ],
                ),
              ),
            ),
            Center(
              child: Container(
                child: Column(
                  children: [
                    Container(
                      child: Expanded(
                          child: user.sons.length > 0
                              ? ListView.builder(
                                  padding: const EdgeInsets.all(8),
                                  itemCount: user.sons.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return _blockSonsInfo(
                                      user.sons[index].city,
                                      user.sons[index].age,
                                      user.sons[index].sport,
                                      user.sons[index].price ?? "",
                                    );
                                  })
                              : _notInfo()),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  loadingInf() {
    user = Provider.of<UserApp>(context, listen: false);
    loadData();
  }

  loadData() async {
    var stream = db.getInfo(user.getId);
    stream.listen((List<UserApp> data) {
      data.toList();
      user = data[0];
    });
  }

  Widget _notInfo() {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: Text(
          "У вас пока нет действующих полисов данного типа",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22, color: PlayColors.red),
        ),
      ),
    );
  }

  Widget _blockInfo(String car, String city, int date, String price) {
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
              "Город: " + city,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Автомобиль: " + car,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Год автомобиля: " + date.toString(),
              style: TextStyle(
                color: Colors.black54,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Цена: " + price,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _blockDmsInfo(String city, int age, String price) {
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
              "Город: " + city,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Возраст: " + age.toString(),
              style: TextStyle(
                color: Colors.black54,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Цена: " + price,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _blockSonsInfo(String city, int age, bool sport, String price) {
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
              "Город: " + city,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Возраст: " + age.toString(),
              style: TextStyle(
                color: Colors.black54,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              sport ? "Занимается спортом" : "Не занимается спортом",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Цена: " + price,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

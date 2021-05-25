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
  TextEditingController _nameController = TextEditingController();
  TextEditingController _seNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _numberController = TextEditingController();

  String _name;
  String _seName;
  String _lastName;
  String _number;
  UserApp user;
  bool loading = false;
  DatabaseService db = DatabaseService();

  @override
  void initState() {
    loadingInf();
    super.initState();
  }

  final List<Tab> myTabs = <Tab>[
    Tab(text: 'ОСАГО'),
    Tab(text: 'КАСКО'),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(8),
        child: Container(
          child: ListView(
            children: [
              Header("Мои полисы"),
              Container(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      alignment: Alignment.center,
                      child: Text(
                        "ОСАГО",
                        style: TextStyle(
                          color: PlayColors.red,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      height: 400,
                      child: Expanded(
                        child: ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemCount: user.osago.length,
                            itemBuilder: (BuildContext context, int index) {
                              return _blockInfo(
                                user.osago[index].car,
                                user.osago[index].city,
                                user.osago[index].date,
                                user.osago[index].price ?? "",
                              );
                            }),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      alignment: Alignment.center,
                      child: Text(
                        "КАСКО",
                        style: TextStyle(
                          color: PlayColors.red,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      height: 400,
                      child: Expanded(
                        child: user.kasko.length > 0
                            ? ListView.builder(
                                padding: const EdgeInsets.all(8),
                                itemCount: user.kasko.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return _blockInfo(
                                    user.kasko[index].car,
                                    user.kasko[index].city,
                                    user.kasko[index].date,
                                    user.kasko[index].price ?? "",
                                  );
                                })
                            : Container(),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
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

  Widget _textCard(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 18, color: Colors.black87),
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
}

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:turnkey_solution/config/theme.dart';
import 'package:turnkey_solution/model/dms.dart';
import 'package:turnkey_solution/model/user.dart';
import 'package:turnkey_solution/services/data_city_car.dart';
import 'package:turnkey_solution/services/database.dart';
import 'package:turnkey_solution/shared/header.dart';
import 'package:turnkey_solution/shared/profile_info.dart';

class DmsPage extends StatefulWidget {
  DmsPage({Key key}) : super(key: key);

  @override
  _DmsPageState createState() => _DmsPageState();
}

class _DmsPageState extends State<DmsPage> {
  TextEditingController _ageController = TextEditingController();

  Dms dms = new Dms();
  String city = DataCityCar().city[0];
  bool first = false;
  bool second = false;
  bool third = false;
  String output = "0";
  UserApp user;
  DatabaseService db = DatabaseService();

  @override
  void initState() {
    loadingInf();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    user = context.watch<UserApp>();

    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(8),
            child: ListView(
              children: [
                Header("ДМС", back: true),
                _kaskoInfoCity(),
                TextInfo(
                  text: "Ваш возраст",
                  widthWidget: 140,
                  widthInput: 181,
                  controller: _ageController,
                  keyboardType: TextInputType.phone,
                ),
                Text(
                  'Оказываемые услуги',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Checkbox(
                                    value: first,
                                    onChanged: (bool value) {
                                      setState(() {
                                        first = value;
                                      });
                                    }),
                                Text(
                                  'Поликлиническая помощь',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                Checkbox(
                                    value: second,
                                    onChanged: (bool value) {
                                      setState(() {
                                        second = value;
                                      });
                                    }),
                                Text(
                                  'Стоматологическая помощь',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                Checkbox(
                                    value: third,
                                    onChanged: (bool value) {
                                      setState(() {
                                        third = value;
                                      });
                                    }),
                                Text(
                                  'Стационарная помощь',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Итоговая сумма ",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      Text(
                        output,
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _button("Купить", () {
                        if (_ageController.text != "") {
                          dms.city = city;

                          dms.age = int.parse(_ageController.text);

                          dms.price = output;
                          setState(() {
                            output = (_out()).toString();
                            _saveInfo();
                          });
                        } else {
                          Fluttertoast.showToast(
                              msg: "Заполните все поля",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      }),
                      _button("Вычислить", () {
                        if (_ageController.text != "") {
                          setState(() {
                            output = (_out()).toString();
                          });
                        } else {
                          Fluttertoast.showToast(
                              msg: "Заполните все поля",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      }),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget _kaskoInfoCity() {
    return Container(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Выберите город ",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            Container(
              width: 170,
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white70,
              ),
              child: DropdownButton<String>(
                value: city,
                icon: Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(
                  color: PlayColors.black100,
                ),
                underline: Container(
                  height: 2,
                  color: PlayColors.buttonBackground,
                ),
                onChanged: (String newValue) {
                  setState(() {
                    //output = _out().toString();
                    city = newValue;
                  });
                },
                items: DataCityCar()
                    .city
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  int _out() {
    int age = int.parse(_ageController.text);
    bool first = this.first;
    bool second = this.second;
    bool third = this.third;
    int out = 0;
    if (age < 6) {
      if (first) out += 15873;
      if (second) out += 8760;
      if (third) out += 4875;
    } else if (age < 13) {
      if (first) out += 14876;
      if (second) out += 8569;
      if (third) out += 4322;
    } else if (age < 18) {
      if (first) out += 14277;
      if (second) out += 7968;
      if (third) out += 3976;
    } else if (age < 36) {
      if (first) out += 16893;
      if (second) out += 8992;
      if (third) out += 5871;
    } else if (age < 51) {
      if (first) out += 20878;
      if (second) out += 10765;
      if (third) out += 6872;
    } else if (age < 66) {
      if (first) out += 22871;
      if (second) out += 10764;
      if (third) out += 7879;
    } else {
      if (first) out += 24870;
      if (second) out += 11768;
      if (third) out += 8876;
    }
    return out;
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

      user.name = data[0].name;
      user.seName = data[0].seName;
      user.lastName = data[0].lastName;
      user.number = data[0].number;
      user.osago = data[0].osago;
      user.kasko = data[0].kasko;
      user.dms = data[0].dms;
      context.read<UserApp>().name = user.name;
      context.read<UserApp>().seName = user.seName;
      context.read<UserApp>().lastName = user.lastName;
      context.read<UserApp>().number = user.number;
      context.read<UserApp>().osago = user.osago;
      context.read<UserApp>().kasko = user.kasko;
      context.read<UserApp>().dms = user.dms;
    });
  }

  void _saveInfo() async {
    user.dms.add(dms);
    var stream = db.getInfo(user.getId);
    stream.listen((List<UserApp> data) {
      data.toList();
      user = data[0];
      user.name = data[0].name;
      user.seName = data[0].seName;
      user.lastName = data[0].lastName;
      user.number = data[0].number;
      user.osago = data[0].osago;
      user.kasko = data[0].kasko;
      user.dms = data[0].dms;
      context.read<UserApp>().name = user.name;
      context.read<UserApp>().seName = user.seName;
      context.read<UserApp>().lastName = user.lastName;
      context.read<UserApp>().number = user.number;
      context.read<UserApp>().osago = user.osago;
      context.read<UserApp>().kasko = user.kasko;
      context.read<UserApp>().dms = user.dms;
    });

    context.read<UserApp>().dms = user.dms;
    await DatabaseService().adduserProfileInfo(user);
    Navigator.pop(context);
  }
}

Widget _button(String text, void func()) {
  return Container(
    margin: EdgeInsets.only(top: 10),
    child: RaisedButton(
      splashColor: PlayColors.red,
      highlightColor: PlayColors.red,
      color: PlayColors.buttonBackground,
      child: Text(text,
          style: TextStyle(
              fontFamily: 'BebasBook',
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 30)),
      onPressed: () {
        func();
      },
    ),
  );
}

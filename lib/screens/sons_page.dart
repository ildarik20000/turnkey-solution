import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:turnkey_solution/config/theme.dart';
import 'package:turnkey_solution/model/dms.dart';
import 'package:turnkey_solution/model/sons.dart';
import 'package:turnkey_solution/model/user.dart';
import 'package:turnkey_solution/services/data_city_car.dart';
import 'package:turnkey_solution/services/database.dart';
import 'package:turnkey_solution/shared/header.dart';
import 'package:turnkey_solution/shared/profile_info.dart';

class SonsPage extends StatefulWidget {
  SonsPage({Key key}) : super(key: key);

  @override
  _SonsPageState createState() => _SonsPageState();
}

enum SingingCharacter1 { yes, no }
enum SingingCharacter2 { first, second }

class _SonsPageState extends State<SonsPage> {
  TextEditingController _ageController = TextEditingController();

  Sons sons = new Sons();
  String city = DataCityCar().city[0];
  bool sport = true;
  bool summ = true;
  String output = "0";
  UserApp user;
  DatabaseService db = DatabaseService();
  SingingCharacter1 _sport = SingingCharacter1.yes;
  SingingCharacter2 _summ = SingingCharacter2.first;
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
                Header("Страхование от\nнесчастного случая", back: true),
                _kaskoInfoCity(),
                TextInfo(
                  text: "Ваш возраст",
                  widthWidget: 140,
                  widthInput: 181,
                  controller: _ageController,
                  keyboardType: TextInputType.phone,
                ),
                Container(
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 140,
                        child: Text(
                          "Занятие спортом ",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 190,
                              height: 60,
                              child: ListTile(
                                title: const Text(
                                  'Да',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                                leading: Radio<SingingCharacter1>(
                                  value: SingingCharacter1.yes,
                                  groupValue: _sport,
                                  onChanged: (SingingCharacter1 value) {
                                    setState(() {
                                      _sport = value;
                                      sport = true;
                                    });
                                  },
                                ),
                              ),
                            ),
                            Container(
                              width: 190,
                              height: 60,
                              child: ListTile(
                                title: const Text(
                                  'Нет',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                                leading: Radio<SingingCharacter1>(
                                  value: SingingCharacter1.no,
                                  groupValue: _sport,
                                  onChanged: (SingingCharacter1 value) {
                                    setState(() {
                                      _sport = value;
                                      sport = false;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 140,
                        child: Text(
                          "Стоимость покрытия",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 190,
                              height: 60,
                              child: ListTile(
                                title: const Text(
                                  'До 100000',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                                leading: Radio<SingingCharacter2>(
                                  value: SingingCharacter2.first,
                                  groupValue: _summ,
                                  onChanged: (SingingCharacter2 value) {
                                    setState(() {
                                      _summ = value;
                                      summ = true;
                                    });
                                  },
                                ),
                              ),
                            ),
                            Container(
                              width: 190,
                              height: 60,
                              child: ListTile(
                                title: const Text(
                                  'Более 100000',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                                leading: Radio<SingingCharacter2>(
                                  value: SingingCharacter2.second,
                                  groupValue: _summ,
                                  onChanged: (SingingCharacter2 value) {
                                    setState(() {
                                      _summ = value;
                                      summ = false;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
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
                          output = (_out()).toString();
                          sons.city = city;

                          sons.age = int.parse(_ageController.text);
                          sons.sport = sport;
                          sons.summ = summ;
                          sons.time = DateTime.now().toString();
                          sons.price = output;
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
    bool summ = this.summ;
    bool sport = this.sport;
    int out = 0;
    if (age < 26) {
      if (sport) {
        if (summ)
          return 5690;
        else
          return 6560;
      } else {
        if (summ)
          return 3590;
        else
          return 4590;
      }
    } else if (age < 51) {
      if (sport) {
        if (summ)
          return 4980;
        else
          return 6980;
      } else {
        if (summ)
          return 3980;
        else
          return 4980;
      }
    } else {
      if (sport) {
        if (summ)
          return 7590;
        else
          return 8960;
      } else {
        if (summ)
          return 5980;
        else
          return 6980;
      }
    }
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
      user.sons = data[0].sons;
      context.read<UserApp>().name = user.name;
      context.read<UserApp>().seName = user.seName;
      context.read<UserApp>().lastName = user.lastName;
      context.read<UserApp>().number = user.number;
      context.read<UserApp>().osago = user.osago;
      context.read<UserApp>().kasko = user.kasko;
      context.read<UserApp>().dms = user.dms;
      context.read<UserApp>().sons = user.sons;
    });
  }

  void _saveInfo() async {
    user.sons.add(sons);
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
      user.sons = data[0].sons;
      context.read<UserApp>().name = user.name;
      context.read<UserApp>().seName = user.seName;
      context.read<UserApp>().lastName = user.lastName;
      context.read<UserApp>().number = user.number;
      context.read<UserApp>().osago = user.osago;
      context.read<UserApp>().kasko = user.kasko;
      context.read<UserApp>().dms = user.dms;
      context.read<UserApp>().sons = user.sons;
    });

    context.read<UserApp>().sons = user.sons;
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

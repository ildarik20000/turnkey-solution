import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:turnkey_solution/config/theme.dart';
import 'package:turnkey_solution/model/kasko.dart';
import 'package:turnkey_solution/model/osago.dart';
import 'package:turnkey_solution/model/user.dart';
import 'package:turnkey_solution/services/data_city_car.dart';
import 'package:turnkey_solution/services/database.dart';
import 'package:turnkey_solution/shared/header.dart';
import 'package:turnkey_solution/shared/profile_info.dart';

class KaskoPage extends StatefulWidget {
  KaskoPage({Key key}) : super(key: key);

  @override
  _KaskoPageState createState() => _KaskoPageState();
}

enum SingingCharacter { buy, notBuy }

class _KaskoPageState extends State<KaskoPage> {
  TextEditingController _dateController = TextEditingController();
  TextEditingController _standingController = TextEditingController();

  Kasko kasko = new Kasko();
  String city = DataCityCar().city[0];
  String car = DataCityCar().car[0];
  String enginePower = DataCityCar().enginePower[0];
  String output = "0";
  String checkName;
  UserApp user;
  bool credit = false;
  SingingCharacter _character = SingingCharacter.notBuy;
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
                Header("КАСКО", back: true),
                _kaskoInfoCity(),
                _kaskoInfoCar(),
                TextInfo(
                  text: "Год выпуска",
                  widthWidget: 140,
                  widthInput: 181,
                  controller: _dateController,
                  keyboardType: TextInputType.phone,
                ),
                Container(
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 140,
                        child: Text(
                          "Информация о кредите ",
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
                                  'без кредита',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                                leading: Radio<SingingCharacter>(
                                  value: SingingCharacter.notBuy,
                                  groupValue: _character,
                                  onChanged: (SingingCharacter value) {
                                    setState(() {
                                      _character = value;
                                      credit = false;
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
                                  'с кредитом',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                                leading: Radio<SingingCharacter>(
                                  value: SingingCharacter.buy,
                                  groupValue: _character,
                                  onChanged: (SingingCharacter value) {
                                    setState(() {
                                      _character = value;
                                      credit = true;
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
                _kaskoEnginePower(),
                TextInfo(
                  text: "Водительский стаж",
                  widthWidget: 140,
                  widthInput: 181,
                  controller: _standingController,
                  keyboardType: TextInputType.phone,
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
                        if (_dateController.text != "" &&
                            _standingController.text != "") {
                          kasko.city = city;
                          kasko.car = car;
                          kasko.date = int.parse(_dateController.text);
                          kasko.enginePower = enginePower;
                          kasko.standing = _standingController.text;
                          kasko.price = output;
                          setState(() {
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
                        if (_dateController.text != "" &&
                            _standingController.text != "") {
                          setState(() {
                            if (credit)
                              output = (_out() + 500).toString();
                            else
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

  Widget _kaskoInfoCar() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Марка автомобиля ",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            Container(
              width: 170,
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white70,
              ),
              child: DropdownButton<String>(
                value: car,
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
                    car = newValue;
                  });
                },
                items: DataCityCar()
                    .car
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

  Widget _kaskoEnginePower() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 140,
              child: Text(
                "Мощность двигателя ",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            Container(
              width: 170,
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white70,
              ),
              child: DropdownButton<String>(
                value: enginePower,
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
                    enginePower = newValue;
                  });
                },
                items: DataCityCar()
                    .enginePower
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
    String mark = car;
    String power = enginePower;
    int year = int.parse(_dateController.text);
    String lvl = _standingController.text;
    int out;
    if (mark == "ГАЗ" || mark == "Москвич" || mark == "УАЗ" || mark == "Lada") {
      if (power == "0-100") {
        if (year < 2000) {
          return 6980;
        } else if (year < 2018)
          return 7350;
        else
          return 7690;
      } else if (power == "101-199") {
        if (year < 2000) {
          return 7960;
        } else if (year < 2018)
          return 8160;
        else
          return 8450;
      } else {
        if (year < 2000) {
          return 8960;
        } else if (year < 2018)
          return 9860;
        else
          return 11260;
      }
    } else if (mark == "Audi" ||
        mark == "BMW" ||
        mark == "Mercedes-Benz" ||
        mark == "Mitsubishi" ||
        mark == "Infiniti" ||
        mark == "Isuzu" ||
        mark == "Lexus" ||
        mark == "Jeep") {
      if (power == "0-100") {
        if (year < 2000) {
          return 12680;
        } else if (year < 2018)
          return 14590;
        else
          return 14980;
      } else if (power == "101-199") {
        if (year < 2000) {
          return 16900;
        } else if (year < 2018)
          return 17200;
        else
          return 19500;
      } else {
        if (year < 2000) {
          return 24980;
        } else if (year < 2018)
          return 26980;
        else
          return 27970;
      }
    } else {
      if (power == "0-100") {
        if (year < 2000) {
          return 9060;
        } else if (year < 2018)
          return 10360;
        else
          return 12690;
      } else if (power == "101-199") {
        if (year < 2000) {
          return 11690;
        } else if (year < 2018)
          return 12300;
        else
          return 13690;
      } else {
        if (year < 2000) {
          return 12360;
        } else if (year < 2018)
          return 13500;
        else
          return 13950;
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
      context.read<UserApp>().name = user.name;
      context.read<UserApp>().seName = user.seName;
      context.read<UserApp>().lastName = user.lastName;
      context.read<UserApp>().number = user.number;
      context.read<UserApp>().osago = user.osago;
      context.read<UserApp>().kasko = user.kasko;
    });
  }

  void _saveInfo() async {
    user.kasko.add(kasko);
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
      context.read<UserApp>().name = user.name;
      context.read<UserApp>().seName = user.seName;
      context.read<UserApp>().lastName = user.lastName;
      context.read<UserApp>().number = user.number;
      context.read<UserApp>().osago = user.osago;
      context.read<UserApp>().kasko = user.kasko;
    });

    context.read<UserApp>().kasko = user.kasko;
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

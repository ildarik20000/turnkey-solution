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

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(8),
        child: Container(
          child: Column(
            children: [
              Header("Профиль"),
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 6),
                      child: TextInfo(
                        text: "Фамилия",
                        controller: _lastNameController,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 6),
                      child: TextInfo(text: "Имя", controller: _nameController),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 6),
                      child: TextInfo(
                          text: "Отчество", controller: _seNameController),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 6),
                      child: TextInfo(
                        text: "Телефон",
                        controller: _numberController,
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                    _button("Сохранить", () => _saveInfo()),
                    Divider(
                      height: 2,
                      color: Colors.white,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Button(
                        text: "Выход",
                        fontSizeText: 20,
                        tapDetectorSize: 59,
                        onPress: () {
                          setState(() {
                            AuthService().logOut();
                          });
                        },
                      ),
                    ),
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
      context.read<UserApp>().name = user.name;
      context.read<UserApp>().seName = user.seName;
      context.read<UserApp>().lastName = user.lastName;
      context.read<UserApp>().number = user.number;
      context.read<UserApp>().osago = user.osago;
      setState(() {
        _nameController.text = user.name ?? "";
        _seNameController.text = user.seName ?? "";
        _lastNameController.text = user.lastName ?? "";
        _numberController.text = user.number ?? "";
      });
    });
  }

  void _saveInfo() async {
    _name = _nameController.text ?? "";
    _seName = _seNameController.text ?? "";
    _lastName = _lastNameController.text ?? "";
    _number = _numberController.text ?? "";
    user = Provider.of<UserApp>(context, listen: false);
    context.read<UserApp>().name = _name;
    context.read<UserApp>().seName = _seName;
    context.read<UserApp>().lastName = _lastName;
    context.read<UserApp>().number = _number;
    context.read<UserApp>().osago = user.osago;

    user.name = _name;
    user.seName = _seName;
    user.lastName = _lastName;
    user.number = _number;
    user.setData(user);
    print(user.getId);
    await DatabaseService().adduserProfileInfo(user);
  }
}

Widget _button(String text, void func()) {
  return RaisedButton(
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
  );
}

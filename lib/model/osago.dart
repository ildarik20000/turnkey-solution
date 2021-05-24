import 'package:turnkey_solution/services/data_city_car.dart';

class Osago {
  String city;
  String car;
  int date;
  String enginePower;
  String standing;
  Osago();
  Map<String, dynamic> toMap() {
    return {
      "city": city,
      "car": car,
      "date": date,
      "enginePower": enginePower,
      "standing": standing,
    };
  }

  Osago.fromJson(String uid, Map<String, dynamic> data) {
    city = data['city'];
    car = data['car'];
    date = data['date'];
    enginePower = data['enginePower'];
    standing = data['standing'];
  }
}

import 'package:turnkey_solution/services/data_city_car.dart';

class Kasko {
  String city;
  String car;
  int date;
  String enginePower;
  String standing;
  String price;
  String time;
  Kasko({this.car, this.city, this.date, this.enginePower, this.standing});

  Map<String, dynamic> toMap() {
    return {
      "city": city,
      "car": car,
      "date": date,
      "enginePower": enginePower,
      "standing": standing,
      "price": price,
      "time": time,
    };
  }

  Kasko.fromJson(Map<String, dynamic> data) {
    city = data['city'];
    car = data['car'];
    date = data['date'];
    enginePower = data['enginePower'];
    standing = data['standing'];
    price = data['price'];
    time = data['time'] ?? "";
  }
}

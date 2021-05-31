import 'package:turnkey_solution/services/data_city_car.dart';

class Dms {
  String city;
  int age;
  String time;

  String price;
  Dms({this.age, this.city});
  Map<String, dynamic> toMap() {
    return {
      "city": city,
      "age": age,
      "price": price,
      "time": time,
    };
  }

  Dms.fromJson(Map<String, dynamic> data) {
    city = data['city'];
    age = data['age'];
    price = data['price'];
    time = data['time'] ?? "";
  }
}

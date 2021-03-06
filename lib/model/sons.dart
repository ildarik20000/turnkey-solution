import 'package:turnkey_solution/services/data_city_car.dart';

class Sons {
  String city;
  int age;
  bool sport;
  bool summ;
  String price;
  String time;
  Sons({this.age, this.city});
  Map<String, dynamic> toMap() {
    return {
      "city": city,
      "age": age,
      "sport": sport,
      "summ": summ,
      "price": price,
      "time": time,
    };
  }

  Sons.fromJson(Map<String, dynamic> data) {
    city = data['city'];
    age = data['age'];
    sport = data['sport'];
    summ = data['summ'];
    price = data['price'];
    time = data['time'] ?? "";
  }
}

class ParseData {
  int parseTimeDay(String data) {
    DateTime dateTime =
        DateTime.parse(data == "" ? "2021-05-30 10:02:20.876050" : data);
    return dateTime.day;
  }

  int parseTimeWeek(String data) {
    DateTime dateTime =
        DateTime.parse(data == "" ? "2021-05-30 10:02:20.876050" : data);
    return dateTime.month;
  }

  String parseWeekRus(String time) {
    if (time == "Jan")
      return "Январь";
    else if (time == "Feb")
      return "Февраль";
    else if (time == "Mar")
      return "Март";
    else if (time == "Apr")
      return "Апрель";
    else if (time == "May")
      return "Май";
    else if (time == "Jun")
      return "Июнь";
    else if (time == "Jul")
      return "Июль";
    else if (time == "Aut")
      return "Август";
    else if (time == "Sep")
      return "Сентябрь";
    else if (time == "Oct")
      return "Октябрь";
    else if (time == "Nov")
      return "Ноябрь";
    else
      return "Декабрь";
  }
}

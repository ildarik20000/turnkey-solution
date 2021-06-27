import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:turnkey_solution/config/theme.dart';
import 'package:turnkey_solution/model/user.dart';
import 'package:turnkey_solution/services/database.dart';
import 'package:turnkey_solution/services/parse.dart';

/// !!Step1: prepare the data to plot.
var _data1 = <double, double>{};
var _data2 = <double, double>{};
var _data3 = <double, double>{};
var _data4 = <double, double>{};

class FlLineChartExample extends StatefulWidget {
  const FlLineChartExample({Key key}) : super(key: key);

  @override
  _FlLineChartExampleState createState() => _FlLineChartExampleState();
}

class _FlLineChartExampleState extends State<FlLineChartExample> {
  bool _showGrid = true;
  bool _isCurved = false;
  bool _showBelowArea = false;
  bool _showDot = true;
  bool _showBorder = true;

  List<UserApp> userNotBuy = [];

  double osago = 0;
  double kasko = 0;
  double dms = 0;
  double sons = 0;
  bool loading = false;
  DatabaseService db = DatabaseService();

  String dropdownValue = "По месяцам";

  @override
  void initState() {
    loadingInf();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (userNotBuy.length > 0) {
      selectDayWeek();
    } else {
      setState(() {
        _data1 = <double, double>{1: 0};
        _data2 = <double, double>{1: 0};
        _data3 = <double, double>{1: 0};
        _data4 = <double, double>{1: 0};
      });
    }

    /// !!Step2: convert data into a list of [FlSpot].
    final spots1 = <FlSpot>[
      for (final entry in _data1.entries) FlSpot(entry.key, entry.value)
    ];
    final spots2 = <FlSpot>[
      for (final entry in _data2.entries) FlSpot(entry.key, entry.value)
    ];
    final spots3 = <FlSpot>[
      for (final entry in _data3.entries) FlSpot(entry.key, entry.value)
    ];

    final spots4 = <FlSpot>[
      for (final entry in _data4.entries) FlSpot(entry.key, entry.value)
    ];

    /// !!Step3: prepare LineChartData
    /// !here we can set styles and behavior of the chart.
    final lineChartData = LineChartData(
// The data to show.
      lineBarsData: [
// ! Here we can style each data line.
        LineChartBarData(
          spots: spots1,
          colors: [Colors.blue],
          barWidth: 6,
          isCurved: _isCurved,
          dotData: FlDotData(show: _showDot),
          belowBarData:
              BarAreaData(show: _showBelowArea, colors: [Colors.blue[200]]),
        ),
        LineChartBarData(
          spots: spots2,
          colors: [Colors.red],
          barWidth: 6,
          isCurved: _isCurved,
          dotData: FlDotData(show: _showDot),
          belowBarData:
              BarAreaData(show: _showBelowArea, colors: [Colors.red[200]]),
        ),
        LineChartBarData(
          spots: spots3,
          colors: [Colors.green],
          barWidth: 6,
          isCurved: _isCurved,
          dotData: FlDotData(show: _showDot),
          belowBarData:
              BarAreaData(show: _showBelowArea, colors: [Colors.green[200]]),
        ),

        LineChartBarData(
          spots: spots4,
          colors: [Colors.purple],
          barWidth: 6,
          isCurved: _isCurved,
          dotData: FlDotData(show: _showDot),
          belowBarData:
              BarAreaData(show: _showBelowArea, colors: [Colors.purple[200]]),
        ),
      ],
// ! Behavior when touching the chart:
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: PlayColors.allWhiteText,
        ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
// ! Borders:
      borderData: FlBorderData(
        show: _showBorder,
        border: const Border(
          bottom: BorderSide(color: Colors.greenAccent, width: 4),
          left: BorderSide(color: Colors.transparent),
          right: BorderSide(color: Colors.transparent),
          top: BorderSide(color: Colors.transparent),
        ),
      ),
// ! Grid behavior:
      gridData: FlGridData(show: _showGrid),
// ! Axis title
      axisTitleData: FlAxisTitleData(
        show: true,
        bottomTitle: AxisTitle(
            titleText: dropdownValue == "По месяцам"
                ? 'Месяца'
                : ParseData()
                    .parseWeekRus((DateFormat.MMM().format(DateTime.now()))),
            showTitle: true),
        leftTitle: AxisTitle(
            titleText: 'Количество пробретенных полисов', showTitle: true),
      ),
// ! Ticks in the axis
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true, // this is false by-default.
// ! Decides how to show bottom titles,
// here we convert double to month names
          getTitles: (double val) => dropdownValue == "По месяцам"
              ? ParseData().parseWeekRus(
                  DateFormat.MMM().format(DateTime(2021, val.toInt())))
              : DateFormat.d()
                  .format(DateTime(2021, DateTime.now().month, val.toInt())),
        ),
        leftTitles: SideTitles(
          showTitles: true,
// ! Decides how to show left titles,
// here we skip some values by returning ''.
          getTitles: (double val) {
            if (val.toInt() % 5 != 0) return '';
            return '${val.toInt()}';
          },
        ),
      ),
    );
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(right: 20, left: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(top: 60),
              alignment: Alignment.topCenter,
              height: 40,
              child: DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: PlayColors.red),
                underline: Container(
                  height: 2,
                  color: PlayColors.buttonBackground,
                ),
                onChanged: (String newValue) {
                  setState(() {
                    dropdownValue = newValue;
                    selectDayWeek();
                  });
                },
                items: <String>["По дням", "По месяцам"]
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            Expanded(child: LineChart(lineChartData)),
          ],
        ),
      ),
      bottomNavigationBar: _buildControlWidgets(),
    );
  }

  Widget _buildInfoLine(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, top: 6, bottom: 6),
      child: Container(
        child: Row(
          children: [
            Container(
              child: Text(
                text,
                style: TextStyle(fontSize: 18, color: color),
              ),
            ),
            Container(
              width: 30,
              height: 8,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4), color: color),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildControlWidgets() {
    return Container(
      height: 200,
      color: Colors.grey[200],
      child: ListView(
        children: [
          _buildInfoLine("Осаго ", Colors.blue),
          _buildInfoLine("Каско ", Colors.red),
          _buildInfoLine("Дмс ", Colors.green),
          _buildInfoLine("СОНС ", Colors.purple),
          SwitchListTile(
            title: const Text('Изогнутые линии'),
            onChanged: (bool val) => setState(() => this._isCurved = val),
            value: this._isCurved,
          ),
          SwitchListTile(
            title: const Text('Показывать сетку'),
            onChanged: (bool val) => setState(() => this._showGrid = val),
            value: this._showGrid,
          ),
          SwitchListTile(
            title: const Text('Ось абсциис'),
            onChanged: (bool val) => setState(() => this._showBorder = val),
            value: this._showBorder,
          ),
          SwitchListTile(
            title: const Text('Показывать точки'),
            onChanged: (bool val) => setState(() => this._showDot = val),
            value: this._showDot,
          ),
        ],
      ),
    );
  }

  loadingInf() {
    loadData();
  }

  loadData() async {
    var stream = db.getInfoAll();
    stream.listen((List<UserApp> data) {
      setState(() {
        userNotBuy = data;
      });
    });
  }

  selectDayWeek() {
    var nowData1 = <double, double>{}; //dms
    var nowData2 = <double, double>{}; //kasko
    var nowData3 = <double, double>{}; //osago
    var nowData4 = <double, double>{}; //sons
    int week = DateTime.now().month;
    if (dropdownValue == "По дням") {
      for (int i = 0; i < userNotBuy.length; i++) {
        for (int k = 0; k < userNotBuy[i].dms.length; k++) {
          if (ParseData().parseTimeWeek(userNotBuy[i].dms[k].time) == week) {
            nowData1[(ParseData().parseTimeDay(userNotBuy[i].dms[k].time) +
                        0.0)] !=
                    null
                ? nowData1[
                    (ParseData().parseTimeDay(userNotBuy[i].dms[k].time) +
                        0.0)]++
                : nowData1[
                    (ParseData().parseTimeDay(userNotBuy[i].dms[k].time) +
                        0.0)] = 1;
          }
        }
        for (int k = 0; k < userNotBuy[i].kasko.length; k++) {
          if (ParseData().parseTimeWeek(userNotBuy[i].kasko[k].time) == week) {
            nowData2[(ParseData().parseTimeDay(userNotBuy[i].kasko[k].time) +
                        0.0)] !=
                    null
                ? nowData2[
                    (ParseData().parseTimeDay(userNotBuy[i].kasko[k].time) +
                        0.0)]++
                : nowData2[
                    (ParseData().parseTimeDay(userNotBuy[i].kasko[k].time) +
                        0.0)] = 1;
          }
        }
        for (int k = 0; k < userNotBuy[i].osago.length; k++) {
          if (ParseData().parseTimeWeek(userNotBuy[i].osago[k].time) == week) {
            nowData3[(ParseData().parseTimeDay(userNotBuy[i].osago[k].time) +
                        0.0)] !=
                    null
                ? nowData3[
                    (ParseData().parseTimeDay(userNotBuy[i].osago[k].time) +
                        0.0)]++
                : nowData3[
                    (ParseData().parseTimeDay(userNotBuy[i].osago[k].time) +
                        0.0)] = 1;
          }
        }
        for (int k = 0; k < userNotBuy[i].sons.length; k++) {
          if (ParseData().parseTimeWeek(userNotBuy[i].sons[k].time) == week) {
            nowData4[(ParseData().parseTimeDay(userNotBuy[i].sons[k].time) +
                        0.0)] !=
                    null
                ? nowData4[
                    (ParseData().parseTimeDay(userNotBuy[i].sons[k].time) +
                        0.0)]++
                : nowData4[
                    (ParseData().parseTimeDay(userNotBuy[i].sons[k].time) +
                        0.0)] = 1;
          }
        }
      }
    } else {
      for (int i = 0; i < userNotBuy.length; i++) {
        for (int k = 0; k < userNotBuy[i].dms.length; k++) {
          nowData1[(ParseData().parseTimeWeek(userNotBuy[i].dms[k].time) +
                      0.0)] !=
                  null
              ? nowData1[(ParseData().parseTimeWeek(userNotBuy[i].dms[k].time) +
                  0.0)]++
              : nowData1[(ParseData().parseTimeWeek(userNotBuy[i].dms[k].time) +
                  0.0)] = 1;
        }
        for (int k = 0; k < userNotBuy[i].kasko.length; k++) {
          nowData2[(ParseData().parseTimeWeek(userNotBuy[i].kasko[k].time) +
                      0.0)] !=
                  null
              ? nowData2[
                  (ParseData().parseTimeWeek(userNotBuy[i].kasko[k].time) +
                      0.0)]++
              : nowData2[
                  (ParseData().parseTimeWeek(userNotBuy[i].kasko[k].time) +
                      0.0)] = 1;
        }
        for (int k = 0; k < userNotBuy[i].osago.length; k++) {
          nowData3[(ParseData().parseTimeWeek(userNotBuy[i].osago[k].time) +
                      0.0)] !=
                  null
              ? nowData3[
                  (ParseData().parseTimeWeek(userNotBuy[i].osago[k].time) +
                      0.0)]++
              : nowData3[
                  (ParseData().parseTimeWeek(userNotBuy[i].osago[k].time) +
                      0.0)] = 1;
        }
        for (int k = 0; k < userNotBuy[i].sons.length; k++) {
          nowData4[(ParseData().parseTimeWeek(userNotBuy[i].sons[k].time) +
                      0.0)] !=
                  null
              ? nowData4[
                  (ParseData().parseTimeWeek(userNotBuy[i].sons[k].time) +
                      0.0)]++
              : nowData4[
                  (ParseData().parseTimeWeek(userNotBuy[i].sons[k].time) +
                      0.0)] = 1;
        }
      }
    }
    setState(() {
      _data1 = nowData3.isNotEmpty ? nowData3 : {1: 0};
      _data2 = nowData2.isNotEmpty ? nowData2 : {1: 0};
      _data3 = nowData1.isNotEmpty ? nowData1 : {1: 0};
      _data4 = nowData4.isNotEmpty ? nowData4 : {1: 0};
      print(_data1);
    });
  }
}

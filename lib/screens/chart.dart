import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:turnkey_solution/model/user.dart';
import 'package:turnkey_solution/services/database.dart';

/// !!Step1: prepare the data to plot.
var _data1 = <double, double>{2: 10, 3: 15, 4: 10, 5: 27, 6: 20, 7: 0};
var _data2 = <double, double>{2: 8, 3: 12, 4: 20, 5: 22, 6: 16, 7: 0};
var _data3 = <double, double>{2: 12, 3: 17, 4: 10, 5: 20, 6: 18, 7: 0};

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
  bool loading = false;
  DatabaseService db = DatabaseService();

  @override
  void initState() {
    loadingInf();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (userNotBuy.length > 0) {
      for (int i = 0; i < userNotBuy.length; i++) {
        kasko += userNotBuy[i].kasko.length;
        osago += userNotBuy[i].osago.length;
        dms += userNotBuy[i].dms.length;
      }
      setState(() {
        _data1[7] = osago;
        _data2[7] = kasko;
        _data3[7] = dms;
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
      ],
// ! Behavior when touching the chart:
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.white,
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
        bottomTitle: AxisTitle(titleText: 'Месяца', showTitle: true),
        leftTitle: AxisTitle(titleText: 'Количество', showTitle: true),
      ),
// ! Ticks in the axis
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
            showTitles: true, // this is false by-default.
// ! Decides how to show bottom titles,
// here we convert double to month names
            getTitles: (double val) => DateFormat.MMM()
                        .format(DateTime(2021, val.toInt())) ==
                    "Feb"
                ? "Февраль"
                : DateFormat.MMM().format(DateTime(2021, val.toInt())) == "Mar"
                    ? "Март"
                    : DateFormat.MMM().format(DateTime(2021, val.toInt())) ==
                            "Apr"
                        ? "Апрель"
                        : DateFormat.MMM()
                                    .format(DateTime(2021, val.toInt())) ==
                                "May"
                            ? "Май"
                            : DateFormat.MMM()
                                        .format(DateTime(2021, val.toInt())) ==
                                    "Jun"
                                ? "Июнь"
                                : DateFormat.MMM().format(
                                            DateTime(2021, val.toInt())) ==
                                        "Jul"
                                    ? "Июль"
                                    : DateFormat.MMM()
                                        .format(DateTime(2021, val.toInt()))),
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
        padding: const EdgeInsets.only(top: 40, right: 20, left: 10),
        child: LineChart(lineChartData),
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
}

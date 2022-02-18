import 'package:covid_tracker/Screen/homepage.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class DetailsPage extends StatefulWidget {
  final int? cases;
  final String? name;
  final String? flag;
  final int? todayCases;
  final int? deaths;
  final int? todayDeaths;
  final int? recovered;
  final int? todayRecovery;
  final int? active;
  final int? critical;
  final int? totalTests;
  final int? population;

  const DetailsPage(
      {Key? key,
      this.cases,
      this.recovered,
      this.name,
      this.flag,
      this.todayCases,
      this.deaths,
      this.todayDeaths,
      this.todayRecovery,
      this.active,
      this.critical,
      this.totalTests,
      this.population})
      : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 3))
        ..repeat();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final colorList = <Color>[
    const Color(0xff4285f4),
    const Color(0xffdb4437),
    const Color(0xfff4b400),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.name as String,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 10),
            Image.network(
              widget.flag as String,
              height: 30,
              width: 30,
            ),
          ],
        ),
        foregroundColor: Colors.black,
        // centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      PieChart(
                        chartRadius: 160,
                        dataMap: {
                          'Total': double.parse(widget.cases.toString()),
                          'Recovered':
                              double.parse(widget.recovered.toString()),
                          'Deaths': double.parse(widget.deaths.toString()),
                        },
                        chartValuesOptions: const ChartValuesOptions(
                            showChartValuesInPercentage: true),
                        animationDuration: const Duration(milliseconds: 800),
                        chartLegendSpacing: 32.0,
                        chartType: ChartType.disc,
                        legendOptions: const LegendOptions(
                          legendTextStyle: TextStyle(
                            color: Colors.black,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                          ),
                          legendPosition: LegendPosition.left,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: Column(
                            children: [
                              ReusableRow(
                                'Total Cases',
                                widget.todayCases.toString(),
                              ),
                              ReusableRow(
                                'Recovered',
                                widget.recovered.toString(),
                              ),
                              ReusableRow(
                                'Deaths',
                                widget.deaths.toString(),
                              ),
                              ReusableRow(
                                'Active',
                                widget.active.toString(),
                              ),
                              ReusableRow(
                                'Today Deaths',
                                widget.todayDeaths.toString(),
                              ),
                              ReusableRow(
                                'Today Cases',
                                widget.todayCases.toString(),
                              ),
                              ReusableRow(
                                'Today Recovered',
                                widget.todayRecovery.toString(),
                              ),
                              ReusableRow(
                                'Total Tests',
                                widget.totalTests.toString(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30)
                ]),
          ),
        ),
      ),
    );
  }
}

import 'package:covid_tracker/Api/http.dart';
import 'package:covid_tracker/Screen/homepage.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../Model/india_model.dart';

class IndiaStats extends StatefulWidget {
  const IndiaStats({Key? key}) : super(key: key);

  @override
  _IndiaStatsState createState() => _IndiaStatsState();
}

class _IndiaStatsState extends State<IndiaStats> with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 3))
        ..repeat();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Apis api = Apis();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder(
            future: api.fetchIndiaReports(),
            builder: (context, AsyncSnapshot<IndiaModel> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SpinKitFadingCircle(
                    color: Colors.white, controller: _controller);
              } else if (snapshot.connectionState == ConnectionState.none) {
                return const Text("No Internet Connection");
              } else {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      const Text("India Stats",
                          style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      SizedBox(
                        height: 30,
                      ),
                      PieChart(
                        chartRadius: 160,
                        dataMap: {
                          'Total':
                              double.parse(snapshot.data!.cases.toString()),
                          'Recovered':
                              double.parse(snapshot.data!.recovered.toString()),
                          'Deaths':
                              double.parse(snapshot.data!.deaths.toString()),
                        },
                        chartValuesOptions: const ChartValuesOptions(
                            showChartValuesInPercentage: true),
                        animationDuration: const Duration(milliseconds: 800),
                        chartLegendSpacing: 32.0,
                        chartType: ChartType.ring,
                        legendOptions: const LegendOptions(
                          legendTextStyle: TextStyle(
                            color: Colors.black,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                          ),
                          legendPosition: LegendPosition.left,
                        ),
                        // colorList: colorList,
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: Column(
                            children: [
                              ReusableRow(
                                'Total Cases',
                                snapshot.data!.cases.toString(),
                              ),
                              ReusableRow(
                                'Recovered',
                                snapshot.data!.recovered.toString(),
                              ),
                              ReusableRow(
                                'Deaths',
                                snapshot.data!.deaths.toString(),
                              ),
                              ReusableRow(
                                'Active',
                                snapshot.data!.active.toString(),
                              ),
                              ReusableRow(
                                'Today Deaths',
                                snapshot.data!.todayDeaths.toString(),
                              ),
                              ReusableRow(
                                'Today Cases',
                                snapshot.data!.todayCases.toString(),
                              ),
                              ReusableRow(
                                'Today Recoverd',
                                snapshot.data!.todayRecovered.toString(),
                              ),
                              ReusableRow(
                                'Total Tests',
                                snapshot.data!.tests.toString(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                );
              }
            }),
      ),
    );
  }
}

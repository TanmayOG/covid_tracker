// ignore_for_file: unused_local_variable

import 'package:covid_tracker/Api/http.dart';
import 'package:covid_tracker/Model/india_model.dart';
import 'package:covid_tracker/Model/world_state.dart';
import 'package:covid_tracker/Screen/search.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 3))
        ..repeat();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController();
    PageController _pcontroller = PageController();

    int _curr = 0;
    int _curr1 = 0;
    Apis api = Apis();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.0,
        title: const Text("World Stats",
            style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder(
          future: api.fetchWorldRecords(),
          builder: (context, AsyncSnapshot<WorldStateModel> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SpinKitFadingCircle(
                  color: Colors.white, controller: _controller);
            } else if (snapshot.connectionState == ConnectionState.none) {
              return const Text("No Internet Connection");
            } else if (snapshot.hasError) {
              return Text('ERRORS:  ${snapshot.error}');
            } else {
              print(snapshot.data!.cases);
              return SingleChildScrollView(
                child: Column(
                  children: [
                    // ignore: prefer_const_constructors
                    SizedBox(
                      height: 20,
                    ),
                    PieChart(
                      chartRadius: 160,
                      dataMap: {
                        'Total': snapshot.data!.cases!.toDouble(),
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
                              'Today Recovered',
                              snapshot.data!.todayRecovered.toString(),
                            ),
                            ReusableRow(
                              'Affected Countries',
                              snapshot.data!.affectedCountries.toString(),
                            ),
                            ReusableRow(
                              'Total Tests',
                              snapshot.data!.tests.toString(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          }),
    );
  }
}

class ReusableRowIcon extends StatelessWidget {
  String? title;
  IconData? value;
  ReusableRowIcon(this.title, this.value, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title!),
              Icon(value!),
            ],
          )
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class ReusableRow extends StatelessWidget {
  String? title, value;
  ReusableRow(this.title, this.value, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title!),
              Text(value!),
            ],
          )
        ],
      ),
    );
  }
}

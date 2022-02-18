import 'package:covid_tracker/Api/http.dart';
import 'package:covid_tracker/Design/Counter.dart';
import 'package:covid_tracker/Model/india_model.dart';
import 'package:covid_tracker/News/news.dart';
import 'package:covid_tracker/Screen/homepage.dart';
import 'package:covid_tracker/Screen/india.dart';
import 'package:covid_tracker/Utils/url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../Screen/search.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final controller = ScrollController();
  double offset = 0;
  Apis api = Apis();
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 3))
        ..repeat();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  final colorList = <Color>[
    const Color(0xff4285f4),
    const Color(0xffdb4437),
    const Color(0xfff4b400),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            centerTitle: true,
            iconTheme: const IconThemeData(color: Colors.black),
            elevation: 0,
            title: const Text(
              "COVID-19 Tracker",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.addchart_outlined),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                  );
                },
              ),
            ],
          ),
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
                    controller: controller,
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 200,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "https://raw.githubusercontent.com/abuanwar072/Covid-19-Flutter-UI/master/assets/images/wear_mask.png"),
                                  fit: BoxFit.none),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(40),
                                  bottomRight: Radius.circular(40))),
                        ),
                        const SizedBox(height: 40),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: <Widget>[
                              RichText(
                                text: const TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "India\n",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  RichText(
                                    text: const TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "Case Update\n",
                                          style: kTitleTextstyle,
                                        ),
                                        TextSpan(
                                          text: "Newest update",
                                          style: TextStyle(
                                            color: kTextLightColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const IndiaStats()));
                                    },
                                    child: const Text(
                                      "See details",
                                      style: TextStyle(
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      offset: const Offset(0, 4),
                                      blurRadius: 30,
                                      color: kShadowColor,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Counter(
                                      color: kInfectedColor,
                                      number: snapshot.data!.cases,
                                      title: "Infected",
                                    ),
                                    Counter(
                                      color: kDeathColor,
                                      number: snapshot.data!.deaths,
                                      title: "Deaths",
                                    ),
                                    Counter(
                                      color: kRecovercolor,
                                      number: snapshot.data!.recovered,
                                      title: "Recovered",
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Search()));
                                },
                                child: Container(
                                  height: 50,
                                  margin: const EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    color: const Color(0xff4285f4),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "Track Others Country",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Column(
                          children: [
                            const Text("Read Latest Health News",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                )),
                            const SizedBox(height: 10),
                            ElevatedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HealthNews()));
                              },
                              icon: const Icon(
                                Icons.chrome_reader_mode_outlined,
                              ),
                              label: const Text(
                                "Read News",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                }
              })),
    );
  }
}

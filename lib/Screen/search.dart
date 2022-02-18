import 'package:covid_tracker/Api/http.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'detail.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> with TickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  late final AnimationController controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 3))
        ..repeat();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Apis api = Apis();
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
            title: TextField(
              keyboardType: TextInputType.text,
              keyboardAppearance: Brightness.dark,
              onChanged: (value) {
                setState(() {});
              },
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Search',
                border: InputBorder.none,
              ),
            ),
          ),
          backgroundColor: Colors.white,
          body: Column(children: [
            Expanded(
              flex: 1,
              child: FutureBuilder(
                  future: api.countriesRecords(),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return ListView.builder(
                          itemCount: 15,
                          itemBuilder: (context, snapshot) {
                            return Shimmer.fromColors(
                                baseColor: Colors.grey.shade700,
                                highlightColor: Colors.grey.shade100,
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade300,
                                        ),
                                      ),
                                      title: Container(
                                        width: 89,
                                        height: 10,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade300,
                                        ),
                                      ),
                                      subtitle: Container(
                                        width: 89,
                                        height: 10,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade300,
                                        ),
                                      ),
                                    ),
                                  ],
                                ));
                          });
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          String name = snapshot.data![index]['country'];
                          if (_controller.text.isEmpty) {
                            return Column(
                              children: [
                                ListTile(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DetailsPage(
                                                  name: snapshot.data![index]
                                                      ['country'],
                                                  cases: snapshot.data![index]
                                                      ['cases'],
                                                  deaths: snapshot.data![index]
                                                      ['deaths'],
                                                  recovered:
                                                      snapshot.data![index]
                                                          ['recovered'],
                                                  todayCases:
                                                      snapshot.data![index]
                                                          ['todayCases'],
                                                  todayDeaths:
                                                      snapshot.data![index]
                                                          ['todayDeaths'],
                                                  active: snapshot.data![index]
                                                      ['active'],
                                                  critical: snapshot
                                                      .data![index]['critical'],
                                                  population:
                                                      snapshot.data![index]
                                                          ['population'],
                                                  totalTests: snapshot
                                                      .data![index]['tests'],
                                                  todayRecovery:
                                                      snapshot.data![index]
                                                          ['todayRecovered'],
                                                  flag: snapshot.data![index]
                                                      ['countryInfo']['flag'],
                                                )));
                                  },
                                  leading: Image.network(
                                    snapshot.data![index]['countryInfo']
                                        ['flag'],
                                    height: 50,
                                    width: 50,
                                  ),
                                  title: Text(
                                    snapshot.data![index]['country'],
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    'Active Cases : ' +
                                        snapshot.data![index]['active']
                                            .toString(),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            );
                          } else if (name
                              .toLowerCase()
                              .contains(_controller.text.toLowerCase())) {
                            return Column(
                              children: [
                                ListTile(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DetailsPage(
                                                  name: snapshot.data![index]
                                                      ['country'],
                                                  cases: snapshot.data![index]
                                                      ['cases'],
                                                  deaths: snapshot.data![index]
                                                      ['deaths'],
                                                  recovered:
                                                      snapshot.data![index]
                                                          ['recovered'],
                                                  todayCases:
                                                      snapshot.data![index]
                                                          ['todayCases'],
                                                  todayDeaths:
                                                      snapshot.data![index]
                                                          ['todayDeaths'],
                                                  active: snapshot.data![index]
                                                      ['active'],
                                                  critical: snapshot
                                                      .data![index]['critical'],
                                                  population:
                                                      snapshot.data![index]
                                                          ['population'],
                                                  totalTests: snapshot
                                                      .data![index]['tests'],
                                                  todayRecovery:
                                                      snapshot.data![index]
                                                          ['todayRecovered'],
                                                  flag: snapshot.data![index]
                                                      ['countryInfo']['flag'],
                                                )));
                                  },
                                  leading: Image.network(
                                    snapshot.data![index]['countryInfo']
                                        ['flag'],
                                    height: 50,
                                    width: 50,
                                  ),
                                  title: Text(
                                    snapshot.data![index]['country'],
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    'Active Cases : ' +
                                        snapshot.data![index]['active']
                                            .toString(),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return Container();
                          }
                        },
                      );
                    }
                  }),
            ),
          ]
              //   TextField(
              //     controller: _controller,
              //     decoration: InputDecoration(
              //       hintText: 'Search',
              //       hintStyle: const TextStyle(
              //         color: Colors.white,
              //       ),
              //       prefixIcon: const Icon(
              //         Icons.search,
              //         color: Colors.white,
              //       ),
              //       filled: true,
              //       fillColor: Colors.white,
              //       border: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(30),
              //         borderSide: BorderSide.none,
              //       ),
              //       contentPadding: const EdgeInsets.symmetric(
              //         horizontal: 20,
              //         vertical: 16,
              //       ),
              //     ),
              //   )
              // ],
              )),
    );
  }
}

import 'package:covid_tracker/Api/http.dart';
import 'package:covid_tracker/News/searchBox.dart';
import 'package:covid_tracker/News/view_news.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Utils/colors.dart';
import '../Utils/const.dart';
import 'newsbox.dart';

class HealthNews extends StatefulWidget {
  const HealthNews({Key? key}) : super(key: key);

  @override
  HealthNewsState createState() => HealthNewsState();
}

class HealthNewsState extends State<HealthNews> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          foregroundColor: Colors.black,
          title: Padding(
            padding: EdgeInsets.only(
                right: MediaQuery.of(context).size.width * 0.07),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Health",
                    style: GoogleFonts.lato(
                        color: Colors.orange, fontWeight: FontWeight.bold)),
                Text("News",
                    style: GoogleFonts.lato(
                        color: Colors.black, fontWeight: FontWeight.bold))
              ],
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const SearchBar(),
            Expanded(
                child: SizedBox(
              width: w,
              child: FutureBuilder<List>(
                future: Apis().fetchNew(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              NewsView(
                                url: snapshot.data![index]['url'],
                              );
                              print(snapshot.data![index]['url']);
                            },
                            child: NewsBox(
                              url: snapshot.data![index]['url'],
                              // ignore: prefer_if_null_operators
                              imageurl: snapshot.data![index]['urlToImage'] ??
                                  Constant.imageurl,
                              title: snapshot.data![index]['title'],
                              time: snapshot.data![index]['publishedAt'],
                              description: snapshot.data![index]['description']
                                  .toString(),
                            ),
                          );
                        });
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }

                  return Center(child: CircularProgressIndicator());
                },
              ),
            ))
          ],
        ));
  }
}

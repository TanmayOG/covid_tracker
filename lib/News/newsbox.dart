import 'package:cached_network_image/cached_network_image.dart';
import 'package:covid_tracker/News/bottomsheet.dart';
import 'package:covid_tracker/News/view_news.dart';
import 'package:covid_tracker/Utils/colors.dart';
import 'package:flutter/material.dart';

import '../Utils/text.dart';

class NewsBox extends StatelessWidget {
  final String imageurl, url, time, title, description;

  const NewsBox(
      {Key? key,
      required this.imageurl,
      required this.url,
      required this.time,
      required this.title,
      required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return NewsView(
                url: url,
              );
            }));

            // showMyBottomSheet(context, title, description, imageurl, url);
          },
          child: Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.only(left: 5, right: 5, top: 5),
            width: w,
            color: Colors.white,
            child: Row(
              children: [
                CachedNetworkImage(
                  imageUrl: imageurl,
                  imageBuilder: (context, imageProvider) => Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.yellow),
                  ),
                  placeholder: (context, url) => CircularProgressIndicator(
                    color: Bgmi.primary,
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ModifiedText(text: title, size: 16, color: Colors.black),
                    const SizedBox(
                      height: 5,
                    ),
                    ModifiedText(text: time, size: 12, color: Colors.grey),
                  ],
                ))
              ],
            ),
          ),
        ),
        const Seperater()
      ],
    );
  }
}

class Seperater extends StatelessWidget {
  const Seperater({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: const Divider(
        color: Colors.white,
      ),
    );
  }
}

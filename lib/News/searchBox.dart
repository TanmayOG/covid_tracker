import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Api/http.dart';
import '../Utils/colors.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  static TextEditingController searchcontroller =
      TextEditingController(text: '');

  @override
  _SearchBarState createState() => _SearchBarState();
}

Bgmi cs = Bgmi();

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Container(
          height: 50,
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.only(left: 20),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(50),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: TextField(
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  textInputAction: TextInputAction.search,
                  controller: SearchBar.searchcontroller,
                  decoration: InputDecoration(
                      suffixIcon: InkWell(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          Apis().fetchNew();
                          setState(() {});
                        },
                        child: const Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                      ),
                      hintText: 'Search a Keyword',
                      hintStyle: GoogleFonts.lato(fontWeight: FontWeight.bold),
                      border: InputBorder.none),
                ))
              ],
            ),
          ),
        )),
        const SizedBox(
          width: 10,
        ),
      ],
    );
  }
}

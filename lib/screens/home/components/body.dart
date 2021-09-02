import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:kinoqahramon_firebase/constants.dart';
import 'package:kinoqahramon_firebase/models/character.dart';
import 'package:kinoqahramon_firebase/screens/detailsPage/detail.dart';

// 4 - Step API ga http request jonatayapmiz
class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Character> characterlarListi = [];
  int dataLength = 0;
  int randomImgAndName = 0;
  void characterlarniOlibKel() async {
    Response res =
        await get(Uri.parse("https://breakingbadapi.com/api/characters/"));
    // print(res.body.toString());
    var data = jsonDecode(res.body);
    // print(data[0]["name"]);
    // STEP - 5 API characterlarini bitta listga qoshdik
    setState(() {
      for (var i = 0; i < data.length; i++) {
        Character k = Character();
        k.id = data[i]["char_id"];
        k.name = data[i]["name"];
        k.img = data[i]["img"];
        k.birthday = data[i]["birthday"];
        k.portrayed = data[i]["portrayed"];
        k.nickname = data[i]["nickname"];
        characterlarListi.add(k);
      }
      dataLength = data.length;
      randomImgAndName = Random().nextInt(dataLength);
    });
  }

  @override
  void initState() {
    super.initState();
    characterlarniOlibKel();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return characterlarListi.length != 0
        ? SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: kPadding),
            child: Column(
              children: [
                // SEARCH SECTION
                Container(
                  child: TextField(
                    decoration: InputDecoration(
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      hintText: 'Search your location',
                      hintStyle: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey,
                      ),
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
                SizedBox(height: kPadding),
                // PICTURES SECTION
                Container(
                  height: size.height * 0.5,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1.2 / 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 25,
                    ),
                    itemCount: characterlarListi.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailPage(
                                id: characterlarListi[index].id,
                                hero: "pic$index",
                              ),
                            ),
                          );
                        },
                        child: HeroMode(
                          enabled: true,
                          child: Hero(
                            tag: "pic$index",
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              characterlarListi[index]
                                                  .img
                                                  .toString()),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5.0),
                                  Text(
                                    characterlarListi[index].name.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2!
                                        .copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16.0),
                                  ),
                                  SizedBox(height: 3.0),
                                  Text(
                                    characterlarListi[index]
                                        .nickname
                                        .toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12.0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(height: kPadding * 2),
                // FEATURED SECTION TITLE
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Death of Day",
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                          color: Colors.black, fontWeight: FontWeight.w600),
                    ),
                    Row(
                      children: [
                        Text(
                          "View all",
                          style: Theme.of(context).textTheme.caption,
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 13.0,
                          color: Colors.grey,
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: kPadding),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(kPadding - 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 10.0,
                            spreadRadius: 5.0,
                          )
                        ],
                      ),
                      // RANDOM DEATH
                      child: Row(
                        children: [
                          Container(
                            width: 70.0,
                            height: 70.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                image: NetworkImage(
                                    characterlarListi[randomImgAndName]
                                        .img
                                        .toString()),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: kPadding),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      characterlarListi[randomImgAndName]
                                          .name
                                          .toString(),
                                      style:
                                          Theme.of(context).textTheme.subtitle2,
                                    ),
                                    Text(
                                      "\$Free",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!
                                          .copyWith(
                                              fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                Text(
                                  characterlarListi[randomImgAndName]
                                      .birthday
                                      .toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(fontWeight: FontWeight.w500),
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.star_sharp,
                                        color: Colors.orange, size: 15.0),
                                    Icon(Icons.star_sharp,
                                        color: Colors.orange, size: 15.0),
                                    Icon(Icons.star_sharp,
                                        color: Colors.orange, size: 15.0),
                                    Icon(Icons.star_sharp,
                                        color: Colors.orange, size: 15.0),
                                    Icon(Icons.star_sharp,
                                        color: Colors.orange, size: 15.0),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ))
        : Center(
            child: SpinKitCubeGrid(
              itemBuilder: (BuildContext context, int index) {
                return DecoratedBox(
                  decoration: BoxDecoration(
                    color: index.isEven ? Colors.red : Colors.green,
                  ),
                );
              },
            ),
          );
  }
}

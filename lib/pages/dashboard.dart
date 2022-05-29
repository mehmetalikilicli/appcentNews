// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:appcentnews/model/news_model.dart';
import 'package:appcentnews/pages/details.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

List<Article> favoriteList = [];

class Dashboard extends StatefulWidget {
  Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String tempKey = "besiktas";
  bool isClicked = false;
  bool isFavorite = false;
  TextEditingController searchConroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    int selectedMenuItem = 0;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              search(height),
              Container(
                height: height * 0.81,
                child: News(height),
              ),
              //searchNews()
            ],
          ),
        ),
      ),
    );
  }

  Stack search(double height) {
    return Stack(
      children: [
        Container(
          height: height * 0.08,
          child: TextField(
            controller: searchConroller,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                fillColor: Colors.white,
                hoverColor: Colors.white,
                focusColor: Colors.black,
                border: OutlineInputBorder(),
                labelText: 'Search',
                labelStyle: TextStyle(color: Colors.white)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 320),
          child: IconButton(
            onPressed: () {
              setState(() {
                tempKey = searchConroller.text;
              });
            },
            icon: Icon(Icons.search),
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget searchNews() {
    return Container(
      height: 100,
      child: TextField(
        controller: searchConroller,
        decoration: InputDecoration(
            fillColor: Colors.white,
            hoverColor: Colors.white,
            focusColor: Colors.black,
            border: OutlineInputBorder(),
            labelText: 'Search',
            labelStyle: TextStyle(color: Colors.white)),
      ),
    );
  }

  FutureBuilder<AppcentNews> News(double height) {
    return FutureBuilder(
      future: _getNews(),
      builder: (context, AsyncSnapshot<AppcentNews> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.articles.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(
                  top: 6,
                  bottom: 6,
                ),
                child: Container(
                  height: height * 0.11,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade800,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: ListTile(
                      leading: Container(
                          width: 110,
                          child: Image.network(
                              snapshot.data!.articles[index].urlToImage,
                              fit: BoxFit.contain)),
                      title: Text(
                        snapshot.data!.articles[index].title.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        debugPrint("Yonlendiriliyor");
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                NewsDetails(snapshot.data!.articles[index]),
                          ),
                        );
                      },
                      trailing: IconButton(
                        onPressed: () {
                          setState(() {
                            if (!snapshot.data!.articles[index].isFavorite) {
                              snapshot.data!.articles[index].isFavorite = true;
                              favoriteList.add(snapshot.data!.articles[index]);
                            }
                          });

                          /*if (favoriteList
                                .contains(snapshot.data!.articles[index])) {
                              favoriteList
                                  .remove(snapshot.data!.articles[index]);
                              snapshot.data!.articles[index].isFavorite =
                                  !snapshot.data!.articles[index].isFavorite;
                              for (int i = 0; i < favoriteList.length; i++) {
                                print(i);
                              }
                            } else {
                              favoriteList.add(snapshot.data!.articles[index]);
                              snapshot.data!.articles[index].isFavorite =
                                  !snapshot.data!.articles[index].isFavorite;
                            }*/
                        },
                        icon: Icon(Icons.favorite,
                            color: snapshot.data!.articles[index].isFavorite
                                ? Colors.red
                                : Colors.white),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Future<AppcentNews> _getNews() async {
    String url = "https://newsapi.org/v2/everything?q=" +
        tempKey +
        "&page=1&apiKey=16035afb911b4a4281ccde6e3de9f0e0";
    var response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      AppcentNews newsList = appcentNewsFromMap(response.body.toString());

      return newsList;
    } else {
      throw Exception("Bağlanamadı...${response.statusCode}");
    }
  }
}

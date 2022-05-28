// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:appcentnews/model/news_model.dart';
import 'package:appcentnews/pages/news_details_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AllNews extends StatefulWidget {
  AllNews({Key? key}) : super(key: key);

  @override
  State<AllNews> createState() => _AllNewsState();
}

class _AllNewsState extends State<AllNews> {
  TextEditingController searchConroller = TextEditingController();
  String url =
      "https://newsapi.org/v2/everything?q=türkiye&page=1&apiKey=16035afb911b4a4281ccde6e3de9f0e0";

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.red,
              height: 100,
            ),
            Container(
              height: height * 0.7,
              child: News(height),
            ),
            //searchNews()
          ],
        ),
      ),
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
                      leading: Image.network(
                        snapshot.data!.articles[index].urlToImage,
                      ),
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

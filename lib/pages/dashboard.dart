import 'dart:convert';

import 'package:appcentnews/model/news_model.dart';
import 'package:appcentnews/pages/news_details.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AllNews extends StatefulWidget {
  AllNews({Key? key}) : super(key: key);

  @override
  State<AllNews> createState() => _AllNewsState();
}

class _AllNewsState extends State<AllNews> {
  String url =
      "https://newsapi.org/v2/everything?q=galatasaray&page=1&apiKey=16035afb911b4a4281ccde6e3de9f0e0";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: News(),
    );
  }

  FutureBuilder<AppcentNews> News() {
    return FutureBuilder(
      future: _getNews(),
      builder: (context, AsyncSnapshot<AppcentNews> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.articles.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(snapshot.data!.articles[index].author.toString()),
                onTap: () {
                  debugPrint("Yonlendiriliyor");
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => NewsDetails(),
                    ),
                  );
                },
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

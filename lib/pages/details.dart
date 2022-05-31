// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:appcentnews/model/news_model.dart';
import 'package:appcentnews/pages/webview.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class NewsDetails extends StatefulWidget {
  Article tappedNews;
  NewsDetails(this.tappedNews, {Key? key}) : super(key: key);

  @override
  State<NewsDetails> createState() => _NewsDetailsState(this.tappedNews);
}

class _NewsDetailsState extends State<NewsDetails> {
  Article newsDetails;
  _NewsDetailsState(this.newsDetails);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: height * 0.36,
                      width: width * 0.96,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Image.network(
                        newsDetails.urlToImage,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 320.0),
                      child: IconButton(
                        onPressed: () async {
                          final url = newsDetails.url;
                          await Share.share(
                              "Haberi Göz Atabilirsin :D \n $url");
                        },
                        icon: Icon(
                          Icons.share,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8),
                  child: Text(
                    newsDetails.title,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 60.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.source,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text(
                          "Source: " + newsDetails.source.name,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 60.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.border_color_rounded,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text(
                          "By: " + newsDetails.author,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 60.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.date_range,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text(
                          "Date: " +
                              newsDetails.publishedAt
                                  .toString()
                                  .substring(0, 10),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8),
                  child: Text(
                    newsDetails.content,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 30,
              left: (width * 0.5) - 100,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Webview(newsDetails.url)),
                  );
                },
                child: Container(
                  height: 70,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade800,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "Haber Kaynagina Git",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

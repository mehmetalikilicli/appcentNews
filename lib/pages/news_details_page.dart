// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:appcentnews/model/news_model.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Image.network(newsDetails.urlToImage),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Text(newsDetails.title),
            Text(
              "Kaynak: " + newsDetails.source.name,
              style: TextStyle(color: Colors.white),
            ),
            Text(
              "Yazar: " + newsDetails.author,
              style: TextStyle(color: Colors.white),
            ),
            Text(
              newsDetails.title,
              style: TextStyle(color: Colors.white),
            ),
            Text(
              newsDetails.content,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

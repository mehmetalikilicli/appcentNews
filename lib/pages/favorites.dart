import 'package:appcentnews/model/news_model.dart';
import 'package:appcentnews/pages/dashboard.dart';
import 'package:appcentnews/pages/details.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatefulWidget {
  List<Article> favoritesList;
  FavoritesPage(this.favoritesList, {Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState(this.favoritesList);
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<Article> favoritesList;

  _FavoritesPageState(this.favoritesList);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: ListView.builder(
        itemCount: favoritesList.length,
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
                      child: Image.network(favoritesList[index].urlToImage,
                          fit: BoxFit.contain)),
                  title: Text(
                    favoritesList[index].title.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    debugPrint("Yonlendiriliyor");
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => NewsDetails(favoritesList[index]),
                      ),
                    );
                  },
                  trailing: IconButton(
                    onPressed: () {
                      setState(() {
                        favoritesList.removeAt(index);
                      });
                    },
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

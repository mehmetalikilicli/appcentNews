import 'package:appcentnews/model/news_model.dart';
import 'package:appcentnews/pages/news.dart';
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
      backgroundColor: Colors.black,
      body: ListView.builder(
        itemCount: favoritesList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(
              top: 6,
              bottom: 6,
            ),
            child: Container(
              height: height * 0.13,
              decoration: BoxDecoration(
                  color: Colors.grey.shade800,
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: ListTile(
                  leading: Container(
                    width: 110,
                    child: Image.network(favoritesList[index].urlToImage,
                        fit: BoxFit.contain),
                  ),
                  title: Text(
                    favoritesList[index].title.toString() + "\n", //+
                    // snapshot.data!.articles[index].description,
                    //Aciklamalar ve basliklar cok uzun oldugu icin sadece basliklari ekledim
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  subtitle: Text(
                    "Date: " +
                        (favoritesList[index].publishedAt.toString())
                            .substring(0, 10) +
                        "\n" +
                        "Source: " +
                        favoritesList[index].source.name,
                    style: TextStyle(color: Colors.white, fontSize: 12),
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

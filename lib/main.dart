// ignore_for_file: prefer_const_constructors

import 'package:appcentnews/pages/news.dart';
import 'package:appcentnews/pages/favorites.dart';
import 'package:appcentnews/pages/details.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const AppcentNewsApp());
}

class AppcentNewsApp extends StatefulWidget {
  const AppcentNewsApp({Key? key}) : super(key: key);

  @override
  State<AppcentNewsApp> createState() => _AppcentNewsAppState();
}

class _AppcentNewsAppState extends State<AppcentNewsApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Appcent NewsApp',
      theme: ThemeData(primarySwatch: Colors.grey),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedMenuItem = 0;
  List? allPages;
  Dashboard? allNews;
  FavoritesPage? favoritesPage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    allNews = Dashboard();
    favoritesPage = FavoritesPage(favoriteList);
    allPages = [allNews, favoritesPage];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: allPages?[selectedMenuItem],
      bottomNavigationBar: bottomNavMenu(),
    );
  }

  bottomNavMenu() {
    return BottomNavigationBar(
      // ignore: prefer_const_literals_to_create_immutables
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.newspaper,
            color: Colors.black,
          ),
          label: 'News',
          backgroundColor: Colors.black,
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.favorite,
            color: Colors.red,
          ),
          label: 'Favorites',
        ),
      ],
      currentIndex: selectedMenuItem,
      onTap: (index) {
        setState(() {
          selectedMenuItem = index;
        });
      },
    );
  }
}

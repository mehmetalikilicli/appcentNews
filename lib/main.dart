// ignore_for_file: prefer_const_constructors

import 'package:appcentnews/pages/dashboard.dart';
import 'package:appcentnews/pages/favorites.dart';
import 'package:appcentnews/pages/details.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Appcent NewsApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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
            icon: Icon(Icons.newspaper),
            label: 'News',
            backgroundColor: Colors.amber),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favorites',
          backgroundColor: Colors.red,
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

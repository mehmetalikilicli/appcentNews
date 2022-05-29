// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Webview extends StatefulWidget {
  String url;

  Webview(this.url, {Key? key}) : super(key: key);

  @override
  State<Webview> createState() => _WebviewState(this.url);
}

class _WebviewState extends State<Webview> {
  String url;

  _WebviewState(this.url);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          WebView(
            initialUrl: url,
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ],
      ),
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';


import 'home_page.dart';



void main() {
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(
         channel: IOWebSocketChannel.connect('ws://localhost:8080/ws-mobile'),
      ),
    );
  }
}




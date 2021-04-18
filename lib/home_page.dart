import 'dart:convert';
import 'dart:core';
import 'dart:async';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:http/http.dart' as http;

import 'detail_screen.dart';

class HomePage extends StatefulWidget {
  final IOWebSocketChannel channel;

  const HomePage({Key key, this.channel}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String scanResult = " ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Homepage"),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image(
                image: NetworkImage(
                    "https://media.istockphoto.com/vectors/qr-code-scan-phone-icon-in-comic-style-scanner-in-smartphone-vector-vector-id1166145556")),
            //flatButton('Scan QR CODE', Handler()),
            FlatButton(
              onPressed: () async {
                try {
                  String codeScanned = await BarcodeScanner.scan();
                  //setState(() => this.scanResult = codeScanned);
                  var scanResult = codeScanned;
                  if (scanResult != null) {
                    print("[TOKEN STRING]" + scanResult);

                    //push resuts to next page
                    pushToDetailScreen(scanResult);
                    //
                   // callDetailScreen(scanResult);
                  }
                } catch (e) {
                  setState(() => this.scanResult = 'Unknown error: $e');
                }

                //barcode scnner

                // qrCodeResult = codeSanner;
              },
              child: Text(
                "Open Scanner",
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.blue, width: 3.0),
                  borderRadius: BorderRadius.circular(20.0)),
            ),
            SizedBox(
              height: 20.0,
            ),
            //flatButton("Generate QR CODE", GeneratePage()),
          ],
        ),
      ),
    );
  }

//ip for deskop;10.63.148.202
//ip for mobile:10.143.78.135

  // var baseUrl =
  //    int.tryParse('http://41.215.173.6:8080/mobile-login') ?? 'Format error!';
  //
  var baseUrl =
      int.tryParse('http://10.56.172.68:8080/mobile-login') ?? 'Format error!';

  //var baseUrl = Uri.parse('http://localhost:8080');
  // pushToDetailScreen(codeSanner) {

  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => DetailScreen(codeSanner: codeSanner),
  //     ),
  //   );
  // }

  callDetailScreen(scanResult) {
    var data = scanResult;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailScreen(data: data),
      ),
    );
  }

  Future<http.Response> pushToDetailScreen(String scanResult) async {
    final response = await http.post(
      Uri.http('$baseUrl', 'data'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'data': scanResult,
      }),
    );
    if (response.statusCode == 200) {
      // If the server did return a 200 CREATED response,
      var data = response.body;
      print("[SCANRESULT STRING]" + scanResult);
      // widget.channel.sink.add(data);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailScreen(data: data),
        ),
      );
      // then parse the JSON.
      return jsonDecode(response.body);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Widget flatButton(String text, Widget widget) {
    return FlatButton(
      padding: EdgeInsets.all(15.0),
      onPressed: () async {
        await Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => widget));
      },
      child: Text(
        text,
        style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
      ),
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.blue, width: 3.0),
          borderRadius: BorderRadius.circular(20.0)),
    );
  }

  @override
  void dispose() {
    widget.channel.sink.close();
    super.dispose();
  }
}

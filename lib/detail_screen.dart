import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String data;

  const DetailScreen({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checks Details'),
      ),
      body: ListView(
        children: <Widget>[
       const SizedBox(height: 30),
          buildCard(data),
      const SizedBox(height: 30),
          showScanResult(data),
        ],
      ),
    );
  }
}

// Widget function to present data from ws-mobile
// backend
Widget buildCard(data) {
  return Center(
    child: Card(
      elevation: 3.0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const ListTile(
            //rtrailing: Icon(Icons.logout),
            title: Text("Today's details"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text('16-04-2021'),
              const SizedBox(width: 8),
              Text('09:05AM'),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget showScanResult(data) {
  return Expanded(child: Text('$data'));
}

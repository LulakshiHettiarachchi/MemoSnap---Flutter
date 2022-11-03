import 'dart:html';

import 'package:flutter/material.dart';

//void main() => runApp(const MyHome());

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  //static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: _title,
      home: Scaffold(
        //appBar: AppBar(title: const Text(_title)),
        body: const MyStatelessWidget(),
      ),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: EdgeInsets.all(30),
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              // borderRadius: BorderRadius.circular(8.0),
              child: Image.network("https://i.postimg.cc/jjf5Z8ct/i1.jpg"),
            ),
            const ListTile(
              //leading: Icon(Icons.album),
              title: Text('The Magic Resort'),
              subtitle: Text('2022/10/25'),
            ),
            Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                    "I visit here on octomber last week 2022,It is great place to visit.In here there are lot of packages with flexible prices.visit"))

            /* Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text('BUY TICKETS'),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 8),
                TextButton(
                  child: const Text('LISTEN'),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 8),
              ],
            ),*/
          ],
        ),
      ),
    ));
  }
}

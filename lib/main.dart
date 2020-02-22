import 'package:flutter/material.dart';
import 'InterestRateConverter.dart';

void main(){
  runApp(
    MaterialApp(
      home:Home()
    )
  );
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Financial Calc"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          RaisedButton(
            child: Text("Interest Rate Converter"),
            padding: EdgeInsets.all(16),
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InterestRateConverter())
              );
            },
          ),
        ],
      ),
    );
  }
}
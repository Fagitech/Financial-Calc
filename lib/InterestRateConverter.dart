import 'package:flutter/material.dart';
import 'dart:math';

class InterestRateConverter extends StatefulWidget {
  @override
  _InterestRateConverterState createState() => _InterestRateConverterState();
}

class _InterestRateConverterState extends State<InterestRateConverter> {

  String _btn = "Calculate";
  static int _yearDays = 365;
  double _monthDays = _yearDays/12;

  TextEditingController _perYear = TextEditingController();
  TextEditingController _perMonth = TextEditingController();
  TextEditingController _perDay = TextEditingController();

  void _calculate(){
    if (_btn == "Clear"){
      _perYear.text = "";
      _perMonth.text = "";
      _perDay.text = "";
      setState(() {
       _btn = "Calculate";
      });
    }else{
      if( _perYear.text == "" && _perMonth.text == "" && _perDay.text == "" ){
        print("Error");
        showDialog(
            context: context,
            builder: (BuildContext context){
              return AlertDialog(
                title: Text("Fill in a field",style: TextStyle(fontSize: 20)),
                actions:[
                  FlatButton(
                    child: Text("OK",style: TextStyle(fontSize: 18)),
                    onPressed: (){Navigator.of(context).pop();},
                  )
                ],
              );
            }
        );
      }else if(_perYear.text != ""){
        double perYear = double.tryParse(_perYear.text);
        var perMonth = (pow(1 + perYear/100, 1/12) - 1) * 100;
        var perDay = (pow(1 + perYear/100, 1/_yearDays) - 1) * 100;
        _perMonth.text = perMonth.toString();
        _perDay.text = perDay.toString();
        setState(() {
         _btn = "Clear";
        });
      }else if(_perMonth.text != ""){
        double perMonth = double.tryParse(_perMonth.text);
        var perYear = (pow(1 + perMonth/100, 12) - 1) * 100;
        var perDay = (pow(1 + perMonth/100, 1/_monthDays) - 1) * 100;
        _perYear.text = perYear.toString();
        _perDay.text = perDay.toString();
        setState(() {
         _btn = "Clear";
        });
      }else if(_perDay.text != ""){
        double perDay = double.tryParse(_perDay.text);
        var perYear = (pow(1 + perDay/100, _yearDays) - 1) * 100;
        var perMonth = (pow(1 + perDay/100, _monthDays) - 1) * 100;
        _perYear.text = perYear.toString();
        _perMonth.text = perMonth.toString();
        setState(() {
         _btn = "Clear";
        });
      }
    }
  }

@override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          title: Text("Interest Rate Converter")
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(top: 16),
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Interest per Year (%)",
                      labelStyle: TextStyle(
                        fontSize: 24,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14.0)
                      )
                  ),
                  style: TextStyle(
                      fontSize: 20
                  ),
                  controller: _perYear,
                )
            ),

            Padding(
                padding: EdgeInsets.only(top: 16),
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Interest per Month (%)",
                      labelStyle: TextStyle(
                          fontSize: 24
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14.0)
                      )
                  ),
                  style: TextStyle(
                      fontSize: 20
                  ),
                  controller: _perMonth,
                )
            ),
            Padding(
                padding: EdgeInsets.only(top: 16),
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "interest per Day (%)",
                      labelStyle: TextStyle(
                          fontSize: 24
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14.0)
                      )
                  ),
                  style: TextStyle(
                      fontSize: 20
                  ),
                  controller: _perDay,
                )
            ),
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: RaisedButton(
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.0),
                ),
                padding: EdgeInsets.fromLTRB(64, 16, 64, 16),
                child: Text(
                 _btn,
                  style: TextStyle(
                      fontSize: 26,
                      color: Colors.white
                  ),
                ),
                onPressed: (){
                  _calculate();
                },
              ),
            )

          ],
        ),
      ),
    );
  }
}
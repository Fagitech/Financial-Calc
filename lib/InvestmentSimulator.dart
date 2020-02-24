import 'package:flutter/material.dart';
import 'dart:math';


class InvestmentSimulator extends StatefulWidget {
  @override
  _InvestmentSimulatorState createState() => _InvestmentSimulatorState();
}

class _InvestmentSimulatorState extends State<InvestmentSimulator> {

  TextEditingController _valorFuturo = TextEditingController();
  TextEditingController _valorInicial = TextEditingController();
  TextEditingController _aporteMensal = TextEditingController();
  TextEditingController _rendimento = TextEditingController();
  TextEditingController _periodo = TextEditingController();


  List<bool> _enable = [false, true, true, true, true];

  _inputFields(){

    Map< int, List<dynamic> > _map = {
      0 : [ "Valor futuro (R\$)"     , _valorFuturo  , _enable[0] ],
      1 : [ "Valor inicial (R\$)"    , _valorInicial , _enable[1]  ],
      2 : [ "Aporte mensal (R\$)"    , _aporteMensal , _enable[2]  ],
      3 : [ "Rendimento mensal (%)"  , _rendimento   , _enable[3]  ],
      4 : [ "Período (meses)"        , _periodo      , _enable[4]  ],
    };

    List<Widget> list = [];
    for( int i = 0; i < _map.length; i++ ){
      list += [
        Padding(
            padding: EdgeInsets.only(top: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[

                Radio(
                    activeColor: Colors.blue,
                    value: i,
                    groupValue: _radioGroup,
                    onChanged: (op){
                      setState(() {
                        _radioGroup = op;
                        _enable = [true, true, true, true, true];
                        _enable[op] = false;
                      });
                    }
                ),

                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    enabled: _map[i][2],
                    decoration: InputDecoration(
                        labelText: _map[i][0],
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
                    controller: _map[i][1],
                  ),
                ),

              ],
            )
        )
        ];
    }
      return list;
  }

   _calcular(){

    double _vf = double.tryParse(_valorFuturo.text) ?? 0;
    double _vi = double.tryParse(_valorInicial.text) ?? 0;
    double _am = double.tryParse(_aporteMensal.text) ?? 0;
    double _r = double.tryParse(_rendimento.text) ?? 0;
    double _p = double.tryParse(_periodo.text) ?? 0;


    switch(_radioGroup){

      case 0:
        print(_radioGroup);
        var _x = _vi * pow(1 + _r / 100, _p) + _am * (pow(1 + _r/100, _p) - 1) / (_r/100);
        if(_x.isNaN){
          setState(() {
            _resultado = "0";
          });
        }else{
          setState(() {
            _resultado = _x.toStringAsFixed(2);
          });
        }
        break;

      case 1:
        print(_radioGroup);
        break;
      case 2:
        print(_radioGroup);
        break;
      case 3:
        print(_radioGroup);
        break;
      case 4:
        print(_radioGroup);
        break;
    }

  }

  _clear(){
    _valorFuturo.text = "";
    _valorInicial.text = "";
    _aporteMensal.text = "";
    _rendimento.text = "";
    _periodo.text ="";
    setState(() {
      _resultado = "0";
    });
  }

  String _resultado = "0";
  int _radioGroup = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Investment Simulator")
      ),
      body: Container(
        height: double.infinity,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[


              Padding(
                  padding: EdgeInsets.only(bottom: 32),
                  child: Text(
                    "$_resultado",
                    style: TextStyle(
                        fontSize: 48
                    ),
                    textAlign: TextAlign.center,
                  )
              ),

              Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    RaisedButton(
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.clear_all),
                            Text("Clear")
                          ],
                        ),
                        onPressed: _clear
                    )
                  ]
              ),

              Column(
                children: _inputFields(),
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
                      "Calcular",
                      style: TextStyle(
                          fontSize: 26,
                          color: Colors.white
                      ),
                    ),
                    onPressed: _calcular
                ),
              )

            ],
          ),
        ),
      )
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _weigthController = new TextEditingController();
  TextEditingController _heightController = new TextEditingController();
  GlobalKey<FormState> _formState = new GlobalKey();
  String _infoText = "Informe seus dados.";

  void _resetFields() {
    _weigthController.text = "";
    _heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados.";
      _formState = new GlobalKey();
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(_weigthController.text);
      double height = double.parse(_heightController.text) / 100;
      double imc = weight / (height * height);
      if (imc < 18.6) {
        _infoText = "Abaixo do peso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = "Peso ideal (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = "Levemente acima do peso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = "Obsesidade Grau I (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 34.9 && imc < 40) {
        _infoText = "Obsesidade Grau II (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 40) {
        _infoText = "Obsesidade Grau III (${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.purple[300],
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetFields,
            )
          ],
        ),
        backgroundColor: Colors.grey[100],
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: Form(
              key: _formState,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(
                    Icons.person_outline,
                    size: 100.0,
                    color: Colors.purple[100],
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Peso (kg)",
                      labelStyle: TextStyle(color: Colors.black26),
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black54, fontSize: 20.0),
                    controller: _weigthController,
                    validator: (value) {
                      if (value.isEmpty) return "Insira seu peso";
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Altura (cm)",
                      labelStyle: TextStyle(color: Colors.black26),
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black54, fontSize: 20.0),
                    controller: _heightController,
                    validator: (value) {
                      if (value.isEmpty) return "Insira sua altura";
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15.0, bottom: 10.0),
                    child: Container(
                      height: 50,
                      child: RaisedButton(
                        onPressed: () {
                          if (_formState.currentState.validate()) _calculate();
                        },
                        child: Text(
                          "Calcular",
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                        color: Colors.purple[300],
                      ),
                    ),
                  ),
                  Text(
                    _infoText,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.purple[300], fontSize: 20.0),
                  )
                ],
              ),
            )));
  }
}

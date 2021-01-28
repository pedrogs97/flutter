import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const uriRequest = 'https://api.hgbrasil.com/finance?format=json&key=30d5c3a7 ';

void main(List<String> args) {
  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(
        hintColor: Colors.amber,
        primaryColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
          hintStyle: TextStyle(color: Colors.amber),
        )),
  ));
}

Future<Map> getDataCurrencies() async {
  http.Response response = await http.get(uriRequest);
  return json.decode(response.body)['results']['currencies'];
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double _dolar = 0.0;
  double _eur = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: Text('\$ Conversor \$'),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
        future: getDataCurrencies(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                  child: Text(
                'Carregando dados...',
                style: TextStyle(color: Colors.amber, fontSize: 20.0),
                textAlign: TextAlign.center,
              ));
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Erro ao carregar dados.',
                    style: TextStyle(color: Colors.amber, fontSize: 20.0),
                    textAlign: TextAlign.center,
                  ),
                );
              } else {
                _dolar = snapshot.data['USD']['buy'];
                _eur = snapshot.data['EUR']['buy'];
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Icon(Icons.monetization_on,
                          size: 100.0, color: Colors.amber),
                      TextField(
                        decoration: InputDecoration(
                            labelText: 'Reais',
                            labelStyle: TextStyle(color: Colors.amber),
                            border: OutlineInputBorder(),
                            prefix: Text('R\$')),
                        style: TextStyle(color: Colors.amber, fontSize: 20.0),
                      )
                    ],
                  ),
                );
              }
          }
        },
      ),
    );
  }
}

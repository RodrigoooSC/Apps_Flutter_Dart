import 'dart:convert';

import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:searchable_dropdown/searchable_dropdown.dart';


// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;

import '../model/tempoModel.dart';
import '../widgets/tempo_widgets.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = false;
  late TempoData tempoData;

  List<String> _cidades = [
    'Aracaju',
    'Belém',
    'Belo Horizonte',
    'Boa Vista',
    'Brasilia',
    'Campo Grande',
    'Cuiaba',
    'Curitiba',
    'Florianópolis',
    'Fortaleza',
    'Goiânia',
    'João Pessoa',
    'Macapá',
    'Maceió',
    'Manaus',
    'Natal',
    'Palmas',
    'Porto Alegre',
    'Porto Velho',
    'Recife',
    'Rio Branco',
    'Rio de Janeiro',
    'Salvador',
    'São Luiz',
    'São Paulo',
    'Teresina',
    'Vitoria'
  ];

  String _cidadeSelecionada = "São Paulo";
  
  
  @override
  void initState() {
    super.initState();
    carregaTempo();
  }

  carregaTempo() async {
    setState(() {
      isLoading = true;
    });

    String appid = '14e75ce78bad027620834e45a017ef12'; //Chave da api
    String lang = 'pt_br'; //Linguagem
    String units = 'metric'; // Conversão de temperatura

   final tempoReponse = await http.get(
        'https://api.openweathermap.org/data/2.5/weather?q=$_cidadeSelecionada&appid=$appid&units=$units&lang=$lang');
 
    print('Url montada: ' + tempoReponse.request.url.toString());

    if (tempoReponse.statusCode == 200) {
      return setState(() {
        tempoData = TempoData.fromJson(jsonDecode(tempoReponse.body));
        isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_cidadeSelecionada),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [

            // Mudar componente
            SearchableDropdown.single(
              items: _cidades
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _cidadeSelecionada = value;
                  carregaTempo();
                });
              },
              displayClearIcon: false,
              value: _cidadeSelecionada,
              icon: Icon(Icons.location_on),
              isExpanded: true,
              closeButton: "Fechar",
            ),
 

            
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(6.0),
                  child: isLoading
                      ? CircularProgressIndicator(
                          strokeWidth: 4.0,
                          valueColor: new AlwaysStoppedAnimation(Colors.blue),
                        )
                      : tempoData != null
                          ? Tempo(temperatura: tempoData)
                          : Container(
                              child: Text(
                                "Sem dados para exibir!",
                                style: Theme.of(context).textTheme.headline4,
                              ),
                            ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: isLoading
                      ? Container(
                          child: Text(
                          "Carregando...",
                          style: Theme.of(context).textTheme.headline5,
                        ))
                      : IconButton(
                          icon: Icon(Icons.refresh),
                          iconSize: 40.0,
                          tooltip: 'Recarregar',
                          onPressed: carregaTempo,
                          color: Colors.blue,
                        ),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}

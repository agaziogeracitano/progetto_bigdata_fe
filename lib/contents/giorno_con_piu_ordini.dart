import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:syncfusion_flutter_charts/charts.dart';

class GiornoConPiuOrdini extends StatefulWidget {
  @override
  _GiornoConPiuOrdiniState createState() => _GiornoConPiuOrdiniState();
}

class _GiornoConPiuOrdiniState extends State<GiornoConPiuOrdini> {
  List<Map<String, dynamic>> _giorni = []; // Lista dei giorni
  bool _isLoadingLeft = false;
  bool _isLoadingRight = false;
  bool _leftQueryCompleted = false;
  String _secondResponse = '';

  final giorniSettimana = ['Domenica', 'Lunedì', 'Martedì', 'Mercoledì', 'Giovedì', 'Venerdì', 'Sabato'];

  Future<void> fetchGiornoConPiuOrdini() async {
    setState(() {
      _isLoadingLeft = true;
      _leftQueryCompleted = false; // Disabilita il bottone a destra
    });

    try {
      final response = await http.get(Uri.parse('http://localhost:6060/topOrderDay'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);

        setState(() {
          _giorni = jsonData
              .map((item) => {
            "giorno": item['order_dow'].toString(),
            "ordiniTotali": int.parse(item['ordiniTotali'].toString()),
          })
              .toList();
          _leftQueryCompleted = true; // Abilita il bottone a destra
        });
      } else {
        throw Exception('Errore HTTP: ${response.statusCode}');
      }
    } catch (error) {
      print("Errore: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Errore nel recupero dei dati: $error"),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoadingLeft = false;
      });
    }
  }

  Future<void> fetchSecondData() async {
    setState(() {
      _isLoadingRight = true;
    });

    try {
      final response = await http.get(Uri.parse('http://localhost:6060/chiediAchat'));

      if (response.statusCode == 200) {
        setState(() {
          _secondResponse = response.body;
          _isLoadingRight = false;
        });
      } else {
        setState(() {
          _secondResponse = 'Errore nella richiesta: ${response.statusCode}';
          _isLoadingRight = false;
        });
      }
    } catch (error) {
      setState(() {
        _secondResponse = 'Errore nella richiesta: $error';
        _isLoadingRight = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Giorni con più ordini", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Parte sinistra (2/3)
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton(
                    onPressed: _isLoadingLeft ? null : fetchGiornoConPiuOrdini,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      textStyle: TextStyle(fontSize: 16),
                    ),
                    child: _isLoadingLeft
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text('Carica i giorni'),
                  ),
                  SizedBox(height: 16.0),
                  // Mostra i giorni con il grafico
                  Expanded(
                    child: _isLoadingLeft
                        ? Center(child: CircularProgressIndicator())
                        : _giorni.isNotEmpty
                        ? Container(
                      height: 250, // Imposta l'altezza del grafico
                      child: SfCircularChart(
                        tooltipBehavior: TooltipBehavior(enable: false), // Disabilitiamo il tooltip
                        series: <CircularSeries>[
                          PieSeries<Map<String, dynamic>, String>(
                            dataSource: _giorni,
                            xValueMapper: (Map<String, dynamic> data, _) =>
                            giorniSettimana[int.parse(data['giorno'])],
                            yValueMapper: (Map<String, dynamic> data, _) =>
                            data['ordiniTotali'],
                            dataLabelMapper: (Map<String, dynamic> data, _) =>
                            '${giorniSettimana[int.parse(data['giorno'])]}: ${data['ordiniTotali']} ordini', // Etichetta da visualizzare
                            explode: true,
                            enableTooltip: false, // Disabilitiamo il tooltip
                            dataLabelSettings: DataLabelSettings(
                              isVisible: true, // Le etichette dei dati saranno visibili
                              textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                              alignment: ChartAlignment.center, // Allineamento centrale
                              labelPosition: ChartDataLabelPosition.outside, // Posiziona tutte le etichette fuori
                            ),
                          ),
                        ],
                      ),
                    )
                        : Center(child: Text("Nessun risultato trovato.")),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16.0),
            // Parte destra (1/3)
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    height: 600,
                    child: SingleChildScrollView(
                      child: Text(
                        _secondResponse.isEmpty
                            ? 'Nessun commento del grafico. Premi il bottone sotto per eseguire l\'analisi.'
                            : _secondResponse,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: (_leftQueryCompleted && !_isLoadingRight) ? fetchSecondData : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      textStyle: TextStyle(fontSize: 16),
                    ),
                    child: _isLoadingRight
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text('Analizza i risultati'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

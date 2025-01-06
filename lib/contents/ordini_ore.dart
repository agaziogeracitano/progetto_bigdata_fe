import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';

class OrdiniOre extends StatefulWidget {
  @override
  _OrdiniOreState createState() => _OrdiniOreState();
}

class _OrdiniOreState extends State<OrdiniOre> {
  List<Map<String, dynamic>> ordiniData = []; // Lista dei risultati della prima chiamata
  List<FlSpot> dataPoints = []; // Lista dei punti per il grafico
  bool _isLoadingLeft = false; // Stato di caricamento per la prima chiamata
  bool _isLoadingRight = false; // Stato di caricamento per la seconda chiamata
  bool _leftQueryCompleted = false; // Stato di completamento della prima chiamata
  String secondResponse = ""; // Risultato della seconda chiamata

  // Funzione per la prima chiamata (dati per il grafico)
  Future<void> fetchData() async {
    final url = Uri.parse("http://localhost:6060/ordiniOre");
    setState(() {
      _isLoadingLeft = true;
    });

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);

        // Converte i dati in formato compatibile con il grafico
        List<FlSpot> points = jsonResponse.map((e) {
          final int hour = e["order_hour_of_day"];
          final int count = e["count"];
          return FlSpot(hour.toDouble(), count.toDouble());
        }).toList();

        setState(() {
          // Assicurati che ordiniData sia una lista di Map
          ordiniData = List<Map<String, dynamic>>.from(jsonResponse);
          dataPoints = points;
          _leftQueryCompleted = true; // Prima chiamata completata, abilita il bottone a destra
        });
      } else {
        print("Errore HTTP: ${response.statusCode}");
      }
    } catch (e) {
      print("Errore nella fetch dei dati: $e");
    } finally {
      setState(() {
        _isLoadingLeft = false;
      });
    }
  }

  // Funzione per la seconda chiamata
  Future<void> fetchSecondData() async {
    setState(() {
      _isLoadingRight = true;
    });

    try {
      final url = Uri.parse("http://localhost:6060/chiediAchat");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() {
          secondResponse = response.body; // Salva la risposta della seconda chiamata
        });
      } else {
        print("Errore HTTP: ${response.statusCode}");
      }
    } catch (e) {
      print("Errore nella seconda chiamata: $e");
    } finally {
      setState(() {
        _isLoadingRight = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Grafico Ordini per Ora", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        iconTheme: IconThemeData(
          color: Colors.white, // Colore della freccia di navigazione
        ),
      ),
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                // Parte sinistra (contenente il bottone per la prima chiamata e il grafico)
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ElevatedButton(
                        onPressed: _isLoadingLeft ? null : fetchData, // Disabilita se in caricamento
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          textStyle: TextStyle(fontSize: 16),
                        ),
                        child: _isLoadingLeft
                            ? CircularProgressIndicator(color: Colors.white)
                            : Text('Carica i dati degli ordini'),
                      ),
                      SizedBox(height: 16.0),
                      // Mostra il grafico se i dati sono disponibili
                      Expanded(
                        child: _isLoadingLeft
                            ? Center(child: CircularProgressIndicator())
                            : dataPoints.isNotEmpty
                            ? LineChart(
                          LineChartData(
                            gridData: FlGridData(show: true),
                            titlesData: FlTitlesData(
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false), // Rimuove etichette asse Y
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  interval: 1, // Intervallo delle ore
                                  getTitlesWidget: (value, meta) {
                                    return Text(
                                      value.toInt().toString(), // Ore sull'asse X
                                      style: TextStyle(fontSize: 12),
                                    );
                                  },
                                ),
                              ),
                              topTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              rightTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                            ),
                            borderData: FlBorderData(
                              show: true,
                              border: Border.all(color: Colors.black38),
                            ),
                            lineBarsData: [
                              LineChartBarData(
                                spots: dataPoints,
                                isCurved: true,
                                color: Colors.blue,
                                barWidth: 3,
                                dotData: FlDotData(show: true),
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
                // Parte destra (contenente il rettangolo per il risultato della seconda chiamata e il bottone)
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
                            _isLoadingRight
                                ? "Caricamento..."
                                : secondResponse.isEmpty
                                ? "Nessun commento del grafico. Premi il bottone sotto per eseguire l\'analisi."
                                : secondResponse, // Visualizza la risposta della seconda chiamata
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: (_leftQueryCompleted && !_isLoadingRight) ? fetchSecondData : null, // Disabilita se la prima chiamata non è completata
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
          );
        },
      ),
    );
  }
}

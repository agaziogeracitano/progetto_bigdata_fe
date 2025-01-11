import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';

class ArticoliOrdine extends StatefulWidget {
  @override
  _ArticoliOrdineState createState() => _ArticoliOrdineState();
}

class _ArticoliOrdineState extends State<ArticoliOrdine> {
  List<BarChartGroupData> _barChartData = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse("http://localhost:6060/numeroArticoliOrdine"));

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        List<BarChartGroupData> barChartGroups = [];

        for (var item in jsonData) {
          int numArticoli = item['numero_articoli'];
          int count = item['count'];

          barChartGroups.add(BarChartGroupData(
            x: numArticoli,
            barRods: [
              BarChartRodData(
                toY: count.toDouble(),
                color: Colors.blue,
                width: 6,
              ),
            ],
          ));
        }

        setState(() {
          _barChartData = barChartGroups;
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Errore nel caricamento dei dati')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Numero articoli per ordine', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : Center(
              child: SizedBox(
                height: 300,
                width: double.infinity,
                child: BarChart(
                  BarChartData(
                    gridData: FlGridData(show: false),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: false, // Nascondi i titoli sull'asse y
                        ),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: false, // Nascondi i titoli sopra
                        ),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: false, // Nascondi i titoli sulla destra
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true, // Mostra solo i titoli sotto
                          reservedSize: 20,
                          getTitlesWidget: (value, meta) {
                            if (value % 2 == 0) {
                              return SizedBox.shrink(); // Nasconde i valori pari
                            }
                            return Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Text(
                                value.toInt().toString(),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    borderData: FlBorderData(
                      show: true,
                      border: Border(
                        bottom: BorderSide(color: Colors.black, width: 1),
                        left: BorderSide(color: Colors.transparent),
                        right: BorderSide(color: Colors.transparent),
                        top: BorderSide(color: Colors.transparent),
                      ),
                    ),
                    barGroups: _barChartData,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

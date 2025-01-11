import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:syncfusion_flutter_charts/charts.dart';

class TopNProdotti extends StatefulWidget {
  @override
  _TopNProdottiPageState createState() => _TopNProdottiPageState();
}

class _TopNProdottiPageState extends State<TopNProdotti> {
  final TextEditingController _numController = TextEditingController();
  List<dynamic> _prodotti = [];
  bool _isLoading = false;
  bool _isSecondCallLoading = false;
  String _responseMessage = '';
  String _secondResponse = '';
  bool _isFirstCallMade = false;


  Future<void> _fetchTopNProdotti() async {
    final String baseUrl = 'http://localhost:6060/topNProdotti';
    final String num = _numController.text;

    if (num.isEmpty) {
      _showError('Per favore inserisci un numero valido.');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse('$baseUrl/$num'));
      if (response.statusCode == 200) {
        final List<dynamic> prodotti = json.decode(response.body);
        setState(() {
          _prodotti = prodotti;
          _responseMessage = 'Dati caricati con successo.';
          _isFirstCallMade = true; // Abilita il bottone a destra
        });
      } else {
        _showError('Errore nella richiesta: ${response.statusCode}');
      }
    } catch (e) {
      _showError('Errore durante la connessione al server: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Metodo per la seconda chiamata al backend
  Future<void> _fetchSecondData() async {
    final String baseUrl = 'http://localhost:6060/chiediAchat';

    setState(() {
      _isSecondCallLoading = true;
    });

    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        setState(() {
          _secondResponse = response.body;
        });
      } else {
        setState(() {
          _secondResponse = 'Errore nella richiesta: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _secondResponse = 'Errore durante la connessione al server: $e';
      });
    } finally {
      setState(() {
        _isSecondCallLoading = false;
      });
    }
  }

  void _showError(String message) {
    setState(() {
      _responseMessage = message;
    });
  }


  Widget _buildBarChart() {
    if (_prodotti.isEmpty) return Center(child: Text('Nessun risultato.'));


    List<_ProductData> chartData = _prodotti.map((prodotto) {
      return _ProductData(
        prodotto['product_name'],
        int.parse(prodotto['count'].toString()),
      );
    }).toList();

    return SfCartesianChart(
      primaryXAxis: CategoryAxis(
        title: AxisTitle(text: ''),
        labelStyle: TextStyle(fontSize: 0),
      ),
      primaryYAxis: NumericAxis(isVisible: false),
      tooltipBehavior: TooltipBehavior(
        enable: true,
        format: 'point.x : point.y',
      ),
      series: <ChartSeries<_ProductData, String>>[
        ColumnSeries<_ProductData, String>(
          dataSource: chartData,
          xValueMapper: (_ProductData data, _) => data.name,
          yValueMapper: (_ProductData data, _) => data.count,
          color: Colors.blue,
          dataLabelSettings: DataLabelSettings(isVisible: false),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top N Prodotti', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
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
                  // Input per il numero di prodotti
                  TextField(
                    controller: _numController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Numero di prodotti',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  // Bottone per avviare la query
                  ElevatedButton(
                    onPressed: _isLoading ? null : _fetchTopNProdotti,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      textStyle: TextStyle(fontSize: 16),
                    ),
                    child: _isLoading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text('Cerca'),
                  ),
                  SizedBox(height: 16.0),
                  // Visualizzazione del grafico
                  Expanded(
                    child: _isLoading
                        ? Center(child: CircularProgressIndicator())
                        : _buildBarChart(),
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
                  // Rettangolo per visualizzare la risposta
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
                  // Bottone per fare la seconda chiamata centrato sotto il rettangolo
                  Center(
                    child: ElevatedButton(
                      onPressed: _isFirstCallMade && !_isSecondCallLoading ? _fetchSecondData : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        textStyle: TextStyle(fontSize: 16),
                      ),
                      child: _isSecondCallLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text('Analizza i risultati'),
                    ),
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

// Classe per rappresentare i dati del grafico
class _ProductData {
  final String name;
  final int count;

  _ProductData(this.name, this.count);
}
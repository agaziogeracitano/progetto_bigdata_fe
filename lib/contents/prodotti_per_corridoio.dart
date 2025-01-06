import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProdottiPerCorridoio extends StatefulWidget {
  @override
  _ProdottiPerCorridoioState createState() => _ProdottiPerCorridoioState();
}

class _ProdottiPerCorridoioState extends State<ProdottiPerCorridoio> {
  List<dynamic> _prodotti = [];
  bool _isLoadingLeft = false;
  bool _isLoadingRight = false;
  bool _leftQueryCompleted = false; // Controllo per abilitare il bottone a destra
  String _secondResponse = '';

  // Funzione per chiamare l'API e ottenere i dati (sinistra)
  Future<void> fetchProdottiPerCorridoio() async {
    setState(() {
      _isLoadingLeft = true;
      _leftQueryCompleted = false; // Disabilita il bottone a destra finché la chiamata non termina
    });

    final response = await http.get(Uri.parse('http://localhost:6060/topProdottiPerAisle'));

    if (response.statusCode == 200) {
      setState(() {
        _prodotti = json.decode(response.body);
        _isLoadingLeft = false;
        _leftQueryCompleted = true; // Abilita il bottone a destra
      });
    } else {
      setState(() {
        _isLoadingLeft = false;
        _leftQueryCompleted = false;
      });
    }
  }

  // Funzione per la seconda chiamata (destra)
  Future<void> fetchSecondData() async {
    setState(() {
      _isLoadingRight = true;
    });

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Prodotti più venduti per corridoio",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        iconTheme: IconThemeData(
          color: Colors.white, // Colore della freccia di navigazione
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
                  ElevatedButton(
                    onPressed: _isLoadingLeft ? null : fetchProdottiPerCorridoio,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      textStyle: TextStyle(fontSize: 16),
                    ),
                    child: _isLoadingLeft
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text('Cerca'),
                  ),
                  SizedBox(height: 16.0),
                  Expanded(
                    child: _isLoadingLeft
                        ? Center(child: CircularProgressIndicator())
                        : ListView.builder(
                      itemCount: _prodotti.length,
                      itemBuilder: (context, index) {
                        final prodotto = _prodotti[index];
                        return ListTile(
                          leading: Icon(Icons.shopping_cart),
                          title: Text("Corridoio: ${prodotto['aisle_id']}"),
                          subtitle: Text(
                            "Prodotto: ${prodotto['product_name']} \nVendite: ${prodotto['vendite']}",
                          ),
                          isThreeLine: true,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16.0),
            // Parte destra (1/3)
            Expanded(
              flex: 1,
              child: Column(
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

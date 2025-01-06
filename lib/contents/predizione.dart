import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Predizione extends StatefulWidget {
  @override
  _PredizioneState createState() => _PredizioneState();
}

class _PredizioneState extends State<Predizione> {
  final TextEditingController _controller = TextEditingController();
  List<String> _products = [
    'Organic Cucumber',
    'Organic Hass Avocado',
    'Organic Strawberries',
    'Limes',
    'Banana',
    'Organic Avocado'
  ];
  Map<String, bool> _selectedProducts = {};

  List<dynamic> _suggestions = [];

  Future<void> fetchPredizione(String dati) async {
    final response = await http.get(Uri.parse('http://localhost:6060/predizione?dati=$dati'));

    if (response.statusCode == 200) {
      setState(() {
        _suggestions = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load predizione');
    }
  }

  void _updateTextField() {
    List<String> selectedItems = [];
    _selectedProducts.forEach((product, isSelected) {
      if (isSelected) {
        selectedItems.add(product);
      }
    });

    String combinedText = selectedItems.join(', ');
    _controller.text = combinedText;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Predizioni', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        iconTheme: IconThemeData(
          color: Colors.white, // Colore della freccia di navigazione
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Casella di testo per l'inserimento dei dati
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Inserisci i prodotti (separati da virgola)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),

            // Lista dei prodotti toggle
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: _products.map((product) {
                return FilterChip(
                  label: Text(product),
                  selected: _selectedProducts[product] ?? false,
                  onSelected: (bool selected) {
                    setState(() {
                      _selectedProducts[product] = selected;
                      _updateTextField();
                    });
                  },
                  backgroundColor: Colors.lightBlue.shade100, // Colore di sfondo azzurro chiaro
                  selectedColor: Colors.blue.shade300, // Colore selezionato (azzurro più scuro)
                  labelStyle: TextStyle(
                    color: _selectedProducts[product] ?? false
                        ? Colors.white
                        : Colors.black, // Colore del testo
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 20),

            // Bottone per inviare la richiesta
            ElevatedButton(
              onPressed: () {
                String dati = _controller.text.trim();
                if (dati.isNotEmpty) {
                  fetchPredizione(dati);
                }
              },
              child: Text('Ottieni Predizione', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Correzione qui
              ),
            ),
            SizedBox(height: 20),

            // Lista dei suggerimenti ricevuti dalla risposta
            Expanded(
              child: _suggestions.isEmpty
                  ? Center(child: Text('Nessun suggerimento disponibile.'))
                  : ListView.builder(
                itemCount: _suggestions.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.blue.shade50,
                    margin: EdgeInsets.all(8),
                    child: ListTile(
                      title: Text(_suggestions[index]['suggestion']),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PosizioneFrequenteProdotto extends StatefulWidget {
  @override
  _PosizioneFrequenteProdottoState createState() =>
      _PosizioneFrequenteProdottoState();
}

class _PosizioneFrequenteProdottoState
    extends State<PosizioneFrequenteProdotto> {
  final TextEditingController _controller = TextEditingController();
  Map<String, dynamic>? _posizione; // Per salvare i dati
  bool _isLoading = false; // Per gestire il caricamento

  // Funzione per chiamare l'API con il productId
  Future<void> fetchPosizioneFrequente(int productId) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.get(
          Uri.parse('http://localhost:6969/posizioneFrequenteProdottoNelCarrello/$productId'));

      if (response.statusCode == 200) {
        setState(() {
          _posizione = json.decode(response.body);
        });
      } else {
        throw Exception('Errore nel caricamento dei dati');
      }
    } catch (error) {
      print("Errore: $error");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Errore nel recupero dei dati."),
        backgroundColor: Colors.red,
      ));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Posizione Frequente del Prodotto", style: TextStyle(color: Colors.white)),
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
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Inserisci l'ID del Prodotto",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Colore di sfondo
                foregroundColor: Colors.white, // Colore del testo
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                textStyle: TextStyle(fontSize: 16),
              ),
              onPressed: () {
                final productId = int.tryParse(_controller.text);
                if (productId != null) {
                  fetchPosizioneFrequente(productId);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Per favore inserisci un ID valido."),
                    backgroundColor: Colors.red,
                  ));
                }
              },
              child: Text("Cerca"),
            ),
            SizedBox(height: 24),
            _isLoading
                ? CircularProgressIndicator() // Mostra un loader durante il caricamento
                : _posizione != null
                ? Card(
              elevation: 4,
              child: ListTile(
                leading: Icon(Icons.shopping_cart, color: Colors.blue),
                title: Text(
                    "Posizione frequente: ${_posizione!['add_to_cart_order']}"),
                subtitle:
                Text("Occorrenze: ${_posizione!['count']}"),
              ),
            )
                : Text("Nessun risultato trovato."),
          ],
        ),
      ),
    );
  }
}

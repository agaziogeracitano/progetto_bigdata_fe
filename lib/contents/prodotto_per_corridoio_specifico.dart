import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProdottoPerCorridoioSpecifico extends StatefulWidget {
  @override
  _ProdottoPerCorridoioSpecificoState createState() =>
      _ProdottoPerCorridoioSpecificoState();
}

class _ProdottoPerCorridoioSpecificoState
    extends State<ProdottoPerCorridoioSpecifico> {
  TextEditingController _aisleIdController = TextEditingController(); // Per inserire l'aisleId
  Map<String, dynamic>? _prodotto; // Per salvare il risultato
  bool _isLoading = false; // Per gestire il caricamento

  // Funzione per chiamare l'API
  Future<void> fetchProdottoPerCorridoioSpecifico(int aisleId) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.get(
        Uri.parse(
            'http://localhost:6969/prodottoPiuVendutoPerAisleSpecifico/$aisleId'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseBody = json.decode(response.body);
        if (responseBody.isNotEmpty) {
          setState(() {
            _prodotto = responseBody[0]; // Ottieni il primo prodotto dall'array
          });
        } else {
          setState(() {
            _prodotto = null; // Nessun prodotto trovato
          });
        }
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
        title: Text("Prodotto più venduto per corridoio", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        iconTheme: IconThemeData(
          color: Colors.white, // Colore della freccia di navigazione
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Input per inserire l'aisleId
            TextField(
              controller: _aisleIdController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Inserisci l'ID del corridoio",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            // Bottone per effettuare la chiamata API
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Colore di sfondo
                foregroundColor: Colors.white, // Colore del testo
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                textStyle: TextStyle(fontSize: 16),
              ),
              onPressed: () {
                final aisleId = int.tryParse(_aisleIdController.text);
                if (aisleId != null) {
                  fetchProdottoPerCorridoioSpecifico(aisleId);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Inserisci un ID valido."),
                    backgroundColor: Colors.orange,
                  ));
                }
              },
              child: Text("Cerca prodotto"),
            ),
            SizedBox(height: 16),
            // Mostra il risultato o un indicatore di caricamento
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : _prodotto != null
                ? Card(
              color: Colors.blue.shade50,
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),
                    Text("Product Name: ${_prodotto!['product_name']}"),
                    Text("Aisle ID: ${_prodotto!['aisle_id']}"),
                    Text("Vendite: ${_prodotto!['vendite']}"),
                    SizedBox(height: 8),
                  ],
                ),
              ),
            )
                : Text("Nessun risultato trovato."),
          ],
        ),
      ),
    );
  }
}

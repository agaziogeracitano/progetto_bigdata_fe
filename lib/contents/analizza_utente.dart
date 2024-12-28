import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart'; // Per usare i formati di input

class AnalizzaUtente extends StatefulWidget {
  @override
  _AnalizzaUtenteState createState() => _AnalizzaUtenteState();
}

class _AnalizzaUtenteState extends State<AnalizzaUtente> {
  final TextEditingController _controller = TextEditingController();
  List<dynamic> _prodottiAcquistati = [];
  bool _isLoadingLeft = false;
  bool _isLoadingRight = false;
  bool _isLeftButtonPressed = false; // Stato per sapere se il bottone sinistro è stato premuto
  bool _isLeftButtonCompleted = false; // Stato per sapere se i dati sono stati stampati a sinistra
  String _dettagliSecondari = ''; // Dettagli secondari per la zona destra

  // Funzione per chiamare l'API e ottenere i dati
  Future<void> fetchAcquistiUtente(String utenteId) async {
    setState(() {
      _isLoadingLeft = true;
      _isLeftButtonPressed = true; // Impostiamo che il bottone sinistro è stato premuto
      _isLeftButtonCompleted = false; // Dati non ancora stampati
    });

    try {
      final response = await http.get(Uri.parse('http://localhost:6969/analizzaUtente/$utenteId'));

      if (response.statusCode == 200) {
        setState(() {
          _prodottiAcquistati = json.decode(response.body);
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
        _isLeftButtonCompleted = true; // Dati stampati a sinistra
      });
    }
  }

  // Funzione per la chiamata a destra (aggiuntiva)
  Future<void> fetchDettagliSecondari() async {
    setState(() {
      _isLoadingRight = true;
    });

    try {
      // Simula una chiamata al backend per ottenere i dettagli secondari
      final response = await http.get(Uri.parse('http://localhost:6969/chiediAchat'));

      if (response.statusCode == 200) {
        setState(() {
          _dettagliSecondari = response.body;
        });
      } else {
        setState(() {
          _dettagliSecondari = 'Errore nella richiesta: ${response.statusCode}';
        });
      }
    } catch (error) {
      setState(() {
        _dettagliSecondari = 'Errore nella richiesta: $error';
      });
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
        title: Text('Analizza Acquisti Utente', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Parte sinistra (2/3 dello schermo)
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Casella di testo per l'inserimento dell'ID utente (solo numeri)
                  TextField(
                    controller: _controller,
                    keyboardType: TextInputType.number, // Mostra la tastiera numerica
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly, // Consente solo numeri
                    ],
                    decoration: InputDecoration(
                      labelText: 'Inserisci ID Utente',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Bottone per inviare la richiesta
                  ElevatedButton(
                    onPressed: _isLoadingLeft
                        ? null
                        : () {
                      String userId = _controller.text.trim();
                      if (userId.isNotEmpty) {
                        fetchAcquistiUtente(userId);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Colore del bottone
                      foregroundColor: Colors.white,
                    ),
                    child: _isLoadingLeft
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text('Analizza Acquisti', style: TextStyle(color: Colors.white)),
                  ),
                  SizedBox(height: 20),

                  // Mostra i prodotti acquistati
                  Expanded(
                    child: _isLoadingLeft
                        ? Center(child: CircularProgressIndicator())
                        : _prodottiAcquistati.isEmpty
                        ? Center(child: Text('Nessun acquisto disponibile per questo utente.'))
                        : ListView.builder(
                      itemCount: _prodottiAcquistati.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Colors.blue.shade50,
                          margin: EdgeInsets.all(8),
                          child: ListTile(
                            title: Text(
                              _prodottiAcquistati[index]['product_name'] ?? 'Prodotto sconosciuto',
                            ),
                            subtitle: Text('Numero acquisti: ${_prodottiAcquistati[index]['numero_acquisti']}'),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16.0),

            // Parte destra (1/3 dello schermo)
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
                        _dettagliSecondari.isEmpty
                            ? 'Nessun dettaglio disponibile. Premi il bottone per eseguire un\'analisi aggiuntiva.'
                            : _dettagliSecondari,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: !_isLeftButtonCompleted || _isLoadingRight
                        ? null // Il bottone è disabilitato finché non sono stati stampati i dati a sinistra
                        : fetchDettagliSecondari,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    child: _isLoadingRight
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text('Analizza Dettagli', style: TextStyle(color: Colors.white)),
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

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegoleAssociative extends StatelessWidget {
  Future<List<dynamic>> fetchRegoleAssociative() async {
    final response = await http.get(Uri.parse('http://localhost:6969/regoleAssociative'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load regole associative');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Regole Associative', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        iconTheme: IconThemeData(
          color: Colors.white, // Colore della freccia di navigazione
        ),
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder<List<dynamic>>(
        future: fetchRegoleAssociative(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Errore: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nessuna regola trovata.'));
          }

          final regole = snapshot.data!;
          return ListView.builder(
            itemCount: regole.length,
            itemBuilder: (context, index) {
              final regola = regole[index];
              return Card(
                color: Colors.blue.shade50,
                margin: EdgeInsets.all(8),
                child: ListTile(
                  title: Text('${regola['antecedent']} -> ${regola['consequent']}'),
                  subtitle: Text('Confidenza: ${regola['confidence']}\nSupporto: ${regola['support']}\nlift: ${regola['lift']}'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

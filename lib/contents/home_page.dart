import 'package:flutter/material.dart';
import 'package:progetto_bigdata_fe/contents/ordini_ore.dart';
import 'package:progetto_bigdata_fe/contents/regole_associative.dart';
import 'package:progetto_bigdata_fe/contents/top_n_prodotti.dart';
import 'package:progetto_bigdata_fe/contents/prodotti_per_corridoio.dart';
import 'package:progetto_bigdata_fe/contents/prodotto_per_corridoio_specifico.dart';
import 'package:progetto_bigdata_fe/contents/giorno_con_piu_ordini.dart';
import 'package:progetto_bigdata_fe/contents/posizione_frequente_prodotto.dart';
import 'package:fl_chart/fl_chart.dart';

class HomePage extends StatelessWidget {
  final List<Map<String, dynamic>> barData = [
    {"order_hour_of_day": 0, "count": 22758},
    {"order_hour_of_day": 1, "count": 12398},
    {"order_hour_of_day": 2, "count": 7539},
    {"order_hour_of_day": 3, "count": 5474},
    {"order_hour_of_day": 4, "count": 5527},
    {"order_hour_of_day": 5, "count": 9569},
    {"order_hour_of_day": 6, "count": 30529},
    {"order_hour_of_day": 7, "count": 91868},
    {"order_hour_of_day": 8, "count": 178201},
    {"order_hour_of_day": 9, "count": 257812},
    {"order_hour_of_day": 10, "count": 288418},
    {"order_hour_of_day": 11, "count": 284728},
    {"order_hour_of_day": 12, "count": 272841},
    {"order_hour_of_day": 13, "count": 277999},
    {"order_hour_of_day": 14, "count": 283042},
    {"order_hour_of_day": 15, "count": 283639},
    {"order_hour_of_day": 16, "count": 272553},
    {"order_hour_of_day": 17, "count": 228795},
    {"order_hour_of_day": 18, "count": 182912},
    {"order_hour_of_day": 19, "count": 140569},
    {"order_hour_of_day": 20, "count": 104292},
    {"order_hour_of_day": 21, "count": 78109},
    {"order_hour_of_day": 22, "count": 61468},
    {"order_hour_of_day": 23, "count": 40043}
  ];

  final List<Map<String, dynamic>> pieData = [
    {"order_dow": 0, "ordiniTotali": 600905},
    {"order_dow": 1, "ordiniTotali": 587478},
    {"order_dow": 2, "ordiniTotali": 467260},
    {"order_dow": 5, "ordiniTotali": 453368},
    {"order_dow": 6, "ordiniTotali": 448761},
    {"order_dow": 3, "ordiniTotali": 436972},
    {"order_dow": 4, "ordiniTotali": 426339}
  ];

  final List<Map<String, dynamic>> barDataTop = [
    {"product_name": "Banana", "count": 491291},
    {"product_name": "Bag of Organic Bananas", "count": 394930},
    {"product_name": "Organic Strawberries", "count": 275577},
    {"product_name": "Organic Baby Spinach", "count": 251705},
    {"product_name": "Organic Hass Avocado", "count": 220877},
    {"product_name": "Organic Avocado", "count": 184224},
    {"product_name": "Large Lemon", "count": 160792},
    {"product_name": "Strawberries", "count": 149445},
    {"product_name": "Limes", "count": 146660},
    {"product_name": "Organic Whole Milk", "count": 142813}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Progetto BigData',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        backgroundColor: Colors.blue,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 24)),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ListTile(
                title: Text('Top N Prodotti', style: TextStyle(color: Colors.black)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TopNProdotti()),
                  );
                },
              ),
              ListTile(
                title: Text('Prodotti per Corridoio', style: TextStyle(color: Colors.black)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProdottiPerCorridoio()),
                  );
                },
              ),
              ListTile(
                title: Text('Prodotto per Corridoio Specifico', style: TextStyle(color: Colors.black)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProdottoPerCorridoioSpecifico()),
                  );
                },
              ),
              ListTile(
                title: Text('Giorno con più Ordini', style: TextStyle(color: Colors.black)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GiornoConPiuOrdini()),
                  );
                },
              ),
              ListTile(
                title: Text('Posizione Frequente del Prodotto', style: TextStyle(color: Colors.black)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PosizioneFrequenteProdotto()),
                  );
                },
              ),
              ListTile(
                title: Text('Vendita per ore', style: TextStyle(color: Colors.black)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OrdiniOre()),
                  );
                },
              ),
              ListTile(
                title: Text('Regole Associative', style: TextStyle(color: Colors.black)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegoleAssociative()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => OrdiniOre()),
                        );
                      },
                      child: Card(
                        color: Colors.blue[50],
                        margin: EdgeInsets.all(8),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: LineChart(
                            LineChartData(
                              gridData: FlGridData(show: true),  // Mostra la griglia
                              titlesData: FlTitlesData(
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),  // Disabilita le etichette dell'asse Y
                                ),
                                topTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),  // Disabilita le etichette della parte superiore
                                ),
                                rightTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),  // Disabilita le etichette della parte destra
                                ),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,  // Mostra le etichette solo sull'asse X
                                    getTitlesWidget: (double value, TitleMeta meta) {
                                      return Text(
                                        value.toInt().toString(),
                                        style: TextStyle(fontSize: 10),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              borderData: FlBorderData(show: true),
                              lineBarsData: [
                                LineChartBarData(
                                  spots: barData.map((entry) {
                                    return FlSpot(entry['order_hour_of_day'].toDouble(), entry['count'].toDouble());
                                  }).toList(),
                                  isCurved: true,  // Rendi la linea curva
                                  color: Colors.red,  // Colore della linea
                                  dotData: FlDotData(show: false),  // Disabilita i punti sulla linea
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TopNProdotti()), // Pagina di destinazione
                        );
                      },
                      child: Card(
                        color: Colors.blue[900], // Sfondo blu scuro per il Card
                        margin: EdgeInsets.all(8),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: BarChart(
                            BarChartData(
                              alignment: BarChartAlignment.spaceAround,
                              titlesData: FlTitlesData(
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: (double value, TitleMeta meta) {
                                      // Etichette dell'asse X in bianco
                                      return Container(
                                        width: 50, // Imposta la larghezza per evitare sovrapposizioni
                                        child: Tooltip(
                                          message: barDataTop[value.toInt()]['product_name'], // Nome del prodotto come tooltip
                                          child: Text(
                                            barDataTop[value.toInt()]['product_name'], // Nome del prodotto
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.white, // Colore bianco per le etichette
                                              fontWeight: FontWeight.bold, // Grassetto per il testo
                                            ),
                                            textAlign: TextAlign.center, // Centra il testo
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              borderData: FlBorderData(show: true),
                              barGroups: barDataTop.map((entry) {
                                return BarChartGroupData(
                                  x: barDataTop.indexOf(entry), // Indice del prodotto
                                  barRods: [
                                    BarChartRodData(
                                      toY: entry['count'].toDouble(),
                                      color: Colors.blue[300], // Colore delle barre
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),


                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => GiornoConPiuOrdini()),
                        );
                      },
                      child: Card(
                        color: Colors.blue[900],  // Imposta lo sfondo del riquadro a blu scuro
                        margin: EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Center(
                              child: Text(
                                'Giorno con più Ordini',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),  // Testo in bianco
                              ),
                            ),
                            Expanded(
                              child: PieChart(
                                PieChartData(
                                  sectionsSpace: 0,
                                  centerSpaceRadius: 70,  // Aumenta la dimensione centrale per renderlo più grande
                                  sections: pieData.map((data) {
                                    String dayLabel;
                                    switch (data['order_dow']) {
                                      case 0:
                                        dayLabel = 'Domenica';
                                        break;
                                      case 1:
                                        dayLabel = 'Lunedì';
                                        break;
                                      case 2:
                                        dayLabel = 'Martedì';
                                        break;
                                      case 3:
                                        dayLabel = 'Mercoledì';
                                        break;
                                      case 4:
                                        dayLabel = 'Giovedì';
                                        break;
                                      case 5:
                                        dayLabel = 'Venerdì';
                                        break;
                                      case 6:
                                        dayLabel = 'Sabato';
                                        break;
                                      default:
                                        dayLabel = '';
                                        break;
                                    }
                                    return PieChartSectionData(
                                      value: data['ordiniTotali'].toDouble(),
                                      title: dayLabel,  // Etichetta per il giorno della settimana
                                      radius: 70,  // Dimensione del raggio della torta
                                      color: Colors.blue[(data['order_dow'] % 7) * 100],
                                      titleStyle: TextStyle(
                                        fontSize: 14,  // Imposta la dimensione del testo per l'etichetta
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,  // Imposta il colore del testo a bianco per contrastare con lo sfondo blu scuro
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ProdottiPerCorridoio()),
                        );
                      },
                      child: Card(
                        color: Colors.red[50],
                        margin: EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Center(
                              child: Text(
                                'Prodotti più venduti per ogni corridoio',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Table(
                                  border: TableBorder.all(
                                    color: Colors.blueAccent,
                                    width: 1,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  children: [
                                    TableRow(
                                      decoration: BoxDecoration(
                                        color: Colors.blue[100], // Colore intestazione
                                      ),
                                      children: [
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Corridoio',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Prodotto',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Vendite',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    // Assicurati che i dati siano una lista di mappe correttamente formattata
                                    for (var product in [
                                      {"aisle_id": "1", "product_name": "Tuna Salad", "vendite": 6252},
                                      {"aisle_id": "10", "product_name": "Primordial Himalayan Sea Salt", "vendite": 987},
                                      {"aisle_id": "100", "product_name": "Organic Riced Cauliflower", "vendite": 9189},
                                      {"aisle_id": "101", "product_name": "Original Scent Extra Strength Fabric Refresher Spray", "vendite": 617},
                                      {"aisle_id": "102", "product_name": "Unscented Pure Castile Soap", "vendite": 541},
                                      {"aisle_id": "103", "product_name": "Genuine Chocolate Flavor Syrup", "vendite": 2252},
                                      {"aisle_id": "104", "product_name": "Garlic Powder", "vendite": 6569},
                                      {"aisle_id": "105", "product_name": "Cinnamon Rolls with Icing", "vendite": 12561},
                                      {"aisle_id": "106", "product_name": "Uncured Hickory Smoked Sunday Bacon", "vendite": 21610},
                                      {"aisle_id": "107", "product_name": "Lightly Salted Baked Snap Pea Crisps", "vendite": 25941},
                                      {"aisle_id": "108", "product_name": "Whipped Cream Cheese", "vendite": 32270},
                                      {"aisle_id": "109", "product_name": "Sensitive Facial Cleansing Towelettes", "vendite": 778},
                                      {"aisle_id": "11", "product_name": "The Original Natural Herb Drops Cough Suppressant", "vendite": 1298}
                                    ])
                                      TableRow(
                                        children: [
                                          TableCell(
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(
                                                (product['aisle_id'] ?? 'N/A').toString(), // Cast a String
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(
                                                (product['product_name'] ?? 'N/A').toString(), // Cast a String
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(
                                                (product['vendite'] ?? 0).toString(), // Cast a String
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )


                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

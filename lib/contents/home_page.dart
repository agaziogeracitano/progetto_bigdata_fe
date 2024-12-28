import 'package:flutter/material.dart';
import 'package:progetto_bigdata_fe/contents/analizza_utente.dart';
import 'package:progetto_bigdata_fe/contents/ordini_ore.dart';
import 'package:progetto_bigdata_fe/contents/predizione.dart';
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
  final List<Map<String, dynamic>> ordiniCorridoio =  [{"aisle_id":" Blunted","product_name":"\"Scotch Kids 5\"\" Scissors","vendite":3},
    {"aisle_id":"1","product_name":"Tuna Salad","vendite":6252},{"aisle_id":"10","product_name":"Primordial Himalayan Sea Salt","vendite":987},{"aisle_id":"100","product_name":"Organic Riced Cauliflower","vendite":9189},{"aisle_id":"101","product_name":"Original Scent Extra Strength Fabric Refresher Spray","vendite":617},{"aisle_id":"102","product_name":"Unscented Pure Castile Soap","vendite":541},{"aisle_id":"103","product_name":"Genuine Chocolate Flavor Syrup","vendite":2252},{"aisle_id":"104","product_name":"Garlic Powder","vendite":6569},{"aisle_id":"105","product_name":"Cinnamon Rolls with Icing","vendite":12561},{"aisle_id":"106","product_name":"Uncured Hickory Smoked Sunday Bacon","vendite":21610},{"aisle_id":"107","product_name":"Lightly Salted Baked Snap Pea Crisps","vendite":25941},{"aisle_id":"108","product_name":"Whipped Cream Cheese","vendite":32270},{"aisle_id":"109","product_name":"Sensitive Facial Cleansing Towelettes","vendite":778},{"aisle_id":"11","product_name":"The Original Natural Herb Drops Cough Suppressant","vendite":1298},{"aisle_id":"110","product_name":"Sliced Black Olives","vendite":11225},{"aisle_id":"111","product_name":"9 Inch Plates","vendite":3213},{"aisle_id":"112","product_name":"100% Whole Wheat Bread","vendite":63114},{"aisle_id":"113","product_name":"Orange Juice with Calcium","vendite":697},{"aisle_id":"114","product_name":"Lemongrass Citrus Scent Disinfecting Wipes","vendite":4182},{"aisle_id":"115","product_name":"Sparkling Water Grapefruit","vendite":79245},{"aisle_id":"116","product_name":"Blueberries","vendite":58269},{"aisle_id":"117","product_name":"Organic Whole Cashews","vendite":13292},{"aisle_id":"118","product_name":"Hydrogen Peroxide","vendite":1104},{"aisle_id":"119","product_name":"Dark Chocolate Covered Banana","vendite":4243},{"aisle_id":"12","product_name":"Freshly Made. Filled with Creamy Ricotta, Aged Parmesan and Romano Cheeses Three Cheese Tortellini","vendite":3092},{"aisle_id":"120","product_name":"Total 2% with Strawberry Lowfat Greek Strained Yogurt","vendite":30866},{"aisle_id":"121","product_name":"Honey Nut Cheerios","vendite":27959},{"aisle_id":"122","product_name":"85% Lean Ground Beef","vendite":12765},{"aisle_id":"123","product_name":"Organic Baby Spinach","vendite":251705},{"aisle_id":"124","product_name":"Vodka","vendite":5666},{"aisle_id":"125","product_name":"Trail Mix","vendite":12601},{"aisle_id":"126","product_name":"Curved Panty Liners","vendite":558},{"aisle_id":"127","product_name":"Deep Moisture Body Wash","vendite":1584},{"aisle_id":"128","product_name":"Corn Tortillas","vendite":15514},{"aisle_id":"129","product_name":"Naturals Chicken Nuggets","vendite":10915},{"aisle_id":"13","product_name":"Original Rotisserie Chicken","vendite":7667},{"aisle_id":"130","product_name":"Organic Old Fashioned Rolled Oats","vendite":20887},{"aisle_id":"131","product_name":"Spaghetti","vendite":16453},{"aisle_id":"132","product_name":"Organic Cotton Balls","vendite":1144},{"aisle_id":"133","product_name":"Premium Epsom Salt","vendite":4377},{"aisle_id":"134","product_name":"Prosecco Sparkling Wine","vendite":1850},{"aisle_id":"14","product_name":"Organic Extra Firm Tofu","vendite":30310},{"aisle_id":"15","product_name":"Smoked Salmon","vendite":4201},{"aisle_id":"16","product_name":"Organic Cilantro","vendite":73050},{"aisle_id":"17","product_name":"Light Brown Sugar","vendite":13853},{"aisle_id":"18","product_name":"Dried Mango","vendite":10596},{"aisle_id":"19","product_name":"Extra Virgin Olive Oil","vendite":52323},{"aisle_id":"2","product_name":"Fresh Mozzarella Ball","vendite":10551},{"aisle_id":"20","product_name":"Fluoride-Free Antiplaque & Whitening Peppermint Toothpaste","vendite":3602},{"aisle_id":"21","product_name":"Organic Whole String Cheese","vendite":61669},{"aisle_id":"22","product_name":"Moroccan Argan Oil + Argan Stem Cell Triple Moisture Conditioner","vendite":930},{"aisle_id":"23","product_name":"Baked Aged White Cheddar Rice and Corn Puffs","vendite":14237},{"aisle_id":"24","product_name":"Banana","vendite":491291},{"aisle_id":"25","product_name":"Lavender Hand Soap","vendite":6199},{"aisle_id":"26","product_name":"Cold Brew Coffee","vendite":9243},{"aisle_id":"27","product_name":"Beer","vendite":6068},{"aisle_id":"28","product_name":"Cabernet Sauvignon","vendite":6352},{"aisle_id":"29","product_name":"Organic Mountain Forest Amber Honey","vendite":7625},{"aisle_id":"3","product_name":"Kids Organic Chocolate Chip ZBars","vendite":12249},{"aisle_id":"30","product_name":"Taco Seasoning","vendite":9397},{"aisle_id":"31","product_name":"100% Raw Coconut Water","vendite":39271},{"aisle_id":"32","product_name":"Raspberries","vendite":60919},{"aisle_id":"33","product_name":"Lightly Breaded Fish Sticks","vendite":1432},{"aisle_id":"34","product_name":"Organic Chicken Strips","vendite":11561},{"aisle_id":"35","product_name":"Ground Turkey Breast","vendite":27679},{"aisle_id":"36","product_name":"Unsalted Butter","vendite":37102},{"aisle_id":"37","product_name":"Chocolate Ice Cream","vendite":13908},{"aisle_id":"38","product_name":"Macaroni & Cheese","vendite":18132},{"aisle_id":"39","product_name":"Tilapia Filet","vendite":15250},{"aisle_id":"4","product_name":"Organic Macaroni Shells & Real Aged Cheddar","vendite":11316},{"aisle_id":"40","product_name":"Small Dog Biscuits","vendite":688},{"aisle_id":"41","product_name":"Grain Free Chicken Formula Cat Food","vendite":1893},{"aisle_id":"42","product_name":"Seven Grain Crispy Tenders","vendite":7423},{"aisle_id":"43","product_name":"Authentic French Brioche Hamburger Buns","vendite":10759},{"aisle_id":"44","product_name":"Cotton Swabs","vendite":4455},{"aisle_id":"45","product_name":"Almonds & Sea Salt in Dark Chocolate","vendite":13366},{"aisle_id":"46","product_name":"Wint-O-Green","vendite":1620},{"aisle_id":"47","product_name":"Vitamin C Super Orange Dietary Supplement","vendite":3118},{"aisle_id":"48","product_name":"Nutri Grain Bars Multi Pack","vendite":3700},{"aisle_id":"49","product_name":"Boneless Skinless Chicken Breasts","vendite":52369},{"aisle_id":"5","product_name":"Panko Bread Crumbs","vendite":9372},{"aisle_id":"50","product_name":"Original Veggie Straws","vendite":17534},{"aisle_id":"51","product_name":"Organic Medium Salsa","vendite":15401},{"aisle_id":"52","product_name":"Chicken & Maple Breakfast Sausage","vendite":19172},{"aisle_id":"53","product_name":"Organic Half & Half","vendite":79006},{"aisle_id":"54","product_name":"100% Recycled Paper Towels","vendite":29047},{"aisle_id":"55","product_name":"SkinTherapy Moisturizing Shave Gel","vendite":419},{"aisle_id":"56","product_name":"Honest Face, Hand, & Baby Wipes","vendite":2985},{"aisle_id":"57","product_name":"Ancient Grain Original Granola","vendite":6760},{"aisle_id":"58","product_name":"Gluten Free Whole Grain Bread","vendite":14207},{"aisle_id":"59","product_name":"Organic Black Beans","vendite":39577},{"aisle_id":"6","product_name":"Roasted Almond Butter","vendite":4150},{"aisle_id":"60","product_name":"Tall Kitchen Drawstring Bags","vendite":4684},{"aisle_id":"61","product_name":"Chocolate Chip Cookies","vendite":14762},{"aisle_id":"62","product_name":"Sauvignon Blanc","vendite":8541},{"aisle_id":"63","product_name":"Organic Long Grain White Rice","vendite":8957},{"aisle_id":"64","product_name":"Energy Drink","vendite":6695},{"aisle_id":"65","product_name":"Vanilla Whey Protein Powder","vendite":2447},{"aisle_id":"66","product_name":"Organic Sea Salt Roasted Seaweed Snacks","vendite":10690},{"aisle_id":"67","product_name":"Original Hummus","vendite":74172},{"aisle_id":"68","product_name":"Organic Rolled Oats","vendite":6639},{"aisle_id":"69","product_name":"Organic Low Sodium Chicken Broth","vendite":18252},{"aisle_id":"7","product_name":"Organic Chicken Thighs","vendite":8204},{"aisle_id":"70","product_name":"Organic Lowfat Mango Kefir","vendite":1764},{"aisle_id":"71","product_name":"Organic Chocolate Almondmilk Pudding","vendite":3642},{"aisle_id":"72","product_name":"Organic Ketchup","vendite":15914},{"aisle_id":"73","product_name":"Makeup Remover Cleansing Towelettes","vendite":1286},{"aisle_id":"74","product_name":"Natural Free & Clear Dish Liquid","vendite":9452},{"aisle_id":"75","product_name":"Free & Clear Natural Laundry Detergent For Sensitive Skin","vendite":5108},{"aisle_id":"76","product_name":"Tikka Masala Mild Indian Simmer Sauce","vendite":1903},{"aisle_id":"77","product_name":"Soda","vendite":37298},{"aisle_id":"78","product_name":"Crackers Cheddar Bunnies Snack Packs","vendite":12752},{"aisle_id":"79","product_name":"Organic Cheese Frozen Pizza","vendite":14851},{"aisle_id":"8","product_name":"Muffins, Mini, Flax, Chocolate Brownie","vendite":2845},{"aisle_id":"80","product_name":"Men Dry Protection Cool Rush Antiperspirant & Deodorant","vendite":548},{"aisle_id":"81","product_name":"Organic Diced Tomatoes","vendite":22834},{"aisle_id":"82","product_name":"Free & Clear Unscented Baby Wipes","vendite":6540},{"aisle_id":"83","product_name":"Organic Yellow Onion","vendite":117716},{"aisle_id":"84","product_name":"Organic Whole Milk","vendite":142813},{"aisle_id":"85","product_name":"Aluminum Foil","vendite":11181},{"aisle_id":"86","product_name":"Large Alfresco Eggs","vendite":42274},{"aisle_id":"87","product_name":"Snack Bags","vendite":2273},{"aisle_id":"88","product_name":"Creamy Almond Butter","vendite":22340},{"aisle_id":"89","product_name":"Ranch Dressing","vendite":7081},{"aisle_id":"9","product_name":"Marinara Sauce","vendite":20752},{"aisle_id":"90","product_name":"Cocoa Powder","vendite":1536},{"aisle_id":"91","product_name":"Organic Unsweetened Almond Milk","vendite":60071},{"aisle_id":"92","product_name":"Baby Food Stage 2 Blueberry Pear & Purple Carrot","vendite":9103},{"aisle_id":"93","product_name":"Original Nooks & Crannies English Muffins","vendite":15642},{"aisle_id":"94","product_name":"Premium Unsweetened Iced Tea","vendite":6458},{"aisle_id":"95","product_name":"Wild Albacore Tuna No Salt Added","vendite":3755},{"aisle_id":"96","product_name":"Uncured Genoa Salami","vendite":43261},{"aisle_id":"97","product_name":"100% Recycled Aluminum Foil","vendite":3409},{"aisle_id":"98","product_name":"Pure Coconut Water","vendite":18912},{"aisle_id":"99","product_name":"Organic AppleApple","vendite":16780}];

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
              ListTile(
                title: Text('Predizioni', style: TextStyle(color: Colors.black)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Predizione()),
                  );
                },
              ),
              ListTile(
                title: Text('Analizza Utente', style: TextStyle(color: Colors.black)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AnalizzaUtente()),
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
                          MaterialPageRoute(builder: (context) => OrdiniOre()), // Pagina di destinazione
                        );
                      },
                      child: Card(
                        color: Colors.blue[50],
                        margin: EdgeInsets.all(8),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              // Titolo sopra il grafico
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  'Ordini per Ore del Giorno', // Titolo personalizzato
                                  style: TextStyle(
                                    fontSize: 18, // Dimensione del font
                                    color: Colors.black, // Colore del titolo
                                    fontWeight: FontWeight.bold, // Grassetto per il titolo
                                  ),
                                ),
                              ),
                              // Grafico
                              Expanded(
                                child: LineChart(
                                  LineChartData(
                                    gridData: FlGridData(show: true), // Mostra la griglia
                                    titlesData: FlTitlesData(
                                      leftTitles: AxisTitles(
                                        sideTitles: SideTitles(showTitles: false), // Disabilita le etichette dell'asse Y
                                      ),
                                      topTitles: AxisTitles(
                                        sideTitles: SideTitles(showTitles: false), // Disabilita le etichette della parte superiore
                                      ),
                                      rightTitles: AxisTitles(
                                        sideTitles: SideTitles(showTitles: false), // Disabilita le etichette della parte destra
                                      ),
                                      bottomTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: true, // Mostra le etichette solo sull'asse X
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
                                        isCurved: true, // per la linea curva
                                        color: Colors.blue[900],
                                        dotData: FlDotData(show: false), // pulsanti sulla linea disabilitati
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
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
                          child: Column(
                            children: [
                              // Titolo sopra il grafico
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  'Top N Prodotti', // Titolo personalizzato
                                  style: TextStyle(
                                    fontSize: 18, // Dimensione del font
                                    color: Colors.white, // Colore del titolo
                                    fontWeight: FontWeight.bold, // Grassetto per il titolo
                                  ),
                                ),
                              ),
                              // Grafico
                              Expanded(
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
                                                    fontSize: 8,
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
                                            color: Colors.white, // Colore delle barre
                                          ),
                                        ],
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
                  )
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
                                  centerSpaceRadius: 70,
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
                        color: Colors.blue[50],
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
                                    for (var product in ordiniCorridoio)
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

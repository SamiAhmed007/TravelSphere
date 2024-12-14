import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:wandermate/chat_page.dart';

class Join extends StatefulWidget {
  const Join({super.key});

  @override
  State<Join> createState() => _JoinState();
}

class _JoinState extends State<Join> {
  Map<String, double> exchangeRates = {};
  final List<int> originalPrice = [];
  final List<int> amounts = [];
  final List<String> selectedCurrency = [];

  @override
  void initState() {
    super.initState();
    fetchExchangeRates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF2193b0), Color(0xFF6dd5ed)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Column(
            children: [
              // Hero section
              Container(
                height: 200,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue, Colors.lightBlueAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: Text(
                    "Find Your Adventure Buddy",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.5),
                          offset: const Offset(2, 2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(child: _buildHikeList()),
            ],
          ),
        ],
      ),
    );
  }

  String getTimeMessage(Timestamp timestamp) {
    final DateTime now = DateTime.now();
    final DateTime date = timestamp.toDate();
    final Duration difference = date.difference(now);

    if (difference.isNegative) {
      return "Expired";
    } else if (difference.inDays < 5) {
      return "More\n${difference.inDays} days\nto go";
    } else if (difference.inDays < 7) {
      return "Less than\na week\nto go";
    } else if (difference.inDays <= 30) {
      final weeks = (difference.inDays / 7).ceil();
      return "More\n$weeks week${weeks > 1 ? 's' : ''}\nto go";
    } else {
      return "Date is far in the future";
    }
  }

  Future<void> fetchExchangeRates() async {
    final apiKey = "3d4e398b39c7329689eed4417b8c078a"; // Replace with your API key
    final url =
        "http://api.currencylayer.com/live?access_key=$apiKey&currencies=EUR,GBP,INR,AUD,CAD";

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          exchangeRates = Map<String, double>.from(data['quotes']);
        });
      } else {
        throw Exception('Failed to load exchange rates');
      }
    } catch (e) {
      debugPrint('$e');
    }
  }

  void convertAmount(int index) {
    if (selectedCurrency[index] == "USD") {
      setState(() {
        amounts[index] = originalPrice[index];
      });
    } else {
      final rateKey = "USD${selectedCurrency[index]}";
      final rate = exchangeRates[rateKey] ?? 1.0;
      setState(() {
        amounts[index] = (originalPrice[index] * rate).ceil();
      });
    }
  }

  Widget _buildHikeList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('hike').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text(
              'Error retrieving data',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final hikes = snapshot.data?.docs;

        if (hikes == null || hikes.isEmpty) {
          return const Center(
            child: Text(
              'No Trips available',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: hikes.length,
          itemBuilder: (BuildContext context, int index) {
            final hikeData = hikes[index].data() as Map<String, dynamic>;
            final title = hikeData['title'] as String;
            final startLocation = hikeData['start'];
            final endLocation = hikeData['end'];
            final timings = hikeData['timings'];
            final amount = hikeData['amount'];
            final id = hikes[index].id;

            // Add data to tracking lists
            if (originalPrice.length <= index) {
              originalPrice.add(amount);
              amounts.add(amount);
              selectedCurrency.add('USD');
            }

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatPage(
                      hikeName: title,
                      hikeId: id,
                    ),
                  ),
                );
              },
              child: Card(
                elevation: 6,
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.white, Colors.blue.withOpacity(0.1)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title and Time Message
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          Text(
                            getTimeMessage(timings),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Locations
                      Text(
                        'From: ${startLocation['city']}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'To: ${endLocation['city']}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Timings
                      Text(
                        'Timings: ${timings.toDate().toString()}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                      const Divider(),
                      // Round Trip Amount with Currency Selector
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Round Trip Amount:",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          DropdownButton<String>(
                            value: selectedCurrency[index],
                            style: const TextStyle(color: Colors.blue),
                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  selectedCurrency[index] = value;
                                  convertAmount(index);
                                });
                              }
                            },
                            items: (["USD"] +
                                    exchangeRates.keys
                                        .map((key) => key.substring(3))
                                        .toList())
                                .map((currency) => DropdownMenuItem(
                                      value: currency,
                                      child: Text(currency),
                                    ))
                                .toList(),
                          ),
                        ],
                      ),
                      Text(
                        "${amounts[index]} ${selectedCurrency[index]}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      const Divider(),
                      // User Details (new section)
                      const Text(
                        "Organized By:",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        hikeData['organizer'] ?? 'Unknown',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        hikeData['contact'] ?? 'No contact provided',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
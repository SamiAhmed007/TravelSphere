import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

class CreateHike extends StatefulWidget {
  const CreateHike({Key? key}) : super(key: key);

  @override
  State<CreateHike> createState() => _CreateHikeState();
}

class _CreateHikeState extends State<CreateHike> {
  final CollectionReference _reference =
      FirebaseFirestore.instance.collection('hike');
  Map<String, String>? startLocation = {};
  Map<String, String>? endLocation = {};
  TextEditingController titleController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  DateTime? date;

  Map<String, dynamic> jsonToMap(dynamic jsonType) {
    if (jsonType is Map<String, dynamic>) {
      return jsonType;
    } else if (jsonType is String) {
      return Map<String, dynamic>.from(jsonDecode(jsonType));
    } else {
      throw Exception("Unsupported type for conversion to Map");
    }
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
                colors: [Color(0xFF00B4DB), Color(0xFF0083B0)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Foreground content
          SingleChildScrollView(
            child: Column(
              children: [
                // Top section
                Container(
                  padding: const EdgeInsets.only(top: 60),
                  child: Column(
                    children: [
                      const Text(
                        "Create Your Trip",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Fill in the details to start planning",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                // Form container
                Container(
                  margin: const EdgeInsets.only(top: 30, left: 16, right: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Hike name input
                      _buildTextField(
                        controller: titleController,
                        labelText: "Enter Hike Name",
                        icon: Icons.hiking,
                      ),
                      const SizedBox(height: 20),
                      // Start location button
                      _buildElevatedButton(
                        label: "Select Start Location",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => _buildLocationPicker(),
                            ),
                          ).then((startAddress) {
                            if (startAddress != null) {
                              setState(() {
                                startLocation =
                                    jsonToMap(startAddress).cast<String, String>();
                              });
                            }
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      // End location button
                      _buildElevatedButton(
                        label: "Select End Location",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => _buildLocationPicker(),
                            ),
                          ).then((value) {
                            if (value != null) {
                              setState(() {
                                endLocation =
                                    jsonToMap(value).cast<String, String>();
                              });
                            }
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      // Date picker
                      _buildElevatedButton(
                        label: "Select Date",
                        onPressed: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2100),
                          ).then((value) {
                            if (value != null) {
                              setState(() {
                                date = value;
                              });
                            }
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      Text(
                        date != null
                            ? "Selected Date: ${date.toString().split(' ')[0]}"
                            : "No Date Selected",
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Amount input
                      _buildTextField(
                        controller: amountController,
                        labelText: "Enter Round Trip Amount (\$USD)",
                        icon: Icons.monetization_on,
                        inputType: TextInputType.number,
                        inputFormatter: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Submit button
                      _buildElevatedButton(
                        label: "Submit",
                        onPressed: _submitData,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationPicker() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Picker'),
        backgroundColor: const Color(0xFF0083B0),
      ),
      body: SizedBox(
        height: double.infinity,
        child: Center(
          child: OpenStreetMapSearchAndPick(
            hintText: 'Search Location',
            buttonColor: const Color(0xFF0083B0),
            buttonText: 'Set Location',
            onPicked: (pickedData) {
              Navigator.pop(context, pickedData.address);
            },
          ),
        ),
      ),
    );
  }

  Future<void> _submitData() async {
    if (startLocation == null ||
        endLocation == null ||
        date == null ||
        titleController.text.isEmpty ||
        amountController.text.isEmpty) {
      showAlert(
          context, 'Pending Information', 'Complete all the fields', () {});
      return;
    }

    try {
      await _reference.add({
        'title': titleController.text,
        'start': startLocation,
        'end': endLocation,
        'timings': date,
        'amount': num.parse(amountController.text),
      });
      showAlert(context, 'Confirmation', 'Hike Created Successfully!', () {
        Navigator.pop(context);
      });
    } catch (error) {
      debugPrint('Error saving data: $error');
    }
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    TextInputType inputType = TextInputType.text,
    List<TextInputFormatter>? inputFormatter,
  }) {
    return TextField(
      controller: controller,
      keyboardType: inputType,
      inputFormatters: inputFormatter,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: const Color(0xFF0083B0)),
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.black54),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildElevatedButton({
    required String label,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF0083B0),
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}

void showAlert(BuildContext context, String title, String message,
    VoidCallback onConfirm) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onConfirm();
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
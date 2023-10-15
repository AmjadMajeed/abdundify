import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../GetX/helper/snackbar_helper.dart';
import '../Utils/Colors.dart';
import '../models/snackbar_message.dart';

class NetworthPage extends StatefulWidget {
  @override
  _NetworthPageState createState() => _NetworthPageState();
}

class _NetworthPageState extends State<NetworthPage> {
  final firestore = FirebaseFirestore.instance;
  Map<String, TextEditingController> controllers = {
    "Home(s)": TextEditingController(),
    "Car(s)": TextEditingController(),
    "Jewelry(s)": TextEditingController(),
    "Bank Account Balance": TextEditingController(),
    "Asset(s)": TextEditingController(),
    "Cash": TextEditingController(),
    "Other(s)": TextEditingController(),
  };
  double total = 0.0;

  @override
  void initState() {
    super.initState();
    fetchDataFromFirestore();
    addListeners();
  }

  Future<void> fetchDataFromFirestore() async {
    final data = await firestore
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("netWorth")
        .doc("allNetWorth")
        .get();

    if (data.exists) {
      final netWorthData = data.data() as Map<String, dynamic>;
      controllers.forEach((key, controller) {
        if (netWorthData.containsKey(key)) {
          double value = netWorthData[key] as double;
          // Format the value with spaces
          controller.text = formatValue(value);
        }
      });
    }
  }

  void addListeners() {
    controllers.forEach((key, controller) {
      controller.addListener(() {
        setState(() {
          total = calculateTotal();
        });
      });
    });
  }

  double calculateTotal() {
    double sum = 0.0;
    controllers.forEach((key, controller) {
      if (controller.text.isNotEmpty) {
        sum += double.tryParse(controller.text.replaceAll(' ', '')) ?? 0.0;
      }
    });
    return sum;
  }

  String formatValue(double value) {
    final formattedValue = value.toStringAsFixed(0); // Change 2 to 0 to remove decimal values
    final mainValue = formattedValue.replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (match) => '${match[1]} ',
    );
    return mainValue;
  }

  Future<void> updateFirestoreValues() async {
    final userUid = FirebaseAuth.instance.currentUser?.uid;

    if (userUid != null) {
      final netWorthData = <String, dynamic>{};

      controllers.forEach((key, controller) {
        final value = controller.text.replaceAll(' ', '');
        if (value.isNotEmpty) {
          netWorthData[key] = double.tryParse(value) ?? 0.0;
        }
      });

      final firestoreDoc = firestore
          .collection("user")
          .doc(userUid)
          .collection("netWorth")
          .doc("allNetWorth");

      await firestoreDoc.set(netWorthData);
    }
  }

  @override
  void dispose() {
    controllers.forEach((key, controller) {
      controller.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final snackbarHelper = SnackbarHelper.instance..injectContext(context);
    final formattedTotal = formatValue(total);

    return Scaffold(
      backgroundColor: AppColors.MainBGColor,
      appBar: AppBar(
        backgroundColor: AppColors.MainBGColor,
        title: Center(child: Text('Net Worth')),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            for (final entry in controllers.entries)
              PointTextField(entry.key, entry.value),
            SizedBox(height: 20.0),
            Text(
              "Net Worth: \$$formattedTotal",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 20.0),
            InkWell(
              onTap: () {
                try {
                  updateFirestoreValues();
                  snackbarHelper.showSnackbar(snackbar: SnackbarMessage.success(message: "Net Worth Saved"));
                } catch (e) {
                  snackbarHelper.showSnackbar(snackbar: SnackbarMessage.error(message: e.toString()));
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white,
                ),
                height: 40,
                width: MediaQuery.of(context).size.width / 3,
                child: Center(child: Text("Save", style: TextStyle(color: AppColors.MainBGColor))),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PointTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;

  PointTextField(this.labelText, this.controller);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          style: TextStyle(color: Colors.white), // Set text color to white
          decoration: InputDecoration(
            labelText: labelText,
            hintText: "Enter amount for $labelText",
            labelStyle: TextStyle(color: Colors.white), // Set label text color to white
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white), // Set focused border color to white
            ),
            prefixText: '\$ ', // Dollar sign prefix
            prefixStyle: TextStyle(color: Colors.white), // Set dollar sign color to white
          ),
        ),
      ),
    );
  }
}

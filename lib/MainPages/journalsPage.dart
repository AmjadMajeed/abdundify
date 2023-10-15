import 'package:abundify/MainPages/EntryFormPage.dart';
import 'package:abundify/Utils/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/EntryModel.dart';

class EntryListPage extends StatefulWidget {
  @override
  _EntryListPageState createState() => _EntryListPageState();
}

class _EntryListPageState extends State<EntryListPage> {
  List<Entry> entries = [];

  @override
  void initState() {
    super.initState();
    loadEntries();
  }

  Future<void> loadEntries() async {
    final prefs = await SharedPreferences.getInstance();
    final entryList = prefs.getStringList('entries') ?? [];

    setState(() {
      entries = entryList.map((entry) {
        final parts = entry.split('|');
        return Entry(date: parts[0], emoji: parts[1], text: parts[2]);
      }).toList();

      // Sort entries by date in descending order
      entries.sort((a, b) => b.date.compareTo(a.date));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.MainBGColor,
      appBar: AppBar(
        backgroundColor: AppColors.MainBGColor,

        title: Center(child: Text('Journal',style: TextStyle(color: Colors.white),)),
      ),
      body: ListView.builder(
        itemCount: entries.length,
        itemBuilder: (context, index) {
          final entry = entries[index];
          return Container(
            color: AppColors.MainBGColor,
            height: MediaQuery.of(context).size.height/5,
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              margin: EdgeInsets.all(8.0),
              child: ListTile(
                leading: Text(
                  entry.date,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: AppColors.MainBGColor),
                ),
                trailing: Text(entry.emoji,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: AppColors.MainBGColor
                ),),
                subtitle: Text(entry.text,style: TextStyle(color: AppColors.MainBGColor),),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EntryFormPage()),
          ).then((value) {
            if (value != null) {
              saveEntry(value);
            }
          });
        },
        child: Icon(Icons.add,color: AppColors.MainBGColor,),
      ),
    );
  }

  Future<void> saveEntry(Entry entry) async {
    final prefs = await SharedPreferences.getInstance();
    entries.add(entry);

    // Sort entries by date in descending order
    entries.sort((a, b) => b.date.compareTo(a.date));

    final entryList = entries.map((entry) =>
    '${entry.date}|${entry.emoji}|${entry.text}').toList();
    await prefs.setStringList('entries', entryList);
    setState(() {});
  }
}

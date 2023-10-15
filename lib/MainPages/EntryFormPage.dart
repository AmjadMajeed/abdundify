import 'package:abundify/models/EntryModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Utils/Colors.dart';

class EntryFormPage extends StatefulWidget {
  @override
  _EntryFormPageState createState() => _EntryFormPageState();
}

class _EntryFormPageState extends State<EntryFormPage> {
  final TextEditingController _textController = TextEditingController();
  DateTime? selectedDate = DateTime.now();
  String selectedEmoji = '😀';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.MainBGColor,
      appBar: AppBar(
        backgroundColor: AppColors.MainBGColor,
        title: Center(child: Text('Journal',style: TextStyle(color: Colors.white),)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      final selected = await showDatePicker(
                        context: context,
                        initialDate: selectedDate ?? DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (selected != null && selected != selectedDate) {
                        setState(() {
                          selectedDate = selected;
                        });
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white), // Set the background color to green
                    ),
                    child: Text(
                      selectedDate != null
                          ? DateFormat('dd MMM yyyy').format(selectedDate!)
                          : 'Select Date',style: TextStyle(color: AppColors.MainBGColor),
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      _showEmojiPicker(context);
                    },
                    child: Text(selectedEmoji,style: TextStyle(fontSize: 26),),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height/10,),

              Container(
                height: 200, // Set the desired height
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0), // Rounded border
                  border: Border.all(
                    color: Colors.grey, // Border color
                  ),
                ),
                child: TextField(
                  controller: _textController,
                  maxLines: 6, // Set the number of lines to display
                  decoration: InputDecoration(
                    hintText: 'How was your day?',
                    hintStyle: TextStyle(color: Colors.white), // Set hint text color to white
                    contentPadding: EdgeInsets.all(16.0), // Padding inside the container
                    border: InputBorder.none, // Remove the default border
                  ),
                  style: TextStyle(color: Colors.white), // Set entered text color to white
                ),

              ),

              SizedBox(height: MediaQuery.of(context).size.height/10,),


              ElevatedButton(
                onPressed: () {
                  if (selectedDate != null) {
                    final entry = Entry(
                      date: DateFormat('dd MMM yyyy').format(selectedDate!),
                      emoji: selectedEmoji,
                      text: _textController.text,
                    );
                    Navigator.pop(context, entry);
                  } else {
                    // Handle the case where no date is selected
                    // You can show an error message or take appropriate action
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.white), // Set the background color to green
                ),
                child: Text('Save', style: TextStyle(color: AppColors.MainBGColor)),
              ),

            ],
          ),
        ),
      ),
    );
  }

  void _showEmojiPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Mood'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildEmojiButton('😌'),
                    _buildEmojiButton('😊'),
                    _buildEmojiButton('😀'),
                    _buildEmojiButton('😂'),
                    _buildEmojiButton('🤣'),
                  ],
                ),
                SizedBox(height: 10,),


                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildEmojiButton('🥰'),
                    _buildEmojiButton('🙂'),
                    _buildEmojiButton('🥳'),
                    _buildEmojiButton('🥺'),
                  ],
                ),

                // Add more emoji buttons as needed
              ],
            ),
          ),
        );
      },
    ).then((emoji) {
      if (emoji != null) {
        setState(() {
          selectedEmoji = emoji;
        });
      }
    });
  }

  Widget _buildEmojiButton(String emoji) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop(emoji);
      },
      child: Text(
        emoji,
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}


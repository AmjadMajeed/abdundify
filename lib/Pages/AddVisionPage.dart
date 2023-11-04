import 'dart:convert';
import 'dart:io';

import 'package:abundify/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/videoModel.dart';

class AddVisionPage extends StatefulWidget {
  final List<MediaData> mediaList;

  AddVisionPage({Key? key, required this.mediaList}) : super(key: key);

  @override
  State<AddVisionPage> createState() => _AddVisionPageState(mediaList: mediaList);
}

final TextEditingController titleController = TextEditingController();



class _AddVisionPageState extends State<AddVisionPage> {

  final List<MediaData> mediaList;
  final TextEditingController titleController = TextEditingController();

  _AddVisionPageState({required this.mediaList});

  var pickedFile;

  @override
  Widget build(BuildContext context) {
    final double itemHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.MainBGColor,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () async {
          await _saveMediaList(); // Save the updated list
          Navigator.pop(context, widget.mediaList); // Pop with the updated list
        },

        child: Icon(Icons.check, color: Colors.blue, size: 32), // Check icon
      ),
      body: SingleChildScrollView(
        child: Container(
          height: itemHeight,
          child: Column(
            children: [
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Icon(Icons.arrow_back_ios,
                          color: Colors.white, size: 30),
                    ),
                  ),
                  Text(
                    "Create Vision Board",
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  SizedBox(),
                ],
              ),
              SizedBox(height: 30),
              InkWell(
                onTap: () {
                  _pickMedia(ImageSource.gallery);
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: itemHeight / 3,
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Center(
                      child: pickedFile == null
                          ? Icon(
                        Icons.cloud_upload,
                        color: AppColors.MainBGColor,
                        size: 36,
                      )
                          : Image.file(
                        File(pickedFile.path),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: titleController,
                  style: TextStyle(color: Colors.white), // User-entered text color
                  decoration: InputDecoration(
                    labelText: 'Title',
                    labelStyle: TextStyle(color: Colors.white), // Label text color
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String newFilePath = "";
  String title = DateTime.now().toString();
  Future<void> _pickMedia(ImageSource source) async {
    final picker = ImagePicker();
    pickedFile = await picker.pickImage(source: source);

    if (pickedFile == null) return;

    final appDir = await getApplicationDocumentsDirectory();


     setState(() {
       newFilePath =
       '${appDir.path}/$title.${pickedFile.path.split('.').last}';
     });
    final newFile = File(newFilePath);
    await newFile.writeAsBytes(await pickedFile.readAsBytes());


  }


  Future<void> _saveMediaList() async {
    final prefs = await SharedPreferences.getInstance();
    final newMediaData = MediaData(path: newFilePath, title: titleController.text.toString());

    // Load the existing media list or create a new list if it doesn't exist
    final mediaListJson = prefs.getStringList('mediaList') ?? [];

    // Add the new media data to the list
    mediaListJson.add(
      jsonEncode({
        'path': newMediaData.path,
        'title': newMediaData.title,
      }),
    );

    // Save the updated media list
    prefs.setStringList('mediaList', mediaListJson);

    // Update the widget's mediaList with the new data
    setState(() {
      mediaList.add(newMediaData);
    });
  }




}

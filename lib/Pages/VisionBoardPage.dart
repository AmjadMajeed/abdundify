import 'package:abundify/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'dart:convert';

import 'package:video_player/video_player.dart';

import '../models/videoModel.dart';
import 'AddVisionPage.dart';






class MediaSavePage extends StatefulWidget {
  @override
  _MediaSavePageState createState() => _MediaSavePageState();
}

class _MediaSavePageState extends State<MediaSavePage> {
   List<MediaData> mediaList = [];
  final TextEditingController titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadMediaList();
  }

  Future<void> _loadMediaList() async {
    final prefs = await SharedPreferences.getInstance();
    final mediaListJson = prefs.getStringList('mediaList');
    if (mediaListJson != null) {
      setState(() {
        mediaList.clear();
        for (final item in mediaListJson) {
          final Map<String, dynamic> mediaDataMap = jsonDecode(item);
          final mediaData = MediaData(
            path: mediaDataMap['path'],
            title: mediaDataMap['title'],
          );
          mediaList.add(mediaData);
        }
      });
    }
  }

  Future<void> _saveMediaList() async {
    final prefs = await SharedPreferences.getInstance();
    final mediaListJson = mediaList.map((mediaData) {
      return jsonEncode({
        'path': mediaData.path,
        'title': mediaData.title,
      });
    }).toList();
    prefs.setStringList('mediaList', mediaListJson);
  }


  Future<void> _deleteMedia(int index) async {
    final confirmed = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete?'),
          content: Text('Are you sure you want to delete this Vision Card?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel',style: TextStyle(color: AppColors.MainBGColor),),
              onPressed: () {
                Navigator.of(context).pop(false); // Cancel the delete operation
              },
            ),
            TextButton(
              child: Text('Delete',style: TextStyle(color: Colors.red)),
              onPressed: () {
                Navigator.of(context).pop(true); // Confirm the delete operation
              },
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      setState(() {
        mediaList.removeAt(index);
      });
      _saveMediaList(); // Save the updated list
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final updatedMediaList = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddVisionPage(mediaList: mediaList), // Pass the correct mediaList
            ),
          );

          if (updatedMediaList != null) {
            setState(() {
              mediaList = updatedMediaList; // Update the mediaList with the updated data
            });
          }
        },

          child: Icon(Icons.add), // Plus icon

      ),
      // backgroundColor: AppColors.MainColor,
      appBar: AppBar(
        backgroundColor: AppColors.MainBGColor,
        title: Center(child: Text('Vision Board')),
      ),
      body: Container(
        color: AppColors.MainBGColorLight,
        child: Column(
          children: [
            Expanded(
              child:
              ListView.builder(
                itemCount: mediaList.length,
                itemBuilder: (context, index) {
                  print("mediaList.length");
                  print(mediaList.length);
                  print("mediaList.length");
                  final mediaData = mediaList[index];
                  return
                  mediaList.length == 0 ?
                      Center(child: Text("No Data",style: TextStyle(color: Colors.white),))
                  :

                    GestureDetector(
                      onLongPress: () => _deleteMedia(index),
                      child: Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12.0), // Top-left corner round
                            topRight: Radius.circular(12.0), // Top-right corner round
                            bottomRight: Radius.circular(12.0), // bottom-right corner round
                            bottomLeft: Radius.circular(12.0), // bottom-right corner round
                          ),
                        ),
                        margin: EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12.0), // Top-left corner round
                                topRight: Radius.circular(12.0), // Top-right corner round
                              ),
                              child: mediaData.path.endsWith('.mp4')
                                  ? VideoPlayerWidget(path: mediaData.path)
                                  : Image.file(File(mediaData.path)),
                            ),
                            ListTile(
                              title: Text(' ${mediaData.title}'),
                            ),
                          ],
                        ),
                      ),
                    );





                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String path;

  VideoPlayerWidget({required this.path});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.path))
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: VideoPlayer(_controller),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}

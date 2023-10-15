import 'package:abundify/Utils/Colors.dart';
import 'package:flutter/material.dart';

class BlessingListPage extends StatefulWidget {
  final List<String> todoList;

  BlessingListPage({required this.todoList});

  @override
  _BlessingListPageState createState() => _BlessingListPageState();
}

class _BlessingListPageState extends State<BlessingListPage> {
  late List<String> _todoList;
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _todoList = List.from(widget.todoList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.MainBGColor,
      appBar: AppBar(
        backgroundColor: AppColors.MainBGColor,
        title: Text('Blessing List',style: TextStyle(color: Colors.white),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 16.0),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _todoList.length + 1, // Add one for the input field
                itemBuilder: (context, index) {
                  if (index == _todoList.length) {
                    return TextField(
                      controller: _textController,
                      onSubmitted: (text) {
                        setState(() {
                          _todoList.insert(index, text); // Insert at the beginning
                          _textController.clear();
                          print("set state runs at 2222");
                        });
                      },
                      decoration: InputDecoration(
                        hintText: '${index + 1}.',
                        hintStyle: TextStyle(color: Colors.white), // Set hint text color
                        contentPadding: EdgeInsets.only(bottom: 12), // Adjust content padding
                        border: InputBorder.none, // Remove the border lines
                      ),
                      style: TextStyle(color: Colors.white), // Set text color
                    );

                  } else {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${index + 1}.',
                          style: TextStyle(fontSize: 16.0,color: Colors.white),
                        ),
                        SizedBox(width: 8.0),
                        Expanded(
                          child: TextField(
                            controller: TextEditingController(text: _todoList[index]),
                            onChanged: (text) {
                              _todoList[index] = text;
                            },
                            decoration: InputDecoration(
                              hintText: '',
                              hintStyle: TextStyle(color: Colors.white), // Set hint text color to white
                              contentPadding: EdgeInsets.only(bottom: 12), // Adjust content padding
                              border: InputBorder.none, // Remove the border lines
                            ),
                            style: TextStyle(color: Colors.white), // Set text color to white
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
              SizedBox(height: 16.0),

              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(_todoList);
                },
                child: Text('Save'),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

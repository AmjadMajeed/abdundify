import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Auth/AuthSelectionScreen.dart';
import 'MainPages/usersListPage.dart';
import 'MainPages/HabitTrackingPage.dart';
import 'MainPages/FeelitNow.dart';
import 'MainPages/BlessingListPage.dart';
import 'MainPages/journalsPage.dart';
import 'Utils/Colors.dart';



class MyScreen extends StatefulWidget {
  @override
  _MyScreenState createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  List<List<bool>> habitStatus = List.generate(4, (_) => List.filled(7, false));
  List<String> todoList = ['', '',''];
  List<String> sendMsgToList = ['', '',''];
  String gratefulText = '';
  String sendMsgTo = '';
  String Jornal = '';
  String todayImprovement = '';

  void _showHabitTrackingDialog(int index) async {
    // final updatedStatus = await Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (context) => DailyRoutineInputScreen(),
    //   ),
    // );
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EntryListPage(),
      ),
    );
    // if (updatedStatus != null) {
    //   setState(() {
    //     habitStatus[index] = updatedStatus;
    //   });
    // }
  }

  void _showTodoListDialog(int index) async {
    final updatedTodoList = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BlessingListPage(
          todoList: todoList,
        ),
      ),
    );
    if (updatedTodoList != null) {
      setState(() {
        todoList = updatedTodoList;
      });
    }
  }

  void _showGratefulTextDialog(int index) async {
    try{
      if(FirebaseAuth.instance.currentUser!.uid == null){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> AuthSelectionScreen()));
      }
      else
      {
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => UserListScreen(currentUserId: FirebaseAuth.instance.currentUser?.uid??"",
            ),
          ),
        );
      }
    }catch(e){
      Navigator.push(context, MaterialPageRoute(builder: (context)=> AuthSelectionScreen()));

    }

    // if (updatedGratefulText != null) {
    //   setState(() {
    //     sendMsgToList = updatedGratefulText;
    //   });
    // }
  }

  void _showTodayImprovementDialog(int index) async {
    final updatedImprovement = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FeelItNow(
        ),
      ),
    );
    if (updatedImprovement != null) {
      setState(() {
        todayImprovement = updatedImprovement;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    final double itemHeight = MediaQuery.of(context).size.height / 2;
    final double itemWidth = MediaQuery.of(context).size.width / 2;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: AppColors.MainBGColor,
    //     image: DecorationImage(
    //     image: AssetImage("assets/bgImage.jpeg"),
    // fit: BoxFit.cover,
    // ),
        ),
        height: MediaQuery.of(context).size.height,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: (itemWidth / itemHeight),
            crossAxisCount: 2,
            // mainAxisSpacing: 0,
            // crossAxisSpacing: 0,// You can change this to adjust the number of portions
          ),
          itemCount: 4,
          itemBuilder: (context, index) {
            if (index == 0) {
              return GestureDetector(
                onTap: () {
                  _showHabitTrackingDialog(index);
                },
                child: SingleChildScrollView(
                  child: Container(
                    height: itemHeight,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white,)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Journal',
                            style: TextStyle(fontSize: 18.0,color: Colors.white),
                          ),

                          SizedBox(height: 150.0),
                          Text(
                            Jornal.isEmpty ? '' : Jornal,
                            style: TextStyle(fontSize: 16.0,color: Colors.white),
                          ),
                          SizedBox(height: 16.0),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            } else if (index == 1) {
              return GestureDetector(
                onTap: () {
                  _showTodoListDialog(index);
                },
                child: SingleChildScrollView(
                  child: Container(
                    height: itemHeight,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'List Blessings',
                            style: TextStyle(fontSize: 18.0,color: Colors.white),
                          ),
                          SizedBox(height: 16.0),
                          for (int i = 0; i < 3; i++)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${i + 1}.',
                                  style: TextStyle(fontSize: 16.0,color: Colors.white),
                                ),
                                SizedBox(width: 8.0),
                                Expanded(
                                  child: TextField(
                                    controller: TextEditingController(text: todoList[i]),
                                    onChanged: (text) {
                                      todoList[i] = text;
                                    },
                                    style: TextStyle(color: Colors.white), // Set the text color to white
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      hintText: '',
                                      border: InputBorder.none, // Remove the bottom line
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          SizedBox(height: 16.0),
                        ],
                      ),
                    ),
                  ),
                ),

              );
            } else if (index == 2) {
              return GestureDetector(
                onTap: () {
                  _showGratefulTextDialog(index);
                },
                child: Container(
                  height: itemHeight,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white,)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Send Graditude Message to...',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18.0,color: Colors.white),
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          gratefulText.isEmpty ? '' : gratefulText,
                          style: TextStyle(fontSize: 16.0,color: Colors.white),
                        ),

                        SizedBox(height: 16.0),
                      ],
                    ),
                  ),
                ),
              );
            } else if (index == 3) {
              return GestureDetector(
                onTap: () {
                  _showTodayImprovementDialog(index);
                },
                child: Container(
                  height: itemHeight,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white,)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Feel It Now!',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18.0,color: Colors.white),
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          todayImprovement.isEmpty ? '' : todayImprovement,
                          style: TextStyle(fontSize: 16.0,color: Colors.white),
                        ),
                        SizedBox(height: 16.0),
                      ],
                    ),
                  ),
                ),
              );
            }
            return Container(); // Placeholder for other portions
          },
        ),
      ),
    );
  }



  Future<List<Map<String, dynamic>>> getUsers(String currentUserId) async {
    final QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance.collection('user').get();

    final List<Map<String, dynamic>> users = [];

    for (final DocumentSnapshot document in querySnapshot.docs) {
      final Map<String, dynamic> userData = document.data() as Map<String, dynamic>;
      final String userId = userData['id'] as String;

      // Exclude the current user
      if (userId != currentUserId) {
        users.add(userData);
      }
    }

    return users;
  }

}









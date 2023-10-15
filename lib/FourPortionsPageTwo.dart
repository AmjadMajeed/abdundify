import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'Auth/AuthSelectionScreen.dart';
import 'Pages/FAQs.dart';
import 'Pages/MoneyTransferPage.dart';
import 'Pages/NetWorthPage.dart';
import 'Pages/VisionBoardPage.dart';
import 'Utils/Colors.dart';
import 'models/user_model.dart';

class FourPortionPageTwo extends StatefulWidget {
  const FourPortionPageTwo({Key? key}) : super(key: key);

  @override
  State<FourPortionPageTwo> createState() => _FourPortionPageTwoState();
}

class _FourPortionPageTwoState extends State<FourPortionPageTwo> {

  var earning;

  @override
  void initState() {
    // Call the readData function to retrieve the 'earning' value
    readData();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    final double itemHeight = MediaQuery.of(context).size.height / 2;
    final double itemWidth = MediaQuery.of(context).size.width / 2;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: AppColors.MainBGColor,
        //   image: DecorationImage(
        //     image: AssetImage("assets/bgImage.jpeg"),
        //     fit: BoxFit.cover,
        //   ),
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
                  try{
                    if(FirebaseAuth.instance.currentUser!.uid == null){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> AuthSelectionScreen()));
                    }
                    else
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>MoneyTransferPage()));
                    }
                  }catch(e){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> AuthSelectionScreen()));

                  }


                },
                child: Container(
                  height: itemHeight,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey,width: 0.3)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Bank account \n balance',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18.0,color: Colors.white),
                        ),
                        // SizedBox(height: 16.0),
                        // Text(
                        //   "",
                        //   style: TextStyle(fontSize: 16.0),
                        // ),

                        SizedBox(height: 16.0),
                      ],
                    ),
                  ),
                ),
              );
            } else if (index == 1) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> MediaSavePage()));
                },
                child: SingleChildScrollView(
                  child: Container(
                    height: itemHeight,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey,width: 0.3),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Vision Board',
                            style: TextStyle(fontSize: 18.0,color: Colors.white),
                          ),
                          SizedBox(height: 16.0),
                          // for (int i = 0; i < 3; i++)
                          //   Row(
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     children: [
                          //       Text(
                          //         '${i + 1}.',
                          //         style: TextStyle(fontSize: 16.0),
                          //       ),
                          //       SizedBox(width: 8.0),
                          //
                          //     ],
                          //   ),
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
                  try{
                    if(FirebaseAuth.instance.currentUser!.uid == null){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> AuthSelectionScreen()));
                    }
                    else
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>NetworthPage()));
                    }
                  }catch(e){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> AuthSelectionScreen()));

                  }


                },
                child: Container(
                  height: itemHeight,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey,width: 0.3)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Net Worth',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18.0,color: Colors.white),
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          "",
                          style: TextStyle(fontSize: 16.0),
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
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>FAQs()));
                },
                child: Container(
                  height: itemHeight,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey,width: 0.3)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'FAQs\n + \n Tips and Tricks',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18.0,color: Colors.white),
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          '',
                          style: TextStyle(fontSize: 16.0),
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


  Future<void> readData() async {
    try {
      // Reference to the Firestore collection and document
      final CollectionReference userCollection = FirebaseFirestore.instance.collection('user');
      final DocumentSnapshot documentSnapshot = await userCollection.doc(FirebaseAuth.instance.currentUser?.uid).get();

      // Check if the document exists
      if (documentSnapshot.exists) {
        // Access the 'earning' field from the document data
        final data = documentSnapshot.data() as Map<String, dynamic>;
        setState(() {
          earning = data['earning'];
        });


        // Use the 'earning' value
        print('Earning: $earning');
      } else {
        print('Document does not exist');
      }
    } catch (e) {
      print('Error reading data: $e');
    }
  }




}

import 'package:abundify/FourPortionsPageTwo.dart';
import 'package:abundify/Utils/Colors.dart';
import 'package:abundify/Utils/Constants.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'Auth/AuthSelectionScreen.dart';
import 'FourPortionScreen.dart';
import 'Pages/SettingPage.dart';
import 'main.dart';



class AffirmationListScreen extends StatefulWidget {
  @override
  State<AffirmationListScreen> createState() => _AffirmationListScreenState();
}

class _AffirmationListScreenState extends State<AffirmationListScreen> {
  final AffirmationController affirmationController = Get.put(AffirmationController());
  String? profilePicUrl;
  String newAffirmation = ''; // To store the new affirmation text




  Future<String?> getUserProfilePicUrl(String userId) async {
    try {
      final userDoc = await FirebaseFirestore.instance.collection('user').doc(userId).get();
      if (userDoc.exists) {
        final profilePicUrl = userDoc.get('image');
        return profilePicUrl;
      }
    } catch (e) {
      print('Error fetching profile pic URL: $e');
    }
    return null;
  }



  @override
  void initState() {
    super.initState();
    // Load the user's profile picture URL when the screen is initialized
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      getUserProfilePicUrl(userId).then((url) {
        setState(() {
          profilePicUrl = url;
        });
      });
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.MainBGColor,
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: AppColors.MainBGColor,
        leading: GestureDetector(
          onTap: () {
            // Handle drawer button tap here
            _scaffoldKey.currentState?.openDrawer();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(profilePicUrl ?? ''),
              radius: 16,
            ),
          ),
        ),
      ),
      drawer: Drawer(

        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(AppConstants.currentUserName??"Abundify"),
              accountEmail: Text(FirebaseAuth.instance.currentUser?.email??""),
              currentAccountPicture: CircleAvatar(
                backgroundColor:
                Theme.of(context).platform == TargetPlatform.iOS
                    ? AppColors.MainColor
                    : Colors.white,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(profilePicUrl ?? ''),
                  radius: 20,
                ),
              ),
            ),


            GestureDetector(
              onTap:(){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>FourPortionPageTwo()));
              },
              child: ListTile(
                title: Text("Wealth"),
                trailing: Icon(Icons.arrow_forward),
              ),
            ),

            GestureDetector(
              onTap:(){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingPage()));
              },
              child: ListTile(
                title: Text("Settings"),
                trailing: Icon(Icons.arrow_forward),
              ),
            ),



            GestureDetector(
              onTap:(){
                try{
                  if(FirebaseAuth.instance.currentUser?.uid !=null)
                  {
                    AwesomeDialog(
                        context: context,
                        dialogType: DialogType.question,
                        animType: AnimType.BOTTOMSLIDE,
                        title: "Warning",
                        desc: "Confirm that you want to delete your account permanently, As your data cannot be recovered",
                        descTextStyle: TextStyle(
                            fontSize: 20,
                            color: Colors.white
                        ),
                        // btnCancelOnPress: () {},
                        dialogBackgroundColor: AppColors.MainColor,
                        btnOkColor: Colors.grey[800],
                        btnOkText: "Delete",
                        btnOkOnPress: () {
                          FirebaseAuth.instance.currentUser?.delete();
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                              AuthSelectionScreen()), (Route<dynamic> route) => false);
                        },
                        btnCancelText: "No",
                        btnCancelOnPress: (){
                          Navigator.pop(context);
                        }
                    ).show();


                  }
                  else
                  {
                    AsmDialogg(context,"Error","Your Must Be Register With Us To Delete Account");
                  }


                }catch(e){

                  AsmDialogg(context,"Error","Something Goes Wronge Try Again");

                }
              },
              child: ListTile(
                title: Text("Delete Account"),
                trailing: Icon(Icons.logout,color: Colors.red,),
              ),
            ),


            GestureDetector(
              onTap:(){
                try{
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                      AuthSelectionScreen()), (Route<dynamic> route) => false);
                }catch(e){

                }
              },
              child: ListTile(
                title: Text("LogOut"),
                trailing: Icon(Icons.logout,color: Colors.red,),
              ),
            ),
          ],
        ),
      ),


      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () => _showAddAffirmationDialog(context),
        child: Icon(Icons.add,color: AppColors.MainBGColor,),
      ),

      body: Container(
        color: AppColors.MainBGColor,
        child: Obx(
              () => PageView.builder(
            itemCount: affirmationController.affirmations.length,
            itemBuilder: (context, index) {
              final affirmation = affirmationController.affirmations[index];
              return Padding(
                padding: const EdgeInsets.all(0.0),
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Container(
                    color: AppColors.MainBGColor,
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Spacer(),
                        Padding(
                          padding:  EdgeInsets.only(left: 30,right: 20,top: 100),
                          child: Text(
                            affirmation.text,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.share,
                                size: 34,
                                color: Colors.white,
                              ),
                              onPressed: () =>
                                  affirmationController.shareAffirmation(affirmation.text),
                            ),
                            IconButton(
                              icon: Icon(
                                affirmation.isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: affirmation.isFavorite ? Colors.red : Colors.white,
                                size: 34,
                              ),
                              onPressed: () {
                                affirmationController.toggleFavorite(affirmation);
                                setState(() {
                                  print("setState runs 111");
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            controller: PageController(), // Use a PageController for swiping
            scrollDirection: Axis.vertical, // Swipe vertically
            pageSnapping: true, // Ensure one index at a time
          ),


        ),
      ),
    );
  }

  // Function to show a dialog for adding a new affirmation
  Future<void> _showAddAffirmationDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Affirmation'),
          content: TextField(
            onChanged: (value) {
              setState(() {
                newAffirmation = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'Enter your new affirmation...',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                // Save the new affirmation here (you can add it to the list)
                affirmationController.addAffirmation(newAffirmation);

                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

}
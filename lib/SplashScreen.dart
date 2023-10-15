import 'dart:async';

import 'package:abundify/Utils/Colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'AffairmationPage.dart';
import 'Auth/AuthSelectionScreen.dart';
import 'GetX/helper/firebase_auth_helper.dart';
import 'Utils/Constants.dart';
import 'bottomNavBar/bottomNavBar.dart';
import 'models/affairmationModel.dart';


class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  String? tokeen;
  @override
  void initState() {
    print("splash runss");
    try{
      if(FirebaseAuth.instance.currentUser!.uid != null)
      {
        print("if runsss");
        getUser();
      }
    }catch(e)
    {
      print("something goes wrong");
    }
    responceGet();

    super.initState();
  }


  responceGet() {
    final firebaseAuthHelper = FirebaseAuthHelper.instance;

    Timer(Duration(seconds: 4), () async {
      print("splash runss22222");
     // try{
     //   if(FirebaseAuth.instance.currentUser!.uid == null){
     //     Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
     //         AuthSelectionScreen()), (Route<dynamic> route) => false);
     //   }
     //   else
     //   {
     //     Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
     //         AffirmationListScreen()), (Route<dynamic> route) => false);
     //     // Get.off(AffirmationListScreen());
     //   }
     // }catch(e){
     //   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
     //       AuthSelectionScreen()), (Route<dynamic> route) => false);
     // }

    });
  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: FutureBuilder<bool>(
        future: _checkAffirmationsExist(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While checking, show a loading indicator.
            return Center(child: CircularProgressIndicator(
              color: AppColors.MainBGColor,
            ));
          } else if (snapshot.hasError) {
            // Handle errors here.
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            // Affirmations check is complete.
            final affirmationsExist = snapshot.data ?? false;

            // Redirect to the appropriate screen.
            if (affirmationsExist) {
              return bottomNavigationBar(0);
            } else {
              // Add default affirmations and then redirect to the list screen.
              _addDefaultAffirmations().then((_) {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>bottomNavigationBar(0)));
                // Get.to(AffirmationListScreen());
              });
              return Center(child: CircularProgressIndicator());
            }
          }
        },
      ),
    );
  }

  Future<bool> _checkAffirmationsExist() async {
    final prefs = await SharedPreferences.getInstance();
    final savedAffirmations = prefs.getStringList('affirmations');
    return savedAffirmations != null && savedAffirmations.isNotEmpty;
  }

  Future<void> _addDefaultAffirmations() async {
    final prefs = await SharedPreferences.getInstance();
    final defaultAffirmations = [
      'Money comes in large amounts into my bank account.',
      'I am living my dream life.',
      'Money shows up to me in expected an unexpected ways nonstop.',
      'I am grateful for the opportunities in my life.',
      'I’m so happy to be in the money flow.',
      'I have financial abundance and I never worry about my spending.',
      'I’m spending money with the belief that so much more is coming to my account as I am spending.',
      'Every day I’m getting richer and richer, I travel the world and have good experiences daily.',
      'I feel good spending money knowing that I’m getting more of it all the times.',
      'I’m happy for other people.',
      'Success and wealth knowing that we have the same source.',
      'I don’t have to work physically or get tired to earn money.',
      'I attract million-dollar ideas and take action.',
      'Money chases after me.',
      'I am free in all aspects.',
      'I’m connected to the infinite supply that provides for all, I’m connected to the source.',
      'I’m so grateful for the abundance of money I have in my bank account right now and I know it’s growing everyday.',
      'I am receiving successful ideas and the energy and resources.',
      'A breakthrough is coming.',
      'A large flow of money is coming into my life from all directions at high speed.',
      'I attract successful people into my life who teach me what I need to know and connect me with great opportunities.',
      'I am surrounded by successful people.',
      'I am constantly pulled towards financial freedom and abundance.',
      'My family is so happy and proud of my success and achievements.',
      'I do what I love and get paid for it I don’t feel like working when I’m doing what I’m passionate about.',
      'I have freedom of time and financial security.',
      'I’m making enough money to have free time and explore life.',
      'I’m living in my dream home.',
      'I am worthy of the life of my dreams.',
      'I have everything I need to be successful.',
      'I am grateful for the positive things in my life.',
      'I am open to limitless possibilities.',
      'I achieve whatever I set my mind to.',
      'I am smart, capable and talented.',
      'I believe in myself.',
      'I am ready to share my gifts with the world.',
      'I surrender to the wisdom of God.',
      'I am my best source of motivation.',
      'I am creative and open to new solutions.',
      'I focus on solutions not problems.',
      'I am in control of my thoughts.',
      'I choose to embrace the mystery of life.',
      'I choose to only see the beauty in things.',
      'I choose faith over fear.',
      'I allow everything to be as it is.',
      'I attract miracles into my life.',
      'A Great miracle is coming.',
      'I am open to receiving unexpected opportunities.',
      'I am aligned with my purpose.',
      'I am aligned with everything I want.',
      'I am worthy of positive changes in my life.',
      'I am grateful for EveryThing.',
    ];

    final jsonStringList = defaultAffirmations.map((affirmation) {
      final model = AffirmationModel(affirmation);
      return jsonEncode(model.toJson());
    }).toList();

    await prefs.setStringList('affirmations', jsonStringList);
  }

  Future<void> getUser() async {
    print("getUSer runsss1111");

    try{
      print("getUSer runsss2222");

      var collection = FirebaseFirestore.instance.collection('user');
      var querySnapshot = await collection.doc(FirebaseAuth.instance.currentUser?.uid.toString()).get();
      Map<String, dynamic>? data = querySnapshot.data();
      setState(() {
        AppConstants.currentUserName = data!["first_name"];
        AppConstants.currentUserProfile = data['image'];
        AppConstants.currentUserRating = data['rating'].toString();
        AppConstants.isOnline = data['isOnline'];
        AppConstants.isNane = data['isNane'];
        AppConstants.memberShip = data['memberShip'];
      });


    }catch(e){
      print("getUSer runsss4444");
      print("error in reading user info");
      print("e.toString()");
      print(e.toString());
      print("e.toString()");
    }

  }

}


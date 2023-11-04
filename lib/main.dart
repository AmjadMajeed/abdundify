import 'package:abundify/Utils/Constants.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'Provider/NotificationApiClass.dart';
import 'Provider/auth_provider.dart';
import 'Provider/chat_provider.dart';
import 'IntroScreens/IntroOne.dart';
import 'Utils/Colors.dart';
import 'models/affairmationModel.dart';
import 'dart:async';
import 'package:timezone/data/latest.dart' as tz;
import 'Services/notifi_service.dart';





Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  AwesomeNotifications().initialize(
    'resource://drawable/app_icon',
    [
    NotificationChannel(
        channelKey: "basic_channel", channelName: "basic_Notification",
        channelDescription: "Notification Channel For Test",
      channelShowBadge: true,
      importance: NotificationImportance.High,
    ),
  ],
    debug: true,
  );

  NotificationService().initNotification();
  tz.initializeTimeZones();


  SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(MyApp(prefs: prefs));
}




setPushNoitificationFunction(int hours){

  try{
    NotificationApiClass.showScheduledNotificationMethod(
      id: 717171,
      titleText: "Hi! ${AppConstants.currentUserName}",
      notificationBody:  "Take out some time to manifest more abundance",
      payloadd: "",
      scheduledDateTime: DateTime.now().add(Duration(
        hours: hours,
      )),
    );
    print("shedul notification sucessss for time of $hours");
  }catch(e)
  {
    print("shedul notification error");
  }
}


setPushNoitificationForBankBalance(int min,int balance){

  try{
    NotificationApiClass.showScheduledNotificationMethod(
      id: 717171,
      titleText: "You Recive a New Payment",
      notificationBody:  "\$${balance} Congrats",
      payloadd: "",
      scheduledDateTime: DateTime.now().add(Duration(
        minutes: min,
      )),
    );
    print("shedul notification for bank sucessss for $balance, and $min mins");
  }catch(e)
  {
    print("shedul notification error");
  }
}

Future<void> onSelectNotification(String? payload) async {
  // Handle notification tap here
}

Future<void> onDidReceiveLocalNotification(
    int id, String? title, String? body, String? payload) async {
  // Handle notification when app is in the foreground here
}



void AsmDialogg(BuildContext context,String title,String description)
{
  AwesomeDialog(
    context: context,
    dialogType: DialogType.ERROR,
    animType: AnimType.BOTTOMSLIDE,
    // title: title,
    desc: description,
    dialogBackgroundColor: AppColors.MainColor,
    btnOkColor: Colors.grey[800],
    btnOkOnPress: () {
    },
    btnOkText: "Ok",
  ).show();
}
void AsmDialogForSuccess(BuildContext context,String title,String description)
{
  AwesomeDialog(
    context: context,
    dialogType: DialogType.SUCCES,
    animType: AnimType.BOTTOMSLIDE,
    // title: title,
    desc: description,
    descTextStyle: TextStyle(
        fontSize: 20,
        color: Colors.white
    ),
    // btnCancelOnPress: () {},
    dialogBackgroundColor: AppColors.MainColor,
    btnOkColor: Colors.grey[800],
    btnOkText: "Ok",
    btnOkOnPress: () {
      Navigator.pop(context);
    },
  ).show();
}

class MyApp extends StatelessWidget {

  final SharedPreferences prefs;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  MyApp({required this.prefs});

  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(
            firebaseAuth: FirebaseAuth.instance,
            googleSignIn: GoogleSignIn(),
            prefs: this.prefs,
            firebaseFirestore: this.firebaseFirestore,
          ),
        ),
        Provider<ChatProvider>(
          create: (_) => ChatProvider(
            prefs: this.prefs,
            firebaseFirestore: this.firebaseFirestore,
            firebaseStorage: this.firebaseStorage,
          ),
        ),
      ],
      child: MaterialApp(
        title: "Abundify",
        theme: ThemeData(
        ),

        home: IntroOne(),
        // home: bottomNavigationBar(0),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class AffirmationController extends GetxController {
  final RxList<AffirmationModel> affirmations = <AffirmationModel>[].obs;
  late SharedPreferences _prefs;

  @override
  void onInit() {
    super.onInit();
    _loadAffirmations();
  }

  Future<void> _loadAffirmations() async {
    _prefs = await SharedPreferences.getInstance();
    final savedAffirmations = _prefs.getStringList('affirmations') ?? [];
    affirmations.assignAll(savedAffirmations.map((affirmation) => AffirmationModel.fromJson(affirmation)));
  }

  Future<void> _saveAffirmations() async {
    final affirmationList = affirmations.map((affirmation) => affirmation.toJson()).toList();
    final jsonStringList = affirmationList.map((affirmation) => jsonEncode(affirmation)).toList();
    await _prefs.setStringList('affirmations', jsonStringList);
  }

  void addAffirmation(String text) {
    if (text.isNotEmpty) {
      final newAffirmation = AffirmationModel(text);
      affirmations.add(newAffirmation);
      _saveAffirmations();
    }
  }

  void shareAffirmation(String affirmation) {
    // Implement sharing functionality here.
  }

  void toggleFavorite(AffirmationModel affirmation) {
    affirmation.isFavorite = !affirmation.isFavorite;
    _saveAffirmations();
  }
}




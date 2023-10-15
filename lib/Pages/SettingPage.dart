import 'package:abundify/Services/notifi_service.dart';
import 'package:abundify/Utils/Colors.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../GetX/helper/snackbar_helper.dart';
import '../models/snackbar_message.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool isSwitched = false;
  TextEditingController affairmationController = TextEditingController();
  TextEditingController listBlessingController = TextEditingController();
  TextEditingController bankAccountTimeController = TextEditingController();
  TextEditingController bankBalanceController = TextEditingController();

  @override
  void initState() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if(!isAllowed){
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    super.initState();
    loadSwitchState();
  }

  // Load switch state from shared preferences
  Future<void> loadSwitchState() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isSwitched = prefs.getBool('isSwitched') ?? false;
    });
  }

  // Save switch state to shared preferences
  Future<void> saveSwitchState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isSwitched', isSwitched);
    // trigerNoticiation();
    // scheduleNotification();
  }

  trigerNoticiation(){
    print("hiiiiiiii");
    AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 10,
            channelKey: "basic_channel",
          title: "testing",
          body: "This is testing Notification",
        ));
  }


  //
  // void scheduleNotificationAtSpecificTime() async {
  //   // Calculate the time in seconds since the epoch
  //   int notificationTimeInSeconds = DateTime.now()
  //       .add(Duration(hours: 24)) // Adjust this to the desired time
  //       .millisecondsSinceEpoch ~/
  //       1000;
  //
  //   await AwesomeNotifications().createNotification(
  //     content: NotificationContent(
  //       id: 10,
  //       channelKey: 'basic_channel',
  //       title: 'Scheduled Notification',
  //       body: 'This is a scheduled notification.',
  //     ),
  //     schedule: NotificationSchedule(
  //       allowWhileIdle: true,
  //       sendAt: notificationTimeInSeconds,
  //     ),
  //   );
  // }


  @override
  Widget build(BuildContext context) {

    final snackbarHelper = SnackbarHelper.instance..injectContext(context);

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.MainBGColor,
      appBar: AppBar(
        backgroundColor: AppColors.MainBGColor,
        title:  Center(child: Text("Settings")),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              SizedBox(height: height / 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Notifications Are ${isSwitched ? '"ON"' : '"OFF"'}',
                    style: const TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                  Switch(
                    value: isSwitched,
                    onChanged: (value) {
                      setState(() {
                        isSwitched = value;
                        saveSwitchState(); // Save the switch state when it's toggled
                      });
                    },
                    activeTrackColor: Colors.lightGreenAccent,
                    activeColor: Colors.green,
                  ),
                ],
              ),

              SizedBox(height: height / 20),
              // Divider(thickness: 1.0,color: Colors.white,),

              SizedBox(height: height/10,),


              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Affirmations",style: TextStyle(color: Colors.white,fontSize: 18),),
                  SizedBox(),
                  Container(
                    width: width / 4,
                    decoration: BoxDecoration(
                      border: Border.all(color: isSwitched? Colors.white: Colors.grey), // Set the border color to white
                      borderRadius: BorderRadius.circular(8.0), // Optional: Add rounded corners
                    ),
                    child: IgnorePointer(
                      ignoring: !isSwitched, // Disable when the switch is off
                      child: TextField(
                        controller: affairmationController,
                        style: TextStyle(
                          color: isSwitched ? Colors.white : Colors.grey, // Change text color based on switch
                        ),
                        decoration: InputDecoration(
                          hintText: "  1",
                          hintStyle: TextStyle(
                            color: isSwitched ? Colors.white : Colors.grey, // Change hint text color based on switch
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(),
                  Text("Per Day",style: TextStyle(color: Colors.white,fontSize: 18),),
                ],
              ),
              Divider(thickness: 1.0,color: Colors.white,),

              SizedBox(height: height/50,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("List of blessings",style: TextStyle(color: Colors.white,fontSize: 18),),
                  SizedBox(),
                  Container(
                    width: width / 4,
                    decoration: BoxDecoration(
                      border: Border.all(color: isSwitched? Colors.white: Colors.grey), // Set the border color to white
                      borderRadius: BorderRadius.circular(8.0), // Optional: Add rounded corners
                    ),
                    child: IgnorePointer(
                      ignoring: !isSwitched, // Disable when the switch is off
                      child: TextField(
                        controller: listBlessingController,
                        style: TextStyle(
                          color: isSwitched ? Colors.white : Colors.grey, // Change text color based on switch
                        ),
                        decoration: InputDecoration(
                          hintText: "  1",
                          hintStyle: TextStyle(
                            color: isSwitched ? Colors.white : Colors.grey, // Change hint text color based on switch
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(),
                  Text("Per Day",style: TextStyle(color: Colors.white,fontSize: 18),),
                ],
              ),
              Divider(thickness: 1.0,color: Colors.white,),

              SizedBox(height: height/50,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Bank Account \nBalance",style: TextStyle(color: Colors.white,fontSize: 17),),
                  SizedBox(),
                  Container(
                    width: width / 6,
                    decoration: BoxDecoration(
                      border: Border.all(color: isSwitched? Colors.white: Colors.grey), // Set the border color to white
                      borderRadius: BorderRadius.circular(8.0), // Optional: Add rounded corners
                    ),
                    child: IgnorePointer(
                      ignoring: !isSwitched, // Disable when the switch is off
                      child: TextField(
                        controller: bankBalanceController,
                        style: TextStyle(
                          color: isSwitched ? Colors.white : Colors.grey, // Change text color based on switch
                        ),
                        decoration: InputDecoration(
                          hintText: "  \$",
                          hintStyle: TextStyle(
                            color: isSwitched ? Colors.white : Colors.grey, // Change hint text color based on switch
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: width / 6,
                    decoration: BoxDecoration(
                      border: Border.all(color: isSwitched? Colors.white: Colors.grey), // Set the border color to white
                      borderRadius: BorderRadius.circular(8.0), // Optional: Add rounded corners
                    ),
                    child: IgnorePointer(
                      ignoring: !isSwitched, // Disable when the switch is off
                      child: TextField(
                        controller: bankAccountTimeController,
                        style: TextStyle(
                          color: isSwitched ? Colors.white : Colors.grey, // Change text color based on switch
                        ),
                        decoration: InputDecoration(
                          hintText: "  30",
                          hintStyle: TextStyle(
                            color: isSwitched ? Colors.white : Colors.grey, // Change hint text color based on switch
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(),
                  Text("Minutes",style: TextStyle(color: Colors.white,fontSize: 18),),
                ],
              ),
              Divider(thickness: 1.0,color: Colors.white,),

              SizedBox(height: height/5,),
              GestureDetector(
                onTap: (){
                  if(isSwitched = true)
                    {
                  try{
                    print("if runnsss");


                    NotificationService().scheduleRepeatedNotifications(
                        int.parse(affairmationController.text.toString().trim()??"2"));

                    NotificationService().scheduleRepeatedNotificationsForBank(
                        int.parse(bankAccountTimeController.text.toString().trim()),
                        int.parse(bankBalanceController.text.toString().trim()));

                    snackbarHelper.showSnackbar(snackbar: SnackbarMessage.success(message: 'Notification set successfully'));
                  }catch(e)
                  {
                    snackbarHelper.showSnackbar(snackbar: SnackbarMessage.error(message: e.toString()));
                  }


                    }
                  else
                    {
                      print("else runnsss");
                      snackbarHelper.showSnackbar(snackbar: SnackbarMessage.error(message: 'Something Goes Wrong Try Again.'));


                    }
                },
                child: Container(
                  height: height/20,
                  width: width/2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white
                  ),
                    child: Center(
                        child: Text("Update",style: TextStyle(color: AppColors.MainBGColor,fontSize: 20),))),
              ),

            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    affairmationController.dispose();
    listBlessingController.dispose();
    bankAccountTimeController.dispose();
    super.dispose();
  }
}


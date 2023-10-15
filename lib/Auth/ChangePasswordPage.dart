import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../GetX/helper/snackbar_helper.dart';
import '../Utils/AppIcons.dart';
import '../Utils/Colors.dart';
import '../Utils/Constants.dart';
import '../main.dart';
import '../models/snackbar_message.dart';
import '../widgets/CustomBtn.dart';



class ChangePasswordPage extends StatefulWidget {
String oldPassword;
ChangePasswordPage({required this.oldPassword});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

TextEditingController oldPasswordController = TextEditingController();
TextEditingController newPasswordController = TextEditingController();

class _ChangePasswordPageState extends State<ChangePasswordPage> {

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final snackbarHelper = SnackbarHelper.instance..injectContext(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap:(){
            Navigator.pop(context);
          },
            child: Icon(Icons.arrow_back_ios,color: Colors.black,)),
        title: Padding(
          padding: EdgeInsets.only(left: screenWidth / 10),
          child: Image.asset(
            AppIcons.logo,
            height: screenHeight / 25,
            width: screenWidth / 2.2,
          ),
        ),
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: screenHeight / 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: AppConstants.language == "en"
                      ? EdgeInsets.only(top: 5.0, left: 20)
                      : EdgeInsets.only(top: 5.0, right: 20),
                  child: Text(
                    "Forget Password",
                    style: TextStyle(color: AppColors.MainColor, fontSize: 22),
                  ),
                ),
              ],
            ),
            Padding(
              padding: AppConstants.language == "en"
                  ? EdgeInsets.only(top: 5.0, left: 20)
                  : EdgeInsets.only(top: 5.0, right: 20),
              child: Text(
                "Enter Current And New Password To Change",
                style:  TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(
              height: screenHeight / 15,
            ),



            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: AppConstants.language == "en"
                      ? EdgeInsets.only(top: 5.0, left: 60)
                      : EdgeInsets.only(top: 5.0, right: 60),
                  child: Text(
                    "Old Password",
                  ),
                ),
              ],
            ),
            ///old password feild
            Container(
              width: screenWidth / 1.4,
              child: TextField(
                  style: TextStyle(
                    fontSize: 17.0,
                    color: Colors.blueAccent,
                  ),
                  controller: oldPasswordController,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(

                      contentPadding:
                      EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      prefixIcon: Icon(Icons.visibility,color: AppColors.MainColor,),
                      hintText: "Old Password",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.grey.withOpacity(0.1), width: 32.0),
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey.withOpacity(0.1), width: 32.0),
                          borderRadius: BorderRadius.circular(18.0)))),
            ),


            SizedBox(
              height: screenHeight / 60,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: AppConstants.language == "en"
                      ? EdgeInsets.only(top: 5.0, left: 60)
                      : EdgeInsets.only(top: 5.0, right: 60),
                  child: Text(
                    'New Password',
                  ),
                ),
              ],
            ),
            ///New password feild
            Container(
              width: screenWidth / 1.4,
              child: TextField(
                  style: TextStyle(
                    fontSize: 17.0,
                    color: Colors.blueAccent,
                  ),
                  controller: newPasswordController,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(

                      contentPadding:
                      EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      prefixIcon: Icon(Icons.visibility,color: AppColors.MainColor,),
                      hintText: "New Password",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.grey.withOpacity(0.1), width: 32.0),
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey.withOpacity(0.1), width: 32.0),
                          borderRadius: BorderRadius.circular(18.0)))),
            ),

            SizedBox(
              height: screenHeight / 15,
            ),
            InkWell(
              onTap: () async {

                setState(() {
                  isLoading = true;
                });

              },
              child:
              isLoading ?
              CircularProgressIndicator(color: AppColors.MainColor,)
                  :
              InkWell(
                onTap: (){
                  setState(() {
                    isLoading = true;
                  });
                  if(oldPasswordController.text.isNotEmpty && newPasswordController.text.isNotEmpty)
                    {
                      if(widget.oldPassword == oldPasswordController.text.toString().trim())
                        {
                          ///means user old password is correct
                          try{
                            final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
                            User? currentUser = firebaseAuth.currentUser;
                            currentUser?.updatePassword(newPasswordController.text.toString().trim()).then((value) {
                              FirebaseFirestore.instance.collection("user").doc(FirebaseAuth.instance.currentUser?.uid).update(
                                  {
                                    "password" : newPasswordController.text.toString().trim(),
                                  });
                              AsmDialogForSuccess(context, "Success", "Password Changed");
                              snackbarHelper.showSnackbar(snackbar: SnackbarMessage.success(
                                  message:"Success"));
                              Navigator.pop(context);
                            }).catchError((error){
                              snackbarHelper.showSnackbar(snackbar: SnackbarMessage.error(
                                  message: error.toString()));

                            });
                            print("try runss success");
                            setState(() {
                              isLoading = false;
                            });
                          }catch(e)
                  {
                    print("catch runsss");
                    snackbarHelper.showSnackbar(snackbar: SnackbarMessage.error(
                        message: "Error Try Again"));
                    setState(() {
                      isLoading = false;
                    });
                  }
                        }
                      else
                        {
                          snackbarHelper.showSnackbar(snackbar: SnackbarMessage.error(
                              message: "Old Password Is Not Correct"));
                          setState(() {
                            isLoading = false;
                          });
                        }
                    }
                  else
                    {
                      snackbarHelper.showSnackbar(snackbar: SnackbarMessage.error(
                          message: "Enter Current And New Password To Change"));
                      setState(() {
                        isLoading = false;
                      });
                    }
                  setState(() {
                    isLoading = false;
                  });
                },
                child: CustomBtn(
                  text: "Change",
                  textColor: Colors.white,
                  btnWidth: screenWidth / 1.4,
                  // borderColor: AppColors.textColorWhite,
                  borderRadiusValue: 10.0,
                  btnHeight: screenHeight / 14,
                  // bgColor: AppColors.MainColor,
                ),
              ),
            ),

            SizedBox(
              height: screenHeight / 80,
            ),
          ]),
        ),
      ),
    );
  }
}

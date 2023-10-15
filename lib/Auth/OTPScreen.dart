import 'dart:async';
import 'package:abundify/SplashScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../GetX/controllers/AuthController.dart';
import '../GetX/helper/material_dialog_content.dart';
import '../GetX/helper/material_dialog_helper.dart';
import '../GetX/helper/snackbar_helper.dart';
import '../Utils/AppIcons.dart';
import '../Utils/Colors.dart';
import '../Utils/Constants.dart';
import '../main.dart';
import '../models/snackbar_message.dart';
import '../widgets/CustomBtn.dart';
import 'NewPasswordScreen.dart';




class OTPScreen extends StatefulWidget {
  OTPScreen({
    required this.PhoneNumber,
    required this.isForSignup,
    required this.userEmail,
    required this.oldPassword,
  });

  String PhoneNumber;
  bool isForSignup;
  String userEmail;
  String oldPassword;

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final MaterialDialogHelper _dialogHelper = MaterialDialogHelper.instance();
  AuthController _authController = Get.put(AuthController());
  bool isRememberMe = true;

  String? _verificationCode;
  String? _verificationId;

  String? deviceToken;

  bool loading = false;
  final interval = const Duration(seconds: 1);

  final int timerMaxSeconds = 120;

  int currentSeconds = 0;

  String get timerText =>
      '${((timerMaxSeconds - currentSeconds) ~/ 60).toString().padLeft(2, '0')}: ${((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(2, '0')}';

  late Timer timer;

  startTimeout() {
    print("starttimer runs");
    var duration = interval;
    timer = Timer.periodic(duration, (timer) async {
      print("starttimer runs1111${timer.tick}");
      setState(() {
        print(timer.tick);
        currentSeconds = timer.tick;
        if (timer.tick >= timerMaxSeconds) timer.cancel();
      });
    });
  }

  @override
  void initState() {
    startTimeout();

    ///todo change it to      _verifyPhone("+966"+widget.PhoneNumber);
    print("widget.PhoneNumber");
    print(widget.PhoneNumber);
    print("widget.PhoneNumber");
    _verifyPhone(widget.PhoneNumber);
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
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
              height: screenHeight / 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding:  EdgeInsets.only(top: 5.0, left: 20),
                  child: Text(
                  "Enter Code",
                    style:  TextStyle(color: AppColors.MainColor, fontSize: 22),
                  ),
                ),
              ],
            ),
            Padding(
              padding:EdgeInsets.only(top: 5.0, left: 20),
              child: Text(
                "${"Login To Your Account By Entering Code"} ${widget.PhoneNumber}",
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(
              height: screenHeight / 20,
            ),
            Text(timerText),
            SizedBox(
              height: screenHeight / 20,
            ),
            OtpTextField(
              numberOfFields: 6,
              borderColor: Color(0xFF512DA8),
              //set to true to show as box or false to show as dash
              showFieldAsBox: true,

              //runs when a code is typed in
              onCodeChanged: (String code) {
                setState(() {
                  _verificationCode = code;
                  print("_verificationCode111");
                  print(_verificationCode);
                });
                //handle validation or checks here
              },
              //runs when every textfield is filled
              onSubmit: (String verificationCode) async {
                if (widget.isForSignup) {
                  ///means user is here for signup
                  setState(() {
                    loading = true;
                    _verificationCode = verificationCode;
                    print("_verificationCode222");
                    print(_verificationCode);
                  });
                  try {
                    await FirebaseAuth.instance
                        .signInWithCredential(PhoneAuthProvider.credential(
                            verificationId: _verificationId!,
                            smsCode: verificationCode!))
                        .then((value) async {
                      if (value.user != null) {
                        ///means user is registerd with phone
                        LogOutFirstUser(value.user);
                      }
                    });
                  } catch (e) {
                    setState(() {
                      loading = false;
                    });
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(e.toString())));
                  }
                } else {
                  ///means user is here to reset password
                  ///user is here to forget password;
                  setState(() {
                    loading = true;
                    _verificationCode = verificationCode;
                    print("_verificationCode222");
                    print(_verificationCode);
                  });
                  print("otp code is");
                  print(_verificationCode);
                  print("_verificationCode");
                  try {
                    await FirebaseAuth.instance
                        .signInWithCredential(PhoneAuthProvider.credential(
                        verificationId: _verificationId!,
                        smsCode: _verificationCode!))
                        .then((value) async {
                      if (value.user != null) {
                        ///means user is registerd with phone login him and change password
                        LogOutFirstUserForResetPassword(value.user);
                      }
                    });
                  } catch (e) {
                    setState(() {
                      loading = false;
                    });
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(e.toString())));
                  }
                }
              }, // end onSubmit
            ),
            SizedBox(
              height: screenHeight / 15,
            ),
            InkWell(
              onTap: () async {
                if (widget.isForSignup) {
                  ///means user is here to signup new account
                  setState(() {
                    loading = true;
                  });
                  try {
                    await FirebaseAuth.instance
                        .signInWithCredential(PhoneAuthProvider.credential(
                            verificationId: _verificationId!,
                            smsCode: _verificationCode!))
                        .then((value) async {
                      if (value.user != null) {
                        ///means user is registerd with phone so delete it
                        LogOutFirstUser(value.user);
                      }
                    });
                  } catch (e) {
                    setState(() {
                      loading = false;
                    });
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(e.toString())));
                  }
                } else {
                  ///user is here to forget password;
                  setState(() {
                    loading = true;
                  });
                  try {
                    await FirebaseAuth.instance
                        .signInWithCredential(PhoneAuthProvider.credential(
                            verificationId: _verificationId!,
                            smsCode: _verificationCode!))
                        .then((value) async {
                      if (value.user != null) {
                        ///means user is registerd with phone login him and change password
                        LogOutFirstUserForResetPassword(value.user);
                      }
                    });
                  } catch (e) {
                    setState(() {
                      loading = false;
                    });
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(e.toString())));
                  }
                }

                // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                //     bottomNavigationBar(4)), (Route<dynamic> route) => false);
              },
              child: CustomBtn(
                text: "Submit",
                textColor: Colors.white,
                btnWidth: screenWidth / 1.4,
                // borderColor: AppColors.textColorWhite,
                borderRadiusValue: 10.0,
                btnHeight: screenHeight / 14,
                // bgColor: AppColors.MainColor,
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

  _verifyPhone(String phone) async {
    print("12212221212211221");
    await FirebaseAuth.instance.verifyPhoneNumber(
        ///todo change number to phone
        // phoneNumber: phone,
        phoneNumber: "+923457197717",
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verficationID, int? resendToken) {
          print("otp send successfull");
          setState(() {
            print("verficationID");
            print(verficationID);
            _verificationId = verficationID;
            print("_verificationId");
            print(_verificationId);
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationId = verificationID;
          });
        },
        timeout: Duration(seconds: 120));
    print("12212221212211221 second");
  }

  LogOutFirstUser(User? user) async {
    print("111111111aaaaa");
    try {
      FirebaseAuth.instance.currentUser?.delete();
      if (widget.isForSignup) {
        _signup();
      } else {
        LogOutFirstUserForResetPassword(user!);
      }
    } catch (e) {
      setState(() {
        loading = false;
      });
      AsmDialogg(context, "Error!", e.toString());
    }
  }

  LogOutFirstUserForResetPassword(User? user) async {
    try {
      print("333333cccccc");
      FirebaseAuth.instance.currentUser?.delete();
      UserCredential result2;
      print("widget.email");
      print(widget.userEmail);
      print("widget.email");
      print(widget.oldPassword);
      print("widget.oldPass");
      result2 = await _authController.LoginEmailPassword(
          email: widget.userEmail.toString().trim(),
          password: widget.oldPassword.toString().trim());
      print("result2");
      print(result2);
      print("result2");
      Future.delayed(const Duration(milliseconds: 1000), () {
        print("Future .delay function runsss");
        // setState(() {
        print("dddddd777777777");
        user = result2.user!;
        print("runnsss3493294583295839845394853985");
        // });
        if (user != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewPasswordScreen(
                previousPassword: widget.oldPassword,
                user: user!,
              ),
            ),
          );
        } else {
          setState(() {
            user = result2.user!;
          });
          if (user != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewPasswordScreen(
                  previousPassword: widget.oldPassword,
                  user: user!,
                ),
              ),
            );
          } else {
            print("still not getting user ");
          }
        }
      });

      // if(result != null)
      //   {
      //     User user = result.user;
      //     if(user != null){
      //       print("User Loginn Success,No We Are Changing User Password");
      //
      //       _changePassword(widget.oldPassword, widget.newPassword,user);
      //     }else{
      //
      //       print("delaying for 15 to login");
      //       Future.delayed(const Duration(seconds: 15), () async {
      //
      //         User user = result.user;
      //
      //         if(user != null){
      //           print("User Loginn Success,11111");
      //
      //           _changePassword(widget.oldPassword, widget.newPassword,user);
      //         }
      //         else{
      //           print("delaying for 10 to login");
      //
      //           Future.delayed(const Duration(seconds: 10), () async {
      //             User user = result.user;
      //
      //             if(user != null){
      //               print("User Loginn Success,222222");
      //
      //               _changePassword(widget.oldPassword, widget.newPassword,user);
      //             }
      //             else{
      //               AwesomeAlertDialog(context, "Error", "Network Error,Slow Internet Connection");
      //
      //             }
      //           });
      //
      //         }
      //       });
      //
      //       print("Error 3333333333333");
      //     }
      //
      //
      //   }
      // else{
      //
      // }

    } catch (e) {
      setState(() {
        loading = false;
      });
      AsmDialogg(context, "Error!", e.toString());
    }
  }

  ///SignUp Method
  void _signup() async {
    print("signup runss11111");
    _dialogHelper
      ..injectContext(context)
      ..showProgressDialog("Submission In Progress");
    final message = await _authController.signUp();
    print("signup runss22222");
    _dialogHelper.dismissProgress();
    if (message == null) {
      _dialogHelper.showMaterialDialogWithContent(
          MaterialDialogContent.networkError(), () => _signup());
      return;
    }
    print("signup runss3333");

    final snackbar = SnackbarHelper.instance..injectContext(context);
    if (message.isNotEmpty) {
      snackbar.showSnackbar(snackbar: SnackbarMessage.error(message: message));
      return;
    }
    getUser();
    snackbar.showSnackbar(
        snackbar:
            SnackbarMessage.success(message: "Sign Up"));
    Future.delayed(const Duration(milliseconds: 700))
        .then((_) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) => SplashScreen())));
  }

  Future<void> getUser() async {
    try{
      var collection = FirebaseFirestore.instance.collection('user');
      var querySnapshot = await collection.doc(FirebaseAuth.instance.currentUser?.uid.toString()).get();
      Map<String, dynamic>? data = querySnapshot.data();
      setState(() {
        AppConstants.currentUserName = data!["first_name"];
        AppConstants.currentUserProfile = data['image'];
        AppConstants.currentUserRating = data['rating'].toString();
        AppConstants.memberShip = data['memberShip'];
        AppConstants.isOnline = data['isOnline'];
        AppConstants.isNane = data['isNane'];
        print("AppConstants.currentUserName : ${AppConstants.currentUserName}");
        print("AppConstants.currentUserProfile : ${AppConstants.currentUserProfile}");
        print("AppConstants.currentUserRating : ${AppConstants.currentUserRating}");
      });
      getUserChild();
    }catch(e){
      print("error in reading user info");
    }

  }


  Future<void> getUserChild() async {

    try{
      print("getChild runsss2222");

      var collection = FirebaseFirestore.instance.collection('user').doc(FirebaseAuth.instance.currentUser?.uid.toString())
          .collection("child");
      var querySnapshot = await collection.doc("1").get();
      Map<String, dynamic>? data = querySnapshot.data();
      setState(() {
        AppConstants.childName = data!["childName"];
        AppConstants.childAge = data['childAge'];
        AppConstants.childImage = data['childImage'];
        AppConstants.childClass = data['childClass'];
        AppConstants.fevGame = data['fevGame'];
        AppConstants.fevFood = data['fevFood'];
        AppConstants.fevFood = data['fevFood'];
      });
    }catch(e){
    }

  }
}

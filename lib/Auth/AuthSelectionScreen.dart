import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';

import '../GetX/controllers/AuthController.dart';
import '../GetX/helper/facbookloginHelperClass.dart';
import '../GetX/helper/material_dialog_content.dart';
import '../GetX/helper/material_dialog_helper.dart';
import '../GetX/helper/snackbar_helper.dart';
import '../SplashScreen.dart';
import '../Utils/AppIcons.dart';
import '../Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../models/snackbar_message.dart';
import '../widgets/CustomBtn.dart';
import 'LoginScreen.dart';
import 'SignUpPage.dart';



class AuthSelectionScreen extends StatefulWidget {

  const AuthSelectionScreen({Key? key}) : super(key: key);

  @override
  State<AuthSelectionScreen> createState() => _AuthSelectionScreenState();
}

class _AuthSelectionScreenState extends State<AuthSelectionScreen> {


  bool isLoading = false;
 final MaterialDialogHelper _dialogHelper = MaterialDialogHelper.instance();
  AuthController _authController = Get.put(AuthController());
  final FacebookLoginHelper facebookLoginHelper = FacebookLoginHelper();



  @override
  Widget build(BuildContext context) {

    final snackbarHelper = SnackbarHelper.instance..injectContext(context);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: screenHeight/8,),

              Image.asset(AppIcons.logo,height: screenHeight/6,),
              SizedBox(height: screenHeight/10,),

              InkWell(
                onTap: (){

                  Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                },
                child: CustomBtn(
                  text: "Login",
                  textColor: AppColors.MainColor,
                  btnWidth: screenWidth/1.4,
                  borderColor: AppColors.MainColor,
                  borderRadiusValue: 10.0,
                  btnHeight: screenHeight/14,
                  bgColor: AppColors.textColorWhite,
                ),
              ),
              SizedBox(height: screenHeight/30,),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
                },
                child: CustomBtn(
                  text: "Sign Up",
                  textColor: Colors.white,
                  btnWidth: screenWidth/1.4,
                  // borderColor: AppColors.textColorWhite,
                  borderRadiusValue: 10.0,
                  btnHeight: screenHeight/14,
                  // bgColor: AppColors.MainColor,
                ),
              ),

              SizedBox(height: screenHeight/20,),

              Text(
                "Or Using",
                style: TextStyle(
                  color: AppColors.mainBlackColor,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              // SizedBox(height: screenHeight/30,),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     InkWell(
              //         onTap: (){
              //           if (Platform.isIOS) {
              //             snackbarHelper.showSnackbar(snackbar: SnackbarMessage.error(message: "Not Available"));
              //             return;
              //           }else{
              //             _googleLogin();
              //           }
              //         },
              //         child: Image.asset(AppIcons.googleIcon,height: screenHeight/15,width: screenWidth/6,)),
              //     SizedBox(width: screenWidth/10,),
              //     InkWell(
              //         onTap: (){
              //           if (Platform.isAndroid) {
              //             snackbarHelper.showSnackbar(snackbar: SnackbarMessage.error(message:  "Not Available"));
              //             return;
              //           }
              //           else
              //           {
              //             _appleLogin();
              //           }
              //
              //         },
              //         child: Image.asset(AppIcons.appleIcon,height: screenHeight/15,width: screenWidth/6,)),
              //   ],
              // ),
              SizedBox(height: screenHeight/30,),

              ///apple login
              Platform.isAndroid?
              SizedBox()
                  :
              InkWell(
                onTap: (){
                  if (Platform.isAndroid) {
                    snackbarHelper.showSnackbar(snackbar: SnackbarMessage.error(message:  "Not Available"));
                    return;
                  }
                  else
                  {
                    _appleLogin();
                  }
                },
                child: Container(
                  width:  screenWidth/1.4,
                  height: screenHeight/14,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(AppIcons.appleIconWhite,height: screenHeight/25,width: screenWidth/8,),
                      Text("Sign In With Apple",style: TextStyle(color: Colors.white),),
                      SizedBox(width: 15.0,),

                    ],
                  ),
                ),
              ),

              SizedBox(height: screenHeight/40,),

              ///Facebook Login
              InkWell(
                onTap: () async {
                  final User? user = await facebookLoginHelper.signInWithFacebook();
                  if (user != null) {
                    // Navigate to the next screen or perform other actions upon successful login.
                    // You can access user information using user.displayName, user.email, etc.
                    print('Logged in as ${user.displayName}');
                  }
                },
                child: Container(
                  width:  screenWidth/1.4,
                  height: screenHeight/14,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(AppIcons.fbIcon,height: screenHeight/20,width: screenWidth/6,),
                      Text("FaceBook",style: TextStyle(color: Colors.white,fontSize: 19),),
                      SizedBox(width: 15.0,),

                    ],
                  ),
                ),
              ),

              SizedBox(height: screenHeight/40,),

              ///google login
              Platform.isIOS?
                  SizedBox()
              :
              InkWell(
                onTap: (){
                  if (Platform.isIOS) {
                    snackbarHelper.showSnackbar(snackbar: SnackbarMessage.error(message: "Not Available"));
                    return;
                  }else{
                    _googleLogin();
                  }
                },
                child: Container(
                  width:  screenWidth/1.4,
                  height: screenHeight/14,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(AppIcons.googleIcon,height: screenHeight/25,width: screenWidth/8,),
                      Text("Sign In With Google",style: TextStyle(color: Colors.white),),
                      SizedBox(width: 15.0,),

                    ],
                  ),
                ),
              ),



              SizedBox(height: screenHeight/30,),

            ],
          ),
        ),
      ),
    );
  }


  void _googleLogin() async {
    _dialogHelper
      ..injectContext(context)
      ..showProgressDialog('Loading....');
    final message = await _authController.signInWithGoogle();
    _dialogHelper.dismissProgress();
    if (message == null) {
      _dialogHelper.showMaterialDialogWithContent(MaterialDialogContent.networkError(), () => _googleLogin());
      return;
    }
    final snackbarHelper = SnackbarHelper.instance..injectContext(context);
    if (message.isEmpty) {
      snackbarHelper.showSnackbar(snackbar: SnackbarMessage.error(message: message));
      return;
    }
    snackbarHelper.showSnackbar(snackbar: SnackbarMessage.success(message: 'Login Successful...'));
    Future.delayed(const Duration(milliseconds: 700))
        .then((_) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) => SplashScreen())));
  }

  void _appleLogin() async {
    _dialogHelper
      ..injectContext(context)
      ..showProgressDialog('Loading....');
    final message = await _authController.signInWithApple();
    _dialogHelper.dismissProgress();
    if (message == null) {
      _dialogHelper.showMaterialDialogWithContent(MaterialDialogContent.networkError(), () => _appleLogin());
      return;
    }
    final snackbarHelper = SnackbarHelper.instance..injectContext(context);
    if (message.isEmpty) {
      snackbarHelper.showSnackbar(snackbar: SnackbarMessage.error(message: message));
      return;
    }
    snackbarHelper.showSnackbar(snackbar: SnackbarMessage.success(message: 'Login Successful...'));
    Future.delayed(const Duration(milliseconds: 700))
        .then((_) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) => SplashScreen())));
  }


}

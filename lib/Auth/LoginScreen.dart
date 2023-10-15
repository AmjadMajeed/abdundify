import 'package:abundify/SplashScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../GetX/controllers/AuthController.dart';
import '../GetX/helper/material_dialog_content.dart';
import '../GetX/helper/material_dialog_helper.dart';
import '../GetX/helper/snackbar_helper.dart';
import '../Utils/AppIcons.dart';
import '../Utils/Colors.dart';
import '../Utils/Constants.dart';
import '../models/snackbar_message.dart';
import '../widgets/CustomBtn.dart';
import 'ResetPasswordScreen.dart';
import 'SignUpPage.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool isLoading = false;
  var _formKey = GlobalKey<FormState>();
  static String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  final MaterialDialogHelper _dialogHelper = MaterialDialogHelper.instance();
  RegExp regExp = new RegExp(p);
  AuthController _authController = Get.put(AuthController());

  final _phoneNumberFocusNode = FocusNode();
  bool _phoneNumberValid = true;

  @override
  void dispose() {
    _phoneNumberFocusNode.dispose();
    super.dispose();
  }


 bool isRememberMe = true;
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
          child:

          Form(
            key: _formKey,
            child: Obx(()
            {
              return Container(
                child: Column(
                    children: [
                      SizedBox(height: screenHeight/10,),

                      Image.asset(AppIcons.logo,height: screenHeight/6,),
                      SizedBox(height: screenHeight/15,),

                      ///Phone feild
                      Container(
                        width: screenWidth/1.4,
                        child: TextFormField(
                            focusNode: _phoneNumberFocusNode,
                            style: TextStyle(
                              fontSize: 17.0,
                              color: Colors.blueAccent,
                            ),
                            controller: _authController.phoneNumber.value,
                            validator: (name){
                              if(name!.isEmpty)  {
                                return "Please Enter Your Phone";
                              }
                            },
                            keyboardType: TextInputType.phone,

                            textAlign: TextAlign.right,
                            onChanged: (value) {
                              setState(() {
                                _phoneNumberValid = PhoneNumberValidator.validate(value);
                              });
                            },
                            decoration: InputDecoration(

                                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                prefixIcon: Icon(Icons.phone_android,color: AppColors.MainColor,),
                                hintText: "Phone",

                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey.withOpacity(0.1), width: 32.0),
                                    borderRadius: BorderRadius.circular(18.0)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey.withOpacity(0.1), width: 32.0),
                                    borderRadius: BorderRadius.circular(18.0)))),
                      ),
                      !_phoneNumberValid
                          ? Text(
                        '${"Please Enter Phone In Correct Format"} (e.g.  3XXXXXXXXX)',
                        style: TextStyle(color: Colors.red),
                      )
                          : SizedBox.shrink(),

                      SizedBox(height: screenHeight/30,),
                      ///Paasword feild
                      Container(
                        width: screenWidth/1.4,
                        child: TextFormField(
                            style: TextStyle(
                              fontSize: 17.0,
                              color: Colors.blueAccent,
                            ),
                            textAlign: TextAlign.right,
                            controller: _authController.password.value,
                            validator: (password){
                              if(password!.isEmpty)  {
                                return "Please Enter Your Password";
                              }
                            },
                            decoration: InputDecoration(

                                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                prefixIcon: Icon(Icons.lock_open,color: AppColors.MainColor,),
                                hintText: "Password",

                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey.withOpacity(0.1), width: 32.0),
                                    borderRadius: BorderRadius.circular(18.0)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey.withOpacity(0.1), width: 32.0),
                                    borderRadius: BorderRadius.circular(18.0)))),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ResetPasswordScreen()));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0,right: 60,left: 60),
                              child:
                              Text("Forget Password",
                              ),
                            ),
                          ],
                        ),
                      ),


                      SizedBox(height: screenHeight/25,),
                      ///login Button;
                      InkWell(
                        onTap: () async {
                          if(_formKey.currentState!.validate()){
                            print("_authController.phoneNumber.value.obs");
                            print(_authController.phoneNumber.value.text.toString().trim());
                            print("_authController.phoneNumber.value.obs");
                            String phoneNumber = _authController.phoneNumber.value.text.toString().trim();
                            // phoneNumber = phoneNumber.substring(1);
                            print("phoneNumber");
                            print(phoneNumber);
                            print("phoneNumber");
                            phoneNumber = "+1"+phoneNumber;
                            setState(() {
                              isLoading = true;
                            });
                            ///check if user is registerd
                            var UserExits = await _authController.userExistsCheckMethod(
                                phoneNumber);
                            ///means user phone is registerd
                            if(UserExits[0])
                            {
                              _login(UserExits[1]);
                            }
                            ///means user phone is not registerd
                            else
                            {
                              snackbarHelper.showSnackbar(snackbar: SnackbarMessage.error(
                                  message: "Phone Is Not Registered"));
                              setState(() {
                                isLoading = false;
                              });
                            }
                          }
                        },
                        child:
                        isLoading ?
                        CircularProgressIndicator(color: AppColors.MainColor,)
                            : CustomBtn(
                          text: "Login",
                          textColor: Colors.white,
                          btnWidth: screenWidth/1.4,
                          // borderColor: AppColors.textColorWhite,
                          borderRadiusValue: 10.0,
                          btnHeight: screenHeight/14,
                          // bgColor: AppColors.MainColor,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                            EdgeInsets.only(top: 5.0,left: 60,),
                            child: Text("Remember Me"),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0,),
                            child: Checkbox(
                                value: isRememberMe,
                                activeColor: AppColors.MainColor,
                                onChanged: (value){
                              setState(() {
                                isRememberMe = value!;
                              });
                            }),
                          ),

                        ],
                      ),

                      SizedBox(height: screenHeight/20,),

                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                             "Don't Have An Account",
                              style: TextStyle(color: AppColors.mainBlackColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,),
                            ),
                            SizedBox(width: 10,),
                            Text(
                              "Register Now",
                              style: TextStyle(color: AppColors.MainColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,),
                            ),
                          ],
                        ),
                      ),
                    ]
                ),
              );
            }
            ),
          ),


        ),
      ),
    );
  }


 void _login(String email) async {
   print("email");
   print(email);
   print("email");
   _dialogHelper
     ..injectContext(context)
     ..showProgressDialog('Loading....');
   final message = await _authController.login(email);
   _dialogHelper.dismissProgress();
   if (message == null) {
     print("11111111110000000000login");
     _dialogHelper.showMaterialDialogWithContent(MaterialDialogContent.networkError(), () => _login(email));
     return;
   }
   final snackbarHelper = SnackbarHelper.instance..injectContext(context);
   if (message.isNotEmpty) {
     setState(() {
       isLoading = false;
     });
     snackbarHelper.showSnackbar(snackbar: SnackbarMessage.error(message: message));
     return;
   }
   snackbarHelper.showSnackbar(snackbar: SnackbarMessage.success(message: 'Logged In SuccessFully'));
   print("navigating to btoommmm");
   getUser();
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

    }catch(e){
      print("e.toString()");
      print(e.toString());
      print("e.toString()");
      print("error in reading user info");
    }

  }



}

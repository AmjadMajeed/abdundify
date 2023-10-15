import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../GetX/controllers/AuthController.dart';
import '../GetX/helper/material_dialog_helper.dart';
import '../GetX/helper/snackbar_helper.dart';
import '../Utils/AppIcons.dart';
import '../Utils/Colors.dart';
import '../main.dart';
import '../models/snackbar_message.dart';
import '../widgets/CustomBtn.dart';
import 'LoginScreen.dart';
import 'OTPScreen.dart';



class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool agreeTermsAndConditions = true;
  // bool isUser = true;
  static String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  final MaterialDialogHelper _dialogHelper = MaterialDialogHelper.instance();
  RegExp regExp = new RegExp(p);
  bool isLoading = false;
  var _formKey = GlobalKey<FormState>();
  AuthController _authController = Get.put(AuthController());

  final _phoneNumberFocusNode = FocusNode();
  bool _phoneNumberValid = true;

  @override
  void dispose() {
    _phoneNumberFocusNode.dispose();
    super.dispose();
  }



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
              return   Container(
                child: Column(
                    children: [
                      SizedBox(height: screenHeight/15,),

                      Image.asset(AppIcons.logo,height: screenHeight/6,),
                      SizedBox(height: screenHeight/100,),


                      ///email feild
                      Container(
                        width: screenWidth/1.4,
                        child: TextFormField(
                            style: TextStyle(
                              fontSize: 17.0,
                              color: Colors.blueAccent,
                            ),
                            controller: _authController.email.value,
                            validator: (name){
                              if(name!.isEmpty)  {
                                return "Please Enter Your Email";
                              }
                            },
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(

                                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                suffixIcon: Icon(Icons.email,color: AppColors.MainColor),
                                ///todo
                                hintText: "Your Email",
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.1), width: 32.0),
                                  borderRadius: BorderRadius.circular(18.0),

                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey.withOpacity(0.1), width: 32.0),
                                    borderRadius: BorderRadius.circular(18.0)))),
                      ),

                      SizedBox(height: screenHeight/50,),

                      ///Name feild
                      Container(
                        width: screenWidth/1.4,
                        child: TextFormField(
                            style: TextStyle(
                              fontSize: 17.0,
                              color: Colors.blueAccent,
                            ),
                            controller: _authController.firstName.value,
                            validator: (name){
                              if(name!.isEmpty)  {
                                return "Please Enter Your Name";
                              }
                            },
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(

                                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                suffixIcon: Icon(Icons.person,color: AppColors.MainColor),
                                hintText: "Name",

                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.1), width: 32.0),
                                  borderRadius: BorderRadius.circular(18.0),

                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey.withOpacity(0.1), width: 32.0),
                                    borderRadius: BorderRadius.circular(18.0)))),
                      ),

                      SizedBox(height: screenHeight/50,),
                      ///Paasword feild
                      Container(
                        width: screenWidth/1.4,
                        child: TextFormField(
                            style: TextStyle(
                              fontSize: 17.0,
                              color: Colors.blueAccent,
                            ),
                            controller: _authController.password.value,
                            validator: (name){
                              if(name!.isEmpty)  {
                                return "Please Enter Your Password";
                              }
                            },
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(

                                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                suffixIcon: Icon(Icons.lock_open,color: AppColors.MainColor),
                                hintText: "Password",

                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey.withOpacity(0.1), width: 32.0),
                                    borderRadius: BorderRadius.circular(18.0)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey.withOpacity(0.1), width: 32.0),
                                    borderRadius: BorderRadius.circular(18.0)))),
                      ),

                      SizedBox(height: screenHeight/50,),
                      ///Confirm Paasword feild
                      Container(
                        width: screenWidth/1.4,
                        child: TextFormField(
                            style: TextStyle(
                              fontSize: 17.0,
                              color: Colors.blueAccent,
                            ),
                            controller: _authController.cPassword.value,
                            validator: (name){
                              if(name!.isEmpty)  {
                                return "Please Enter Your Password";
                              }
                            },
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(

                                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                suffixIcon: Icon(Icons.lock_open,color: AppColors.MainColor),
                                hintText: "Confirm Password",

                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey.withOpacity(0.1), width: 32.0),
                                    borderRadius: BorderRadius.circular(18.0)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey.withOpacity(0.1), width: 32.0),
                                    borderRadius: BorderRadius.circular(18.0)))),
                      ),

                      SizedBox(height: screenHeight/50,),
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

                            textAlign: TextAlign.left,
                            onChanged: (value) {
                              setState(() {
                                _phoneNumberValid = PhoneNumberValidator.validate(value);
                              });
                            },
                            decoration: InputDecoration(

                                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                suffixIcon: Icon(Icons.phone_android,color: AppColors.MainColor,),
                                hintText: "Phone",

                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey.withOpacity(0.1), width: 32.0),
                                    borderRadius: BorderRadius.circular(18.0)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey.withOpacity(0.1), width: 32.0),
                                    borderRadius: BorderRadius.circular(18.0)))),
                      ),
                      !_phoneNumberValid
                          ? const Text(
                        "Please Enter Phone In Correct Format (e.g. 3XXXXXXXXX)",
                        style: TextStyle(color: Colors.red),
                      )
                          : SizedBox.shrink(),
                      SizedBox(height: screenHeight/50,),


                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(

                            padding:
                            EdgeInsets.only(top: 5.0,left: 50),
                            child: Checkbox(
                                value: agreeTermsAndConditions,
                                activeColor: AppColors.MainColor,
                                onChanged: (value){
                                  setState(() {
                                    agreeTermsAndConditions = value!;
                                  });
                                }),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5.0,),
                            child:
                            Text(
                              "I Agree To Terms And Condition",
                            ),
                          ),


                        ],
                      ),
                      SizedBox(height: screenHeight/25,),
                      InkWell(
                        onTap: () async {
                          ///check if user agree with terms and condtions;
                          if(agreeTermsAndConditions)
                            {
                              if(_formKey.currentState!.validate()){
                                if(_authController.password.value.text.toString().trim()
                                    == _authController.cPassword.value.text.toString().trim()){

                                  //check if phone is valid or not
                                  if(_phoneNumberValid)
                                  {
                                    String phoneNumber = _authController.phoneNumber.value.text.toString().trim();
                                    // phoneNumber = phoneNumber.substring(1);
                                    print("phoneNumber");
                                    print(phoneNumber);
                                    print("phoneNumber");
                                    phoneNumber = "+1"+phoneNumber;
                                    //check if phone already register of not
                                    setState(() {
                                      isLoading = true;
                                    });
                                    ///check if user is registerd
                                    var UserExits = await _authController.userExistsCheckMethod(
                                        phoneNumber);
                                    ///means user phone is registerd
                                    if(UserExits[0])
                                    {
                                      //means user phone is already registed
                                      snackbarHelper.showSnackbar(snackbar: SnackbarMessage.error(
                                          message: "Phone Is Already Registered"));
                                      setState(() {
                                        isLoading = false;
                                      });
                                    }
                                    ///means user phone is not registerd so register him with otp
                                    else
                                    {
                                      setState(() {
                                        isLoading = false;
                                      });
                                      //send otp and navigate user to otp page;
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                          OTPScreen(PhoneNumber: phoneNumber,
                                            isForSignup: true,
                                            userEmail: "",
                                            oldPassword: "",)));
                                    }
                                    print("phone is valid");
                                    //method to signUp User;
                                    // _signup();
                                  }
                                  else
                                  {
                                    ///means phone is not valide formate
                                    AsmDialogg(context, "Error",
                                      '${"Please Enter Phone In Correct Format"} (e.g. 05XXXXXXXX)',);
                                  }

                                }
                                else{
                                  snackbarHelper.showSnackbar(snackbar: SnackbarMessage.error(
                                      message: "Password And CPassword Is Not Same"));
                                  AwesomeDialog(context: context,title: "Error",
                                      desc:"Password And CPassword Is Not Same" );
                                  print("password and confrim password is not matched");
                                }
                              }
                            }
                          else{
                            ///means user havent check terms yet
                            snackbarHelper.showSnackbar(snackbar: SnackbarMessage.error(
                                message: "Please Agree Terms And Conditions First"));
                          }

                          },
                        child:
                        isLoading?
                        CircularProgressIndicator(color: AppColors.MainColor,)
                            : CustomBtn(
                          text: "Sign Up",
                          textColor: Colors.white,
                          btnWidth: screenWidth/1.4,
                          // borderColor: AppColors.textColorWhite,
                          borderRadiusValue: 10.0,
                          btnHeight: screenHeight/14,
                          // bgColor: AppColors.MainColor,
                        ),
                      ),

                      SizedBox(height: screenHeight/80,),
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
                      SizedBox(height: screenHeight/10,),
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






}

class PhoneNumberValidator {
  static bool validate(String value) {
    // RegExp regExp = new RegExp(r'^3\d{8}$');
    // if (value.isEmpty) {
    //   return false;
    // } else if (!regExp.hasMatch(value)) {
    //   return false;
    // }
    // return true;
    if (value.length != 10)
      return false;
    else
      return true;
  }
}

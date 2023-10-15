import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../GetX/controllers/AuthController.dart';
import '../GetX/helper/snackbar_helper.dart';
import '../Utils/AppIcons.dart';
import '../Utils/Colors.dart';
import '../Utils/Constants.dart';
import '../main.dart';
import '../models/snackbar_message.dart';
import '../widgets/CustomBtn.dart';
import 'OTPScreen.dart';
import 'SignUpPage.dart';



class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

TextEditingController PhoneController = TextEditingController();

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  bool isRememberMe = true;
  bool isWithPhone = true;


  AuthController _authController = Get.put(AuthController());

  final _phoneNumberFocusNode = FocusNode();
  bool _phoneNumberValid = true;
  bool isLoading = false;

  @override
  void dispose() {
    _phoneNumberFocusNode.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final snackbarHelper = SnackbarHelper.instance..injectContext(context);

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
              height: screenHeight / 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding:  EdgeInsets.only(top: 5.0, left: 20),
                  child: Text(
                    "Forget Password",
                    style:  TextStyle(color: AppColors.MainColor, fontSize: 22),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 5.0, left: 20),
              child: Text(
               "Enter Email / Phone To Reset Password",
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(
              height: screenHeight / 15,
            ),


            isWithPhone ?
                SizedBox()
            :
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding:  EdgeInsets.only(top: 5.0, left: 60),

                  child: Text(
                    "Email",
                  ),
                ),
              ],
            ),

            isWithPhone ?
            SizedBox()
                :
            ///email feild
            Container(
              width: screenWidth / 1.4,
              child: TextField(
                  style: TextStyle(
                    fontSize: 17.0,
                    color: Colors.blueAccent,
                  ),
                  controller: _authController.email.value,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(

                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      prefixIcon: Icon(Icons.email,color: AppColors.MainColor,),
                      hintText: "ABC@gmail.com",
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


            !isWithPhone ?
                SizedBox()
            :
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 5.0, left: 60),
                  child: Text(
                    "Phone",

                  ),
                ),
              ],
            ),



            !isWithPhone ?
                SizedBox()
            :
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
                      hintText: "3XXXXXXXXX",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.withOpacity(0.1), width: 32.0),
                          borderRadius: BorderRadius.circular(18.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.withOpacity(0.1), width: 32.0),
                          borderRadius: BorderRadius.circular(18.0)))),
            ),
            !_phoneNumberValid
                ? Text(
              '${"Please Enter Phone In Correct Format"} (e.g. 3XXXXXXXXX)',
              style: TextStyle(color: Colors.red),
            )
                : SizedBox.shrink(),

            SizedBox(
              height: screenHeight / 15,
            ),
            InkWell(
              onTap: () async {

                setState(() {
                  isLoading = true;
                });
                if(isWithPhone)
                  {
                    ///todo reset password with phone;
                    //check if phone is in correct formate
                    if(_phoneNumberValid && _authController.phoneNumber.value.text.length == 10)
                    {
                      String phoneNumber = _authController.phoneNumber.value.text.toString().trim();
                      // phoneNumber = phoneNumber.substring(1);
                      // print("phoneNumber");
                      // print(phoneNumber);
                      // print("phoneNumber");
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
                        setState(() {
                          isLoading = false;
                        });
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>
                            OTPScreen(PhoneNumber: phoneNumber,
                              isForSignup: false,
                            userEmail: UserExits[1],
                            oldPassword: UserExits[2],)));

                      }
                      ///means user phone is not registerd so register him with otp
                      else
                      {
                        //means user phone is already registed
                        snackbarHelper.showSnackbar(snackbar: SnackbarMessage.error(
                            message: "Phone Is Not Registered"));
                        setState(() {
                          isLoading = false;
                        });
                      }
                    }
                    else
                      {
                        setState(() {
                          isLoading = false;
                        });
                        ///means phone is not valide formate
                        AsmDialogg(context, "Error",
                          '${"Please Enter Phone In Correct Format"} (e.g. 05XXXXXXXX)',);
                      }

                  }
                else
                  {
                    ///todo reset password with email;
                  }


              },
              child:
              isLoading ?
                  CircularProgressIndicator(color: AppColors.MainColor,)
              :
              CustomBtn(
                text: "Sign Up",
                textColor: Colors.white,
                btnWidth: screenWidth / 1.4,
                // borderColor: AppColors.textColorWhite,
                borderRadiusValue: 10.0,
                btnHeight: screenHeight / 14,
                // bgColor: AppColors.MainColor,
              ),
            ),

            isWithPhone?
            ///resetPasswordWithEmail
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: (){
                    setState(() {
                      isWithPhone = !isWithPhone;
                    });
                  },
                  child: Padding(
                    padding: AppConstants.language == "en"
                        ? EdgeInsets.only(top: 5.0, left: 60)
                        : EdgeInsets.only(top: 5.0, right: 60),
                    child: Text(
                      "Reset Password With Email",
                    ),
                  ),
                ),
              ],
            )
                :
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: (){
                    setState(() {
                      isWithPhone = !isWithPhone;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 5.0, left: 60),
                    child: Text(
                      "Reset Password With Phone",

                    ),
                  ),
                ),
              ],
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

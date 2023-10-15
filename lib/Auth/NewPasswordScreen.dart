import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../GetX/controllers/AuthController.dart';
import '../GetX/helper/snackbar_helper.dart';
import '../Utils/AppIcons.dart';
import '../Utils/Colors.dart';
import '../Utils/Constants.dart';
import '../widgets/CustomBtn.dart';
import 'LoginScreen.dart';

class NewPasswordScreen extends StatefulWidget {
  String previousPassword;
  User user;
   NewPasswordScreen({required this.previousPassword,required this.user});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}
bool isLoading = false;
TextEditingController PhoneController = TextEditingController();

class _NewPasswordScreenState extends State<NewPasswordScreen> {

  AuthController _authController = Get.put(AuthController());
TextEditingController newPasswordController = TextEditingController();
TextEditingController ConfirmPasswordController = TextEditingController();

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
              padding: EdgeInsets.only(top: 5.0, left: 20),
              child: Text(
                "Enter Email Phone To Reset Password",
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(
              height: screenHeight / 15,
            ),



            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding:EdgeInsets.only(top: 5.0, left: 60),
                  child: Text(
                    "New Password",
                  ),
                ),
              ],
            ),

            ///Password feild
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
                  padding: EdgeInsets.only(top: 5.0, left: 60),
                  child: Text(
                    "Confirm Password",
                  ),
                ),
              ],
            ),

            ///Confirm Password feild
            Container(
              width: screenWidth / 1.4,
              child: TextField(
                  style: TextStyle(
                    fontSize: 17.0,
                    color: Colors.blueAccent,
                  ),
                  controller: ConfirmPasswordController,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(

                      contentPadding:
                      EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
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

            SizedBox(
              height: screenHeight / 15,
            ),
            InkWell(
              onTap: () async {
                // showAlertDialog(context);
                // print("MediaQ");
                setState(() {
                  isLoading = true;
                });
                ///todo uncomment
                print(MediaQuery.of(context).size.height.toString());

                if(newPasswordController.text.isNotEmpty
                    && ConfirmPasswordController.text.isNotEmpty)
                {
                  if(newPasswordController.text.toString().trim() ==
                      ConfirmPasswordController.text.toString().trim())
                  {
                    // String currentPassword, String newPassword,User userr
                    _changeUserPasswordMethod(widget.previousPassword,
                        newPasswordController.text.toString().trim(),widget.user);

                  }
                  else
                  {
                    setState(() {
                      isLoading = false;
                    });
                    /// Password And Confirm Password Should be Same
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("يجب أن تكون كلمة المرور وتأكيد كلمة المرور متطابقتين")));
                  }
                }
                else
                {
                  setState(() {
                    isLoading = false;
                  });
                  ///Error", "Please Fill All Data
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("الرجاء تعبئة كافة البيانات")));

                }

              },
              child:

              isLoading ?
              CircularProgressIndicator(color: AppColors.MainColor,)
                  :
              CustomBtn(
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

  ///
  /// Reset User Password
  ///
  void _changeUserPasswordMethod(String currentPassword, String newPassword,User user) async {
    print("change password method runss");
    print("2121211");
    print("user email is:${user.email}");
    print("2121211");

    try{
      final user = await FirebaseAuth.instance.currentUser;
      final credentials = EmailAuthProvider.credential(
          email: user?.email??"", password: currentPassword);

      user?.reauthenticateWithCredential(credentials).then((value) {
        user.updatePassword(newPassword).then((_) {
          print("User Password Updated Success");


          updatePasswordInFireStore(user);


        }).catchError((error) {
          print("error 11111");
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(error.toString())));
        });
      }).catchError((err) {
        print("error 2222222");

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(err.toString())));

      });
    }catch(e){
      print("error 3333333");
      print("user in catch");
      print(user.email);
      print(user);
      print(e.toString());
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  updatePasswordInFireStore(User user) async {

    print("Login OTPRepositry RUns");

    try{
      var collection = FirebaseFirestore.instance.collection("user");
      collection.doc(FirebaseAuth.instance.currentUser?.uid).update({
        "password": newPasswordController.text.toString().trim(),
      });
      FirebaseAuth.instance.signOut();
      setState(() {
        isLoading = false;
      });
      ///password change successfull;
      print("Password changed now showing Msg");
      AwesomeDialog(
        context: context,
        dialogType: DialogType.SUCCES,
        animType: AnimType.BOTTOMSLIDE,
        // title: title,
        desc: "Password Changed Successfully Login With New Password",
        descTextStyle: TextStyle(
            fontSize: 20,
            color: Colors.white
        ),
        // btnCancelOnPress: () {},
        dialogBackgroundColor: AppColors.MainColor,
        btnOkColor: AppColors.PrimeryColor,
        btnOkText: "Ok",

        btnOkOnPress: () {
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
              LoginScreen()), (Route<dynamic> route) => false);
        },
      ).show();

    }catch(e)
    {
      ///Error to update password
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("خطأ في تحديث كلمة المرور")));
    }
  }
}

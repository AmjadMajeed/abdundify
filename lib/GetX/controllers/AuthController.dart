import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../models/user_model.dart';
import '../helper/firebase_auth_helper.dart';
import '../helper/firestore_database_helper.dart';
import '../helper/get_storage_helper.dart';
import '../helper/shared_preference_helper.dart';



class AuthController extends GetxController {


  FirebaseAuthHelper _firebaseAuthHelper = FirebaseAuthHelper.instance;
  FirestoreDatabaseHelper _firestoreDatabaseHelper = FirestoreDatabaseHelper.instance;
  SharedPreferenceHelper? _sharedPreferenceHelper = SharedPreferenceHelper.instance;
  GetStorageHelper getStorageHelper=GetStorageHelper.instance;
  Rx<bool> isMale = true.obs;
  bool isNane = false;
  GetStorageHelper _getStorageHelper = GetStorageHelper.instance;
  Rx<TextEditingController> firstName = TextEditingController().obs;
  Rx<TextEditingController> lastName = TextEditingController().obs;
  Rx<TextEditingController> password = TextEditingController().obs;
  Rx<TextEditingController> cPassword = TextEditingController().obs;
  Rx<TextEditingController> email = TextEditingController().obs;
  Rx<TextEditingController> phoneNumber = TextEditingController().obs;
  Rx<TextEditingController> ratePerHoure = TextEditingController().obs;
  Rx<TextEditingController> chilAge = TextEditingController().obs;
  Rx<TextEditingController> chilName = TextEditingController().obs;
  String? otp;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  final box = GetStorage();

  Future<void> logout() async {
    _firebaseAuthHelper.signout();
    getStorageHelper.clear();
  }

  Future<String?> signUp() async {
    try {
      final userCredential = await _firebaseAuthHelper.createAccountWithEmail(email.value.text, password: password.value.text);
      final userUid = userCredential.user?.uid;
      if (userUid == null) return null;
      final userData = UserModel(
        isPaidForVerify: false,
        age : 30,
        fevList: [],
        friends: [],
        longitude : 0.01,
        latitude: 0.01,
        address: "",
        earning: "0",
        isOnline: false,
        rating: 5.0,
        memberShip: "Free",
          firstName: firstName.value.text,
          email: email.value.text,
          id: userUid,
          image: "https://firebasestorage.googleapis.com/v0/b/fir-auth-4bbeb.appspot.com/o/Unknown-2.jpg?alt=media&token=cf9c5ca9-2a03-4be0-9a6a-17d2722ce394",
          type: 'email',
        userIdImage: "",
          lastName: '',
          phone: "+1"+phoneNumber.value.text.toString(),
          gender: isMale.value,
        password: password.value.text,
        totalOrders: 0,
        ratePerHour :
        ratePerHoure.value.text.toString().trim().isEmpty ?
            0.0 :
        double.parse(ratePerHoure.value.text.toString().trim()),
        isNane  : isNane,
        suggestionAndComplains: 0, totalLikes: 0, totalSales: 0, totalHires: 0,
        bio: "",
      );
      final updatedUser = await _firestoreDatabaseHelper.addUser(userData);
      print(updatedUser);
      if (updatedUser == null) return null;
      _getStorageHelper.storeUser(updatedUser);
      // FirebaseFirestore.instance.collection("user").doc(FirebaseAuth.instance.currentUser?.uid)
      //     .collection("child").doc().set(
      //     {
      //       "childName": chilName.value.text.toString().trim(),
      //       "childAge": chilAge.value.text.toString().trim(),
      //       "childImage": "https://firebasestorage.googleapis.com/v0/b/fir-auth-4bbeb.appspot.com/o/images-3.png?alt=media&token=891e90c5-09ae-42f5-b12f-f4d23541049d",
      //       "childClass": "",
      //       "fevGame": "",
      //       "fevFood": "",
      //       "hobby": "",
      //     });
      return '';
    } on FirebaseAuthException catch (e) {
      print('exeptions');
      print(e);
      return _firebaseAuthHelper.getErrorMessage(e);
    } catch (e,s) {
      print(e);
      print(s);
      return null;
    }
  }

  Future<String?> signInWithGoogle() async {
    try {

      final userCredential = await _firebaseAuthHelper.authenticateWithGoogle();
      if (userCredential == null) return null;
      final user = userCredential.user;
      if (user == null) return null;
      final email = user.email;
      if (email == null) return null;
      String firstName = '';
      String lastName = '';
      if (user.displayName != null) {
        final names = user.displayName?.split(' ');
        if (names != null) {
          firstName = names[0];
          if (names.length == 2) lastName = names[1];
        }
      }
      final userData = UserModel(
        isPaidForVerify: false,
        age : 30,
        fevList: [],
        friends: [],
        longitude : 0.01,
        latitude: 0.01,
        address: "",
        earning: "0",
        userIdImage: "",
        rating: 5.0,
        isOnline: false,
        memberShip: "Free",
        firstName: firstName,
          lastName: lastName,
          email: user.email ?? '',
          id: user.uid,
          type: 'google',
          image: user.photoURL ?? '',
          gender: true,
          phone: user.phoneNumber ?? '',
          password: '',
        totalOrders: 0,
        suggestionAndComplains: 0,
        totalLikes: 0,
        totalSales: 0,
        ratePerHour :
        ratePerHoure.value.text.toString().trim().isEmpty ?
        0.0 :
        double.parse(ratePerHoure.value.text.toString().trim()),
        isNane  : isNane,
        totalHires: 0,
        bio: "",
      );
      final updatedUser = await _firestoreDatabaseHelper.addUser(userData);
      if (updatedUser == null) return null;
      _getStorageHelper.storeUser(updatedUser);
      // FirebaseFirestore.instance.collection("user").doc(FirebaseAuth.instance.currentUser?.uid)
      //     .collection("child").doc().set(
      //     {
      //       "childName": chilName.value.text.toString().trim(),
      //       "childAge": chilAge.value.text.toString().trim(),
      //       "childImage": "https://firebasestorage.googleapis.com/v0/b/fir-auth-4bbeb.appspot.com/o/images-3.png?alt=media&token=891e90c5-09ae-42f5-b12f-f4d23541049d",
      //       "childClass": "",
      //       "fevGame": "",
      //       "fevFood": "",
      //       "hobby": "",
      //     });
      return 'user';
    } on FirebaseAuthException catch (e) {
      print("e.toString()");
      print(e.toString());
      return _firebaseAuthHelper.getErrorMessage(e);
    } catch (_) {
      print("e.toString()");
      print(_.toString());
      return null;
    }
  }
  Future<String?> signInWithApple() async {
    try {
      print("try runss111");
      final userCredential = await _firebaseAuthHelper.authenticateWithApple();
      if (userCredential == null) return null;
      print("try runss2222");
      final user = userCredential.user;
      if (user == null) return null;
      print("try runs333");
      final email = user.email;
      if (email == null) return null;
      String firstName = '';
      String lastName = '';
      if (user.displayName != null) {
        print("try runss4444");
        final names = user.displayName?.split(' ');
        if (names != null) {
          print("try runss55555");
          firstName = names[0];
          if (names.length == 2) lastName = names[1];
          print("try runs6666");
        }
      }
      final userData = UserModel(
        isPaidForVerify: false,
        age : 30,
        fevList: [],
        friends: [],
        userIdImage: "",
        longitude : 0.01,
        latitude: 0.01,
        address: "",
        earning: "0",
        rating: 5.0,
        memberShip: "Free",
        isOnline : false,
        firstName: firstName,
          lastName: lastName,
          type: 'apple',
          email: user.email ?? '',
          id: user.uid,
          image: user.photoURL ?? '',
          gender: true,
          phone: user.phoneNumber ?? '',
          password: '',
        totalOrders: 0,
        suggestionAndComplains: 0,
          totalLikes: 0,
        ratePerHour :
        ratePerHoure.value.text.toString().trim().isEmpty ?
        0.0 :
        double.parse(ratePerHoure.value.text.toString().trim()),
        isNane  : isNane,
        totalHires: 0,
        totalSales: 0,
          bio: "",
      );
      final updatedUser = await _firestoreDatabaseHelper.addUser(userData);
      if (updatedUser == null) return null;
      _getStorageHelper.storeUser(updatedUser);
      print("try runss7777");
      return 'user';
    } on FirebaseAuthException catch (e) {
      print("catch runss8888");
      print(e.toString());
      return _firebaseAuthHelper.getErrorMessage(e);
    } catch (_) {
      print("catch runss");
      return null;
    }
  }

  Future<String?> login(String email) async {
    print("1111111111login");
    try {
      print("222222222login");
      await _firebaseAuthHelper.signIn(email, password.value.text);
      final user = _firebaseAuthHelper.currentUser;
      print("33333login");
      if (user == null) return null;
      final userData = await _firestoreDatabaseHelper.getUser(user.uid);
      print("444444444login");
      if (userData == null) return null;
      print("5555555login");
      _getStorageHelper.storeUser(userData);
      print("6666666login");
      return '';
    } on FirebaseAuthException catch (e) {
      print("77777777771login");
      print("catch section runsss");
      return _firebaseAuthHelper.getErrorMessage(e);
    } catch (e, s) {
      print("8888888888login");
      return null;
    }
  }

  Future<String?> phoneVerify() async {
    try {
      otp = await _firebaseAuthHelper.verifyPhoneNumber(phoneNumber.value.text);
      if (otp == '') return '';
      print('otp');
      print(otp);
      return otp;
    } on FirebaseAuthException catch (e) {
      return _firebaseAuthHelper.getErrorMessage(e);
    } catch (_) {
      return null;
    }
  }

  Future<String?> sendResetPasswordEmail(email) async {
    try {
      await _firebaseAuthHelper.resetPassword(email);
      return "Email sent with Reset Password link";
    } on FirebaseAuthException catch (e) {
      print("email");
      print(email.toString());
      print("e.toString()");
      print(e.toString());
      print("e.toString()");
      return _firebaseAuthHelper.getErrorMessage(e);
    } catch (_) {
      print("_.toString()");
      print(_.toString());
      print("_.toString()");
      return "false";
    }
  }

  Future<UserCredential> LoginEmailPassword({email, password}) async {
    UserCredential? userCredential;
    try {
      print("email in LoginEmailPassword method");
      print(email);
      print("password");
      print(password);
      userCredential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
    } catch (e) {
      // ToastMsg(e.toString(),Colors.red,false);
    }
    print("userCredential");
    print(userCredential);
    print("userCredential");
    return userCredential!;
  }

  Future<String?> checkedOtp(String sms) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: otp!,
        smsCode: sms,
      );
      return 'user';
    } catch (_) {
      return null;
    }
  }

  Future<String?> changePassword(String currentPassword, String newPassword) async {
    final user = _firebaseAuthHelper.currentUser;
    if (user == null) return 'user not found';
    final cred = EmailAuthProvider.credential(email: user.email.toString(), password: currentPassword);

    user.reauthenticateWithCredential(cred).then((value) {
      user.updatePassword(newPassword).then((_) {
        return '';
      }).catchError((error) {
        return error;
      });
    }).catchError((err) {
      return null;
    });
  }

  @override
  void onClose() {
    firstName.close();
    lastName.close();
    phoneNumber.close();
    password.close();
    email.close();
    super.onClose();
  }

  userExistsCheckMethod(String phone) async {
    print("userExistsCheckMethod runss11111");
    print("phone");
    print(phone);
    print("phone");
    return FirebaseFirestore.instance
        .collection("user")
        .where('phone', isEqualTo: phone)
        .get()
        .then((value) async {
      if (value.docs.isNotEmpty) {
        print("userExistsCheckMethod runss22222");
        var querySnapshot = await   FirebaseFirestore.instance.collection("user").doc(value.docs.first.id).get();
        Map<String, dynamic>? data = querySnapshot.data();
        var userEmail = data!['email'].toString();
        var userPassword = data['password'].toString();
        print("userExistsCheckMethod runss3333");
        return [true, userEmail,userPassword];
      } else {
        print("userExistsCheckMethod runss4444");
        return [false];
      }
    });
  }
}

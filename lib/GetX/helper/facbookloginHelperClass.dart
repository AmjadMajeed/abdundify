import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';

import '../../models/user_model.dart';
import 'firebase_auth_helper.dart';
import 'firestore_database_helper.dart';

class FacebookLoginHelper {
  final FacebookLogin facebookSignIn = FacebookLogin();
  FirebaseAuthHelper _firebaseAuthHelper = FirebaseAuthHelper.instance;
  FirestoreDatabaseHelper _firestoreDatabaseHelper = FirestoreDatabaseHelper.instance;

  Future<User?> signInWithFacebook() async {
    try {
      final FacebookLoginResult result = await facebookSignIn.logIn(permissions: [
        FacebookPermission.email,
        FacebookPermission.publicProfile,
      ]);

      switch (result.status) {
        case FacebookLoginStatus.success:
          final FacebookAccessToken? accessToken = result.accessToken;
          final AuthCredential credential = FacebookAuthProvider.credential(accessToken!.token);
          final UserCredential authResult = await FirebaseAuth.instance.signInWithCredential(credential);
          ///todo save user data
          final User? user = authResult.user;
          String firstName = '';
          String lastName = '';
          if (user?.displayName != null) {
            final names = user?.displayName?.split(' ');
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
            email: user?.email ?? '',
            id: user!.uid,
            type: 'google',
            image: user?.photoURL ?? '',
            gender: true,
            phone: user?.phoneNumber ?? '',
            password: '',
            totalOrders: 0,
            suggestionAndComplains: 0,
            totalLikes: 0,
            totalSales: 0,
            ratePerHour : 0,
            totalHires: 0,
            bio: "",
            isNane: false,
          );
          final updatedUser = await _firestoreDatabaseHelper.addUser(userData);
          return authResult.user;
        case FacebookLoginStatus.cancel:
          print('Facebook login canceled.');
          return null;
        case FacebookLoginStatus.error:
          print('Facebook login error: ${result.error}');
          return null;
      }
    } catch (e) {
      print('Error during Facebook login: $e');
      return null;
    }
  }

  Future<void> signOut() async {
    await facebookSignIn.logOut();
    await FirebaseAuth.instance.signOut();
  }
}

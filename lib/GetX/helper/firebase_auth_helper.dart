import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class FirebaseAuthHelper {
  static FirebaseAuthHelper instance = FirebaseAuthHelper._internal();

  static const WEAK_PASSWORD = 'weak-password';
  static const EMAIL_ALREADY_IN_USE = 'email-already-in-use';
  static const INVALID_EMAIL = 'invalid-email';
  static const USER_NOT_FOUND = 'user-not-found';
  static const WRONG_PASSWORD = 'wrong-password';

  FirebaseAuthHelper._internal();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Future<void> signIn(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }
  String _otpCode='';

  Future<String> verifyPhoneNumber(String phone) async {
    await _firebaseAuth.verifyPhoneNumber(
      // phoneNumber: '+966$phone',
      phoneNumber: '+923457197717',
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _firebaseAuth.currentUser?.updatePhoneNumber(credential);
      },
      timeout: Duration(seconds: 60),
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
          _otpCode = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
          _otpCode = verificationId;
      },
    );
    return _otpCode;
  }



  Future<UserCredential?> authenticateWithGoogle() async {
    print("google login method runss22222");
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
    await googleUser?.authentication;
    print("google login method runss333333");
    final OAuthCredential? credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
    print("google login method runss444444");
    if (credential == null) return null;
    return await _firebaseAuth.signInWithCredential(credential);
  }

  String generateNonce([int length = 32]) {
    final charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
  Future<UserCredential?> authenticateWithApple() async {
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );
    print(appleCredential.authorizationCode);

    // Create an `OAuthCredential` from the credential returned by Apple.
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );
    return await _firebaseAuth.signInWithCredential(oauthCredential);
  }
  Future<UserCredential> createAccountWithEmail(String email, {String password = '123456789'}) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  }

  String? getErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case USER_NOT_FOUND:
        return 'No user found with this email';
      case WRONG_PASSWORD:
        return 'Invalid password';
      case INVALID_EMAIL:
        return 'Invalid email';
      case WEAK_PASSWORD:
        return 'Password must be greater than 8 characters';
      case EMAIL_ALREADY_IN_USE:
        return 'Email is already used by another user';
      default:
        return null;
    }
  }

  String? getDatabaseErrorMessage(FirebaseException e) {
    return e.message;
  }

  Future<void> signout() async => _firebaseAuth.signOut();

  Future<void> resetPassword(String email) => _firebaseAuth.sendPasswordResetEmail(email: email);
}

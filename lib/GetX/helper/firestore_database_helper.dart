import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/user_model.dart';


class FirestoreDatabaseHelper {
  static final FirestoreDatabaseHelper instance = FirestoreDatabaseHelper._internal();
  static const String _USER = 'user';
  static const String _PARCEL ='parcel';
  static const String _FURNITURE= 'furniture';
  static const String _RENT_CAR='rent_car';
  static const String _ORDER = 'order';
  static const String USER_RIDER = 'service_provider';
  static const String _CHAT='chat';

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  FirestoreDatabaseHelper._internal() {
    _firebaseFirestore.settings = const Settings(persistenceEnabled: false);
  }

  final _timeoutDuration = const Duration(seconds: 15);

  Future<UserModel?> addUser(UserModel user) async {
    print('add user');
      await _firebaseFirestore.collection(_USER).doc(user.id).set(user.toJson()).timeout(_timeoutDuration);
      return user.copyWith(id: user.id);
    }



  Future<UserModel?> getUser(String id) async {
      final documentReference = await _firebaseFirestore.collection(_USER).doc(id).get().timeout(_timeoutDuration);
      if (documentReference.data() == null) return null;
      return UserModel.fromJson(documentReference.data()!);
  }

  Future<void> updateReviews(String id,num reviews,num totalNumber) =>
      _firebaseFirestore.collection(USER_RIDER).doc(id).update({'reviews':reviews,'totalCount':totalNumber}).timeout(_timeoutDuration);

  Future<void> updateUser(UserModel user) =>
      _firebaseFirestore.collection(_USER).doc(user.id).update(user.toJson()).timeout(_timeoutDuration);
}

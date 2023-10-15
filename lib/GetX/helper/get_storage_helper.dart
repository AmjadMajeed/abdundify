import 'dart:convert';
import 'package:get_storage/get_storage.dart';

import '../../models/user_model.dart';

class GetStorageHelper {
  static const String _USER = 'getSotrage.user';
  static const String _PICK_UP_LOCATION = 'pick_up_location';
  static const String _DROP_LOCATION = 'drop_location';

  static final GetStorageHelper instance = GetStorageHelper._internal();

  GetStorageHelper._internal();

  GetStorage getStorage = GetStorage();

  Future<void> storeUser(UserModel user) async {
    final userSerialization = json.encode(user.toJson());
    print("userSerialization");
    print(userSerialization);
    print("userSerialization");
    getStorage.write(_USER, userSerialization);

  }

  Future<void> storePickUp(UserPicUp user) async {

    final userSerialization = json.encode(user.toJson());

    try{
      getStorage.write(_PICK_UP_LOCATION, userSerialization);
      print("address write in storage success");
    }catch(e)
    {
      print("error accors in writing pickup location");
    }
  }

  Future<void> storeDrop(UserDrop user) async {
    final userSerialization = json.encode(user.toJson());
    print(userSerialization);
    getStorage.write(_DROP_LOCATION, userSerialization);
  }

  Future<UserModel?> user() async {
    final userSerialization = getStorage.read(_USER);
    print(userSerialization);
    print('get string');
    if (userSerialization == null) return null;
    print(json.decode(userSerialization));
    return UserModel.fromJson((await json.decode(userSerialization)));
  }

  Future<UserPicUp?> getPickUp() async {
    final userSerialization = getStorage.read(_PICK_UP_LOCATION);
    print(userSerialization);
    print('get Pickup');
    if (userSerialization == null) return null;
    print(json.decode(userSerialization));
    return UserPicUp.fromJson(json.decode(userSerialization));
  }

  Future<UserDrop?> getDrop() async {
    final userSerialization = getStorage.read(_DROP_LOCATION);
    print(userSerialization);
    print('get Drop');
    if (userSerialization == null) return null;
    print(json.decode(userSerialization));
    return UserDrop.fromJson(json.decode(userSerialization));
  }

  Future<void> clear() async => await getStorage.erase();

  Future<void> removedPickUp() async => getStorage.remove(_PICK_UP_LOCATION);

  Future<void> removedDrop() async => getStorage.remove(_DROP_LOCATION);
}

class UserPicUp {
  final num pickLocationLat;
  final num pickLocationLong;
  final String pickAddress;

  UserPicUp({
    required this.pickLocationLong,
    required this.pickLocationLat,
    required this.pickAddress,
  });

  factory UserPicUp.fromJson(Map<String, dynamic> json) {
    final pickLocationLat = json['pick_location_lat'];
    final pickLocationLong = json['pick_location_long'];
    final pickAddress = json['pick_address'];

    return UserPicUp(
        pickLocationLat: pickLocationLat, pickLocationLong: pickLocationLong, pickAddress: pickAddress);
  }

  Map<String, dynamic> toJson() => {
        'pick_location_lat': pickLocationLat,
        'pick_location_long': pickLocationLong,
        'pick_address': pickAddress,
      };
}

class UserDrop {
  final num dropLocationLat;
  final num dropLocationLong;

  UserDrop({
    required this.dropLocationLat,
    required this.dropLocationLong,
  });

  factory UserDrop.fromJson(Map<String, dynamic> json) {
    final dropLocationLat = json['drop_location_lat'];
    final dropLocationLong = json['drop_location_long'];

    return UserDrop(
      dropLocationLat: dropLocationLat,
      dropLocationLong: dropLocationLong,
    );
  }

  Map<String, dynamic> toJson() => {
        'drop_location_lat': dropLocationLat,
        'drop_location_long': dropLocationLong,
      };
}

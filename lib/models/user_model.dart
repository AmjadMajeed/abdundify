class UserModel {
  final String id, firstName, lastName, email, phone, image,type,password,memberShip,earning,address,bio,userIdImage;
      final int totalOrders,suggestionAndComplains,totalLikes,totalSales,totalHires,age;
      final double rating,latitude,longitude,ratePerHour;
  final bool gender,isNane,isOnline,isPaidForVerify;
  List<dynamic> fevList;
  List<dynamic> friends;

  UserModel(
      {
        required this.isPaidForVerify,
        required this.userIdImage,
        required this.isOnline,
        required this.fevList,
        required this.friends,
        required this.bio,
        required this.age,
        required this.latitude,
        required this.longitude,
        required this.address,
        required this.earning,
        required this.rating,
        required this.firstName,
      required this.memberShip,
      required this.lastName,
      required this.id,
        required this.type,
      required this.email,
      required this.image,
      required this.phone,
      required this.gender,
      required this.password,
      required this.totalOrders,
      required this.suggestionAndComplains,
        required this.totalLikes,
        required this.totalSales,
        required this.totalHires,
        required this.isNane,
        required this.ratePerHour,
      });
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      isPaidForVerify: map['isPaidForVerify'],
      userIdImage: map['userIdImage'],
      isOnline: map['isOnline'],
      fevList: map['fevList'],
      friends: map['friends'],
      bio: map['bio'],
      age: map['age'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      address: map['address'],
      earning: map['earning'],
      rating: map['rating'],
      memberShip: map['memberShip'],
     firstName: map['first_name'],
     lastName : map['last_name'],
     email : map['email'],
     image : map['image'],
     id : map['id'],
     type: map.containsKey('type')?map['type']:'',
     gender : map['gender'],
     phone : map['phone'],
     password : map['password'],
     totalOrders : map['totalOrders'],
     suggestionAndComplains : map['suggestionAndComplains'],
     totalLikes : map['totalLikes'],
     totalSales : map['totalSales'],
      totalHires : map['totalHires'],
      isNane : map['isNane'],
      ratePerHour : map['ratePerHour'],
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final isPaidForVerify = json['isPaidForVerify'];
    final userIdImage = json['userIdImage'];
    final isOnline = json['isOnline'];
    final fevList = json['fevList'];
    final friends = json['friends'];
    final bio = json['bio'];
    final age = json['age'];
    final address = json['address'];
    final latitude = json['latitude'];
    final longitude = json['longitude'];
    final earning = json['earning'];
    final rating = json['rating'];
    final memberShip = json['memberShip'];
    final firstName = json['first_name'];
    final lastName = json['last_name'];
    final email = json['email'];
    final image = json['image'];
    final id = json['id'];
    final type=json.containsKey('type')?json['type']:'';
    final gender = json['gender'];
    final phone = json['phone'];
    final password = json['password'];
    final totalOrders = json['totalOrders'];
    final suggestionAndComplains = json['suggestionAndComplains'];
    final totalLikes = json['totalLikes'];
    final totalSales = json['totalSales'];
    final totalHires = json['totalHires'];
    final isNane = json['isNane'];
    final ratePerHour = json['ratePerHour'];

    return UserModel(
        isPaidForVerify: isPaidForVerify,
        userIdImage: userIdImage,
        isOnline: isOnline,
        friends: friends,
        fevList: fevList,
        bio: bio,
        age: age,
        latitude: latitude,
        longitude: longitude,
        address: address,
        isNane:isNane,
        earning:earning,
        rating: rating, memberShip: memberShip, firstName: firstName, lastName: lastName, id: id, email: email, image: image,
        phone: phone, gender: gender,type: type,password : password,
      totalOrders : totalOrders,suggestionAndComplains:suggestionAndComplains,totalLikes:totalLikes,
        totalSales:totalSales,totalHires:totalHires,ratePerHour:ratePerHour);
  }

  UserModel copyWith({
    String? id,
    String? firstName,
    String? image
  }) =>
      UserModel(
          isPaidForVerify: isPaidForVerify,
          userIdImage: userIdImage,
          fevList: fevList,
          friends: friends,
          isOnline: isOnline,
          bio: bio,
          age: age,
          isNane: isNane,
          latitude: latitude,
          longitude: longitude,
          earning: earning,
          address: address,
          rating: rating,
          memberShip: memberShip,
          type: type, image: image??this.image, id: id ??
          this.id, firstName: firstName?? this.firstName, lastName: lastName,
          gender: gender, phone: phone, email: email,
          password : password,totalOrders:totalOrders,suggestionAndComplains: suggestionAndComplains,
          totalLikes: totalLikes,totalHires: totalHires,totalSales: totalSales,ratePerHour:ratePerHour);

  Map<String, dynamic> toJson() => {
    'isPaidForVerify': isPaidForVerify,
    'userIdImage': userIdImage,
    'isOnline': isOnline,
    'isNane': isNane,
    'fevList': fevList,
    'friends': friends,
    'bio': bio,
    'age': age,
    'latitude': latitude,
    'longitude': longitude,
    'address': address,
    'earning': earning,
    'rating': rating,
    'memberShip': memberShip,
    'first_name': firstName,
    'email': email,
    'last_name': lastName,
    'image': image,
    'phone': phone,
    'type':type,
    'gender': gender,
    'id': id,
    'password': password,
    'totalOrders': totalOrders,
    'suggestionAndComplains': suggestionAndComplains,
    "totalLikes" : totalLikes,
    "totalSales" : totalSales,
    "totalHires" : totalHires,
    "ratePerHour" : ratePerHour,
  };



}

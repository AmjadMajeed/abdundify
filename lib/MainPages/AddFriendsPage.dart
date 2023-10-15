import 'package:abundify/Auth/AuthSelectionScreen.dart';
import 'package:abundify/Utils/Colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../GetX/helper/snackbar_helper.dart';
import '../Pages/chatScreen.dart';
import '../Provider/auth_provider.dart';
import '../Utils/firestore_constants.dart';
import '../models/snackbar_message.dart';
import '../models/user_chat.dart';

class AddFriendsPage extends StatefulWidget {
  @override
  _AddFriendsPageState createState() => _AddFriendsPageState();
}

class _AddFriendsPageState extends State<AddFriendsPage> {
  late final AuthProvider authProvider;
  late final String currentUserId;
  final ScrollController listScrollController = ScrollController();

  final TextEditingController _searchController = TextEditingController();
  List<UserChat> usersList = [];
  List<UserChat> searchResults = [];

  @override
  void initState() {
    super.initState();
    authProvider = context.read<AuthProvider>();
    currentUserId = FirebaseAuth.instance.currentUser?.uid ?? '';

    if (currentUserId.isEmpty) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => AuthSelectionScreen()),
            (Route<dynamic> route) => false,
      );
    }

    fetchDataFromFirestore();
  }

  Future<void> fetchDataFromFirestore() async {
    final snapshot = await FirebaseFirestore.instance
        .collection(FirestoreConstants.pathUserCollection)
        .get();

    final allUsers = snapshot.docs
        .map((document) => UserChat.fromDocument(document))
        .toList();

    setState(() {
      usersList = allUsers
          .where((userChat) => userChat.id != currentUserId)
          .toList();
      searchResults = usersList;
    });
  }

  void _onSearchTextChanged(String text) {
    setState(() {
      searchResults = usersList
          .where((user) => user.nickname.toLowerCase().contains(text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: AppColors.MainBGColor,
      appBar: AppBar(
        backgroundColor: AppColors.MainBGColor,
        title: Center(
          child: Text('Add Friends'),
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by name...',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: _onSearchTextChanged,
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: searchResults.length,
              itemBuilder: (context, index) => buildItem(context, searchResults[index]),
              controller: listScrollController,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildItem(BuildContext context, UserChat userChat) {
    final snackbarHelper = SnackbarHelper.instance..injectContext(context);
    return Container(
      child: TextButton(
        child: Row(
          children: <Widget>[
            Material(
              child: userChat.photoUrl.isNotEmpty
                  ? Image.network(
                userChat.photoUrl,
                fit: BoxFit.cover,
                width: 50,
                height: 50,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    width: 50,
                    height: 50,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColors.MainBGColor,
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    ),
                  );
                },
                errorBuilder: (context, object, stackTrace) {
                  return Icon(
                    Icons.account_circle,
                    size: 50,
                    color: Colors.grey,
                  );
                },
              )
                  : Icon(
                Icons.account_circle,
                size: 50,
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.all(Radius.circular(25)),
              clipBehavior: Clip.hardEdge,
            ),
            Flexible(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            '  ${userChat.nickname}',
                            maxLines: 1,
                            style: TextStyle(color: Colors.white, fontSize: 19),
                          ),
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.fromLTRB(10, 0, 0, 5),
                        ),
                        SizedBox(width: 50),
                        InkWell(
                          onTap: () {
                            try {
                              addFriend(userChat.id);
                              snackbarHelper.showSnackbar(
                                snackbar: SnackbarMessage.success(message: 'Friend Added...'),
                              );
                            } catch (e) {
                              print('Error: $e');
                            }
                          },
                          child: Icon(Icons.add, color: Colors.white, size: 36),
                        ),
                      ],
                    ),
                  ],
                ),
                margin: EdgeInsets.only(left: 20),
              ),
            ),
          ],
        ),
        onPressed: () {},
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ),
      margin: EdgeInsets.only(bottom: 10, left: 5, right: 5),
    );
  }

  Future<void> addFriend(String friendId) async {
    try {
      final userFriendsRef = FirebaseFirestore.instance.collection('user').doc(friendId);
      final friendsSnapshot = await userFriendsRef.get();
      final friendsList = List<String>.from(friendsSnapshot['friends'] ?? []);

      if (!friendsList.contains(currentUserId)) {
        friendsList.add(currentUserId);
        await userFriendsRef.update({'friends': friendsList});
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}

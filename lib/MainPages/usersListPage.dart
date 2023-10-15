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
import '../models/user_chat.dart';
import 'AddFriendsPage.dart';

class UserListScreen extends StatefulWidget {
  final String currentUserId;

  UserListScreen({required this.currentUserId});

  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  late final AuthProvider authProvider;
  late final String currentUserId;

  final ScrollController listScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    authProvider = context.read<AuthProvider>();
    currentUserId = FirebaseAuth.instance.currentUser?.uid?? '';

    if (currentUserId.isEmpty) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => AuthSelectionScreen()),
            (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.MainBGColor,
      appBar: AppBar(
        backgroundColor: AppColors.MainBGColor,
        title: Center(child: Text('Friends'),),
        actions: [
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>AddFriendsPage()));
            },
            child: Padding(
              padding:  EdgeInsets.only(left: 8.0,right: 8.0),
              child: Icon(Icons.add,color: Colors.white,),
            ),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection(FirestoreConstants.pathUserCollection)
        .where("friends",arrayContains: FirebaseAuth.instance.currentUser?.uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            print(FirebaseAuth.instance.currentUser?.uid);
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.MainBGColor,
              ),
            );
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text("No Friends Found",style: TextStyle(color: Colors.white),),
            );
          }

          final usersList = snapshot.data!.docs
              .map((document) => UserChat.fromDocument(document))
              .where((userChat) => userChat.id != currentUserId)
              .toList();

          return ListView.builder(
            padding: EdgeInsets.all(10),
            itemCount: usersList.length,
            itemBuilder: (context, index) =>
                buildItem(context, usersList[index]),
            controller: listScrollController,
          );
        },
      ),
    );
  }

  Widget buildItem(BuildContext context, UserChat userChat) {

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
                        value: loadingProgress.expectedTotalBytes !=
                            null
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
                    Container(
                      child: Text(
                        '  ${userChat.nickname}',
                        maxLines: 1,
                        style: TextStyle(color: Colors.white,fontSize: 19),
                      ),
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.fromLTRB(10, 0, 0, 5),
                    ),

                  ],
                ),
                margin: EdgeInsets.only(left: 20),
              ),
            ),
          ],
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                arguments: ChatPageArguments(
                  peerId: userChat.id,
                  peerAvatar: userChat.photoUrl,
                  peerNickname: userChat.nickname,
                ),
              ),
            ),
          );
        },
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
}

import 'package:abundify/Utils/Colors.dart';
import 'package:abundify/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../GetX/helper/snackbar_helper.dart';
import '../models/snackbar_message.dart';

class sendToFriendPage extends StatefulWidget {
UserModel userModel;
sendToFriendPage({required this.userModel});

  @override
  State<sendToFriendPage> createState() => _sendToFriendPageState();
}


TextEditingController addMoneyController = TextEditingController();

class _sendToFriendPageState extends State<sendToFriendPage> {
  @override
  Widget build(BuildContext context) {
    final snackbarHelper = SnackbarHelper.instance..injectContext(context);
    final double itemHeight = MediaQuery.of(context).size.height;
    final double itemWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[200],
      ),
      body: Container(
        height: itemHeight,
        decoration: BoxDecoration(
          color: AppColors.MainBGColor,
          // image: DecorationImage(
          //   image: AssetImage("assets/bgImage.jpeg"),
          //   fit: BoxFit.cover,
          // ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Add Balance To Send: ${widget.userModel.firstName}",style: TextStyle(fontSize: 20),),
            Padding(
              padding: EdgeInsets.all(30.0),
              child: TextField(
                controller: addMoneyController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Enter Balance To Send "${widget.userModel.firstName}"',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),

            ElevatedButton(
              onPressed: () {
                print("addMoneyController.text.toString()");
                print(addMoneyController.text.toString());
                print("addMoneyController.text.toString()");
                if(addMoneyController.text.toString().isNotEmpty){
                  try{
                    FirebaseFirestore.instance.collection('user')
                        .doc(widget.userModel.id).update(
                        {
                          "earning": (int.parse(widget.userModel.earning) + int.parse(addMoneyController.text.trim())).toString(),
                        }
                    );
                    FirebaseFirestore.instance.collection('user')
                        .doc(FirebaseAuth.instance.currentUser?.uid).update(
                        {
                          "earning": (int.parse(widget.userModel.earning) - int.parse(addMoneyController.text.trim())).toString(),
                        }
                    );
                    FirebaseFirestore.instance.collection('user')
                        .doc(FirebaseAuth.instance.currentUser?.uid)
                        .collection("transections").doc().set(
                        {
                          "amount":  addMoneyController.text.trim(),
                        }
                    );
                    snackbarHelper.showSnackbar(snackbar: SnackbarMessage.success(message: 'Money sent Successfully'));
                    addMoneyController.clear();
                    Navigator.pop(context);
                  }catch(e){
                    snackbarHelper.showSnackbar(snackbar: SnackbarMessage.error(message: 'SomeThing Goes Wrong Try Again later'));

                  }
                }
                else{
                  snackbarHelper.showSnackbar(snackbar: SnackbarMessage.error(message: 'Write Balance To Added'));
                }



              },
              child: Text('     Send     ',style: TextStyle(color: Colors.black,fontSize: 20),),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
            ),
          ],
        ),),
      ),
    );
  }
}

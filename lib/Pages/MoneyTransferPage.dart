import 'package:abundify/Pages/sendToFriendPage.dart';
import 'package:abundify/Utils/AppIcons.dart';
import 'package:abundify/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';

import '../GetX/helper/snackbar_helper.dart';
import '../Utils/Colors.dart';
import '../models/snackbar_message.dart';

class MoneyTransferPage extends StatefulWidget {
  const MoneyTransferPage({Key? key}) : super(key: key);

  @override
  State<MoneyTransferPage> createState() => _MoneyTransferPageState();
}


class _MoneyTransferPageState extends State<MoneyTransferPage> {

  TextEditingController addMoneyController = TextEditingController();

  bool isAddingMoney = false;


  @override
  Widget build(BuildContext context) {
    final snackbarHelper = SnackbarHelper.instance..injectContext(context);


    final double itemHeight = MediaQuery.of(context).size.height;
    final double itemWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: itemHeight,
        decoration: BoxDecoration(
          color: AppColors.MainBGColor,

          // image: DecorationImage(
          //   image: AssetImage("assets/bgImage.jpeg"),
          //   fit: BoxFit.cover,
          // ),
        ),
        ///child stream
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('user')
              .where("id",isEqualTo: FirebaseAuth.instance.currentUser?.uid)
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            if (!snapshot.hasData) {
              return Text('Loading...');
            }
            final List<UserModel> childModel = snapshot.data!.docs.map((doc) {
              final data = doc.data();
              return UserModel.fromJson(data as Map<String, dynamic>);
            }).toList();
            return StaggeredGridView.countBuilder(
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 1,
              crossAxisSpacing: 10,
              mainAxisSpacing: 12,
              // scrollDirection: ScrollDirection.reverse,
              itemCount: 1,
              itemBuilder: (context, index) {
                final user = childModel[index];
                String? ds = snapshot.data?.docs[index].id;
                String formattedEarnings = NumberFormat('#,###').format(int.parse(user.earning));
                String earningsText = '\$$formattedEarnings';

                return Container(
                  // height: screenHeight/2,
                  child: Column(
                    children: [
                      SizedBox(height: 40.0,),
                      ///blance
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text("Bank Account",style:
                        TextStyle(fontSize: 14,color: Colors.white,),),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(left: itemWidth/2.6,right: itemWidth/2.6),
                        child: Divider(thickness: 2.0,color: Colors.white,),
                      ),
                      SizedBox(height: 20.0,),
                      ///blance
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text("Total Balance is:",style: TextStyle(fontSize: 17,color: Colors.white),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(earningsText,style: TextStyle(fontSize: 40,color: Colors.white,fontWeight: FontWeight.bold),),
                      ),
                      SizedBox(height: 30.0,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: (){
                                setState(() {
                                  print("clicked");
                                  isAddingMoney = !isAddingMoney;
                                });
                              },
                              child: Container(
                                height: itemHeight/5,
                                width: itemWidth/3,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white,
                                ),
                                child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                    Image.asset(AppIcons.logo,height: 100,width: 100,),
                                    Text("Send Money",style: TextStyle(fontSize: 20),),
                                  ],
                                )),
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                setState(() {
                                  print("clicked");
                                  isAddingMoney = !isAddingMoney;
                                });
                              },
                              child: Container(
                                height: itemHeight/5,
                                width: itemWidth/3,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white,
                                ),
                                child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                      padding:  EdgeInsets.only(top: 30.0),
                                      child: Image.asset(AppIcons.deposit,height: 50,width: 50,),
                                    ),
                                    Padding(
                                      padding:  EdgeInsets.only(top: 25.0),
                                      child: Text("Add Money",style: TextStyle(fontSize: 20),),
                                    ),
                                  ],
                                )),
                              ),
                            ),

                          ],
                        ),
                      ),

                      isAddingMoney ?
                      Padding(
                        padding: EdgeInsets.all(30.0),
                        child: TextField(
                          controller: addMoneyController,
                          keyboardType: TextInputType.number,
                          style: TextStyle(color: Colors.white), // Set the text color of the entered text
                          decoration: InputDecoration(
                            labelText: 'Enter Balance To Add',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            labelStyle: TextStyle(color: Colors.white), // Text color of the label
                            hintStyle: TextStyle(color: Colors.white), // Text color of the hint text
                          ),
                        ),
                      )
                          :
                      SizedBox(),

                      isAddingMoney?
                      ElevatedButton(
                        onPressed: () {
                          print("addMoneyController.text.toString()");
                          print(addMoneyController.text.toString());
                          print("addMoneyController.text.toString()");
                        if(addMoneyController.text.toString().isNotEmpty){
                       try{
                         FirebaseFirestore.instance.collection('user')
                             .doc(FirebaseAuth.instance.currentUser?.uid).update(
                             {
                               "earning": (int.parse(user.earning) + int.parse(addMoneyController.text.trim())).toString(),
                             }
                         );
                         snackbarHelper.showSnackbar(snackbar: SnackbarMessage.success(message: 'Money Added'));
                         addMoneyController.clear();
                       }catch(e){
                         snackbarHelper.showSnackbar(snackbar: SnackbarMessage.error(message: 'SomeThing Goes Wrong Try Again later'));

                       }
                        }
                        else{
                          snackbarHelper.showSnackbar(snackbar: SnackbarMessage.error(message: 'Write Balance To Added'));
                        }



                        },
                        child: Text('     Add     ',style: TextStyle(color: Colors.black,fontSize: 20),),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        ),
                      )
                          :
                      Column(
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(top: 15.0,left: 30),
                            child: Row(
                              children: [
                                Text("Send Balance To:",style: TextStyle(fontSize: 18,color: Colors.white),),
                              ],
                            ),
                          ),
                          Container(
                            height: itemHeight/3,
                            child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('user')
                                  .where("id",isEqualTo: FirebaseAuth.instance.currentUser?.uid)
                                  .snapshots(),
                              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                }
                                if (!snapshot.hasData) {
                                  return Text('Loading...');
                                }
                                final List<UserModel> childModel = snapshot.data!.docs.map((doc) {
                                  final data = doc.data();
                                  return UserModel.fromJson(data as Map<String, dynamic>);
                                }).toList();
                                return StaggeredGridView.countBuilder(
                                  physics: NeverScrollableScrollPhysics(),
                                  crossAxisCount: 1,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 12,
                                  // scrollDirection: ScrollDirection.reverse,
                                  itemCount: snapshot.data?.docs.length,
                                  itemBuilder: (context, index) {
                                    final user = childModel[index];
                                    String? ds = snapshot.data?.docs[index].id;
                                    return InkWell(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(
                                            builder: (context)=>sendToFriendPage(userModel: user,)));
                                      },
                                      child: Padding(
                                        padding:  EdgeInsets.only(left: 30,right: 30,top: 8.0,bottom: 8.0),
                                        child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(10.0),
                                            ),
                                            child: ListTile(
                                              leading: Icon(Icons.person),
                                              title: Text(user.firstName,style: TextStyle(fontSize: 20),),
                                              trailing: Icon(Icons.send),
                                            )),
                                      ),
                                    );
                                  }, staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                                );
                              },
                            ),
                          ),
                        ],
                      ),




                    ],
                  ),
                );
              }, staggeredTileBuilder: (index) => StaggeredTile.fit(1),
            );
          },
        ),
      ),
    );
  }
}

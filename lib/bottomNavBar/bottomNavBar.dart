import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../AffairmationPage.dart';
import '../FourPortionScreen.dart';
import '../FourPortionsPageTwo.dart';
import '../GetX/helper/snackbar_helper.dart';
import '../Pages/SettingPage.dart';



class bottomNavigationBar extends StatefulWidget {

  int indexMain;
  bottomNavigationBar(this.indexMain);

  @override
  _bottomNavigationBarState createState() => _bottomNavigationBarState();
}


class _bottomNavigationBarState extends State<bottomNavigationBar> {


  int indexx = 0;

  final List<Widget> Pages = [
    AffirmationListScreen(),
    FourPortionPageTwo(),
    MyScreen(),
    AffirmationListScreen(),
  ];
  final PageStorageBucket pageBucket = PageStorageBucket();


  int values = 0;

  late DateTime currentBackPressTime;


  @override
  Widget build(BuildContext context) {

    final snackbarHelper = SnackbarHelper.instance..injectContext(context);


    Widget currentpge =   indexx == 0? AffirmationListScreen():
        indexx == 1 ?
            MyScreen() :
            indexx == 2?
    FourPortionPageTwo()
    :
    SettingPage();

    return Scaffold(

      ///floating Button For My Mathes
      // floatingActionButton: Visibility(
      //   visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
      //   child: Stack(
      //     children: [
      //       FloatingActionButton(
      //         backgroundColor: Colors.green,
      //         onPressed: () {  },
      //         child:
      //         ///my matches button
      //         Container(
      //           // width: MediaQuery.of(context).size.width/4,
      //           child: MaterialButton(
      //             onPressed: () {
      //               Navigator.push(context, MaterialPageRoute(builder: (context)=>MyScreen()));
      //
      //             },
      //             child: Padding(
      //               padding: const EdgeInsets.only(top: 1.0,),
      //               child: Container(
      //                 // width: MediaQuery.of(context).size.width / 8,
      //                 decoration: BoxDecoration(
      //                   borderRadius: BorderRadius.circular(30.0),
      //                   color: Colors.green,
      //                 ),
      //                 child:
      //                 Stack(
      //                   children: [
      //                     Container(
      //                       // child: Image.asset('assets/logo.png'),),
      //                       child: Icon(Icons.add,color: Colors.white,),),
      //
      //                   ],
      //                 ),
      //
      //               ),
      //             ),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar :  Container(
        width: MediaQuery.of(context).size.width,
        // height: MediaQuery.of(context).size.height / 10,
        height: 80,
        color: Color(0xFF4C4A4E),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ///Affairmation
            Container(
              // width: MediaQuery.of(context).size.width/5.1,
              child: MaterialButton(
                onPressed: () {
                  try{
                    if(FirebaseAuth.instance.currentUser?.uid == null)
                    {
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=> AffirmationListScreen()));

                    }
                    else
                    {
                      ("else runssss");
                      setState(() {
                        currentpge = AffirmationListScreen();
                        indexx = 0;
                      });

                    }
                  }catch(e)
                  {
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=> oneScren()));

                  }

                },



                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    indexx == 0
                        ? Icon(Icons.star,color: Colors.green,)
                    :
                    Icon(Icons.star,color: Colors.white,),

                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        "Affirmations",
                        style: TextStyle(
                          color: indexx == 0
                              ? Colors.green
                              : Colors.white,
                          fontWeight: indexx == 0
                              ? FontWeight.bold
                              : FontWeight.normal,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),


            ///Gratitude
            Container(
              // width: MediaQuery.of(context).size.width/5.1,

              child: MaterialButton(
                onPressed: () {
                  try{

                    if(FirebaseAuth.instance.currentUser?.uid == null)
                    {

                      Navigator.push(context, MaterialPageRoute(builder: (context)=> MyScreen()));

                    }
                    else
                    {

                      setState(() {
                        currentpge = MyScreen();
                        indexx = 1;
                      });
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=> Notification1()));

                    }
                  }catch(e)
                  {

                    // Navigator.push(context, MaterialPageRoute(builder: (context)=> oneScren()));

                  }

                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    indexx == 1
                        ? Icon(Icons.favorite,color: Colors.green,)
                        :  Icon(Icons.favorite,color: Colors.white,),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        "Gratitude",
                        style: TextStyle(
                          fontSize: 12,
                          color: indexx == 1
                              ? Colors.green
                              : Colors.white,
                          fontWeight: indexx == 1
                              ? FontWeight.bold
                              : FontWeight.normal,

                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            ///wealth
            Container(
              // width: MediaQuery.of(context).size.width/5.1,

              child: MaterialButton(
                onPressed: () {
                  try{

                    if(FirebaseAuth.instance.currentUser?.uid == null)
                    {

                      Navigator.push(context, MaterialPageRoute(builder: (context)=> FourPortionPageTwo()));

                    }
                    else
                    {

                      setState(() {
                        currentpge = FourPortionPageTwo();
                        indexx = 2;
                      });
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=> Notification1()));

                    }
                  }catch(e)
                  {

                    // Navigator.push(context, MaterialPageRoute(builder: (context)=> oneScren()));

                  }

                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    indexx == 2
                        ? Icon(Icons.attach_money,color: Colors.green,)
                        :  Icon(Icons.attach_money,color: Colors.white,),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        "Wealth",
                        style: TextStyle(
                          fontSize: 12,
                          color: indexx == 2
                              ? Colors.green
                              : Colors.white,
                          fontWeight: indexx == 2
                              ? FontWeight.bold
                              : FontWeight.normal,

                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            ///Settings
            Container(
              // width: MediaQuery.of(context).size.width/5.1,

              child: MaterialButton(
                onPressed: () {
                  try{

                    if(FirebaseAuth.instance.currentUser?.uid == null)
                    {

                      Navigator.push(context, MaterialPageRoute(builder: (context)=> SettingPage()));

                    }
                    else
                    {

                      setState(() {
                        currentpge = MyScreen();
                        indexx = 3;
                      });
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=> Notification1()));

                    }
                  }catch(e)
                  {

                    // Navigator.push(context, MaterialPageRoute(builder: (context)=> oneScren()));

                  }

                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    indexx == 3
                        ? Icon(Icons.settings,color: Colors.green,)
                        :  Icon(Icons.settings,color: Colors.white,),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        "Settings",
                        style: TextStyle(
                          fontSize: 12,
                          color: indexx == 3
                              ? Colors.green
                              : Colors.white,
                          fontWeight: indexx == 3
                              ? FontWeight.bold
                              : FontWeight.normal,

                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),

      body: WillPopScope(child: PageStorage(bucket: pageBucket, child: currentpge),onWillPop: onWillPop,),
    );
  }
  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      // ToastMessage("Press Again To Exit", Colors.red);

      return Future.value(false);
    }
    return Future.value(true);
  }


}


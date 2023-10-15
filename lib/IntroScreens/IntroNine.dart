import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../SplashScreen.dart';

class IntroNine extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: (){
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
              SplashScreen()), (Route<dynamic> route) => false);
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Image.asset('assets/icons/introNine.png',fit: BoxFit.cover,),
        ),
      ),
    );
  }
}

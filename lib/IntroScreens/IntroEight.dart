import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'IntroNine.dart';

class IntroEight extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>IntroNine()));
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Image.asset('assets/icons/introEight.png',fit: BoxFit.cover,),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'IntroFour.dart';

class IntroThree extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>IntroFour()));
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Image.asset('assets/icons/introThree.png',fit: BoxFit.cover,),
        ),
      ),
    );
  }
}

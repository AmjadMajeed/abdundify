import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'IntroSix.dart';

class IntroFive extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>IntroSix()));
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Image.asset('assets/icons/introFive.png',fit: BoxFit.cover,),
        ),
      ),
    );
  }
}

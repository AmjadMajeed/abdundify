import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'IntroEight.dart';

class IntroSeven extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>IntroEight()));
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Image.asset('assets/icons/introSeven.png',fit: BoxFit.cover,),
        ),
      ),
    );
  }
}

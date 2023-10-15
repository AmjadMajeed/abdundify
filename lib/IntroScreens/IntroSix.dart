import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'IntroSeven.dart';

class IntroSix extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>IntroSeven()));
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Image.asset('assets/icons/introSix.png',fit: BoxFit.cover,),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Utils/Colors.dart';



class CustomBtn extends StatelessWidget {
  CustomBtn({
     this.text,
    this.textSized,
    this.textColor,
    this.bgColor,
    this.borderRadiusValue,
    this.btnHeight,
    this.btnWidth,
    this.icon,
    this.borderColor,
  });

  String? text;
      double? textSized;
  Color? textColor;
      Color? bgColor;
  double? borderRadiusValue;
      double? btnHeight;
  double? btnWidth;
  String? icon;
  Color? borderColor;


  @override
  Widget build(BuildContext context) {
    return
      Container(
        height: btnHeight??MediaQuery.of(context).size.height/15,
        width: btnWidth??MediaQuery.of(context).size.width - 50,
        decoration: BoxDecoration(
          border: Border.all(color: borderColor ??Colors.white),
          borderRadius: BorderRadius.circular(borderRadiusValue??12.0),
          color: bgColor?? AppColors.MainColor,
        ),
        child: Center(
            child:
                icon == null ?
            Text(text??"Submit",
                style: TextStyle(
                  color: textColor??Colors.white,
                  fontSize: textSized??18.0,
                )
                )
                 :

                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Image.asset(icon!,height: 30,width: 30,),
                    ),
                    SizedBox(width: 5.0,),
                    Text(text??"Submite",
                      style: TextStyle(
                        color: textColor??Colors.white,
                        fontSize: textSized??18.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
        ),
      );

  }
}

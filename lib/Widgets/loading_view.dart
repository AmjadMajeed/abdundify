import 'package:abundify/Utils/Colors.dart';
import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: CircularProgressIndicator(
          color: AppColors.MainColor,
        ),
      ),
      color: Colors.white.withOpacity(0.8),
    );
  }
}

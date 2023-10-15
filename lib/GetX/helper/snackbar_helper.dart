import 'package:flutter/material.dart';

import '../../models/snackbar_message.dart';



class SnackbarHelper {
  static const Duration _duration = Duration(seconds: 3);
  static const Duration _longDuration = Duration(seconds: 4);
  static final SnackbarHelper instance = SnackbarHelper._internal();

  BuildContext? _context;

  SnackbarHelper._internal();

  void injectContext(BuildContext context) => _context = context;




  void dispose() => _context = null;

  void showSnackbar({required SnackbarMessage snackbar}) {
    final context = _context;
    if (context == null) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
          duration: snackbar.isLongDuration ? _longDuration : _duration,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          content: Text(
            snackbar.message,
            style: const TextStyle(color:Colors.white, fontSize: 15,fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          backgroundColor: snackbar.isForSuccess ?Color(0xff28476E) : Colors.red));
  }
}

import 'dart:ui';
import 'package:flutter/material.dart';
import '../../Utils/Colors.dart';
import 'material_dialog_content.dart';

class MaterialDialogHelper {
  static MaterialDialogHelper? _instance;

  MaterialDialogHelper._();

  static MaterialDialogHelper instance() {
    _instance ??= MaterialDialogHelper._();
    return _instance!;
  }

  BuildContext? _context;

  void injectContext(BuildContext context) => _context = context;

  void hideDialog() {
    final context = _context;
    if (context == null) return;
    Navigator.pop(context);
  }

  void dismissProgress() {
    final context = _context;
    if (context == null) return;
    Navigator.pop(context);
  }
  void showMaterialDialogWithContent(MaterialDialogContent content, Function positiveClickListener,
      {Function? negativeClickListener}) {
    final context = _context;
    if (context == null) return;
    showDialog(
        context: context,
        builder: (_) {
          return WillPopScope(
              child: AlertDialog(
                insetPadding: const EdgeInsets.symmetric(horizontal: 25),
                contentPadding: const EdgeInsets.all(0),
                backgroundColor:AppColors.MainColor,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(content.title,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 20, color: Colors.white))),
                    const SizedBox(height: 10),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(content.message,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 14))),
                    const SizedBox(height: 30),
                    Divider(thickness: 0.8, color: Color(0xff28476E).withOpacity(0.1), height: 0),
                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              borderRadius: const BorderRadius.only(bottomRight: Radius.circular(16)),
                              onTap: () {
                                Navigator.pop(context);
                                positiveClickListener.call();
                              },
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 13),
                                  child: Text(content.positiveText.toUpperCase(),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold))),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              onWillPop: () async => true);
        });
  }


  void showProgressDialog(String text) {
    final context = _context;
    if (context == null) return;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: Dialog(
              backgroundColor: AppColors.MainColor,
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
              child: Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 15, left: 25, right: 25),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator(backgroundColor: Colors.white, strokeWidth: 3),
                    const SizedBox(width: 20),
                    Flexible(
                      child: Text(text,
                          style: const TextStyle(
                              color: Colors.white, fontFamily: 'JF Flat', fontSize: 14, fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}

import 'package:flutter/material.dart';
class Util {
  static Size sizeScreen({required BuildContext context}) {
    MediaQueryData queryData = MediaQuery.of(context);
    return queryData.size;
  }
  static Future<void> showBottomSheet(
      {required BuildContext context, required Widget
      bottomSheet}) async {
    double _radius = 16;
    return showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(_radius),
                        topRight: Radius.circular(_radius))),
                child: SingleChildScrollView(child: bottomSheet)),
          );
        });
  }
}
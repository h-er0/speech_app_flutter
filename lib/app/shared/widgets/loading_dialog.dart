import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

Future<void> showLoadingDialog(BuildContext context) async {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return PopScope(
        canPop: false,
        child:
            Platform.isIOS
                ? const CupertinoAlertDialog(
                  title: Text('Loading'),
                  content: Padding(
                    padding: EdgeInsets.all(20),
                    child: CupertinoActivityIndicator(),
                  ),
                )
                : Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  insetPadding: const EdgeInsets.symmetric(horizontal: 60),
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "Loading",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 10,
                        ),
                        child: CircularProgressIndicator.adaptive(),
                      ),
                      Gap(10),
                    ],
                  ),
                ),
      );
    },
  );
}

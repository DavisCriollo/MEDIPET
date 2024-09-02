import 'package:flutter/material.dart';
import 'package:neitorcont/src/utils/theme.dart';





class NotificatiosnService {
  static GlobalKey<ScaffoldMessengerState> messengerKey =
       GlobalKey<ScaffoldMessengerState>();
  
  static showSnackBarError(String message) {
    final snackBar =  SnackBar(
      // backgroundColor: Colors.red.withOpacity(0.9),
 backgroundColor: errorColor,
      content: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20
        ),
      ),
    );
    messengerKey.currentState!.showSnackBar(snackBar);
  }
  static showSnackBarSuccsses(String message) {
    final snackBar =  SnackBar(
      // backgroundColor: Colors.green.withOpacity(0.9),
      backgroundColor: alertColor,
      content: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20
        ),
      ),
    );
    messengerKey.currentState!.showSnackBar(snackBar);
  }
  static showSnackBarDanger(String message) {
    final snackBar =  SnackBar(
      // backgroundColor: Colors.green.withOpacity(0.9),
      backgroundColor: alertColor,
      content: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20
        ),
      ),
    );
    messengerKey.currentState!.showSnackBar(snackBar);
  }
  static showSnackBarInfo(String message,String result) {
    final snackBar =  SnackBar(
      // backgroundColor: Colors.green.withOpacity(0.9),
      // backgroundColor: (result=='success')?secondaryColor:tercearyColor,
       backgroundColor: (result=='success')?Colors.orange:Colors.red,
      content: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20
        ),
      ),
    );
    messengerKey.currentState!.showSnackBar(snackBar);
  }
  
}



import 'package:flutter/material.dart';
import 'package:neitorcont/src/api/api_provider.dart';


class PasswordController extends ChangeNotifier {
  GlobalKey<FormState> passwordFormKey = GlobalKey<FormState>();
  final _api = ApiProvider();





 bool validateForm() {
    if (passwordFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }




}
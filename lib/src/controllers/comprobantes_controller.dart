import 'package:flutter/material.dart';
import 'package:neitorcont/src/api/api_provider.dart';
import 'package:neitorcont/src/models/auth_response.dart';

class ComprobantesController extends ChangeNotifier {
  final _api = ApiProvider();
  GlobalKey<FormState> comprobantesFormKey = GlobalKey<FormState>();

  AuthResponse? usuarios;
  bool validateForm() {
    if (comprobantesFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }


  String _tipoPlaca = '';
  String get getTipoPlaca  => _tipoPlaca;

  void setTipoPlaca(String _tipo) {
   _tipoPlaca =''; 
   _tipoPlaca = _tipo;
     print('==_tipoPlaca===> $_tipoPlaca');
    notifyListeners();
  }





}
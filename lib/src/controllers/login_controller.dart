import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:neitorcont/src/api/api_provider.dart';
import 'package:neitorcont/src/api/authentication_client.dart';

import 'package:neitorcont/src/models/auth_response.dart';
import 'package:neitorcont/src/models/sesison_model.dart';


class LoginController extends ChangeNotifier {
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final _api = ApiProvider();
  AuthResponse? _dataLogin;

  Session? infoUser;

  // AuthResponse? get infoUser  => _dataLogin ;
  bool? _recuerdaCredenciales = true;

  String? _empresa = "",_usuario = "", _clave = "";
  //  _empresa = "PAZVISEG";

  void onChangeUser(String text) {
    _usuario = text;
    // print('_usuario: $_usuario');
  }

  void onChangeClave(String text) {
    _clave = text;
    // print('_clave: $_clave');
  }

  void onChangeEmpresa(String text) {
    _empresa = text;
    //  print('_empresa: $_empresa');
  }

  bool? get getRecuerdaCredenciales => _recuerdaCredenciales;
  String? get getUsuario => _usuario;
  String? get getClave => _clave;
  // String? get getEmpresa => _empresa;

  bool validateForm() {
    if (loginFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

 
// //========================== DROPDOWN MOTIVO AUSENCIA =======================//
//   // String? _labelNombreEmpresa;
//   String? _textNombreEmpresa;

//   // String? get getlabelNombreEmpresa => _labelNombreEmpresa;
//   String? get getlNombreEmpresa => _textNombreEmpresa;

//   void setLabelNombreEmpresa(String value) {
//     // _labelNombreEmpresa = value;
//     _textNombreEmpresa = value;
  
//     // resetListaGuardiasInformes();
//     // print('----_labelNombreEmpresa-:$_labelNombreEmpresa');
//     // print('---_textNombreEmpresa-:$_textNombreEmpresa');
//     notifyListeners();
//   }

  //========================== MENU =======================//
  bool _isOpen = false;
  int _indexMenu = 0;

  void onChangeOpen(bool value) {
    _isOpen = value;

    notifyListeners();
  }

  void onChangeIndex(int index) {
    _indexMenu = index;

    notifyListeners();
  }

  bool get getIsOpen => _isOpen;
  int get getIndexMenu => _indexMenu;

  //========================== CREA TABLA ACTIVIDADES =======================//


 // ========================== LOGIN =======================//
  Future<AuthResponse?> loginApp(BuildContext context) async {
List _creddenciales =[];
    final response = await _api.login(
        empresa: _empresa!.trim(), usuario: _usuario!.trim(), password: _clave!.trim());

    if (response != null) {

        _creddenciales.addAll(['$_recuerdaCredenciales','$_empresa','$_usuario','$_clave']);
//  await Auth.instance.deleteDataRecordarme();

      await Auth.instance.saveSession(response);
      infoUser = await Auth.instance.getSession();
       print('=========++ > ${infoUser}');
       print('=========++ > ${infoUser!.rol}');
       print('====las credenciales de loguearse =====++ > $_creddenciales');
      if(_recuerdaCredenciales==true){
      //  getCredenciales(_creddenciales);
       await Auth.instance.saveDataRecordarme(_creddenciales);

        }
      _dataLogin = response;
      
      // print(_dataLogin!.nomComercial);
      // print('INFO login:$response');




      return response;
    }
    if (response == null) {
      return null;
    }
  }

   //====================================== RECORDAR CLAVE ======================================//
  void onRecuerdaCredenciales(bool value) {
    _recuerdaCredenciales = value;
  print('----_recuerdaCredenciales:$_recuerdaCredenciales');
    notifyListeners();
  }



// List<dynamic> _credencialesInfo=[];
// List<dynamic> get getCredencialesInfo=>_credencialesInfo;
// 




//*******************************************************//
}
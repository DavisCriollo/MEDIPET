import 'package:flutter/material.dart';
import 'package:neitorcont/src/api/api_provider.dart';
import 'package:neitorcont/src/api/authentication_client.dart';
import 'package:neitorcont/src/models/auth_response.dart';
import 'package:neitorcont/src/models/sesison_model.dart';

class HomeController extends ChangeNotifier {
  final _api = ApiProvider();
  GlobalKey<FormState> homeFormKey = GlobalKey<FormState>();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Session? _infoUser;
  Session? get getInfoUser => _infoUser;
  void setInfoUser(Session? _user) {
    _infoUser = _user;
    // print('ESTOS DATOS SON RECIBIDOS:${_infoUser!.rucempresa}');
    notifyListeners();
  }

  AuthResponse? usuarios;
  bool validateForm() {
    if (homeFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }


// //====== OBTIENE LA SESION DEL USUARIO ==========//


  Session? _usuarioInfo;
  Session? get getUsuarioInfo => _usuarioInfo;

  void setUsuarioInfo(Session? _user) {
    _usuarioInfo = _user;
     print('=====_usuarioInfo====++ > ${_usuarioInfo!.empCategoria}');
    notifyListeners();
  }

//   Future validaInicioDeSesion(BuildContext context,) async {
//     final dataUser = await Auth.instance.getSession();
//     //  print( 'token Usuario${dataUser!.token}');

//     final response = await _api.revisaToken(
//       token: dataUser!.token,
//     );

//     if (response != null) {
     
//   //  print('=========++ > ${response}');
//       return response;
//     }
//     if (response == null) {
//       // print('=========++ > ${response}');
//       await Auth.instance.deleteSesion(context);

//       return null;
//     }
//   }
  










}

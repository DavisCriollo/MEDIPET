import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as _http;
import 'package:neitorcont/src/api/authentication_client.dart';
import 'package:neitorcont/src/models/auth_response.dart';
import 'package:neitorcont/src/services/notifications_service.dart' as snaks;
import 'package:neitorcont/src/services/notifications_service.dart';
import 'package:neitorcont/src/models/auth_response.dart';

class ApiProvider {
  final String _url = 'https://contabackend.neitor.com/api';

//================================= LOGIN ==============================//
  Future<AuthResponse?> login({
    BuildContext? context,
    String? usuario,
    String? password,
    String? empresa,
  }) async {
    try {
      final dataResp = await _http.post(
          Uri.parse('https://contabackend.neitor.com/api/auth/login'),
          body: {"usuario": usuario, "password": password, "empresa": empresa});
      final respo = jsonDecode(dataResp.body);

      print('-OKkkkkkR->$respo');

      if (dataResp.statusCode == 404) {
        // print('-OKkkkkkR->$respo');
        snaks.NotificatiosnService.showSnackBarDanger("${respo["msg"]}");
        // return null;
        return null;
      }
      if (dataResp.statusCode == 200) {
        // snaks.NotificatiosnService.showSnackBarDanger("${respo["msg"]}");
        final responsData = AuthResponse.fromMap(respo);
        return responsData;
      }
      if (dataResp.statusCode == 401) {
        Auth.instance.deleteSesion(context!);
        // Auth.instance.deleteIdRegistro();
        // Auth.instance.deleteTurnoSesion();
        return null;
      }
    } catch (e) {
      // snaks.NotificatiosnService.showSnackBarError("SIN RESPUESTA");
      // return null;
    }
  }

//=========================GET ALL COMUNICADOS CLIENTES =====================================//
  Future getAllRecomendaciones({
    BuildContext? context,
    String? token,
  }) async {
    try {
      final url = Uri.parse(
          // 'https://contabackend.neitor.com/api/paises/0');
          '$_url/recomendaciones/filtro/0');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.body.isEmpty) {
        return null;
      }
      // print('RESPONSE:DSDSD ${dataResp.body}');
      if (dataResp.statusCode == 200) {
        final responseData = jsonDecode(dataResp.body);
        // print('INFORMACION DATA paises  $responseData');
        // print('RESPONSE:DSDSD ${dataResp.body}');
        // print('si se ejecuta la accion ');
        return responseData;
      }
      // if (dataResp.statusCode == 401) {
      //   Map<String, dynamic> message = jsonDecode(dataResp.body);

      //   return null;
      // }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        // NotificatiosnService.showSnackBarError("Su Sesión ha Expirado");
        //  Auth.instance.deleteSesion(context!);
        // Auth.instance.deleteIdRegistro();
        // Auth.instance.deleteTurnoSesion();
        return null;
      }
    } catch (e) {
      // NotificatiosnService.showSnackBarError("SIN 11 ");
      return null;
    }
  }

//=========================GET ALL COMUNICADOS CLIENTES =====================================//
  Future getAllPaises({
    BuildContext? context,
    String? token,
  }) async {
    try {
      final url = Uri.parse(
          // 'https://contabackend.neitor.com/api/paises/0');
          '$_url/paises/0');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.body.isEmpty) {
        return null;
      }
      // print('RESPONSE:paises ${dataResp.body}');
      if (dataResp.statusCode == 200) {
        final responseData = jsonDecode(dataResp.body);
        // print('INFORMACION DATA paises  $responseData');
        // print('RESPONSE:DSDSD ${dataResp.body}');
        // print('si se ejecuta la accion ');
        return responseData;
      }
      // if (dataResp.statusCode == 401) {
      //   Map<String, dynamic> message = jsonDecode(dataResp.body);

      //   return null;
      // }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        // NotificatiosnService.showSnackBarError("Su Sesión ha Expirado");
        //  Auth.instance.deleteSesion(context!);
        // Auth.instance.deleteIdRegistro();
        // Auth.instance.deleteTurnoSesion();
        return null;
      }
    } catch (e) {
      // NotificatiosnService.showSnackBarError("SIN 11 ");
      return null;
    }
  }

//=========================GET ALL COMUNICADOS PROVINCIAS =====================================//
  Future getAllProvincias({
    BuildContext? context,
    int? code,
    String? token,
  }) async {
    try {
      final url = Uri.parse(
          // 'https://contabackend.neitor.com/api/provincias/filtro/$code');
          '$_url/provincias/filtro/$code');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.body.isEmpty) {
        return null;
      }
      // print('RESPONSE:DSDSD ${dataResp.body}');
      if (dataResp.statusCode == 200) {
        final responseData = jsonDecode(dataResp.body);
        // print('INFORMACION DATA PROVINCIAS  $responseData');
        // print('RESPONSE:DSDSD ${dataResp.body}');
        // print('si se ejecuta la accion ');
        return responseData;
      }
      // if (dataResp.statusCode == 401) {
      //   Map<String, dynamic> message = jsonDecode(dataResp.body);

      //   return null;
      // }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        // NotificatiosnService.showSnackBarError("Su Sesión ha Expirado");
        //  Auth.instance.deleteSesion(context!);
        // Auth.instance.deleteIdRegistro();
        // Auth.instance.deleteTurnoSesion();
        return null;
      }
    } catch (e) {
      // NotificatiosnService.showSnackBarError("SIN 11 ");
      return null;
    }
  }

//=========================GET ALL COMUNICADOS CANTONES =====================================//
  Future getAllCantones({
    BuildContext? context,
    int? code,
    String? token,
  }) async {
    try {
      final url = Uri.parse('$_url/cantones/filtro/$code');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.body.isEmpty) {
        return null;
      }
      // print('RESPONSE:DSDSD ${dataResp.body}');
      if (dataResp.statusCode == 200) {
        final responseData = jsonDecode(dataResp.body);
        // print('INFORMACION DATA PROVONCIAS  $responseData');
        // print('RESPONSE:DSDSD ${dataResp.body}');
        // print('si se ejecuta la accion ');
        return responseData;
      }
      // if (dataResp.statusCode == 401) {
      //   Map<String, dynamic> message = jsonDecode(dataResp.body);

      //   return null;
      // }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        // NotificatiosnService.showSnackBarError("Su Sesión ha Expirado");
        //  Auth.instance.deleteSesion(context!);
        // Auth.instance.deleteIdRegistro();
        // Auth.instance.deleteTurnoSesion();
        return null;
      }
    } catch (e) {
      // NotificatiosnService.showSnackBarError("SIN 11 ");
      return null;
    }
  }

  //=========================GET ALL PROPIETARIOS =====================================//
  Future getAllPropietarios({
    BuildContext? context,
    String? search,
    String? estado,
    String? token,
  }) async {
    try {
      final url =
          Uri.parse('$_url/proveedores/filtro/0?search=$search&estado=$estado');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.body.isEmpty) {
        return null;
      }
      // print('RESPONSE:AVISOSALIDA ${dataResp.body}');
      if (dataResp.statusCode == 200) {
// print('RESPONSE: ${dataResp.body}');
// print('RESPONSE:DSDSD ${dataResp.body}');
        // final responseData = AllInformesGuardias.fromJson(dataResp.body);

        final responseData = jsonDecode(dataResp.body);
        return responseData;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        // NotificatiosnService.showSnackBarError("Su Sesión ha Expirado");
        //  Auth.instance.deleteSesion(context!);
        // Auth.instance.deleteIdRegistro();
        // Auth.instance.deleteTurnoSesion();
        return null;
      }
    } catch (e) {
      //  NotificatiosnService.showSnackBarError("SIN 19 ");
      return null;
    }
  }
  //=========================GET ALL PROPIETARIOS PAGINACION=====================================//
  Future getAllPropietariosPaginacion({
    // BuildContext? context,
    String? search,
    int? page,
    int? cantidad,
    String? perfil,
    String? input,
    bool? orden,
    String? token,
  }) async {
    try {

// print('cantidad: $cantidad - page: $page, search: $search');




      final url =
          // Uri.parse('$_url/proveedores/filtro/0?search=$search&estado=$estado');
          // Uri.parse('$_url/proveedores/obtenerlistado/0?search=$search&perfil=$perfil&cantidad=$cantidad&page=$page&input=$input&orden=$orden');
          Uri.parse('$_url/proveedores/byPagination/app?search=$search&cantidad=$cantidad&page=$page&input=$input&orden=$orden');

      final dataResp = await _http.post(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.body.isEmpty) {
        return null;
      }
      // print('RESPONSE:CLIENTES ${dataResp.body}');
      if (dataResp.statusCode == 200) {
// print('RESPONSE: ${dataResp.body}');
// print('RESPONSE:DSDSD ${dataResp.body}');
        // final responseData = AllInformesGuardias.fromJson(dataResp.body);

        final responseData = jsonDecode(dataResp.body);

        // print('RESPONSE:DSDSD ${responseData.length}');
        return responseData;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        // NotificatiosnService.showSnackBarError("Su Sesión ha Expirado");
        //  Auth.instance.deleteSesion(context!);
        // Auth.instance.deleteIdRegistro();
        // Auth.instance.deleteTurnoSesion();
        return null;
      }
    } catch (e) {
      //  NotificatiosnService.showSnackBarError("SIN 19 ");
      return null;
    }
  }

  //=========================GET ALL PROPIETARIOS =====================================//
  Future getAllPersonas({
    BuildContext? context,
    String? search,
    String? estado,
    String? token,
  }) async {
    try {
      final url = Uri.parse(
          '$_url/proveedores/filtro/0?search=$search&estado=$estado&edicion=true');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.body.isEmpty) {
        return null;
      }
      // print('RESPONSE: ${dataResp.body}');
      if (dataResp.statusCode == 200) {
// print('RESPONSE: ${dataResp.body}');
// print('RESPONSE:DSDSD ${dataResp.body}');
        // final responseData = AllInformesGuardias.fromJson(dataResp.body);

        final responseData = jsonDecode(dataResp.body);
        return responseData;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        // NotificatiosnService.showSnackBarError("Su Sesión ha Expirado");
        //  Auth.instance.deleteSesion(context!);
        // Auth.instance.deleteIdRegistro();
        // Auth.instance.deleteTurnoSesion();
        return null;
      }
    } catch (e) {
      //  NotificatiosnService.showSnackBarError("SIN 19 ");
      return null;
    }
  }

  //=========================BUSCA ALL PROPIETARIOS =====================================//
  Future searchAllPropietarios({
    BuildContext? context,
    String? search,
    // String? estado,
    String? token,
  }) async {
    try {
      // final url = Uri.parse('$_url/proveedores/agregarperfil/0?search=$search');
      final url = Uri.parse('$_url/proveedores/filtro/0?search=$search');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.body.isEmpty) {
        return null;
      }
      // print('RESPONSE:AVISOSALIDA ${dataResp.body}');
      if (dataResp.statusCode == 200) {
// print('RESPONSE: ${dataResp.body}');
// print('RESPONSE:DSDSD ${dataResp.body}');
        // final responseData = AllInformesGuardias.fromJson(dataResp.body);

        final responseData = jsonDecode(dataResp.body);
        return responseData;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        // NotificatiosnService.showSnackBarError("Su Sesión ha Expirado");
        //  Auth.instance.deleteSesion(context!);
        // Auth.instance.deleteIdRegistro();
        // Auth.instance.deleteTurnoSesion();
        return null;
      }
    } catch (e) {
      //  NotificatiosnService.showSnackBarError("SIN 19 ");
      return null;
    }
  }

  //=========================GET ALL MASCOTAS =====================================//
  Future getAllMascotas({
    BuildContext? context,
    String? search,
    // String? estado,
    String? token,
  }) async {
    try {
      final url = Uri.parse('$_url/mascotas/filtro/0?search=$search');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.body.isEmpty) {
        return null;
      }
      // print('RESPONSE:AVISOSALIDA ${dataResp.body}');
      if (dataResp.statusCode == 200) {
// print('RESPONSE: ${dataResp.body}');
// print('RESPONSE:DSDSD ${dataResp.body}');
        // final responseData = AllInformesGuardias.fromJson(dataResp.body);

        final responseData = jsonDecode(dataResp.body);
        return responseData;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        // NotificatiosnService.showSnackBarError("Su Sesión ha Expirado");
        //  Auth.instance.deleteSesion(context!);
        // Auth.instance.deleteIdRegistro();
        // Auth.instance.deleteTurnoSesion();
        return 401;
      }
    } catch (e) {
      //  NotificatiosnService.showSnackBarError("SIN 19 ");
      return null;
    }
  }



//=========================GET ALL MASCOTAS PAGINACION=====================================//
  Future getAllMascotasPaginacion({
    // BuildContext? context,
    String? search,
    int? page,
    int? cantidad,
    String? documento,
    String? input,
    bool? orden,
    bool? allData,
    String? token,
  }) async {
    try {

// print('cantidad: $cantidad - page: $page, search: $search , input: $input , documento: $documento , allData: $allData');




      final url =
          // Uri.parse('$_url/proveedores/filtro/0?search=$search&estado=$estado');
          Uri.parse('$_url/mascotas?cantidad=$cantidad&page=$page&search=$search&input=$input&orden=$orden&documento=$documento&allData=$allData');
          // Uri.parse('$_url/mascotas?cantidad=$cantidad&page=0&search=lunito&input=mascId&orden=false&documento&allData=true');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.body.isEmpty) {
        return null;
      }
      // print('RESPONSE:AVISOSALIDA ${dataResp.body}');
      if (dataResp.statusCode == 200) {
// print('RESPONSE: ${dataResp.body}');
// print('RESPONSE:DSDSD ${dataResp.body}');
        // final responseData = AllInformesGuardias.fromJson(dataResp.body);

        final responseData = jsonDecode(dataResp.body);

        // print('RESPONSE:DSDSD ${responseData.length}');
        return responseData;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        // NotificatiosnService.showSnackBarError("Su Sesión ha Expirado");
        //  Auth.instance.deleteSesion(context!);
        // Auth.instance.deleteIdRegistro();
        // Auth.instance.deleteTurnoSesion();
        return null;
      }
    } catch (e) {
      //  NotificatiosnService.showSnackBarError("SIN 19 ");
      return null;
    }
  }



  //=========================GET ALL MASCOTAS =====================================//
  Future getAllMascotasPropietario({
    BuildContext? context,
    String? search,
    String? propietario,
    String? token,
  }) async {
    try {
      final url = Uri.parse(
          '$_url/mascotas/mascotaByPropietario/0?propietarioDocumento=$propietario&search=$search');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.body.isEmpty) {
        return null;
      }
      // print('RESPONSE:Propietario ${dataResp.body}');
      if (dataResp.statusCode == 200) {
// print('RESPONSE: ${dataResp.body}');
// print('RESPONSE:DSDSD ${dataResp.body}');
        // final responseData = AllInformesGuardias.fromJson(dataResp.body);

        final responseData = jsonDecode(dataResp.body);
        return responseData;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        // NotificatiosnService.showSnackBarError("Su Sesión ha Expirado");
        //  Auth.instance.deleteSesion(context!);
        // Auth.instance.deleteIdRegistro();
        // Auth.instance.deleteTurnoSesion();
        return 401;
      }
    } catch (e) {
      //  NotificatiosnService.showSnackBarError("SIN 19 ");
      return null;
    }
  }

  //=========================GET ALL MASCOTAS =====================================//
  Future getAllEspecies({
    BuildContext? context,
    String? search,
    // String? estado,
    String? token,
  }) async {
    try {
      final url = Uri.parse('$_url/especies/filtro/0?search=$search');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.body.isEmpty) {
        return null;
      }
      // print('RESPONSE:AVISOSALIDA ${dataResp.body}');
      if (dataResp.statusCode == 200) {
// print('RESPONSE: ${dataResp.body}');
// print('RESPONSE:DSDSD ${dataResp.body}');
        // final responseData = AllInformesGuardias.fromJson(dataResp.body);

        final responseData = jsonDecode(dataResp.body);
        return responseData;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        // NotificatiosnService.showSnackBarError("Su Sesión ha Expirado");
        //  Auth.instance.deleteSesion(context!);
        // Auth.instance.deleteIdRegistro();
        // Auth.instance.deleteTurnoSesion();
        return null;
      }
    } catch (e) {
      //  NotificatiosnService.showSnackBarError("SIN 19 ");
      return null;
    }
  }

  //=========================GET ALL MASCOTAS =====================================//
  Future getAllAlimentos({
    BuildContext? context,
    String? search,
    // String? estado,
    String? token,
  }) async {
    try {
      final url = Uri.parse('$_url/alimentos/filtro/0?search=$search');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.body.isEmpty) {
        return null;
      }
      // print('RESPONSE:AVISOSALIDA ${dataResp.body}');
      if (dataResp.statusCode == 200) {
// print('RESPONSE: ${dataResp.body}');
// print('RESPONSE:DSDSD ${dataResp.body}');
        // final responseData = AllInformesGuardias.fromJson(dataResp.body);

        final responseData = jsonDecode(dataResp.body);
        return responseData;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        // NotificatiosnService.showSnackBarError("Su Sesión ha Expirado");
        //  Auth.instance.deleteSesion(context!);
        // Auth.instance.deleteIdRegistro();
        // Auth.instance.deleteTurnoSesion();
        return null;
      }
    } catch (e) {
      //  NotificatiosnService.showSnackBarError("SIN 19 ");
      return null;
    }
  }

  //=========================GET ALL MASCOTAS =====================================//
  Future getAllSexoMascota({
    BuildContext? context,
    String? search,
    // String? estado,
    String? token,
  }) async {
    try {
      final url = Uri.parse('$_url/sexo/filtro/0?search=$search');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.body.isEmpty) {
        return null;
      }
      // print('RESPONSE:AVISOSALIDA ${dataResp.body}');
      if (dataResp.statusCode == 200) {
// print('RESPONSE: ${dataResp.body}');
// print('RESPONSE:DSDSD ${dataResp.body}');
        // final responseData = AllInformesGuardias.fromJson(dataResp.body);

        final responseData = jsonDecode(dataResp.body);
        return responseData;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        // NotificatiosnService.showSnackBarError("Su Sesión ha Expirado");
        //  Auth.instance.deleteSesion(context!);
        // Auth.instance.deleteIdRegistro();
        // Auth.instance.deleteTurnoSesion();
        return null;
      }
    } catch (e) {
      //  NotificatiosnService.showSnackBarError("SIN 19 ");
      return null;
    }
  }

//=========================GET ALL HISTORIAS CLINICAS =====================================//
  Future getAllHistoriasClinicas({
    BuildContext? context,
    String? search,
    // String? estado,
    String? token,
  }) async {
    try {
      final url = Uri.parse('$_url/historiasclinicas/filtro/0?search=$search');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.body.isEmpty) {
        return null;
      }
      print('RESPONSE:AVISOSALIDA ${dataResp.body}');
      if (dataResp.statusCode == 200) {
// print('RESPONSE: ${dataResp.body}');
// print('RESPONSE:DSDSD ${dataResp.body}');
        // final responseData = AllInformesGuardias.fromJson(dataResp.body);

        final responseData = jsonDecode(dataResp.body);
        return responseData;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        // NotificatiosnService.showSnackBarError("Su Sesión ha Expirado");
        //  Auth.instance.deleteSesion(context!);
        // Auth.instance.deleteIdRegistro();
        // Auth.instance.deleteTurnoSesion();
        return 401;
      }
    } catch (e) {
      //  NotificatiosnService.showSnackBarError("SIN 19 ");
      return null;
    }
  }


//=========================GET ALL HISTORIAS CLINICAS =====================================//
  Future getAllHistoriasClinicasPaginacion({
    BuildContext? context,
       String? search,
    int? page,
    int? cantidad,

    String? input,
    bool? orden,
    bool? hcliMascId,
    String? token,
  }) async {
    try {
      // final url = Uri.parse('$_url/historiasclinicas/filtro/0?search=$search');
      final url = Uri.parse('$_url/historiasclinicas?cantidad=$cantidad&page=$page&search=$search&input=$input&orden=orden&hcliMascId');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.body.isEmpty) {
        return null;
      }
      // print('RESPONSE:AVISOSALIDA ${dataResp.body}');
      if (dataResp.statusCode == 200) {
// print('RESPONSE: ${dataResp.body}');
// print('RESPONSE:DSDSD ${dataResp.body}');
        // final responseData = AllInformesGuardias.fromJson(dataResp.body);

        final responseData = jsonDecode(dataResp.body);
        return responseData;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        // NotificatiosnService.showSnackBarError("Su Sesión ha Expirado");
        //  Auth.instance.deleteSesion(context!);
        // Auth.instance.deleteIdRegistro();
        // Auth.instance.deleteTurnoSesion();
        return 401;
      }
    } catch (e) {
      //  NotificatiosnService.showSnackBarError("SIN 19 ");
      return null;
    }
  }
//=========================GET ALL VACUNAS =====================================//
  Future getAllVacunas({
    BuildContext? context,
    String? search,
    // String? estado,
    String? token,
  }) async {
    try {
      final url = Uri.parse('$_url/carnetvacunas/filtro/0?search=$search');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.body.isEmpty) {
        return null;
      }
      // print('RESPONSE:AVISOSALIDA ${dataResp.body}');
      if (dataResp.statusCode == 200) {
// print('RESPONSE: ${dataResp.body}');
// print('RESPONSE:DSDSD ${dataResp.body}');
        // final responseData = AllInformesGuardias.fromJson(dataResp.body);

        final responseData = jsonDecode(dataResp.body);
        return responseData;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        // NotificatiosnService.showSnackBarError("Su Sesión ha Expirado");
        //  Auth.instance.deleteSesion(context!);
        // Auth.instance.deleteIdRegistro();
        // Auth.instance.deleteTurnoSesion();
        return 401;
      }
    } catch (e) {
      //  NotificatiosnService.showSnackBarError("SIN 19 ");
      return null;
    }
  }
//=========================GET ALL PROPIETARIOS PAGINACION=====================================//
  Future getAllVacunasPaginacion({
    // BuildContext? context,
    String? search,
    int? page,
    int? cantidad,
  
    String? input,
    bool? orden,
    int? idmascota,
    String? token,
  }) async {
    try {

// print('cantidad: $cantidad - page: $page, search: $search , input: $input , documento: $documento , allData: $allData');




      final url =
         
          Uri.parse('$_url/carnetvacunas?cantidad=$cantidad&page=$page&search=$search&input=$input&orden=$orden&idmascota');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.body.isEmpty) {
        return null;
      }
      // print('RESPONSE:AVISOSALIDA ${dataResp.body}');
      if (dataResp.statusCode == 200) {


        final responseData = jsonDecode(dataResp.body);

        // print('RESPONSE:DSDSD ${responseData.length}');
        return responseData;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        // NotificatiosnService.showSnackBarError("Su Sesión ha Expirado");
        //  Auth.instance.deleteSesion(context!);
        // Auth.instance.deleteIdRegistro();
        // Auth.instance.deleteTurnoSesion();
        return null;
      }
    } catch (e) {
      //  NotificatiosnService.showSnackBarError("SIN 19 ");
      return null;
    }
  }



//=========================GET ALL RECETAS =====================================//
  Future getAllRecetas({
    BuildContext? context,
    String? search,
    // String? estado,
    String? token,
  }) async {
    try {
      final url = Uri.parse('$_url/recetas/filtro/0?search=$search');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.body.isEmpty) {
        return null;
      }
      // print('RESPONSE:AVISOSALIDA ${dataResp.body}');
      if (dataResp.statusCode == 200) {
// print('RESPONSE: ${dataResp.body}');
// print('RESPONSE:DSDSD ${dataResp.body}');
        // final responseData = AllInformesGuardias.fromJson(dataResp.body);

        final responseData = jsonDecode(dataResp.body);
        return responseData;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        // NotificatiosnService.showSnackBarError("Su Sesión ha Expirado");
        //  Auth.instance.deleteSesion(context!);
        // Auth.instance.deleteIdRegistro();
        // Auth.instance.deleteTurnoSesion();
        return 401;
      }
    } catch (e) {
      //  NotificatiosnService.showSnackBarError("SIN 19 ");
      return null;
    }
  }


//=========================GET ALL RECETAS =====================================//
  Future getAllRecetasPaginacion({
    BuildContext? context,
     String? search,
    int? page,
    int? cantidad,
  
    String? input,
    bool? orden,
    int? idmascota,
    String? token,
  }) async {
    try {
      // final url = Uri.parse('$_url/recetas/filtro/0?search=$search');
      final url = Uri.parse('$_url/recetas?cantidad=$cantidad&page=$page&search=$search&input=$input&orden=$orden&idmascota');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.body.isEmpty) {
        return null;
      }
      // print('RESPONSE:AVISOSALIDA ${dataResp.body}');
      if (dataResp.statusCode == 200) {
// print('RESPONSE: ${dataResp.body}');
// print('RESPONSE:DSDSD ${dataResp.body}');
        // final responseData = AllInformesGuardias.fromJson(dataResp.body);

        final responseData = jsonDecode(dataResp.body);
        return responseData;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        // NotificatiosnService.showSnackBarError("Su Sesión ha Expirado");
        //  Auth.instance.deleteSesion(context!);
        // Auth.instance.deleteIdRegistro();
        // Auth.instance.deleteTurnoSesion();
        return 401;
      }
    } catch (e) {
      //  NotificatiosnService.showSnackBarError("SIN 19 ");
      return null;
    }
  }
//=========================GET ALL RECETAS =====================================//
  Future getAllMedicinas({
    BuildContext? context,
    String? search,
    // String? estado,
    String? token,
  }) async {
    try {
      final url = Uri.parse('$_url/inventario/filtro/0?search=$search');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.body.isEmpty) {
        return null;
      }
      // print('RESPONSE:AVISOSALIDA ${dataResp.body}');
      if (dataResp.statusCode == 200) {
// print('RESPONSE: ${dataResp.body}');
// print('RESPONSE:DSDSD ${dataResp.body}');
        // final responseData = AllInformesGuardias.fromJson(dataResp.body);

        final responseData = jsonDecode(dataResp.body);
        return responseData;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        // NotificatiosnService.showSnackBarError("Su Sesión ha Expirado");
        //  Auth.instance.deleteSesion(context!);
        // Auth.instance.deleteIdRegistro();
        // Auth.instance.deleteTurnoSesion();
        return null;
      }
    } catch (e) {
      //  NotificatiosnService.showSnackBarError("SIN 19 ");
      return null;
    }
  }

//=========================GET ALL [PARAMETROS] =====================================//
  Future getAllParametros({
    BuildContext? context,
    String? search,
    // String? estado,
    String? token,
  }) async {
    try {
      final url = Uri.parse('$_url/parametros/filtro/0?search=$search');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.body.isEmpty) {
        return null;
      }
      // print('RESPONSE:AVISOSALIDA ${dataResp.body}');
      if (dataResp.statusCode == 200) {
// print('RESPONSE: ${dataResp.body}');
// print('RESPONSE:DSDSD ${dataResp.body}');
        // final responseData = AllInformesGuardias.fromJson(dataResp.body);

        final responseData = jsonDecode(dataResp.body);
        return responseData;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        // NotificatiosnService.showSnackBarError("Su Sesión ha Expirado");
        //  Auth.instance.deleteSesion(context!);
        // Auth.instance.deleteIdRegistro();
        // Auth.instance.deleteTurnoSesion();
        return null;
      }
    } catch (e) {
      //  NotificatiosnService.showSnackBarError("SIN 19 ");
      return null;
    }
  }

// //=========================GET ALL TIPO CONSULTAS =====================================//
//   Future getAllTipoConsultas({
//     BuildContext? context,
//     String? search,
//     // String? estado,
//     String? token,
//   }) async {
//     try {
//       final url = Uri.parse('$_url/inventario/filtro/0?search=$search');

//       final dataResp = await _http.get(
//         url,
//         headers: {"x-auth-token": '$token'},
//       );

//       if (dataResp.body.isEmpty) {
//         return null;
//       }
//       // print('RESPONSE:AVISOSALIDA ${dataResp.body}');
//       if (dataResp.statusCode == 200) {
// // print('RESPONSE: ${dataResp.body}');
// // print('RESPONSE:DSDSD ${dataResp.body}');
//         // final responseData = AllInformesGuardias.fromJson(dataResp.body);

//         final responseData = jsonDecode(dataResp.body);
//         return responseData;
//       }
//       if (dataResp.statusCode == 404) {
//         return null;
//       }
//       if (dataResp.statusCode == 401) {
//         //  Auth.instance.deleteSesion(context!);
//         // Auth.instance.deleteIdRegistro();
//         // Auth.instance.deleteTurnoSesion();
//         return null;
//       }
//     } catch (e) {
//       //  NotificatiosnService.showSnackBarError("SIN 19 ");
//       return null;
//     }
//   }

//=========================GET ALL HOSPITALIZACION =====================================//
  Future getAllHospitalizaciones({
    BuildContext? context,
    String? search,
    // String? estado,
    String? token,
  }) async {
    try {
      final url = Uri.parse('$_url/hospitalizacion/filtro/0?search=$search');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.body.isEmpty) {
        return null;
      }
      // print('RESPONSE:HOSPITALIZACION ${dataResp.body}');
      if (dataResp.statusCode == 200) {
        final responseData = jsonDecode(dataResp.body);
        return responseData;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        //  NotificatiosnService.showSnackBarError("Su Sesión ha Expirado");
        //  Auth.instance.deleteSesion(context!);
        // Auth.instance.deleteIdRegistro();
        // Auth.instance.deleteTurnoSesion();
        return 401;
      }
    } catch (e) {
      //  NotificatiosnService.showSnackBarError("SIN 19 ");
      return null;
    }
  }
//=========================GET ALL HOSPITALIZACION =====================================//
  Future getAllHospitalizacionesPaginacion({
    BuildContext? context,
      String? search,
    int? page,
    int? cantidad,

    String? input,
    bool? orden,
    bool? idmascota,
    String? token,
  }) async {
    try {
      // final url = Uri.parse('$_url/hospitalizacion/filtro/0?search=$search');
      final url = Uri.parse('$_url/hospitalizacion?cantidad=$cantidad&page=$page&search=$search&input=$input&orden=$orden&idmascota');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.body.isEmpty) {
        return null;
      }
      // print('RESPONSE:HOSPITALIZACION ${dataResp.body}');
      if (dataResp.statusCode == 200) {
        final responseData = jsonDecode(dataResp.body);
        return responseData;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        //  NotificatiosnService.showSnackBarError("Su Sesión ha Expirado");
        //  Auth.instance.deleteSesion(context!);
        // Auth.instance.deleteIdRegistro();
        // Auth.instance.deleteTurnoSesion();
        return 401;
      }
    } catch (e) {
      //  NotificatiosnService.showSnackBarError("SIN 19 ");
      return null;
    }
  }

//=========================GET ALL PELUQUERIA =====================================//
  Future getAllPeluqueria({
    BuildContext? context,
    String? search,
    // String? estado,
    String? token,
  }) async {
    try {
      final url = Uri.parse('$_url/peluqueria/filtro/0?search=$search');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.body.isEmpty) {
        return null;
      }
      // print('RESPONSE:AVISOSALIDA ${dataResp.body}');
      if (dataResp.statusCode == 200) {
// print('RESPONSE: ${dataResp.body}');
// print('RESPONSE:DSDSD ${dataResp.body}');
        // final responseData = AllInformesGuardias.fromJson(dataResp.body);

        final responseData = jsonDecode(dataResp.body);
        return responseData;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        // NotificatiosnService.showSnackBarError("Su Sesión ha Expirado");
        //  Auth.instance.deleteSesion(context!);
        // Auth.instance.deleteIdRegistro();
        // Auth.instance.deleteTurnoSesion();
        return 401;
      }
    } catch (e) {
      //  NotificatiosnService.showSnackBarError("SIN 19 ");
      return null;
    }
  }
//=========================GET ALL PELUQUERIA =====================================//
  Future getAllPeluqueriaPaginacion({
    BuildContext? context,
      String? search,
    int? page,
    int? cantidad,

    String? input,
    bool? orden,
    bool? allData,
    String? token,
  }) async {
    try {
      // final url = Uri.parse('$_url/peluqueria/filtro/0?search=$search');
      final url = Uri.parse('$_url/peluqueria?cantidad=$cantidad&page=$page&search=$search&input=$input&orden=$orden&allData=$allData');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.body.isEmpty) {
        return null;
      }
      // print('RESPONSE:AVISOSALIDA ${dataResp.body}');
      if (dataResp.statusCode == 200) {
// print('RESPONSE: ${dataResp.body}');
// print('RESPONSE:DSDSD ${dataResp.body}');
        // final responseData = AllInformesGuardias.fromJson(dataResp.body);

        final responseData = jsonDecode(dataResp.body);
        return responseData;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        // NotificatiosnService.showSnackBarError("Su Sesión ha Expirado");
        //  Auth.instance.deleteSesion(context!);
        // Auth.instance.deleteIdRegistro();
        // Auth.instance.deleteTurnoSesion();
        return 401;
      }
    } catch (e) {
      //  NotificatiosnService.showSnackBarError("SIN 19 ");
      return null;
    }
  }
//=========================GET ALL PELUQUERIA =====================================//
  Future getAllPedidosPeluqueria({
    BuildContext? context,
    String? search,
    // String? estado,
    String? token,
  }) async {
    try {
      final url = Uri.parse('$_url/pedidospeluqueria/filtro/0?search=$search');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.body.isEmpty) {
        return null;
      }
      // print('RESPONSE:AVISOSALIDA ${dataResp.body}');
      if (dataResp.statusCode == 200) {
// print('RESPONSE: ${dataResp.body}');
// print('RESPONSE:DSDSD ${dataResp.body}');
        // final responseData = AllInformesGuardias.fromJson(dataResp.body);

        final responseData = jsonDecode(dataResp.body);
        return responseData;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        // NotificatiosnService.showSnackBarError("Su Sesión ha Expirado");
        //  Auth.instance.deleteSesion(context!);
        // Auth.instance.deleteIdRegistro();
        // Auth.instance.deleteTurnoSesion();
        return null;
      }
    } catch (e) {
      //  NotificatiosnService.showSnackBarError("SIN 19 ");
      return null;
    }
  }

//=========================GET ALL PROPIETARIOS =====================================//
  Future getAllTipoConsultas({
    BuildContext? context,
    String? search,
    // String? estado,
    String? token,
  }) async {
    try {
      final url = Uri.parse('$_url/consultasmedicas/filtro/0?search=$search');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.body.isEmpty) {
        return null;
      }
      // print('RESPONSE: ${dataResp.body}');
      if (dataResp.statusCode == 200) {
// print('RESPONSE: ${dataResp.body}');
// print('RESPONSE:DSDSD ${dataResp.body}');
        // final responseData = AllInformesGuardias.fromJson(dataResp.body);

        final responseData = jsonDecode(dataResp.body);
        return responseData;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        // NotificatiosnService.showSnackBarError("Su Sesión ha Expirado");
        //  Auth.instance.deleteSesion(context!);
        // Auth.instance.deleteIdRegistro();
        // Auth.instance.deleteTurnoSesion();
        return null;
      }
    } catch (e) {
      //  NotificatiosnService.showSnackBarError("SIN 19 ");
      return null;
    }
  }

//=========================GET ALL PROPIETARIOS =====================================//
  Future getAllProductos({
    BuildContext? context,
    // String? search,
    String? tipo,
    String? token,
  }) async {
    try {
      final url = Uri.parse('$_url/inventario/categoria/0?tipo=$tipo');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.body.isEmpty) {
        return null;
      }
      // print('RESPONSE: ${dataResp.body}');
      if (dataResp.statusCode == 200) {
// print('RESPONSE: ${dataResp.body}');
// print('RESPONSE:DSDSD ${dataResp.body}');
        // final responseData = AllInformesGuardias.fromJson(dataResp.body);

        final responseData = jsonDecode(dataResp.body);
        return responseData;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        // NotificatiosnService.showSnackBarError("Su Sesión ha Expirado");
        //  Auth.instance.deleteSesion(context!);
        // Auth.instance.deleteIdRegistro();
        // Auth.instance.deleteTurnoSesion();
        return null;
      }
    } catch (e) {
      //  NotificatiosnService.showSnackBarError("SIN 19 ");
      return null;
    }
  }

//================================= RECOPERA TOKEN DEL SERVIDOR ==============================//
  Future revisaToken(
    String? token, {
    BuildContext? context,
    // String? tokennotificacion,
    // String token,
  }) async {
    try {
      final url = Uri.parse('https://contabackend.neitor.com/api/auth');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );
      //  print('RESPONSE NOTIFICACIONES 2: ${dataResp}');

      if (dataResp.body.isEmpty) {
        //  NotificatiosnService.showSnackBarError("No ha iniciado Turno ");
        return null;
      }

      if (dataResp.statusCode == 200) {
        final responseData = jsonDecode(dataResp.body);
        //  print('RESPONSE NOTIFICACIONES 2: ${responseData['data']}');
        // print('RESPONSE NOTIFICACIONES 2: ${responseData['data']}');

        return responseData;
        // return dataResp.body;
      }
      if (dataResp.statusCode == 404) {
        //  NotificatiosnService.showSnackBarError("No ha iniciado Turno ");
        return 404;
      }
      if (dataResp.statusCode == 401) {
        //  Auth.instance.deleteSesion(context!);
        // Auth.instance.deleteIdRegistro();
        // Auth.instance.deleteTurnoSesion();
        return 401;
      }
    } catch (e) {
      //  NotificatiosnService.showSnackBarError("SIN $e['msg'] ");
      return null;
    }
  }

//=========================GET ALL VACUNAS =====================================//
  Future getAllFacturas({
    BuildContext? context,
    String? search,
    String? ruccliente,
    String? token,
  }) async {
    try {
      // final url = Uri.parse('$_url/carnetvacunas/filtro/0?search=$search');
      final url = Uri.parse(
          // '$_url/ventas/filtro/0?ruccliente=1003163175&search=$search');
          '$_url/ventas?cantidad=10&page=0&search&input=venId&orden=false&estado=FACTURAS');

//           FACTURAS,
// NOTA VENTAS, ->prefactura
// PROFORMAS
// NOTA CREDITOS,
// ANULADA

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.body.isEmpty) {
        return null;
      }
      print('RESPONSE:AVISOSALIDA ${dataResp.body}');
      if (dataResp.statusCode == 200) {
        if (dataResp.body.isNotEmpty) {
          final responseData = jsonDecode(dataResp.body);
          return responseData;
        }
// print('RESPONSE:DSDSD ${dataResp.body}');
        // final responseData = AllInformesGuardias.fromJson(dataResp.body);

        // final responseData = jsonDecode(dataResp.body);
        // return responseData;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        // NotificatiosnService.showSnackBarError("Su Sesión ha Expirado");
        //  Auth.instance.deleteSesion(context!);
        // Auth.instance.deleteIdRegistro();
        // Auth.instance.deleteTurnoSesion();
        return 401;
      }
    } catch (e) {
      //  NotificatiosnService.showSnackBarError("SIN 19 ");
      return null;
    }
  }

  //=========================GET ALL facturas PAGINACION=====================================//
  Future getAllFacturasPaginacion({
     String? search,
    int? page,
    int? cantidad,
    String? input,
    bool? orden,
    String? estado,
    String? token,
  }) async {
    try {

      final url =
          // Uri.parse('$_url/proveedores/filtro/0?search=$search&estado=$estado');
          Uri.parse('$_url/ventas?cantidad=$cantidad&page=$page&search=$search&input=$input&orden=$orden&estado=$estado');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.body.isEmpty) {
        return null;
      }
      // print('RESPONSE:AVISOSALIDA ${dataResp.body}');
      if (dataResp.statusCode == 200) {


        final responseData = jsonDecode(dataResp.body);

        return responseData;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
     
        return null;
      }
    } catch (e) {
      //  NotificatiosnService.showSnackBarError("SIN 19 ");
      return null;
    }
  }
  //=========================GET ALL facturas PAGINACION=====================================//
  Future getAllPreFacturasPaginacion({
     String? search,
    int? page,
    int? cantidad,
    String? input,
    bool? orden,
    String? estado,
    String? token,
  }) async {
    try {

      final url =
          // Uri.parse('$_url/proveedores/filtro/0?search=$search&estado=$estado');
          Uri.parse('$_url/ventas?cantidad=$cantidad&page=$page&search=$search&input=$input&orden=$orden&estado=$estado');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.body.isEmpty) {
        return null;
      }
      // print('RESPONSE:AVISOSALIDA ${dataResp.body}');
      if (dataResp.statusCode == 200) {


        final responseData = jsonDecode(dataResp.body);

        return responseData;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
     
        return null;
      }
    } catch (e) {
      //  NotificatiosnService.showSnackBarError("SIN 19 ");
      return null;
    }
  }
//=========================GET ALL facturas PAGINACION=====================================//
  Future getAllProformasPaginacion({
     String? search,
    int? page,
    int? cantidad,
    String? input,
    bool? orden,
    String? estado,
    String? token,
  }) async {
    try {

      final url =
          // Uri.parse('$_url/proveedores/filtro/0?search=$search&estado=$estado');
          Uri.parse('$_url/ventas?cantidad=$cantidad&page=$page&search=$search&input=$input&orden=$orden&estado=$estado');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.body.isEmpty) {
        return null;
      }
      // print('RESPONSE:AVISOSALIDA ${dataResp.body}');
      if (dataResp.statusCode == 200) {


        final responseData = jsonDecode(dataResp.body);

        return responseData;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
     
        return null;
      }
    } catch (e) {
      //  NotificatiosnService.showSnackBarError("SIN 19 ");
      return null;
    }
  }
//=========================GET ALL facturas PAGINACION=====================================//
  Future getAllNotasCreditoPaginacion({
     String? search,
    int? page,
    int? cantidad,
    String? input,
    bool? orden,
    String? estado,
    String? token,
  }) async {
    try {

      final url =
          // Uri.parse('$_url/proveedores/filtro/0?search=$search&estado=$estado');
          Uri.parse('$_url/ventas?cantidad=$cantidad&page=$page&search=$search&input=$input&orden=$orden&estado=$estado');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.body.isEmpty) {
        return null;
      }
      // print('RESPONSE:AVISOSALIDA ${dataResp.body}');
      if (dataResp.statusCode == 200) {


        final responseData = jsonDecode(dataResp.body);

        return responseData;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
     
        return null;
      }
    } catch (e) {
      //  NotificatiosnService.showSnackBarError("SIN 19 ");
      return null;
    }
  }
//=========================GET ALL facturas PAGINACION=====================================//
  Future getAllAnuladasPaginacion({
     String? search,
    int? page,
    int? cantidad,
    String? input,
    bool? orden,
    String? estado,
    String? token,
  }) async {
    try {

      final url =
          // Uri.parse('$_url/proveedores/filtro/0?search=$search&estado=$estado');
          Uri.parse('$_url/ventas?cantidad=$cantidad&page=$page&search=$search&input=$input&orden=$orden&estado=$estado');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.body.isEmpty) {
        return null;
      }
      // print('RESPONSE:AVISOSALIDA ${dataResp.body}');
      if (dataResp.statusCode == 200) {


        final responseData = jsonDecode(dataResp.body);

        return responseData;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
     
        return null;
      }
    } catch (e) {
      //  NotificatiosnService.showSnackBarError("SIN 19 ");
      return null;
    }
  }
//=========================GET ALL VACUNAS =====================================//
  Future getAllTutoriales({
    BuildContext? context,
    String? search,
    String? token,
  }) async {
    try {
      // final url = Uri.parse('$_url/carnetvacunas/filtro/0?search=$search');
      final url = Uri.parse('$_url/tutoriales/filtro/0?search=$search');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.body.isEmpty) {
        return null;
      }
      // print('RESPONSE:TUTORIALES ${dataResp.body}');
      if (dataResp.statusCode == 200) {
        if (dataResp.body.isNotEmpty) {
          final responseData = jsonDecode(dataResp.body);
          return responseData;
        }

      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        
        return 401;
      }
    } catch (e) {
      //  NotificatiosnService.showSnackBarError("SIN 19 ");
      return null;
    }
  }

//=========================DELETE FOTO MASCOTA =====================================//
  Future deleteDocumento({
    BuildContext? context,
    String? token,
    List<Map<String, String?>>? info,
  }) async {
    try {
      final _data = json.encode(info);

      var response = await _http.post(
          Uri.parse(
              'https://contabackend.neitor.com/api/upload_delete_multiple_files/delete'),
          headers: {
            "Content-Type": "application/json",
            "x-auth-token": '$token'
          },
          body: _data);

      if (response.statusCode == 200) {
// print('RESPONSE:DSDSD ${response.body}');
        if (response.body.isNotEmpty) {
          final responseData = jsonDecode(response.body);
          return responseData;
        }
        if (response.statusCode == 404) {
          // print('-OKkkkkkR->$respo');
          // snaks.NotificatiosnService.showSnackBarDanger("${response["msg"]}");
          // return null;
          return null;
        }
      }
      if (response.statusCode == 404) {
        return null;
      }
      if (response.statusCode == 401) {
        return 401;
      }
    } catch (e) {
      //  NotificatiosnService.showSnackBarError("SIN 19 ");
      return null;
    }
  }

//=========================SAVE IMAGEN MASCOTA  =====================================//
  final Dio _dio = Dio();
  Future saveDocumento({
    BuildContext? context,
    String? token,
    FormData? formData,
  }) async {
    try {
      final response = await _dio.post(
          "https://contabackend.neitor.com/api/upload_delete_multiple_files/upload",
          options: Options(
            headers: {"x-auth-token": '$token'},
            validateStatus: (_) => true,
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
          ),
          data: formData);

      if (response.statusCode == 200) {
// print('RESPONSE:DSDSD ${response.body}');
        if (response.data.isNotEmpty) {
          // final responseData = jsonDecode(response.data);
          return response.data['nombre'];
        }
        if (response.statusCode == 404) {
          return null;
        }
      }
      if (response.statusCode == 404) {
        return null;
      }
      if (response.statusCode == 401) {
        return 401;
      }
    } catch (e) {
      //  NotificatiosnService.showSnackBarError("SIN 19 ");
      return null;
    }
  }

 //=========================GET ALL facturas PAGINACION=====================================//
  Future getAllReservasPaginacion({
     String? search,
    int? page,
    int? cantidad,
    String? input,
    bool? orden,
    // String? estado,
    String? token,
  }) async {
    try {

      final url =
          // Uri.parse('$_url/proveedores/filtro/0?search=$search&estado=$estado');
          // Uri.parse('$_url/reservas?cantidad=$cantidad&page=$page&search=$search&input=$input&orden=$orden');
          Uri.parse('$_url/reservas?cantidad=$cantidad&page=$page&search=$search&input=$input&orden=$orden');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.body.isEmpty) {
        return null;
      }
      // print('RESPONSE:AVISOSALIDA ${dataResp.body}');
      if (dataResp.statusCode == 200) {


        final responseData = jsonDecode(dataResp.body);

        return responseData;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
     
        return null;
      }
    } catch (e) {
      //  NotificatiosnService.showSnackBarError("SIN 19 ");
      return null;
    }
  }

//=========================GET ALL TIPO DE RESERVAS =====================================//
  Future getAllTipoReservas({
    // BuildContext? context,
     String? search,
    String? token,
  }) async {
    try {
      final url = Uri.parse(
          // 'https://contabackend.neitor.com/api/paises/0');
          '$_url/tiporeservas/filtro/0?search=$search');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.body.isEmpty) {
        return null;
      }
      // print('RESPONSE:DSDSD ${dataResp.body}');
      if (dataResp.statusCode == 200) {
        final responseData = jsonDecode(dataResp.body);
        // print('INFORMACION DATA paises  $responseData');
        // print('RESPONSE:DSDSD ${dataResp.body}');
        // print('si se ejecuta la accion ');
        return responseData;
      }
      // if (dataResp.statusCode == 401) {
      //   Map<String, dynamic> message = jsonDecode(dataResp.body);

      //   return null;
      // }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
       
        return null;
      }
    } catch (e) {
      // NotificatiosnService.showSnackBarError("SIN 11 ");
      return null;
    }
  }



  //=========================BUSCA  cliente =====================================//
  Future searchCliente({
    BuildContext? context,
    String? search,
    // String? estado,
    String? token,
  }) async {
    try {
      // final url = Uri.parse('$_url/proveedores/agregarperfil/0?search=$search');
      final url = Uri.parse('$_url/proveedores/searchByCedulaOfRuc/0?search=$search');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.body.isEmpty) {
        return null;
      }
      print('RESPONSE:AVISOSALIDA ${dataResp.body}');
      if (dataResp.statusCode == 200) {
// print('RESPONSE: ${dataResp.body}');
// print('RESPONSE:DSDSD ${dataResp.body}');
        // final responseData = AllInformesGuardias.fromJson(dataResp.body);

        final responseData = jsonDecode(dataResp.body);
        return responseData;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        // NotificatiosnService.showSnackBarError("Su Sesión ha Expirado");
        //  Auth.instance.deleteSesion(context!);
        // Auth.instance.deleteIdRegistro();
        // Auth.instance.deleteTurnoSesion();
        return null;
      }
    } catch (e) {
      //  NotificatiosnService.showSnackBarError("SIN 19 ");
      return null;
    }
  }







}

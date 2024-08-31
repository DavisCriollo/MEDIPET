import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:neitorcont/src/models/auth_response.dart';
import 'package:neitorcont/src/models/sesison_model.dart';

class Auth {
  Auth.internal();
  static final Auth _instance = Auth.internal();
  static Auth get instance => _instance;

  final _storage = const FlutterSecureStorage();
  final keySESION = 'SESSION';
  // final keyTURNO = 'TURNO';
  final keyCREDENCIALES = 'CEDENCIALES';
  // final keyTOKENFIREBASE = 'TOKENFIREBASE';
  // final keyRONDAS = 'RONDASACTIVIDAD';
  // final keyIDREGISTRO = 'IDREGISTRO';

// GUARDO LA INFORMACION EN EL DISPOSITIVO
  Future<void> saveSession(AuthResponse data) async {
    final Session session = Session(
      token: data.token,
      id: data.id,
      nombre: data.nombre,
      usuario: data.usuario,
      rucempresa: data.rucempresa,
      codigo: data.codigo,
      nomEmpresa: data.nomEmpresa,
      nomComercial: data.nomComercial,
      fechaCaducaFirma: data.fechaCaducaFirma,
      rol: data.rol!,
      empCategoria: data.empCategoria,
      logo: data.logo,
      foto: data.foto,
      colorPrimario: data.colorPrimario,
      colorSecundario: data.colorSecundario,
      
      iva: data.iva,
      permisosUsuario: data.permisosUsuario,
      ciudad: data.ciudad,
      sector: data.sector
    );
// CONVERTIMOS  LA INFORMACION  A STRING PARA GUARDAR AL DISPOSITIVO
    final String value = jsonEncode(session.toJson());
// GUARDAMOS LA INFORMACION DEL DISPOSITIVO

print('guardado enel dispositivo la ssesion: $value');

    await _storage.write(key: keySESION, value: value);
  }

// OBTEMENOS LA INFORMACION DEL DISPOSITIVO
  Future<Session?> getSession() async {
    final String? value = await _storage.read(key: keySESION);
    if (value != null) {
      // final Map<String, dynamic> json = jsonDecode(value);
      final session = Session.fromJson(jsonDecode(value));
      return session;
    }
    return null;
  }

  // CIERRO SESSION
  Future<void> deleteSesion(BuildContext context) async {
    // await _storage.deleteAll();
    await _storage.delete(key: keySESION);
    Navigator.pushNamedAndRemoveUntil(context, 'login', (_) => false);
  }

//   // ============================================= TOKEN FIREBASE =======================//

//   Future<void> saveTokenFireBase(String data) async {
// // GUARDAMOS LA INFORMACION DEL DISPOSITIVO
//       await _storage.write(key: keyTOKENFIREBASE, value: data);
//      print('TOKEN DE FIREBASE GUARDADO DISPOSITIVO');

//   }

//   // OBTEMENOS EL TOKENFIREBASE   DEL DISPOSITIVO
//   Future getTokenFireBase() async {
//     final String? value = await _storage.read(key: keyTOKENFIREBASE);
//     if (value != null) {
//       return value;
//     }
//     return null;
//   }

//   // ELIMINA TOKEN FIREBASE
//   Future<void> deleteTokenFireBase() async {
//     await _storage.delete(key: keyTOKENFIREBASE);
//   }

//   //=========================================================================//
  // GUARDO RECORDAR CONTRASENA EN EL DISPOSITIVO
  Future<void> saveDataRecordarme(List<dynamic> _recordarme) async {
// CONVERTIMOS  LA INFORMACION  A STRING PARA GUARDAR AL DISPOSITIVO
    final String value = jsonEncode(_recordarme);
// GUARDAMOS LA INFORMACION DEL DISPOSITIVO
    await _storage.write(key: keyCREDENCIALES, value: value);
    print(' GUARDAMOS  LAS CREDENCIALES DEL DISPOSTIVO : $value');
  }

// OBTEMENOS LA INFORMACION DEL credenciales
  Future getDataRecordarme() async {
    final String? datosCredencial = await _storage.read(key: keyCREDENCIALES);
    if (datosCredencial != null) {
      // final Map<String, dynamic> json = jsonDecode(value);
      final getDatosCredencial = jsonDecode(datosCredencial);
      print(' OBTENEMOS  LAS CREDENCIALES DEL DISPOSTIVO: $getDatosCredencial');
      return getDatosCredencial;
    }
    return null;
  }

// CIERRO SESSION
  Future<void> deleteDataRecordarme() async {
    // await _storage.deleteAll();

    await _storage.delete(key: keyCREDENCIALES);
    print(' ELIMINAMOS   LAS CREDENCIALES DEL DISPOSTIVO');
  }

  //=========================================================================//

}

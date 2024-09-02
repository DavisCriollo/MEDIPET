import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:neitorcont/src/api/api_provider.dart';
import 'package:neitorcont/src/api/authentication_client.dart';
import 'package:neitorcont/src/models/auth_response.dart';
import 'package:neitorcont/src/services/socket_service.dart';
import 'package:http/http.dart' as _http;
import 'package:provider/provider.dart';

class HistoriaClinicaController extends ChangeNotifier {
  final _api = ApiProvider();
  GlobalKey<FormState> historiaclinicaFormKey = GlobalKey<FormState>();

  AuthResponse? usuarios;
  bool validateFormHistClinica() {
    if (historiaclinicaFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  void resetFormHistClinica() {
    _nombreMascota = '';
    _pesoMascota = '';
    _propietarioIdMascota = '';
    _propietarioNombreMascota = '';
    _vetInternoId = '';
    _vetInternoNombre = '';
    _inputFecha = "";

    _temperatura = '';
    _hidratacion = '';
    _frecuenciaCardiaca = '';
    _pulso = '';
    _frecuenciaRespiratoria = '';
    _general = '';
    _foong = '';
    _tP = '';
    _mE = '';
    _cardioVascular = '';
    _respiratorio = '';
    _gastroIntestinal = '';
    _gR = '';
    _tipoConsulta = '';
    _neurologico = '';
    _linfatico = '';
    _patronRespitarorio = '';
    _grasgowModificado = '';
    _ritmoCardiaco = '';
    _reflejoPupilar = '';
    _reflejotusigeno = '';
    _llenadoVascular = '';
    _colorMacota = '';
    _amigdalas = '';
    _dolorPaciente = '';
    _lesiones = '';
    _pasPamPad = '';
    _oTros = '';
    _tratamiento = '';
    _fotoServer = '';

 _page = 0;
    _cantidad = 25;
    //  _listaHistoriasPaginacion=[];
    _next = '';
    _isNext = false;

  }

//  =================  CREO DEBOUNCE  PARA BUSQUEDAS ==================//

  Timer? _deboucerSearchBuscaHistorias;
  Timer? _deboucerSearchBuscaTipoConsulta;

  @override
  void dispose() {
    _deboucerSearchBuscaHistorias?.cancel();
    _deboucerSearchBuscaTipoConsulta?.cancel();
    // _deboucerSearchBuscaPersona?.cancel();

    // _videoController.dispose();
    super.dispose();
  }

//===================BOTON SEARCH Mascota ==========================//

  bool _btnSearchHistorias = false;
  bool get btnSearchHistorias => _btnSearchHistorias;

  void setBtnSearchHistorias(bool action) {
    _btnSearchHistorias = action;
    //
    notifyListeners();
  }

  //===================INPUT SEARCH COROSE==========================//
  String _nameSearchHistorias = "";
  String get nameSearchHistorias => _nameSearchHistorias;

  void onSearchTextHistorias(String data) {
    _nameSearchHistorias = data;
    if (_nameSearchHistorias.length >= 3) {
      _deboucerSearchBuscaHistorias?.cancel();
      _deboucerSearchBuscaHistorias =
          Timer(const Duration(milliseconds: 700), () {
        //
        buscaAllHistoriasClinicas(data);
      });
    } else {
      buscaAllHistoriasClinicas('');
      // buscaAusencias('','false');
    }
    notifyListeners();
  }

//==================== LISTO TODAS LAS HISTORIAS CLINICAS====================//
  List _listaHistorias = [];

  List get getListaHistorias => _listaHistorias;

  void setInfoBusquedaHistorias(List data) {
    _listaHistorias = data;
    // print('hClin:=====> $_listaHistorias');
    //
    notifyListeners();
  }

  bool? _errorHistorias; // sera nulo la primera vez
  bool? get getErrorHistorias => _errorHistorias;
  set setErrorHistorias(bool? value) {
    _errorHistorias = value;
    notifyListeners();
  }
bool? _error401HistoriaClinica =false; // sera nulo la primera vez
  bool? get getError401HistoriaClinica => _error401HistoriaClinica;
  set setError401HistoriaClinica(bool? value) {
    _error401HistoriaClinica = value;
    notifyListeners();
  }
  Future buscaAllHistoriasClinicas(String? _search) async {
    final dataUser = await Auth.instance.getSession();
//
    final response = await _api.getAllHistoriasClinicas(
      search: _search,
      // estado: 'CLIENTES',
      token: '${dataUser!.token}',
    );

    // if (response != null) {
    //   _errorHistorias = true;

    //   List dataSort = [];
    //   dataSort = response['data'];
    //   dataSort.sort((a, b) => b['hcliFecReg']!.compareTo(a['hcliFecReg']!));

    //   // setInfoBusquedaHistorias(response['data']);
    //   setInfoBusquedaHistorias(dataSort);
    //   //
    //   notifyListeners();
    //   return response;
    // }
 if (response != null ){

    if(response==401){

       setInfoBusquedaHistorias([]);
       _error401HistoriaClinica=true;
     notifyListeners();
      return response;
    }
    else{
       _errorHistorias = true;

      List dataSort = [];
      dataSort = response['data'];
      dataSort.sort((a, b) => b['hcliFecReg']!.compareTo(a['hcliFecReg']!));

      // setInfoBusquedaHistorias(response['data']);
      setInfoBusquedaHistorias(dataSort);
      // print('object;${response['data']}');
      notifyListeners();
      return response;

    }
  

 }


    if (response == null) {
      _errorHistorias = false;
      notifyListeners();
      return null;
    }
  }

  //================================INPUT   MASCOTA=============================================//
  String? _nombreMascota = '';
  String? get getNombreMascota => _nombreMascota;

  void setNombreMascota(String? value) {
    _nombreMascota = value;

    notifyListeners();
  }

//==========================================================================================//
  String? _pesoMascota = '';
  String? get getPesoMascota => _pesoMascota;

  void setPesoMascota(String? value) {
    _pesoMascota = value;
    print('PESO ES:$_pesoMascota ');

    notifyListeners();
  }

//==========================================================================================//
  String? _temperatura = '';
  String? get getTemperatura => _temperatura;

  void setTemperatura(String? value) {
    _temperatura = value;

    notifyListeners();
  }

//==========================================================================================//
  String? _hidratacion = '';
  String? get getHidratacion => _hidratacion;

  void setHidratacion(String? value) {
    _hidratacion = value;

    notifyListeners();
  }

//==========================================================================================//
  String? _frecuenciaCardiaca = '';
  String? get getFrecuenciaCardiaca => _frecuenciaCardiaca;

  void setFrecuenciaCardiaca(String? value) {
    _frecuenciaCardiaca = value;

    notifyListeners();
  }

//==========================================================================================//
  String? _general = '';
  String? get getGeneral => _general;

  void setGeneral(String? value) {
    _general = value;

    notifyListeners();
  }

//==========================================================================================//
  String? _foong = '';
  String? get getFoong => _foong;

  void setFoong(String? value) {
    _foong = value;

    notifyListeners();
  }

//==========================================================================================//
  String? _tP = '';
  String? get getTP => _tP;

  void setTP(String? value) {
    _tP = value;

    notifyListeners();
  }

//==========================================================================================//
  String? _mE = '';
  String? get getMe => _mE;

  void setMe(String? value) {
    _mE = value;

    notifyListeners();
  }

//==========================================================================================//
  String? _cardioVascular = '';
  String? get getCardioVascular => _cardioVascular;

  void setCardioVascular(String? value) {
    _cardioVascular = value;

    notifyListeners();
  }

//==========================================================================================//
  String? _respiratorio = '';
  String? get getRespiratorio => _respiratorio;

  void setRespiratorio(String? value) {
    _respiratorio = value;

    notifyListeners();
  }

//==========================================================================================//
  String? _gastroIntestinal = '';
  String? get getGastroIntestinal => _gastroIntestinal;

  void setGastroIntestinal(String? value) {
    _gastroIntestinal = value;

    notifyListeners();
  }

//==========================================================================================//
  String? _gR = '';
  String? get getGR => _gR;

  void setGR(String? value) {
    _gR = value;

    notifyListeners();
  }

//==========================================================================================//
  String? _pulso = '';
  String? get getPulso => _pulso;

  void setPulso(String? value) {
    _pulso = value;

    notifyListeners();
  }

  //==========================================================================================//
  String? _frecuenciaRespiratoria = '';
  String? get getFrecuenciaRespiratoria => _frecuenciaRespiratoria;

  void setFrecuenciaRespiratoria(String? value) {
    _frecuenciaRespiratoria = value;

    notifyListeners();
  }

//==========================================================================================//
  String? _propietarioIdMascota = '';
  String? get getPropietarioIdMascota => _propietarioIdMascota;

  void setPropietarioIdMascota(String? value) {
    _propietarioIdMascota = value;

    notifyListeners();
  }

//==========================================================================================//
  String? _propietarioNombreMascota = '';
  String? get getPropietarioMascota => _propietarioNombreMascota;

  void setPropietarioMascota(String? value) {
    _propietarioNombreMascota = value;

    notifyListeners();
  }

  //========================================DOCTOR ==================================================//
  String? _vetInternoId = '';
  String? get getDoctorId => _vetInternoId;

  void setVetInternoId(String? _value) {
    _vetInternoId = _value;
    //
    notifyListeners();
  }

  String? _vetInternoNombre = '';
  String? get getVetInternoNombre => _vetInternoNombre;

  void setVetInternoNombre(String? _value) {
    _vetInternoNombre = _value;
    //
    notifyListeners();
  }

//==========================================================================================//
  String? _inputFecha =   '${DateTime.now().year}-${(DateTime.now().month) < 10 ? '0${DateTime.now().month}' : '${DateTime.now().month}'}-${(DateTime.now().day) < 10 ? '0${DateTime.now().day}' : '${DateTime.now().day}'}';
  get getInputfecha => _inputFecha;
  void onInputFechaChange(String? date) async {
    _inputFecha = date;
    print('LA FECHA ES: $_inputFecha ');

    notifyListeners();
  }


  //==========================================================================================//
  String? _descripcion = '';
  String? get getDescripcion => _descripcion;

  void setDescripcion(String? value) {
    _descripcion = value;

    notifyListeners();
  }

  //==========================================================================================//
  String? _tipoConsultaId = '';
  String? get getTipoConsultaId => _tipoConsultaId;

  void setTipoConsultaId(String? value) {
    _tipoConsultaId = value;

    notifyListeners();
  }

  //==========================================================================================//
  String? _tipoConsulta = '';
  String? get getTipoConsulta => _tipoConsulta;

  void setTipoConsulta(String? value) {
    _tipoConsulta = value;

    notifyListeners();
  }

//==========================================================================================//
  String? _neurologico = '';
  String? get getNeurologico => _neurologico;

  void setNeurologico(String? value) {
    _neurologico = value;

    notifyListeners();
  }

//==========================================================================================//
  String? _linfatico = '';
  String? get getLinfatico => _linfatico;

  void setLinfatico(String? value) {
    _linfatico = value;

    notifyListeners();
  }

//==========================================================================================//
  String? _patronRespitarorio = '';
  String? get getPatronRespitarorio => _patronRespitarorio;

  void setPatronRespitarorio(String? value) {
    _patronRespitarorio = value;

    notifyListeners();
  }

//==========================================================================================//
  String? _grasgowModificado = '';
  String? get getGrasgowModificado => _grasgowModificado;

  void setGrasgowModificado(String? value) {
    _grasgowModificado = value;

    notifyListeners();
  }

//==========================================================================================//
  String? _ritmoCardiaco = '';
  String? get getRitmoCardiaco => _ritmoCardiaco;

  void setRitmoCardiaco(String? value) {
    _ritmoCardiaco = value;

    notifyListeners();
  }

//==========================================================================================//
  String? _reflejoPupilar = '';
  String? get getReflejoPupilar => _reflejoPupilar;

  void setReflejoPupilar(String? value) {
    _reflejoPupilar = value;

    notifyListeners();
  }

//==========================================================================================//
  String? _reflejotusigeno = '';
  String? get getReflejotusigeno => _reflejotusigeno;

  void setReflejotusigeno(String? value) {
    _reflejotusigeno = value;

    notifyListeners();
  }

//==========================================================================================//
  String? _llenadoVascular = '';
  String? get getLlenadoVascular => _llenadoVascular;

  void setLlenadoVascular(String? value) {
    _llenadoVascular = value;

    notifyListeners();
  }

//==========================================================================================//
  String? _colorMacota = '';
  String? get getColorMacota => _colorMacota;

  void setColorMacota(String? value) {
    _colorMacota = value;

    notifyListeners();
  }

//==========================================================================================//
  String? _amigdalas = '';
  String? get getAmigdalas => _amigdalas;

  void setAmigdalas(String? value) {
    _amigdalas = value;

    notifyListeners();
  }

//==========================================================================================//
  String? _dolorPaciente = '';
  String? get getDolorPaciente => _dolorPaciente;

  void setDolorPaciente(String? value) {
    _dolorPaciente = value;

    notifyListeners();
  }

//==========================================================================================//
  String? _lesiones = '';
  String? get getLesiones => _lesiones;

  void setLesiones(String? value) {
    _lesiones = value;

    notifyListeners();
  }

//==========================================================================================//
  String? _pasPamPad = '';
  String? get getPasPamPad => _pasPamPad;

  void setPasPamPad(String? value) {
    _pasPamPad = value;

    notifyListeners();
  }

//==========================================================================================//
  String? _oTros = '';
  String? get getOtros => _oTros;

  void setOtros(String? value) {
    _oTros = value;

    notifyListeners();
  }

//==========================================================================================//
  String? _tratamiento = '';
  String? get getTratamiento => _tratamiento;

  void setTratamiento(String? value) {
    _tratamiento = value;

    notifyListeners();
  }
  //================================GET MASCOTA=============================================//

  dynamic _infoMascota;
  dynamic get getInfoMascota => _infoMascota;
  int? _idMascota;

  void setMascotaInfo(dynamic _inf) {
    _infoMascota = _inf;
    _idMascota = _inf['mascId'];
    setNombreMascota(_inf['mascNombre']);
    // setPesoMascota(_inf['mascPeso']);
    // setPropietarioIdMascota(_inf['mascPerId']);
    // setPropietarioMascota(_inf['mascPerNombre']);

    // setVetInternoId(_inf['mascPerNombre']);
    // setVetInternoNombre(_inf['mascPerNombre']);

    // setRazaMascota(_inf['mascRaza']);
    // setSexoMascota(_inf['mascSexo']);
    // setEdadMascota(_inf['mascEdad']);
    // setPropietarioCedulaMascota(_inf['mascPerDocNumero']);
    // setPropietarioDirecionMascota(_inf['mascPerDireccion']);
    // setPropietarioTelefonoMascota(_inf['mascPerTelefono']);

    // setPropietarioCelularMascota(_inf['mascPerCelular']);
    // setPropietarioEmailMascota(_inf['mascPerEmail']);

    //
    //
    notifyListeners();
  }

//================================GET MASCOTA=============================================//

  dynamic _infoDoctor;
  dynamic get getInfoDoctor => _infoDoctor;
  // int? _idMascota;

  void setDoctorInfo(dynamic _inf) {
    _infoDoctor = _inf;
    setVetInternoId(_inf['perId'].toString());
    setVetInternoNombre(_inf['perNombre']);
    notifyListeners();
  }
//================================GET TIPO CONSULTA =============================================//

  dynamic _infoTipoConsulta;
  dynamic get getInfoTipoConsulta => _infoTipoConsulta;
  // int? _idMascota;

  void setTipoConsultaInfo(dynamic _inf) {
    _infoTipoConsulta = _inf;
    setTipoConsultaId(_inf['consId'].toString());
    setTipoConsulta(_inf['consNombre']);

    notifyListeners();
  }

//================================== LISTAR TIPO DE CONSULTA  ==============================//

  //===================INPUT SEARCH CONSULTA==========================//
  String _nameSearchTipoConsulta = "";
  String get nameSearchTipoConsulta => _nameSearchTipoConsulta;

  void onSearchTextTipoConsulta(String data) {
    _nameSearchTipoConsulta = data;
    if (_nameSearchTipoConsulta.length >= 3) {
      _deboucerSearchBuscaTipoConsulta?.cancel();
      _deboucerSearchBuscaTipoConsulta =
          Timer(const Duration(milliseconds: 700), () {
        //
        buscaAllTipoConsultas(data);
      });
    } else {
      // buscaAusencias('','false');
    }
    notifyListeners();
  }

  List _listaAllTipoConsultas = [];
  List get getListaAllTipoConsultas => _listaAllTipoConsultas;

  void setListaAllTipoConsultas(List data) {
    _listaAllTipoConsultas = data;

    //

    notifyListeners();
  }

  bool? _errorAllTipoConsultas; // sera nulo la primera vez
  bool? get getErrorAllTipoConsultas => _errorAllTipoConsultas;

  Future? buscaAllTipoConsultas(String? _search) async {
    final dataUser = await Auth.instance.getSession();
    final response = await _api.getAllTipoConsultas(
      search: _search,
      // estado: 'VETERINARIOS',
      token: '${dataUser!.token}',
    );
    if (response != null) {
      _errorAllTipoConsultas = true;
      setListaAllTipoConsultas(response['data']);

      // setListaTodasLasRazas(response['data'][0]['espRazas']);

      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorAllTipoConsultas = false;
      notifyListeners();
      return null;
    }
    return null;
  }

//================================== CREA RECETA  ==============================//
  Future creaHistoriaClinica(
    BuildContext context,
  ) async {
    final serviceSocket = context.read<SocketService>();
    final infoUser = await Auth.instance.getSession();

    final _pyloadNuevaHistoriaClinica = {
      "tabla": "historiaclinica",
      "rucempresa": infoUser!.rucempresa, // LOGIN
      "rol": infoUser.rol, //LOGIN

      "hcliId": "",
      "hcliMascId": _idMascota,
      "hcliMascNombre": _nombreMascota,
      "hcliPerId": _propietarioIdMascota,
      "hcliPerNombre": _propietarioNombreMascota,
      "hcliPerIdVetInt": _vetInternoId,
      "hcliPerNombreVetInt": _vetInternoNombre,
      "hcliPerIdVetExt": "",
      "hcliPerNombreVetExt": "",
      "hcliFecha": _inputFecha,
      "hcliMotiConsulMedica": _tipoConsulta,
      "hcliPeso": _pesoMascota,
      "hcliTemperatura": _temperatura,
      "hcliHidratacion": _hidratacion,
      "hcliFrecuCardiaca": _frecuenciaCardiaca,
      "hcliPulso": _pulso,
      "hcliFrecuRespiratoria": _frecuenciaRespiratoria,
      "hcliGeneral": _general,
      "hcliFoong": _foong,
      "hcliTp": _tP,
      "hcliMe": _mE,
      "hcliCardioVascular": _cardioVascular,
      "hcliRespiratorio": _respiratorio,
      "hcliGastroIntestinal": _gastroIntestinal,
      "hcliGr": _gR,
      "hcliNeurologico": _neurologico,
      "hcliLinfatico": _linfatico,
      "hcliPatronRespiratorio": _patronRespitarorio,
      "hcliGlasgowModificado": _grasgowModificado,
      "hcliRitmoCardiaco": _ritmoCardiaco,
      "hcliReflejoPupilar": _reflejoPupilar,
      "hcliReflejoTusigeno": _reflejotusigeno,
      "hcliTLlenadoVascular": _llenadoVascular,
      "hcliColorMocosas": _colorMacota,
      "hcliAmigdalas": _amigdalas,
      "hcliDolorPaciente": _dolorPaciente,
      "hcliLesiones": _lesiones,
      "hcliPasPamPad": _pasPamPad,
      "hcliOtros": _oTros,
      "hcliTratamiento": _tratamiento,
     "hcliArchivo":_fotoServer,
      "hcliFoto": "",
      "hcliDescripcion": _descripcion,
      "hcliUser": infoUser.usuario,
      "hcliEmpresa": infoUser.rucempresa,
      "hcliFecReg": "",
      "Todos": ""
    };

    // print(
    //     '==========================JSON PARA CREAR NUEVA RECETA ===============================');
    // print(_pyloadNuevaHistoriaClinica);
    // print(
    //     '==========================SOCKET RECETA ===============================');
    serviceSocket.sendMessage('client:guardarData', _pyloadNuevaHistoriaClinica);
  //   serviceSocket.socket!
  //       .emit('client:guardarData', _pyloadNuevaHistoriaClinica);
  }

//================================== EDITAR HISTORIA CLINICA  ==============================//
  Future editaHistoriaClinica(
    BuildContext context,
  ) async {
    final serviceSocket = context.read<SocketService>();
    final infoUser = await Auth.instance.getSession();

    final _pyloadEditaHistoriaClinica = {
      "tabla": "historiaclinica",
      "rucempresa": infoUser!.rucempresa, // LOGIN
      "rol": infoUser.rol, //LOGIN

      "hcliId": _idHistoriaClinica,
      "hcliMascId": _idMascota,
      "hcliMascNombre": _nombreMascota,
      "hcliPerId": _propietarioIdMascota,
      "hcliPerNombre": _propietarioNombreMascota,
      "hcliPerIdVetInt": _vetInternoId,
      "hcliPerNombreVetInt": _vetInternoNombre,
      "hcliPerIdVetExt": "",
      "hcliPerNombreVetExt": "",
      "hcliFecha": _inputFecha,
      "hcliMotiConsulMedica": _tipoConsulta,
      "hcliPeso": _pesoMascota,
      "hcliTemperatura": _temperatura,
      "hcliHidratacion": _hidratacion,
      "hcliFrecuCardiaca": _frecuenciaCardiaca,
      "hcliPulso": _pulso,
      "hcliFrecuRespiratoria": _frecuenciaRespiratoria,
      "hcliGeneral": _general,
      "hcliFoong": _foong,
      "hcliTp": _tP,
      "hcliMe": _mE,
      "hcliCardioVascular": _cardioVascular,
      "hcliRespiratorio": _respiratorio,
      "hcliGastroIntestinal": _gastroIntestinal,
      "hcliGr": _gR,
      "hcliNeurologico": _neurologico,
      "hcliLinfatico": _linfatico,
      "hcliPatronRespiratorio": _patronRespitarorio,
      "hcliGlasgowModificado": _grasgowModificado,
      "hcliRitmoCardiaco": _ritmoCardiaco,
      "hcliReflejoPupilar": _reflejoPupilar,
      "hcliReflejoTusigeno": _reflejotusigeno,
      "hcliTLlenadoVascular": _llenadoVascular,
      "hcliColorMocosas": _colorMacota,
      "hcliAmigdalas": _amigdalas,
      "hcliDolorPaciente": _dolorPaciente,
      "hcliLesiones": _lesiones,
      "hcliPasPamPad": _pasPamPad,
      "hcliOtros": _oTros,
      "hcliTratamiento": _tratamiento,
      "hcliArchivo":_fotoServer,
      "hcliFoto": "",
      "hcliDescripcion": _descripcion,
      "hcliUser": "$_userData ** ${infoUser.usuario}",
      "hcliEmpresa": infoUser.rucempresa,
      "hcliFecReg": "",
      "Todos": ""
    };

    // print(
    //     '==========================JSON PARA CREAR Edita RECETA ===============================');
    // print(_pyloadEditaHistoriaClinica);
    // print(
    //     '==========================SOCKET RECETA ===============================');
   
    serviceSocket.sendMessage('client:actualizarData', _pyloadEditaHistoriaClinica);
    // serviceSocket.socket!
    //     .emit('client:actualizarData', _pyloadEditaHistoriaClinica);
  }

  //================================== ELIMINAR  HISTORIA CLINICA  ==============================//
  Future eliminaHistoriaCinica(BuildContext context, int? idhistoria) async {
    // final serviceSocket = SocketService();

    final serviceSocket = context.read<SocketService>();
    final infoUser = await Auth.instance.getSession();

    final _pyloadEliminaHistoriaClinica = {
      "tabla": 'historiaclinica',
      "rucempresa": infoUser!.rucempresa,
      "rol": infoUser.rol,
      "hcliId": idhistoria,
    };
        serviceSocket.sendMessage('client:eliminarData', _pyloadEliminaHistoriaClinica);
    // serviceSocket.socket!
    //     .emit('client:eliminarData', _pyloadEliminaHistoriaClinica);
  }

  dynamic _infoHistoriaClinica;
  dynamic get getInfoHistoriaClinica => _infoHistoriaClinica;
  int? _idHistoriaClinica;
    String? _userData='';
  void setInfoHistoriaClinica(dynamic _infoHistoria) {


    _userData=_infoHistoria['hcliUser'];
    _infoHistoriaClinica = _infoHistoria;
    _idHistoriaClinica = _infoHistoria['hcliId'];

    _idMascota = int.parse(_infoHistoria['hcliMascId']);

    setNombreMascota(_infoHistoria['hcliMascNombre']);
    setPropietarioIdMascota(_infoHistoria['hcliPerId']);
    setPropietarioMascota(_infoHistoria['hcliPerNombre']);

    setVetInternoId(_infoHistoria['hcliPerIdVetInt']);
    setVetInternoNombre(_infoHistoria['hcliPerNombreVetInt']);
    onInputFechaChange(_infoHistoria['hcliFecha']);
    setTipoConsulta(_infoHistoria['hcliMotiConsulMedica']);
    setPesoMascota(_infoHistoria['hcliPeso']);
    setTemperatura(_infoHistoria['hcliTemperatura']);
    setHidratacion(_infoHistoria['hcliHidratacion']);
    setFrecuenciaCardiaca(_infoHistoria['hcliFrecuCardiaca']);
    setPulso(_infoHistoria['hcliPulso']);
    setFrecuenciaRespiratoria(_infoHistoria['hcliFrecuRespiratoria']);
    setGeneral(_infoHistoria['hcliGeneral']);
    setFoong(_infoHistoria['hcliFoong']);
    setTP(_infoHistoria['hcliTp']);
    setMe(_infoHistoria['hcliMe']);
    setCardioVascular(_infoHistoria['hcliCardioVascular']);
    setRespiratorio(_infoHistoria['hcliRespiratorio']);
    setGastroIntestinal(_infoHistoria['hcliGastroIntestinal']);
    setGR(_infoHistoria['hcliGr']);
    setNeurologico(_infoHistoria['hcliNeurologico']);
    setLinfatico(_infoHistoria['hcliLinfatico']);
    setPatronRespitarorio(_infoHistoria['hcliPatronRespiratorio']);
    setGrasgowModificado(_infoHistoria['hcliGlasgowModificado']);
    setRitmoCardiaco(_infoHistoria['hcliRitmoCardiaco']);
    setReflejoPupilar(_infoHistoria['hcliReflejoPupilar']);
    setReflejotusigeno(_infoHistoria['hcliReflejoTusigeno']);
    setLlenadoVascular(_infoHistoria['hcliTLlenadoVascular']);
    setColorMacota(_infoHistoria['hcliColorMocosas']);
    setAmigdalas(_infoHistoria['hcliAmigdalas']);
    setDolorPaciente(_infoHistoria['hcliDolorPaciente']);
    setLesiones(_infoHistoria['hcliLesiones']);
    setPasPamPad(_infoHistoria['hcliPasPamPad']);
    setOtros(_infoHistoria['hcliOtros']);
    setTratamiento(_infoHistoria['hcliTratamiento']);
    setDescripcion(_infoHistoria['hcliDescripcion']);
    setFotoServer(_infoHistoria['hcliArchivo']);

    notifyListeners();
  }

//========================AGREGA ARCHIVO ==============================//
  PlatformFile? _filesPicker;

  PlatformFile? get getFilesPicker => _filesPicker;

  void deleteFile() {
    _filesPicker = null;

    _sizeFile = '';
    notifyListeners();
  }

  String? _sizeFile;

  String? get getSizeFile => _sizeFile;

  void setPickFiless() async {
    FilePickerResult? _result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        // allowedExtensions: ['jpg','png','pdf','doc','docx'],
        allowedExtensions: ['pdf'],
        allowMultiple: false);
    if (_result == null) return;

    _filesPicker = _result.files.first;
    // print('ESTE ES LA URL:${_filesPicker!.path}');

    final kb = _filesPicker!.size / 1024;
    final mb = kb / 1024;
    _sizeFile =
        (mb > 1) ? '${mb.toStringAsFixed(0)}MB' : '${kb.toStringAsFixed(0)}KB';

    // upLoadImagen(_filesPicker!.path);
    guardaDocumento();

// _viewfile(_file);
    notifyListeners();
  }

  // void _viewfile(PlatformFile _file)
  // {
  // OpenFile.open(_file.path);
  // }
  // Future _sendfileSerfer(PlatformFile _file) async
  // {
  // OpenFile.open(_file.path);
  // }
//==============================GUARDA LA FOTO EN EL SERVIDOR =======================================//
  String? _fotoServer = '';
  String? get getFotoServer => _fotoServer;

  void setFotoServer(String? _fto) {
    _fotoServer = _fto;
    // print("SUCCESS delete: $_fotoServer");
    notifyListeners();
  }

  // Future upLoadImagen(String? _filesPicker) async {
  //   final dataUser = await Auth.instance.getSession();

  //   //for multipartrequest
  //   var request = _http.MultipartRequest(
  //       'POST',
  //       Uri.parse(
  //           'https://contabackend.neitor.com/api/upload_delete_multiple_files/uploads'));

  //   //for token
  //   request.headers.addAll({"x-auth-token": '${dataUser!.token}'});

  //   request.files
  //       .add(await _http.MultipartFile.fromPath('foto', _filesPicker!));

  //   //for completeing the request
  //   var response = await request.send();

  //   //for getting and decoding the response into json format
  //   var responsed = await _http.Response.fromStream(response);
  //   // final responseData = json.decode(responsed.body);

  //   if (responsed.statusCode == 200) {
  //     // print("SUCCESS");
  //     final responseFoto = jsonDecode(responsed.body);
  //     // _foto=responseFoto['urls'][0]['url'];
  //     setFotoServer(responseFoto['urls'][0]['url']);
  //     // print("SUCCESS $_foto");s
  //     notifyListeners();
  //   }
  //   if (responsed.statusCode == 404) {
  //     setFotoServer('');
  //     return null;
  //   }
  //   if (responsed.statusCode == 401) {
  //     setFotoServer('');
  //     return null;
  //   }
  // }

//============================== ELIMINA LA FOTO EN EL SERVIDOR =======================================//

  Future deleteFileServer(String _filePath) async {
    final dataUser = await Auth.instance.getSession();

    // print('DATA A ELIMINAR:$_filePath');

//  final _dataFileDelet=[
// 		{
// 			"nombre": "foto1",
// 			"url": "https://documentos.neitor.com/contable/documentos/VET365/69d1db0e-f2cd-4a55-ac4b-d10596429133.pdf"
// 		}
// 	];

    // for multipartrequest
    var request = _http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://contabackend.neitor.com/api/upload_delete_multiple_files/delete'));

    //for token
    request.headers.addAll({
      "Content-Type": 'application/json',
      "x-auth-token": '${dataUser!.token}'
    });

    request.files.add(await _http.MultipartFile.fromPath(
      'foto',
      _filePath,
    ));

    //for completeing the request
    var response = await request.send();

    //for getting and decoding the response into json format
    var responsed = await _http.Response.fromStream(response);
    // final responseData = json.decode(responsed.body);

    if (responsed.statusCode == 200) {
      // print("SUCCESS");
      // final responseFoto = jsonDecode(responsed.body);

      // setFotoServer(responseFoto['urls'][0]['url']);
      setFotoServer('');

      notifyListeners();
    }
    if (responsed.statusCode == 404) {
      setFotoServer('');
      return null;
    }
    if (responsed.statusCode == 401) {
      setFotoServer('');
      return null;
    }
  }

  Future uploadImageHTTP(file) async {
    var request = _http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://contabackend.neitor.com/api/upload_delete_multiple_files/delete'));
    request.files.add(
      await _http.MultipartFile.fromPath(
        
        'file',
        file!,
      ),
    );
    var responsed = await request.send();

    if (responsed.statusCode == 200) {
      setFotoServer('');

      notifyListeners();
    }
    if (responsed.statusCode == 404) {
      setFotoServer('');
      return null;
    }
    if (responsed.statusCode == 401) {
      setFotoServer('');
      return null;
    }
    return responsed.reasonPhrase.toString();
  }


//  String? _documento;
//   String? get getDocumento => _documento;

//   void setDocumento(String? _path) {
//     _documento = _path;
//     print('Documento URL: $_documento');
//     notifyListeners();
//   }


  String? _docUrlTemp = '';
 String? get getDocUrlTemp => _docUrlTemp;
  void setUrlDocServer(String? _docUlr) {
    _docUrlTemp = _docUlr;
    // print('LA docITO: $_docUrlTemp');
    notifyListeners();
  }
//========================================= ELIMINAT DOCUMENTO============================================//
  bool? _errorDeleteDoc;// sera nulo la primera vez
  bool? get getErrorDeleteDoc => _errorDeleteDoc;

  Future? deleteDoc(String? _doc) async {
    // print("object: $_fto");
    final _docDelete = [
      {"nombre": "DocDelete", "url": "$_doc"}
    ];
    final dataUser = await Auth.instance.getSession();
    final response = await _api.deleteDocumento(
      info: _docDelete,
      token: '${dataUser!.token}',
    );
    if (response != null) {
      _errorDeleteDoc = false;
      // setUrlDocServer('');
      // _documento = '';
      setFotoServer('');
     

      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorDeleteDoc = true;
      notifyListeners();
      return null;
    }
    return null;
  }

//========================== PROCESO DE TOMAR FOTO DE CAMARA =======================//

  File? _newPictureFile;
  File? get getNewPictureFile => _newPictureFile;

  void setNewPictureFile(File? _path) {
    _newPictureFile = _path;
    // print('FOTO _newPictureFile: $_newPictureFile');
    // upLoadImagen();
    notifyListeners();
  }

  String? _foto;
  String? get getFoto => _foto;

  void setFoto(String? _path) {
    _foto = _path;
    // print('FOTO URL: $_foto');
    notifyListeners();
  }

  //================================== GUARDA DOCUMENTO  ==============================//
 bool? _errorSaveDoc; // sera nulo la primera vez
  bool? get getErrorSaveDoc => _errorSaveDoc;
  Future guardaDocumento() async {
    final infoUser = await Auth.instance.getSession();

    String fileName = _filesPicker!.path!.split('/').last;
    FormData _formData = FormData.fromMap({
      "tipo": "historiaclinica",
      "archivoAnterior": "",
      "archivo": await MultipartFile.fromFile(_filesPicker!.path!,
          filename: fileName),
    });
    final response = await _api.saveDocumento(
      formData: _formData,
      token: '${infoUser!.token}',
    );
    if (response != null) {
      _errorSaveDoc = true;
      _fotoServer = response;

      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorSaveDoc = false;
      _fotoServer='';
      notifyListeners();
      return null;
    }
    return null;
  }

//=================================================================================================================//
  // ================= VARIABLES DE PAGINACION ====================//
//=================================================================================================================//
//===================BOTON SEARCH PAGINACION ==========================//

  bool _btnSearchHistoriasPaginacion = false;
  bool get btnSearchHistoriaPaginacion => _btnSearchHistoriasPaginacion;

  void setBtnSearchHistoriaPaginacion(bool action) {
    _btnSearchHistoriasPaginacion = action;
    //  print('==_btnSearchCoros===> $_btnSearchPropietarios');
    notifyListeners();
  }

  //===================INPUT SEARCH PROPIETARIO==========================//
  String _nameSearchHistoriaPaginacion = "";
  String get nameSearchHistoriaPaginacion => _nameSearchHistoriaPaginacion;

  void onSearchTextHistoriaPaginacion(String data) {
    _nameSearchHistoriaPaginacion = data;
    print('MASCOTNOMBRE:${_nameSearchHistoriaPaginacion}');
  }
//=============================================================================//

  List _listaHistoriasPaginacion = [];
  // List<TipoMulta> get getListaTodosLosTiposDeMultas => _listaTodosLosTiposDeMultas;
  List get getListaHistoriasPaginacion => _listaHistoriasPaginacion;

  void setInfoBusquedaHistoriasPaginacion(List data) {
    _listaHistoriasPaginacion.addAll(data);
    print('Historias :${_listaHistoriasPaginacion.length}');

    // for (var item in _listaHistoriasPaginacion) {
    //    print('-->:${item['perId']}');
    // }

    notifyListeners();
  }

  bool? _errorHistoriasPaginacion; // sera nulo la primera vez
  bool? get getErrorHistoriasPaginacion => _errorHistoriasPaginacion;
  void setErrorHistoriasPaginacion(bool? value) {
    _errorHistoriasPaginacion = value;
    notifyListeners();
  }

  bool? _error401HistoriasPaginacion = false; // sera nulo la primera vez
  bool? get getError401HistoriasPaginacion => _error401HistoriasPaginacion;
  void setError401HistoriasPaginacion(bool? value) {
    _error401HistoriasPaginacion = value;
    notifyListeners();
  }

  bool _isNext = false;
  bool get getIsNext => _isNext;
  void setIsNext(bool _next) {
    _isNext = _next;
    // print('_isNext: $_isNext');

    notifyListeners();
  }

  int? _page = 0;
  int? get getpage => _page;
  void setPage(int? _pag) {
    _page = _pag;
    // print('_page: $_page');

    notifyListeners();
  }

  int? _cantidad = 25;
  int? get getCantidad => _cantidad;
  void setCantidad(int? _cant) {
    _cantidad = _cant;
    notifyListeners();
  }

  String? _next = '';
  String? get getNext => _next;
  void setNext(String? _nex) {
    _next = _nex;
    notifyListeners();
  }

  Future buscaAllHistoriasPaginacion(String? _search, bool _isSearch) async {
    final dataUser = await Auth.instance.getSession();
// print('usuario : ${dataUser!.rucempresa}');
    final response = await _api.getAllHistoriasClinicasPaginacion(
      search: _search,
      page: _page,
      cantidad: _cantidad,
      input: 'hcliId',
      orden: false,
      hcliMascId: null,
      token: '${dataUser!.token}',
    );

    if (response != null) {
      if (response == 401) {
        setInfoBusquedaHistoriasPaginacion([]);
        _error401HistoriasPaginacion = true;
        notifyListeners();
        return response;
      } else {
        _errorHistoriasPaginacion = true;
        if (_isSearch == true) {
          _listaHistoriasPaginacion = [];
        }
        List<dynamic> dataSort = response['data']['results'];
        dataSort.sort((a, b) => b['hcliFecReg']!.compareTo(a['hcliFecReg']!));

        setPage(response['data']['pagination']['next']);

        setInfoBusquedaHistoriasPaginacion(dataSort);
        notifyListeners();
        return response;
      }

      //===========================================//

    }
    if (response == null) {
      _errorHistoriasPaginacion = false;
      notifyListeners();
      return null;
    }
  }
  
//=====================================================================================================//

}

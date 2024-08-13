import 'dart:async';

import 'package:flutter/material.dart';
import 'package:neitorcont/src/api/api_provider.dart';
import 'package:neitorcont/src/api/authentication_client.dart';
import 'package:neitorcont/src/models/auth_response.dart';
import 'package:neitorcont/src/services/socket_service.dart';
import 'package:provider/provider.dart';

class ReservasController extends ChangeNotifier {
  final _api = ApiProvider();
  GlobalKey<FormState> reservasFormKey = GlobalKey<FormState>();

  AuthResponse? usuarios;
  bool validateForm() {
    if (reservasFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  void resetFormReservas() {


    _nombreMascota = '';
    _razaMascota = '';
    _sexoMascota = '';
    _edadMascota = '';
    _propietarioIdMascota = '';
    _propietarioMascota = '';
    _doctorId = '';
    _doctoNombre = '';
    _propietarioCedulaMascota = '';
    _propietarioDirecionMascota = '';
    _propietarioTelefonoMascota = '';
    _pesoMascota = '';
    _observaciones = '';
    _inputFechaProximaCita =
        '${DateTime.now().year}-${(DateTime.now().month) < 10 ? '0${DateTime.now().month}' : '${DateTime.now().month}'}-${(DateTime.now().day) < 10 ? '0${DateTime.now().day}' : '${DateTime.now().day}'}';

    _inputHoraProximaCita = '${DateTime.now().hour}:${DateTime.now().minute}';

    _inputDoctorMascota = '';
    _tipoReservaNombre = '';


    _page = 0;
    _cantidad = 25;
    // _listaReservasPaginacion = [];
    _next = '';
    _isNext = false;





    
    // notifyListeners();
  }

  // void resetCreateForm() {
  //   _nombreMascota = '';
  //   _razaMascota = '';
  //   _sexoMascota = '';
  //   _edadMascota = '';
  //   _propietarioIdMascota = '';
  //   _propietarioMascota = '';
  //   _doctorId = '';
  //   _doctoNombre = '';
  //   _propietarioCedulaMascota = '';
  //   _propietarioDirecionMascota = '';
  //   _propietarioTelefonoMascota = '';
  //   _pesoMascota = '';
  //   _observaciones = '';
  //   _inputFechaProximaCita =
  //       '${DateTime.now().year}-${(DateTime.now().month) < 10 ? '0${DateTime.now().month}' : '${DateTime.now().month}'}-${(DateTime.now().day) < 10 ? '0${DateTime.now().day}' : '${DateTime.now().day}'}';

  //   _inputHoraProximaCita = '${DateTime.now().hour}:${DateTime.now().minute}';

  //   _inputDoctorMascota = '';
  //   _tipoReservaNombre = '';
  // }
//  =================  CREO DEBOUNCE  PARA BUSQUEDAS ==================//

  Timer? _deboucerSearchReservas;
  // Timer? _deboucerSearchBuscaPersona;

  @override
  void dispose() {
    _deboucerSearchReservas?.cancel();
    // _deboucerSearchBuscaPersona?.cancel();

    // _videoController.dispose();
    super.dispose();
  }

//=================================================================================================================//
  // ================= VARIABLES DE PAGINACION ====================//
//=================================================================================================================//
//===================BOTON SEARCH PAGINACION ==========================//

  bool _btnSearchReservasPaginacion = false;
  bool get btnSearchReservaPaginacion => _btnSearchReservasPaginacion;

  void setBtnSearchReservaPaginacion(bool action) {
    _btnSearchReservasPaginacion = action;
    //  print('==_btnSearchCoros===> $_btnSearchPropietarios');
    notifyListeners();
  }

  //===================INPUT SEARCH PROPIETARIO==========================//
  String _nameSearchReservaPaginacion = "";
  String get nameSearchReservaPaginacion => _nameSearchReservaPaginacion;

  void onSearchTextReservaPaginacion(String data) {
    _nameSearchReservaPaginacion = data;
    //  print('ReservaOMBRE:${_nameSearchReservaPaginacion}');
  }
//=============================================================================//

  List _listaReservasPaginacion = [];
  // List<TipoMulta> get getListaTodosLosTiposDeMultas => _listaTodosLosTiposDeMultas;
  List get getListaReservasPaginacion => _listaReservasPaginacion;

  void setInfoBusquedaReservasPaginacion(List data) {
    _listaReservasPaginacion.addAll(data);
    // print('Reservas :${_listaReservasPaginacion.length}');

    // for (var item in _listaReservasPaginacion) {
    //    print('-->:${item['perId']}');
    // }

    notifyListeners();
  }

  bool? _errorReservasPaginacion; // sera nulo la primera vez
  bool? get getErrorReservasPaginacion => _errorReservasPaginacion;
  void setErrorReservasPaginacion(bool? value) {
    _errorReservasPaginacion = value;
    notifyListeners();
  }

  bool? _error401ReservasPaginacion = false; // sera nulo la primera vez
  bool? get getError401ReservasPaginacion => _error401ReservasPaginacion;
  void setError401ReservasPaginacion(bool? value) {
    _error401ReservasPaginacion = value;
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

  Future buscaAllReservasPaginacion(String? _search, bool _isSearch) async {
    final dataUser = await Auth.instance.getSession();
// print('usuario : ${dataUser!.rucempresa}');
    final response = await _api.getAllReservasPaginacion(
      search: _search,
      page: _page,
      cantidad: _cantidad,
      input: 'resId',
      orden: false,
      // estado:'Reservas',
      token: '${dataUser!.token}',
    );

    if (response != null) {
      if (response == 401) {
        setInfoBusquedaReservasPaginacion([]);
        _error401ReservasPaginacion = true;
        notifyListeners();
        return response;
      } else {
        _errorReservasPaginacion = true;
        if (_isSearch == true) {
          _listaReservasPaginacion = [];
        }
        List<dynamic> dataSort = response['data']['results'];
        dataSort.sort((a, b) => b['resFecReg']!.compareTo(a['resFecReg']!));

        setPage(response['data']['pagination']['next']);

        setInfoBusquedaReservasPaginacion(dataSort);
        notifyListeners();
        return response;
      }

      //===========================================//

    }
    if (response == null) {
      _errorReservasPaginacion = false;
      notifyListeners();
      return null;
    }
    //===========================================//
  }
// 
//================================INPUT   MASCOTA=============================================//
  String? _nombreMascota = '';
  String? get getNombreMascota => _nombreMascota;

  void setNombreMascota(String? value) {
    _nombreMascota = value;
    // print('==_nombreMascota ===> $_nombreMascota');
    notifyListeners();
  }

//==========================================================================================//
  String? _razaMascota = '';
  String? get getRazaMascota => _razaMascota;

  void setRazaMascota(String? value) {
    _razaMascota = value;
    // print('==_RazaMascota ===> $_razaMascota');
    notifyListeners();
  }

//==========================================================================================//
  String? _sexoMascota = '';
  String? get getSexoMascota => _sexoMascota;

  void setSexoMascota(String? value) {
    _sexoMascota = value;
    // print('==_sexoMascota ===> $_sexoMascota');
    notifyListeners();
  }

//==========================================================================================//
  String? _edadMascota = '';
  String? get getEdadMascota => _edadMascota;

  void setEdadMascota(String? value) {
    _edadMascota = value;
    // print('==_edadMascota ===> $_edadMascota');
    notifyListeners();
  }

//==========================================================================================//
  String? _propietarioIdMascota = '';
  String? get getPropietarioIdMascota => _propietarioIdMascota;

  void setPropietarioIdMascota(String? value) {
    _propietarioIdMascota = value;
    // print('==_propietarioIdMascota ===> $_propietarioIdMascota');
    notifyListeners();
  }

//==========================================================================================//
  String? _propietarioMascota = '';
  String? get getPropietarioMascota => _propietarioMascota;

  void setPropietarioMascota(String? value) {
    _propietarioMascota = value;
    // print('==_propietarioMascota ===> $_propietarioMascota');
    notifyListeners();
  }

//========================================RESERVA ==================================================//
  String? _tipoReservaId = '';
  String? get getTipoReservaId => _tipoReservaId;

  void setTipoReservaId(String? _value) {
    _tipoReservaId = _value;
    // print('==_propietarioMascota ===> $_propietarioMascota');
    notifyListeners();
  }

  String? _tipoReservaNombre = '';
  String? get getTipoReservaNombre => _tipoReservaNombre;

  void setTipoReservaNombre(String? _value) {
    _tipoReservaNombre = _value;
    // print('==_propietarioMascota ===> $_propietarioMascota');
    notifyListeners();
  }

//========================================DOCTOR ==================================================//
  String? _doctorId = '';
  String? get getDoctorId => _doctorId;

  void setDoctorId(String? _value) {
    _doctorId = _value;
    // print('==_propietarioMascota ===> $_propietarioMascota');
    notifyListeners();
  }

  String? _doctorCedula = '';
  String? get getDoctorCedula => _doctorCedula;

  void setDoctorCedula(String? _value) {
    _doctorCedula = _value;
    // print('==_propietarioMascota ===> $_propietarioMascota');
    notifyListeners();
  }

  String? _doctoNombre = '';
  String? get getDoctoNombre => _doctoNombre;

  void setDoctoNombre(String? _value) {
    _doctoNombre = _value;
    // print('==_propietarioMascota ===> $_propietarioMascota');
    notifyListeners();
  }

//==========================================================================================//
  String? _propietarioCedulaMascota = '';
  String? get getPropietarioCedulaMascota => _propietarioCedulaMascota;

  void setPropietarioCedulaMascota(String? value) {
    _propietarioCedulaMascota = value;
    // print('==_propietarioCedulaMascota ===> $_propietarioCedulaMascota');
    notifyListeners();
  }

//==========================================================================================//
  String? _propietarioDirecionMascota = '';
  String? get getPropietarioDirecionMascota => _propietarioDirecionMascota;

  void setPropietarioDirecionMascota(String? value) {
    _propietarioDirecionMascota = value;
    // print('==_propietarioDirecionMascota ===> $_propietarioDirecionMascota');
    notifyListeners();
  }

  String? _propietarioTelefonoMascota = '';
  String? get getPropietarioTelefonoMascota => _propietarioTelefonoMascota;

  void setPropietarioTelefonoMascota(String? value) {
    _propietarioTelefonoMascota = value;
    // print('==_propietarioTelefonoMascota ===> $_propietarioTelefonoMascota');
    notifyListeners();
  }

//==========================================================================================//
  List? _propietarioCelularMascota = [];
  List? get getPropietarioCelularMascota => _propietarioCelularMascota;

  void setPropietarioCelularMascota(List? value) {
    _propietarioCelularMascota = value;
    // print('==_propietarioCelularMascota ===> $_propietarioCelularMascota');
    notifyListeners();
  }

//==========================================================================================//
  List? _propietarioEmailMascota = [];
  List? get getPropietarioEmailMascota => _propietarioEmailMascota;

  void setPropietarioEmailMascota(List? value) {
    _propietarioEmailMascota = value;
    // print('==_propietarioEmailMascota ===> $_propietarioEmailMascota');
    notifyListeners();
  }

//==========================================================================================//
  String? _pesoMascota = '';
  String? get getPesoMascota => _pesoMascota;

  void setPesoMascota(String? value) {
    _pesoMascota = value;
    // print('==_pesoMascota ===> $_pesoMascota');
    notifyListeners();
  }

//==========================================================================================//
  String? _procesoIgualAnterior = 'NO';
  String? get getProcesoIgualAnterior => _procesoIgualAnterior;

  void setProcesoIgualAnterior(String? value) {
    _procesoIgualAnterior = value;
    // print('==_procesoIgualAnterior ===> $_procesoIgualAnterior');
    notifyListeners();
  }

//==========================================================================================//
  String? _observaciones = '';
  String? get getObservaciones => _observaciones;

  void setObservaciones(String? value) {
    _observaciones = value;
    // print('==_recomendacionesMascota ===> $_recomendacionesMascota');
    notifyListeners();
  }

//==========================================================================================//
  String? _envioCorreo = '';
  String? get getEnvioCorreo => _envioCorreo;

  void setEnvioCorreo(String? value) {
    _envioCorreo = value;
    // print('==_recomendacionesMascota ===> $_recomendacionesMascota');
    notifyListeners();
  }

//==========================================================================================//
  String? _envioSMS = '';
  String? get getEnvioSMS => _envioSMS;

  void setEnvioSMS(String? value) {
    _envioSMS = value;
    // print('==_recomendacionesMascota ===> $_recomendacionesMascota');
    notifyListeners();
  }

//==========================================================================================//
  String? _inputFechaProximaCita =
      '${DateTime.now().year}-${(DateTime.now().month) < 10 ? '0${DateTime.now().month}' : '${DateTime.now().month}'}-${(DateTime.now().day) < 10 ? '0${DateTime.now().day}' : '${DateTime.now().day}'}';
  get getInputfechaProximaCita => _inputFechaProximaCita;
  void onInputFechaProximaCitaChange(String? date) async {
    _inputFechaProximaCita = date;
    // print('_inputFechaProximaCita =====>$_inputFechaProximaCita');

    notifyListeners();
  }
//==========================================================================================//

  String? _inputHoraProximaCita =
      '${DateTime.now().hour}:${DateTime.now().minute}';
  get getInputHoraProximaCita => _inputHoraProximaCita;
  void onInputHoraProximaCitaChange(String? date) {
    _inputHoraProximaCita = date;
    // print('_inputHoraProximaCita =====>$_inputHoraProximaCita');

    notifyListeners();
  }

//==========================================================================================//
  String? _inputDoctorMascota = '';
  get getInputDoctorMascota => _inputDoctorMascota;
  void onInputDoctorMascotaChange(String? date) async {
    _inputDoctorMascota = date;
    // print('_inputDoctorMascota =====>$_inputDoctorMascota');

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
    setRazaMascota(_inf['mascRaza']);
    setSexoMascota(_inf['mascSexo']);
    setEdadMascota(_inf['mascEdad']);
    setPesoMascota(_inf['mascPeso']);
    setPropietarioIdMascota(_inf['mascPerId']);
    setPropietarioMascota(_inf['mascPerNombre']);
    setPropietarioCedulaMascota(_inf['mascPerDocNumero']);
    setPropietarioDirecionMascota(_inf['mascPerDireccion']);
    setPropietarioTelefonoMascota(_inf['mascPerTelefono']);

    setPropietarioCelularMascota(_inf['mascPerCelular']);
    setPropietarioEmailMascota(_inf['mascPerEmail']);

    // print('==ID MASCOTA ===> $_idMascota');
    // print('==INFO MASCOTA ===> $_infoMascota');
    notifyListeners();
  }
//================================GET MASCOTA=============================================//

  dynamic _infoDoctor;
  dynamic get getInfoDoctor => _infoDoctor;
  // int? _idMascota;

  void setDoctorInfo(dynamic _inf) {
    _infoDoctor = _inf;
    setDoctorId(_inf['perId'].toString());
    setDoctorCedula(_inf['perDocNumero'].toString());
    setDoctoNombre(_inf['perNombre']);
    // _idMascota=_inf['mascId'];
    // setNombreMascota(_inf['mascNombre']);
    // setRazaMascota(_inf['mascRaza']);
    // setSexoMascota(_inf['mascSexo']);
    // setEdadMascota(_inf['mascEdad']);
    // // setPesoMascota(_inf['mascNombre']);
    // setPropietarioIdMascota(_inf['mascPerId']);
    // setPropietarioMascota(_inf['mascPerNombre']);
    // setPropietarioCedulaMascota(_inf['mascPerDocNumero']);
    // setPropietarioDirecionMascota(_inf['mascPerDireccion']);
    // setPropietarioCelularMascota(_inf['mascPerCelular']);
    // setPropietarioEmailMascota(_inf['mascPerEmail']);

    // print('==_infoDoctor ===> $_infoDoctor');
    // print('==INFO DOCTOR ===> $_infoDoctor');
    notifyListeners();
  }
  //===========================================//
//================================GET TIPO RESERVA=============================================//

  dynamic _infoTipoReserva;
  dynamic get getInfoTipoReserva => _infoTipoReserva;
  // int? _idMascota;

  void setTipoReservaInfo(dynamic _inf) {
    _infoTipoReserva = _inf;
    setTipoReservaId(_inf['tiporesId'].toString());
    setTipoReservaNombre(_inf['tiporesNombre']);
    // _idMascota=_inf['mascId'];
    // setNombreMascota(_inf['mascNombre']);
    // setRazaMascota(_inf['mascRaza']);
    // setSexoMascota(_inf['mascSexo']);
    // setEdadMascota(_inf['mascEdad']);
    // // setPesoMascota(_inf['mascNombre']);
    // setPropietarioIdMascota(_inf['mascPerId']);
    // setPropietarioMascota(_inf['mascPerNombre']);
    // setPropietarioCedulaMascota(_inf['mascPerDocNumero']);
    // setPropietarioDirecionMascota(_inf['mascPerDireccion']);
    // setPropietarioCelularMascota(_inf['mascPerCelular']);
    // setPropietarioEmailMascota(_inf['mascPerEmail']);

    // print('==ID MASCOTA ===> $_idMascota');
    // print('==INFO DOCTOR ===> $_infoDoctor');
    notifyListeners();
  }
  //===========================================//

  Timer? _deboucerSearchRecetas;

  //===================INPUT SEARCH COROSE==========================//
  String _nameSearchTipoReserva = "";
  String get nameSearchTipoReserva => _nameSearchTipoReserva;

  void onSearchTextTipoReserva(String data) {
    _nameSearchTipoReserva = data;
    if (_nameSearchTipoReserva.length >= 3) {
      _deboucerSearchRecetas?.cancel();
      _deboucerSearchRecetas = Timer(const Duration(milliseconds: 700), () {
        // print('=====> $data');
        buscaAllTipoReservas(data);
      });
    } else {
      buscaAllTipoReservas('');
      // buscaAusencias('','false');
    }
    notifyListeners();
  }
//================================== LISTAR DOCTORES  ==============================//

  List _listaAllTipoReservas = [];
  List get getListaAllTipoReservas => _listaAllTipoReservas;

  void setListaAllTipoReservas(List data) {
    _listaAllTipoReservas = data;
    // print('_listaAllTipoReservas: $_listaAllTipoReservas');
    // print('LA RAZA: ${_listaAllTipoReservas[0]['espRazas']}');

    notifyListeners();
  }

  bool? _errorAllTipoReservas; // sera nulo la primera vez
  bool? get getErrorAllTipoReservas => _errorAllTipoReservas;

  Future? buscaAllTipoReservas(String? _search) async {
    final dataUser = await Auth.instance.getSession();
    final response = await _api.getAllTipoReservas(
      search: _search,
      token: '${dataUser!.token}',
    );
    if (response != null) {
      _errorAllTipoReservas = true;
      setListaAllTipoReservas(response['data']);

      // setListaTodasLasRazas(response['data'][0]['espRazas']);

      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorAllTipoReservas = false;
      notifyListeners();
      return null;
    }
    return null;
  }

  //================================== ELIMINAR  PRIPIETARIO  ==============================//
  Future eliminaReserva(BuildContext context, int? idReserva) async {
    // final serviceSocket = SocketService();

    final serviceSocket = context.read<SocketService>();
    final infoUser = await Auth.instance.getSession();

    final _pyloadEliminaReserva = {
      "tabla": 'reserva',
      "rucempresa": infoUser!.rucempresa,
      "rol": infoUser.rol,
      "resId": idReserva,
    };

    serviceSocket.socket!.emit('client:eliminarData', _pyloadEliminaReserva);
  }

//======================================= GET INFO RESERVA ===========================================================//

  dynamic _infoReserva;
  String? _userData = '';
  String? _resUltima = '';
  int? _idReserva;
  void getInfoReserva(dynamic _data) async {
    _infoReserva = _data;

_userData=_data['resUser'];

//     _nuevoContacto = [];

    // print('LA RESERVA: $_infoReserva');
    _idReserva = _data['resId'];
    _idMascota = int.parse(_data['resMascId']);
    setNombreMascota(_data['resMascNombre']);
    setRazaMascota(_data['resMascRaza']);

    setPropietarioIdMascota(_data['resPerId']);
    setPropietarioMascota(_data['resPerNombre']);
    setPropietarioCedulaMascota(_data['resPerDocumento']);
    // setPropietarioDirecionMascota(_data['resMascRaza']);
    setPropietarioCelularMascota(_data['resPerCelular']);
    setPropietarioEmailMascota(_data['resPerEmail']);
    _resUltima = _data['resUltima'];
    setObservaciones(_data['resObservacion']);
    setEnvioCorreo(_data['resEnvioCorreo']);
    setEnvioSMS(_data['resEnvioSms']);

    setTipoReservaNombre(_data['resTipoReserva']);

    final _fecha = _data['resFecha'].split('T');

    onInputFechaProximaCitaChange(_fecha[0]);
    onInputHoraProximaCitaChange(_fecha.length > 1 ? _fecha[1] : '00:00');

    setTipoReservaNombre(_data['resTipoReserva']);

    setDoctorId(_data['resPerDocVeterinario']);

    setDoctoNombre(_data['resPerNomVeterinario']);
  }

//================================== CREA RECETA  ==============================//
  Future creaReserva(
    BuildContext context,
  ) async {
    final serviceSocket = context.read<SocketService>();
    final infoUser = await Auth.instance.getSession();

    final _pyloadNuevaReserva = {
      "tabla": "reserva",
      "rucempresa": infoUser!.rucempresa, // LOGIN
      "rol": infoUser.rol, //LOGIN

      "resId": '',
      "resMascId": _idMascota,
      "resMascNombre": _nombreMascota,

      "resMascRaza": _razaMascota,
      "resPerId": _propietarioIdMascota,
      "resPerDocumento": _propietarioCedulaMascota,
      "resPerNombre": _propietarioMascota,
      "resPerCelular": _propietarioCelularMascota,
      "resPerEmail": _propietarioEmailMascota,
      "resTipoReserva": _tipoReservaNombre,
      "resUltima": _resUltima,
      "resPerDocVeterinario": _doctorCedula,
      "resPerNomVeterinario": _doctoNombre,
      "resFecha": "${_inputFechaProximaCita}T$_inputHoraProximaCita",
      "resObservacion": _observaciones,
      "resEnvioCorreo": "PENDIENTE",
      "resEnvioSms": "PENDIENTE",

      "resEmpresa": infoUser.rucempresa,
      "resUser": infoUser.usuario,

      "resFecReg": "",
      "Todos": ""
    };

    //   print(
    //     '==========================JSON PARA CREAR reserva ===============================');
    // print(_pyloadNuevaReserva);
    // print(
    //     '==========================SOCKET RECETA ===============================');
    serviceSocket.socket!.emit('client:guardarData', _pyloadNuevaReserva);
  }

  //================================== CREA RESERVA  ==============================//
  Future editaReserva(
    BuildContext context,
  ) async {
    final serviceSocket = context.read<SocketService>();
    final infoUser = await Auth.instance.getSession();



    final _pyloadEditaReserva = {
      "tabla": "reserva",
      "rucempresa": infoUser!.rucempresa, // LOGIN
      "rol": infoUser.rol, //LOGIN

      "resId": _idReserva,
      "resMascId": _idMascota,
      "resMascNombre": _nombreMascota,

      "resMascRaza": _razaMascota,
      "resPerId": _propietarioIdMascota,
      "resPerDocumento": _propietarioCedulaMascota,
      "resPerNombre": _propietarioMascota,
      "resPerCelular": _propietarioCelularMascota,
      "resPerEmail": _propietarioEmailMascota,
      "resTipoReserva": _tipoReservaNombre,
      "resUltima": _resUltima,
      "resPerDocVeterinario": _doctorCedula,
      "resPerNomVeterinario": _doctoNombre,
      "resFecha": "${_inputFechaProximaCita}T$_inputHoraProximaCita",
      "resObservacion": _observaciones,
      "resEnvioCorreo": _envioCorreo,
      "resEnvioSms": _envioSMS,

      "resEmpresa": infoUser.rucempresa,
      // "resUser": infoUser.usuario,
      "resUser": "$_userData ** ${infoUser.usuario}",
      "resFecReg": "",
      "Todos": ""
    };
    //     print(
    //     '==========================JSON PARA CREAR Edita RECETA ===============================');
    // print(_pyloadEditaReserva);
    // print(
    //     '==========================SOCKET RECETA ===============================');
    serviceSocket.socket!.emit('client:actualizarData', _pyloadEditaReserva);
  }
}

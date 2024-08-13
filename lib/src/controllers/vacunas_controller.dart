import 'dart:async';

import 'package:flutter/material.dart';
import 'package:neitorcont/src/api/api_provider.dart';
import 'package:neitorcont/src/api/authentication_client.dart';
import 'package:neitorcont/src/models/auth_response.dart';
import 'package:neitorcont/src/services/socket_service.dart';
import 'package:provider/provider.dart';

class VacunasController extends ChangeNotifier {
  final _api = ApiProvider();
  GlobalKey<FormState> vacunasFormKey = GlobalKey<FormState>();

  AuthResponse? usuarios;
  bool validateForm() {
    if (vacunasFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  void resetFormVacuna() {
    _nombreMascota = '';
    _idMascota;
    _pesoMascota = '';
    _fechaCaducidad = '';
    _vetDoctorId = '';
    _vetDoctorNombre = '';
    _infoDoctor;
    _infoMascota;
    _labelTipoProducto = '';
    _labelProducto = '';
      _page = 0;
    _cantidad = 25;
    //  _listaVacunasPaginacion=[];
    _next = '';
    _isNext = false;
   _fechaColocacion = '${DateTime.now().year}-${(DateTime.now().month) < 10 ? '0${DateTime.now().month}' : '${DateTime.now().month}'}-${(DateTime.now().day) < 10 ? '0${DateTime.now().day}' : '${DateTime.now().day}'}';
  }

//  =================  CREO DEBOUNCE  PARA BUSQUEDAS ==================//

  Timer? _deboucerSearchVacunas;
  // Timer? _deboucerSearchBuscaPersona;

  @override
  void dispose() {
    _deboucerSearchVacunas?.cancel();
    // _deboucerSearchBuscaPersona?.cancel();

    // _videoController.dispose();
    super.dispose();
  }

//===================BOTON SEARCH Mascota ==========================//

  bool _btnSearchVacunas = false;
  bool get btnSearchVacunas => _btnSearchVacunas;

  void setBtnSearchVacunas(bool action) {
    _btnSearchVacunas = action;
    //  print('==_btnSearchCoros===> $_btnSearchVacunas');
    notifyListeners();
  }

  //===================INPUT SEARCH COROSE==========================//
  String _nameSearchVacunas = "";
  String get nameSearchVacunas => _nameSearchVacunas;

  void onSearchTextVacunas(String data) {
    _nameSearchVacunas = data;
    if (_nameSearchVacunas.length >= 3) {
      _deboucerSearchVacunas?.cancel();
      _deboucerSearchVacunas = Timer(const Duration(milliseconds: 700), () {
        // print('=====> $data');
        buscaAllVacunas(data);
      });
    } else {
      buscaAllVacunas('');
      // buscaAusencias('','false');
    }
    notifyListeners();
  }

//==================== LISTO TODAS LAS Vacunas CLINICAS====================//
  List _listaVacunas = [];

  List get getListaVacunas => _listaVacunas;

  void setInfoBusquedaVacunas(List data) {
    _listaVacunas = data;
    // print('Vacunas:$_listaVacunas');
    notifyListeners();
  }

  bool? _errorVacunas; // sera nulo la primera vez
  bool? get getErrorVacunas => _errorVacunas;
  set setErrorVacunas(bool? value) {
    _errorVacunas = value;
    notifyListeners();
  }

  bool? _error401Vacunas = false; // sera nulo la primera vez
  bool? get getError401Vacunas => _error401Vacunas;
  set setError401Vacunas(bool? value) {
    _error401Vacunas = value;
    notifyListeners();
  }

  Future buscaAllVacunas(String? _search) async {
    final dataUser = await Auth.instance.getSession();
// print('usuario : ${dataUser!.rucempresa}');
    final response = await _api.getAllVacunas(
      search: _search,
      // estado: 'CLIENTES',
      token: '${dataUser!.token}',
    );
    // if (response != null) {
    //   _errorVacunas = true;

    //   List dataSort = [];
    //   dataSort = response['data'];
    //   dataSort.sort((a, b) => b['carnFecReg']!.compareTo(a['carnFecReg']!));

    //   // setInfoBusquedaVacunas(response['data']);
    //   setInfoBusquedaVacunas(dataSort);
    //   // print('object;${response['data']}');
    //   notifyListeners();
    //   return response;
    // }
    if (response != null) {
      if (response == 401) {
        setInfoBusquedaVacunas([]);
        _error401Vacunas = true;
        notifyListeners();
        return response;
      } else {
        _errorVacunas = true;

        List dataSort = [];
        dataSort = response['data'];
        dataSort.sort((a, b) => b['carnFecReg']!.compareTo(a['carnFecReg']!));

        // setInfoBusquedaVacunas(response['data']);
        setInfoBusquedaVacunas(dataSort);
        // print('object;${response['data']}');
        notifyListeners();
        return response;
      }
    }
    if (response == null) {
      _errorVacunas = false;
      notifyListeners();
      return null;
    }
  }
  //================================GET INFO VCUNA=============================================//

  dynamic _infoVacuna;
  dynamic get getInfoVacuna => _infoVacuna;
  int? _idVacuna;
  String? _userData = '';
  void setVacunaInfo(dynamic _inf) {
    _infoVacuna = _inf;
    // print('==INFO Vacuna ===> $_infoVacuna');
    // print('==INFO _idVacuna ===> $_idVacuna');
      _userData = _infoVacuna['carnUser'];
    _idVacuna = _infoVacuna['carnId'];
    _idMascota = int.parse(_infoVacuna['carnMascId']);
    setNombreMascota(_infoVacuna['carnMascNombre']);
    setVetDoctorId(_infoVacuna['carnPerIdVet']);
    setVetDoctorNombre(_infoVacuna['carnPerNombreVet']);
    setPesoMascota(_infoVacuna['carnPeso']);
    setLabelTipoProducto(_infoVacuna['carnProdTipo']);
    setLabelProducto(_infoVacuna['carnProdNombre']);
    setFechaCaducudad(_infoVacuna['carnProdFecCaducidad']);
    setFechaColocacion(_infoVacuna['carnFecVacuColocacion']);
    setFechaRecolocacion(_infoVacuna['carnFecVacuRecolocacion']);
    setInputDiasRec(_infoVacuna['carnDiasVacuRecolocacion']);
    setObservacacion(_infoVacuna['carnObservacion']);

    notifyListeners();
  }

  //================================GET MASCOTA=============================================//
  //================================INPUT   MASCOTA=============================================//
  String? _nombreMascota = '';
  String? get getNombreMascota => _nombreMascota;

  void setNombreMascota(String? value) {
    _nombreMascota = value;

    notifyListeners();
  }

  //================================INFO   MASCOTA=============================================//
  dynamic _infoMascota;
  dynamic get getInfoMascota => _infoMascota;
  int? _idMascota;
  String? _carnPerId = '';
  String? _carnPerNombre = '';

  void setMascotaInfo(dynamic _inf) {
    _infoMascota = _inf;
    _idMascota = _inf['mascId'];
    _carnPerId = _inf['mascPerId'];
    _carnPerNombre = _inf['mascPerNombre'];
    setNombreMascota(_inf['mascNombre']);



    notifyListeners();
  }

//==========================================================================================//
  String? _pesoMascota = '';
  String? get getPesoMascota => _pesoMascota;

  void setPesoMascota(String? value) {
    _pesoMascota = value;
    // print('PESO ES:$_pesoMascota ');

    notifyListeners();
  }

//==========================================================================================//
  String? _fechaCaducidad = '';
  String? get getFechaCaducudad => _fechaCaducidad;

  void setFechaCaducudad(String? value) {
    _fechaCaducidad = value;
    // print('PESO ES:$_fechaCaducidad ');

    notifyListeners();
  }

//================================GET VETERINARIO=============================================//
  //========================================DOCTOR ==================================================//
  String? _vetDoctorId = '';
  String? get getDoctorId => _vetDoctorId;

  void setVetDoctorId(String? _value) {
    _vetDoctorId = _value;
    //
    notifyListeners();
  }

  String? _vetDoctorNombre = '';
  String? get getVetDoctorNombre => _vetDoctorNombre;

  void setVetDoctorNombre(String? _value) {
    _vetDoctorNombre = _value;
    //
    notifyListeners();
  }

  dynamic _infoDoctor;
  dynamic get getInfoDoctor => _infoDoctor;
  // int? _idMascota;

  void setDoctorInfo(dynamic _inf) {
    _infoDoctor = _inf;
    setVetDoctorId(_inf['perId'].toString());
    setVetDoctorNombre(_inf['perNombre']);
    notifyListeners();
  }

  //========================================FECHAS COLOCACION ==================================================//

  String? _fechaColocacion =
     '${DateTime.now().year}-${(DateTime.now().month) < 10 ? '0${DateTime.now().month}' : '${DateTime.now().month}'}-${(DateTime.now().day) < 10 ? '0${DateTime.now().day}' : '${DateTime.now().day}'}';
  get getFechaColocacion => _fechaColocacion;
  void setFechaColocacion(String? date) async {
    _fechaColocacion = date;

    notifyListeners();
  }

  //========================================FECHAS RECOLOCACION  ==================================================//
  String? _fechaRecolocacion;
  get getFechaRecolocacion => _fechaRecolocacion;
  void setFechaRecolocacion(String? date) async {
    _fechaRecolocacion = date;

    notifyListeners();
  }

  //========================================OBSERVACIONES ==================================================//
  String? _observacion;
  get getObservacacion => _observacion;
  void setObservacacion(String? date) async {
    _observacion = date;

    notifyListeners();
  }
//================================INGRESA dias =============================================//

  String _inputDiasRec = '';
  String? get getInputDiasRec => _inputDiasRec;

  void setInputDiasRec(String _days) {
    var _fecha_rec;

    int _dias;

    int _day;
    var _diasRec;
    _inputDiasRec = "";
    _inputDiasRec = _days;

    final _listfechColo = _fechaColocacion!.split('-');
    int anioCol, mesCol, diaCol;

    anioCol = int.parse(_listfechColo[0].trim());
    mesCol = int.parse(_listfechColo[1].trim());
    diaCol = int.parse(_listfechColo[2].trim());

    _fecha_rec = DateTime(anioCol, mesCol, diaCol);

    if (_days.isEmpty) {
      _day = int.parse(_inputDiasRec = '0');
      _diasRec = _fecha_rec.add(Duration(days: _day));

      setFechaRecolocacion(_diasRec.toString().substring(0, 10));
    } else if (int.parse(_days) <= 9) {
      _day = int.parse(_inputDiasRec = _days);
      _diasRec = _fecha_rec.add(Duration(days: _day));

      setFechaRecolocacion(_diasRec.toString().substring(0, 10));
    } else {
      _day = int.parse(_inputDiasRec);
      _diasRec = _fecha_rec.add(Duration(days: _day));

      setFechaRecolocacion(_diasRec.toString().substring(0, 10));
    }

    notifyListeners();
  }

  //==================== LISTO TODOS LOS PRODUCTOS====================//
  List _listaProductos = [];

  List get getListaProductos => _listaProductos;

  void setInfoBusquedaProductos(List data) {
    _listaProductos = data;
    // print('Productos:${_listaProductos[0]['invNombre']}');
    // print('Productos:${_listaProductos[1]['invNombre']}');
    notifyListeners();
  }

  bool? _errorProductos; // sera nulo la primera vez
  bool? get getErrorProductos => _errorProductos;
  set setErrorProductos(bool? value) {
    _errorProductos = value;
    notifyListeners();
  }

  Future buscaAllProductos(String? _tipo) async {
    final dataUser = await Auth.instance.getSession();
// print('usuario : ${dataUser!.rucempresa}');
    final response = await _api.getAllProductos(
      tipo: _tipo,
      // estado: 'CLIENTES',
      token: '${dataUser!.token}',
    );
    if (response != null) {
      _errorProductos = true;

      List dataSort = [];
      dataSort = response['data'];
      dataSort.sort((a, b) => b['invFecReg']!.compareTo(a['invFecReg']!));

      // setInfoBusquedaProductos(response['data']);
      // setInfoBusquedaProductos(response['data']);
      setInfoBusquedaProductos(dataSort);
      // print('object;${response['data']}');
      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorVacunas = false;
      notifyListeners();
      return null;
    }
  }

//========================== SELECT TITPO PRODUCTO =======================//
  String? _labelTipoProducto;

  String? get labelTipoProducto => _labelTipoProducto;

  void setLabelTipoProducto(String value) {
    _labelTipoProducto = value;

    notifyListeners();
  }

//========================== SELECT PRODUCTO =======================//
  String? _labelProducto;

  String? get labelProducto => _labelProducto;

  void setLabelProducto(String value) {
    _labelProducto = value;

    notifyListeners();
  }

//================================== CREA NUEVA CONSIGNA  ==============================//
  Future crearVacuna(
    BuildContext context,
  ) async {
    final serviceSocket = context.read<SocketService>();
    final infoUser = await Auth.instance.getSession();

    // print(
    //     '==========================JSON PARA CREAR NUEVA VACUNA ===============================');
    final _pyloadNuevaVacuna = {
      "tabla": "carnetvacuna", //DEFECTO
      "rucempresa": infoUser!.rucempresa, // LOGIN
      "rol": infoUser.rol, //LOGIN

      "carnPerId": _carnPerId,
      "carnPerNombre": _carnPerNombre,

      "carnId": "",
      "carnMascId": _idMascota,
      "carnMascNombre": _nombreMascota,
      "carnPerIdVet": _vetDoctorId,
      "carnPerNombreVet": _vetDoctorNombre,
      "carnPeso": _pesoMascota,
      "carnProdTipo": _labelTipoProducto,
      "carnProdNombre": _labelProducto,
      "carnProdFecCaducidad": _fechaCaducidad,
      "carnFecVacuColocacion": _fechaColocacion,
      "carnFecVacuRecolocacion": _fechaRecolocacion,
      "carnDiasVacuRecolocacion": _inputDiasRec,
      "carnObservacion": _observacion,
      "carnCorreo": "PENDIENTE",
      "carnMensaje": "PENDIENTE",

      "carnUser": infoUser.usuario,
      "carnEmpresa": infoUser.rucempresa,
      "carnFecReg": "",
      "Todos": "",
    };
    // print(
    //     '==========================JSON PARA CREAR NUEVO GUARDIA ===============================');
    // print(_pyloadNuevaVacuna);
    // // // print(
    //     '==========================JSON DE PERSONAL DEIGNADO ===============================');
    serviceSocket.socket!.emit('client:guardarData', _pyloadNuevaVacuna);
  }

//================================== CREA NUEVA CONSIGNA  ==============================//
  Future editarVacuna(
    BuildContext context,
  ) async {
    final serviceSocket = context.read<SocketService>();
    final infoUser = await Auth.instance.getSession();

    // print(
    //     '==========================JSON PARA CREAR NUEVA VACUNA ===============================');
    final _pyloadEditarVacuna = {
      "tabla": "carnetvacuna", //DEFECTO
      "rucempresa": infoUser!.rucempresa, // LOGIN
      "rol": infoUser.rol, //LOGIN

      "carnPerId": _carnPerId,
      "carnPerNombre": _carnPerNombre,

      "carnId": _idVacuna,
      "carnMascId": _idMascota,
      "carnMascNombre": _nombreMascota,
      "carnPerIdVet": _vetDoctorId,
      "carnPerNombreVet": _vetDoctorNombre,
      "carnPeso": _pesoMascota,
      "carnProdTipo": _labelTipoProducto,
      "carnProdNombre": _labelProducto,
      "carnProdFecCaducidad": _fechaCaducidad,
      "carnFecVacuColocacion": _fechaColocacion,
      "carnFecVacuRecolocacion": _fechaRecolocacion,
      "carnDiasVacuRecolocacion": _inputDiasRec,
      "carnObservacion": _observacion,
      "carnCorreo": "PENDIENTE",
      "carnMensaje": "PENDIENTE",

      "carnUser": "$_userData ** ${infoUser.usuario}",
      "carnEmpresa": infoUser.rucempresa,
      "carnFecReg": "",
      "Todos": "",
    };
    // print(
    //     '==========================JSON PARA CREAR NUEVO GUARDIA ===============================');
    // print(_pyloadEditarVacuna);
    // // // print(
    //     '==========================JSON DE PERSONAL DEIGNADO ===============================');
    serviceSocket.socket!.emit('client:actualizarData', _pyloadEditarVacuna);
  }

  //================================== ELIMINAR  VACUNA  ==============================//
  Future eliminaVacuna(BuildContext context, int? idVacuna) async {
    // final serviceSocket = SocketService();

    final serviceSocket = context.read<SocketService>();
    final infoUser = await Auth.instance.getSession();

    final _pyloadEliminaVacuna = {
      "tabla": 'carnetvacuna',
      "rucempresa": infoUser!.rucempresa,
      "rol": infoUser.rol,
      "carnId": idVacuna,
    };

    serviceSocket.socket!.emit('client:eliminarData', _pyloadEliminaVacuna);
  }

//=====================//


//=================================================================================================================//
  // ================= VARIABLES DE PAGINACION ====================//
//=================================================================================================================//
//===================BOTON SEARCH PAGINACION ==========================//

  bool _btnSearchVacunasPaginacion = false;
  bool get btnSearchVacunPaginacion => _btnSearchVacunasPaginacion;

  void setBtnSearchVacunaPaginacion(bool action) {
    _btnSearchVacunasPaginacion = action;
    //  print('==_btnSearchCoros===> $_btnSearchPropietarios');
    notifyListeners();
  }

  //===================INPUT SEARCH PROPIETARIO==========================//
  String _nameSearchVacunaPaginacion = "";
  String get nameSearchVacunaPaginacion =>
      _nameSearchVacunaPaginacion;

  void onSearchTextVacunaPaginacion(String data) {
    _nameSearchVacunaPaginacion = data;
     print('VacunNOMBRE:${_nameSearchVacunaPaginacion}');
     }
//=============================================================================//

 //================= LISTA PROPIETARIOS SIN PAGINACION ===================/

  List _listaVacunasPaginacion = [];
  // List<TipoMulta> get getListaTodosLosTiposDeMultas => _listaTodosLosTiposDeMultas;
  List get getListaVacunasPaginacion => _listaVacunasPaginacion;

  void setInfoBusquedaVacunasPaginacion(List data) {
    _listaVacunasPaginacion.addAll(data);
    print('Vacunas :${_listaVacunasPaginacion.length}');

    // for (var item in _listaVacunasPaginacion) {
    //    print('-->:${item['perId']}');
    // }

    notifyListeners();
  }

  bool? _errorVacunasPaginacion; // sera nulo la primera vez
  bool? get getErrorVacunasPaginacion => _errorVacunasPaginacion;
  void setErrorVacunasPaginacion(bool? value) {
    _errorVacunasPaginacion = value;
    notifyListeners();
  }

  bool? _error401VacunasPaginacion = false; // sera nulo la primera vez
  bool? get getError401VacunasPaginacion => _error401VacunasPaginacion;
  void setError401VacunasPaginacion(bool? value) {
    _error401VacunasPaginacion = value;
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

  Future buscaAllVacunasPaginacion(String? _search, bool _isSearch) async {
    final dataUser = await Auth.instance.getSession();
// print('usuario : ${dataUser!.rucempresa}');
    final response = await _api.getAllVacunasPaginacion(
      search: _search,
      page: _page,
      cantidad: _cantidad,

      input: 'carnId',
      orden: false,
      idmascota:null,
      token: '${dataUser!.token}',
    );

    if (response != null) {
      if (response == 401) {
        setInfoBusquedaVacunasPaginacion([]);
        _error401VacunasPaginacion = true;
        notifyListeners();
        return response;
      } else {
        _errorVacunasPaginacion = true;
        if (_isSearch == true) {
          _listaVacunasPaginacion = [];
        }
        List<dynamic> dataSort = response['data']['results'];
        dataSort.sort((a, b) => b['carnFecReg']!.compareTo(a['carnFecReg']!));

        setPage(response['data']['pagination']['next']);

        setInfoBusquedaVacunasPaginacion(dataSort);
        notifyListeners();
        return response;
      }

      //===========================================//

    }
    if (response == null) {
      _errorVacunasPaginacion = false;
      notifyListeners();
      return null;
    }
  }














}

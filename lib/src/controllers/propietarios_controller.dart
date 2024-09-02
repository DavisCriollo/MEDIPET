import 'dart:async';
import 'dart:convert';
// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:neitorcont/src/api/api_provider.dart';
import 'package:neitorcont/src/api/authentication_client.dart';
import 'package:neitorcont/src/services/socket_service.dart';
import 'package:neitorcont/src/utils/valida_cedula.dart';
import 'package:provider/provider.dart';

class PropietariosController extends ChangeNotifier {
  GlobalKey<FormState> propietariosFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> placaFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> celularFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> correoFormKey = GlobalKey<FormState>();
  final _api = ApiProvider();

  bool validateFormPropietario() {
    if (propietariosFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  bool validateFormPlaca() {
    if (placaFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }
  bool validateFormCelular() {
    if (celularFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  bool validateFormCorreo() {
    if (correoFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

//  =================  RESET FORM PROPIETARIO ==================//

  void resetFormPropietario() {
    _labelTipoDocumento = 'CEDULA';
    _documentos = '';
    _generos;
    _nombres;
    _recomendacion;
    _ocupacion;
    _direccion;
    _labelTelefono;
    _listaAddCelulares = [];
    _listaRecomendaciones = [];
    _listaAddCorreos = [];
    _listaTodosLosPaises.clear();
    _listaTodasLasProvincias.clear();
    _listaTodosLosCantones.clear();
    _pais;
    _provincia;
    _canton;
    _observacion;
    _isCedula = false;
    _isCedulaOk = false;
    _page = 0;
    _cantidad = 25;
     _listaPropietariosPaginacion=[];
    _next = '';
    _isNext = false;
    // print('SE RESET LOS CAMPOS');
  }

//  =================  CREO DEBOUNCE  PARA BUSQUEDAS ==================//

  Timer? _deboucerSearchBuscaPropietario;
  Timer? _deboucerSearchBuscaPropietarioPaginacion;
  Timer? _deboucerSearchBuscaPersona;

  @override
  void dispose() {
    _deboucerSearchBuscaPropietario?.cancel();
    _deboucerSearchBuscaPersona?.cancel();
    _deboucerSearchBuscaPropietarioPaginacion?.cancel();
    // _videoController.dispose();
    super.dispose();
  }

//===================BOTON SEARCH PROPIETARIO ==========================//

  bool _btnSearchPropietarios = false;
  bool get btnSearchPropietario => _btnSearchPropietarios;

  void setBtnSearchPropietario(bool action) {
    _btnSearchPropietarios = action;
    //  print('==_btnSearchCoros===> $_btnSearchPropietarios');
    notifyListeners();
  }

  //===================INPUT SEARCH PROPIETARIO==========================//
  String _nameSearchPropietario = "";
  String get nameSearchPropietario => _nameSearchPropietario;

  void onSearchTextPropietario(String data) {
    _nameSearchPropietario = data;
    if (_nameSearchPropietario.length >= 3) {
      _deboucerSearchBuscaPropietario?.cancel();
      _deboucerSearchBuscaPropietario =
          Timer(const Duration(milliseconds: 700), () {
        // print('=====> $data');
        buscaAllPropietarios(data);
      });
    } else {
      // buscaAusencias('','false');
    }
    notifyListeners();
  }



//===================BOTON SEARCH PERSONA ==========================//

  bool _btnSearchPersona = false;
  bool get btnSearchPersona => _btnSearchPersona;

  void setBtnSearchPersona(bool action) {
    _btnSearchPersona = action;
    //  print('==_btnSearchCoros===> $_btnSearchPropietarios');
    notifyListeners();
  }

  //===================INPUT SEARCH COROSE==========================//
  String _nameSearchPersona = "";
  String get nameSearchPersona => _nameSearchPersona;

  void onSearchTextPersona(String data) {
    _nameSearchPersona = data;
    if (_nameSearchPersona.length >= 3) {
      _deboucerSearchBuscaPersona?.cancel();
      _deboucerSearchBuscaPersona =
          Timer(const Duration(milliseconds: 700), () {
        // print('=====> $data');
        searchAllPersinas(data);
      });
    } else {
      // buscaAusencias('','false');
    }
    notifyListeners();
  }

//================================OBTENEMOS EL TIPODOCUMENTO=============================================//
  String? _tipoDocumentos;
  String? get getTipoDocumento => _tipoDocumentos;

  void setTipoDocumento(String? value) {
    _tipoDocumentos = value;
    // print('==_TIPOdocumentos===> $_tipoDocumentos');
    notifyListeners();
  }

//=============================================================================//
//================================ESTADO EL DOCUMENTO=============================================//
  bool _isCedula = false;
  bool get getIsCedula => _isCedula;

  void setIsCedula(bool value) {
    _isCedula = value;
    // print('==_isCedula===> $_isCedula');
    notifyListeners();
  }

//================================OBTENEMOS EL DOCUMENTO=============================================//
  String? _documentos = '';
  String? get getDocumento => _documentos;

  void setDocumento(String? value) async {
    _documentos = value;
    // print('==_documentos===> $_documentos');
    if (_documentos!.length == 10) {
      final _respCedula = await validaCedula(_documentos!);
      // print('CANTIDAD CARACTERES :${_documentos!.length}');
      print('CANTIDAD CARACTERES :$_documentos');
      if (_respCedula) {
        _isCedula = true;
      } else {
        _isCedula = false;
      }
    }
    notifyListeners();
  }

//=============================================================================//
//================================SELECCIONAMOS EL GENERO=============================================//
  String? _generos;
  String? get getGeneros => _generos;

  void setGeneros(String? value) {
    _generos = value;
    // print('==_generos===> $_generos');
    notifyListeners();
  }

//========================== DROPDOWN DIRIGIDO A  =======================//
  String? _labelTipoCliente;

  String? get labelTipoCliente => _labelTipoCliente;

  void setLabelTipoCliente(String value) {
    _labelTipoCliente = value;

    // print('-----ss:$_labelTipoCliente');
    notifyListeners();
  }

//========================== DROPDOWN TIPO DDE DOCUMENTO  =======================//
  String? _labelTipoDocumento = 'CEDULA';

  String? get labelTipoDocumento => _labelTipoDocumento;

  void setLabelTipoDocumento(String value) {
    _labelTipoDocumento = value;
    // if (value == 'CEDULA' || value == 'RUC') {
    //   _isCedula = true;
    // }

    // print('-----ss:$_labelTipoDocumento');
    notifyListeners();
  }

//========================== DROPDOWN TELEFONO  =======================//
  String? _labelTelefono;

  String? get labelTelefono => _labelTelefono;

  void setLabelTelefono(String value) {
    _labelTelefono = value;

    // print('-----ss:$_labelTelefono');
    notifyListeners();
  }

//========================== VALIDA INPUT TELEFONO  =======================//
  bool? _isCelular;

  bool? get getIsCelular => _isCelular;

  void setIsCelular(bool? value) {
    _isCelular = value;

    // print('-----ss:$_isCelular');
    notifyListeners();
  }
//========================== ITEM DE CelularS  =======================//

  String? _itemCodeCelulares = '';
  String? get getItemCodeCelular => _itemCodeCelulares;

  void seItemCodeCelular(String? valor) {
    if (valor == '593') {
      _itemCodeCelulares = '+$valor' + '9';
    } else {
      _itemCodeCelulares = '+$valor';
    }

    // print('item _itemCodeCelulares: $_itemCodeCelulares');

    notifyListeners();
  }
//========================== ITEM DE CelularS  =======================//

  // String? _itemAddCelulares = '';
  // String? get getItemAddCelulars => _itemAddCelulares;

  // void seItemAddCelulars(String? valor) {
  //   _itemAddCelulares = valor;
  //   if (_itemAddCelulares!.isNotEmpty) {
  //     _isCelular = true;
  //   } else {
  //     _isCelular = false;
  //   }

  //   // print('item Celulars: $_itemAddCelulares');
  //   notifyListeners();
  // }

  // void getNumeroCelular(){

  //   _itemAddCelulares!.replaceAll('from', replace)
  // }
//========================== LISTA DE PLACAS  =======================//
  String? _itemAddPlaca = '';
  String? get getItemAddPlaca => _itemAddPlaca;

  void seItemAddPlaca(String? valor) {
    _itemAddPlaca = valor;
    // print('item Celulars: $_itemAddCelulares');
    notifyListeners();
  }


  List? _listaAddPlacas = [];
  List? get getlistaAddPlacas => _listaAddPlacas;

  void agregaListaPlacas() {
    _listaAddPlacas!.add(_itemAddPlaca);

    notifyListeners();
  }

  void eliminaPlaca(String? _placa) {
    _listaAddPlacas!.removeWhere((e) => e == _placa);

    notifyListeners();
  }
  resetPlacas(){
     _listaAddPlacas!.clear();
  }
//========================== LISTA DE CELULARES  =======================//
  String? _itemAddCelulares = '';
  String? get getItemAddCelular => _itemAddCelulares;

  void seItemAddCelulars(String? valor) {
    _itemAddCelulares = valor;
    // print('item Celulars: $_itemAddCelulares');
    notifyListeners();
  }


  List? _listaAddCelulares = [];
  List? get getlistaAddCelulares => _listaAddCelulares;

  void agregaListaCelulares() {
    _listaAddCelulares!.add(_itemAddCelulares);

    notifyListeners();
  }

  void eliminaCelular(String? _celular) {
    _listaAddCelulares!.removeWhere((e) => e == _celular);

    notifyListeners();
  }
resetCelulares(){
     _listaAddCelulares!.clear();
  }
//========================== VALIDA INPUT CORREO  =======================//
  bool? _isCorreo;

  bool? get getIsCorreo => _isCorreo;

  void setIsCorreo(bool? value) {
    _isCorreo = value;
    // notifyListeners();
  }
//========================== ITEM DE CORREOS  =======================//

  String? _itemAddCorreos = '';
  String? get getItemAddCorreos => _itemAddCorreos;

  void seItemAddCorreos(String? valor) {
    _itemAddCorreos = valor;

    notifyListeners();
  }
//========================== LISTA DE CORREOS  =======================//

  List? _listaAddCorreos = [];
  List? get getlistaAddCorreos => _listaAddCorreos;

  void agregaListaCorreos() {
    _listaAddCorreos!.add(_itemAddCorreos);

    notifyListeners();
  }

  void eliminaCorreo(String? _correo) {
    _listaAddCorreos!.removeWhere((element) => element == _correo);

    notifyListeners();
  }
  resetCorreos(){
     _listaAddCorreos!.clear();
  }

//================================SELECCIONAMOS EL NOMBRE=============================================//
  String? _nombres = '';
  String? get getNombres => _nombres;

  void setNombres(String? value) {
    _nombres = value;
    // print('==_nombres===> $_nombres');
    notifyListeners();
  }

//================================SELECCIONAMOS LA OCUPACION=============================================//
  String? _ocupacion = '';
  String? get getOcupacion => _ocupacion;

  void setOcupacion(String? value) {
    _ocupacion = value;

    notifyListeners();
  }

//================================SELECCIONAMOS LA DIRECCION=============================================//
  String? _direccion = '';
  String? get getDireccion => _direccion;

  void setDireccion(String? value) {
    _direccion = value;

    notifyListeners();
  }

//================================SELECCIONAMOS LA OBSERVACION=============================================//
  String? _observacion = '';
  String? get getObservacion => _observacion;

  void setObservacion(String? value) {
    _observacion = value;

    notifyListeners();
  }

//================================== LISTAR RECOMENDACIONES  ==============================//

  String? _recomendacion;
  String? get getRecomendacion => _recomendacion;

  void setRecomendacion(String? value) {
    _recomendacion = value;
    // print('Recomendacion : ${_recomendacion}');
    notifyListeners();
  }

  List _listaRecomendaciones = [];
  List get getListaRecomendaciones => _listaRecomendaciones;

  void setListaRecomendaciones(List data) {
    _listaRecomendaciones = data;
    print('data RECOMENDACIONES : ${_listaRecomendaciones}');
    notifyListeners();
  }

  bool? _errorRecomendaciones; // sera nulo la primera vez
  bool? get getErrorRecomendaciones => _errorRecomendaciones;

  Future? buscaRecomendaciones() async {
    final dataUser = await Auth.instance.getSession();
    final response = await _api.getAllRecomendaciones(
      // cantidad: 100,
      // page: 0,
      // search: search,
      // input: 'cliId',
      // orden: false,
      // datos: '',
      // rucempresa: '${dataUser!.rucempresa}',
      // estado: 'CLIENTES',
      token: '${dataUser!.token}',
    );
    if (response != null) {
      _errorRecomendaciones = true;
      setListaRecomendaciones(response['data']);

      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorRecomendaciones = false;
      notifyListeners();
      return null;
    }
    return null;
  }

//==================================  PAISES  ==============================//
//================================== LISTAR PAISES  ==============================//
  List _listaTodosLosPaises = [];
  List get getListaTodosLosPaises => _listaTodosLosPaises;

  void setListaTodosLosPaises(List data) {
    _listaTodosLosPaises = data;
   
    notifyListeners();
  }

  bool? _errorPaises; // sera nulo la primera vez
  bool? get getErrorPaises => _errorPaises;

  Future? buscaPaises() async {
    final dataUser = await Auth.instance.getSession();
    final response = await _api.getAllPaises(
      // cantidad: 100,
      // page: 0,
      // search: search,
      // input: 'cliId',
      // orden: false,
      // datos: '',
      // rucempresa: '${dataUser!.rucempresa}',
      // estado: 'CLIENTES',
      token: '${dataUser!.token}',
    );
    if (response != null) {
      _errorPaises = true;
      setListaTodosLosPaises(response['data']);

      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorPaises = false;
      notifyListeners();
      return null;
    }
    return null;
  }

//================================== LISTAR PROVINCIAS  ==============================//

 String _provincia = '';
  String get getProvincia => _provincia;

  void setProvincia(String data) {
    _provincia = data;
    notifyListeners();
  }

  List _listaTodasLasProvincias = [];
  List get getListaTodasLasProvincias => _listaTodasLasProvincias;

  void setListaTodasLasProvincias(List data) {
    _listaTodasLasProvincias = data;
    notifyListeners();
  }

  bool? _errorProvincias; // sera nulo la primera vez
  bool? get getErrorProvincias => _errorProvincias;

  Future? buscaProvincias(int code) async {
    final dataUser = await Auth.instance.getSession();
    final response = await _api.getAllProvincias(
      code: code,
      // cantidad: 100,
      // page: 0,
      // search: search,
      // input: 'cliId',
      // orden: false,
      // datos: '',
      // rucempresa: '${dataUser!.rucempresa}',
      // estado: 'CLIENTES',
      token: '${dataUser!.token}',
    );
    if (response != null) {
      _errorProvincias = true;
      setListaTodasLasProvincias(response['data']);

      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorProvincias = false;
      notifyListeners();
      return null;
    }
    return null;
  }

//================================== LISTAR CANTONES  ==============================//
  List _listaTodosLosCantones = [];
  List get getListaTodosLosCantones => _listaTodosLosCantones;

  void setListaTodosLosCantones(List data) {
    _listaTodosLosCantones = data;
    // print('data CANTONES : ${_listaTodosLosCantones}');
    notifyListeners();
  }

  bool? _errorCantones; // sera nulo la primera vez
  bool? get getErrorCantones => _errorCantones;

  Future? buscaCantones(int code) async {
    final dataUser = await Auth.instance.getSession();
    final response = await _api.getAllCantones(
      code: code,
      // cantidad: 100,
      // page: 0,
      // search: search,
      // input: 'cliId',
      // orden: false,
      // datos: '',
      // rucempresa: '${dataUser!.rucempresa}',
      // estado: 'CLIENTES',
      token: '${dataUser!.token}',
    );
    if (response != null) {
      _errorCantones = true;
      setListaTodosLosCantones(response['data']);

      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorCantones = false;
      notifyListeners();
      return null;
    }
    return null;
  }
//================================== SELECCIONA PAIS  ==============================//

  String? _pais='';
  String? get getPais => _pais;

  void setPais(String? value) {
    _pais = value;
    _listaTodasLasProvincias = [];
    _listaTodosLosCantones = [];
    // _provincia = null;
    // _canton = null;

    notifyListeners();
  }
//================================== SELECCIONA PAIS  ==============================//

  // String? _provincia;
  // String? get getProvincia => _provincia;

  // void setProvincia(String? value) {
  //   _provincia = value;
  //   // print('PROVINCIA:$_provincia');
  //   _canton = null;

  //   notifyListeners();
  // }
//================================== SELECCIONA PAIS  ==============================//

  String? _canton='';
  String? get getCanton => _canton;

  void setCanton(String? value) {
    _canton = value;
    notifyListeners();
  }

//================================== CREA NUEVA CONSIGNA  ==============================//
  Future crearPropietario(
    BuildContext context,
  ) async {
    final serviceSocket = context.read<SocketService>();

    // print(
    //     '========================= GUARDA NUEVO INFORME ================================');
    // print('--_labelTipoDocumento -->:$_labelTipoDocumento');
    // print('--_documentos -->:$_documentos');
    // print('--_generos-->:$_generos');
    // print('--_nombres-->:$_nombres');
    // print('--_recomendacion-->:$_recomendacion');
    // print('--_ocupacion-->:$_ocupacion');
    // print('--_direccion-->:$_direccion');
    // print('--_labelTelefono-->:$_labelTelefono');
    // print('--_listaAddCelulares-->:$_listaAddCelulares');
    // print('--_listaAddCorreos-->:$_listaAddCorreos');
    // print('--_pais-->:$_pais');
    // print('--_provincia-->:$_provincia');
    // print('--_canton-->:$_canton');
    // print('--_observacion-->:$_observacion');
    final infoUser = await Auth.instance.getSession();
    // print(
    //     '==========================DATOS DEL TELEFONO ===============================');
    // print('rucEmpresa ${infoUser!.rucempresa}');
    // print('rucempresa ${infoUser.rucempresa}');
    // print('user ${infoUser.usuario}');
    // print(
    //     '==========================JSON PARA CREAR NUEVA COMPRA ===============================');
    final _pyloadNuevoPropietario = {
      "tabla": "proveedor", //DEFECTO
      "rucempresa": infoUser!.rucempresa, // LOGIN
      "rol": infoUser.rol, //LOGIN
     
      "perId": "",
      "perDocTipo": _labelTipoDocumento,
      "perDocNumero": _documentos,
      "perPerfil": ["CLIENTE"],
      "perNombre": _nombres,
      "perNombreComercial": "",
      "perDireccion": _direccion,
      "perObligado": "NO",
      "perTipoProveedor": "BIENES",
      "perTiempoCredito": "0",
      "perCredito": "NO",
      "perTelefono": _labelTelefono,
      "perCelular": _listaAddCelulares,
      "perGenero": _generos,
      "perRecomendacion":"OTROS",// _recomendacion,
      "perFecNacimiento": _listaBusquedaCliente['perFecNacimiento'],
      "perEspecialidad": _listaBusquedaCliente['perEspecialidad'],
      "perTitulo": "",
      "perSenescyt": "",
      "perPersonal": "INTERNO",
      "perEstado": "ACTIVO",
      "perObsevacion": _observacion,
      "perEmail": _listaAddCorreos,
      "perNickname": "",
      "perPais": _pais,
      "perProvincia": _provincia,
      "perCanton": _canton,
      "perEmpresa": [infoUser.rucempresa],
      "perUser": infoUser.usuario,
      "perOtros": _listaAddPlacas,
      "perFoto": "",
      "perDocumento": "",
      "perUbicacion": {"longitud": "", "latitud": ""},
      "perISPContratos":_listaBusquedaCliente['perISPContratos'],

    };
    // };
    // print(
    //     '==========================JSON PARA CREAR NUEVO GUARDIA ===============================');
    // print(_pyloadNuevoPropietario);
    // // // print(
    // //     '==========================JSON DE PERSONAL DEIGNADO ===============================');
  
   serviceSocket.sendMessage('client:guardarData', _pyloadNuevoPropietario);
  
  //  serviceSocket.socket!.emit('client:guardarData', _pyloadNuevoPropietario);
  }

//==================== LISTO TODOS  PROPIETARIOS====================//
  List _listaPropietarios = [];
  // List<TipoMulta> get getListaTodosLosTiposDeMultas => _listaTodosLosTiposDeMultas;
  List get getListaPropietarios => _listaPropietarios;

  void setInfoBusquedaPropietarios(List data) {
    _listaPropietarios = data;
    // print('PROPIETARIOS:$_listaPropietarios');
    notifyListeners();
  }

  bool? _errorPropietarios; // sera nulo la primera vez
  bool? get getErrorPropietarios => _errorPropietarios;
  set setErrorPropietarios(bool? value) {
    _errorPropietarios = value;
    notifyListeners();
  }

  bool? _error401Propietarios = false; // sera nulo la primera vez
  bool? get getError401Propietarios => _error401Propietarios;
  set setError401Propietarios(bool? value) {
    _error401Propietarios = value;
    notifyListeners();
  }

  //================= LISTA PROPIETARIOS SIN PAGINACION ===================/
  Future buscaAllPropietarios(String? _search) async {
    final dataUser = await Auth.instance.getSession();
// print('usuario : ${dataUser!.rucempresa}');
    final response = await _api.getAllPropietarios(
      search: _search,
      estado: 'CLIENTES',
      token: '${dataUser!.token}',
    );

    if (response != null) {
      if (response == 401) {
        setInfoBusquedaPropietarios([]);
        _error401Propietarios = true;
        notifyListeners();
        return response;
      } else {
        _errorPropietarios = true;

        List dataSort = [];
        dataSort = response['data'];
        dataSort.sort((a, b) => b['perFecReg']!.compareTo(a['perFecReg']!));

        // setInfoBusquedaMascotas(response['data']);
        setInfoBusquedaPropietarios(dataSort);
        // print('object;${response['data']}');
        notifyListeners();
        return response;
      }
    }
    if (response == null) {
      _errorPropietarios = false;
      notifyListeners();
      return null;
    }
  }
 
//==================== LISTO BUSQUEDA DE TODOS  PROPIETARIOS====================//
  List _listaBusquedapersonas = [];
  // List<TipoMulta> get getListaTodosLosTiposDeMultas => _listaTodosLosTiposDeMultas;
  List get getListaBusquedaPersonas => _listaBusquedapersonas;

  void setBusquedaPersonas(List data) {
    _listaBusquedapersonas = data;

    // print('personas BUSCADA:$_listaBusquedapersonas');
    notifyListeners();
  }

  bool? _errorBusquedaPersona; // sera nulo la primera vez
  bool? get getErrorBusquedaPersona => _errorBusquedaPersona;
  set setErrorBusquedaPersona(bool? value) {
    _errorBusquedaPersona = value;
    notifyListeners();
  }

  Future searchAllPersinas(String? _search) async {
    final dataUser = await Auth.instance.getSession();
// print('usuario : ${dataUser!.rucempresa}');
    final response = await _api.searchAllPropietarios(
      search: _search,
      // estado: 'CLIENTES',
      token: '${dataUser!.token}',
    );
    if (response != null) {
      _errorBusquedaPersona = true;

      List dataSort = [];
      dataSort = response['data'];
      dataSort.sort((a, b) => b['perFecReg']!.compareTo(a['perFecReg']!));

      // setInfoBusquedaPropietarios(response['data']);
      setBusquedaPersonas(dataSort);
      // print('object;${response['data']}');
      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorBusquedaPersona = false;
      notifyListeners();
      return null;
    }
  }

  //================================== ELIMINAR  PRIPIETARIO  ==============================//
  Future eliminaPropietario(BuildContext context, int? idPropietario) async {
    // final serviceSocket = SocketService();

    final serviceSocket = context.read<SocketService>();
    final infoUser = await Auth.instance.getSession();

    final _pyloadEliminaPropietario = {
      "tabla": 'proveedor',
      "rucempresa": infoUser!.rucempresa,
      "rol": infoUser.rol,
      "perId": idPropietario,
    };

serviceSocket.sendMessage('client:guardarData', _pyloadEliminaPropietario);

    // serviceSocket.socket!
        // .emit('client:eliminarData', _pyloadEliminaPropietario);
  }

  //     '======================================================================GET INFO PROPIETARIO ===================================================');

  dynamic _infoPropietario;
  dynamic get infoPropietario => _infoPropietario;
  int? _idPropietario;
String?  _userData;
  void getInfoPropietario(dynamic _data, bool? _origen) async {
    // print('DATA GET PROPIETARIO========> : $_data');
    _infoPropietario = _data;


    

    _userData=_data['perUser'];
    _idPropietario = _origen == true ? _data['perId'] : null;
    _labelTipoDocumento = _data['perDocTipo'];
    _documentos = _data['perDocNumero'];
    final _valCedula = await validaCedula('$_documentos');
    setIsCedula(_valCedula);

    _generos = _data['perGenero'];
    setNombres(_data['perNombre']);
    // _nombres=_data['perNombre'];
    // _listaRecomendaciones.clear();

    // _listaRecomendaciones=[];

// print('RECOMENDACION DATA GET:${_data['perRecomendacion']}');
    // _listaRecomendaciones.addAll(_data['perRecomendacion']);
    //  setListaRecomendaciones(['ASD','ASD','ASD']);
// print('RECOMENDACION DATA GET TIPO :$_listaRecomendaciones');
    // _listaRecomendaciones.add(['ASD','ASD','ASD']);
    // _ocupacion=_data['perNombre'];
    // setRecomendacion(_data['perRecomendacion']);
    // _listaRecomendaciones.add(_data['perRecomendacion']);
    // setListaRecomendaciones([_recomendacion]);

    _direccion = _data['perDireccion'];
    _labelTelefono = _data['perTelefono'];
    _listaAddCelulares = _data['perCelular'];
    _listaAddCorreos = _data['perEmail'];
    _pais = _data['perPais'];
    _provincia = _data['perProvincia'];
    _canton = _data['perCanton'];
    _observacion = _data['perObsevacion'];

    notifyListeners();
  }

//================================ESTADO EL DOCUMENTO=============================================//
  bool _isCedulaOk = false;
  bool get getIsCedulaOk => _isCedulaOk;

  void setIsCedulaOk(bool value) {
    _isCedulaOk = value;
    // print('==_isCedulaOKkkkkk===> $_isCedulaOk');
    notifyListeners();
  }

//================================== CREA NUEVA CONSIGNA  ==============================//
  Future editaPropietario(
    BuildContext context,
  ) async {
    final serviceSocket = context.read<SocketService>();

    // print(
    //     '========================= GUARDA NUEVO INFORME ================================');
    // print('--_labelTipoDocumento -->:$_labelTipoDocumento');
    // print('--_documentos -->:$_documentos');
    // print('--_generos-->:$_generos');
    // print('--_nombres-->:$_nombres');
    // print('--_recomendacion-->:$_recomendacion');
    // print('--_ocupacion-->:$_ocupacion');
    // print('--_direccion-->:$_direccion');
    // print('--_labelTelefono-->:$_labelTelefono');
    // print('--_listaAddCelulares-->:$_listaAddCelulares');
    // print('--_listaAddCorreos-->:$_listaAddCorreos');
    // print('--_pais-->:$_pais');
    // print('--_provincia-->:$_provincia');
    // print('--_canton-->:$_canton');
    // print('--_observacion-->:$_observacion');
    final infoUser = await Auth.instance.getSession();
    // print(
    //     '==========================DATOS DEL TELEFONO ===============================');
    // print('rucEmpresa ${infoUser!.rucempresa}');
    // print('rucempresa ${infoUser.rucempresa}');
    // print('user ${infoUser.usuario}');
    // print(
    //     '==========================JSON PARA CREAR NUEVA COMPRA ===============================');
    final _pyloadEditaPropietario = {
      "tabla": "proveedor", //DEFECTO
      "rucempresa": infoUser!.rucempresa, // LOGIN
      "rol": infoUser.rol, //LOGIN
      "infRol": infoUser.rol, // del login
      "perId": _idPropietario,
      "perDocTipo": _labelTipoDocumento,
      "perDocNumero": _documentos,
      "perPerfil": ["CLIENTE"],
      "perNombre": _nombres,
      "perNombreComercial": "",
      "perDireccion": _direccion,
      "perObligado": "NO",
      "perTipoProveedor": "BIENES",
      "perTiempoCredito": "0",
      "perCredito": "NO",
      "perTelefono": _labelTelefono,
      "perCelular": _listaAddCelulares,
      "perGenero": _generos,
      "perRecomendacion": _recomendacion,
      "perFecNacimiento": "",
      "perEspecialidad": "",
      "perTitulo": "",
      "perSenescyt": "",
      "perPersonal": "INTERNO",
      "perEstado": "ACTIVO",
      "perObsevacion": _observacion,
      "perEmail": _listaAddCorreos,
      "perNickname": "",
      "perEmpresa": [infoUser.rucempresa],
      "perPais": _pais,
      "perProvincia": _provincia,
      "perCanton": _canton,
      "perUser":  "$_userData ** ${infoUser.usuario}",
      "perOtros": ["ZZZ9999"],
      "perFoto": "",
      "perDocumento": "",
      "perUbicacion": {"longitud": "", "latitud": ""},
      "perISPContratos": {}
    };
    // };
    // print(
    //     '==========================JSON PARA CREAR NUEVO GUARDIA ===============================');
    // print(_pyloadNuevoPropietario);
    // // // print(
    // //     '==========================JSON DE PERSONAL DEIGNADO ===============================');
    
    serviceSocket.sendMessage('client:actualizarData', _pyloadEditaPropietario);
    // serviceSocket.socket!.emit('client:actualizarData', _pyloadEditaPropietario);



    // serviceSocket.sendMessage('client:actualizarData', _pyloadEditaPropietario);
  }

//=================================================================================================================//
  // ================= VARIABLES DE PAGINACION ====================//
//=================================================================================================================//
//===================BOTON SEARCH PAGINACION ==========================//

  bool _btnSearchPropietariosPaginacion = false;
  bool get btnSearchPropietarioPaginacion => _btnSearchPropietariosPaginacion;

  void setBtnSearchPropietarioPaginacion(bool action) {
    _btnSearchPropietariosPaginacion = action;
    //  print('==_btnSearchCoros===> $_btnSearchPropietarios');
    notifyListeners();
  }

  //===================INPUT SEARCH PROPIETARIO==========================//
  String _nameSearchPropietarioPaginacion = "";
  String get nameSearchPropietarioPaginacion =>
      _nameSearchPropietarioPaginacion;

  void onSearchTextPropietarioPaginacion(String data) {
    _nameSearchPropietarioPaginacion = data;
     }
//=============================================================================//

 //================= LISTA PROPIETARIOS SIN PAGINACION ===================/

  List _listaPropietariosPaginacion = [];
  // List<TipoMulta> get getListaTodosLosTiposDeMultas => _listaTodosLosTiposDeMultas;
  List get getListaPropietariosPaginacion => _listaPropietariosPaginacion;

  void setInfoBusquedaPropietariosPaginacion(List data) {
    _listaPropietariosPaginacion.addAll(data);
    // print('PROPIETARIOS:${_listaPropietariosPaginacion.length}');

    for (var item in _listaPropietariosPaginacion) {
      //  print('-->:${item['perId']}');
    }

    notifyListeners();
  }

  bool? _errorPropietariosPaginacion; // sera nulo la primera vez
  bool? get getErrorPropietariosPaginacion => _errorPropietariosPaginacion;
  void setErrorPropietariosPaginacion(bool? value) {
    _errorPropietariosPaginacion = value;
    notifyListeners();
  }

  bool? _error401PropietariosPaginacion = false; // sera nulo la primera vez
  bool? get getError401PropietariosPaginacion => _error401PropietariosPaginacion;
  void setError401PropietariosPaginacion(bool? value) {
    _error401PropietariosPaginacion = value;
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

  Future buscaAllPropietariosPaginacion(String? _search, bool _isSearch) async {
    final dataUser = await Auth.instance.getSession();
// print('usuario : ${dataUser!.rucempresa}');
    final response = await _api.getAllPropietariosPaginacion(
      search: _search,
      page: _page,
      cantidad: _cantidad,
      perfil: 'perFecUpd',//"CLIENTES",
      input: 'perId',
      orden: false,
      token: '${dataUser!.token}',
    );

    if (response != null) {
      if (response == 401) {
        setInfoBusquedaPropietariosPaginacion([]);
        _error401PropietariosPaginacion = true;
        notifyListeners();
        return response;
      } else {
        _errorPropietariosPaginacion = true;
        if (_isSearch == true) {
          _listaPropietariosPaginacion = [];
        }
        List<dynamic> dataSort = response['data']['results'];
        dataSort.sort((a, b) => b['perFecReg']!.compareTo(a['perFecReg']!));

        setPage(response['data']['pagination']['next']);

        setInfoBusquedaPropietariosPaginacion(dataSort);
        notifyListeners();
        return response;
      }

      //===========================================//

    }
    if (response == null) {
      _errorPropietariosPaginacion = false;
      notifyListeners();
      return null;
    }
  }


//==================== BUSCA CLIENTE PROPIETARIOS====================//
  Map<String,dynamic> _listaBusquedaCliente = {};
  // List<TipoMulta> get getListaTodosLosTiposDeMultas => _listaTodosLosTiposDeMultas;
  Map<String,dynamic> get getListaBusquedaCliente => _listaBusquedaCliente;

  void setBusquedaCliente(Map<String,dynamic> data) {
    _listaBusquedaCliente = data;

    setNombres(_listaBusquedaCliente['perNombre']);
    setDireccion(_listaBusquedaCliente['perDireccion']);
    setLabelTelefono(_listaBusquedaCliente['perTelefono']);
    setGeneros(_listaBusquedaCliente['perGenero']);

       for (var item in _listaBusquedaCliente['perOtros']) {
           _listaAddPlacas!.add(item);
        }

    //  _listaAddCelulares!.add(_listaBusquedaCliente['perCelular']);
        for (var item in _listaBusquedaCliente['perCelular']) {
           _listaAddCelulares!.add(item);
        }

    // _listaAddCorreos!.add(_listaBusquedaCliente['perEmail']);
     for (var item in _listaBusquedaCliente['perEmail']) {
           _listaAddCorreos!.add(item);
        }

        

    setPais(_listaBusquedaCliente['perPais']);
     setProvincia(_listaBusquedaCliente['perProvincia']);
      setCanton(_listaBusquedaCliente['perCanton']);
        setObservacion(_listaBusquedaCliente['perObsevacion']);

    print('Cliente BUSCADA:$_listaBusquedaCliente;');
    notifyListeners();
  }

  bool? _errorBusquedaCliente; // sera nulo la primera vez
  bool? get getErrorBusquedaCliente=> _errorBusquedaCliente;
  set setErrorBusquedaCliente (bool? value) {
    _errorBusquedaCliente= value;
    notifyListeners();
  }

  Future searchCliente() async {
    final dataUser = await Auth.instance.getSession();
// print('usuario : ${dataUser!.rucempresa}');
    final response = await _api.searchCliente(
      search: _documentos,
      // estado: 'CLIENTES',
      rol: '${dataUser!.rol}',
      token: '${dataUser.token}',
    );
    if (response != null) {
      _errorBusquedaCliente= true;

     
      // setInfoBusquedaPropietarios(response['data']);
      setBusquedaCliente(response);
      // print('object;${response['data']}');
      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorBusquedaPersona = false;
      notifyListeners();
      return null;
    }
  }



//================================ BUSQUEDA DE PRODUCTO=============================================//

//   bool _btnSearch = false;
//   bool get btnSearch => _btnSearch;

//   void setBtnSearch(bool action) {
//     _btnSearch = action;
//     notifyListeners();
//   }
  

//  List<dynamic> _allItemsFilters=[];
//    List<dynamic> get allItemsFilters => _allItemsFilters;
//    void setListFilter( List<dynamic> _list){
//   _allItemsFilters = [];

// // _sortList();



// _allItemsFilters.addAll(_list);
// // print('LA LISTA DE LOS ESTUDIANTES _allItemsFilters: $_allItemsFilters ');

//   notifyListeners();
//  }

//   void search(String query) {
//       List<Map<String, dynamic>> originalList = List.from(getListaDeProductos); // Copia de la lista original
//     if (query.isEmpty) {
//       _allItemsFilters = originalList;
//     } else {
//       _allItemsFilters = originalList.where((estudiante) {
//         return 
//         // resident['resCedula'].toLowerCase().contains(query.toLowerCase()) ||
//                estudiante['invNombre'].toLowerCase().contains(query.toLowerCase()) ;
//       }).toList();
//     }
//     notifyListeners();
//   }






}

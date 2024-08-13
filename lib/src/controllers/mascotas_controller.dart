import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:neitorcont/src/api/api_provider.dart';
import 'package:neitorcont/src/api/authentication_client.dart';

import 'package:neitorcont/src/services/socket_service.dart';
import 'package:neitorcont/src/utils/calcula_fecha_nacimiento.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as _http;

class MascotasController extends ChangeNotifier {
  GlobalKey<FormState> mascotasFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> contactoExtraFormKey = GlobalKey<FormState>();

  final _api = ApiProvider();

  bool validateFormMascota() {
    if (mascotasFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  bool validateFormContactoExtra() {
    if (contactoExtraFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  // =================  RESET FORM PROPIETARIO ==================//

  void resetFormModalContactoExtra() {
    _countryCode;
    _correoContactExtra = '';
    _itemAddCelulares = '';
  }

  void resetFormMascota() {
    _listaTodosLosAlimentos = [];
    _listaTiposDeAlimentos = [];
    _listaTodasLasEspecies = [];
    _listaTodasLasRazas = [];
    _nuevoContacto = [];
    _listaEdad = [];
    setEspecie(null);
    setRaza(null);
    setAlimento(null);
    setTipoAlimento(null);
    // _tipoAlimento;
    // _aliento;
    // _especie;
    // _raza;
    _nombreMascota;
    _foto = '';
    // setFotoTemp('');
    onInputFechaNacimientoChange(null);
    // _fotUrlTemp;
    // _inputFechaNacicmiento;
    _edadAnio;
    _edadMeses;
    _newPictureFile;
    _nombrePropietario = '';
    _errorDeleteFoto;
    //  print('SE RESET LOS CAMPOS');
     _page = 0;
    _cantidad = 25;
    //  _listaMascotasPaginacion=[];
    _next = '';
    _isNext = false;
    notifyListeners();
  }

//================================INPUT  NOMBRE MASCOTA=============================================//
  String? _nombreMascota = '';
  String? get getNombreMascota => _nombreMascota;

  void setNombreMascota(String? value) {
    _nombreMascota = value;
    // print('==_nombreMascota ===> $_nombreMascota');
    notifyListeners();
  }

//================================SELECCIONAMOS EL NOMBRE DEL PROPIETARIO=============================================//
  String? _nombrePropietario = '';
  String? get getNombrePropietario => _nombrePropietario;
  // "mascPerDocNumero": "null",
  // 	"mascPerTelefono": "null",
  // 	"mascPerCelular": null,
  // 	"mascPerDireccion": "null",
  // 	"mascPerEmail": null,
  String? _propietrioDocumento = '';
  String? get getPropietrioDocumento => _propietrioDocumento;

  void setDocumentoPropietario(String? value) {
    _propietrioDocumento = value;
    // print('==_propietrioDocumento ===> $_propietrioDocumento');
    notifyListeners();
  }

  String? _propietarioTelefono = '';
  String? get getPropietarioTelefono => _propietarioTelefono;
  void setTelefonoPropietario(String? value) {
    _propietarioTelefono = value;
    // print('==_propietarioTelefono ===> $_propietarioTelefono');
    notifyListeners();
  }

  String? _propietarioDirecion = '';
  String? get getPropietarioDirecion => _propietarioDirecion;
  void setDireccionPropietario(String? value) {
    _propietarioDirecion = value;
    // print('==_propietarioDirecion ===> $_propietarioDirecion');
    notifyListeners();
  }

  List? _propietarioCelular = [];
  void getPropietarioCelular(List? _movil) {
    _propietarioCelular = _movil;
  }

  List? _propietarioCorreo = [];
  void getPropietarioCorreo(List? _email) {
    _propietarioCorreo = _email;
  }

  void setNombrePropietario(String? value) {
    _nombrePropietario = value;
    // print('==_nombrePropietario ===> $_nombrePropietario');
    notifyListeners();
  }

  dynamic _infoPropietario;
  String? _idPropietarioMascota;
  void getInfoPropietarioMascota(dynamic _value) {
    _infoPropietario = _value;
    // print('==infoPropietario ===> $_infoPropietario');
    // print('==infoPropietario ===> $_value');
    _idPropietarioMascota = _value['perId'].toString();
    setNombrePropietario(_value['perNombre']);
    // print('==infoPropietarioid ===> $_idPropietarioMascota');

    setDocumentoPropietario(_value['perDocNumero']);
    // _propietrioDocumento=_infoPropietario['mascPerDocNumero'];
    setTelefonoPropietario(_value['perTelefono']);
    setDireccionPropietario(_value['perDireccion']);
    _propietarioCelular = _value['perCelular'];
    _propietarioCorreo = _value['perEmail'];

//  print('==$_propietrioDocumento  $_propietarioTelefono  $_propietarioDirecion $_propietarioCelular===> $_propietarioCorreo');
  }

//================================SELECCIONAMOS EL COLOR=============================================//
  String? _color = '';
  String? get getColor => _color;

  void setColor(String? value) {
    _color = value;
    print('==color ===> $_color');
    notifyListeners();
  }

//================================INPUT  OBSERVACION MASCOTA=============================================//
  String? _observacionMascota = '';
  String? get getObservacionMascota => _observacionMascota;

  void setObservacionMascota(String? value) {
    _observacionMascota = value;
    // print('==_observacionMascota ===> $_observacionMascota');
    notifyListeners();
  }

//==================== LISTO TODOS  MascotaS====================//
  List _listaMascotas = [];
  // List<TipoMulta> get getListaTodosLosTiposDeMultas => _listaTodosLosTiposDeMultas;
  List get getListaMascotas => _listaMascotas;

  void setInfoBusquedaMascotas(List data) {
    _listaMascotas = data;
    // print('Mascotas:$_listaMascotas');
    notifyListeners();
  }

  bool? _errorMascotas; // sera nulo la primera vez
  bool? get getErrorMascotas => _errorMascotas;
  set setErrorMascotas(bool? value) {
    _errorMascotas = value;
    notifyListeners();
  }

  bool? _error401Mascotas = false; // sera nulo la primera vez
  bool? get getError401Mascotas => _error401Mascotas;
  set setError401Mascotas(bool? value) {
    _error401Mascotas = value;
    notifyListeners();
  }

  Future buscaAllMascotas(String? _search) async {
    final dataUser = await Auth.instance.getSession();
// print('usuario : ${dataUser!.rucempresa}');
    final response = await _api.getAllMascotas(
      search: _search,
      // estado: 'CLIENTES',
      token: '${dataUser!.token}',
    );

    if (response != null) {
      if (response == 401) {
        setInfoBusquedaMascotas([]);
        _error401Mascotas = true;
        notifyListeners();
        return response;
      } else {
        _errorMascotas = true;

        List dataSort = [];
        dataSort = response['data'];
        dataSort.sort((a, b) => b['mascFecReg']!.compareTo(a['mascFecReg']!));

        // setInfoBusquedaMascotas(response['data']);
        setInfoBusquedaMascotas(dataSort);
        // print('object;${response['data']}');
        notifyListeners();
        return response;
      }
    }

    if (response == null) {
      _errorMascotas = false;
      notifyListeners();
      return null;
    }
  }

  //==================== LISTO TODOS  MascotaS====================//
  List _listaMascotasPropietario = [];
  // List<TipoMulta> get getListaTodosLosTiposDeMultas => _listaTodosLosTiposDeMultas;
  List get getListaMascotasPropietario => _listaMascotasPropietario;

  void setInfoBusquedaMascotasPropietario(List data) {
    _listaMascotasPropietario = data;
    // print('_listaMascotasPropietario:$_listaMascotasPropietario');
    notifyListeners();
  }

  bool? _errorMascotasPropietario; // sera nulo la primera vez
  bool? get getErrorMascotasPripietario => _errorMascotasPropietario;
  set setErrorMascotasPropietario(bool? value) {
    _errorMascotasPropietario = value;
    notifyListeners();
  }

  bool? _error401MascotasPropietario = false; // sera nulo la primera vez
  bool? get getError401MascotasPropietario => _error401MascotasPropietario;
  set setError401MascotasPropietario(bool? value) {
    _error401MascotasPropietario = value;
    notifyListeners();
  }

  Future buscaAllMascotasPropietario(
      String? _search, String _propietario) async {
    final dataUser = await Auth.instance.getSession();
// print('usuario : ${dataUser!.rucempresa}');
    final response = await _api.getAllMascotasPropietario(
      search: _search,
      propietario: _propietario,
      token: '${dataUser!.token}',
    );

    if (response != null) {
      if (response == 401) {
        setInfoBusquedaMascotasPropietario([]);
        _error401Mascotas = true;
        notifyListeners();
        return response;
      } else {
        _errorMascotasPropietario = true;

        List dataSort = [];
        dataSort = response['data'];
        dataSort.sort((a, b) => b['mascFecReg']!.compareTo(a['mascFecReg']!));

        // setInfoBusquedaMascotasPropietario(response['data']);
        setInfoBusquedaMascotasPropietario(dataSort);
        // print('object;${response['data']}');
        notifyListeners();
        return response;
      }
    }

    if (response == null) {
      _errorMascotasPropietario = false;
      notifyListeners();
      return null;
    }
  }

//  =================  CREO DEBOUNCE  PARA BUSQUEDAS ==================//

  Timer? _deboucerSearchBuscaMascota;
  Timer? _deboucerSearchBuscaMascotaPropietario;
  // Timer? _deboucerSearchBuscaPersona;

  @override
  void dispose() {
    _deboucerSearchBuscaMascota?.cancel();
    _deboucerSearchBuscaMascotaPropietario?.cancel();
    // _deboucerSearchBuscaPersona?.cancel();

    // _videoController.dispose();
    super.dispose();
  }

//===================BOTON SEARCH Mascota ==========================//

  bool _btnSearchMascotas = false;
  bool get btnSearchMascota => _btnSearchMascotas;

  void setBtnSearchMascota(bool action) {
    _btnSearchMascotas = action;
    //  print('==_btnSearchCoros===> $_btnSearchMascotas');
    notifyListeners();
  }

  //===================INPUT SEARCH COROSE==========================//
  String _nameSearchMascota = "";
  String get nameSearchMascota => _nameSearchMascota;

  void onSearchTextMascota(String data) {
    _nameSearchMascota = data;
    if (_nameSearchMascota.length >= 3) {
      _deboucerSearchBuscaMascota?.cancel();
      _deboucerSearchBuscaMascota =
          Timer(const Duration(milliseconds: 700), () {
        // print('=====> $data');
        buscaAllMascotas(data);
      });
    } else {
      // buscaAusencias('','false');
    }
    notifyListeners();
  }
//===================BOTON SEARCH Mascota ==========================//

  bool _btnSearchMascotasPropietario = false;
  bool get btnSearchMascotaPropietario => _btnSearchMascotasPropietario;

  void setBtnSearchMascotaPropietario(bool action) {
    _btnSearchMascotasPropietario = action;
    //  print('==_btnSearchCoros===> $_btnSearchMascotas');
    notifyListeners();
  }

  //===================INPUT SEARCH COROSE==========================//
  String _nameSearchMascotaPropietario = "";
  String get nameSearchMascotaPropietario => _nameSearchMascotaPropietario;

  void onSearchTextMascotaPropietario(String data) {
    _nameSearchMascotaPropietario = data;
    if (_nameSearchMascotaPropietario.length >= 3) {
      _deboucerSearchBuscaMascotaPropietario?.cancel();
      _deboucerSearchBuscaMascotaPropietario =
          Timer(const Duration(milliseconds: 700), () {
        // print('=====> $data');
        buscaAllMascotas(data);
      });
    } else {
      // buscaAusencias('','false');
    }
    notifyListeners();
  }

//====GET INFO DETALLE MASCOTA===//
  dynamic _infoMascota;
  dynamic get infoMascota => _infoMascota;
  int? _idMascota;
  String? _fotUrlTemp = '';
  String? get getFotUrlTemp => _fotUrlTemp;
  void setUrlFotoServer(String? _fotUlr) {
    _fotUrlTemp = _fotUlr;
    // print('LA FOTITO: $_fotUrlTemp');
    notifyListeners();
  }

  String? _edadMascota = '';
  String? get getEdadMascota => _edadMascota;

//===================================================// ELIMINA LA FOTO =================================================//
  // void setFotoTemp(String? _fto) {
  //   _fotUrlTemp = _fto;

  //   final _fotoDelete =
  //   {
  //     "nombre": "foto",
  //      "url": _fotUrlTemp
  //   };

  //   print('LA FOTITO: $_fotoDelete');

  //   notifyListeners();
  // }
  bool? _errorDeleteFoto; // sera nulo la primera vez
  bool? get getErrorDeleteFoto => _errorDeleteFoto;

  Future? deleteFoto(String? _fto) async {
    // print("object: $_fto");
    final _fotoDelete = [
      {"nombre": "fotoDelete", "url": "$_fto"}
    ];
    final dataUser = await Auth.instance.getSession();
    final response = await _api.deleteDocumento(
      info: _fotoDelete,
      token: '${dataUser!.token}',
    );
    if (response != null) {
      _errorDeleteFoto = false;
      setUrlFotoServer('');
      _foto = '';
     

      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorDeleteFoto = true;
      notifyListeners();
      return null;
    }
    return null;
  }
//==================================================================================================//
  String?  _userData='';
  void getInfoMascota(dynamic _data) async {
    _nuevoContacto = [];

    _infoMascota = _data;
    // print('LA MASCOTA: $_infoMascota');
      _userData=_data['mascUser'];
    _idMascota = _data['mascId'];
    _idPropietarioMascota = _data['mascPerId'];
    _nombrePropietario = _data['mascPerNombre'];
    _nombreMascota = _data['mascNombre'];

    _color = _data['mascColor'];

    _inputFechaNacicmiento = _data['mascFechaNacimiento'];
    _edadMascota = _data['mascEdad'];
//  _edadAnio=_data['mascColor'];
//  _edadMeses=_data['mascColor'];
    _microChip = _data['mascMicroChip'];
    _caracter = _data['mascCaracter'];
    _observacionMascota = _data['mascObservacion'];
    _especie = _data['mascEspecie'];
    _raza = _data['mascRaza'];
    _aliento = _data['mascAlimento'];
    _tipoAlimento = _data['mascTipoAlimento'];
    _sexoAnimal = _data['mascSexo'];
    _foto = _data['mascFoto'];
    _fotUrlTemp = _data['mascFoto'];

// _data['mascContactoExtra'];

    for (var item in _data['mascContactoExtra']) {
      _nuevoContacto.addAll([
        {
          "nombre": item['nombre'],
          "celular": item['celular'],
          "correo": item['correo']
        }
      ]);
      // print('items:${item['nombre']}');
      // print('lista:$_nuevoContacto');
    }

// _nuevoContacto=_data['mascContactoExtra'];

    notifyListeners();
  }

//==================================  MASCOTAS  ==============================//
//================================== LISTAR ESPECIE  ==============================//

  List _listaTodasLasEspecies = [];
  List get getListaTodasLasEspecies => _listaTodasLasEspecies;

  void setListaTodasLasEspecies(List data) {
    _listaTodasLasEspecies = data;
    // print('especie: $_listaTodasLasEspecies');
    // print('LA RAZA: ${_listaTodasLasEspecies[0]['espRazas']}');

    notifyListeners();
  }

  bool? _errorEspecies; // sera nulo la primera vez
  bool? get getErrorEspecies => _errorEspecies;

  Future? buscaEspecies() async {
    final dataUser = await Auth.instance.getSession();
    final response = await _api.getAllEspecies(
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
      _errorEspecies = true;
      setListaTodasLasEspecies(response['data']);

      // setListaTodasLasRazas(response['data'][0]['espRazas']);

      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorEspecies = false;
      notifyListeners();
      return null;
    }
    return null;
  }

//================================== LISTAR RAZAS  ==============================//

  List _listaTodasLasRazas = [];
  List get getListaTodasLasRazas => _listaTodasLasRazas;

  void setListaTodasLasRazas(List _razas) {
    _listaTodasLasRazas = _razas;
//  for (var e in  _listaTodasLasEspecies) {
//   // print('razzzzz ${e['espRazas']}');
// //  setListaTodasLasRazas();
//     _listaTodasLasRazas = e['espRazas'];

//       }

    // print('RAZAS: $_listaTodasLasRazas');

    notifyListeners();
  }

//================================== SELECCIONA ESPECIE ==============================//

  String? _especie;
  String? get getEspecie => _especie;

  void setEspecie(String? value) {
    _especie = value;
    // _listaTodasLasProvincias = [];
    // _listaTodosLosCantones = [];
    // _provincia = null;
    // _canton = null;

    notifyListeners();
  }
//================================== SELECCIONA RAZA ==============================//

  String? _raza;
  String? get getRaza => _raza;

  void setRaza(String? value) {
    _raza = value;
    // _listaTodasLasProvincias = [];
    // _listaTodosLosCantones = [];
    // _provincia = null;
    // _canton = null;

    notifyListeners();
  }
//================================== LISTAR ALIMENTOS  ==============================//

  List _listaTodosLosAlimentos = [];
  List get getListaTodosLosAlimentos => _listaTodosLosAlimentos;

  void setListaTodosLosAlimentos(List _data) {
    _listaTodosLosAlimentos = _data;
    // print('alimentos: $_listaTodosLosAlimentos');
    // print('LA RAZA: ${_listaTodosLosAlimentos[0]['espRazas']}');

    notifyListeners();
  }

  bool? _errorAlimentos; // sera nulo la primera vez
  bool? get getErrorAlimentos => _errorAlimentos;

  Future? buscaAlimentos() async {
    final dataUser = await Auth.instance.getSession();
    final response = await _api.getAllAlimentos(
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
      _errorAlimentos = true;
      setListaTodosLosAlimentos(response['data']);

      // setListaTodasLasRazas(response['data'][0]['espRazas']);

      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorAlimentos = false;
      notifyListeners();
      return null;
    }
    return null;
  }

//================================== LISTAR RAZAS  ==============================//

  List _listaTiposDeAlimentos = [];
  List get getListaTiposDeAlimentos => _listaTiposDeAlimentos;

  void setListaTiposDeAlimentos(List _alimento) {
    _listaTiposDeAlimentos = _alimento;
//  for (var e in  _listaTodasLasEspecies) {
//   // print('razzzzz ${e['espRazas']}');
// //  setListaTodasLasRazas();
//     _listaTodasLasRazas = e['espRazas'];

//       }

    // print('RAZAS: $_listaTiposDeAlimentos');

    notifyListeners();
  }

//================================== SELECCIONA ALIMENTO ==============================//

  String? _aliento;
  String? get getAlimento => _aliento;

  void setAlimento(String? value) {
    _aliento = value;
    // _listaTodasLasProvincias = [];
    // _listaTodosLosCantones = [];
    // _provincia = null;
    // _canton = null;

    notifyListeners();
  }
//================================== SELECCIONA TIPO ALIMENTO ==============================//

  String? _tipoAlimento;
  String? get getTipoAlimento => _tipoAlimento;

  void setTipoAlimento(String? value) {
    _tipoAlimento = value;
    // _listaTodasLasProvincias = [];
    // _listaTodosLosCantones = [];
    // _provincia = null;
    // _canton = null;

    notifyListeners();
  }

//================================== LISTAR SEXO MASCOTA  ==============================//

  List _listaSexoMascota = [];
  List get getListaSexoMascota => _listaSexoMascota;

  void setListaSexoMascota(List data) {
    _listaSexoMascota = data;
    // print('especie: $_listaSexoMascota');
    // print('LA RAZA: ${_listaSexoMascota[0]['espRazas']}');

    notifyListeners();
  }

  bool? _errorSexoMascota; // sera nulo la primera vez
  bool? get getErrorSexoMascota => _errorSexoMascota;

  Future? buscaSexoMascota() async {
    final dataUser = await Auth.instance.getSession();
    final response = await _api.getAllSexoMascota(
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
      _errorSexoMascota = true;
      setListaSexoMascota(response['data']);

      // setListaTodasLasRazas(response['data'][0]['espRazas']);

      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorSexoMascota = false;
      notifyListeners();
      return null;
    }
    return null;
  }

//================================== SELECCIONA SEXO ANIMAL ==============================//

  String? _sexoAnimal;
  String? get getSexoAnimal => _sexoAnimal;

  void setSexoAnimal(String? value) {
    _sexoAnimal = value;
    // _listaTodasLasProvincias = [];
    // _listaTodosLosCantones = [];
    // _provincia = null;
    // _canton = null;

    notifyListeners();
  }

//========================== DROPDOWN ESTADO ANIMAL =======================//
  String? _labelEstadoAnimal = 'Vivo';

  String? get labelEstadoAnimal => _labelEstadoAnimal;

  void setLabelEstadoAnimal(String value) {
    _labelEstadoAnimal = value;
    // if (value == 'CEDULA' || value == 'RUC') {
    //   _isCedula = true;
    // }

    // print('-----ss:$_labelEstadoAnimal');
    notifyListeners();
  }

//================================SELECCIONAMOS MICROCHIO=============================================//
  String? _microChip = '';
  String? get getMicroChip => _microChip;

  void setMicroChip(String? value) {
    _microChip = value;
    // print('==_microChip ===> $_microChip');
    notifyListeners();
  }

//================================SELECCIONAMOS CARACTER=============================================//
  String? _caracter = '';
  String? get getCaracter => _caracter;

  void setCaracter(String? value) {
    _caracter = value;
    // print('==_caracter ===> $_caracter');
    notifyListeners();
  }

  //========================== VALIDA CAMPO  FECHA    =======================//
  List _listaEdad = [];
  List get getListaEdad => _listaEdad;

  void setListaEdad(List _data) {
    _listaEdad = _data;
    // print('EDAD OBTENIDA: $_listaEdad');
    // print('LA RAZA: ${_listaSexoMascota[0]['espRazas']}');

    notifyListeners();
  }

  String? _inputFechaNacicmiento;
  get getInputfechaNacimiento => _inputFechaNacicmiento;
  void onInputFechaNacimientoChange(String? date) async {
    _inputFechaNacicmiento = date;

    notifyListeners();
  }

  //========================== ANIOS Y MESES    =======================//
  String? _edadAnio;
  get getEdadAnio => _edadAnio;
  String? _edadMeses;
  get getEdadMeses => _edadMeses;

//========================== VALIDA INPUT CORREO  =======================//
  bool? _isCorreo;

  bool? get getIsCorreo => _isCorreo;

  void setIsCorreo(bool? value) {
    _isCorreo = value;
    // notifyListeners();
  }

//================================INGRESA ANIOS Y MESES=============================================//
  String? _inputAnios = '';
  String? get getInputAnios => _inputAnios;

  void setInputAnios(String? value) {
    _inputAnios = value;
    // print('==_inputAnios ===> $_inputAnios');

    if (_inputAnios!.isNotEmpty) {
      if (_inputMeses!.isNotEmpty) {
        calculaFechaNacimiento(_inputAnios, _inputMeses);
      } else {
        calculaFechaNacimiento(_inputAnios, '0');
      }
    }

    notifyListeners();
  }

  String? _inputMeses = '';
  String? get getInputMeses => _inputMeses;

  void setInputMeses(String? value) {
    _inputMeses = value;
    // print('==_inputMeses ===> $_inputMeses');

    if (_inputMeses!.isNotEmpty) {
      if (_inputAnios!.isNotEmpty) {
        calculaFechaNacimiento(_inputAnios, _inputMeses);
      } else {
        calculaFechaNacimiento('0', _inputMeses);
      }
    }

    notifyListeners();
  }

//========================== ITEM DE CelularS  =======================//
  bool? _isCelular;

  bool? get getIsCelular => _isCelular;

  void setIsCelular(bool? value) {
    _isCelular = value;

    // print('-----ss:$_isCelular');
    notifyListeners();
  }

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

  // }
  String? _itemAddCelulares = '';
  String? get getItemAddCelulars => _itemAddCelulares;

  void seItemAddCelulars(String? valor) {
    _itemAddCelulares = valor;
    // print('item Celulars: $_itemAddCelulares');
    notifyListeners();
  }

//================================SELECCIONAMOS EL NOMBRE DEL CONTACTO=============================================//
  String? _nombreContactoExtra = '';
  String? get getNombreContactoExtra => _nombreContactoExtra;

  void setNombreContactoExtra(String? value) {
    _nombreContactoExtra = value;
    // print('==_nombreContactoExtra ===> $_nombreContactoExtra');
    notifyListeners();
  }

//================================SELECCIONAMOS EL NOMBRE DEL PROPIETARIO=============================================//
  String? _correoContactExtra = '';
  String? get getCorreoContactoExtra => _correoContactExtra;

  void setCorreoContactoExtra(String? value) {
    _correoContactExtra = value;
    // print('==_correoContactExtra ===> $_correoContactExtra');
    notifyListeners();
  }

//================================ AGREGA CONTACO A LA LISTA=============================================//
  List<dynamic> _nuevoContacto = [];
  List<dynamic> get getListaContactos => _nuevoContacto;

  void agregarContacto() {
    _nuevoContacto.addAll([
      {
        "nombre": _nombreContactoExtra,
        "celular": "${_countryCode!.dialCode}$_itemAddCelulares",
        "correo": _correoContactExtra,
      }
    ]);
    notifyListeners();

    // print('==ESTA ES LA INFO QUE SE AGREGAR ===> $_nuevoContacto');
  }

  void eliminaContactoExtra(_registro) {
    // List<CreaNuevaFotoNovedad?> temp = images;

    // print(id);
    // _listaGuardiasInforme.removeWhere((element) => element.id == id);
    _nuevoContacto.removeWhere((e) => (e['nombre'] == _registro['nombre'] &&
        e['celular'] == _registro['celular'] &&
        e['correo'] == _registro['correo']));
    // _listaGuardiasInforme.removeWhere((e) => e['id'] == id);
    // _nuevoContacto.forEach(((element) {
    //   // print('${element['nombres']}');
    // }));

    notifyListeners();
    // print('------LISTA ---.${_listaGuardiasInforme.length}');
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

//================================== CREA NUEVA CONSIGNA  ==============================//
  Future crearMascota(
    BuildContext context,
  ) async {
    final serviceSocket = context.read<SocketService>();
    final infoUser = await Auth.instance.getSession();
    // print(
    //     '==========================DATOS DEL TELEFONO ===============================');
    // print('rucEmpresa ${infoUser!.rucempresa}');
    // print('rucempresa ${infoUser.rucempresa}');
    // print('user ${infoUser.usuario}');
    // print(
    //     '==========================JSON PARA CREAR NUEVA COMPRA ===============================');
    final _pyloadNuevaMascota = {
      "tabla": "mascota", //DEFECTO
      "rucempresa": infoUser!.rucempresa, // LOGIN
      "rol": infoUser.rol, //LOGIN

      "mascId": '',
      "mascNombre": _nombreMascota,
      "mascEspecie": _especie,
      "mascRaza": _raza,
      "mascAlimento": _aliento,
      "mascTipoAlimento": _tipoAlimento,
      "mascSexo": _sexoAnimal,
      "mascColor": _color,
      "mascFechaNacimiento": _inputFechaNacicmiento,
      "mascEdad": '', // calcula desde la base
      "mascFoto": _foto,
      "mascEstado": _labelEstadoAnimal, //por defecto si no ha elegido ninguno
      "mascEliminado": "NO", //por ddefecto
      "mascQuienElimina": "",
      "mascMicroChip": _microChip,
      "mascCaracter": _caracter,
      "mascObservacion": _observacionMascota,
      "mascPerId": _idPropietarioMascota,

      "mascPerDocNumero": _propietrioDocumento,
      "mascPerNombre": _nombrePropietario,
      "mascPerTelefono": _propietarioTelefono,
      "mascPerCelular": _propietarioCelular,
      "mascPerDireccion": _propietarioDirecion,
      "mascPerEmail": _propietarioCorreo,

      "mascContactoExtra": _nuevoContacto,
      "mascUser": infoUser.usuario,
      "mascEmpresa": infoUser.rucempresa,
      "mascFecReg": "",
      "mascFecModificacion": "",
      "Todos": ""
    };
    // print(
    //     '==========================JSON PARA CREAR NUEVO GUARDIA ===============================');
    // print(_pyloadNuevaMascota);
    // // // print(
    //     '==========================JSON DE PERSONAL DEIGNADO ===============================');
    serviceSocket.socket!.emit('client:guardarData', _pyloadNuevaMascota);
  }

  //     '==========================JSON DE PERSONAL DEIGNADO ===============================');

  Future? calculaFechaNacimiento(String? _year, String? _month) async {
    List<String> _data = [];
    var fActual = DateTime.now();

    var year = 0;
    var month = 0;
    var day = 0;

    year = int.parse(_year!);
    month = int.parse(_month!);
    month = month > 12 ? 0 : month;

    var yearAct = fActual.year;
    var mesAct = fActual.month <= 9 ? fActual.month + 1 : fActual.month;
    var dayAct = fActual.day <= 9 ? fActual.day + 1 : fActual.day;

    var _mes = mesAct <= month ? month : mesAct - month;

    if (month >= mesAct) {
      _mes = 12 - (month - mesAct);
      year += year + 1;
    } else {
      _mes = mesAct - month;
    }

    var _dia = (dayAct >= 28) && _mes == 2 ? 28 : dayAct;

    var mascFechaNacimiento = "${yearAct - year} -- ${_mes} -- ${_dia} ";

    _data = mascFechaNacimiento.split("--");

    if (int.parse(_data[1]) < 10) {
      _data[1] = '0${_data[1].trim()}';
    }

    onInputFechaNacimientoChange(
        "${_data[0].trim()}-${_data[1].trim()}-${_data[2].trim()}");

    // print("esta es $mascFechaNacimiento");
    // print("esta es Lista  $_data");
    // print("esta es Lista TYPE ${_data.runtimeType}");
    return _data;
  }

  //     '========================== POSTEA EN EL SERVIDOR LA FOTO TOMADA  ===============================');

  // Future<String?> upLoadImagen(File? _newPictureFile) async {
  //   final dataUser = await Auth.instance.getSession();

  //   //for multipartrequest
  //   var request = _http.MultipartRequest(
  //       'POST', Uri.parse('https://contabackend.neitor.com/api/upload_delete_multiple_files/uploads'));

  //   //for token
  //   request.headers.addAll(
  //     {
  //       "x-auth-token": '${dataUser!.token}',
  //       "tipo": "mascotas",
  //       "archivoAnterior": "",
  //   });

  //   request.files
  //       .add(await _http.MultipartFile.fromPath('archivo', _newPictureFile!.path));

  //   //for completeing the request
  //   var response = await request.send();

  //   //for getting and decoding the response into json format
  //   var responsed = await _http.Response.fromStream(response);
  //   // final responseData = json.decode(responsed.body);

  //   if (responsed.statusCode == 200) {
  //     // print("SUCCESS");
  //     final responseFoto = FotoUrl.fromJson(responsed.body);
  //     final fotoUrl = responseFoto.urls[0];
  //     notifyListeners();
  //    return _foto=fotoUrl.toString();

  //   }
  // }

  // List<dynamic>? _listaFotosUrl = [];

  // Future<String?> upLoadImagen() async {
  //   final dataUser = await Auth.instance.getSession();

  //   //for multipartrequest
  //   var request = _http.MultipartRequest(
  //       'POST',
  //       Uri.parse(
  //           'https://contabackend.neitor.com/api/upload_delete_multiple_files/uploads'));

  //   //for token
  //   request.headers.addAll({"x-auth-token": '${dataUser!.token}'});

  //   request.files
  //       .add(await _http.MultipartFile.fromPath('foto', _newPictureFile!.path));

  //   //for completeing the request
  //   var response = await request.send();

  //   //for getting and decoding the response into json format
  //   var responsed = await _http.Response.fromStream(response);
  //   // final responseData = json.decode(responsed.body);

  //   if (responsed.statusCode == 200) {
  //     // print("SUCCESS");
  //     final responseFoto = jsonDecode(responsed.body);
  //     // _foto=responseFoto['urls'][0]['url'];
  //     setFoto(responseFoto['urls'][0]['url']);
  //     // print("SUCCESS $_foto");
  //     notifyListeners();
  //   }
  //   if (responsed.statusCode == 404) {
  //     _foto = '';
  //     return null;
  //   }
  //   if (responsed.statusCode == 401) {
  //     _foto = '';
  //     //  Auth.instance.deleteSesion(context!);
  //     // Auth.instance.deleteIdRegistro();
  //     // Auth.instance.deleteTurnoSesion();
  //     return null;
  //   }
  // }
  Future<String?> upLoadImagen() async {
    final dataUser = await Auth.instance.getSession();

    // var request = _http.MultipartRequest(
    //     'POST',
    //     Uri.parse(
    //         'https://=======.com/api/imagen'));

    // //for token
    // request.headers.addAll({"x-auth-token": '${dataUser!.token}'});

    // request.files
    //     .add(await _http.MultipartFile.fromPath('foto', _newPictureFile!.path));

    // var response = await request.send();

    // var responsed = await _http.Response.fromStream(response);

    // if (responsed.statusCode == 200) {

    //   final responseFoto = jsonDecode(responsed.body);

    //   setFoto(responseFoto['urls'][0]['url']);
    //   // print("SUCCESS $_foto");
    //   notifyListeners();
    // }
    // if (responsed.statusCode == 404) {
    //   _foto = '';
    //   return null;
    // }
    // if (responsed.statusCode == 401) {
    //   _foto = '';

    //   return null;
    // }
  }

//================================== CREA NUEVA CONSIGNA  ==============================//
  Future editarMascota(
    BuildContext context,
  ) async {
    final serviceSocket = context.read<SocketService>();

    final infoUser = await Auth.instance.getSession();
    // print(
    //     '==========================DATOS DEL TELEFONO ===============================');
    // print('rucEmpresa ${infoUser!.rucempresa}');
    // print('rucempresa ${infoUser.rucempresa}');
    // print('user ${infoUser.usuario}');
    // print(
    //     '==========================JSON PARA CREAR NUEVA COMPRA ===============================');
    final _pyloadEditaMascota = {
      "tabla": "mascota", //DEFECTO
      "rucempresa": infoUser!.rucempresa, // LOGIN
      "rol": infoUser.rol, //LOGIN

      "mascId": _idMascota.toString(),
      "mascNombre": _nombreMascota,
      "mascEspecie": _especie,
      "mascRaza": _raza,
      "mascAlimento": _aliento,
      "mascTipoAlimento": _tipoAlimento,
      "mascSexo": _sexoAnimal,
      "mascColor": _color,
      "mascFechaNacimiento": _inputFechaNacicmiento,
      "mascEdad": '', // calcula desde la base
      "mascFoto": _foto,
      "mascEstado": _labelEstadoAnimal, //por defecto si no ha elegido ninguno
      "mascEliminado": "NO", //por ddefecto
      "mascQuienElimina": "",
      "mascMicroChip": _microChip,
      "mascCaracter": _caracter,
      "mascObservacion": _observacionMascota,
      "mascPerId": _idPropietarioMascota,

      "mascPerDocNumero": _infoMascota['mascPerDocNumero'],
      "mascPerNombre": _nombrePropietario,
      "mascPerTelefono": _infoMascota['mascPerTelefono'],
      "mascPerCelular": _infoMascota['mascPerCelular'],
      "mascPerDireccion": _infoMascota['mascPerDireccion'],
      "mascPerEmail": _infoMascota['mascPerEmail'],

      "mascContactoExtra": _nuevoContacto,
      "mascUser":  "$_userData ** ${infoUser.usuario}",
      "mascEmpresa": infoUser.rucempresa,
      "mascFecReg": "",
      "mascFecModificacion": "",
      "Todos": ""
    };
    // print(
    //     '==========================JSON PARA CREAR NUEVO GUARDIA ===============================');
    // print(_pyloadEditaMascota);
    // // // print(
    // //     '==========================JSON DE PERSONAL DEIGNADO ===============================');
    serviceSocket.socket!.emit('client:actualizarData', _pyloadEditaMascota);
  }

  //     '==========================SELECCIONA TELEFONO===============================');
  CountryCode? _code;

  CountryCode? get getDataCountry => _code;

  void setDataContry(CountryCode? _info) {
    _code = _info;

    // print('INFO COUNTRY:${_countryCode!.dialCode} ${getDataCountry}');
    notifyListeners();
  }

  //     '==========================SELECCIONA TELEFONO===============================');
  CountryCode? _countryCode;

  CountryCode? get getCountrys => _countryCode;

  void setContrys(CountryCode? _info) {
    _countryCode = _info;

    // print('INFO COUNTRY:${_countryCode!.dialCode}');
    notifyListeners();
  }

  //================================== ELIMINAR  MASCOTA  ==============================//
  Future eliminaMascota(BuildContext context, int? idMascota) async {
    // final serviceSocket = SocketService();

    final serviceSocket = context.read<SocketService>();
    final infoUser = await Auth.instance.getSession();

    final _pyloadEliminaMascota = {
      "tabla": 'mascota',
      "rucempresa": infoUser!.rucempresa,
      "rol": infoUser.rol,
      "mascId": idMascota,
      "nombre": infoUser.nombre,
    };

    serviceSocket.socket!.emit('client:eliminarData', _pyloadEliminaMascota);
    // buscaAllMascotasPaginacion('',false);
    


  }
 

  //================================== GUARDA FOTO  MASCOTA  ==============================//

 bool? _errorSaveImage; // sera nulo la primera vez
  bool? get getErrorSaveImage => _errorSaveImage;
  Future guardaImagenMascota() async {
    final infoUser = await Auth.instance.getSession();

    String fileName = _newPictureFile!.path.split('/').last;
    FormData _formData = FormData.fromMap({
      "tipo": "mascotas",
      "archivoAnterior": "",
      "archivo": await MultipartFile.fromFile(_newPictureFile!.path,
          filename: fileName),
    });
    final response = await _api.saveDocumento(
      formData: _formData,
      token: '${infoUser!.token}',
    );
    if (response != null) {
      _errorSaveImage = true;
      _foto = response;

      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorSaveImage = false;
      _foto='';
      notifyListeners();
      return null;
    }
    return null;
  }



//=================================================================================================================//
  // ================= VARIABLES DE PAGINACION ====================//
//=================================================================================================================//
//===================BOTON SEARCH PAGINACION ==========================//

  bool _btnSearchMascotasPaginacion = false;
  bool get btnSearchMascotPaginacion => _btnSearchMascotasPaginacion;

  void setBtnSearchMascotaPaginacion(bool action) {
    _btnSearchMascotasPaginacion = action;
    //  print('==_btnSearchCoros===> $_btnSearchPropietarios');
    notifyListeners();
  }

  //===================INPUT SEARCH PROPIETARIO==========================//
  String _nameSearchMascotaPaginacion = "";
  String get nameSearchMascotaPaginacion =>
      _nameSearchMascotaPaginacion;

  void onSearchTextMascotaPaginacion(String data) {
    _nameSearchMascotaPaginacion = data;
     print('MASCOTNOMBRE:${_nameSearchMascotaPaginacion}');
     }
//=============================================================================//


  List _listaMascotasPaginacion = [];
  // List<TipoMulta> get getListaTodosLosTiposDeMultas => _listaTodosLosTiposDeMultas;
  List get getListaMascotasPaginacion => _listaMascotasPaginacion;

  void setInfoBusquedaMascotasPaginacion(List data) {
    _listaMascotasPaginacion.addAll(data);
    print('mascotas :${_listaMascotasPaginacion.length}');

    // for (var item in _listaMascotasPaginacion) {
    //    print('-->:${item['perId']}');
    // }

    notifyListeners();
  }

  bool? _errorMascotasPaginacion; // sera nulo la primera vez
  bool? get getErrorMascotasPaginacion => _errorMascotasPaginacion;
  void setErrorMascotasPaginacion(bool? value) {
    _errorMascotasPaginacion = value;
    notifyListeners();
  }

  bool? _error401MascotasPaginacion = false; // sera nulo la primera vez
  bool? get getError401MascotasPaginacion => _error401MascotasPaginacion;
  void setError401MascotasPaginacion(bool? value) {
    _error401MascotasPaginacion = value;
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

  Future buscaAllMascotasPaginacion(String? _search, bool _isSearch) async {
    final dataUser = await Auth.instance.getSession();
// print('usuario : ${dataUser!.rucempresa}');
    final response = await _api.getAllMascotasPaginacion(
      search: _search,
      page: _page,
      cantidad: _cantidad,
      documento: "",
      input: 'mascId',
      orden: false,
      allData:true,
      token: '${dataUser!.token}',
    );

    if (response != null) {
      if (response == 401) {
        setInfoBusquedaMascotasPaginacion([]);
        _error401MascotasPaginacion = true;
        notifyListeners();
        return response;
      } else {
        _errorMascotasPaginacion = true;
        if (_isSearch == true) {
          _listaMascotasPaginacion = [];
        }
        List<dynamic> dataSort = response['data']['results'];
        dataSort.sort((a, b) => b['mascFecReg']!.compareTo(a['mascFecReg']!));

        setPage(response['data']['pagination']['next']);

        setInfoBusquedaMascotasPaginacion(dataSort);
        notifyListeners();
        return response;
      }

      //===========================================//

    }
    if (response == null) {
      _errorMascotasPaginacion = false;
      notifyListeners();
      return null;
    }
  }


















}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:neitorcont/src/api/api_provider.dart';
import 'package:neitorcont/src/api/authentication_client.dart';
import 'package:neitorcont/src/models/auth_response.dart';
import 'package:neitorcont/src/services/socket_service.dart';
import 'package:provider/provider.dart';

class VideosController extends ChangeNotifier {
  final _api = ApiProvider();
  GlobalKey<FormState> videosFormKey = GlobalKey<FormState>();

  AuthResponse? usuarios;
  bool validateForm() {
    if (videosFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  void resetFormVideos() {
    _nombreCategoria = '';
    _tituloVideo = '';
    _urlVideo = '';
    _itemsTutorial = [];
  }

//  =================  CREO DEBOUNCE  PARA BUSQUEDAS ==================//

  Timer? _deboucerSearchVideos;
  // Timer? _deboucerSearchBuscaPersona;

  @override
  void dispose() {
    _deboucerSearchVideos?.cancel();
    // _deboucerSearchBuscaPersona?.cancel();

    // _videoController.dispose();
    super.dispose();
  }

//===================BOTON SEARCH Mascota ==========================//

  bool _btnSearchVideos = false;
  bool get btnSearchVideos => _btnSearchVideos;

  void setBtnSearchVideos(bool action) {
    _btnSearchVideos = action;
    //  print('==_btnSearchCoros===> $_btnSearchVideos');
    notifyListeners();
  }

  //===================INPUT SEARCH COROSE==========================//
  String _nameSearchVideos = "";
  String get nameSearchVideos => _nameSearchVideos;

  void onSearchTextVideos(String data) {
    _nameSearchVideos = data;
    if (_nameSearchVideos.length >= 3) {
      _deboucerSearchVideos?.cancel();
      _deboucerSearchVideos = Timer(const Duration(milliseconds: 700), () {
        // print('=====> $data');
        // buscaAllVideos(data);
      });
    } else {
      // buscaAllVideos('');
      // buscaAusencias('','false');
    }
    notifyListeners();
  }

//==================== LISTO TODAS LAS Videos CLINICAS====================//
  List _listaVideos = [];

  List get getListaVideos => _listaVideos;

  void setInfoBusquedaVideos(List data) {
    _listaVideos = data;
    // print('Videos:$_listaVideos');
    notifyListeners();
  }

  bool? _errorVideos; // sera nulo la primera vez
  bool? get getErrorVideos => _errorVideos;
  set setErrorVideos(bool? value) {
    _errorVideos = value;
    notifyListeners();
  }

  bool? _error401Videos = false; // sera nulo la primera vez
  bool? get getError401Videos => _error401Videos;
  set setError401Videos(bool? value) {
    _error401Videos = value;
    notifyListeners();
  }

  Future buscaAllVideos(String? _search) async {
    final dataUser = await Auth.instance.getSession();

    final response = await _api.getAllTutoriales(
      search: _search,
      // estado: 'CLIENTES',
      token: '${dataUser!.token}',
    );

    if (response != null) {
      if (response == 401) {
        setInfoBusquedaVideos([]);
        _error401Videos = true;
        notifyListeners();
        return response;
      } else {
        _errorVideos = true;

        List dataSort = [];
        dataSort = response['data'];
        dataSort.sort((a, b) => b['tutoFecReg']!.compareTo(a['tutoFecReg']!));

        // setInfoBusquedaVideos(response['data']);
        setInfoBusquedaVideos(dataSort);
        // print('object;${response['data']}');
        notifyListeners();
        return response;
      }
    }
    if (response == null) {
      _errorVideos = false;
      notifyListeners();
      return null;
    }
  }

  //================================== ELIMINAR  TUTORIAL  ==============================//
  Future eliminaVideo(BuildContext context, int? idVideo) async {
    // final serviceSocket = SocketService();

    final serviceSocket = context.read<SocketService>();
    final infoUser = await Auth.instance.getSession();

    final _pyloadEliminaVideo = {
      "tabla": 'tutorial',
      "rucempresa": infoUser!.rucempresa,
      "rol": infoUser.rol,
      "tutoId": idVideo,
    };

    serviceSocket.socket!.emit('client:eliminarData', _pyloadEliminaVideo);
  }

//====  LISTA CATEGORIAS =================//

  final List _listaCategorias = [
    "PROPIETARIOS",
    "MASCOTAS",
    "HISTORIAS CLINICAS",
    "RECETAS",
    "VACUNAS",
    "HOSPITALIZACION",
    "PELUQUERIA",
    "FACTURAS",
    "NOTAS CREDITO",
    "PROFORMAS",
    "PREFACTURAS",
  ];
  List get getListaCategorias => _listaCategorias;

  //================================INPUT   VIDEO=============================================//
  String? _nombreCategoria = '';
  String? get getNombreCategoria => _nombreCategoria;

  void setNombreCategoria(String? value) {
    _nombreCategoria = value;
    // print('_nombreCategoria: $_nombreCategoria');

    notifyListeners();
  }

  String? _tituloVideo = '';
  String? get getTituloVideo => _tituloVideo;

  void setTituloVideo(String? value) {
    _tituloVideo = value;
    // print('_TituloVideo: $_tituloVideo');

    notifyListeners();
  }

  String? _urlVideo = '';
  String? get getUrlVideo => _urlVideo;

  void setUrlVideo(String? value) {
    _urlVideo = value;
    // print('_urlVideo: $_urlVideo');

    notifyListeners();
  }

//================================== GET INFO TUTORIALS  ==============================//
  dynamic _infoTutoriales;
  dynamic get getInfoTutoriales => _infoTutoriales;
  int? _idTutoriales;

  List _itemsTutorial = [];

  void setInfoTutorial(dynamic _info) {
    _infoTutoriales = _info;
    _idTutoriales = _info['tutoId'];
    setNombreCategoria(_info['tutoNombre']);

    for (var item in _info['tutoInformacion']) {
      _itemsTutorial.addAll({item});
    }
    //  print('_itemsTutorial: $_itemsTutorial');
  }
  void setInfoItemTutorial(int _id,String _title,String _url) {
    
    _idTutoriales = _id;
    setTituloVideo(_title);
    setUrlVideo(_url);
    //  print('_itemsTutorial: $_itemsTutorial');
  }

//================================== CREA NUEVO TUTORIALS  ==============================//

  Future crearTurorial(
    BuildContext context,
  ) async {
    final serviceSocket = context.read<SocketService>();
    final infoUser = await Auth.instance.getSession();

    //     '==========================JSON PARA CREAR NUEVO TUTORIAL ===============================');
    final _pyloadNuevoTutorial = {
      "tabla": "tutorial", //DEFECTO
      "rucempresa": infoUser!.rucempresa, // LOGIN
      "rol": infoUser.rol, //LOGIN

      "tutoId": "",
      "tutoNombre": _nombreCategoria,
      "tutoInformacion": [
        {"tutoTitulo": _tituloVideo, "tutoUrl": _urlVideo}
      ],

      "tutoEmpresa": infoUser.rucempresa,
      "tutoUser": infoUser.usuario,
      "tutoFecReg": ""
    };
    // print(
    //     '==========================JSON PARA CREAR NUEVO GUARDIA ===============================');
    // print(_pyloadNuevaTutorial);
    // // print(
    //   //     '==========================JSON DE PERSONAL DEIGNADO ===============================');
    serviceSocket.socket!.emit('client:guardarData', _pyloadNuevoTutorial);
  }
//================================== EDITA TUTORIALS  ==============================//

  Future editarTutorial(
    BuildContext context,
  ) async {
    final serviceSocket = context.read<SocketService>();
    final infoUser = await Auth.instance.getSession();

    //     '==========================JSON PARA CREAR NUEVO TUTORIAL ===============================');
    final _pyloadEditarTutorial = {
      "tabla": "tutorial", //DEFECTO
      "rucempresa": infoUser!.rucempresa, // LOGIN
      "rol": infoUser.rol, //LOGIN

      "tutoId": _idTutoriales,
      "tutoNombre": _nombreCategoria,
      "tutoInformacion": _itemsTutorial,

      "tutoEmpresa": infoUser.rucempresa,
      "tutoUser": infoUser.usuario,
      "tutoFecReg": ""
    };
    // print(
    //     '==========================JSON PARA CREAR Editar TITORIAL ===============================');
    // print(_pyloadEditarTutorial);
    // // print(
    //   //     '==========================JSON DE PERSONAL DEIGNADO ===============================');
    serviceSocket.socket!.emit('client:actualizarData', _pyloadEditarTutorial);
  }

//================================== CREA ITEM TUTORIAL  ==============================//

  Future crearItemTurorial(
    BuildContext context,
  ) async {
    final serviceSocket = context.read<SocketService>();
    final infoUser = await Auth.instance.getSession();

    _itemsTutorial.add({"tutoTitulo": _tituloVideo, "tutoUrl": _urlVideo});

    //     '==========================JSON PARA CREAR NUEVO TUTORIAL ===============================');
    final _pyloadItemTutorial = {
      "tabla": "tutorial", //DEFECTO
      "rucempresa": infoUser!.rucempresa, // LOGIN
      "rol": infoUser.rol, //LOGIN

      "tutoId": _idTutoriales,
      "tutoNombre": _nombreCategoria,
      "tutoInformacion": _itemsTutorial,
      "tutoEmpresa": infoUser.rucempresa,
      "tutoUser": infoUser.usuario,
      "tutoFecReg": ""
    };
    // print(
    //     '==========================JSON PARA CREAR ITEM TUTORIAL ===============================');
    // print(_pyloadItemTutorial);
    // // print(
    //   //     '==========================JSON DE PERSONAL DEIGNADO ===============================');
    serviceSocket.socket!.emit('client:actualizarData', _pyloadItemTutorial);
  }

  //================================== ELIMINAR  TUTORIAL  ==============================//
  Future eliminaItemVideo(
      BuildContext context, String _title, String _url) async {
    final serviceSocket = context.read<SocketService>();
    final infoUser = await Auth.instance.getSession();

  

    _itemsTutorial
        .removeWhere((e) => e['tutoTitulo'] == _title && e['tutoUrl'] == _url);



    //     '==========================JSON PARA CREAR NUEVO TUTORIAL ===============================');
    final _pyloadEliminaItemTutorial = {
      "tabla": "tutorial", //DEFECTO
      "rucempresa": infoUser!.rucempresa, // LOGIN
      "rol": infoUser.rol, //LOGIN

      "tutoId": _idTutoriales,
      "tutoNombre": _nombreCategoria,
      "tutoInformacion": _itemsTutorial,
      "tutoEmpresa": infoUser.rucempresa,
      "tutoUser": infoUser.usuario,
      "tutoFecReg": ""
    };

    serviceSocket.socket!
        .emit('client:actualizarData', _pyloadEliminaItemTutorial);
  }

  // bool _exist = false;
  // bool get getExist => _exist;
  // void setExist(bool _estado) {
  //   _exist = _estado;
  //   notifyListeners();
  // }

  validaTutorial(String _tutorial) {
    for (int i = 0; i < _listaVideos.length; i++) {
      if (_listaVideos[i]['tutoNombre'] == _tutorial) {
        return true;
      }
    }

    return false;
  }
}

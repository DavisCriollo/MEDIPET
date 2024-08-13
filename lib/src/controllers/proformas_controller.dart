import 'dart:async';

import 'package:flutter/material.dart';
import 'package:neitorcont/src/api/api_provider.dart';
import 'package:neitorcont/src/api/authentication_client.dart';
import 'package:neitorcont/src/models/auth_response.dart';

class ProformasController extends ChangeNotifier {
  final _api = ApiProvider();
  GlobalKey<FormState> proformasFormKey = GlobalKey<FormState>();

  AuthResponse? usuarios;
  bool validateForm() {
    if (proformasFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  void resetFormProformas() {
    // _nombreMascota = '';
    // _idMascota;
    // _pesoMascota = '';
    // _fechaCaducidad = '';
    // _vetDoctorId = '';
    // _vetDoctorNombre = '';
    // _infoDoctor;
    // _infoMascota;
    // _labelTipoProducto = '';
    // _labelProducto = '';
  }

//  =================  CREO DEBOUNCE  PARA BUSQUEDAS ==================//

  Timer? _deboucerSearchProformas;
  // Timer? _deboucerSearchBuscaPersona;

  @override
  void dispose() {
    _deboucerSearchProformas?.cancel();
    // _deboucerSearchBuscaPersona?.cancel();

    // _videoController.dispose();
    super.dispose();
  }

//===================BOTON SEARCH Mascota ==========================//

  bool _btnSearchProformas = false;
  bool get btnSearchProformas => _btnSearchProformas;

  void setBtnSearchProformas(bool action) {
    _btnSearchProformas = action;
    //  print('==_btnSearchCoros===> $_btnSearchVacunas');
    notifyListeners();
  }

  //===================INPUT SEARCH COROSE==========================//
  String _nameSearchProformas = "";
  String get nameSearchProformas => _nameSearchProformas;

  void onSearchTextProformas(String data) {
    _nameSearchProformas = data;
    if (_nameSearchProformas.length >= 3) {
      _deboucerSearchProformas?.cancel();
      _deboucerSearchProformas = Timer(const Duration(milliseconds: 700), () {
        // print('=====> $data');
        buscaAllProformas(data);
      });
    } else {
      buscaAllProformas('');
      // buscaAusencias('','false');
    }
    notifyListeners();
  }

//==================== LISTO TODAS LAS Vacunas CLINICAS====================//
  List _listaProformas = [];

  List get getListaProformas => _listaProformas;

  void setInfoBusquedaProformas(List data) {
    _listaProformas = data;
    // print('Proformas:$_listaProformas');
    notifyListeners();
  }

  bool? _errorProformas; // sera nulo la primera vez
  bool? get getErrorProformas => _errorProformas;
  set setErrorProformas(bool? value) {
    _errorProformas = value;
    notifyListeners();
  }

  bool? _error401Proformas = false; // sera nulo la primera vez
  bool? get getError401Proformas => _error401Proformas;
  set setError401Proformas(bool? value) {
    _error401Proformas = value;
    notifyListeners();
  }

  Future buscaAllProformas(String? _search) async {
    final dataUser = await Auth.instance.getSession();
// print('usuario : ${dataUser!.rucempresa}');
    final response = await _api.getAllFacturas(
      search: _search,
      // estado: 'CLIENTES',
      token: '${dataUser!.token}',
    );
 
    if (response != null) {
  if (response['data'].isEmpty) {
        setInfoBusquedaProformas([]);
        _errorProformas = false;
      }

     else if (response == 401) {
        setInfoBusquedaProformas([]);
        _error401Proformas = true;
        notifyListeners();
        return response;
      } else  if (response['data'].isNotEmpty){
          for (var item in response['data']) {
             if(item['venTipoDocumento']=='P'){
          _errorProformas = true;

        List dataSort = [];
        dataSort = response['data'];
        dataSort.sort((a, b) => b['venFecReg']!.compareTo(a['venFecReg']!));

        // setInfoBusquedaProformas(response['data']);
        setInfoBusquedaProformas(dataSort);
        // print('object;${response['data']}');
        }
         else{
           setInfoBusquedaProformas([]);
             _errorProformas = false;
        }
          }

       
        
        notifyListeners();
        return response;
      }
    }
    if (response == null) {
      _errorProformas = false;
      notifyListeners();
      return null;
    }
  }




//=================================================================================================================//
  // ================= VARIABLES DE PAGINACION ====================//
//=================================================================================================================//
//===================BOTON SEARCH PAGINACION ==========================//

  bool _btnSearchProformasPaginacion = false;
  bool get btnSearchProformasPaginacion => _btnSearchProformasPaginacion;

  void setBtnSearchProformasPaginacion(bool action) {
    _btnSearchProformasPaginacion = action;
    //  print('==_btnSearchCoros===> $_btnSearchPropietarios');
    notifyListeners();
  }

  //===================INPUT SEARCH PROPIETARIO==========================//
  String _nameSearchProformasPaginacion = "";
  String get nameSearchProformasPaginacion =>
      _nameSearchProformasPaginacion;

  void onSearchTextProformasPaginacion(String data) {
    _nameSearchProformasPaginacion = data;
     print('ProformasOMBRE:${_nameSearchProformasPaginacion}');
     }
//=============================================================================//


  List _listaProformasPaginacion = [];
  // List<TipoMulta> get getListaTodosLosTiposDeMultas => _listaTodosLosTiposDeMultas;
  List get getListaProformasPaginacion => _listaProformasPaginacion;

  void setInfoBusquedaProformasPaginacion(List data) {
    _listaProformasPaginacion.addAll(data);
    print('Proformas :${_listaProformasPaginacion.length}');

    // for (var item in _listaProformasPaginacion) {
    //    print('-->:${item['perId']}');
    // }

    notifyListeners();
  }

  bool? _errorProformasPaginacion; // sera nulo la primera vez
  bool? get getErrorProformasPaginacion => _errorProformasPaginacion;
  void setErrorProformasPaginacion(bool? value) {
    _errorProformasPaginacion = value;
    notifyListeners();
  }

  bool? _error401ProformasPaginacion = false; // sera nulo la primera vez
  bool? get getError401ProformasPaginacion => _error401ProformasPaginacion;
  void setError401ProformasPaginacion(bool? value) {
    _error401ProformasPaginacion = value;
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

  Future buscaAllProformasPaginacion(String? _search, bool _isSearch) async {
    final dataUser = await Auth.instance.getSession();
// print('usuario : ${dataUser!.rucempresa}');
    final response = await _api.getAllProformasPaginacion(
      search: _search,
      page: _page,
      cantidad: _cantidad,
      input: 'venId',
      orden: false,
    estado:'PROFORMAS',
      token: '${dataUser!.token}',
    );

    if (response != null) {
      if (response == 401) {
        setInfoBusquedaProformasPaginacion([]);
        _error401ProformasPaginacion = true;
        notifyListeners();
        return response;
      } else {
        _errorProformasPaginacion = true;
        if (_isSearch == true) {
          _listaProformasPaginacion = [];
        }
        List<dynamic> dataSort = response['data']['results'];
        dataSort.sort((a, b) => b['venFecReg']!.compareTo(a['venFecReg']!));

        setPage(response['data']['pagination']['next']);

        setInfoBusquedaProformasPaginacion(dataSort);
        notifyListeners();
        return response;
      }

      //===========================================//

    }
    if (response == null) {
      _errorProformasPaginacion = false;
      notifyListeners();
      return null;
    }
  }









}
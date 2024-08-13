import 'dart:async';

import 'package:flutter/material.dart';
import 'package:neitorcont/src/api/api_provider.dart';
import 'package:neitorcont/src/api/authentication_client.dart';
import 'package:neitorcont/src/models/auth_response.dart';

class PreFacturasController extends ChangeNotifier {
  final _api = ApiProvider();
  GlobalKey<FormState> preFacturasFormKey = GlobalKey<FormState>();

  AuthResponse? usuarios;
  bool validateForm() {
    if (preFacturasFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  void resetFormPreFacturas() {
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

  Timer? _deboucerSearchPrefacturas;
  // Timer? _deboucerSearchBuscaPersona;

  @override
  void dispose() {
    _deboucerSearchPrefacturas?.cancel();
    // _deboucerSearchBuscaPersona?.cancel();

    // _videoController.dispose();
    super.dispose();
  }

//===================BOTON SEARCH Mascota ==========================//

  bool _btnSearchPreFacturas = false;
  bool get btnSearchPreFacturas => _btnSearchPreFacturas;

  void setBtnSearchPreFacturas(bool action) {
    _btnSearchPreFacturas = action;
    //  print('==_btnSearchCoros===> $_btnSearchVacunas');
    notifyListeners();
  }

  //===================INPUT SEARCH COROSE==========================//
  String _nameSearchPrefacturas = "";
  String get nameSearchPrefacturas => _nameSearchPrefacturas;

  void onSearchTextPrefacturas(String data) {
    _nameSearchPrefacturas = data;
    if (_nameSearchPrefacturas.length >= 3) {
      _deboucerSearchPrefacturas?.cancel();
      _deboucerSearchPrefacturas = Timer(const Duration(milliseconds: 700), () {
        // print('=====> $data');
        buscaAllPreFacturas(data);
      });
    } else {
      buscaAllPreFacturas('');
      // buscaAusencias('','false');
    }
    notifyListeners();
  }

//==================== LISTO TODAS LAS Vacunas CLINICAS====================//
  List _listaPreFacturas = [];

  List get getListaPreFacturas => _listaPreFacturas;

  void setInfoBusquedaPreFacturas(List data) {
    _listaPreFacturas = data;
    // print('PreFacturas:$_listaPreFacturas');
    notifyListeners();
  }

  bool? _errorPreFacturas; // sera nulo la primera vez
  bool? get getErrorPreFacturas => _errorPreFacturas;
  set setErrorPreFacturas(bool? value) {
    _errorPreFacturas = value;
    notifyListeners();
  }

  bool? _error401PreFacturas = false; // sera nulo la primera vez
  bool? get getError401PreFacturas => _error401PreFacturas;
  set setError401PreFacturas(bool? value) {
    _error401PreFacturas = value;
    notifyListeners();
  }

  Future buscaAllPreFacturas(String? _search) async {
    final dataUser = await Auth.instance.getSession();
// print('usuario : ${dataUser!.rucempresa}');
    final response = await _api.getAllFacturas(
      search: _search,
      // estado: 'CLIENTES',
      token: '${dataUser!.token}',
    );

    if (response != null) {
        if (response['data'].isEmpty) {
        setInfoBusquedaPreFacturas([]);
        _errorPreFacturas = false;
      }
      if (response == 401) {
        setInfoBusquedaPreFacturas([]);
        _error401PreFacturas = true;
        notifyListeners();
        return response;
      } else  if (response['data'].isNotEmpty){
          for (var item in response['data']) {
             if(item['venTipoDocumento']=='N'){
          _errorPreFacturas = true;

        List dataSort = [];
        dataSort = response['data'];
        dataSort.sort((a, b) => b['venFecReg']!.compareTo(a['venFecReg']!));

        // setInfoBusquedaPreFacturas(response['data']);
        setInfoBusquedaPreFacturas(dataSort);
        // print('object;${response['data']}');
        }
          else{
           setInfoBusquedaPreFacturas([]);
             _errorPreFacturas = false;
        }
          }

       
        
        notifyListeners();
        return response;
      }
    }
    if (response == null) {
      _errorPreFacturas = false;
      notifyListeners();
      return null;
    }
  }





//=================================================================================================================//
  // ================= VARIABLES DE PAGINACION ====================//
//=================================================================================================================//
//===================BOTON SEARCH PAGINACION ==========================//

  bool _btnSearchPreFacturasPaginacion = false;
  bool get btnSearchPreFacturaPaginacion => _btnSearchPreFacturasPaginacion;

  void setBtnSearchPreFacturaPaginacion(bool action) {
    _btnSearchPreFacturasPaginacion = action;
    //  print('==_btnSearchCoros===> $_btnSearchPropietarios');
    notifyListeners();
  }

  //===================INPUT SEARCH PROPIETARIO==========================//
  String _nameSearchPreFacturaPaginacion = "";
  String get nameSearchPreFacturaPaginacion =>
      _nameSearchPreFacturaPaginacion;

  void onSearchTextPreFacturaPaginacion(String data) {
    _nameSearchPreFacturaPaginacion = data;
     print('PreFacturaOMBRE:${_nameSearchPreFacturaPaginacion}');
     }
//=============================================================================//


  List _listaPreFacturasPaginacion = [];
  // List<TipoMulta> get getListaTodosLosTiposDeMultas => _listaTodosLosTiposDeMultas;
  List get getListaPreFacturasPaginacion => _listaPreFacturasPaginacion;

  void setInfoBusquedaPreFacturasPaginacion(List data) {
    _listaPreFacturasPaginacion.addAll(data);
    print('PreFacturas :${_listaPreFacturasPaginacion.length}');

    // for (var item in _listaPreFacturasPaginacion) {
    //    print('-->:${item['perId']}');
    // }

    notifyListeners();
  }

  bool? _errorPreFacturasPaginacion; // sera nulo la primera vez
  bool? get getErrorPreFacturasPaginacion => _errorPreFacturasPaginacion;
  void setErrorPreFacturasPaginacion(bool? value) {
    _errorPreFacturasPaginacion = value;
    notifyListeners();
  }

  bool? _error401PreFacturasPaginacion = false; // sera nulo la primera vez
  bool? get getError401PreFacturasPaginacion => _error401PreFacturasPaginacion;
  void setError401PreFacturasPaginacion(bool? value) {
    _error401PreFacturasPaginacion = value;
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

  Future buscaAllPreFacturasPaginacion(String? _search, bool _isSearch) async {
    final dataUser = await Auth.instance.getSession();
// print('usuario : ${dataUser!.rucempresa}');
    final response = await _api.getAllPreFacturasPaginacion(
      search: _search,
      page: _page,
      cantidad: _cantidad,
      input: 'venId',
      orden: false,
    estado:'NOTA CREDITOS',
      token: '${dataUser!.token}',
    );

    if (response != null) {
      if (response == 401) {
        setInfoBusquedaPreFacturasPaginacion([]);
        _error401PreFacturasPaginacion = true;
        notifyListeners();
        return response;
      } else {
        _errorPreFacturasPaginacion = true;
        if (_isSearch == true) {
          _listaPreFacturasPaginacion = [];
        }
        List<dynamic> dataSort = response['data']['results'];
        dataSort.sort((a, b) => b['venFecReg']!.compareTo(a['venFecReg']!));

        setPage(response['data']['pagination']['next']);

        setInfoBusquedaPreFacturasPaginacion(dataSort);
        notifyListeners();
        return response;
      }

      //===========================================//

    }
    if (response == null) {
      _errorPreFacturasPaginacion = false;
      notifyListeners();
      return null;
    }
  }



}
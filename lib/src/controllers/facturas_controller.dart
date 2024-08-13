import 'dart:async';

import 'package:flutter/material.dart';
import 'package:neitorcont/src/api/api_provider.dart';
import 'package:neitorcont/src/api/authentication_client.dart';
import 'package:neitorcont/src/models/auth_response.dart';

class FacturasController extends ChangeNotifier {
  final _api = ApiProvider();
  GlobalKey<FormState> facturasFormKey = GlobalKey<FormState>();

  AuthResponse? usuarios;
  bool validateForm() {
    if (facturasFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  void resetFormFacturas() {
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

     _page = 0;
    _cantidad = 25;
     _listaFacturasPaginacion=[];
    _next = '';
    _isNext = false;
  }

//  =================  CREO DEBOUNCE  PARA BUSQUEDAS ==================//

  Timer? _deboucerSearchfacturas;
  // Timer? _deboucerSearchBuscaPersona;

  @override
  void dispose() {
    _deboucerSearchfacturas?.cancel();
    // _deboucerSearchBuscaPersona?.cancel();

    // _videoController.dispose();
    super.dispose();
  }

//===================BOTON SEARCH Mascota ==========================//

  bool _btnSearchFacturas = false;
  bool get btnSearchFacturas => _btnSearchFacturas;

  void setBtnSearchFacturas(bool action) {
    _btnSearchFacturas = action;
    //  print('==_btnSearchCoros===> $_btnSearchVacunas');
    notifyListeners();
  }

  //===================INPUT SEARCH COROSE==========================//
  String _nameSearchfacturas = "";
  String get nameSearchfacturas => _nameSearchfacturas;

  void onSearchTextfacturas(String data) {
    _nameSearchfacturas = data;
    if (_nameSearchfacturas.length >= 3) {
      _deboucerSearchfacturas?.cancel();
      _deboucerSearchfacturas = Timer(const Duration(milliseconds: 700), () {
        // print('=====> $data');
        buscaAllFacturas(data);
      });
    } else {
      buscaAllFacturas('');
      // buscaAusencias('','false');
    }
    notifyListeners();
  }

//==================== LISTO TODAS LAS Vacunas CLINICAS====================//
  List _listaFacturas = [];

  List get getListaFacturas => _listaFacturas;

  void setInfoBusquedaFacturas(List data) {
    _listaFacturas = data;
    print('Facturas:$_listaFacturas');
    notifyListeners();
  }

  bool? _errorFacturas; // sera nulo la primera vez
  bool? get getErrorFacturas => _errorFacturas;
  set setErrorFacturas(bool? value) {
    _errorFacturas = value;
    notifyListeners();
  }

  bool? _error401Facturas = false; // sera nulo la primera vez
  bool? get getError401Facturas => _error401Facturas;
  set setError401Facturas(bool? value) {
    _error401Facturas = value;
    notifyListeners();
  }

  Future buscaAllFacturas(String? _search) async {
    final dataUser = await Auth.instance.getSession();
// print('usuario : ${dataUser!.rucempresa}');
    final response = await _api.getAllFacturas(
      search: _search,
      // estado: 'CLIENTES',
      token: '${dataUser!.token}',
    );
    if (response != null) {
      if (response['data'].isEmpty) {
        setInfoBusquedaFacturas([]);
        _errorFacturas = false;
      } else if (response == 401) {
        setInfoBusquedaFacturas([]);
        _error401Facturas = true;
        notifyListeners();
        return response;
      } else if (response['data'].isNotEmpty) {
        for (var item in response['data']) {
          if (item['venTipoDocumento'] == 'F') {
            _errorFacturas = true;

            List dataSort = [];
            dataSort = response['data'];
            dataSort.sort((a, b) => b['venFecReg']!.compareTo(a['venFecReg']!));

            // setInfoBusquedaFacturas(response['data']);
            setInfoBusquedaFacturas(dataSort);
            // print('object;${response['data']}');
          } else {
            setInfoBusquedaFacturas([]);
            _errorFacturas = false;
          }
        }

        notifyListeners();
        return response;
      }
    }
    if (response == null) {
      _errorFacturas = false;
      notifyListeners();
      return null;
    }
  }




//=================================================================================================================//
  // ================= VARIABLES DE PAGINACION ====================//
//=================================================================================================================//
//===================BOTON SEARCH PAGINACION ==========================//

  bool _btnSearchFacturasPaginacion = false;
  bool get btnSearchFacturaPaginacion => _btnSearchFacturasPaginacion;

  void setBtnSearchFacturaPaginacion(bool action) {
    _btnSearchFacturasPaginacion = action;
    //  print('==_btnSearchCoros===> $_btnSearchPropietarios');
    notifyListeners();
  }

  //===================INPUT SEARCH PROPIETARIO==========================//
  String _nameSearchFacturaPaginacion = "";
  String get nameSearchFacturaPaginacion =>
      _nameSearchFacturaPaginacion;

  void onSearchTextFacturaPaginacion(String data) {
    _nameSearchFacturaPaginacion = data;
     print('FacturaOMBRE:${_nameSearchFacturaPaginacion}');
     }
//=============================================================================//


  List _listaFacturasPaginacion = [];
  // List<TipoMulta> get getListaTodosLosTiposDeMultas => _listaTodosLosTiposDeMultas;
  List get getListaFacturasPaginacion => _listaFacturasPaginacion;

  void setInfoBusquedaFacturasPaginacion(List data) {
    _listaFacturasPaginacion.addAll(data);
    print('Facturas :${_listaFacturasPaginacion.length}');

    // for (var item in _listaFacturasPaginacion) {
    //    print('-->:${item['perId']}');
    // }

    notifyListeners();
  }

  bool? _errorFacturasPaginacion; // sera nulo la primera vez
  bool? get getErrorFacturasPaginacion => _errorFacturasPaginacion;
  void setErrorFacturasPaginacion(bool? value) {
    _errorFacturasPaginacion = value;
    notifyListeners();
  }

  bool? _error401FacturasPaginacion = false; // sera nulo la primera vez
  bool? get getError401FacturasPaginacion => _error401FacturasPaginacion;
  void setError401FacturasPaginacion(bool? value) {
    _error401FacturasPaginacion = value;
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

  Future buscaAllFacturasPaginacion(String? _search, bool _isSearch) async {
    final dataUser = await Auth.instance.getSession();
// print('usuario : ${dataUser!.rucempresa}');
    final response = await _api.getAllFacturasPaginacion(
      search: _search,
      page: _page,
      cantidad: _cantidad,
      input: 'venId',
      orden: false,
    estado:'FACTURAS',
      token: '${dataUser!.token}',
    );

    if (response != null) {
      if (response == 401) {
        setInfoBusquedaFacturasPaginacion([]);
        _error401FacturasPaginacion = true;
        notifyListeners();
        return response;
      } else {
        _errorFacturasPaginacion = true;
        if (_isSearch == true) {
          _listaFacturasPaginacion = [];
        }
        List<dynamic> dataSort = response['data']['results'];
        dataSort.sort((a, b) => b['venFecReg']!.compareTo(a['venFecReg']!));

        setPage(response['data']['pagination']['next']);

        setInfoBusquedaFacturasPaginacion(dataSort);
        notifyListeners();
        return response;
      }

      //===========================================//

    }
    if (response == null) {
      _errorFacturasPaginacion = false;
      notifyListeners();
      return null;
    }
  }












}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:neitorcont/src/api/api_provider.dart';
import 'package:neitorcont/src/api/authentication_client.dart';
import 'package:neitorcont/src/models/auth_response.dart';

class AnuladasController extends ChangeNotifier {
  final _api = ApiProvider();
  GlobalKey<FormState> anuladasFormKey = GlobalKey<FormState>();

  AuthResponse? usuarios;
  bool validateForm() {
    if (anuladasFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  void resetFormAnuladas() {
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
     _listaAnuladasPaginacion=[];
    _next = '';
    _isNext = false;
  }

//  =================  CREO DEBOUNCE  PARA BUSQUEDAS ==================//

  Timer? _deboucerSearchAnuladas;
  // Timer? _deboucerSearchBuscaPersona;

  @override
  void dispose() {
    _deboucerSearchAnuladas?.cancel();
    // _deboucerSearchBuscaPersona?.cancel();

    // _videoController.dispose();
    super.dispose();
  }


//=================================================================================================================//
  // ================= VARIABLES DE PAGINACION ====================//
//=================================================================================================================//
//===================BOTON SEARCH PAGINACION ==========================//

  bool _btnSearchAnuladasPaginacion = false;
  bool get btnSearchAnuladaPaginacion => _btnSearchAnuladasPaginacion;

  void setBtnSearchAnuladaPaginacion(bool action) {
    _btnSearchAnuladasPaginacion = action;
    //  print('==_btnSearchCoros===> $_btnSearchPropietarios');
    notifyListeners();
  }

  //===================INPUT SEARCH PROPIETARIO==========================//
  String _nameSearchAnuladaPaginacion = "";
  String get nameSearchAnuladaPaginacion =>
      _nameSearchAnuladaPaginacion;

  void onSearchTextAnuladaPaginacion(String data) {
    _nameSearchAnuladaPaginacion = data;
     print('AnuladaOMBRE:${_nameSearchAnuladaPaginacion}');
     }
//=============================================================================//


  List _listaAnuladasPaginacion = [];
  // List<TipoMulta> get getListaTodosLosTiposDeMultas => _listaTodosLosTiposDeMultas;
  List get getListaAnuladasPaginacion => _listaAnuladasPaginacion;

  void setInfoBusquedaAnuladasPaginacion(List data) {
    _listaAnuladasPaginacion.addAll(data);
    print('Anuladas :${_listaAnuladasPaginacion.length}');

    // for (var item in _listaAnuladasPaginacion) {
    //    print('-->:${item['perId']}');
    // }

    notifyListeners();
  }

  bool? _errorAnuladasPaginacion; // sera nulo la primera vez
  bool? get getErrorAnuladasPaginacion => _errorAnuladasPaginacion;
  void setErrorAnuladasPaginacion(bool? value) {
    _errorAnuladasPaginacion = value;
    notifyListeners();
  }

  bool? _error401AnuladasPaginacion = false; // sera nulo la primera vez
  bool? get getError401AnuladasPaginacion => _error401AnuladasPaginacion;
  void setError401AnuladasPaginacion(bool? value) {
    _error401AnuladasPaginacion = value;
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

  Future buscaAllAnuladasPaginacion(String? _search, bool _isSearch) async {
    final dataUser = await Auth.instance.getSession();
// print('usuario : ${dataUser!.rucempresa}');
    final response = await _api.getAllAnuladasPaginacion(
      search: _search,
      page: _page,
      cantidad: _cantidad,
      input: 'venId',
      orden: false,
    estado:'ANULADAS',
      token: '${dataUser!.token}',
    );

    if (response != null) {
      if (response == 401) {
        setInfoBusquedaAnuladasPaginacion([]);
        _error401AnuladasPaginacion = true;
        notifyListeners();
        return response;
      } else {
        _errorAnuladasPaginacion = true;
        if (_isSearch == true) {
          _listaAnuladasPaginacion = [];
        }
        List<dynamic> dataSort = response['data']['results'];
        dataSort.sort((a, b) => b['venFecReg']!.compareTo(a['venFecReg']!));

        setPage(response['data']['pagination']['next']);

        setInfoBusquedaAnuladasPaginacion(dataSort);
        notifyListeners();
        return response;
      }

      //===========================================//

    }
    if (response == null) {
      _errorAnuladasPaginacion = false;
      notifyListeners();
      return null;
    }
  }












}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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


  double _valorTotalFacturasHoy = 0.00;
  // List<TipoMulta> get getListaTodosLosTiposDeMultas => _listaTodosLosTiposDeMultas;
  double get getValorTotalFacturasHoy => _valorTotalFacturasHoy;
double _valorTotalFacturasAntes = 0.00;
  // List<TipoMulta> get getListaTodosLosTiposDeMultas => _listaTodosLosTiposDeMultas;
  double get getValorTotalFacturasAntes => _valorTotalFacturasAntes;

void resetValorTotal(){
_valorTotalFacturasHoy = 0.00;
_valorTotalFacturasAntes = 0.00;
notifyListeners();
}



  void setInfoBusquedaAnuladasPaginacion(List data) {
    _listaAnuladasPaginacion=[];
    _listaAnuladasPaginacion.addAll(data);
    print('Anuladas :${_listaAnuladasPaginacion.length}');

   
if (_tabIndex==0) {
  _valorTotalFacturasHoy = 0.0;

// Iterar sobre cada item en la lista
for (var item in _listaAnuladasPaginacion) {
  // Asegurarse de que 'venTotal' no sea nulo y sea un valor numérico
  final venTotal = item['venTotal'];
  if (venTotal != null) {
    // Convertir 'venTotal' a un número de tipo double y sumar
    _valorTotalFacturasHoy += double.tryParse(venTotal.toString()) ?? 0.0;
  }
}

// Redondear a 3 decimales
_valorTotalFacturasHoy = double.parse(_valorTotalFacturasHoy.toStringAsFixed(3));

// Imprimir el valor total
// print('-->: $_valorTotalFacturasHoy');
  
} else {
_valorTotalFacturasAntes = 0.0;

// Iterar sobre cada item en la lista
for (var item in _listaAnuladasPaginacion) {
  // Asegurarse de que 'venTotal' no sea nulo y sea un valor numérico
  final venTotal = item['venTotal'];
  if (venTotal != null) {
    // Convertir 'venTotal' a un número de tipo double y sumar
    _valorTotalFacturasAntes += double.tryParse(venTotal.toString()) ?? 0.0;
  }
}

// Redondear a 3 decimales
_valorTotalFacturasAntes = double.parse(_valorTotalFacturasAntes.toStringAsFixed(3));

// Imprimir el valor total
// print('-->: $_valorTotalFacturasAntes');



}


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

  Future buscaAllAnuladasPaginacion(String? _search, bool _isSearch,int tipo) async {
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

        // setInfoBusquedaAnuladasPaginacion(dataSort);

 if (tipo==0) {
          //  setInfoBusquedaFacturasPaginacion([]);
          setFacturas(dataSort);
          filtrarFacturasDeHoy();
        } else {
          //  setInfoBusquedaFacturasPaginacion([]);
             setFacturas(dataSort);
          filtrarFacturasAnteriores();
        }




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
List _facturas = [];
  List _facturasFiltradas = [];

  List get facturasFiltradas => _facturasFiltradas;

  void setFacturas(List facturas) {
    _facturas = facturas;
    notifyListeners();
  }

  void filtrarFacturasDeHoy() {
    DateTime hoy = DateTime.now();
    String fechaHoy = DateFormat('yyyy-MM-dd').format(hoy);

    _facturasFiltradas = _facturas.where((factura) {
      String? fechaFactura = factura['venFecReg'];
      if (fechaFactura != null) {
        String fechaFacturaSoloFecha = fechaFactura.split('T').first;
        return fechaFacturaSoloFecha == fechaHoy;
      }
      return false;
    }).toList();
    // setInfoBusquedaAnuladasPaginacion(_facturasFiltradas);
     setListFilter( _facturasFiltradas);
    notifyListeners();
  }

  void filtrarFacturasAnteriores() {
    DateTime hoy = DateTime.now();
    String fechaHoy = DateFormat('yyyy-MM-dd').format(hoy);

    _facturasFiltradas = _facturas.where((factura) {
      String? fechaFactura = factura['venFecReg'];
      if (fechaFactura != null) {
        String fechaFacturaSoloFecha = fechaFactura.split('T').first;
        return fechaFacturaSoloFecha != fechaHoy;
      }
      return false;
    }).toList();
      //  setInfoBusquedaAnuladasPaginacion(_facturasFiltradas);
       setListFilter( _facturasFiltradas);
    notifyListeners();
  }

//************INDEX TAB*****************//
int _tabIndex=0;

int get getTabIndex=>_tabIndex;

void setTabIndex( int _index)
{
_tabIndex=_index;

notifyListeners();

}




//=================BUSCADOR LOCAL==================//

 List<dynamic> _allItemsFilters=[];
   List<dynamic> get allItemsFilters => _allItemsFilters;
   void setListFilter( List<dynamic> _list){
  _allItemsFilters = [];

// _sortList();



_allItemsFilters.addAll(_list);
print('LA LISTA DE LOS ESTUDIANTES _allItemsFilters: ${_allItemsFilters.length} ');
print('LA LISTA DE LOS ESTUDIANTES _allItemsFilters: $_allItemsFilters ');


  notifyListeners();
 }

  void search(String query) {
      List<Map<String, dynamic>> originalList = List.from(_facturasFiltradas); // Copia de la lista original
    if (query.isEmpty) {
      _allItemsFilters = originalList;
    } else {
      _allItemsFilters = originalList.where((estudiante) {
        return 
        // resident['resCedula'].toLowerCase().contains(query.toLowerCase()) ||
               estudiante['venNomCliente'].toLowerCase().contains(query.toLowerCase()) ;
      }).toList();
    }
    notifyListeners();
  }




//====================================//











}

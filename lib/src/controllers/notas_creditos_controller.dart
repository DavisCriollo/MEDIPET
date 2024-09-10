import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:neitorcont/src/api/api_provider.dart';
import 'package:neitorcont/src/api/authentication_client.dart';
import 'package:neitorcont/src/models/auth_response.dart';

class NotasCreditosController extends ChangeNotifier {
  final _api = ApiProvider();
  GlobalKey<FormState> notasCreditosFormKey = GlobalKey<FormState>();

  AuthResponse? usuarios;
  bool validateForm() {
    if (notasCreditosFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  void resetFormNotasCreditos() {
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

  Timer? _deboucerSearchNotasCreditos;
  // Timer? _deboucerSearchBuscaPersona;

  @override
  void dispose() {
    _deboucerSearchNotasCreditos?.cancel();
    // _deboucerSearchBuscaPersona?.cancel();

    // _videoController.dispose();
    super.dispose();
  }

//===================BOTON SEARCH Mascota ==========================//

  bool _btnSearchNotasCreditos = false;
  bool get btnSearchNotasCreditos => _btnSearchNotasCreditos;

  void setBtnSearchNotasCreditos(bool action) {
    _btnSearchNotasCreditos = action;
    //  print('==_btnSearchCoros===> $_btnSearchVacunas');
    notifyListeners();
  }

  //===================INPUT SEARCH COROSE==========================//
  String _nameSearchNotasCreditos = "";
  String get nameSearchNotasCreditos => _nameSearchNotasCreditos;

  void onSearchTextNotasCreditos(String data) {
    _nameSearchNotasCreditos = data;
    if (_nameSearchNotasCreditos.length >= 3) {
      _deboucerSearchNotasCreditos?.cancel();
      _deboucerSearchNotasCreditos = Timer(const Duration(milliseconds: 700), () {
        // print('=====> $data');
        buscaAllNotasCreditos(data);
      });
    } else {
      buscaAllNotasCreditos('');
      // buscaAusencias('','false');
    }
    notifyListeners();
  }

//==================== LISTO TODAS LAS Vacunas CLINICAS====================//
  List _listaNotasCreditos = [];

  List get getListaNotasCreditos => _listaNotasCreditos;

  void setInfoBusquedaNotasCreditos(List data) {
    _listaNotasCreditos = data;
    print('NotasCreditos:$_listaNotasCreditos');
    notifyListeners();
  }

  bool? _errorNotasCreditos; // sera nulo la primera vez
  bool? get getErrorNotasCreditos => _errorNotasCreditos;
  set setErrorNotasCreditos(bool? value) {
    _errorNotasCreditos = value;
    notifyListeners();
  }

  bool? _error401NotasCreditos = false; // sera nulo la primera vez
  bool? get getError401NotasCreditos => _error401NotasCreditos;
  set setError401NotasCreditos(bool? value) {
    _error401NotasCreditos = value;
    notifyListeners();
  }

  Future buscaAllNotasCreditos(String? _search) async {
    final dataUser = await Auth.instance.getSession();
// print('usuario : ${dataUser!.rucempresa}');
    final response = await _api.getAllFacturas(
      search: _search,
      // estado: 'CLIENTES',
      token: '${dataUser!.token}',
    );
    // if (response != null) {
    //   _errorNotasCreditos = true;

    //   List dataSort = [];
    //   dataSort = response['data'];
    //   dataSort.sort((a, b) => b['carnFecReg']!.compareTo(a['carnFecReg']!));

    //   // setInfoBusquedaNotasCreditos(response['data']);
    //   setInfoBusquedaNotasCreditos(dataSort);
    //   // print('object;${response['data']}');
    //   notifyListeners();
    //   return response;
    // }
    if (response != null) {
       if (response['data'].isEmpty) {
        setInfoBusquedaNotasCreditos([]);
        _errorNotasCreditos = false;
      }
      else if (response == 401) {
        setInfoBusquedaNotasCreditos([]);
        _error401NotasCreditos = true;
        notifyListeners();
        return response;
      } else  if (response['data'].isNotEmpty){
          for (var item in response['data']) {
             if(item['venTipoDocumento']=='NC'){
          _errorNotasCreditos = true;

        List dataSort = [];
        dataSort = response['data'];
        dataSort.sort((a, b) => b['venFecReg']!.compareTo(a['venFecReg']!));

        // setInfoBusquedaNotasCreditos(response['data']);
        setInfoBusquedaNotasCreditos(dataSort);

        // print('object;${response['data']}');
        }
        else{
           setInfoBusquedaNotasCreditos([]);
             _errorNotasCreditos = false;
        }
          }

       
        
        notifyListeners();
        return response;
      }
    }
    if (response == null) {
      _errorNotasCreditos = false;
      notifyListeners();
      return null;
    }
  }




//=================================================================================================================//
  // ================= VARIABLES DE PAGINACION ====================//
//=================================================================================================================//
//===================BOTON SEARCH PAGINACION ==========================//

  bool _btnSearchNotasCreditosPaginacion = false;
  bool get btnSearchNotasCreditoPaginacion => _btnSearchNotasCreditosPaginacion;

  void setBtnSearchNotasCreditoPaginacion(bool action) {
    _btnSearchNotasCreditosPaginacion = action;
    //  print('==_btnSearchCoros===> $_btnSearchPropietarios');
    notifyListeners();
  }

  //===================INPUT SEARCH PROPIETARIO==========================//
  String _nameSearchNotasCreditoPaginacion = "";
  String get nameSearchNotasCreditoPaginacion =>
      _nameSearchNotasCreditoPaginacion;

  void onSearchTextNotasCreditoPaginacion(String data) {
    _nameSearchNotasCreditoPaginacion = data;
     print('NotasCreditoOMBRE:${_nameSearchNotasCreditoPaginacion}');
     }
//=============================================================================//


  List _listaNotasCreditosPaginacion = [];
  // List<TipoMulta> get getListaTodosLosTiposDeMultas => _listaTodosLosTiposDeMultas;
  List get getListaNotasCreditosPaginacion => _listaNotasCreditosPaginacion;



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



  void setInfoBusquedaNotasCreditosPaginacion(List data) {
      _listaNotasCreditosPaginacion=[];
    _listaNotasCreditosPaginacion.addAll(data);
    print('NotasCreditos :${_listaNotasCreditosPaginacion.length}');
if (_tabIndex==0) {
  _valorTotalFacturasHoy = 0.0;

// Iterar sobre cada item en la lista
for (var item in _listaNotasCreditosPaginacion) {
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
for (var item in _listaNotasCreditosPaginacion) {
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

  bool? _errorNotasCreditosPaginacion; // sera nulo la primera vez
  bool? get getErrorNotasCreditosPaginacion => _errorNotasCreditosPaginacion;
  void setErrorNotasCreditosPaginacion(bool? value) {
    _errorNotasCreditosPaginacion = value;
    notifyListeners();
  }

  bool? _error401NotasCreditosPaginacion = false; // sera nulo la primera vez
  bool? get getError401NotasCreditosPaginacion => _error401NotasCreditosPaginacion;
  void setError401NotasCreditosPaginacion(bool? value) {
    _error401NotasCreditosPaginacion = value;
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

  Future buscaAllNotasCreditosPaginacion(String? _search, bool _isSearch,int tipo) async {
    final dataUser = await Auth.instance.getSession();
// print('usuario : ${dataUser!.rucempresa}');
    final response = await _api.getAllNotasCreditoPaginacion(
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
        setInfoBusquedaNotasCreditosPaginacion([]);
        _error401NotasCreditosPaginacion = true;
        notifyListeners();
        return response;
      } else {
        _errorNotasCreditosPaginacion = true;
        if (_isSearch == true) {
          _listaNotasCreditosPaginacion = [];
        }
        List<dynamic> dataSort = response['data']['results'];
        dataSort.sort((a, b) => b['venFecReg']!.compareTo(a['venFecReg']!));

        setPage(response['data']['pagination']['next']);

        // setInfoBusquedaNotasCreditosPaginacion(dataSort);

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
      _errorNotasCreditosPaginacion = false;
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
    // setInfoBusquedaNotasCreditosPaginacion(_facturasFiltradas);
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
      //  setInfoBusquedaNotasCreditosPaginacion(_facturasFiltradas);
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

//====================== REALIZA LA SUMATORIA EN CADA CONSULTA  =============================//

if (_tabIndex==0) {
  _valorTotalFacturasHoy = 0.0;

// Iterar sobre cada item en la lista
for (var item in _allItemsFilters) {
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
for (var item in _allItemsFilters) {
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
//===================================================//


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
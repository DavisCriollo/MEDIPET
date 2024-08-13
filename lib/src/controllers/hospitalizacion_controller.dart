import 'dart:async';
// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:neitorcont/src/api/api_provider.dart';
import 'package:neitorcont/src/api/authentication_client.dart';
import 'package:neitorcont/src/models/auth_response.dart';
import 'package:neitorcont/src/services/socket_service.dart';
import 'package:provider/provider.dart';

class HospitalizacionController extends ChangeNotifier {
  final _api = ApiProvider();
  GlobalKey<FormState> hospitalizacionFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> hospitalizacionMedicinaFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> hospitalizacionHorariosMedicinaFormKey =
      GlobalKey<FormState>();
  GlobalKey<FormState> hospitalizacionAlimentoFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> hospitalizacionParametroFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> hospitalizacionFluidoFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> hospitalizacionInfusionFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> hospitalizacionHorariosFormKey = GlobalKey<FormState>();

  AuthResponse? usuarios;
  bool validateForm() {
    if (hospitalizacionFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  bool validateFormAgregaMedicina() {
    if (hospitalizacionMedicinaFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  bool validateFormAgregaHorariosMedicina() {
    if (hospitalizacionHorariosMedicinaFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  bool validateFormAgregaAlimento() {
    if (hospitalizacionAlimentoFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  bool validateFormAgregaParametro() {
    if (hospitalizacionParametroFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  bool validateFormAgregaFluido() {
    if (hospitalizacionFluidoFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  bool validateFormAgregaInfusion() {
    if (hospitalizacionInfusionFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  bool validateFormHorarios() {
    if (hospitalizacionHorariosFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

//  ================= RESET ==================//
  void resetFormospitalizacion() {
    _nombreMascota = '';
    _razaMascota = '';
    _sexoMascota = '';
    _edadMascota = '';
    _estadoMascota = '';
    _personaId = "";
    _personaDoc = "";
    _personaNombre = "";
    _personaTelefono = "";
    _personaListCelular = [];
    _personaDireccion = "";
    _personaListCorreo = [];
    _vetDoctorId = '';
    _vetDoctorNombre = '';
    _nuevoMedicamento = [];
    _nuevoHorarioMedicamento = [];
    _nuevoFluido = [];
    _nuevoInfusion = [];
    _nuevoAlimento = [];
    _nuevoHorarioAlimeno = [];
    _nuevoParametro = [];
    _nuevoHorarioParametro = [];
    _nuevoMedicamento = [];
    _nuevoHorarioMedicamento = [];
    idItem = 0;
    idItemHorario = 0;
    idItemAlimento = 0;
    idItemHorarioAliemto = 0;
    _idHosp;


_page = 0;
    _cantidad = 25;
     _listaHospitalizacioinesPaginacion=[];
    _next = '';
    _isNext = false;





  }

//  =================  CREO DEBOUNCE  PARA BUSQUEDAS ==================//

  Timer? _deboucerSearchHospitalizaciones;
  Timer? _deboucerSearchBuscaMedicina;
  Timer? _deboucerSearchBuscaParametro;

  @override
  void dispose() {
    _deboucerSearchHospitalizaciones?.cancel();
    _deboucerSearchBuscaMedicina?.cancel();
    _deboucerSearchBuscaParametro?.cancel();

    super.dispose();
  }

//===================BOTON SEARCH Mascota ==========================//

  bool _btnSearchHospitalizaciones = false;
  bool get btnSearchHospitalizaciones => _btnSearchHospitalizaciones;

  void setBtnSearchHospitalizaciones(bool action) {
    _btnSearchHospitalizaciones = action;
    //  print('==_btnSearchCoros===> $_btnSearchHospitalizaciones');
    notifyListeners();
  }

  //===================INPUT SEARCH COROSE==========================//
  String _nameSearchHospitalizaciones = "";
  String get nameSearchHospitalizaciones => _nameSearchHospitalizaciones;

  void onSearchTextHospitalizaciones(String data) {
    _nameSearchHospitalizaciones = data;
    if (_nameSearchHospitalizaciones.length >= 3) {
      _deboucerSearchHospitalizaciones?.cancel();
      _deboucerSearchHospitalizaciones =
          Timer(const Duration(milliseconds: 700), () {
        // print('=====> $data');
        buscaAllHospitalizaciones(data);
      });
    } else {
      buscaAllHospitalizaciones('');
      // buscaAusencias('','false');
    }
    notifyListeners();
  }

//==================== LISTO TODAS LAS Hospitalizaciones CLINICAS====================//
  List _listaHospitalizaciones = [];

  List get getListaHospitalizaciones => _listaHospitalizaciones;

  void setInfoBusquedaHospitalizaciones(List data) {
    _listaHospitalizaciones = data;
    // print('Hospitalizaciones:$_listaHospitalizaciones');
    notifyListeners();
  }

  bool? _errorHospitalizaciones; // sera nulo la primera vez
  bool? get getErrorHospitalizaciones => _errorHospitalizaciones;
  set setErrorHospitalizaciones(bool? value) {
    _errorHospitalizaciones = value;
    notifyListeners();
  }

  bool? _error401Hospitalizaciones = false; // sera nulo la primera vez
  bool? get getError401Hospitalizaciones => _error401Hospitalizaciones;
  set setError401Hospitalizaciones(bool? value) {
    _error401Hospitalizaciones = value;
    notifyListeners();
  }

  Future buscaAllHospitalizaciones(String? _search) async {
    final dataUser = await Auth.instance.getSession();
// print('usuario : ${dataUser!.rucempresa}');
    final response = await _api.getAllHospitalizaciones(
      search: _search,
      // estado: 'CLIENTES',
      token: '${dataUser!.token}',
    );

    if (response != null) {
      if (response == 401) {
        setInfoBusquedaHospitalizaciones([]);
        _error401Hospitalizaciones = true;
        notifyListeners();
        return response;
      } else {
        _errorHospitalizaciones = true;

        List dataSort = [];
        dataSort = response['data'];
        dataSort.sort((a, b) => b['hospFecReg']!.compareTo(a['hospFecReg']!));

        // setInfoBusquedaHospitalizaciones(response['data']);
        setInfoBusquedaHospitalizaciones(dataSort);
        // print('object;${response['data']}');
        notifyListeners();
        return response;
      }
    }

    if (response == null) {
      _errorHospitalizaciones = false;
      notifyListeners();
      return null;
    }
  }

  //================================INPUT   MASCOTA=============================================//
  String? _nombreMascota = '';
  String? get getNombreMascota => _nombreMascota;

  void setNombreMascota(String? value) {
    _nombreMascota = value;

    notifyListeners();
  }

  //================================INPUT   MASCOTA=============================================//
  String? _pesoMascota = '';
  String? get getPesoMascota => _pesoMascota;

  void setPesoMascota(String? value) {
    _pesoMascota = value;

    notifyListeners();
  }

  //================================INPUT   MASCOTA=============================================//
  String? _razaMascota = '';
  String? get getRazaMascota => _razaMascota;

  void setRazaMascota(String? value) {
    _razaMascota = value;

    notifyListeners();
  }

  //================================INPUT   MASCOTA=============================================//
  String? _sexoMascota = '';
  String? get getSexoMascota => _sexoMascota;

  void setSexoMascota(String? value) {
    _sexoMascota = value;

    notifyListeners();
  }

  //================================INPUT   MASCOTA=============================================//
  String? _edadMascota = '';
  String? get getEdadMascota => _edadMascota;

  void setEdadMascota(String? value) {
    _edadMascota = value;

    notifyListeners();
  }

  //================================INPUT   ESTADO CABELLO=============================================//
  String? _estadoMascota = '';
  String? get getEstadoMascota => _estadoMascota;

  void setEstadoMascota(String? value) {
    _estadoMascota = value;

    notifyListeners();
  }

  //================================INPUT   ESTADO CONDICIONES=============================================//
  String? _condicionesMascota = '';
  String? get getCondicionesMascota => _condicionesMascota;

  void setCondicionesMascota(String? value) {
    _condicionesMascota = value;

    notifyListeners();
  }

  String? _personaNombre = '';
  String? get getPropietarioMascota => _personaNombre;

  void setPersonaNombre(String? value) {
    _personaNombre = value;

    notifyListeners();
  }

  //================================INFO   MASCOTA=============================================//
  dynamic _infoMascota;
  dynamic get getInfoMascota => _infoMascota;
  int? _idMascota;

  String _personaId = "";
  String _personaDoc = "";
  // String _personaNombre = "";
  String _personaTelefono = "";
  List<String> _personaListCelular = [];
  String _personaDireccion = "";
  List<String> _personaListCorreo = [];

  void setMascotaInfo(dynamic _inf) {
    _infoMascota = _inf;
    _idMascota = _inf['mascId'];
    setNombreMascota(_inf['mascNombre']);
    setRazaMascota(_inf['mascRaza']);
    setSexoMascota(_inf['mascSexo']);
    setEdadMascota(_inf['mascEdad']);

    _personaId = _inf['mascPerId'];
    _personaDoc = _inf['mascPerDocNumero'];
    _personaNombre = _inf['mascPerNombre'];
    _personaTelefono = _inf['mascPerTelefono'];
    for (var itemCelu in _inf['mascPerCelular']) {
      _personaListCelular.add(itemCelu);
    }
    _personaDireccion = _inf['mascPerDireccion'];
    for (var itemEmail in _inf['mascPerEmail']) {
      _personaListCorreo.add(itemEmail);
    }
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

  //========================================DOCTOR secundario==================================================//
  String? _vetDoctorSecundarioId = '';
  String? get getDoctorSecundarioId => _vetDoctorSecundarioId;

  void setVetDoctorSecundarioId(String? _value) {
    _vetDoctorSecundarioId = _value;
    //
    notifyListeners();
  }

  String? _vetDoctorSecundarioNombre = '';
  String? get getVetDoctorSecundarioNombre => _vetDoctorSecundarioNombre;

  void setVetDoctorSecundarioNombre(String? _value) {
    _vetDoctorSecundarioNombre = _value;
    //
    notifyListeners();
  }

  dynamic _infoDoctorSecundario;
  dynamic get getInfoDoctorSecundario => _infoDoctorSecundario;
  // int? _idMascota;

  void setDoctorSecundarioInfo(dynamic _inf) {
    _infoDoctorSecundario = _inf;
    setVetDoctorSecundarioId(_inf['perId'].toString());
    setVetDoctorSecundarioNombre(_inf['perNombre']);
    notifyListeners();
  }

  //========================================DOCTOR NOCTURNO==================================================//
  String? _vetDoctorNocturnoId = '';
  String? get getDoctorNocturnoId => _vetDoctorNocturnoId;

  void setVetDoctorNocturnoId(String? _value) {
    _vetDoctorNocturnoId = _value;
    //
    notifyListeners();
  }

  String? _vetDoctorNocturnoNombre = '';
  String? get getVetDoctorNocturnoNombre => _vetDoctorNocturnoNombre;

  void setVetDoctorNocturnoNombre(String? _value) {
    _vetDoctorNocturnoNombre = _value;
    //
    notifyListeners();
  }

  dynamic _infoDoctorNocturno;
  dynamic get getInfoDoctorNocturno => _infoDoctorNocturno;
  // int? _idMascota;

  void setDoctorNocturnoInfo(dynamic _inf) {
    _infoDoctorNocturno = _inf;
    setVetDoctorNocturnoId(_inf['perId'].toString());
    setVetDoctorNocturnoNombre(_inf['perNombre']);
    notifyListeners();
  }

  //========================================OBSERVACIONES ==================================================//
  String? _observacion;
  get getObservacacion => _observacion;
  void setObservacacion(String? date) async {
    _observacion = date;

    notifyListeners();
  }

  //========================================DIAGNOSTICO ==================================================//
  String? _diagnostico;
  get getDiagnostico => _diagnostico;
  void setDiagnostico(String? date) async {
    _diagnostico = date;

    notifyListeners();
  }

  //========================================DIAGEXAMENES COMPLEMENTARIOOSTICO ==================================================//
  String? _examenesComplementarios;
  get getExamenesComplementarios => _examenesComplementarios;
  void setExamenesComplementarios(String? date) async {
    _examenesComplementarios = date;

    notifyListeners();
  }

//  =================  CREO DEBOUNCE  PARA BUSQUEDAS ==================//

  // Timer? _deboucerSearchBuscaPersona;

  // @override
  // void dispose() {
  //   _deboucerSearchBuscaMascota?.cancel();
  //   // _deboucerSearchBuscaPersona?.cancel();

  //   // _videoController.dispose();
  //   super.dispose();
  // }

//===================BOTON SEARCH MEDICINAS ==========================//

  bool _btnSearchMedicina = false;
  bool get btnSearchMedicina => _btnSearchMedicina;

  void setBtnSearchMedicina(bool action) {
    _btnSearchMedicina = action;
    //  print('==_btnSearchCoros===> $_btnSearchMascotas');
    notifyListeners();
  }

  //===================INPUT SEARCH COROSE==========================//
  String _nameSearchMedicina = "";
  String get nameSearchMedicina => _nameSearchMedicina;

  void onSearchTextMedicina(String data) {
    _nameSearchMedicina = data;
    if (_nameSearchMedicina.length >= 3) {
      _deboucerSearchBuscaMedicina?.cancel();
      _deboucerSearchBuscaMedicina =
          Timer(const Duration(milliseconds: 700), () {
        // print('=====> $data');
        buscaAllMedicinas(data);
      });
    } else {
      // buscaAusencias('','false');
    }
    notifyListeners();
  }

//==================== LISTA TODOS  MEDICINAS====================//
  List _listaMedicinas = [];
  // List<TipoMulta> get getListaTodosLosTiposDeMultas => _listaTodosLosTiposDeMultas;
  List get getListaMedicinas => _listaMedicinas;

  void setInfoBusquedaMedicinas(List data) {
    _listaMedicinas = data;
    // print('Medicinas:$_listaMedicinas');
    notifyListeners();
  }

  bool? _errorMedicinas; // sera nulo la primera vez
  bool? get getErrorMedicinas => _errorMedicinas;
  set setErrorMedicinas(bool? value) {
    _errorMedicinas = value;
    notifyListeners();
  }

  Future buscaAllMedicinas(String? _search) async {
    final dataUser = await Auth.instance.getSession();
// print('usuario : ${dataUser!.rucempresa}');
    final response = await _api.getAllMedicinas(
      search: _search,
      // estado: 'CLIENTES',
      token: '${dataUser!.token}',
    );
    if (response != null) {
      _errorMedicinas = true;

      List dataSort = [];
      dataSort = response['data'];
      dataSort.sort((a, b) => b['invFecReg']!.compareTo(a['invFecReg']!));

      // setInfoBusquedaMedicinas(response['data']);
      setInfoBusquedaMedicinas(dataSort);
      // print('object;${response['data']}');
      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorMedicinas = false;
      notifyListeners();
      return null;
    }
  }

//===================BOTON SEARCH parametro ==========================//

  bool _btnSearchParametro = false;
  bool get btnSearchParametro => _btnSearchParametro;

  void setBtnSearchParametro(bool action) {
    _btnSearchParametro = action;
    //  print('==_btnSearchCoros===> $_btnSearchMascotas');
    notifyListeners();
  }

  //===================INPUT SEARCH COROSE==========================//
  String _nameSearchParametro = "";
  String get nameSearchParametro => _nameSearchParametro;

  void onSearchTextParametro(String data) {
    _nameSearchParametro = data;
    if (_nameSearchParametro.length >= 3) {
      _deboucerSearchBuscaParametro?.cancel();
      _deboucerSearchBuscaParametro =
          Timer(const Duration(milliseconds: 700), () {
        // print('=====> $data');
        buscaAllParametros(data);
      });
    } else {
      // buscaAusencias('','false');
    }
    notifyListeners();
  }

//==================== LISTA TODOS  MEDICINAS====================//
  List _listaParametros = [];
  // List<TipoMulta> get getListaTodosLosTiposDeMultas => _listaTodosLosTiposDeMultas;
  List get getListaParametros => _listaParametros;

  void setInfoBusquedaParametros(List data) {
    _listaParametros = data;
    // print('Parametros:$_listaParametros');
    notifyListeners();
  }

  bool? _errorParametros; // sera nulo la primera vez
  bool? get getErrorParametros => _errorParametros;
  set setErrorParametros(bool? value) {
    _errorParametros = value;
    notifyListeners();
  }

  Future buscaAllParametros(String? _search) async {
    final dataUser = await Auth.instance.getSession();
// print('usuario : ${dataUser!.rucempresa}');
    final response = await _api.getAllParametros(
      search: _search,
      // estado: 'CLIENTES',
      token: '${dataUser!.token}',
    );
    if (response != null) {
      _errorParametros = true;

      List dataSort = [];
      dataSort = response['data'];
      dataSort.sort((a, b) => b['paramFecReg']!.compareTo(a['paramFecReg']!));

      // setInfoBusquedaParametros(response['data']);
      setInfoBusquedaParametros(dataSort);
      // print('object;${response['data']}');
      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorParametros = false;
      notifyListeners();
      return null;
    }
  }

//================================== GET INFO CABECERA  ==============================//
// void getInfoCabecera(dynamic _info){

//   print('INFO CABECERA $_info');
//   setNombreMedicina( _info['medicina']);
//    setDosisMedicina( _info['dosis']);
//     setCantidadMedicina(_info['cantidad']);
//     setViaMedicina( _info['inicio']);
//    setInicioMedicina( _info['via']);
//     setFrecuenciaMedicina( _info['frecuencia']);

// notifyListeners();
// }

  //========================================CABECERA MEDICAMENTOS ==================================================//

  String? _fechaHoraMedicina =
      '${DateTime.now().year}-${(DateTime.now().month) < 10 ? '0${DateTime.now().month}' : '${DateTime.now().month}'}-${(DateTime.now().day) < 10 ? '0${DateTime.now().day}' : '${DateTime.now().day}'}';

  get getFechaHoraMedicina => _fechaHoraMedicina;
  Future setFechaHoraMedicina(String? date) async {
    _fechaHoraMedicina = date;
// print('=====_fechaHoraMedicina: $_fechaHoraMedicina');
    notifyListeners();
  }

  String? _nombreMedicina = '';
  get getNombreMedicina => _nombreMedicina;
  Future setNombreMedicina(String? date) async {
    _nombreMedicina = date;
    // print('=====_nombreMedicina: $_nombreMedicina');

    // notifyListeners();
  }

  String? _dosisMedicina = '';
  get getDosisMedicina => _dosisMedicina;
  void setDosisMedicina(String? date) async {
    _dosisMedicina = date;

    notifyListeners();
  }

  String? _orderMedicina = '';
  get getOrderMedicina => _orderMedicina;
  void setOrderMedicina(String? date) async {
    _orderMedicina = date;
    // notifyListeners();
  }

  String? _cantidadMedicina = '1';
  get getCantidadMedicina => _cantidadMedicina;
  void setCantidadMedicina(String? date) async {
    _cantidadMedicina = date;

    notifyListeners();
  }

  String? _viaMedicina = '';
  get getViaMedicina => _viaMedicina;
  void setViaMedicina(String? date) async {
    _viaMedicina = date;

    notifyListeners();
  }

  String? _inicioMedicina = '0';
  get getInicioMedicina => _inicioMedicina;
  void setInicioMedicina(String? _date) async {
    if (_date!.isNotEmpty) {
      _inicioMedicina = _date;
    } else {
      _inicioMedicina = "0";
    }

    notifyListeners();
  }

  String? _frecuenciaMedicina = '1';
  get getFrecuenciaMedicina => _frecuenciaMedicina;
  void setFrecuenciaMedicina(String? date) async {
    if (date!.isNotEmpty) {
      _frecuenciaMedicina = date;
    } else {
      _frecuenciaMedicina = "1";
    }
    //

    notifyListeners();
  }

  dynamic _infoMedicina;
  dynamic get getInfoMedicina => _infoMedicina;
  int? _idMedicina;

  void setMedicinaInfo(dynamic _infMed) {
    // _infoMascota = _infMed;
    // _idMedicina = _infMed['mascId'];
    setNombreMedicina(_infMed['invNombre']);

    notifyListeners();
  }

  void resetFormAddMedicina() {
    idItem;
    _nombreMedicina = "";
    _dosisMedicina = "";
    _cantidadMedicina = "1";
    _viaMedicina = "";
    _inicioMedicina = "0";
    _frecuenciaMedicina = "1";
  }

  void resetFormAddAlimentos() {
    idItem;
    _nombreAlimento = "";
    _dosisAlimento = "";
    _cantidadAlimento = "1";
    _viaAlimento = "";
    _inicioAlimento = "0";
    _frecuenciaAlimento = "1";
  }

  void resetFormAddFluidos() {
    idItemFluido;
    _nombreFluido = "";
    _dosisFluido = "";
    _cantidadFluido = "1";

    _inicioFluido = "0";
  }

  void getInfoRowMedicina(int _idItem) {
    _medicamentoNew = {
      "idCabecera": _idItem,
      "order": getOrderMedicina,
      "medicina": getNombreMedicina,
      "dosis": getDosisMedicina,
      "cantidad": getCantidadMedicina,
      "via": getViaMedicina,
      "inicio": getInicioMedicina,
      "frecuencia": getFrecuenciaMedicina,
    };
    eliminaMedicinaAgregada(_idItem);
    setNuevoMedicamento(_medicamentoNew);
    // print('ESTE MEDICAMENTO ===***** ==>$_medicamentoNew');
    eliminaHorarioMedicinaAgregada(_idItem);
    resetHoraMedicina();
    addHorarioMedicamento(
      _idItem,
      getNombreMedicina,
      getInicioMedicina,
      getFrecuenciaMedicina,
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
    );
  }

//=========GUARDA HORA==============//
  void setHorarioMedicina(
    int _idItem,
    String _nomMedicina,
    String _inicioMedicina,
    String _frecuenciaMedicina,
    String _orderMedicina,
  ) {
    eliminaHorarioMedicinaAgregada(_idItem);
    addHorarioMedicamento(
      _idItem,
      _nomMedicina,
      _inicioMedicina,
      _frecuenciaMedicina,
      getH0,
      getH1,
      getH2,
      getH3,
      getH4,
      getH5,
      getH6,
      getH7,
      getH8,
      getH9,
      getH10,
      getH11,
      getH12,
      getH13,
      getH14,
      getH15,
      getH16,
      getH17,
      getH18,
      getH19,
      getH20,
      getH21,
      getH22,
      getH23,
      getOrdenMedicamento,
    );
    notifyListeners();
  }

//==================================//

  // void setInfoRowHorarioMedicina(
  //   int _idItem,
  //   String _nomMedicina,
  //   String _inicioMedicina,
  //   String _frecuenciaMedicina,
  // ) {
  //   eliminaHorarioMedicinaAgregada(_idItem);
  //   addHorarioMedicamento(
  //     _idItem,
  //     _nomMedicina,
  //     _inicioMedicina,
  //     _frecuenciaMedicina,
  //     // _h0,
  //     // _h1,
  //     // _h2,
  //     // _h3,
  //     // _h4,
  //     // _h5,
  //     // _h6,
  //     // _h7,
  //     // _h8,
  //     // _h9,
  //     // _h10,
  //     // _h11,
  //     // _h12,
  //     // _h13,
  //     // _h14,
  //     // _h15,
  //     // _h16,
  //     // _h17,
  //     // _h18,
  //     // _h19,
  //     // _h20,
  //     // _h21,
  //     // _h22,
  //     // _h23,
  //     getH0,
  //     getH1,
  //     getH2,
  //     getH3,
  //     getH4,
  //     getH5,
  //     getH6,
  //     getH7,
  //     getH8,
  //     getH9,
  //     getH10,
  //     getH11,
  //     getH12,
  //     getH13,
  //     getH14,
  //     getH15,
  //     getH16,
  //     getH17,
  //     getH18,
  //     getH19,
  //     getH20,
  //     getH21,
  //     getH22,
  //     getH23,
  //     getOrdenMedicamento,
  //   );

  //   resetHoraMedicina();
  // }

//================================AGREGA LISTA MEDICAMENTOA=============================================//
  List<Map<String, dynamic>> _listMedicamentos = [];
  Map<String, dynamic> _medicamentoNew = {};
  int? idItem = 0;
  void addCabeceraMedicamento() {
    _medicamentoNew = {
      "idCabecera": idItem,
      "order": "",
      "medicina": _nombreMedicina,
      "dosis": _dosisMedicina,
      "cantidad": _cantidadMedicina,
      "via": _viaMedicina,
      "inicio": _inicioMedicina,
      "frecuencia": _frecuenciaMedicina,
    };

    setNuevoMedicamento(_medicamentoNew);

    addHorarioMedicamento(
      idItem,
      _nombreMedicina!,
      getInicioMedicina,
      getFrecuenciaMedicina,
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
    );
    // print('ESTE MEDICAMENTO ===***** ==>$_listMedicamentos');
    idItem = idItem! + 1;
  }

  //============ELIMINA ELEMENTO DE LA LISTA DE MEDICAMENTOS=====================//
  void eliminaMedicinaAgregada(int rowSelect) {
    _nuevoMedicamento.removeWhere((e) => e['idCabecera'] == rowSelect);
    eliminaHorarioMedicinaAgregada(rowSelect);
    // _listHorarioMedicamento.removeWhere((e) => e['idCabecera'] == rowSelect);
    notifyListeners();
  }
  //============ELIMINA ELEMENTO DE LA LISTA DE MEDICAMENTOS=====================//

  bool _isFechaCita = false;
  bool get getIsFechaCita => _isFechaCita;

  void setisFechaCita(bool _estado) {
    _isFechaCita = _estado;
    notifyListeners();
  }

//================================AGREGA LISTA MEDICAMENTOA=============================================//
  List<Map<String, dynamic>> _nuevoMedicamento = [];
  List<Map<String, dynamic>> get getNuevoMedicamento => _nuevoMedicamento;

  void setNuevoMedicamento(Map<String, dynamic> _medicamento) {
    _nuevoMedicamento.add(_medicamento);
    // print('ESTA ES LA MEDICINA  =====>$_nuevoMedicamento');

    notifyListeners();
  }

  List<Map<String, dynamic>> _antiguosMedicamento = [];
  List<Map<String, dynamic>> get getAntiguosMedicamento => _antiguosMedicamento;

  void setAntiguosMedicamento(Map<String, dynamic> _medicamento) {
    _antiguosMedicamento.add(_medicamento);
    // print('ESTA ES LA MEDICINA  =====>$_nuevoMedicamento');

    notifyListeners();
  }

//================================AGREGA  HORARIO MEDICINA=============================================//

  void getHData(int _index) async {
    if (_index == 0) {
      getH0;
    } else if (_index == 1) {
      getH1;
    } else if (_index == 2) {
      getH2;
    } else if (_index == 3) {
      getH3;
    } else if (_index == 4) {
      getH4;
    } else if (_index == 5) {
      getH5;
    } else if (_index == 6) {
      getH6;
    } else if (_index == 7) {
      getH7;
    } else if (_index == 8) {
      getH8;
    } else if (_index == 9) {
      getH9;
    } else if (_index == 10) {
      getH10;
    } else if (_index == 11) {
      getH11;
    } else if (_index == 12) {
      getH12;
    } else if (_index == 13) {
      getH13;
    } else if (_index == 14) {
      getH14;
    } else if (_index == 15) {
      getH15;
    } else if (_index == 16) {
      getH16;
    } else if (_index == 17) {
      getH17;
    } else if (_index == 18) {
      getH18;
    } else if (_index == 19) {
      getH19;
    } else if (_index == 20) {
      getH20;
    } else if (_index == 21) {
      getH21;
    } else if (_index == 22) {
      getH22;
    } else if (_index == 23) {
      getH23;
    }

    notifyListeners();
  }

  void setHData(String? _data, int _index) async {
    if (_index == 0) {
      setH0(_data);
    } else if (_index == 1) {
      setH1(_data);
    } else if (_index == 2) {
      setH2(_data);
    } else if (_index == 3) {
      setH3(_data);
    } else if (_index == 4) {
      setH4(_data);
    } else if (_index == 5) {
      setH5(_data);
    } else if (_index == 6) {
      setH6(_data);
    } else if (_index == 7) {
      setH7(_data);
    } else if (_index == 8) {
      setH8(_data);
    } else if (_index == 9) {
      setH9(_data);
    } else if (_index == 10) {
      setH10(_data);
    } else if (_index == 11) {
      setH11(_data);
    } else if (_index == 12) {
      setH12(_data);
    } else if (_index == 13) {
      setH13(_data);
    } else if (_index == 14) {
      setH14(_data);
    } else if (_index == 15) {
      setH15(_data);
    } else if (_index == 16) {
      setH16(_data);
    } else if (_index == 17) {
      setH17(_data);
    } else if (_index == 18) {
      setH18(_data);
    } else if (_index == 19) {
      setH19(_data);
    } else if (_index == 20) {
      setH20(_data);
    } else if (_index == 21) {
      setH21(_data);
    } else if (_index == 22) {
      setH22(_data);
    } else if (_index == 23) {
      setH23(_data);
    }

    notifyListeners();
  }

  String? _h0 = "";
  get getH0 => _h0;
  void setH0(String? _data) {
    _h0 = _data;

    print('HORA _h0: $_h0 ');
    // notifyListeners();
  }

  String? _h1 = "";
  get getH1 => _h1;
  void setH1(String? _data) {
    _h1 = _data;

    print('HORA _h1: $_h1');
    // notifyListeners();
  }

  String? _h2 = "";
  get getH2 => _h2;
  void setH2(String? _data) {
    print('HORA _h2: $_h2');
    _h2 = _data;
    // notifyListeners();
  }

  String? _h3 = "";
  get getH3 => _h3;
  void setH3(String? _data) {
    _h3 = _data;
    print('HORA _h3: $_h3');
    // notifyListeners();
  }

  String? _h4 = "";
  get getH4 => _h4;
  void setH4(String? _data) {
    _h4 = _data;
    print('HORA _h4: $_h4');
    // notifyListeners();
  }

  String? _h5 = "";
  get getH5 => _h5;
  void setH5(String? _data) {
    _h5 = _data;
    print('HORA _h5: $_h5');
    // notifyListeners();
  }

  String? _h6 = "";
  get getH6 => _h6;
  void setH6(String? _data) {
    _h6 = _data;
    print('HORA _h6: $_h6');
    // notifyListeners();
  }

  String? _h7 = "";
  get getH7 => _h7;
  void setH7(String? _data) {
    _h7 = _data;
    print('HORA _h7: $_h7');
    // notifyListeners();
  }

  String? _h8 = "";
  get getH8 => _h8;
  void setH8(String? _data) {
    _h8 = _data;
    print('HORA _h8: $_h8');
    // notifyListeners();
  }

  String? _h9 = "";
  get getH9 => _h9;
  void setH9(String? _data) {
    _h9 = _data;
    print('HORA _h9: $_h9');
    // notifyListeners();
  }

  String? _h10 = "";
  get getH10 => _h10;
  void setH10(String? _data) {
    _h10 = _data;
    print('HORA _h10: $_h10');
    // notifyListeners();
  }

  String? _h11 = "";
  get getH11 => _h11;
  void setH11(String? _data) {
    _h11 = _data;
    print('HORA _h11: $_h11');
    // notifyListeners();
  }

  String? _h12 = "";
  get getH12 => _h12;
  void setH12(String? _data) {
    _h12 = _data;
    print('HORA _h12: $_h12');
    // notifyListeners();
  }

  String? _h13 = "";
  get getH13 => _h13;
  void setH13(String? _data) {
    _h13 = _data;
    print('HORA _h13: $_h13');
    // notifyListeners();
  }

  String? _h14 = "";
  get getH14 => _h14;
  void setH14(String? _data) {
    _h14 = _data;
    print('HORA _h14: $_h14');
    // notifyListeners();
  }

  String? _h15 = "";
  get getH15 => _h15;
  void setH15(String? _data) {
    _h15 = _data;
    print('HORA _h15: $_h15');
    // notifyListeners();
  }

  String? _h16 = "";
  get getH16 => _h16;
  void setH16(String? _data) {
    _h16 = _data;
    print('HORA _h16: $_h16');
    // notifyListeners();
  }

  String? _h17 = "";
  get getH17 => _h17;
  void setH17(String? _data) {
    _h17 = _data;
    print('HORA _h17: $_h17');
    // notifyListeners();
  }

  String? _h18 = "";
  get getH18 => _h18;
  void setH18(String? _data) {
    _h18 = _data;
    print('HORA _h18: $_h18');
    // notifyListeners();
  }

  String? _h19 = "";
  get getH19 => _h19;
  void setH19(String? _data) {
    _h19 = _data;
    print('HORA _h19: $_h19');
    // notifyListeners();
  }

  String? _h20 = "";
  get getH20 => _h20;
  void setH20(String? _data) {
    _h20 = _data;
    print('HORA _h20: $_h20');
    // notifyListeners();
  }

  String? _h21 = "";
  get getH21 => _h21;
  void setH21(String? _data) {
    _h21 = _data;
    print('HORA _h21: $_h21');
    // notifyListeners();
  }

  String? _h22 = "";
  get getH22 => _h22;
  void setH22(String? _data) {
    _h22 = _data;
    print('HORA _h22: $_h22');
    // notifyListeners();
  }

  String? _h23 = "";
  get getH23 => _h23;
  void setH23(String? _data) {
    _h23 = _data;
    print('HORA _h23: $_h23');
    // notifyListeners();
  }

  String? _fechaHorario = '2022-12-19';
  get getFechaHorario => _fechaHorario;
  void setFechaHorario(String? date) async {
    _fechaHorario = date;
    notifyListeners();
  }

  void resetHoraMedicina() {
    _h0 = "";
    _h1 = "";
    _h2 = "";
    _h3 = "";
    _h4 = "";
    _h5 = "";
    _h6 = "";
    _h7 = "";
    _h8 = "";
    _h9 = "";
    _h10 = "";
    _h11 = "";
    _h12 = "";
    _h13 = "";
    _h14 = "";
    _h15 = "";
    _h16 = "";
    _h17 = "";
    _h18 = "";
    _h19 = "";
    _h20 = "";
    _h21 = "";
    _h22 = "";
    _h23 = "";
  }

  void resetHoraAlimento() {
    _h0Alimento = "";
    _h1Alimento = "";
    _h2Alimento = "";
    _h3Alimento = "";
    _h4Alimento = "";
    _h5Alimento = "";
    _h6Alimento = "";
    _h7Alimento = "";
    _h8Alimento = "";
    _h9Alimento = "";
    _h10Alimento = "";
    _h11Alimento = "";
    _h12Alimento = "";
    _h13Alimento = "";
    _h14Alimento = "";
    _h15Alimento = "";
    _h16Alimento = "";
    _h17Alimento = "";
    _h18Alimento = "";
    _h19Alimento = "";
    _h20Alimento = "";
    _h21Alimento = "";
    _h22Alimento = "";
    _h23Alimento = "";
  }

  void resetHoraParametros() {
    _h0Parametro = "";
    _h1Parametro = "";
    _h2Parametro = "";
    _h3Parametro = "";
    _h4Parametro = "";
    _h5Parametro = "";
    _h6Parametro = "";
    _h7Parametro = "";
    _h8Parametro = "";
    _h9Parametro = "";
    _h10Parametro = "";
    _h11Parametro = "";
    _h12Parametro = "";
    _h13Parametro = "";
    _h14Parametro = "";
    _h15Parametro = "";
    _h16Parametro = "";
    _h17Parametro = "";
    _h18Parametro = "";
    _h19Parametro = "";
    _h20Parametro = "";
    _h21Parametro = "";
    _h22Parametro = "";
    _h23Parametro = "";
  }

  List<Map<String, dynamic>> _listHorarioMedicamento = [];
  Map<String, dynamic> _medicamentoHorarioNew = {};
  int? idItemHorario = 0;
  void addHorarioMedicamento(
      int? idItem,
      String _nomMedic,
      String _inic,
      String _frec,
      String? _h0,
      String? _h1,
      String? _h2,
      String? _h3,
      String? _h4,
      String? _h5,
      String? _h6,
      String? _h7,
      String? _h8,
      String? _h9,
      String? _h10,
      String? _h11,
      String? _h12,
      String? _h13,
      String? _h14,
      String? _h15,
      String? _h16,
      String? _h17,
      String? _h18,
      String? _h19,
      String? _h20,
      String? _h21,
      String? _h22,
      String? _h23,
      String? _order) {
    _medicamentoHorarioNew = {
      "idCabecera": idItem,
      "_inicio": _inic,
      "_frecuencia": _frec,
      "idMedicamento": idItemHorario,
      "fecha": _fechaHoraMedicina,
      "nameMedicinaHorarios": _nomMedic,
      "H0": _h0,
      "H1": _h1,
      "H2": _h2,
      "H3": _h3,
      "H4": _h4,
      "H5": _h5,
      "H6": _h6,
      "H7": _h7,
      "H8": _h8,
      "H9": _h9,
      "H10": _h10,
      "H11": _h11,
      "H12": _h12,
      "H13": _h13,
      "H14": _h14,
      "H15": _h15,
      "H16": _h16,
      "H17": _h17,
      "H18": _h18,
      "H19": _h19,
      "H20": _h20,
      "H21": _h21,
      "H22": _h22,
      "H23": _h23,
      "order": "",
    };
    setNuevoHorarioMedicamento(_medicamentoHorarioNew);
    // print('ESTE HORARIO MEDICAMENTO ===***** ==>$_medicamentoHorarioNew');
    idItemHorario = idItemHorario! + 1;
    notifyListeners();
  }

  //============GET ITEM  MEDICAMENTO=====================//
// String? action;
  int? _inicio;
  int? get getInicio => _inicio;
  // int idItem;
  int? _frecuencia;
  int? get getFrecuenci => _frecuencia;

  int? _idCabecera;
  int? get getIdCabecera => _idCabecera;
  String? _nomMedicamento;
  String? get getNomMedic => _nomMedicamento;
  String? _ordenMedicamento;
  String? get getOrdenMedicamento => _ordenMedicamento;
  Map<String, dynamic>? _listaHorario;
  Map<String, dynamic>? get getlistaHorario => _listaHorario;

  Map<String, dynamic>? _infoItemHora;
  Map<String, dynamic>? get getInfoItemHora => _infoItemHora;
  void getItemHorariMedicamento(Map<String, dynamic> _infoItem) {
// print('ESTE HORARIO _infoItem ===***** ==>$_infoItem');
    _infoItemHora = _infoItem;
    _inicio = int.parse(_infoItem['_inicio']);

    _frecuencia = int.parse(_infoItem['_frecuencia']);
    _idCabecera = _infoItem['idCabecera'];

    _nomMedicamento = _infoItem['nameMedicinaHorarios'];
// _listaHorario=_infoItem[''];
    setH0(_infoItem['H0']);
    setH1(_infoItem['H1']);
    setH2(_infoItem['H2']);
    setH3(_infoItem['H3']);
    setH4(_infoItem['H4']);
    setH5(_infoItem['H5']);
    setH6(_infoItem['H6']);
    setH7(_infoItem['H7']);
    setH8(_infoItem['H8']);
    setH9(_infoItem['H9']);
    setH10(_infoItem['H10']);
    setH11(_infoItem['H11']);
    setH12(_infoItem['H12']);
    setH13(_infoItem['H13']);
    setH14(_infoItem['H14']);
    setH15(_infoItem['H15']);
    setH16(_infoItem['H16']);
    setH17(_infoItem['H17']);
    setH18(_infoItem['H18']);
    setH19(_infoItem['H19']);
    setH20(_infoItem['H20']);
    setH21(_infoItem['H21']);
    setH22(_infoItem['H22']);
    setH23(_infoItem['H23']);
    setOrderMedicina(_infoItem['order']);

    notifyListeners();
  }

  //============ELIMINA ELEMENTO DE LA LISTA DE MEDICAMENTOS=====================//
  void eliminaHorarioMedicinaAgregada(int rowSelect) {
    // print('ESTE MEDICAMENTO ===***** ==>$rowSelect');
    _nuevoHorarioMedicamento.removeWhere((e) => e['idCabecera'] == rowSelect);
    notifyListeners();
  }

//================================AGREGA LISTA MEDICAMENTOA=============================================//
  List<Map<String, dynamic>> _nuevoHorarioMedicamento = [];
  List<Map<String, dynamic>> get getNuevoHorarioMedicamento =>
      _nuevoHorarioMedicamento;

  void setNuevoHorarioMedicamento(Map<String, dynamic> _medicamento) {
    _nuevoHorarioMedicamento.add(_medicamento);
    // print('ESTE ES EL HORARIO  =====>$_nuevoMedicamento');

    notifyListeners();
  }

  List<Map<String, dynamic>> _antiguoHoraMedicamento = [];
  List<Map<String, dynamic>> get getAntiguooraMedicamento =>
      _antiguoHoraMedicamento;

  void setAntiguoorarioMedicamento(Map<String, dynamic> _medicamento) {
    _antiguoHoraMedicamento.add(_medicamento);
    // print('ESTA ES LA MEDICINA  =====>$_nuevoMedicamento');

    notifyListeners();
  }

  //=======================================================================================================//
  //========================================CABECERA ALIMENTOS ==================================================//
  //==========================================================================================================//
  String? _fechaHoraAlimentos =
      '${DateTime.now().year}-${(DateTime.now().month) < 10 ? '0${DateTime.now().month}' : '${DateTime.now().month}'}-${(DateTime.now().day) < 10 ? '0${DateTime.now().day}' : '${DateTime.now().day}'}';
  get getFechaHoraAlimentos => _fechaHoraAlimentos;
  Future setFechaHoraAlimentos(String? date) async {
    _fechaHoraAlimentos = date;
// print('=====_fechaHoraAlimentos: $_fechaHoraAlimentos');
    notifyListeners();
  }

  String? _nombreAlimento = '';
  get getNombreAlimento => _nombreAlimento;
  Future setNombreAlimento(String? date) async {
    _nombreAlimento = date;
    // print('EST_nombreAlimento  =====>$_nombreAlimento');

    // notifyListeners();
  }

  String? _dosisAlimento = '';
  get getDosisAlimento => _dosisAlimento;
  void setDosisAlimento(String? date) async {
    _dosisAlimento = date;

    notifyListeners();
  }

  String? _orderAlimento = '';
  get getOrderAlimento => _orderAlimento;
  void setOrderAlimento(String? date) async {
    _orderAlimento = date;
    // notifyListeners();
  }

  String? _cantidadAlimento = '1';
  get getCantidadAlimento => _cantidadAlimento;
  void setCantidadAlimento(String? date) async {
    _cantidadAlimento = date;

    notifyListeners();
  }

  String? _viaAlimento = '';
  get getViaAlimento => _viaAlimento;
  void setViaAlimento(String? date) async {
    _viaAlimento = date;

    notifyListeners();
  }

  String? _inicioAlimento = '0';
  get getInicioAlimento => _inicioAlimento;
  void setInicioAlimento(String? _date) async {
    if (_date!.isNotEmpty) {
      _inicioAlimento = _date;
    } else {
      _inicioAlimento = "0";
    }

    notifyListeners();
  }

  String? _frecuenciaAlimento = '1';
  get getFrecuenciaAlimento => _frecuenciaAlimento;
  void setFrecuenciaAlimento(String? date) async {
    if (date!.isNotEmpty) {
      _frecuenciaAlimento = date;
    } else {
      _frecuenciaAlimento = "1";
    }
    //

    notifyListeners();
  }

  dynamic _infoAlimento;
  dynamic get getInfoAlimento => _infoAlimento;
  int? _idAlimento;

  void setAlimentoInfo(dynamic _infMed) {
    // _infoMascota = _infMed;
    // _idAlimento = _infMed['mascId'];
    setNombreAlimento(_infMed['invNombre']);

    notifyListeners();
  }

  void resetFormAddAlimento() {
    _idAlimento;
    _nombreAlimento = "";
    _dosisAlimento = "";
    _cantidadAlimento = "1";
    _inicioAlimento = "0";
    _frecuenciaAlimento = "1";
  }

  // void getInfoRowAlimento(int _idItem) {
  //   _alimentoNew = {
  //     "idCabeceraAlimento": _idItem,
  //     "order": "",
  //     "alimento": getNombreAlimento,
  //     "dosis": getDosisAlimento,
  //     "cantidad": getCantidadAlimento,
  //     "inicio": getInicioAlimento,
  //     "frecuencia": getFrecuenciaAlimento,
  //   };
  //   eliminaAlimentoAgregada(_idItem);
  //   setNuevoAlimento(_alimentoNew);
  //   // print('ESTE MEDICAMENTO ===***** ==>$_medicamentoNew');
  //   eliminaHorarioAlimentoAgregada(_idItem);
  //   resetHoraAlimento();
  //   addHorarioAlimento(_idItem);
  // }

  void setInfoRowHorarioAlimento(int _idItem) {
    /// print('ESTE MEDICAMENTO ===***** ==>$_medicamentoNew');
    eliminaHorarioAlimentoAgregada(_idItem);
    addHorarioAlimento(
      _idItem,
      getNombreAlimento,
      getInicioAlimento,
      getFrecuenciaAlimento,
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
    );
  }

//================================AGREGA LISTA MEDICAMENTOA=============================================//
  List<Map<String, dynamic>> _listAlimentos = [];
  Map<String, dynamic> _alimentoNew = {};
  int? idItemAlimento = 0;
  void addCabeceraAlimento() {
    _alimentoNew = {
      "idCabeceraAlimento": idItemAlimento,
      "order": "",
      "alimento": _nombreAlimento,
      "dosis": _dosisAlimento,
      "cantidad": _cantidadAlimento,
      "inicio": _inicioAlimento,
      "frecuencia": _frecuenciaAlimento,
    };
    setNuevoAlimento(_alimentoNew);

    addHorarioAlimento(
      idItemAlimento,
      getNombreAlimento,
      getInicioAlimento,
      getFrecuenciaAlimento,
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
    );
    // print('ESTE MEDICAMENTO ===***** ==>$_listAlimentos');
    idItemAlimento = idItemAlimento! + 1;
  }

  //============ELIMINA ELEMENTO DE LA LISTA DE Alimentos=====================//
  void eliminaAlimentoAgregada(int rowSelect) {
    _nuevoAlimento.removeWhere((e) => e['idCabeceraAlimento'] == rowSelect);
    eliminaHorarioAlimentoAgregada(rowSelect);
    // _listHorarioMedicamento.removeWhere((e) => e['idCabecera'] == rowSelect);
    notifyListeners();
  }
  //============ELIMINA ELEMENTO DE LA LISTA DE MEDICAMENTOS=====================//

//================================AGREGA LISTA MEDICAMENTOA=============================================//
  List<Map<String, dynamic>> _nuevoAlimento = [];
  List<Map<String, dynamic>> get getNuevoAlimento => _nuevoAlimento;

  void setNuevoAlimento(Map<String, dynamic> _alimento) {
    _nuevoAlimento.add(_alimento);
    //  print('ESTA ES ALIMENTO  =====>$_nuevoAlimento');

    notifyListeners();
  }

  List<Map<String, dynamic>> _antiguosAlimento = [];
  List<Map<String, dynamic>> get getAntiguosAlimento => _antiguosAlimento;

  void setAntiguosAlimento(Map<String, dynamic> _alimento) {
    _antiguosAlimento.add(_alimento);
    // print('ESTA ES LA Alimento  =====>$_nuevoMedicamento');

    notifyListeners();
  }

//================================AGREGA  HORARIO MEDICINA=============================================//

  // String? _hData = "---";
  // get getHData => _hData;
  void setHDataAlimento(String? _data, int _index) async {
    //   String ? _input='_h$index';
    //  _input= date;
    //  print('DATO H$index:INPUT$_input');

    if (_index == 0) {
      setH0Alimento(_data);
    } else if (_index == 1) {
      setH1Alimento(_data);
    } else if (_index == 2) {
      setH2Alimento(_data);
    } else if (_index == 3) {
      setH3Alimento(_data);
    } else if (_index == 4) {
      setH4Alimento(_data);
    } else if (_index == 5) {
      setH5Alimento(_data);
    } else if (_index == 6) {
      setH6Alimento(_data);
    } else if (_index == 7) {
      setH7Alimento(_data);
    } else if (_index == 8) {
      setH8Alimento(_data);
    } else if (_index == 9) {
      setH9Alimento(_data);
    } else if (_index == 10) {
      setH10Alimento(_data);
    } else if (_index == 11) {
      setH11Alimento(_data);
    } else if (_index == 12) {
      setH12Alimento(_data);
    } else if (_index == 13) {
      setH13Alimento(_data);
    } else if (_index == 14) {
      setH14Alimento(_data);
    } else if (_index == 15) {
      setH15Alimento(_data);
    } else if (_index == 16) {
      setH16Alimento(_data);
    } else if (_index == 17) {
      setH17Alimento(_data);
    } else if (_index == 18) {
      setH18Alimento(_data);
    } else if (_index == 19) {
      setH19Alimento(_data);
    } else if (_index == 20) {
      setH20Alimento(_data);
    } else if (_index == 21) {
      setH21Alimento(_data);
    } else if (_index == 22) {
      setH22Alimento(_data);
    } else if (_index == 23) {
      setH23Alimento(_data);
    }

    notifyListeners();
  }

  String? _h0Alimento = " ";
  get getH0Alimento => _h0Alimento;
  void setH0Alimento(String? _data) {
    _h0Alimento = _data;

    // print('HORA _h0Alimento: $_h0Alimento');
    // notifyListeners();
  }

  String? _h1Alimento = " ";
  get getH1Alimento => _h1Alimento;
  void setH1Alimento(String? _data) {
    _h1Alimento = _data;

    // print('HORA _h1Alimento: $_h1Alimento');
    // notifyListeners();
  }

  String? _h2Alimento = " ";
  get getH2Alimento => _h2Alimento;
  void setH2Alimento(String? _data) {
    // print('HORA _h2Alimento: $_h2Alimento');
    _h2Alimento = _data;
    // notifyListeners();
  }

  String? _h3Alimento = " ";
  get getH3Alimento => _h3Alimento;
  void setH3Alimento(String? _data) {
    _h3Alimento = _data;
    // print('HORA _h3Alimento: $_h3Alimento');
    // notifyListeners();
  }

  String? _h4Alimento = " ";
  get getH4Alimento => _h4Alimento;
  void setH4Alimento(String? _data) {
    _h4Alimento = _data;
    // print('HORA _h4Alimento: $_h4Alimento');
    // notifyListeners();
  }

  String? _h5Alimento = " ";
  get getH5Alimento => _h5Alimento;
  void setH5Alimento(String? _data) {
    _h5Alimento = _data;
    // print('HORA _h5Alimento: $_h5Alimento');
    // notifyListeners();
  }

  String? _h6Alimento = " ";
  get getH6Alimento => _h6Alimento;
  void setH6Alimento(String? _data) {
    _h6Alimento = _data;
    // print('HORA _h6Alimento: $_h6Alimento');
    // notifyListeners();
  }

  String? _h7Alimento = " ";
  get getH7Alimento => _h7Alimento;
  void setH7Alimento(String? _data) {
    _h7Alimento = _data;
    // print('HORA _h7Alimento: $_h7Alimento');
    // notifyListeners();
  }

  String? _h8Alimento = " ";
  get getH8Alimento => _h8Alimento;
  void setH8Alimento(String? _data) {
    _h8Alimento = _data;
    // print('HORA _h8Alimento: $_h8Alimento');
    // notifyListeners();
  }

  String? _h9Alimento = " ";
  get getH9Alimento => _h9Alimento;
  void setH9Alimento(String? _data) {
    _h9Alimento = _data;
    // print('HORA _h9Alimento: $_h9Alimento');
    // notifyListeners();
  }

  String? _h10Alimento = " ";
  get getH10Alimento => _h10Alimento;
  void setH10Alimento(String? _data) {
    _h10Alimento = _data;
    // print('HORA _h10Alimento: $_h10Alimento');
    // notifyListeners();
  }

  String? _h11Alimento = " ";
  get getH11Alimento => _h11Alimento;
  void setH11Alimento(String? _data) {
    _h11Alimento = _data;
    // print('HORA _h11Alimento: $_h11Alimento');
    // notifyListeners();
  }

  String? _h12Alimento = " ";
  get getH12Alimento => _h12Alimento;
  void setH12Alimento(String? _data) {
    _h12Alimento = _data;
    // print('HORA _h12Alimento: $_h12Alimento');
    // notifyListeners();
  }

  String? _h13Alimento = " ";
  get getH13Alimento => _h13Alimento;
  void setH13Alimento(String? _data) {
    _h13Alimento = _data;
    // print('HORA _h14Alimento: $_h14Alimento');
    // notifyListeners();
  }

  String? _h14Alimento = " ";
  get getH14Alimento => _h14Alimento;
  void setH14Alimento(String? _data) {
    _h14Alimento = _data;
    // print('HORA _h1Alimento: $_h1Alimento');
    // notifyListeners();
  }

  String? _h15Alimento = " ";
  get getH15Alimento => _h15Alimento;
  void setH15Alimento(String? _data) {
    _h15Alimento = _data;
    // print('HORA _h15Alimento: $_h15Alimento');
    // notifyListeners();
  }

  String? _h16Alimento = " ";
  get getH16Alimento => _h16Alimento;
  void setH16Alimento(String? _data) {
    _h16Alimento = _data;
    // print('HORA _h16Alimento: $_h16Alimento');
    // notifyListeners();
  }

  String? _h17Alimento = " ";
  get getH17Alimento => _h17Alimento;
  void setH17Alimento(String? _data) {
    _h17Alimento = _data;
    // print('HORA _h17Alimento: $_h17Alimento');
    // notifyListeners();
  }

  String? _h18Alimento = " ";
  get getH18Alimento => _h18Alimento;
  void setH18Alimento(String? _data) {
    _h18Alimento = _data;
    // print('HORA _h18Alimento: $_h18Alimento');
    // notifyListeners();
  }

  String? _h19Alimento = " ";
  get getH19Alimento => _h19Alimento;
  void setH19Alimento(String? _data) {
    _h19Alimento = _data;
    // print('HORA _h19Alimento: $_h19Alimento');
    // notifyListeners();
  }

  String? _h20Alimento = " ";
  get getH20Alimento => _h20Alimento;
  void setH20Alimento(String? _data) {
    _h20Alimento = _data;
    // print('HORA _h20Alimento: $_h20Alimento');
    // notifyListeners();
  }

  String? _h21Alimento = " ";
  get getH21Alimento => _h21Alimento;
  void setH21Alimento(String? _data) {
    _h21Alimento = _data;
    // print('HORA _h21Alimento: $_h21Alimento');
    // notifyListeners();
  }

  String? _h22Alimento = " ";
  get getH22Alimento => _h22Alimento;
  void setH22Alimento(String? _data) {
    _h22Alimento = _data;
    // print('HORA _h22Alimento: $_h22Alimento');
    // notifyListeners();
  }

  String? _h23Alimento = " ";
  get getH23Alimento => _h23Alimento;
  void setH23Alimento(String? _data) {
    _h23Alimento = _data;
    // print('HORA _h23Alimento: $_h23Alimento');
    // notifyListeners();
  }

  // List<Map<String, dynamic>> _listHorarioAlimento = [];
  // Map<String, dynamic> _alimentoHorarioNew = {};
  // int? idItemHorarioAliemto = 0;
  // void addHorarioAlimento(int? _idItem) {
  //   _alimentoHorarioNew = {
  //     "_inicio": _inicioAlimento,
  //     "_frecuencia": _frecuenciaAlimento,
  //     "idCabeceraAlimento": _idItem,
  //     "idHorarioAlimento": _idItem,
  //     "fecha": _fechaHoraAlimentos,
  //     "nameAlimentosHorarios": _nombreAlimento,
  //     "H0": _h0Alimento,
  //     "H1": _h1Alimento,
  //     "H2": _h2Alimento,
  //     "H3": _h3Alimento,
  //     "H4": _h4Alimento,
  //     "H5": _h5Alimento,
  //     "H6": _h6Alimento,
  //     "H7": _h7Alimento,
  //     "H8": _h8Alimento,
  //     "H9": _h9Alimento,
  //     "H10": _h10Alimento,
  //     "H11": _h11Alimento,
  //     "H12": _h12Alimento,
  //     "H13": _h13Alimento,
  //     "H14": _h14Alimento,
  //     "H15": _h15Alimento,
  //     "H16": _h16Alimento,
  //     "H17": _h17Alimento,
  //     "H18": _h18Alimento,
  //     "H19": _h19Alimento,
  //     "H20": _h20Alimento,
  //     "H21": _h21Alimento,
  //     "H22": _h22Alimento,
  //     "H23": _h23Alimento,
  //     "order": ""
  //   };
  //   setNuevoHorarioAlimeno(_alimentoHorarioNew);
  //   // print('ESTE Alimeno ===***** ==>$_listAlimenos');
  //   idItemHorarioAliemto = idItemHorarioAliemto! + 1;
  // }

  List<Map<String, dynamic>> _listHorarioAlimento = [];
  Map<String, dynamic> _alimentoHorarioNew = {};
  int? idItemHorarioAliemto = 0;
  void addHorarioAlimento(
      int? idItemAli,
      String _nomAli,
      String _inicAli,
      String _frecAli,
      String? _h0,
      String? _h1,
      String? _h2,
      String? _h3,
      String? _h4,
      String? _h5,
      String? _h6,
      String? _h7,
      String? _h8,
      String? _h9,
      String? _h10,
      String? _h11,
      String? _h12,
      String? _h13,
      String? _h14,
      String? _h15,
      String? _h16,
      String? _h17,
      String? _h18,
      String? _h19,
      String? _h20,
      String? _h21,
      String? _h22,
      String? _h23,
      String? _order) {
    _alimentoHorarioNew = {
      "idCabeceraAlimento": idItemAli,
      "_inicio": _inicAli,
      "_frecuencia": _frecAli,
      "idHorarioAlimento": idItemHorarioAliemto,
      "fecha": _fechaHoraAlimentos,
      "nameAlimentosHorarios": _nomAli,
      "H0": _h0Alimento,
      "H1": _h1Alimento,
      "H2": _h2Alimento,
      "H3": _h3Alimento,
      "H4": _h4Alimento,
      "H5": _h5Alimento,
      "H6": _h6Alimento,
      "H7": _h7Alimento,
      "H8": _h8Alimento,
      "H9": _h9Alimento,
      "H10": _h10Alimento,
      "H11": _h11Alimento,
      "H12": _h12Alimento,
      "H13": _h13Alimento,
      "H14": _h14Alimento,
      "H15": _h15Alimento,
      "H16": _h16Alimento,
      "H17": _h17Alimento,
      "H18": _h18Alimento,
      "H19": _h19Alimento,
      "H20": _h20Alimento,
      "H21": _h21Alimento,
      "H22": _h22Alimento,
      "H23": _h23Alimento,
      "order": "",
    };
    setNuevoHorarioAlimeno(_alimentoHorarioNew);
    // print('ESTE HORARIO MEDICAMENTO ===***** ==>$_medicamentoHorarioNew');
    idItemHorarioAliemto = idItemHorarioAliemto! + 1;
    notifyListeners();
  }

  //============ELIMINA ELEMENTO DE LA LISTA DE AlimenoS=====================//
  void eliminaHorarioAlimentoAgregada(int rowSelect) {
    // print('ESTE Alimeno ===***** ==>$rowSelect');
    _nuevoHorarioAlimeno
        .removeWhere((e) => e['idCabeceraAlimento'] == rowSelect);
    notifyListeners();
  }

//================================AGREGA LISTA AlimenoA=============================================//
  List<Map<String, dynamic>> _nuevoHorarioAlimeno = [];
  List<Map<String, dynamic>> get getNuevoHorarioAlimeno => _nuevoHorarioAlimeno;

  void setNuevoHorarioAlimeno(Map<String, dynamic> _alimeno) {
    _nuevoHorarioAlimeno.add(_alimeno);
    // print('ESTA ES LA MEDICINA  =====>$_nuevoAlimeno');

    notifyListeners();
  }

  List<Map<String, dynamic>> _antiguoHoraAlimeno = [];
  List<Map<String, dynamic>> get getAntiguoHoraAlimeno => _antiguoHoraAlimeno;

  void setAntiguoHorarioAlimeno(Map<String, dynamic> _alimeno) {
    _antiguoHoraAlimeno.add(_alimeno);
    // print('ESTA ES LA MEDICINA  =====>$_nuevoAlimeno');

    notifyListeners();
  }

  //=======================================================================================================//
  //========================================CABECERA PARAMETROS ==================================================//
  //==========================================================================================================//

  String? _fechaHoraParametros =
      '${DateTime.now().year}-${(DateTime.now().month) < 10 ? '0${DateTime.now().month}' : '${DateTime.now().month}'}-${(DateTime.now().day) < 10 ? '0${DateTime.now().day}' : '${DateTime.now().day}'}';
  get getFechaHoraParametros => _fechaHoraParametros;
  Future setFechaHoraParametros(String? date) async {
    _fechaHoraParametros = date;
    // print('=====_fechaHoraParametros: $_fechaHoraParametros');
    notifyListeners();
  }

  String? _nombreParametro = '';
  get getNombreParametro => _nombreParametro;
  Future setNombreParametro(String? date) async {
    _nombreParametro = date;
    // print('EST_nombreParametro  =====>$_nombreParametro');

    // notifyListeners();
  }

  String? _orderParametro = '';
  get getOrderParametro => _orderParametro;
  Future setOrderParametro(String? date) async {
    _orderParametro = date;
    // print('_orderParametro  =====>$_orderParametro');

    // notifyListeners();
  }

  String? _nombreParametroValor = '';
  get getNombreParametroValor => _nombreParametroValor;
  void setNombreParametroValor(String? date) {
    _nombreParametroValor = date;
    // print('EST_nombreParametroValor  =====>$_nombreParametroValor');

    notifyListeners();
  }

  String? _dosisParametro = '';
  get getDosisParametro => _dosisParametro;
  void setDosisParametro(String? date) async {
    _dosisParametro = date;
    // print('_dosisParametro  =====>$_dosisParametro');

    notifyListeners();
  }

  String? _cantidadParametro = '1';
  get getCantidadParametro => _cantidadParametro;
  void setCantidadParametro(String? date) async {
    _cantidadParametro = date;

    notifyListeners();
  }

  String? _viaParametro = '';
  get getViaParametro => _viaParametro;
  void setViaParametro(String? date) async {
    _viaParametro = date;

    notifyListeners();
  }

  String? _inicioParametro = '0';
  get getInicioParametro => _inicioParametro;
  void setInicioParametro(String? _date) async {
    if (_date!.isNotEmpty) {
      _inicioParametro = _date;
    } else {
      _inicioParametro = "0";
    }

    notifyListeners();
  }

  String? _frecuenciaParametro = '1';
  get getFrecuenciaParametro => _frecuenciaParametro;
  void setFrecuenciaParametro(String? date) async {
    if (date!.isNotEmpty) {
      _frecuenciaParametro = date;
    } else {
      _frecuenciaParametro = "1";
    }
    //

    notifyListeners();
  }

  dynamic _infoParametro;
  dynamic get getInfoParametro => _infoParametro;
  int? _idParametro;

  void setParametroInfo(dynamic _infMed) {
    // _infoMascota = _infMed;
    // _idParametro = _infMed['mascId'];
    setNombreParametro(_infMed['paramNombre']);
    setDosisParametro(_infMed['paramValor']);

    notifyListeners();
  }

  void resetFormAddParametro() {
    _idParametro;
    _nombreParametro = "";
    _dosisParametro = "";
    _cantidadParametro = "1";
    _inicioParametro = "0";
    _frecuenciaParametro = "1";
  }

  // void getInfoRowParametro(int _idItem) {
  //   _ParametroNew = {
  //     "idCabeceraParametro": _idItem,
  //     "order": "",
  //     "parametro": getNombreParametro,
  //     "dosis": getDosisParametro,
  //     "cantidad": getCantidadParametro,
  //     "inicio": getInicioParametro,
  //     "frecuencia": getFrecuenciaParametro,
  //   };
  //   eliminaParametroAgregada(_idItem);
  //   setNuevoParametro(_ParametroNew);
  //   // print('ESTE MEDICAMENTO ===***** ==>$_medicamentoNew');
  //   eliminaHorarioParametroAgregada(_idItem);
  //   resetHoraParametros();
  //   addHorarioParametro(_idItem);
  // }

  // void setInfoRowHorarioParametro(int _idItem) {
  //   /// print('ESTE MEDICAMENTO ===***** ==>$_medicamentoNew');
  //   eliminaHorarioParametroAgregada(_idItem);
  //   addHorarioParametro(_idItem);
  // }
  // void getInfoRowParametro(int _idItem) {
  //   _parametroNew = {
  //     // "idCabecera": _idItem,
  //     // "medicina": getNombreMedicina,
  //     // "dosis": getDosisMedicina,
  //     // "cantidad": getCantidadMedicina,
  //     // "via": getViaMedicina,
  //     // "inicio": getInicioMedicina,
  //     // "frecuencia": getFrecuenciaMedicina,
  //     //  "idCabeceraParametro": _idItem,
  //     // "order": "",
  //     // "parametro": getNombreParametro,
  //     // "dosis": getDosisParametro,
  //     // "cantidad": getCantidadParametro,
  //     // "inicio": getInicioParametro,
  //     // "frecuencia": getFrecuenciaParametro,

  //      "idCabeceraParametro": idItemParametro,
  //     "order": "",
  //     "parametro": _nombreParametro,
  //     "dosis": _dosisParametro,
  //     "inicio": _inicioParametro,
  //     "frecuencia": _frecuenciaParametro,

  //   };
  //   eliminaParametroAgregada(_idItem);
  //   setNuevoParametro(_parametroNew);
  //   // print('ESTE MEDICAMENTO ===***** ==>$_medicamentoNew');
  //   eliminaHorarioParametroAgregada(_idItem);
  //   resetHoraParametros();
  //   addHorarioParametro(
  //     _idItem,
  //     getNombreParametro,
  //     getInicioParametro,
  //     getFrecuenciaParametro,
  //     "",
  //     "",
  //     "",
  //     "",
  //     "",
  //     "",
  //     "",
  //     "",
  //     "",
  //     "",
  //     "",
  //     "",
  //     "",
  //     "",
  //     "",
  //     "",
  //     "",
  //     "",
  //     "",
  //     "",
  //     "",
  //     "",
  //     "",
  //     "",
  //     "",
  //   );
  // }

//================================AGREGA LISTA MEDICAMENTOA=============================================//
  List<Map<String, dynamic>> _listParametros = [];
  Map<String, dynamic> _parametroNew = {};
  int? idItemParametro = 0;
  void addCabeceraParametro() {
    _parametroNew = {
      "idCabeceraParametro": idItemParametro,
      "order": "",
      "parametro": _nombreParametro,
      "dosis": _dosisParametro,
      "inicio": _inicioParametro,
      "frecuencia": _frecuenciaParametro,
    };
    setNuevoParametro(_parametroNew);

    addHorarioParametro(
      idItemParametro,
      getNombreParametro,
      getInicioParametro,
      getFrecuenciaParametro,
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
    );
    // print('ESTE MEDICAMENTO ===***** ==>$_listParametros');
    idItemParametro = idItemParametro! + 1;
  }

  //============ELIMINA ELEMENTO DE LA LISTA DE Parametros=====================//
  void eliminaParametroAgregada(int rowSelect) {
    _nuevoParametro.removeWhere((e) => e['idCabeceraParametro'] == rowSelect);
    eliminaHorarioParametroAgregada(rowSelect);
    // _listHorarioMedicamento.removeWhere((e) => e['idCabecera'] == rowSelect);
    notifyListeners();
  }
  //============ELIMINA ELEMENTO DE LA LISTA DE MEDICAMENTOS=====================//

//================================AGREGA LISTA MEDICAMENTOA=============================================//
  List<Map<String, dynamic>> _nuevoParametro = [];
  List<Map<String, dynamic>> get getNuevoParametro => _nuevoParametro;

  void setNuevoParametro(Map<String, dynamic> _parametro) {
    _nuevoParametro.add(_parametro);

    notifyListeners();
  }

  List<Map<String, dynamic>> _antiguosParametro = [];
  List<Map<String, dynamic>> get getAntiguosParametro => _antiguosParametro;

  void setAntiguosParametro(Map<String, dynamic> _parametro) {
    _antiguosParametro.add(_parametro);
    // print('ESTA ES LA Parametro  =====>$_nuevoMedicamento');

    notifyListeners();
  }

//================================AGREGA  HORARIO MEDICINA=============================================//

  // String? _hData = "---";
  // get getHData => _hData;
  void setHDataParametro(String? _data, int _index) async {
    //   String ? _input='_h$index';
    //  _input= date;
    //  print('DATO H$index:INPUT$_input');

    if (_index == 0) {
      setH0Parametro(_data);
    } else if (_index == 1) {
      setH1Parametro(_data);
    } else if (_index == 2) {
      setH2Parametro(_data);
    } else if (_index == 3) {
      setH3Parametro(_data);
    } else if (_index == 4) {
      setH4Parametro(_data);
    } else if (_index == 5) {
      setH5Parametro(_data);
    } else if (_index == 6) {
      setH6Parametro(_data);
    } else if (_index == 7) {
      setH7Parametro(_data);
    } else if (_index == 8) {
      setH8Parametro(_data);
    } else if (_index == 9) {
      setH9Parametro(_data);
    } else if (_index == 10) {
      setH10Parametro(_data);
    } else if (_index == 11) {
      setH11Parametro(_data);
    } else if (_index == 12) {
      setH12Parametro(_data);
    } else if (_index == 13) {
      setH13Parametro(_data);
    } else if (_index == 14) {
      setH14Parametro(_data);
    } else if (_index == 15) {
      setH15Parametro(_data);
    } else if (_index == 16) {
      setH16Parametro(_data);
    } else if (_index == 17) {
      setH17Parametro(_data);
    } else if (_index == 18) {
      setH18Parametro(_data);
    } else if (_index == 19) {
      setH19Parametro(_data);
    } else if (_index == 20) {
      setH20Parametro(_data);
    } else if (_index == 21) {
      setH21Parametro(_data);
    } else if (_index == 22) {
      setH22Parametro(_data);
    } else if (_index == 23) {
      setH23Parametro(_data);
    }

    notifyListeners();
  }

  String? _h0Parametro = " ";
  get getH0Parametro => _h0Parametro;
  void setH0Parametro(String? _data) {
    _h0Parametro = _data;

    // print('HORA _h0Parametro: $_h0Parametro');
    // notifyListeners();
  }

  String? _h1Parametro = " ";
  get getH1Parametro => _h1Parametro;
  void setH1Parametro(String? _data) {
    _h1Parametro = _data;

    // print('HORA _h1Parametro: $_h1Parametro');
    // notifyListeners();
  }

  String? _h2Parametro = " ";
  get getH2Parametro => _h2Parametro;
  void setH2Parametro(String? _data) {
    // print('HORA _h2Parametro: $_h2Parametro');
    _h2Parametro = _data;
    // notifyListeners();
  }

  String? _h3Parametro = " ";
  get getH3Parametro => _h3Parametro;
  void setH3Parametro(String? _data) {
    _h3Parametro = _data;
    // print('HORA _h3Parametro: $_h3Parametro');
    // notifyListeners();
  }

  String? _h4Parametro = " ";
  get getH4Parametro => _h4Parametro;
  void setH4Parametro(String? _data) {
    _h4Parametro = _data;
    // print('HORA _h4Parametro: $_h4Parametro');
    // notifyListeners();
  }

  String? _h5Parametro = " ";
  get getH5Parametro => _h5Parametro;
  void setH5Parametro(String? _data) {
    _h5Parametro = _data;
    // print('HORA _h5Parametro: $_h5Parametro');
    // notifyListeners();
  }

  String? _h6Parametro = " ";
  get getH6Parametro => _h6Parametro;
  void setH6Parametro(String? _data) {
    _h6Parametro = _data;
    // print('HORA _h6Parametro: $_h6Parametro');
    // notifyListeners();
  }

  String? _h7Parametro = " ";
  get getH7Parametro => _h7Parametro;
  void setH7Parametro(String? _data) {
    _h7Parametro = _data;
    // print('HORA _h7Parametro: $_h7Parametro');
    // notifyListeners();
  }

  String? _h8Parametro = " ";
  get getH8Parametro => _h8Parametro;
  void setH8Parametro(String? _data) {
    _h8Parametro = _data;
    // print('HORA _h8Parametro: $_h8Parametro');
    // notifyListeners();
  }

  String? _h9Parametro = " ";
  get getH9Parametro => _h9Parametro;
  void setH9Parametro(String? _data) {
    _h9Parametro = _data;
    // print('HORA _h9Parametro: $_h9Parametro');
    // notifyListeners();
  }

  String? _h10Parametro = " ";
  get getH10Parametro => _h10Parametro;
  void setH10Parametro(String? _data) {
    _h10Parametro = _data;
    // print('HORA _h10Parametro: $_h10Parametro');
    // notifyListeners();
  }

  String? _h11Parametro = " ";
  get getH11Parametro => _h11Parametro;
  void setH11Parametro(String? _data) {
    _h11Parametro = _data;
    // print('HORA _h11Parametro: $_h11Parametro');
    // notifyListeners();
  }

  String? _h12Parametro = " ";
  get getH12Parametro => _h12Parametro;
  void setH12Parametro(String? _data) {
    _h12Parametro = _data;
    // print('HORA _h12Parametro: $_h12Parametro');
    // notifyListeners();
  }

  String? _h13Parametro = " ";
  get getH13Parametro => _h13Parametro;
  void setH13Parametro(String? _data) {
    _h13Parametro = _data;
    // print('HORA _h14Parametro: $_h14Parametro');
    // notifyListeners();
  }

  String? _h14Parametro = " ";
  get getH14Parametro => _h14Parametro;
  void setH14Parametro(String? _data) {
    _h14Parametro = _data;
    // print('HORA _h1Parametro: $_h1Parametro');
    // notifyListeners();
  }

  String? _h15Parametro = " ";
  get getH15Parametro => _h15Parametro;
  void setH15Parametro(String? _data) {
    _h15Parametro = _data;
    // print('HORA _h15Parametro: $_h15Parametro');
    // notifyListeners();
  }

  String? _h16Parametro = " ";
  get getH16Parametro => _h16Parametro;
  void setH16Parametro(String? _data) {
    _h16Parametro = _data;
    // print('HORA _h16Parametro: $_h16Parametro');
    // notifyListeners();
  }

  String? _h17Parametro = " ";
  get getH17Parametro => _h17Parametro;
  void setH17Parametro(String? _data) {
    _h17Parametro = _data;
    // print('HORA _h17Parametro: $_h17Parametro');
    // notifyListeners();
  }

  String? _h18Parametro = " ";
  get getH18Parametro => _h18Parametro;
  void setH18Parametro(String? _data) {
    _h18Parametro = _data;
    // print('HORA _h18Parametro: $_h18Parametro');
    // notifyListeners();
  }

  String? _h19Parametro = " ";
  get getH19Parametro => _h19Parametro;
  void setH19Parametro(String? _data) {
    _h19Parametro = _data;
    // print('HORA _h19Parametro: $_h19Parametro');
    // notifyListeners();
  }

  String? _h20Parametro = " ";
  get getH20Parametro => _h20Parametro;
  void setH20Parametro(String? _data) {
    _h20Parametro = _data;
    // print('HORA _h20Parametro: $_h20Parametro');
    // notifyListeners();
  }

  String? _h21Parametro = " ";
  get getH21Parametro => _h21Parametro;
  void setH21Parametro(String? _data) {
    _h21Parametro = _data;
    // print('HORA _h21Parametro: $_h21Parametro');
    // notifyListeners();
  }

  String? _h22Parametro = " ";
  get getH22Parametro => _h22Parametro;
  void setH22Parametro(String? _data) {
    _h22Parametro = _data;
    // print('HORA _h22Parametro: $_h22Parametro');
    // notifyListeners();
  }

  String? _h23Parametro = " ";
  get getH23Parametro => _h23Parametro;
  void setH23Parametro(String? _data) {
    _h23Parametro = _data;
    // print('HORA _h23Parametro: $_h23Parametro');
    // notifyListeners();
  }

  // List<Map<String, dynamic>> _listHorarioParametro = [];
  // Map<String, dynamic> _parametroHorarioNew = {};
  // int? idItemHorarioParametro = 0;
  // void addHorarioParametro(int? _idItem) {
  //   _parametroHorarioNew = {
  //     "_inicio": _inicioParametro,
  //     "_frecuencia": _frecuenciaParametro,
  //     "idCabeceraParametro": _idItem,
  //     "idHorarioParametro": _idItem,
  //     "fecha": _fechaHoraParametros,
  //     "nameParametrosHorarios": _nombreParametro,
  //     "H0": _h0Parametro,
  //     "H1": _h1Parametro,
  //     "H2": _h2Parametro,
  //     "H3": _h3Parametro,
  //     "H4": _h4Parametro,
  //     "H5": _h5Parametro,
  //     "H6": _h6Parametro,
  //     "H7": _h7Parametro,
  //     "H8": _h8Parametro,
  //     "H9": _h9Parametro,
  //     "H10": _h10Parametro,
  //     "H11": _h11Parametro,
  //     "H12": _h12Parametro,
  //     "H13": _h13Parametro,
  //     "H14": _h14Parametro,
  //     "H15": _h15Parametro,
  //     "H16": _h16Parametro,
  //     "H17": _h17Parametro,
  //     "H18": _h18Parametro,
  //     "H19": _h19Parametro,
  //     "H20": _h20Parametro,
  //     "H21": _h21Parametro,
  //     "H22": _h22Parametro,
  //     "H23": _h23Parametro,
  //     "order": "",
  //   };
  //   setNuevoHorarioParametro(_parametroHorarioNew);
  //   // print('ESTE Parametro ===***** ==>$_listParametros');
  //   idItemHorarioParametro = idItemHorarioParametro! + 1;
  // }
  List<Map<String, dynamic>> _listHorarioParametro = [];
  Map<String, dynamic> _parametroHorarioNew = {};
  int? idItemHorarioParametro = 0;
  void addHorarioParametro(
      int? _idItemParam,
      String _nomParam,
      String _inicParam,
      String _frecParam,
      String? _h0,
      String? _h1,
      String? _h2,
      String? _h3,
      String? _h4,
      String? _h5,
      String? _h6,
      String? _h7,
      String? _h8,
      String? _h9,
      String? _h10,
      String? _h11,
      String? _h12,
      String? _h13,
      String? _h14,
      String? _h15,
      String? _h16,
      String? _h17,
      String? _h18,
      String? _h19,
      String? _h20,
      String? _h21,
      String? _h22,
      String? _h23,
      String? _orderParam) {
    _parametroHorarioNew = {
      "idCabeceraParametro": _idItemParam,
      "_inicio": _inicParam,
      "_frecuencia": _frecParam,
      "idHorarioParametro": idItemHorarioParametro,
      "fecha": _fechaHoraParametros,
      "nameParametrosHorarios": _nomParam,
      "H0": _h0Parametro,
      "H1": _h1Parametro,
      "H2": _h2Parametro,
      "H3": _h3Parametro,
      "H4": _h4Parametro,
      "H5": _h5Parametro,
      "H6": _h6Parametro,
      "H7": _h7Parametro,
      "H8": _h8Parametro,
      "H9": _h9Parametro,
      "H10": _h10Parametro,
      "H11": _h11Parametro,
      "H12": _h12Parametro,
      "H13": _h13Parametro,
      "H14": _h14Parametro,
      "H15": _h15Parametro,
      "H16": _h16Parametro,
      "H17": _h17Parametro,
      "H18": _h18Parametro,
      "H19": _h19Parametro,
      "H20": _h20Parametro,
      "H21": _h21Parametro,
      "H22": _h22Parametro,
      "H23": _h23Parametro,
      "order": "555",
    };
    setNuevoHorarioParametro(_parametroHorarioNew);
    // print('ESTE HORARIO MEDICAMENTO ===***** ==>$_medicamentoHorarioNew');
    idItemHorarioParametro = idItemHorarioParametro! + 1;
    notifyListeners();
  }

  //============ELIMINA ELEMENTO DE LA LISTA DE ParametroS=====================//
  void eliminaHorarioParametroAgregada(int rowSelect) {
    // print('ESTE Parametro ===***** ==>$rowSelect');
    _nuevoHorarioParametro
        .removeWhere((e) => e['idCabeceraParametro'] == rowSelect);
    notifyListeners();
  }

//================================AGREGA LISTA ParametroA=============================================//
  List<Map<String, dynamic>> _nuevoHorarioParametro = [];
  List<Map<String, dynamic>> get getNuevoHorarioParametro =>
      _nuevoHorarioParametro;

  void setNuevoHorarioParametro(Map<String, dynamic> _parametro) {
    _nuevoHorarioParametro.add(_parametro);
    // print('ESTA ES LA MEDICINA  =====>$_nuevoParametro');

    notifyListeners();
  }

  List<Map<String, dynamic>> _antiguoHoraParametro = [];
  List<Map<String, dynamic>> get getAntiguoHoraParametro =>
      _antiguoHoraParametro;

  void setAntiguoHorarioParametro(Map<String, dynamic> _parametro) {
    _antiguoHoraParametro.add(_parametro);
    // print('ESTA ES LA MEDICINA  =====>$_nuevoParametro');

    notifyListeners();
  }

  //=======================================================================================================//
  //========================================FLUIDOS ==================================================//
  //==========================================================================================================//
  String? _nombreFluido = '';
  get getNombreFluido => _nombreFluido;
  Future setNombreFluido(String? date) async {
    _nombreFluido = date;
    // print('EST_nombreFluido  =====>$_nombreFluido');

    // notifyListeners();
  }

  String? _orderFluido = '';
  get getOrderFluido => _orderFluido;
  Future setOrderFluido(String? date) async {
    _orderFluido = date;
    // print('_orderParametro  =====>$_orderParametro');

    // notifyListeners();
  }

  String? _dosisFluido = '';
  get getDosisFluido => _dosisFluido;
  void setDosisFluido(String? date) async {
    _dosisFluido = date;
    // print('_dosisFluido  =====>$_dosisFluido');

    notifyListeners();
  }

  String? _cantidadFluido = '1';
  get getCantidadFluido => _cantidadFluido;
  void setCantidadFluido(String? date) async {
    _cantidadFluido = date;

    notifyListeners();
  }

  String? _inicioFluido = '0';
  get getInicioFluido => _inicioFluido;
  void setInicioFluido(String? _date) async {
    if (_date!.isNotEmpty) {
      _inicioFluido = _date;
    } else {
      _inicioFluido = "0";
    }

    notifyListeners();
  }

  dynamic _infoFluido;
  dynamic get getInfoFluido => _infoFluido;
  int? _idFluido;

  // void setFluidoInfo(dynamic _infMed) {
  //   // _infoMascota = _infMed;
  //   // _idFluido = _infMed['mascId'];
  //   setNombreFluido(_infMed['paramNombre']);
  //   setDosisFluido(_infMed['paramValor']);

  //   notifyListeners();
  // }

  void resetFormAddFluido() {
    _idFluido;
    _nombreFluido = "";
    _dosisFluido = "";
    _cantidadFluido = "1";
    _inicioFluido = "0";
  }

  void getInfoRowFluido(int _idItemF) {
    _fluidoNew = {
      "idFluido": _idItemF,
      "order": "",
      "fluido": getNombreFluido,
      "dosis": getDosisFluido,
      "cantidad": getCantidadFluido,
      "inicio": getInicioFluido,
    };
    eliminaFluidoAgregada(_idItemF);
    setNuevoFluido(_fluidoNew);
    // print('ESTE MEDICAMENTO ===***** ==>$_medicamentoNew');
  }

//================================AGREGA LISTA MEDICAMENTOA=============================================//
  List<Map<String, dynamic>> _listFluidos = [];
  Map<String, dynamic> _fluidoNew = {};
  int? idItemFluido = 0;
  void addCabeceraFluido() {
    _fluidoNew = {
      "idFluido": idItemFluido,
      "order": "",
      "fluido": _nombreFluido,
      "dosis": _dosisFluido,
      "cantidad": _cantidadFluido,
      "inicio": _inicioFluido,
    };
    setNuevoFluido(_fluidoNew);

    // print('ESTE MEDICAMENTO ===***** ==>$_listFluidos');
    idItemFluido = idItemFluido! + 1;
  }

  //============ELIMINA ELEMENTO DE LA LISTA DE Fluidos=====================//
  void eliminaFluidoAgregada(int rowSelect) {
    _nuevoFluido.removeWhere((e) => e['idFluido'] == rowSelect);

    // _listHorarioMedicamento.removeWhere((e) => e['idCabecera'] == rowSelect);
    notifyListeners();
  }
  //============ELIMINA ELEMENTO DE LA LISTA DE MEDICAMENTOS=====================//

//================================AGREGA LISTA MEDICAMENTOA=============================================//
  List<Map<String, dynamic>> _nuevoFluido = [];
  List<Map<String, dynamic>> get getNuevoFluido => _nuevoFluido;

  void setNuevoFluido(Map<String, dynamic> _fluido) {
    _nuevoFluido.add(_fluido);

    notifyListeners();
  }

  List<Map<String, dynamic>> _antiguosFluido = [];
  List<Map<String, dynamic>> get getAntiguosFluido => _antiguosFluido;

  void setAntiguosFluido(Map<String, dynamic> _fluido) {
    _antiguosFluido.add(_fluido);
    // print('ESTA ES LA Parametro  =====>$_nuevoMedicamento');

    notifyListeners();
  }

  //=======================================================================================================//
  //========================================INFUSION ==================================================//
  //==========================================================================================================//
  String? _nombreInfusion = '';
  get getNombreInfusion => _nombreInfusion;
  Future setNombreInfusion(String? date) async {
    _nombreInfusion = date;
    // print('EST_nombreInfusion  =====>$_nombreInfusion');

    // notifyListeners();
  }

  String? _orderInfusion = '';
  get getOrderInfusion => _orderInfusion;
  Future setOrderInfusion(String? date) async {
    _orderInfusion = date;
    // print('_orderInfusion  =====>$_orderInfusion');

    // notifyListeners();
  }

  String? _dosisInfusion = '';
  get getDosisInfusion => _dosisInfusion;
  void setDosisInfusion(String? date) async {
    _dosisInfusion = date;
    // print('_dosisInfusion  =====>$_dosisInfusion');

    notifyListeners();
  }

  String? _cantidadInfusion = '1';
  get getCantidadInfusion => _cantidadInfusion;
  void setCantidadInfusion(String? date) async {
    _cantidadInfusion = date;

    notifyListeners();
  }

  String? _unidadInfusion = '0';
  get getUnidadInfusion => _unidadInfusion;
  void setUnidadInfusion(String? _date) async {
    if (_date!.isNotEmpty) {
      _unidadInfusion = _date;
    } else {
      _unidadInfusion = "0";
    }

    notifyListeners();
  }

  dynamic _infoInfusion;
  dynamic get getInfoInfusion => _infoInfusion;
  int? _idInfusion;

  // void setInfusionInfo(dynamic _infMed) {
  //   // _infoMascota = _infMed;
  //   // _idInfusion = _infMed['mascId'];
  //   setNombreInfusion(_infMed['paramNombre']);
  //   setDosisInfusion(_infMed['paramValor']);

  //   notifyListeners();
  // }

  void resetFormAddInfusion() {
    _idInfusion;
    _nombreInfusion = "";
    _dosisInfusion = "";
    _unidadInfusion = "0";
  }

  void getInfoRowInfusion(int _idItem) {
    _infusionNew = {
      "idInfusion": _idItem,
      "order": "",
      "infusion": getNombreInfusion,
      "dosis": getDosisInfusion,
      "unidad": getUnidadInfusion,
    };
    eliminaInfusionAgregada(_idItem);
    setNuevoInfusion(_infusionNew);
    // print('ESTE MEDICAMENTO ===***** ==>$_medicamentoNew');
  }

//================================AGREGA LISTA MEDICAMENTOA=============================================//
  List<Map<String, dynamic>> _listInfusions = [];
  Map<String, dynamic> _infusionNew = {};
  int? idItemInfusion = 0;
  void addCabeceraInfusion() {
    _infusionNew = {
      "idInfusion": idItemInfusion,
      "order": "",
      "infusion": _nombreInfusion,
      "dosis": _dosisInfusion,
      "unidad": _unidadInfusion,
    };
    setNuevoInfusion(_infusionNew);

    // print('ESTE MEDICAMENTO ===***** ==>$_listInfusions');
    idItemInfusion = idItemInfusion! + 1;
  }

  //============ELIMINA ELEMENTO DE LA LISTA DE Infusions=====================//
  void eliminaInfusionAgregada(int rowSelect) {
    _nuevoInfusion.removeWhere((e) => e['idInfusion'] == rowSelect);

    // _listHorarioMedicamento.removeWhere((e) => e['idCabecera'] == rowSelect);
    notifyListeners();
  }
  //============ELIMINA ELEMENTO DE LA LISTA DE MEDICAMENTOS=====================//

//================================AGREGA LISTA MEDICAMENTOA=============================================//
  List<Map<String, dynamic>> _nuevoInfusion = [];
  List<Map<String, dynamic>> get getNuevoInfusion => _nuevoInfusion;

  void setNuevoInfusion(Map<String, dynamic> _infusion) {
    _nuevoInfusion.add(_infusion);

    notifyListeners();
  }

  List<Map<String, dynamic>> _antiguosInfusion = [];
  List<Map<String, dynamic>> get getAntiguosInfusion => _antiguosInfusion;

  void setAntiguosInfusion(Map<String, dynamic> _infusion) {
    _antiguosInfusion.add(_infusion);
    // print('ESTA ES LA Parametro  =====>$_nuevoMedicamento');

    notifyListeners();
  }

  //================================== CREA HOSPITALIZACION  ==============================//
  Future creaHospitalizacion(
    BuildContext context,
  ) async {
    final serviceSocket = context.read<SocketService>();
    final infoUser = await Auth.instance.getSession();
    //ELIMINAMOS LAS PROPIEDADES QUE NO QUEREMOS DE CABECERA MEDICINA
    for (var m in _nuevoMedicamento) {
      m.removeWhere((key, value) => key == "idCabecera");
    }
    //ELIMINAMOS LAS PROPIEDADES QUE NO QUEREMOS DE HORARIO MEDICINA
    for (var mH in _nuevoHorarioMedicamento) {
      mH.removeWhere((key, value) => key == "idCabecera");
      mH.removeWhere((key, value) => key == "_inicio");
      mH.removeWhere((key, value) => key == "_frecuencia");
      mH.removeWhere((key, value) => key == "idMedicamento");
    }

    //ELIMINAMOS LAS PROPIEDADES QUE NO QUEREMOS DE CABECERA ALIMENTO
    for (var a in _nuevoAlimento) {
      a.removeWhere((key, value) => key == "idCabeceraAlimento");
    }
    //ELIMINAMOS LAS PROPIEDADES QUE NO QUEREMOS DE HORARIO ALIMENTOS
    for (var aH in _nuevoHorarioAlimeno) {
      // aH.removeWhere((key, value) => key == "idCabecera");
      aH.removeWhere((key, value) => key == "_inicio");
      aH.removeWhere((key, value) => key == "_frecuencia");
      aH.removeWhere((key, value) => key == "idCabeceraAlimento");
      aH.removeWhere((key, value) => key == "idHorarioAlimento");
    }

    //ELIMINAMOS LAS PROPIEDADES QUE NO QUEREMOS DE CABECERA FLUIDO
    for (var flu in _nuevoFluido) {
      flu.removeWhere((key, value) => key == "idFluido");
    }

    //ELIMINAMOS LAS PROPIEDADES QUE NO QUEREMOS DE CABECERA INFUSION
    for (var infu in _nuevoInfusion) {
      infu.removeWhere((key, value) => key == "idInfusion");
    }

    //ELIMINAMOS LAS PROPIEDADES QUE NO QUEREMOS DE CABECERA PARAMETRO
    for (var p in _nuevoParametro) {
      p.removeWhere((key, value) => key == "idCabeceraParametro");
    }
    //ELIMINAMOS LAS PROPIEDADES QUE NO QUEREMOS DE HORARIO ALIMENTOS
    for (var pH in _nuevoHorarioParametro) {
      // aH.removeWhere((key, value) => key == "idCabecera");
      pH.removeWhere((key, value) => key == "_inicio");
      pH.removeWhere((key, value) => key == "_frecuencia");
      pH.removeWhere((key, value) => key == "idCabeceraParametro");
      pH.removeWhere((key, value) => key == "idHorarioParametro");
    }

    final _pyloadNuevaHospitalizacion = {
      "tabla": "hospitalizacion",
      "rucempresa": infoUser!.rucempresa, // LOGIN
      "rol": infoUser.rol, //LOGIN

      "hospId": "",
      "hospMascId": _idMascota,
      "hospMascNombre": _nombreMascota,
      "hospMascPeso": _pesoMascota,
      "hospMascRaza": _razaMascota,
      "hospMascSexo": _sexoMascota,
      "hospMascEdad": _edadMascota,
      "hospPerIdPropietario": _personaId,
      "hospPerNombrePropietario": _personaNombre,
      "hospPerDocNumeroPropietario": _personaDoc,
      "hospPerTelefonoPropietario": _personaTelefono,
      "hospPerCelularPropietario": _personaListCelular,
      "hospPerDireccionPropietario": _personaDireccion,
      "hospPerEmailPropietario": _personaListCorreo,
      "hospPerIdDoc": _vetDoctorId,
      "hospPerNombreDoc": _vetDoctorNombre,
      "hospPerIdDocSecundario": _vetDoctorSecundarioId,
      "hospPerNombreSecundario": _vetDoctorSecundarioNombre,
      "hospPerIdDocNocturno": _vetDoctorNocturnoId,
      "hospPerNombreNocturno": _vetDoctorNocturnoNombre,
      "hospEstado": _estadoMascota,
      "hospCondicion": _condicionesMascota,
      "hospDiagnostico": _diagnostico,
      "hospObservacion": _observacion,
      "hospExaComplementario": _examenesComplementarios,
      "hospMedicamentos": {
        "medicamentosCabecera": _nuevoMedicamento,
        "medicamentosHorario": _nuevoHorarioMedicamento,
      },
      "hospAlimentos": {
        "alimentosCabecera": _nuevoAlimento,
        "alimentosHorario": _nuevoHorarioAlimeno,
      },

      "hospFluidos": {"fluidosCabecera": _nuevoFluido},

      "hospInfusion": {"infusionCabecera": _nuevoInfusion},

      "hospParametros": {
        "parametrosCabecera": _nuevoParametro,
        "parametrosHorario": _nuevoHorarioParametro,
      },

      "hospUser": infoUser.usuario,
      "hospEmpresa": infoUser.rucempresa,
      "hospFecReg": "",
      "Todos": "",
    };

    // print(
    //     '==========================JSON PARA CREAR NUEVA HOSPITALIZACION ===============================');
    // print(_pyloadNuevaHospitalizacion);
    // print(
    //     '==========================JSON PARA CREAR NUEVA HOSPITALIZACION ===============================');
    // print('FLUIDOS: $_listFluidos');
    // print('INFUSION: $_listInfusions');
    // print(
    //     '==========================SOCKET RECETA ===============================');
    serviceSocket.socket!
        .emit('client:guardarData', _pyloadNuevaHospitalizacion);
  }

  //================================== EDITAR HOSPITALIZACION  ==============================//
  Future editaHospitalizacion(BuildContext context) async {
    final serviceSocket = context.read<SocketService>();
    final infoUser = await Auth.instance.getSession();
    //ELIMINAMOS LAS PROPIEDADES QUE NO QUEREMOS DE CABECERA MEDICINA
    for (var m in _nuevoMedicamento) {
      m.removeWhere((key, value) => key == "idCabecera");
    }
    //ELIMINAMOS LAS PROPIEDADES QUE NO QUEREMOS DE HORARIO MEDICINA
    for (var mH in _nuevoHorarioMedicamento) {
      mH.removeWhere((key, value) => key == "idCabecera");
      mH.removeWhere((key, value) => key == "_inicio");
      mH.removeWhere((key, value) => key == "_frecuencia");
      mH.removeWhere((key, value) => key == "idMedicamento");
    }

    //ELIMINAMOS LAS PROPIEDADES QUE NO QUEREMOS DE CABECERA ALIMENTO
    for (var a in _nuevoAlimento) {
      a.removeWhere((key, value) => key == "idCabeceraAlimento");
    }
    //ELIMINAMOS LAS PROPIEDADES QUE NO QUEREMOS DE HORARIO ALIMENTOS
    for (var aH in _nuevoHorarioAlimeno) {
      // aH.removeWhere((key, value) => key == "idCabecera");
      aH.removeWhere((key, value) => key == "_inicio");
      aH.removeWhere((key, value) => key == "_frecuencia");
      aH.removeWhere((key, value) => key == "idCabeceraAlimento");
      aH.removeWhere((key, value) => key == "idHorarioAlimento");
    }

    //ELIMINAMOS LAS PROPIEDADES QUE NO QUEREMOS DE CABECERA FLUIDO
    for (var flu in _nuevoFluido) {
      flu.removeWhere((key, value) => key == "idFluido");
    }

    //ELIMINAMOS LAS PROPIEDADES QUE NO QUEREMOS DE CABECERA INFUSION
    for (var infu in _nuevoInfusion) {
      infu.removeWhere((key, value) => key == "idInfusion");
    }

    //ELIMINAMOS LAS PROPIEDADES QUE NO QUEREMOS DE CABECERA PARAMETRO
    for (var p in _nuevoParametro) {
      p.removeWhere((key, value) => key == "idCabeceraParametro");
    }
    //ELIMINAMOS LAS PROPIEDADES QUE NO QUEREMOS DE HORARIO ALIMENTOS
    for (var pH in _nuevoHorarioParametro) {
      // aH.removeWhere((key, value) => key == "idCabecera");
      pH.removeWhere((key, value) => key == "_inicio");
      pH.removeWhere((key, value) => key == "_frecuencia");
      pH.removeWhere((key, value) => key == "idCabeceraParametro");
      pH.removeWhere((key, value) => key == "idHorarioParametro");
    }

    final _pyloadEditaHospitalizacion = {
      "tabla": "hospitalizacion",
      "rucempresa": infoUser!.rucempresa, // LOGIN
      "rol": infoUser.rol, //LOGIN

      "hospId": getIdHosp,
      "hospMascId": _idMascota,
      "hospMascNombre": _nombreMascota,
      "hospMascPeso": _pesoMascota,
      "hospMascRaza": _razaMascota,
      "hospMascSexo": _sexoMascota,
      "hospMascEdad": _edadMascota,
      "hospPerIdPropietario": _personaId,
      "hospPerNombrePropietario": _personaNombre,
      "hospPerDocNumeroPropietario": _personaDoc,
      "hospPerTelefonoPropietario": _personaTelefono,
      "hospPerCelularPropietario": _personaListCelular,
      "hospPerDireccionPropietario": _personaDireccion,
      "hospPerEmailPropietario": _personaListCorreo,
      "hospPerIdDoc": _vetDoctorId,
      "hospPerNombreDoc": _vetDoctorNombre,
      "hospPerIdDocSecundario": _vetDoctorSecundarioId,
      "hospPerNombreSecundario": _vetDoctorSecundarioNombre,
      "hospPerIdDocNocturno": _vetDoctorNocturnoId,
      "hospPerNombreNocturno": _vetDoctorNocturnoNombre,
      "hospEstado": _estadoMascota,
      "hospCondicion": _condicionesMascota,
      "hospDiagnostico": _diagnostico,
      "hospObservacion": _observacion,
      "hospExaComplementario": _examenesComplementarios,
      "hospMedicamentos": {
        "medicamentosCabecera": _nuevoMedicamento,
        "medicamentosHorario": _nuevoHorarioMedicamento,
      },
      "hospAlimentos": {
        "alimentosCabecera": _nuevoAlimento,
        "alimentosHorario": _nuevoHorarioAlimeno,
      },

      "hospFluidos": {"fluidosCabecera": _nuevoFluido},

      "hospInfusion": {"infusionCabecera": _nuevoInfusion},

      "hospParametros": {
        "parametrosCabecera": _nuevoParametro,
        "parametrosHorario": _nuevoHorarioParametro,
      },

      "hospUser": "$_userData ** ${infoUser.usuario}",
      "hospEmpresa": infoUser.rucempresa,
      "hospFecReg": "",
      "Todos": "",
    };

    // print(
    //     '==========================JSON PARA CREAR NUEVA HOSPITALIZACION ===============================');
    // print(_pyloadEditaHospitalizacion);
    // print(
    //     '==========================JSON PARA CREAR NUEVA HOSPITALIZACION ===============================');
    // print('CABECERA ALIMENTO: $_nuevoAlimento');
    // print('HORARIO ALIMENTO: $_nuevoHorarioAlimeno');

    // print(
    //     '==========================SOCKET RECETA ===============================');
    serviceSocket.socket!
        .emit('client:actualizarData', _pyloadEditaHospitalizacion);
  }

//=================================ALIMENTOS======================================//

  void getInfoRowAlimento(int _idItem) {
    _alimentoNew = {
      "idCabeceraAlimento": _idItem,
      "order": "",
      "alimento": getNombreAlimento,
      "dosis": getDosisAlimento,
      "cantidad": getCantidadAlimento,
      "inicio": getInicioAlimento,
      "frecuencia": getFrecuenciaAlimento,
    };
    eliminaAlimentoAgregada(_idItem);
    setNuevoAlimento(_alimentoNew);
    // print('ESTE MEDICAMENTO ===***** ==>$_medicamentoNew');
    eliminaHorarioAlimentoAgregada(_idItem);
    resetHoraAlimento();
    addHorarioAlimento(
      _idItem,
      getNombreAlimento,
      getInicioAlimento,
      getFrecuenciaAlimento,
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
    );
  }

//=========GUARDA HORA==============//
  void setHorarioAlimento(
    int _idItem,
    String _nomAlimento,
    String _inicioAlimento,
    String _frecuenciaAlimento,
    String _orderAlimento,
  ) {
    eliminaHorarioAlimentoAgregada(_idItem);
    addHorarioAlimento(
      _idItem,
      _nomAlimento,
      _inicioAlimento,
      _frecuenciaAlimento,
      getH0Alimento,
      getH1Alimento,
      getH2Alimento,
      getH3Alimento,
      getH4Alimento,
      getH5Alimento,
      getH6Alimento,
      getH7Alimento,
      getH8Alimento,
      getH9Alimento,
      getH10Alimento,
      getH11Alimento,
      getH12Alimento,
      getH13Alimento,
      getH14Alimento,
      getH15Alimento,
      getH16Alimento,
      getH17Alimento,
      getH18Alimento,
      getH19Alimento,
      getH20Alimento,
      getH21Alimento,
      getH22Alimento,
      getH23Alimento,
      _orderAlimento,
    );
    notifyListeners();
  }

//=========GUARDA HORA==============//
  void setHorarioParametro(
    int _idItem,
    String _nomParametro,
    String _inicioParametro,
    String _frecuenciaParametro,
    String _orderParametro,
  ) {
    eliminaHorarioParametroAgregada(_idItem);
    addHorarioParametro(
      _idItem,
      _nomParametro,
      _inicioParametro,
      _frecuenciaParametro,
      getH0Parametro,
      getH1Parametro,
      getH2Parametro,
      getH3Parametro,
      getH4Parametro,
      getH5Parametro,
      getH6Parametro,
      getH7Parametro,
      getH8Parametro,
      getH9Parametro,
      getH10Parametro,
      getH11Parametro,
      getH12Parametro,
      getH13Parametro,
      getH14Parametro,
      getH15Parametro,
      getH16Parametro,
      getH17Parametro,
      getH18Parametro,
      getH19Parametro,
      getH20Parametro,
      getH21Parametro,
      getH22Parametro,
      getH23Parametro,
      _orderParametro,
    );
    notifyListeners();
  }

//=================================ALIMENTOS======================================//

  void getInfoRowParametro(int _idItem) {
    _parametroNew = {
      "idCabeceraParametro": _idItem,
      "order": "",
      "parametro": getNombreParametro,
      "dosis": getDosisParametro,
      // "cantidad": getCantidadParametro,
      "inicio": getInicioParametro,
      "frecuencia": getFrecuenciaParametro,
    };

    eliminaParametroAgregada(_idItem);
    setNuevoParametro(_parametroNew);
    // print('ESTE MEDICAMENTO ===***** ==>$_medicamentoNew');
    eliminaHorarioParametroAgregada(_idItem);
    resetHoraParametros();
    addHorarioParametro(
      _idItem,
      getNombreParametro,
      getInicioParametro,
      getFrecuenciaParametro,
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
    );
  }

//================================================================================//

//====GET INFO DETALLE MASCOTA===//
  dynamic _getInfoHospitalizacion;
  dynamic get getInfohospitalizacion => _getInfoHospitalizacion;

  int? _idHosp;
  int? get getIdHosp => _idHosp;
  void getIdHospitalizacion(int? _idHospit) {
    _idHosp = _idHospit;
    // print('ESTA ES LA INFO _idHosp: ${_idHosp} ');
  }
//  int? get getIdHospitalizacion=>_idHosp;



 String? _userData='';

  void getInfoHospitalizacion(dynamic _data) async {
    _getInfoHospitalizacion = _data;



    _userData=_data['hospUser'];
    _idMascota = int.parse(_data['hospMascId']);
    setNombreMascota(_data['hospMascNombre']);
    setRazaMascota(_data['hospMascRaza']);
    setSexoMascota(_data['hospMascSexo']);
    setEdadMascota(_data['hospMascEdad']);

    setPesoMascota(_data['hospMascPeso']);
    setEstadoMascota(_data['hospEstado']);

    _personaId = _data['hospPerIdPropietario'].toString();
    _personaDoc = _data['hospPerDocNumeroPropietario'].toString();
    _personaNombre = _data['hospPerNombrePropietario'];
    _personaTelefono = _data['hospPerTelefonoPropietario'].toString();

    for (var itemCelu in _data['hospPerCelularPropietario']) {
      _personaListCelular.add(itemCelu);
    }
    _personaDireccion = _data['hospPerDireccionPropietario'].toString();
    for (var itemEmail in _data['hospPerEmailPropietario']) {
      _personaListCorreo.add(itemEmail);
    }

    setVetDoctorId(_data['hospPerIdDoc'].toString());
    setVetDoctorNombre(_data['hospPerNombreDoc']);

    setVetDoctorSecundarioId(_data['hospPerIdDocSecundario']);
    setVetDoctorSecundarioNombre(_data['hospPerNombreSecundario']);

    setVetDoctorNocturnoId(_data['hospPerIdDocNocturno']);
    setVetDoctorNocturnoNombre(_data['hospPerNombreNocturno']);
    setCondicionesMascota(_data['hospCondicion']);
    setDiagnostico(_data['hospDiagnostico']);
    setObservacacion(_data['hospObservacion']);
    setExamenesComplementarios(_data['hospExaComplementario']);

//************************** MEDICAMENTOS *****************************/
    if (_data['hospMedicamentos']['medicamentosCabecera'].isEmpty) {
      _nuevoMedicamento = [];
      _nuevoHorarioMedicamento = [];
    } else {
      for (var i = 0;
          i < _data['hospMedicamentos']['medicamentosCabecera'].length;
          i++) {
        _medicamentoNew = {
          "idCabecera": i,
          "order": _data['hospMedicamentos']['medicamentosCabecera'][i]
              ['order'],
          "medicina": _data['hospMedicamentos']['medicamentosCabecera'][i]
              ['medicina'],
          "dosis": _data['hospMedicamentos']['medicamentosCabecera'][i]
              ['dosis'],
          "cantidad": _data['hospMedicamentos']['medicamentosCabecera'][i]
              ['cantidad'],
          "via": _data['hospMedicamentos']['medicamentosCabecera'][i]['via'],
          "inicio": _data['hospMedicamentos']['medicamentosCabecera'][i]
              ['inicio'],
          "frecuencia": _data['hospMedicamentos']['medicamentosCabecera'][i]
              ['frecuencia'],
        };
        setNuevoMedicamento(_medicamentoNew);
        _medicamentoHorarioNew = {
          "idCabecera": i,
          "_inicio": _data['hospMedicamentos']['medicamentosCabecera'][i]
              ['inicio'],
          "_frecuencia": _data['hospMedicamentos']['medicamentosCabecera'][i]
              ['frecuencia'],
          "idMedicamento": idItemHorario,
          "fecha": _data['hospMedicamentos']['medicamentosHorario'][i]['fecha'],
          "nameMedicinaHorarios": _data['hospMedicamentos']
              ['medicamentosHorario'][i]['nameMedicinaHorarios'],
          "H0": _data['hospMedicamentos']['medicamentosHorario'][i]['H0'] ??
              '===',
          "H1": _data['hospMedicamentos']['medicamentosHorario'][i]['H1'] ??
              '===',
          "H2": _data['hospMedicamentos']['medicamentosHorario'][i]['H2'] ??
              '===',
          "H3": _data['hospMedicamentos']['medicamentosHorario'][i]['H3'] ??
              '===',
          "H4": _data['hospMedicamentos']['medicamentosHorario'][i]['H4'] ??
              '===',
          "H5": _data['hospMedicamentos']['medicamentosHorario'][i]['H5'] ??
              '===',
          "H6": _data['hospMedicamentos']['medicamentosHorario'][i]['H6'] ??
              '===',
          "H7": _data['hospMedicamentos']['medicamentosHorario'][i]['H7'] ??
              '===',
          "H8": _data['hospMedicamentos']['medicamentosHorario'][i]['H8'] ??
              '===',
          "H9": _data['hospMedicamentos']['medicamentosHorario'][i]['H9'] ??
              '===',
          "H10": _data['hospMedicamentos']['medicamentosHorario'][i]['H10'] ??
              '===',
          "H11": _data['hospMedicamentos']['medicamentosHorario'][i]['H11'] ??
              '===',
          "H12": _data['hospMedicamentos']['medicamentosHorario'][i]['H12'] ??
              '===',
          "H13": _data['hospMedicamentos']['medicamentosHorario'][i]['H13'] ??
              '===',
          "H14": _data['hospMedicamentos']['medicamentosHorario'][i]['H14'] ??
              '===',
          "H15": _data['hospMedicamentos']['medicamentosHorario'][i]['H15'] ??
              '===',
          "H16": _data['hospMedicamentos']['medicamentosHorario'][i]['H16'] ??
              '===',
          "H17": _data['hospMedicamentos']['medicamentosHorario'][i]['H17'] ??
              '===',
          "H18": _data['hospMedicamentos']['medicamentosHorario'][i]['H18'] ??
              '===',
          "H19": _data['hospMedicamentos']['medicamentosHorario'][i]['H19'] ??
              '===',
          "H20": _data['hospMedicamentos']['medicamentosHorario'][i]['H20'] ??
              '===',
          "H21": _data['hospMedicamentos']['medicamentosHorario'][i]['H21'] ??
              '===',
          "H22": _data['hospMedicamentos']['medicamentosHorario'][i]['H22'] ??
              '===',
          "H23": _data['hospMedicamentos']['medicamentosHorario'][i]['H23'] ??
              '===',
          "order": _data['hospMedicamentos']['medicamentosHorario'][i]
                  ['order'] ??
              '===',
        };
        //  print('ESTE HORARIO ===***** ==>$_medicamentoHorarioNew');
        setNuevoHorarioMedicamento(_medicamentoHorarioNew);

        idItem = i + 1;
        idItemHorario = i + 1;
      }
    }

//*******************************************************/

//************************** ALIMENTOS *****************************/

    if (_data['hospAlimentos']['alimentosCabecera'].isEmpty) {
      _nuevoAlimento = [];
      _nuevoHorarioAlimeno = [];
    } else {
      for (var j = 0;
          j < _data['hospAlimentos']['alimentosCabecera'].length;
          j++) {
        _alimentoNew = {
          "idCabeceraAlimento": j,
          "order": _data['hospAlimentos']['alimentosCabecera'][j]['order'],
          "alimento": _data['hospAlimentos']['alimentosCabecera'][j]
              ['alimento'],
          "dosis": _data['hospAlimentos']['alimentosCabecera'][j]['dosis'],
          "cantidad": _data['hospAlimentos']['alimentosCabecera'][j]
              ['cantidad'],
          "inicio": _data['hospAlimentos']['alimentosCabecera'][j]['inicio'],
          "frecuencia": _data['hospAlimentos']['alimentosCabecera'][j]
              ['frecuencia'],
        };
        setNuevoAlimento(_alimentoNew);

        _alimentoHorarioNew = {
          "idCabeceraAlimento": j,
          "_inicio": _data['hospAlimentos']['alimentosCabecera'][j]['inicio'],
          "_frecuencia": _data['hospAlimentos']['alimentosCabecera'][j]
              ['frecuencia'],
          "idHorarioAlimento": idItemHorarioAliemto,
          "fecha": _data['hospAlimentos']['alimentosHorario'][j]['fecha'],
          "nameAlimentosHorarios": _data['hospAlimentos']['alimentosHorario'][j]
              ['nameAlimentosHorarios'],
          "H0": _data['hospAlimentos']['alimentosHorario'][j]["H0"] ?? '===',
          "H1": _data['hospAlimentos']['alimentosHorario'][j]["H1"] ?? '===',
          "H2": _data['hospAlimentos']['alimentosHorario'][j]["H2"] ?? '===',
          "H3": _data['hospAlimentos']['alimentosHorario'][j]["H3"] ?? '===',
          "H4": _data['hospAlimentos']['alimentosHorario'][j]["H4"] ?? '===',
          "H5": _data['hospAlimentos']['alimentosHorario'][j]["H5"] ?? '===',
          "H6": _data['hospAlimentos']['alimentosHorario'][j]["H6"] ?? '===',
          "H7": _data['hospAlimentos']['alimentosHorario'][j]["H7"] ?? '===',
          "H8": _data['hospAlimentos']['alimentosHorario'][j]["H8"] ?? '===',
          "H9": _data['hospAlimentos']['alimentosHorario'][j]["H9"] ?? '===',
          "H10": _data['hospAlimentos']['alimentosHorario'][j]["H10"] ?? '===',
          "H11": _data['hospAlimentos']['alimentosHorario'][j]["H11"] ?? '===',
          "H12": _data['hospAlimentos']['alimentosHorario'][j]["H12"] ?? '===',
          "H13": _data['hospAlimentos']['alimentosHorario'][j]["H13"] ?? '===',
          "H14": _data['hospAlimentos']['alimentosHorario'][j]["H14"] ?? '===',
          "H15": _data['hospAlimentos']['alimentosHorario'][j]["H15"] ?? '===',
          "H16": _data['hospAlimentos']['alimentosHorario'][j]["H16"] ?? '===',
          "H17": _data['hospAlimentos']['alimentosHorario'][j]["H17"] ?? '===',
          "H18": _data['hospAlimentos']['alimentosHorario'][j]["H18"] ?? '===',
          "H19": _data['hospAlimentos']['alimentosHorario'][j]["H19"] ?? '===',
          "H20": _data['hospAlimentos']['alimentosHorario'][j]["H20"] ?? '===',
          "H21": _data['hospAlimentos']['alimentosHorario'][j]["H21"] ?? '===',
          "H22": _data['hospAlimentos']['alimentosHorario'][j]["H22"] ?? '===',
          "H23": _data['hospAlimentos']['alimentosHorario'][j]["H23"] ?? '===',
          "order":
              _data['hospAlimentos']['alimentosHorario'][j]['order'] ?? '===',
        };
        setNuevoHorarioAlimeno(_alimentoHorarioNew);

        idItemAlimento = j + 1;
        idItemHorarioAliemto = j + 1;
      }
    }

//*******************************************************/
//************************** FLUIDOS *****************************/

    if (_data['hospFluidos']['fluidosCabecera'].isEmpty) {
      _nuevoFluido = [];
    } else {
      for (var k = 0; k < _data['hospFluidos']['fluidosCabecera'].length; k++) {
        _fluidoNew = {
          "idFluido": k,
          "order": _data['hospFluidos']['fluidosCabecera'][k]['order'] ?? '===',
          "fluido":
              _data['hospFluidos']['fluidosCabecera'][k]['fluido'] ?? '===',
          "dosis": _data['hospFluidos']['fluidosCabecera'][k]['dosis'] ?? '===',
          "cantidad":
              _data['hospFluidos']['fluidosCabecera'][k]['cantidad'] ?? '===',
          "inicio":
              _data['hospFluidos']['fluidosCabecera'][k]['inicio'] ?? '===',
        };

        setNuevoFluido(_fluidoNew);

        idItemFluido = k + 1;
      }
    }

//*******************************************************/
//************************** INFUSION *****************************/
    if (_data['hospInfusion']['infusionCabecera'].isEmpty) {
      _nuevoInfusion = [];
    } else {
      for (var m = 0;
          m < _data['hospInfusion']['infusionCabecera'].length;
          m++) {
        _infusionNew = {
          "idInfusion": m,
          "order":
              _data['hospInfusion']['infusionCabecera'][m]['order'] ?? '===',
          "infusion":
              _data['hospInfusion']['infusionCabecera'][m]['infusion'] ?? '===',
          "dosis":
              _data['hospInfusion']['infusionCabecera'][m]['dosis'] ?? '===',
          "unidad":
              _data['hospInfusion']['infusionCabecera'][m]['unidad'] ?? '===',
        };
        setNuevoInfusion(_infusionNew);

        // print('ESTE MEDICAMENTO ===***** ==>$_listInfusions');
        idItemInfusion = m + 1;
      }
    }
//*******************************************************/

//************************** PARAMETROS *****************************/

    if (_data['hospParametros']['parametrosCabecera'].isEmpty) {
      _nuevoParametro = [];
      _nuevoHorarioParametro = [];
    } else {
      for (var xx = 0;
          xx < _data['hospParametros']['parametrosCabecera'].length;
          xx++) {
        _parametroNew = {
          "idCabeceraParametro": xx,
          "order": _data['hospParametros']['parametrosCabecera'][xx]['order'],
          "parametro": _data['hospParametros']['parametrosCabecera'][xx]
              ['parametro'],
          "dosis": _data['hospParametros']['parametrosCabecera'][xx]['dosis'],
          "inicio": _data['hospParametros']['parametrosCabecera'][xx]['inicio'],
          "frecuencia": _data['hospParametros']['parametrosCabecera'][xx]
              ['frecuencia'],
        };
        setNuevoParametro(_parametroNew);

        _parametroHorarioNew = {
          "idCabeceraParametro": xx,
          "_inicio": _data['hospParametros']['parametrosCabecera'][xx]
              ['inicio'],
          "_frecuencia": _data['hospParametros']['parametrosCabecera'][xx]
              ['frecuencia'],
          "idHorarioParametro": idItemHorarioParametro,
          "fecha": _data['hospParametros']['parametrosHorario'][xx]['fecha'],
          "nameParametrosHorarios": _data['hospParametros']['parametrosHorario']
              [xx]['nameParametrosHorarios'],
          "H0": _data['hospParametros']['parametrosHorario'][xx]["H0"] ?? '===',
          "H1": _data['hospParametros']['parametrosHorario'][xx]["H1"] ?? '===',
          "H2": _data['hospParametros']['parametrosHorario'][xx]["H2"] ?? '===',
          "H3": _data['hospParametros']['parametrosHorario'][xx]["H3"] ?? '===',
          "H4": _data['hospParametros']['parametrosHorario'][xx]["H4"] ?? '===',
          "H5": _data['hospParametros']['parametrosHorario'][xx]["H5"] ?? '===',
          "H6": _data['hospParametros']['parametrosHorario'][xx]["H6"] ?? '===',
          "H7": _data['hospParametros']['parametrosHorario'][xx]["H7"] ?? '===',
          "H8": _data['hospParametros']['parametrosHorario'][xx]["H8"] ?? '===',
          "H9": _data['hospParametros']['parametrosHorario'][xx]["H9"] ?? '===',
          "H10":
              _data['hospParametros']['parametrosHorario'][xx]["H10"] ?? '===',
          "H11":
              _data['hospParametros']['parametrosHorario'][xx]["H11"] ?? '===',
          "H12":
              _data['hospParametros']['parametrosHorario'][xx]["H12"] ?? '===',
          "H13":
              _data['hospParametros']['parametrosHorario'][xx]["H13"] ?? '===',
          "H14":
              _data['hospParametros']['parametrosHorario'][xx]["H14"] ?? '===',
          "H15":
              _data['hospParametros']['parametrosHorario'][xx]["H15"] ?? '===',
          "H16":
              _data['hospParametros']['parametrosHorario'][xx]["H16"] ?? '===',
          "H17":
              _data['hospParametros']['parametrosHorario'][xx]["H17"] ?? '===',
          "H18":
              _data['hospParametros']['parametrosHorario'][xx]["H18"] ?? '===',
          "H19":
              _data['hospParametros']['parametrosHorario'][xx]["H19"] ?? '===',
          "H20":
              _data['hospParametros']['parametrosHorario'][xx]["H20"] ?? '===',
          "H21":
              _data['hospParametros']['parametrosHorario'][xx]["H21"] ?? '===',
          "H22":
              _data['hospParametros']['parametrosHorario'][xx]["H22"] ?? '===',
          "H23":
              _data['hospParametros']['parametrosHorario'][xx]["H23"] ?? '===',
          "order": _data['hospParametros']['parametrosHorario'][xx]['order'] ??
              '===',
        };
        setNuevoHorarioParametro(_parametroHorarioNew);

        idItemParametro = xx + 1;

        idItemHorarioParametro = xx + 1;
      }
    }

//*******************************************************/

    notifyListeners();
  }

  //================================== ELIMINAR  PRIPIETARIO  ==============================//
  Future eliminaHospitalizacion(BuildContext context, int? idHosp) async {
    final serviceSocket = context.read<SocketService>();
    final infoUser = await Auth.instance.getSession();

    final _pyloadEliminaHospitalizacion = {
      "tabla": 'hospitalizacion',
      "rucempresa": infoUser!.rucempresa,
      "rol": infoUser.rol,
      "hospId": idHosp,
    };

    serviceSocket.socket!
        .emit('client:eliminarData', _pyloadEliminaHospitalizacion);
  }

//=================================================================================================================//
  // ================= VARIABLES DE PAGINACION ====================//
//=================================================================================================================//
//===================BOTON SEARCH PAGINACION ==========================//

  bool _btnSearchHospitalizacioinesPaginacion = false;
  bool get btnSearchHospitalizacioinesPaginacion => _btnSearchHospitalizacioinesPaginacion;

  void setBtnSearchHospitalizacionPaginacion(bool action) {
    _btnSearchHospitalizacioinesPaginacion = action;
    //  print('==_btnSearchCoros===> $_btnSearchPropietarios');
    notifyListeners();
  }

  //===================INPUT SEARCH PROPIETARIO==========================//
  String _nameSearchHospitalizacionPaginacion = "";
  String get nameSearchHospitalizacionPaginacion => _nameSearchHospitalizacionPaginacion;

  void onSearchTextHospitalizacionPaginacion(String data) {
    _nameSearchHospitalizacionPaginacion = data;
    // print('MASCOTNOMBRE:${_nameSearchHospitalizacionPaginacion}');
  }
//=============================================================================//

  List _listaHospitalizacioinesPaginacion = [];
  // List<TipoMulta> get getListaTodosLosTiposDeMultas => _listaTodosLosTiposDeMultas;
  List get getListaHospitalizacioinesPaginacion => _listaHospitalizacioinesPaginacion;

  void setInfoBusquedaHospitalizacioinesPaginacion(List data) {
    _listaHospitalizacioinesPaginacion.addAll(data);
    // print('Hospitalizacions :${_listaHospitalizacioinesPaginacion.length}');

    // for (var item in _listaHospitalizacioinesPaginacion) {
    //    print('-->:${item['perId']}');
    // }

    notifyListeners();
  }

  bool? _errorHospitalizacioinesPaginacion; // sera nulo la primera vez
  bool? get getErrorHospitalizacioinesPaginacion => _errorHospitalizacioinesPaginacion;
  void setErrorHospitalizacioinesPaginacion(bool? value) {
    _errorHospitalizacioinesPaginacion = value;
    notifyListeners();
  }

  bool? _error401HospitalizacioinesPaginacion = false; // sera nulo la primera vez
  bool? get getError401HospitalizacioinesPaginacion => _error401HospitalizacioinesPaginacion;
  void setError401HospitalizacioinesPaginacion(bool? value) {
    _error401HospitalizacioinesPaginacion = value;
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

  Future buscaAllHospitalizacioinesPaginacion(String? _search, bool _isSearch) async {
    final dataUser = await Auth.instance.getSession();
// print('usuario : ${dataUser!.rucempresa}');
    final response = await _api.getAllHospitalizacionesPaginacion(
      search: _search,
      page: _page,
      cantidad: _cantidad,
      input: 'hospId',
      orden: false,
      idmascota: null,
      token: '${dataUser!.token}',
    );

    if (response != null) {
      if (response == 401) {
        setInfoBusquedaHospitalizacioinesPaginacion([]);
        _error401HospitalizacioinesPaginacion = true;
        notifyListeners();
        return response;
      } else {
        _errorHospitalizacioinesPaginacion = true;
        if (_isSearch == true) {
          _listaHospitalizacioinesPaginacion = [];
        }
        List<dynamic> dataSort = response['data']['results'];
        dataSort.sort((a, b) => b['hospFecReg']!.compareTo(a['hospFecReg']!));

        setPage(response['data']['pagination']['next']);

        setInfoBusquedaHospitalizacioinesPaginacion(dataSort);
        notifyListeners();
        return response;
      }

      //===========================================//

    }
    if (response == null) {
      _errorHospitalizacioinesPaginacion = false;
      notifyListeners();
      return null;
    }
  }



  
}

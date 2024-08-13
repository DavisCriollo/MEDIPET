import 'dart:async';

import 'package:flutter/material.dart';
import 'package:neitorcont/src/api/api_provider.dart';
import 'package:neitorcont/src/api/authentication_client.dart';
import 'package:neitorcont/src/models/auth_response.dart';
import 'package:neitorcont/src/pages/crear_peluqueria.dart';
import 'package:neitorcont/src/services/socket_service.dart';
import 'package:provider/provider.dart';

class PeluqueriaController extends ChangeNotifier {
  final _api = ApiProvider();
  GlobalKey<FormState> peluqueriaFormKey = GlobalKey<FormState>();

  AuthResponse? usuarios;
  bool validateForm() {
    if (peluqueriaFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

//  ================= RESET ==================//
  void resetFormPeluqueria() {
    _nombreMascota = '';
    _temperamentoMascota = '';
    _observacionIngresoMascota = '';
    _estadoCabello = '';
    _autorizadoPor = '';
    _estadoCabello = '';
    _inputHoraIngreso = '';
    _inputHoraSalida = '';
    _inputHoraProximaCita = '';
    _turno;
    _vetDoctorId = '';
    _vetDoctorNombre = '';
    _pedidoCara = '';
    _pedidoCopete = '';
    _pedidoBigotes = '';
    _pedidoCejas = '';
    _pedidoSoloLomo = '';
    _pedidoCola = '';
    _pedidoManosYPatas = '';
    _pedidoFormaDeLaCabeza = '';
    _pedidoOrejas = '';
    _pedidoBigotesForma = '';
    _pedidoTodoElCuerpo = '';
    _pedidoFaldonPechoPatitas = '';
    _pedidoColaForma = '';
    _procesoLlamar = 'NO';
    _procesoOidos = 'NO';
    _lavadoDientes = 'NO';
    _uniasDedos = 'NO';
    _drenaje = 'NO';
    _secado = 'NO';
    _perfume = 'NO';
    _limpiezaOcular = 'NO';
    _corteUnias = 'NO';
    _rapadoGenital = 'NO';
    _banio = 'NO';
    _corteYAcabados = 'NO';
    _declaro = 'NO';
    _otrosProcesos = '';
    _retiraMascota = 'NO';
    _dejaAcesorios = '';
    _inputFechaProximaCita = "";
    _inputHoraProximaCita = "";
    _personaID = "";
    _personaDoc = "";
    _personaNombre = "";
    _personaTelefono = "";
    _personaListCelular = [];
    _personaDireccion = "";
    _personaListCorreo = [];
    _fecha ='${DateTime.now().year}-${(DateTime.now().month) < 10 ? '0${DateTime.now().month}' : '${DateTime.now().month}'}-${(DateTime.now().day) < 10 ? '0${DateTime.now().day}' : '${DateTime.now().day}'}';
     _page = 0;
    _cantidad = 25;
    //  _listaPeluqueriasPaginacion=[];
    _next = '';
    _isNext = false;


  }
//  =================  CREO DEBOUNCE  PARA BUSQUEDAS ==================//

  Timer? _deboucerSearchPeluqueria;
  // Timer? _deboucerSearchBuscaPersona;

  @override
  void dispose() {
    _deboucerSearchPeluqueria?.cancel();
    // _deboucerSearchBuscaPersona?.cancel();

    // _videoController.dispose();
    super.dispose();
  }

//===================BOTON SEARCH Mascota ==========================//

  bool _btnSearchPeluqueria = false;
  bool get btnSearchPeluqueria => _btnSearchPeluqueria;

  void setBtnSearchPeluqueria(bool action) {
    _btnSearchPeluqueria = action;
    //
    notifyListeners();
  }

  //===================INPUT SEARCH COROSE==========================//
  String _nameSearchPeluqueria = "";
  String get nameSearchPeluqueria => _nameSearchPeluqueria;

  void onSearchTextPeluqueria(String data) {
    _nameSearchPeluqueria = data;
    if (_nameSearchPeluqueria.length >= 3) {
      _deboucerSearchPeluqueria?.cancel();
      _deboucerSearchPeluqueria = Timer(const Duration(milliseconds: 700), () {
        //
        buscaAllPeluqueria(data);
      });
    } else {
      buscaAllPeluqueria('');
      // buscaAusencias('','false');
    }
    notifyListeners();
  }

//==================== LISTO TODAS LAS Peluqueria ====================//
  List _listaPeluqueria = [];

  List get getListaPeluqueria => _listaPeluqueria;

  void setInfoBusquedaPeluqueria(List data) {
    _listaPeluqueria = data;
    // print('DATA:$_listaPeluqueria');
    notifyListeners();
  }

  bool? _errorPeluqueria; // sera nulo la primera vez
  bool? get getErrorPeluqueria => _errorPeluqueria;
  set setErrorPeluqueria(bool? value) {
    _errorPeluqueria = value;
    notifyListeners();
  }

  bool? _error401Peluqueria = false; // sera nulo la primera vez
  bool? get getError401Peluqueria => _error401Peluqueria;
  set setError401Peluqueria(bool? value) {
    _error401Peluqueria = value;
    notifyListeners();
  }

  Future buscaAllPeluqueria(String? _search) async {
    final dataUser = await Auth.instance.getSession();
//
    final response = await _api.getAllPeluqueria(
      search: _search,
      // estado: 'CLIENTES',
      token: '${dataUser!.token}',
    );
    // if (response != null) {
    //   _errorPeluqueria = true;

    //   List dataSort = [];
    //   dataSort = response['data'];
    //   dataSort.sort((a, b) => b['pelFecReg']!.compareTo(a['pelFecReg']!));

    //   // setInfoBusquedaPeluqueria(response['data']);
    //   setInfoBusquedaPeluqueria(dataSort);
    //   //
    //   notifyListeners();
    //   return response;
    // }
    if (response != null) {
      if (response == 401) {
        setInfoBusquedaPeluqueria([]);
        _error401Peluqueria = true;
        notifyListeners();
        return response;
      } else {
        _errorPeluqueria = true;

        List dataSort = [];
        dataSort = response['data'];
        dataSort.sort((a, b) => b['pelFecReg']!.compareTo(a['pelFecReg']!));

        // setInfoBusquedaPeluqueria(response['data']);
        setInfoBusquedaPeluqueria(dataSort);
        // print('object;${response['data']}');
        notifyListeners();
        return response;
      }
    }

    if (response == null) {
      _errorPeluqueria = false;
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

  //================================INPUT   TEMPERAMENTO=============================================//
  String? _temperamentoMascota = '';
  String? get getTemperamentoMascota => _temperamentoMascota;

  void setTemperamentoMascota(String? value) {
    _temperamentoMascota = value;

    notifyListeners();
  }

  //================================INPUT   TEMPERAMENTO=============================================//
  String? _observacionIngresoMascota = '';
  String? get getObservacionIngresoMascota => _observacionIngresoMascota;

  void onInputObservacionIngresoMascota(String? value) {
    _observacionIngresoMascota = value;

    notifyListeners();
  }

  //================================INPUT   TEMPERAMENTO=============================================//
  String? _otrosProcesos = '';
  String? get getOtrosProcesos => _otrosProcesos;

  void onInputOtrosProcesos(String? value) {
    _otrosProcesos = value;

    notifyListeners();
  }

  //================================INPUT   TEMPERAMENTO=============================================//
  String? _dejaAcesorios = '';
  String? get getDejaAcesorios => _dejaAcesorios;

  void onInputDejaAcesorios(String? value) {
    _dejaAcesorios = value;

    notifyListeners();
  }

  //================================INPUT   ESTADO CABELLO=============================================//
  String? _estadoCabello = '';
  String? get getEstadoCabello => _estadoCabello;

  void setEstadoCabello(String? value) {
    _estadoCabello = value;

    notifyListeners();
  }

  //================================INPUT   TEMPERAMENTO=============================================//
  String? _autorizadoPor = '';
  String? get getAutorizadoPor => _autorizadoPor;

  void setAutorizadoPor(String? value) {
    _autorizadoPor = value;

    notifyListeners();
  }
  //================================INPUT   HOTRA ingreso=============================================//

  String? _inputHoraIngreso = "";
  get getInputHoraIngreso => _inputHoraIngreso;
  void onInputHoraIngresoChange(String? date) {
    _inputHoraIngreso = date;

    notifyListeners();
  }
  //================================INPUT   HOTRA SLIDA=============================================//

  String? _inputHoraSalida = "";
  get getInputHoraSalida => _inputHoraSalida;
  void onInputHoraSalidaChange(String? date) {
    _inputHoraSalida = date;

    notifyListeners();
  }

//==========================================================================================//
//==========================================================================================//
  String? _inputFechaProximaCita = "";
  get getInputfechaProximaCita => _inputFechaProximaCita;
  void onInputFechaProximaCitaChange(String? date) async {
    _inputFechaProximaCita = date;
    // print('_inputFechaProximaCita =====>$_inputFechaProximaCita');

    notifyListeners();
  }
//==========================================================================================//

  String? _inputHoraProximaCita = "";
  get getInputHoraProximaCita => _inputHoraProximaCita;
  void onInputHoraProximaCitaChange(String? date) {
    _inputHoraProximaCita = date;

    notifyListeners();
  }

  //========================================TURNO ==================================================//
  String? _turno;
  get getTurno => _turno;
  void setTurno(String? _date) {
    _turno = _date;

    notifyListeners();
  }

  //================================INFO   MASCOTA=============================================//
  dynamic _infoMascota;
  dynamic get getInfoMascota => _infoMascota;
  int? _idMascota;

  void setMascotaInfo(dynamic _inf) {
    _infoMascota = _inf;
    _idMascota = _inf['mascId'];
    setNombreMascota(_inf['mascNombre']);

    _personaID = _inf['mascPerId'];
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

  List? _otrosProductos = [];
  List? get getOtrosProductos => _otrosProductos;

  void setOtrosProductos(List? _value) {
    _otrosProductos = _value;
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

  String? _fechaRegistro = '';
  String? get getFechaRegistro => _fechaRegistro;

  void setFechaRegistro(String? _value) {
    _fechaRegistro = _value;
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

  String? _fecha ='${DateTime.now().year}-${(DateTime.now().month) < 10 ? '0${DateTime.now().month}' : '${DateTime.now().month}'}-${(DateTime.now().day) < 10 ? '0${DateTime.now().day}' : '${DateTime.now().day}'}';
  get getFecha => _fecha;
  void setFecha(String? date) async {
    _fecha = date;

    notifyListeners();
  }

  //========================================LISTA PEDIDOS PELUQUERIA  ==================================================//

  List? _listaPedidosPeluqueria = [];

  List? get getListaPedidosPeluqueria => _listaPedidosPeluqueria;

  void setInfoBusquedaPedidosPeluqueria(List? data) {
    _listaPedidosPeluqueria = data;
    //
    notifyListeners();
  }

  bool? _errorPedidosPeluqueria; // sera nulo la primera vez
  bool? get getErrorPedidosPeluqueria => _errorPedidosPeluqueria;
  set setErrorPedidosPeluqueria(bool? value) {
    _errorPedidosPeluqueria = value;
    notifyListeners();
  }

  Future buscaAllPedidosPeluqueria(String? _search) async {
    final dataUser = await Auth.instance.getSession();
//
    final response = await _api.getAllPedidosPeluqueria(
      search: _search,
      // estado: 'CLIENTES',
      token: '${dataUser!.token}',
    );
    if (response != null) {
      _errorPedidosPeluqueria = true;

      List dataSort = [];
      dataSort = response['data'];
      dataSort.sort((a, b) => b['pedipeFecReg']!.compareTo(a['pedipeFecReg']!));

      // setInfoBusquedaPedidosPeluqueria(response['data']);
      setInfoBusquedaPedidosPeluqueria(dataSort);
      //
      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorPedidosPeluqueria = false;
      notifyListeners();
      return null;
    }
  }

  //================================PEDIDOS CLIENTE =============================================//
  //=============================================================================================//
  String? _pedidoCara = '';
  String? get getPedidoCara => _pedidoCara;

  void setPedidoCara(String? value) {
    _pedidoCara = value;

    notifyListeners();
  }

  //=============================================================================================//
  String? _pedidoCopete = '';
  String? get getPedidoCopete => _pedidoCopete;

  void setPedidoCopete(String? value) {
    _pedidoCopete = value;

    notifyListeners();
  }

  //=============================================================================================//
  String? _pedidoBigotes = '';
  String? get getPedidoBigotes => _pedidoBigotes;

  void setPedidoBigotes(String? value) {
    _pedidoBigotes = value;

    notifyListeners();
  }

  //=============================================================================================//
  String? _pedidoCejas = '';
  String? get getPedidoCejas => _pedidoCejas;

  void setPedidoCejas(String? value) {
    _pedidoCejas = value;

    notifyListeners();
  }

  //=============================================================================================//
  String? _pedidoSoloLomo = '';
  String? get getPedidoSoloLomo => _pedidoSoloLomo;

  void setPedidoSoloLomo(String? value) {
    _pedidoSoloLomo = value;

    notifyListeners();
  }

  //=============================================================================================//
  String? _pedidoCola = '';
  String? get getPedidoCola => _pedidoCola;

  void setPedidoCola(String? value) {
    _pedidoCola = value;

    notifyListeners();
  }

  //=============================================================================================//
  String? _pedidoManosYPatas = '';
  String? get getPedidoManosYPatas => _pedidoManosYPatas;

  void setPedidoManosYPatas(String? value) {
    _pedidoManosYPatas = value;

    notifyListeners();
  }

  //=============================================================================================//
  String? _pedidoFormaDeLaCabeza = '';
  String? get getPedidoFormaDeLaCabeza => _pedidoFormaDeLaCabeza;

  void setPedidoFormaDeLaCabeza(String? value) {
    _pedidoFormaDeLaCabeza = value;

    notifyListeners();
  }

  //=============================================================================================//
  String? _pedidoOrejas = '';
  String? get getPedidoOrejas => _pedidoOrejas;

  void setPedidoOrejas(String? value) {
    _pedidoOrejas = value;

    notifyListeners();
  }

  //=============================================================================================//
  String? _pedidoBigotesForma = '';
  String? get getPedidoBigotesForma => _pedidoBigotesForma;

  void setPedidoBigotesForma(String? value) {
    _pedidoBigotesForma = value;

    notifyListeners();
  }

  //=============================================================================================//
  String? _pedidoTodoElCuerpo = '';
  String? get getPedidoTodoElCuerpo => _pedidoTodoElCuerpo;

  void setPedidoTodoElCuerpo(String? value) {
    _pedidoTodoElCuerpo = value;

    notifyListeners();
  }

  //=============================================================================================//
  String? _pedidoFaldonPechoPatitas = '';
  String? get getPedidoFaldonPechoPatitas => _pedidoFaldonPechoPatitas;

  void setPedidoFaldonPechoPatitas(String? value) {
    _pedidoFaldonPechoPatitas = value;

    notifyListeners();
  }

  //=============================================================================================//
  String? _pedidoColaForma = '';
  String? get getPedidoColaForma => _pedidoColaForma;

  void setPedidoColaForma(String? value) {
    _pedidoColaForma = value;

    notifyListeners();
  }

  //================================PROCESO PELUQUERIA =============================================//
  //=============================================================================================//
  String? _procesoLlamar = 'NO';
  String? get getProcesoLlamar => _procesoLlamar;

  void setProcesoLlamar(String? value) {
    _procesoLlamar = value;

    notifyListeners();
  }

  String? _procesoOidos = 'NO';
  String? get getProcesoOidos => _procesoOidos;

  void setProcesoOidos(String? value) {
    _procesoOidos = value;

    notifyListeners();
  }

  String? _lavadoDientes = 'NO';
  String? get getLavadoDientes => _lavadoDientes;

  void setLavadoDientes(String? value) {
    _lavadoDientes = value;
    notifyListeners();
  }

  String? _uniasDedos = 'NO';
  String? get getUniasDedos => _uniasDedos;

  void setUniasDedos(String? value) {
    _uniasDedos = value;
    notifyListeners();
  }

  String? _drenaje = 'NO';
  String? get getDrenaje => _drenaje;

  void setDrenaje(String? value) {
    _drenaje = value;
    notifyListeners();
  }

  String? _secado = 'NO';
  String? get getSecado => _secado;

  void setSecado(String? value) {
    _secado = value;
    notifyListeners();
  }

  String? _perfume = 'NO';
  String? get getPerfume => _perfume;

  void setPerfume(String? value) {
    _perfume = value;
    notifyListeners();
  }

  String? _limpiezaOcular = 'NO';
  String? get getLimpiezaOcular => _limpiezaOcular;

  void setLimpiezaOcular(String? value) {
    _limpiezaOcular = value;
    notifyListeners();
  }

  String? _corteUnias = 'NO';
  String? get getCorteUnias => _corteUnias;

  void setCorteUnias(String? value) {
    _corteUnias = value;
    notifyListeners();
  }

  String? _rapadoGenital = 'NO';
  String? get getRapadoGenital => _rapadoGenital;

  void setRapadoGenital(String? value) {
    _rapadoGenital = value;
    notifyListeners();
  }

  String? _banio = 'NO';
  String? get getBanio => _banio;

  void setBanio(String? value) {
    _banio = value;
    notifyListeners();
  }

  String? _corteYAcabados = 'NO';
  String? get getCorteYAcabados => _corteYAcabados;

  void setCorteYAcabados(String? value) {
    _corteYAcabados = value;
    notifyListeners();
  }

//======= AGREGADOS NUEVOS ============//
  String? _lazoCentral = 'NO';
  String? get getLazoCentral => _lazoCentral;

  void setLazoCentral(String? value) {
    _corteYAcabados = value;
    notifyListeners();
  }

  String? _bufanda = 'NO';
  String? get getBufanda => _bufanda;

  void setBufanda(String? value) {
    _bufanda = value;
    notifyListeners();
  }

  String? _dosLazos = 'NO';
  String? get getDosLazos => _dosLazos;

  void setDosLazos(String? value) {
    _dosLazos = value;
    notifyListeners();
  }

  String? _panuelo = 'NO';
  String? get getPanuelo => _panuelo;

  void setPanuelo(String? value) {
    _panuelo = value;
    notifyListeners();
  }

//=======================================

  String? _valor;
  String? get getValor => _valor;

  void setValor(String? value) {
    _valor = value;
    notifyListeners();
  }

  String? _correo;
  String? get getCorreo => _correo;

  void setCorreo(String? value) {
    _correo = value;
    notifyListeners();
  }

  String? _declaro = 'NO';
  String? get getDeclaro => _declaro;

  void setDeclaro(String? value) {
    _declaro = value;
    notifyListeners();
  }

  String? _retiraMascota = 'NO';
  String? get getRetiraMascota => _retiraMascota;

  void setRetiraMascota(String? value) {
    _retiraMascota = value;
    notifyListeners();
  }

  String? _dejaCarnet = 'NO';
  String? get getDejaCarnet => _dejaCarnet;

  void setDejaCarnet(String? value) {
    _dejaCarnet = value;
    notifyListeners();
  }

  String? _presenciaPropietario = 'NO';
  String? get getPresenciaPropietario => _presenciaPropietario;

  void setPresenciaPropietario(String? value) {
    _presenciaPropietario = value;
    notifyListeners();
  }

//================================== CREA RECETA  ==============================//

  String _personaID = "";
  String _idFactura = "";
  String _personaDoc = "";
  String _personaNombre = "";
  String _personaTelefono = "";
  List<String> _personaListCelular = [];
  String _personaDireccion = "";
  List<String> _personaListCorreo = [];

  Future creaPeluqueria(
    BuildContext context,
  ) async {
    final serviceSocket = context.read<SocketService>();
    final infoUser = await Auth.instance.getSession();

    final _pyloadNuevaPeluqueria = {
      "tabla": "peluqueria",
      "rucempresa": infoUser!.rucempresa, // LOGIN
      "rol": infoUser.rol, //LOGIN

      "idFactura": "",

      "pelId": "",
      "pelMascId": _idMascota,
      "pelMascNombre": _nombreMascota,

      "pelPerId": _personaID,
      "pelPerNombre": _personaNombre,
      "pelPerDocNumero": _personaDoc,
      "pelPerTelefono": _personaTelefono,
      "pelPerCelular": _personaListCelular,
      "pelPerDireccion": _personaDireccion,
      "pelPerEmail": _personaListCorreo,

      "pelPerIdDoc": _vetDoctorId,
      "pelPerNombreDoc": _vetDoctorNombre,
      "pelTemperamento": _temperamentoMascota,
      "pelAutorizo": _autorizadoPor,
      "pelTurno": _turno,
      "pelFecha": _fecha,
      "pelHoraIngreso": _inputHoraIngreso,
      "pelHoraSalida": _inputHoraSalida,
      "pelEstado": _estadoCabello,
      "pelLlamar30min": _procesoLlamar,
      "pelProxCita": _inputHoraProximaCita,
      "pelCara": _pedidoCara,
      "pelFormaCabeza": _pedidoFormaDeLaCabeza,
      "pelCopete": _pedidoCopete,
      "pelOreja": _pedidoOrejas,
      "pelBigotes": _pedidoBigotes,
      "pelBigotesForma": _pedidoBigotesForma,
      "pelCejas": _pedidoCejas,
      "pelCuerpo": _pedidoTodoElCuerpo,
      "pelLomo": _pedidoSoloLomo,
      "pelFaldon": _pedidoFaldonPechoPatitas,
      "pelCola": _pedidoCola,
      "pelColaForma": _pedidoColaForma,
      "pelPatitas": _pedidoManosYPatas,
      "pelDeclaro": _declaro,
      "pelOidos": _procesoOidos,
      "pelLimpiezaOcular": _limpiezaOcular,
      "pelLavadoDientes": _lavadoDientes,
      "pelCorteUna": _corteUnias,
      "pelUnasDedos": _uniasDedos,
      "pelRapadoGenitales": _rapadoGenital,
      "pelDrenaje": _drenaje,
      "pelBano": _banio,
      "pelSecado": _secado,
      "pelCortesAcabados": _corteYAcabados,

      "pelLazoCentral": _lazoCentral,
      "pelDosLazos": _dosLazos,
       "pelBufanda": _bufanda,
      "pelPanuelo": _panuelo,

      "pelPerfume": _perfume,
      "pelPresencia": _presenciaPropietario,
      "pelRetira": _retiraMascota,
      "pelCarnet": _dejaCarnet,
      "pelUser": infoUser.usuario,
      "pelEmpresa": infoUser.rucempresa,
      "pelObservacion": _observacionIngresoMascota,
      "pelOtrosProcesos": _otrosProcesos,
      "pelValor": "0",
      "pelCorreo": "PENDIENTE",
      "pelDejaAccesorios": _dejaAcesorios,
      "pelProductos": [],
      "pelFecUpdate": "",
      "pelFecReg": "",
      "Todos": ""
    };

    // print(
    //     '==========================JSON PARA CREAR NUEVA RECETA ===============================');
    // print(_pyloadNuevaPeluqueria);
    // print(
    //     '==========================SOCKET RECETA ===============================');
    serviceSocket.socket!.emit('client:guardarData', _pyloadNuevaPeluqueria);
  }

  //================================== ELIMINAR  PELUQUERIA  ==============================//
  Future eliminaPeluqueria(BuildContext context, int? idPeluqueria) async {
    // final serviceSocket = SocketService();

    final serviceSocket = context.read<SocketService>();
    final infoUser = await Auth.instance.getSession();

    final _pyloadEliminaPeluqueria = {
      "tabla": 'peluqueria',
      "rucempresa": infoUser!.rucempresa,
      "rol": infoUser.rol,
      "pelId": idPeluqueria,
    };

    serviceSocket.socket!.emit('client:eliminarData', _pyloadEliminaPeluqueria);
  }

  //================================GET INFO PELUQUERIA=============================================//

  dynamic _infoPeluqueria;
  dynamic get getInfoPeluqueria => _infoPeluqueria;
  int? _idPeluqueria;
String? _userData='';
  void setPeluqueriaInfo(dynamic _inf) {
    _infoPeluqueria = _inf;
    // print('==INFO _infoPeluqueria ===> $_infoPeluqueria');


    _userData=_inf['pelUser'];
    _idPeluqueria = _inf['pelId'];
    _idMascota = int.parse(_inf['pelMascId']);
    setNombreMascota(_inf['pelMascNombre']);

    _personaID = _inf['pelPerId'];
    _personaDoc = _inf['pelPerDocNumero'];
    _personaNombre = _inf['pelPerNombre'];
    _personaTelefono = _inf['pelPerTelefono'];
    for (var itemCelu in _inf['pelPerCelular']) {
      _personaListCelular.add(itemCelu);
    }
    _personaDireccion = _inf['pelPerDireccion'];
    for (var itemEmail in _inf['pelPerEmail']) {
      _personaListCorreo.add(itemEmail);
    }

    _idFactura = _inf['idFactura'] ?? "";

    setTemperamentoMascota(_inf['pelTemperamento']);
    setEstadoCabello(_inf['pelEstado']);
    setAutorizadoPor(_inf['pelPerDireccion']);
    setTurno(_inf['pelPerDireccion']);

    _infoDoctor = _inf;

    setVetDoctorId(_inf['pelPerIdDoc'].toString());
    setVetDoctorNombre(_inf['pelPerNombreDoc']);

    setFecha(_inf['pelFecha']);
    setAutorizadoPor(_inf['pelAutorizo']);
    setTurno(_inf['pelTurno']);
    onInputHoraIngresoChange(_inf['pelHoraIngreso']);
    onInputHoraSalidaChange(_inf['pelHoraSalida']);

    setProcesoLlamar(_inf['pelLlamar30min']);

    onInputHoraProximaCitaChange(_inf['pelProxCita']);
    setPedidoCara(_inf['pelCara']);
    setPedidoFormaDeLaCabeza(_inf['pelFormaCabeza']);
    setPedidoCopete(_inf['pelCopete']);
    setPedidoOrejas(_inf['pelOreja']);
    setPedidoBigotes(_inf['pelBigotes']);
    setPedidoBigotesForma(_inf['pelBigotesForma']);
    setPedidoCejas(_inf['pelCejas']);
    setPedidoTodoElCuerpo(_inf['pelCuerpo']);
    setPedidoSoloLomo(_inf['pelLomo']);
    setPedidoFaldonPechoPatitas(_inf['pelFaldon']);
    setPedidoCola(_inf['pelCola']);
    setPedidoColaForma(_inf['pelColaForma']);
    setPedidoManosYPatas(_inf['pelPatitas']);
    setDeclaro(_inf['pelDeclaro']);
    setProcesoOidos(_inf['pelOidos']);
    setLimpiezaOcular(_inf['pelLimpiezaOcular']);
    setLavadoDientes(_inf['pelLavadoDientes']);
    setCorteUnias(_inf['pelCorteUna']);
    setUniasDedos(_inf['pelUnasDedos']);
    setRapadoGenital(_inf['pelRapadoGenitales']);
    setDrenaje(_inf['pelDrenaje']);
    setBanio(_inf['pelBano']);
    setSecado(_inf['pelSecado']);
    setCorteYAcabados(_inf['pelCortesAcabados']);


   //===== AGREGADOS NUEVOS ========//
    setLazoCentral(_inf['pelLazoCentral']);
    setDosLazos(_inf['pelDosLazos']);
    setBufanda(_inf['pelBufanda']);
    setPanuelo(_inf['pelPanuelo']);
   //===============================//
     
    

    setPerfume(_inf['pelPerfume']);
    setPresenciaPropietario(_inf['pelPresencia']);
    setRetiraMascota(_inf['pelRetira']);
    setDejaCarnet(_inf['pelCarnet']);

    onInputObservacionIngresoMascota(_inf['pelObservacion']);
    onInputOtrosProcesos(_inf['pelOtrosProcesos']);

    onInputDejaAcesorios(_inf['pelDejaAccesorios']);
    for (var itemProductos in _inf['pelProductos']) {
      _otrosProductos!.add(itemProductos);
    }

    setValor(_inf['pelValor']);
    setCorreo(_inf['setCorreo']);
    setFechaRegistro(_inf['pelFecReg']);

//
// 			"pelFecUpdate": "2022-12-06T15:42:59.000Z",
// 			"pelFecReg": "2022-11-12T17:24:29.000Z",
// 			"Todos": "PAQUITO"

    notifyListeners();
  }

  Future editaPeluqueria(
    BuildContext context,
  ) async {
    final serviceSocket = context.read<SocketService>();
    final infoUser = await Auth.instance.getSession();

    final _pyloadEditaPeluqueria = {
      "tabla": "peluqueria",
      "rucempresa": infoUser!.rucempresa, // LOGIN
      "rol": infoUser.rol, //LOGIN

      "idFactura": _idFactura,

      "pelId": _idPeluqueria,
      "pelMascId": _idMascota,
      "pelMascNombre": _nombreMascota,

      "pelPerId": _personaID,
      "pelPerNombre": _personaNombre,
      "pelPerDocNumero": _personaDoc,
      "pelPerTelefono": _personaTelefono,
      "pelPerCelular": _personaListCelular,
      "pelPerDireccion": _personaDireccion,
      "pelPerEmail": _personaListCorreo,

      "pelPerIdDoc": _vetDoctorId,
      "pelPerNombreDoc": _vetDoctorNombre,
      "pelTemperamento": _temperamentoMascota,
      "pelAutorizo": _autorizadoPor,
      "pelTurno": _turno,
      "pelFecha": _fecha,
      "pelHoraIngreso": _inputHoraIngreso,
      "pelHoraSalida": _inputHoraSalida,
      "pelEstado": _estadoCabello,
      "pelLlamar30min": _procesoLlamar,
      "pelProxCita": _inputHoraProximaCita,
      "pelCara": _pedidoCara,
      "pelFormaCabeza": _pedidoFormaDeLaCabeza,
      "pelCopete": _pedidoCopete,
      "pelOreja": _pedidoOrejas,
      "pelBigotes": _pedidoBigotes,
      "pelBigotesForma": _pedidoBigotesForma,
      "pelCejas": _pedidoCejas,
      "pelCuerpo": _pedidoTodoElCuerpo,
      "pelLomo": _pedidoSoloLomo,
      "pelFaldon": _pedidoFaldonPechoPatitas,
      "pelCola": _pedidoCola,
      "pelColaForma": _pedidoColaForma,
      "pelPatitas": _pedidoManosYPatas,
      "pelDeclaro": _declaro,
      "pelOidos": _procesoOidos,
      "pelLimpiezaOcular": _limpiezaOcular,
      "pelLavadoDientes": _lavadoDientes,
      "pelCorteUna": _corteUnias,
      "pelUnasDedos": _uniasDedos,
      "pelRapadoGenitales": _rapadoGenital,
      "pelDrenaje": _drenaje,
      "pelBano": _banio,
      "pelSecado": _secado,
      "pelCortesAcabados": _corteYAcabados,


      "pelLazoCentral": _lazoCentral,
      "pelDosLazos": _dosLazos,
       "pelBufanda": _bufanda,
      "pelPanuelo": _panuelo,


      "pelPerfume": _perfume,
      "pelPresencia": _presenciaPropietario,
      "pelRetira": _retiraMascota,
      "pelCarnet": _dejaCarnet,
      "pelUser": "$_userData ** ${infoUser.usuario}",
      "pelEmpresa": infoUser.rucempresa,
      "pelObservacion": _observacionIngresoMascota,
      "pelOtrosProcesos": _otrosProcesos,
      "pelValor": "0",
      "pelCorreo": "PENDIENTE",
      "pelDejaAccesorios": _dejaAcesorios,
      "pelProductos": [],
      "pelFecUpdate": "",
      "pelFecReg": "",
      "Todos": ""
    };

    // print(
    //     '==========================JSON PARA CREAR NUEVA RECETA ===============================');
    // print(_pyloadEditaPeluqueria);
    // print(
    //     '==========================SOCKET RECETA ===============================');
    serviceSocket.socket!.emit('client:actualizarData', _pyloadEditaPeluqueria);
  }



//=================================================================================================================//
  // ================= VARIABLES DE PAGINACION ====================//
//=================================================================================================================//
//===================BOTON SEARCH PAGINACION ==========================//

  bool _btnSearchPeluqueriasPaginacion = false;
  bool get btnSearchPeluqueriaPaginacion => _btnSearchPeluqueriasPaginacion;

  void setBtnSearchPeluqueriaPaginacion(bool action) {
    _btnSearchPeluqueriasPaginacion = action;
    //  print('==_btnSearchCoros===> $_btnSearchPropietarios');
    notifyListeners();
  }

  //===================INPUT SEARCH PROPIETARIO==========================//
  String _nameSearchPeluqueriaPaginacion = "";
  String get nameSearchPeluqueriaPaginacion =>
      _nameSearchPeluqueriaPaginacion;

  void onSearchTextPeluqueriaPaginacion(String data) {
    _nameSearchPeluqueriaPaginacion = data;
     print('VacunNOMBRE:${_nameSearchPeluqueriaPaginacion}');
     }
//=============================================================================//

 //================= LISTA PROPIETARIOS SIN PAGINACION ===================/

  List _listaPeluqueriasPaginacion = [];
  // List<TipoMulta> get getListaTodosLosTiposDeMultas => _listaTodosLosTiposDeMultas;
  List get getListaPeluqueriasPaginacion => _listaPeluqueriasPaginacion;

  void setInfoBusquedaPeluqueriasPaginacion(List data) {
    _listaPeluqueriasPaginacion.addAll(data);
    print('Peluquerias :${_listaPeluqueriasPaginacion.length}');

    // for (var item in _listaPeluqueriasPaginacion) {
    //    print('-->:${item['perId']}');
    // }

    notifyListeners();
  }

  bool? _errorPeluqueriasPaginacion; // sera nulo la primera vez
  bool? get getErrorPeluqueriasPaginacion => _errorPeluqueriasPaginacion;
  void setErrorPeluqueriasPaginacion(bool? value) {
    _errorPeluqueriasPaginacion = value;
    notifyListeners();
  }

  bool? _error401PeluqueriasPaginacion = false; // sera nulo la primera vez
  bool? get getError401PeluqueriasPaginacion => _error401PeluqueriasPaginacion;
  void setError401PeluqueriasPaginacion(bool? value) {
    _error401PeluqueriasPaginacion = value;
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

  Future buscaAllPeluqueriasPaginacion(String? _search, bool _isSearch) async {
    final dataUser = await Auth.instance.getSession();
// print('usuario : ${dataUser!.rucempresa}');
    final response = await _api.getAllPeluqueriaPaginacion(
      search: _search,
      page: _page,
      cantidad: _cantidad,
      // documento: "",
      input: 'pelId',
      orden: false,
      allData:true,
      token: '${dataUser!.token}',
    );

    if (response != null) {
      if (response == 401) {
        setInfoBusquedaPeluqueriasPaginacion([]);
        _error401PeluqueriasPaginacion = true;
        notifyListeners();
        return response;
      } else {
        _errorPeluqueriasPaginacion = true;
        if (_isSearch == true) {
          _listaPeluqueriasPaginacion = [];
        }
        List<dynamic> dataSort = response['data']['results'];
        dataSort.sort((a, b) => b['pelFecReg']!.compareTo(a['pelFecReg']!));

        setPage(response['data']['pagination']['next']);

        setInfoBusquedaPeluqueriasPaginacion(dataSort);
        notifyListeners();
        return response;
      }

      //===========================================//

    }
    if (response == null) {
      _errorPeluqueriasPaginacion = false;
      notifyListeners();
      return null;
    }
  }











}

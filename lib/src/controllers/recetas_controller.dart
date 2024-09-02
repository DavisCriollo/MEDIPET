import 'dart:async';

import 'package:flutter/material.dart';
import 'package:neitorcont/src/api/api_provider.dart';
import 'package:neitorcont/src/api/authentication_client.dart';
import 'package:neitorcont/src/models/auth_response.dart';
import 'package:neitorcont/src/services/socket_service.dart';
import 'package:provider/provider.dart';

class RecetasController extends ChangeNotifier {
  final _api = ApiProvider();
  GlobalKey<FormState> recetasFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> recetasMedicamentoFormKey = GlobalKey<FormState>();

  AuthResponse? usuarios;
  bool validateFormReceta() {
    if (recetasFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  void resetFormReceta() {
    idItem = 0;
    _infoMascota;
    _nombreMascota = '';
    _doctoNombre = '';
    _doctorId = '';
    _medicamentoNew.clear();
    _nuevoMedicamento.clear();
    _nombreMascota = '';
_isFechaCita=false;
    _razaMascota = '';

    _sexoMascota = '';

    _edadMascota = '';
   

    _propietarioIdMascota = '';

    _propietarioMascota = '';

    _doctorId = '';
    _inputFechaProximaCita="";
    _inputHoraProximaCita='';

    _doctoNombre = '';

    _propietarioCedulaMascota = '';

    _propietarioDirecionMascota = '';

    _propietarioCelularMascota = [];

    _propietarioEmailMascota = [];

    _pesoMascota = '';

    _recomendacionesMascota = '';

    _inputFechaProximaCita;

    _inputHoraProximaCita;


     _page = 0;
    _cantidad = 25;
     _listaRecetasPaginacion=[];
    _next = '';
    _isNext = false;

    // ====================//
  }

  bool validateFormMedicamento() {
    if (recetasMedicamentoFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

//  =================  CREO DEBOUNCE  PARA BUSQUEDAS ==================//

  Timer? _deboucerSearchRecetas;
  Timer? _deboucerSearchMedicinas;
  Timer? _deboucerSearchBuscaPersona;

  @override
  void dispose() {
    _deboucerSearchRecetas?.cancel();
    _deboucerSearchMedicinas?.cancel();
    _deboucerSearchBuscaPersona?.cancel();

    // _videoController.dispose();
    super.dispose();
  }

//===================BOTON SEARCH Mascota ==========================//

  bool _btnSearchRecetas = false;
  bool get btnSearchRecetas => _btnSearchRecetas;

  void setBtnSearchRecetas(bool action) {
    _btnSearchRecetas = action;
    //  print('==_btnSearchCoros===> $_btnSearchRecetas');
    notifyListeners();
  }

  //===================INPUT SEARCH COROSE=========================
  String _nameSearchRecetas = "";
  String get nameSearchRecetas => _nameSearchRecetas;

  void onSearchTextRecetas(String data) {
    _nameSearchRecetas = data;
    if (_nameSearchRecetas.length >= 3) {
      _deboucerSearchRecetas?.cancel();
      _deboucerSearchRecetas = Timer(const Duration(milliseconds: 700), () {
        // print('=====> $data');
        buscaAllRecetas(data);
      });
    } else {
      buscaAllRecetas('');
      // buscaAusencias('','false');
    }
    notifyListeners();
  }
  //===================INPUT SEARCH DOCTORES=========================
  String _nameSearPersonas = "";
  String get nameSearcPersonas => _nameSearPersonas;

  void onSearchTexPersonas(String data) {
    _nameSearPersonas = data;
    if (_nameSearPersonas.length >= 3) {
      _deboucerSearchBuscaPersona?.cancel();
      _deboucerSearchBuscaPersona = Timer(const Duration(milliseconds: 700), () {
        // print('=====> $data');
        buscaAllDoctores(data);
      });
    } else {
      buscaAllDoctores('');
      // buscaAusencias('','false');
    }
    notifyListeners();
  }
  //===================INPUT SEARCH COROSE==========================//
  String _nameSearchMedicinas = "";
  String get nameSearchMedicinas => _nameSearchMedicinas;

  void onSearchTextMedicinas(String data) {
    _nameSearchMedicinas = data;
    if (_nameSearchMedicinas.length >= 3) {
      _deboucerSearchMedicinas?.cancel();
      _deboucerSearchMedicinas = Timer(const Duration(milliseconds: 700), () {
        // print('=====> $data');
        buscaAllMedicinas(data);
      });
    } else {
      buscaAllMedicinas('');
      // buscaAusencias('','false');
    }
    notifyListeners();
  }

//==================== LISTO TODAS LAS Recetas CLINICAS====================//
  List _listaRecetas = [];

  List get getListaRecetas => _listaRecetas;

  void setInfoBusquedaRecetas(List data) {
    _listaRecetas = data;
    // print('Recetas:$_listaRecetas');
    notifyListeners();
  }

  bool? _errorRecetas; // sera nulo la primera vez
  bool? get getErrorRecetas => _errorRecetas;
  set setErrorRecetas(bool? value) {
    _errorRecetas = value;
    notifyListeners();
  }
 bool? _error401Recetas =false; // sera nulo la primera vez
  bool? get getError401Recetas => _error401Recetas;
  set setError401Recetas(bool? value) {
    _error401Recetas = value;
    notifyListeners();
  }
  Future buscaAllRecetas(String? _search) async {
    final dataUser = await Auth.instance.getSession();
// print('usuario : ${dataUser!.rucempresa}');
    final response = await _api.getAllRecetas(
      search: _search,
      // estado: 'CLIENTES',
      token: '${dataUser!.token}',
    );
    // if (response != null) {
    //   _errorRecetas = true;

    //   List dataSort = [];
    //   dataSort = response['data'];
    //   dataSort.sort((a, b) => b['recFecReg']!.compareTo(a['recFecReg']!));

    //   // setInfoBusquedaRecetas(response['data']);
    //   setInfoBusquedaRecetas(dataSort);
    //   // print('object;${response['data']}');
    //   notifyListeners();
    //   return response;
    // }

     if (response != null ){

    if(response==401){

       setInfoBusquedaRecetas([]);
       _error401Recetas=true;
     notifyListeners();
      return response;
    }
    else{
       _errorRecetas = true;

      List dataSort = [];
      dataSort = response['data'];
      dataSort.sort((a, b) => b['recFecReg']!.compareTo(a['recFecReg']!));

      // setInfoBusquedaRecetas(response['data']);
      setInfoBusquedaRecetas(dataSort);
      // print('object;${response['data']}');
      notifyListeners();
      return response;

    }
  

 }
    if (response == null) {
      _errorRecetas = false;
      notifyListeners();
      return null;
    }
  }
//==================== LISTO TODAS LAS MEDICINAS====================//
  List _listaMedicinas = [];

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

//================================INPUT   MASCOTA=============================================//
  String? _nombreMascota = '';
  String? get getNombreMascota => _nombreMascota;

  void setNombreMascota(String? value) {
    _nombreMascota = value;
    // print('==_nombreMascota ===> $_nombreMascota');
    notifyListeners();
  }

//==========================================================================================//
  String? _razaMascota = '';
  String? get getRazaMascota => _razaMascota;

  void setRazaMascota(String? value) {
    _razaMascota = value;
    // print('==_RazaMascota ===> $_razaMascota');
    notifyListeners();
  }

//==========================================================================================//
  String? _sexoMascota = '';
  String? get getSexoMascota => _sexoMascota;

  void setSexoMascota(String? value) {
    _sexoMascota = value;
    // print('==_sexoMascota ===> $_sexoMascota');
    notifyListeners();
  }

//==========================================================================================//
  String? _edadMascota = '';
  String? get getEdadMascota => _edadMascota;

  void setEdadMascota(String? value) {
    _edadMascota = value;
    // print('==_edadMascota ===> $_edadMascota');
    notifyListeners();
  }


//==========================================================================================//
  String? _propietarioIdMascota = '';
  String? get getPropietarioIdMascota => _propietarioIdMascota;

  void setPropietarioIdMascota(String? value) {
    _propietarioIdMascota = value;
    // print('==_propietarioIdMascota ===> $_propietarioIdMascota');
    notifyListeners();
  }


//==========================================================================================//
  String? _propietarioMascota = '';
  String? get getPropietarioMascota => _propietarioMascota;

  void setPropietarioMascota(String? value) {
    _propietarioMascota = value;
    // print('==_propietarioMascota ===> $_propietarioMascota');
    notifyListeners();
  }

//========================================DOCTOR ==================================================//
  String? _doctorId = '';
  String? get getDoctorId => _doctorId;

  void setDoctorId(String? _value) {
    _doctorId = _value;
    // print('==_propietarioMascota ===> $_propietarioMascota');
    notifyListeners();
  }

  String? _doctoNombre = '';
  String? get getDoctoNombre => _doctoNombre;

  void setDoctoNombre(String? _value) {
    _doctoNombre = _value;
    // print('==_propietarioMascota ===> $_propietarioMascota');
    notifyListeners();
  }

//==========================================================================================//
  String? _propietarioCedulaMascota = '';
  String? get getPropietarioCedulaMascota => _propietarioCedulaMascota;

  void setPropietarioCedulaMascota(String? value) {
    _propietarioCedulaMascota = value;
    // print('==_propietarioCedulaMascota ===> $_propietarioCedulaMascota');
    notifyListeners();
  }

//==========================================================================================//
  String? _propietarioDirecionMascota = '';
  String? get getPropietarioDirecionMascota => _propietarioDirecionMascota;

  void setPropietarioDirecionMascota(String? value) {
    _propietarioDirecionMascota = value;
    // print('==_propietarioDirecionMascota ===> $_propietarioDirecionMascota');
    notifyListeners();
  }
  String? _propietarioTelefonoMascota = '';
  String? get getPropietarioTelefonoMascota => _propietarioTelefonoMascota;

  void setPropietarioTelefonoMascota(String? value) {
    _propietarioTelefonoMascota = value;
    // print('==_propietarioTelefonoMascota ===> $_propietarioTelefonoMascota');
    notifyListeners();
  }

//==========================================================================================//
  List? _propietarioCelularMascota = [];
  List? get getPropietarioCelularMascota => _propietarioCelularMascota;

  void setPropietarioCelularMascota(List? value) {
    _propietarioCelularMascota = value;
    // print('==_propietarioCelularMascota ===> $_propietarioCelularMascota');
    notifyListeners();
  }

//==========================================================================================//
  List? _propietarioEmailMascota = [];
  List? get getPropietarioEmailMascota => _propietarioEmailMascota;

  void setPropietarioEmailMascota(List? value) {
    _propietarioEmailMascota = value;
    // print('==_propietarioEmailMascota ===> $_propietarioEmailMascota');
    notifyListeners();
  }

//==========================================================================================//
  String? _pesoMascota = '';
  String? get getPesoMascota => _pesoMascota;

  void setPesoMascota(String? value) {
    _pesoMascota = value;
    // print('==_pesoMascota ===> $_pesoMascota');
    notifyListeners();
  }

//==========================================================================================//
  String? _recomendacionesMascota = '';
  String? get getRecomendacionesMascota => _recomendacionesMascota;

  void setRecomendacionesMascota(String? value) {
    _recomendacionesMascota = value;
    // print('==_recomendacionesMascota ===> $_recomendacionesMascota');
    notifyListeners();
  }

//==========================================================================================//
  String? _inputFechaProximaCita="";
  get getInputfechaProximaCita => _inputFechaProximaCita;
  void onInputFechaProximaCitaChange(String? date) async {
    _inputFechaProximaCita = date;
    // print('_inputFechaProximaCita =====>$_inputFechaProximaCita');

    notifyListeners();
  }
//==========================================================================================//

  String? _inputHoraProximaCita="";
  get getInputHoraProximaCita => _inputHoraProximaCita;
  void onInputHoraProximaCitaChange(String? date) {
    _inputHoraProximaCita = date;
    // print('_inputHoraProximaCita =====>$_inputHoraProximaCita');

    notifyListeners();
  }

//==========================================================================================//
  String? _inputDoctorMascota = '';
  get getInputDoctorMascota => _inputDoctorMascota;
  void onInputDoctorMascotaChange(String? date) async {
    _inputDoctorMascota = date;
    print('_inputDoctorMascota =====>$_inputDoctorMascota');

    notifyListeners();
  }

//================================GET MASCOTA=============================================//

  dynamic _infoMascota;
  dynamic get getInfoMascota => _infoMascota;
  int? _idMascota;

  void setMascotaInfo(dynamic _inf) {
    _infoMascota = _inf;
    _idMascota = _inf['mascId'];
    setNombreMascota(_inf['mascNombre']);
    setRazaMascota(_inf['mascRaza']);
    setSexoMascota(_inf['mascSexo']);
    setEdadMascota(_inf['mascEdad']);
    setPesoMascota(_inf['mascPeso']);
    setPropietarioIdMascota(_inf['mascPerId']);
    setPropietarioMascota(_inf['mascPerNombre']);
    setPropietarioCedulaMascota(_inf['mascPerDocNumero']);
    setPropietarioDirecionMascota(_inf['mascPerDireccion']);
    setPropietarioTelefonoMascota(_inf['mascPerTelefono']);

    setPropietarioCelularMascota(_inf['mascPerCelular']);
    setPropietarioEmailMascota(_inf['mascPerEmail']);

    // print('==ID MASCOTA ===> $_idMascota');
    // print('==INFO MASCOTA ===> $_infoMascota');
    notifyListeners();
  }
//================================GET MASCOTA=============================================//

  dynamic _infoDoctor;
  dynamic get getInfoDoctor => _infoDoctor;
  // int? _idMascota;

  void setDoctorInfo(dynamic _inf) {
    _infoDoctor = _inf;
    setDoctorId(_inf['perId'].toString());
    setDoctoNombre(_inf['perNombre']);
    // _idMascota=_inf['mascId'];
    // setNombreMascota(_inf['mascNombre']);
    // setRazaMascota(_inf['mascRaza']);
    // setSexoMascota(_inf['mascSexo']);
    // setEdadMascota(_inf['mascEdad']);
    // // setPesoMascota(_inf['mascNombre']);
    // setPropietarioIdMascota(_inf['mascPerId']);
    // setPropietarioMascota(_inf['mascPerNombre']);
    // setPropietarioCedulaMascota(_inf['mascPerDocNumero']);
    // setPropietarioDirecionMascota(_inf['mascPerDireccion']);
    // setPropietarioCelularMascota(_inf['mascPerCelular']);
    // setPropietarioEmailMascota(_inf['mascPerEmail']);

    // print('==ID MASCOTA ===> $_idMascota');
    // print('==INFO DOCTOR ===> $_infoDoctor');
    notifyListeners();
  }
//================================GET INFO RECETA=============================================//

  dynamic _infoReceta;
  dynamic get getInfoReceta => _infoReceta;
  int? _idReceta;
 String? _userData='';
  void setRecetaInfo(dynamic _inf) {
    _nuevoMedicamento=[];
    _infoReceta = _inf;
    // print('==INFO RECETA ===> $_infoReceta');



    _userData=_inf['recUser'];
    _idMascota = int.parse(_inf['recMascId']);
    // _idMascota = _inf['recMascId'];
    _idReceta = _inf['recId'];
    setNombreMascota(_inf['recMascNombre']);
   setRazaMascota(_inf['recMascRaza']);
    setSexoMascota(_inf['recMascSexo']);
    setEdadMascota(_inf['recMascEdad']);
    setPesoMascota(_inf['recPeso']);
    setPropietarioIdMascota(_inf['recPerIdPropietario']);
    setPropietarioMascota(_inf['recPerNombrePropietario']);
    setPropietarioCedulaMascota(_inf['recPerDocNumeroPropietario']);
    setPropietarioDirecionMascota(_inf['recPerDireccionPropietario']);
    setPropietarioTelefonoMascota(_inf['recPerTelefonoPropietario']);

    setPropietarioCelularMascota(_inf['recPerCelularPropietario']);
    setPropietarioEmailMascota(_inf['recPerEmailPropietario']);

     setDoctorId(_inf['recPerIdDoc'].toString());
    setDoctoNombre(_inf['recPerNombreDoc']);

    // setDoctoNombre(_inf['perNombre']);

  
// setNuevoMedicamento(_inf['recMedicamentos']['arrayMedicamentos']);
// _nuevoMedicamento.add(_inf['recMedicamentos']['arrayMedicamentos']);
// print('este es el aray de medicamentos: $_nuevoMedicamento');

// _nuevoMedicamento=_inf['recMedicamentos']['arrayMedicamentos'];
for (var item in _inf['recMedicamentos']['arrayMedicamentos']) {
  _antiguosMedicamento.add(item);
  
}
for (var item in _inf['recMedicamentos']['arrayMedicamentos']) {
  _nuevoMedicamento.add(item);
  
}
// print('este es el aray de medicamentos: $_nuevoMedicamento');



    if(_inf['recProxCita']=='T'|| _inf['recProxCita']==''){
    onInputHoraProximaCitaChange('');
    onInputFechaProximaCitaChange('');

    }
    else
    {
      // final _fecha=_inf['recProxCita'].substring(0, 10);
      // final _hora=_inf['recProxCita'].substring(0, 4);

      onInputFechaProximaCitaChange(_inf['recProxCita'].substring(0, 10));
      onInputHoraProximaCitaChange(_inf['recProxCita'].substring(11, 16));

    }
    setRecomendacionesMascota(_inf['recRecomendacion']);
    


    
    notifyListeners();
  }

//================================== LISTAR MEDICINA  ==============================//
dynamic _infoMedicina;
  dynamic get getInfoMedicina => _infoMedicina;
  int? _idMedicina;

  void setMedicinaInfo(dynamic _infMed) {
    // _infoMascota = _infMed;
    _idMedicina = _infMed['mascId'];
    onInputMedicamentoMedicinaChange(_infMed['invNombre']);
    onInputSerieMedicinaChange(_infMed['invSerie']);
    // setNom(_inf['mascNombre']);

    // setRazaMascota(_inf['mascRaza']);
    // setSexoMascota(_inf['mascSexo']);
    // setEdadMascota(_inf['mascEdad']);
    // setPesoMascota(_inf['mascPeso']);
    // setPropietarioIdMascota(_inf['mascPerId']);
    // setPropietarioMascota(_inf['mascPerNombre']);
    // setPropietarioCedulaMascota(_inf['mascPerDocNumero']);
    // setPropietarioDirecionMascota(_inf['mascPerDireccion']);
    // setPropietarioTelefonoMascota(_inf['mascPerTelefono']);

    // setPropietarioCelularMascota(_inf['mascPerCelular']);
    // setPropietarioEmailMascota(_inf['mascPerEmail']);

    // print('==ID MASCOTA ===> $_idMascota');
    // print('==INFO MASCOTA ===> $_infoMascota');
    notifyListeners();
  }



//================================== LISTAR DOCTORES  ==============================//

  List _listaAllPersonas = [];
  List get getListaAllPersonas => _listaAllPersonas;

  void setListaAllPersonas(List data) {
    _listaAllPersonas = data;
    print('_listaAllPersonas: $_listaAllPersonas');
    // print('LA RAZA: ${_listaAllPersonas[0]['espRazas']}');

    notifyListeners();
  }

  bool? _errorAllPersonas; // sera nulo la primera vez
  bool? get getErrorAllPersonas => _errorAllPersonas;

  Future? buscaAllDoctores(String? _search) async {
    final dataUser = await Auth.instance.getSession();
    final response = await _api.getAllPersonas(
      search: _search,
      estado: 'VETERINARIOS',
      token: '${dataUser!.token}',
    );
    if (response != null) {
      _errorAllPersonas = true;
      setListaAllPersonas(response['data']);

      // setListaTodasLasRazas(response['data'][0]['espRazas']);

      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorAllPersonas = false;
      notifyListeners();
      return null;
    }
    return null;
  }

//================================AGREGA MEDICAMENTOA=============================================//
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

  //==========================================================================================//
  String? _inputCantidadMedicina;
  get getInputCantidadMedicina => _inputCantidadMedicina;
  void onInputCantidadMedicinaChange(String? date) async {
    _inputCantidadMedicina = date;
    // print('_inputCantidadMedicina =====>$_inputCantidadMedicina');

    notifyListeners();
  }

  String? _inputMedicamentoMedicina='';
  get getInputMedicamentoMedicina => _inputMedicamentoMedicina;
  void onInputMedicamentoMedicinaChange(String? date) async {
    _inputMedicamentoMedicina = date;
    // print('_inputMedicamentoMedicina =====>$_inputMedicamentoMedicina');

    notifyListeners();
  }
  String? _inputSerieMedicina='';
  get getInputSerieMedicina => _inputSerieMedicina;
  void onInputSerieMedicinaChange(String? date) async {
    _inputSerieMedicina = date;
    // print('_inputSerieMedicina =====>$_inputSerieMedicina');

    notifyListeners();
  }

  String? _inputTratamientoMedicina;
  get getInputTratamientoMedicina => _inputTratamientoMedicina;
  void onInputTratamientoMedicinaChange(String? date) async {
    _inputTratamientoMedicina = date;
    // print('_inputTratamientoMedicina =====>$_inputTratamientoMedicina');

    notifyListeners();
  }

  List<Map<String, dynamic>> _listMedicamentos = [];
  Map<String, dynamic> _medicamentoNew = {};
  int? idItem = 0;
  void addMedicamento() {
    _medicamentoNew = {
      "order": idItem,
      "cantidad": _inputCantidadMedicina,
      "medicina": _inputMedicamentoMedicina,
      "tratamiento": _inputTratamientoMedicina,
      "serie": _inputSerieMedicina,
    };
    setNuevoMedicamento(_medicamentoNew);
    // print('ESTE MEDICAMENTO ===***** ==>$_listMedicamentos');
    idItem = idItem! + 1;
  }

  //============ELIMINA ELEMENTO DE LA LISTA DE MEDICAMENTOS=====================//
  void eliminaMedicinaAgregada(int rowSelect) {
    _nuevoMedicamento.removeWhere((e) => e['order'] == rowSelect);
    notifyListeners();
  }
  //============ELIMINA ELEMENTO DE LA LISTA DE MEDICAMENTOS=====================//

bool _isFechaCita=false;
bool get getIsFechaCita=>_isFechaCita;

  void setisFechaCita(bool _estado) {
_isFechaCita=_estado;
    notifyListeners();
  }

  //================================== CREA RECETA  ==============================//
  Future creaReceta(
    BuildContext context,
  ) async {
    final serviceSocket = context.read<SocketService>();
    final infoUser = await Auth.instance.getSession();


    final _pyloadNuevaReceta = 
    {
      "tabla": "receta",
      "rucempresa": infoUser!.rucempresa, // LOGIN
      "rol": infoUser.rol, //LOGIN

      "recId": "",
      "recMascId": _idMascota,
      "recMascNombre": _nombreMascota,


      "recMascRaza": _razaMascota,
			"recMascSexo": _sexoMascota,
			"recMascEdad": _edadMascota,
      "recPeso": _pesoMascota,

      "recPerIdPropietario": _propietarioIdMascota,
      "recPerDocNumeroPropietario": _propietarioCedulaMascota,
      "recPerNombrePropietario": _propietarioMascota,
			"recPerTelefonoPropietario": _propietarioTelefonoMascota,
			"recPerCelularPropietario": _propietarioCelularMascota,
			"recPerDireccionPropietario": _propietarioDirecionMascota,
			"recPerEmailPropietario": _propietarioEmailMascota,



      "recPerIdDoc": _doctorId,
      "recPerNombreDoc": _doctoNombre,
      "recTipo": "1",
      "recCorreo": "PENDIENTE",
      "recRecomendacion": _recomendacionesMascota,
      "recMedicamentos": {
        "arrayMedicamentos":_nuevoMedicamento 
      },
      "recProxCita": _inputFechaProximaCita!=''&& _inputHoraProximaCita!=''?"${_inputFechaProximaCita}T$_inputHoraProximaCita":"",

      "recUser": infoUser.usuario,
      "recEmpresa": infoUser.rucempresa,
      "recFecReg": "",
      "Todos": ""
    };


    // print(
    //     '==========================JSON PARA CREAR NUEVA RECETA ===============================');
    // print(_pyloadNuevaReceta);
    // print(
    //     '==========================SOCKET RECETA ===============================');
   
    serviceSocket.sendMessage('client:guardarData', _pyloadNuevaReceta);
    // serviceSocket.socket!.emit('client:guardarData', _pyloadNuevaReceta);
  }
  //================================== CREA RECETA  ==============================//
  Future editaReceta(
    BuildContext context,
  ) async {
    final serviceSocket = context.read<SocketService>();
    final infoUser = await Auth.instance.getSession();


    final _pyloadEditaReceta = 
    {
      "tabla": "receta",
      "rucempresa": infoUser!.rucempresa, // LOGIN
      "rol": infoUser.rol, //LOGIN

      "recId": _idReceta,
      "recMascId": _idMascota,
      "recMascNombre": _nombreMascota,


      "recMascRaza": _razaMascota,
			"recMascSexo": _sexoMascota,
			"recMascEdad": _edadMascota,
      "recPeso": _pesoMascota,

      "recPerIdPropietario": _propietarioIdMascota,
      "recPerDocNumeroPropietario": _propietarioCedulaMascota,
      "recPerNombrePropietario": _propietarioMascota,
			"recPerTelefonoPropietario": _propietarioTelefonoMascota,
			"recPerCelularPropietario": _propietarioCelularMascota,
			"recPerDireccionPropietario": _propietarioDirecionMascota,
			"recPerEmailPropietario": _propietarioEmailMascota,







      "recPerIdDoc": _doctorId,
      "recPerNombreDoc": _doctoNombre,
      "recTipo": "1",
      "recCorreo": "PENDIENTE",
      "recRecomendacion": _recomendacionesMascota,
      "recMedicamentos": {
        "arrayMedicamentos":_nuevoMedicamento 
      },

      "recProductosAntiguos":_antiguosMedicamento,


      "recProxCita": "${_inputFechaProximaCita}T$_inputHoraProximaCita",

      "recUser":"$_userData ** ${infoUser.usuario}",
      "recEmpresa": infoUser.rucempresa,
      "recFecReg": "",
      "Todos": ""
    };


    // print(
    //     '==========================JSON PARA CREAR Edita RECETA ===============================');
    // print(_pyloadEditaReceta);
    // print(
    //     '==========================SOCKET RECETA ===============================');
   
    serviceSocket.sendMessage('client:actualizarData', _pyloadEditaReceta);
   
    // serviceSocket.socket!.emit('client:actualizarData', _pyloadEditaReceta);
  }
    //================================== ELIMINAR  PRIPIETARIO  ==============================//
  Future eliminaReceta(BuildContext context, int? idReceta) async {
    // final serviceSocket = SocketService();

    final serviceSocket = context.read<SocketService>();
    final infoUser = await Auth.instance.getSession();

 
    final _pyloadEliminaReceta = {
      "tabla": 'receta',
      "rucempresa": infoUser!.rucempresa,
      "rol": infoUser.rol,
      "recId": idReceta,
    };
  serviceSocket.sendMessage('client:eliminarData', _pyloadEliminaReceta);
    // serviceSocket.socket!
    //     .emit('client:eliminarData', _pyloadEliminaReceta);
  }




//=================================================================================================================//
  // ================= VARIABLES DE PAGINACION ====================//
//=================================================================================================================//
//===================BOTON SEARCH PAGINACION ==========================//

  bool _btnSearchRecetasPaginacion = false;
  bool get btnSearchRecetaPaginacion => _btnSearchRecetasPaginacion;

  void setBtnSearchRecetaPaginacion(bool action) {
    _btnSearchRecetasPaginacion = action;
    //  print('==_btnSearchCoros===> $_btnSearchPropietarios');
    notifyListeners();
  }

  //===================INPUT SEARCH PROPIETARIO==========================//
  String _nameSearchRecetaPaginacion = "";
  String get nameSearchRecetaPaginacion =>
      _nameSearchRecetaPaginacion;

  void onSearchTextRecetaPaginacion(String data) {
    _nameSearchRecetaPaginacion = data;
    //  print('VacunNOMBRE:${_nameSearchRecetaPaginacion}');
     }
//=============================================================================//

 //================= LISTA PROPIETARIOS SIN PAGINACION ===================/

  List _listaRecetasPaginacion = [];
  // List<TipoMulta> get getListaTodosLosTiposDeMultas => _listaTodosLosTiposDeMultas;
  List get getListaRecetasPaginacion => _listaRecetasPaginacion;

  void setInfoBusquedaRecetasPaginacion(List data) {
    _listaRecetasPaginacion.addAll(data);
    // print('Recetas :${_listaRecetasPaginacion.length}');

    // for (var item in _listaRecetasPaginacion) {
    //    print('-->:${item['perId']}');
    // }

    notifyListeners();
  }

  bool? _errorRecetasPaginacion; // sera nulo la primera vez
  bool? get getErrorRecetasPaginacion => _errorRecetasPaginacion;
  void setErrorRecetasPaginacion(bool? value) {
    _errorRecetasPaginacion = value;
    notifyListeners();
  }

  bool? _error401RecetasPaginacion = false; // sera nulo la primera vez
  bool? get getError401RecetasPaginacion => _error401RecetasPaginacion;
  void setError401RecetasPaginacion(bool? value) {
    _error401RecetasPaginacion = value;
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

  Future buscaAllRecetasPaginacion(String? _search, bool _isSearch) async {
    final dataUser = await Auth.instance.getSession();
// print('usuario : ${dataUser!.rucempresa}');
    final response = await _api.getAllRecetasPaginacion(
      search: _search,
      page: _page,
      cantidad: _cantidad,
      // documento: "",
      input: 'recId',
      orden: false,
      idmascota:null,
      token: '${dataUser!.token}',
    );

    if (response != null) {
      if (response == 401) {
        setInfoBusquedaRecetasPaginacion([]);
        _error401RecetasPaginacion = true;
        notifyListeners();
        return response;
      } else {
        _errorRecetasPaginacion = true;
        if (_isSearch == true) {
          _listaRecetasPaginacion = [];
        }
        List<dynamic> dataSort = response['data']['results'];
        dataSort.sort((a, b) => b['recFecReg']!.compareTo(a['recFecReg']!));

        setPage(response['data']['pagination']['next']);

        setInfoBusquedaRecetasPaginacion(dataSort);
        notifyListeners();
        return response;
      }

      //===========================================//

    }
    if (response == null) {
      _errorRecetasPaginacion = false;
      notifyListeners();
      return null;
    }
  }
















}

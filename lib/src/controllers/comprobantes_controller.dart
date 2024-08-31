import 'dart:async';

import 'package:flutter/material.dart';


import 'package:neitorcont/src/api/api_provider.dart';
import 'package:neitorcont/src/api/authentication_client.dart';
import 'package:neitorcont/src/models/auth_response.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:printing/printing.dart';


import 'dart:async';

import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

// import 'package:sunmi_printer_plus/enums.dart';
// // import 'package:sunmi_printer_plus/sunmi_printer_plus.dart' as  SunmiPrint;
// import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';
// import 'package:sunmi_printer_plus/sunmi_style.dart';
import 'dart:typed_data';


class ComprobantesController extends ChangeNotifier {
  final _api = ApiProvider();
  GlobalKey<FormState> comprobantesFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> placaFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> cantidadFormKey = GlobalKey<FormState>();

  AuthResponse? usuarios;
  bool validateForm() {
    if (comprobantesFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }
 bool validateFormPlaca() {
    if (placaFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }
   bool validateFormCantidad() {
    if (cantidadFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }
//================== TIPO DE DOCUMENTO  ==========================//
  String _tipoDocumento = '';
  String get getTipoDocumento  => _tipoDocumento;

  void setTipoDocumento(String _tipo) {
   _tipoDocumento =''; 
   _tipoDocumento = _tipo;
     print('==_tipoDocumento===> $_tipoDocumento');
    notifyListeners();
  }
//================== FORMA DE PAGO  ==========================//
  String _formaDePago = '';
  String get getFormaDePago  => _formaDePago;

  void setFormaDePago(String _forma) {
   _formaDePago =''; 
   _formaDePago = _forma;
     print('==_formaDePago===> $_formaDePago');
    notifyListeners();
  }

//================== IMPRESION TERMIC  ==========================//
  final FlutterBluePlus flutterBlue = FlutterBluePlus();

  List<BluetoothDevice> _dispositivos = [];
  BluetoothDevice? _dispositivoConectado;
  BluetoothCharacteristic? _characteristic;
  bool _isScanning = false;
  StreamSubscription<List<ScanResult>>? _scanSubscription;

  List<BluetoothDevice> get dispositivos => _dispositivos;
  BluetoothDevice? get dispositivoConectado => _dispositivoConectado;
  bool get isScanning => _isScanning;

  Future<void> checkPermissions() async {
    final status = await Permission.bluetoothScan.status;
    if (!status.isGranted) {
      await Permission.bluetoothScan.request();
    }
    final locationStatus = await Permission.locationWhenInUse.status;
    if (!locationStatus.isGranted) {
      await Permission.locationWhenInUse.request();
    }
  }

  Future<void> ensureBluetoothEnabled() async {
    final isSupported = await FlutterBluePlus.isSupported;
    final adapterState = await FlutterBluePlus.adapterState.first;

    if (!isSupported) {
      // Informar al usuario que Bluetooth no es compatible
      // Puedes usar un diálogo para informar al usuario
      print("Bluetooth no es compatible con este dispositivo.");
      return;
    }

    if (adapterState != BluetoothAdapterState.on) {
      // Solicitar al usuario que habilite Bluetooth
      print("Bluetooth está apagado. Por favor, enciéndelo.");
      // Puedes usar un diálogo para informar al usuario
    }
  }

  void scanDispositivos() async {
    await checkPermissions();
    await ensureBluetoothEnabled();

    _dispositivos.clear();
    _isScanning = true;
    notifyListeners();

    // Iniciar el escaneo
    await FlutterBluePlus.startScan(timeout: Duration(seconds: 4));

    // Escuchar los resultados del escaneo
    _scanSubscription = FlutterBluePlus.scanResults.listen((results) {
      print('Resultados del escaneo: $results');
      for (ScanResult result in results) {
        print('Dispositivo encontrado: ${result.device.name}');
        if (!_dispositivos.contains(result.device) && result.device.name.isNotEmpty) {
          _dispositivos.add(result.device);
          notifyListeners();
        }
      }
    });

    // Manejo del final del escaneo
    await Future.delayed(Duration(seconds: 10)); // Asegúrate de que el tiempo de espera coincida con el timeout
    await FlutterBluePlus.stopScan(); // Detener el escaneo después del timeout
    _isScanning = false;
    _scanSubscription?.cancel(); // Cancelar la suscripción
    notifyListeners();
  }

  Future<void> conectarDispositivo(BluetoothDevice dispositivo) async {
    try {
      await dispositivo.connect();
      _dispositivoConectado = dispositivo;
      notifyListeners();

      // Descubre los servicios del dispositivo
      List<BluetoothService> services = await dispositivo.discoverServices();
      for (BluetoothService service in services) {
        for (BluetoothCharacteristic characteristic in service.characteristics) {
          // Filtra por características que soporten escritura
          if (characteristic.properties.write) {
            _characteristic = characteristic;
            break;
          }
        }
      }
    } catch (e) {
      print("Error conectando al dispositivo: $e");
    }
  }

  void imprimir() async {
  if (_characteristic != null) {
    // Crea el perfil de capacidad para ESC/POS
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm58, profile);

    // Configura el texto con diferentes estilos
    final List<int> bytes = [
      // Tamaño de fuente grande
      ...generator.setStyles(PosStyles(align: PosAlign.center, height: PosTextSize.size2, width: PosTextSize.size2)),
      ...generator.text('¡Hola desde Flutter!', styles: PosStyles(align: PosAlign.center)),
      ...generator.text('JESUS ES MI PASTOR', styles: PosStyles(align: PosAlign.center, height: PosTextSize.size2, width: PosTextSize.size2)),
      
      // Tamaño de fuente normal
      ...generator.setStyles(PosStyles(align: PosAlign.center, height: PosTextSize.size1, width: PosTextSize.size1)),
      ...generator.text('NADA ME FALTARA EN LUGARES DE DELICADOS PASTOS ME HARA DESCANZAR!'),
      
      // Espacio entre líneas
      ...generator.text(''), // Línea en blanco para espacio
      
      // Aplicar negrita
      ...generator.setStyles(PosStyles(bold: true)),
      ...generator.text('Texto en negrita'),
      ...generator.setStyles(PosStyles(bold: false)),

      // Aplicar subrayado
      ...generator.setStyles(PosStyles(underline: true)),
      ...generator.text('Texto subrayado'),
      ...generator.setStyles(PosStyles(underline: false)),

      // Alineación derecha
      ...generator.setStyles(PosStyles(align: PosAlign.right)),
      ...generator.text('Texto alineado a la derecha'),

      // Restablecer estilos
      // ...generator.setStyles(),
      
      // Saltar una línea
      ...generator.text(''), // Línea en blanco para espacio
      
      // Finalizar el texto
      ...generator.feed(2), // Alimenta dos líneas hacia adelante
      ...generator.cut(),
    ];

    // Tamaño máximo permitido por el dispositivo (ajustar según tu dispositivo)
    const maxDataLength = 182;
    
    // Fragmentar los datos y enviarlos
    for (int i = 0; i < bytes.length; i += maxDataLength) {
      final end = (i + maxDataLength < bytes.length) ? i + maxDataLength : bytes.length;
      final chunk = bytes.sublist(i, end);
      try {
        await _characteristic!.write(chunk, withoutResponse: true);
        // Puedes agregar un pequeño retraso entre envíos si es necesario
        await Future.delayed(Duration(milliseconds: 100));
      } catch (e) {
        print("Error al escribir en la característica: $e");
        break;
      }
    }
  } else {
    print("No hay dispositivo conectado o característica de impresión no encontrada.");
  }
}


  void desconectarDispositivo() {
    _dispositivoConectado?.disconnect();
    _dispositivoConectado = null;
    _characteristic = null;
    notifyListeners();
  }



//================== RADIOS  ==========================//

 int _selectedValue = 0; // Valor predeterminado del botón seleccionado

  int get selectedValue => _selectedValue;

  void setSelectedValue(int value) {
    _selectedValue = value;
    notifyListeners();
  }

//================== SELECCIONA COMBUSTIBLE  ==========================//

 String _selectedTextCombustible = 'Extra con Ethanol';

  String get selectedTextCombustible => _selectedTextCombustible;

  void select(String text) {
    _selectedTextCombustible = text;

    print('se selecciona combustible: $_selectedTextCombustible');
    notifyListeners(); // Notifica a los widgets que el estado ha cambiado
  }



//================== SELECCIONA PRECIO  ==========================//
  int? _selectedIndex;

  int? get selectedIndex => _selectedIndex;

  void selectIndex(int index) {
    _selectedIndex = index;


    print('Selecciona precio: $_selectedIndex ');

    notifyListeners();
  }

//  String _selectedValuePrecio='';

//   String get selectedValuePrecio => _selectedValuePrecio;

//   void selectValuePrecio(String value) {
//     _selectedValuePrecio = value;


//     print('Selecciona Value Precio: $_selectedValuePrecio ');

//     notifyListeners();
//   }
  String? _selectedValuePrecio;

  String? get selectedValuePrecio => _selectedValuePrecio;

  void selectValue(String value) {
    _selectedValuePrecio = value;
    print('Selecciona precio: $selectedValuePrecio ');
    notifyListeners();
  }

//==========================TARIFAS===================================//
final  List<Map<String,dynamic>> _listTarifas=[
{
  "tipo":"CAMIONETAS VACIAS O CARGADAS",
  "valor":"3.00"
},
{
  "tipo":"CAMIONES CARGA COMÚN O VACIO 5 TOMELADAS HACIA ABAJO",
  "valor":"10.00"
},
{
  "tipo":"CAMIONES FC-GD-FF CARGA COMUN O VACIO",
  "valor":"12.50"
},

{
  "tipo":"CAMIONES GH Y MULA CARGA COMUN O VACIO",
  "valor":"15.00"
},
{
  "tipo":"BUS",
  "valor":"2.50"
},
{
  "tipo":"MOTOS",
  "valor":"0.50"
},
{
  "tipo":"METRO CUBICO DE MADERA",
  "valor":"3.50"
},

];



List<Map<String,dynamic>> get listTarifas=>_listTarifas;


Map<String,dynamic> _tipoTarifa={};

Map<String,dynamic> get tipoTarifa=>_tipoTarifa;

void setTarifa(Map<String,dynamic> tarifa){
_tipoTarifa={};
_tipoTarifa=tarifa;
notifyListeners();


}

  //================================INPUT   CANTIDAD=============================================//
  double _cantidad =1.0;
  double get getCantidad => _cantidad;

  void setCantidad(double value) {
    _cantidad = value;

print('LA CANTIDAD ES: $_cantidad');
 calculateTotal();

    notifyListeners();
  }


  //================================INPUT   CANTIDAD=============================================//

 
  double _total = 0.00;
 double get getTotal =>_total;

 void setTotal() {
    _cantidad =1.0;
    _total = 0.00;
    notifyListeners(); // Notifica a los widgets escuchando este provider
  }
 

 

  // Método privado para calcular el total
  void calculateTotal() {
    if (_cantidad==0.0) {
      _cantidad=1.0;
    }
    _total =_tipoTarifa['valor']==null?0: double.parse(_tipoTarifa['valor']) * _cantidad;
    notifyListeners(); // Notifica a los widgets escuchando este provider
  }

//============================= BUSCA CLIENTE COMPROBANTES  ================================//
Map<String,dynamic> _clienteComprobante={};
Map<String,dynamic> get getClienteComprobante=>_clienteComprobante;
void setClienteComprbante(Map<String,dynamic> _info){
  _clienteComprobante={};
_clienteComprobante.addAll(_info);


if (_clienteComprobante.isNotEmpty) {
   _listaAddPlacas=[];
  for (var item in _clienteComprobante['perOtros']) {
   _listaAddPlacas!.add(item);
  
}
}


print('EL CLIENTE ENCOTRADO > $_clienteComprobante');
  notifyListeners();
  
}


 Future buscaClienteComprobante() async {
    final dataUser = await Auth.instance.getSession();
// print('usuario : ${dataUser!.rucempresa}');
    final response = await _api.searchClienteComprobante(
      search: _documento,
      token: '${dataUser!.token}',
    );

    if (response != null) {
      if (response.isNotEmpty) {
        setClienteComprbante(response[0]);
         return response;
      } else {
             setClienteComprbante({});
              return {};
      }
      
    
  // print('==LA DATA ===> $response');

        
        // filtrarFacturasDeHoy(dataSort);



       
      }

      //===========================================//

    
    if (response == null) {
     
   
      return null;
    }
 }

//********************//

//================================SELECCIONAMOS EL COLOR=============================================//
 String? _documento = '';
  String? get getDocumento => _documento;

  void setDocumento(String? value) {
  _documento = value;
    print('==_documento ===> $_documento');
    notifyListeners();
  }


//========================== LISTA DE PLACAS  =======================//
  String? _itemAddPlaca = '';
  String? get getItemAddPlaca => _itemAddPlaca;

  void seItemAddPlaca(String? valor) {
    _itemAddPlaca = valor;
    // print('item Celulars: $_itemAddCelulares');
    notifyListeners();
  }


  List? _listaAddPlacas = [];
  List? get getlistaAddPlacas => _listaAddPlacas;

  void agregaListaPlacas( ) {
    _listaAddPlacas!.add(_itemAddPlaca);

    notifyListeners();
  }

  void eliminaPlaca(String? _placa) {
    _listaAddPlacas!.removeWhere((e) => e == _placa);

    notifyListeners();
  }
  resetPlacas(){
     _listaAddPlacas!.clear();
  }

//****************BUSCA PRODUCTOS ******************//

List<Map<String,dynamic>> _listaDeProductosFactura=[]; 

List<Map<String,dynamic>> get getListaDeProductosFactura=>_listaDeProductosFactura; 

void setListaDeProductosFactura(Map<String,dynamic> _item){
    _listaDeProductosFactura.removeWhere((e) => e['invId']==_item['invId']);
  _listaDeProductosFactura.add(_item); 
  print('TODOS LOS PRODUCTOSFactura :$_listaDeProductosFactura');
  notifyListeners();
}

//*************************ELIMINA EL ITEM SELECCIONADO ****************************//
void deleteItem(Map<String, dynamic> itemToDelete) {
  // Verifica si la clave 'venProductos' existe y si es una lista
  if (_respuestaCalculoItem.containsKey('venProductos') && _respuestaCalculoItem['venProductos'] is List) {
    // Convierte la lista de productos a una lista de mapas
    List<Map<String, dynamic>> productos = List<Map<String, dynamic>>.from(_respuestaCalculoItem['venProductos']);
    // Elimina el item que coincide con el código y descripción dados
    productos.removeWhere((producto) =>
        producto['codigo'] == itemToDelete['codigo'] &&
        producto['descripcion'] == itemToDelete['descripcion']);
    // Actualiza la lista de productos en el mapa original
    _respuestaCalculoItem['venProductos'] = productos;
  } 

enviaProductoCalculo({},0);



notifyListeners();
  // Imprime la lista actualizada de productos
  print('Lista de productos después de la eliminación:');
  print(_respuestaCalculoItem['venProductos']);
}


void resetListasProdutos(){
_listaDeProductosFactura=[];
 _listaDeProductos=[]; 
  _respuestaCalculoItem={}; 
  
 notifyListeners();
}


List _listaDeProductos=[]; 

List get getListaDeProductos=>_listaDeProductos; 

void setListaDeProductos(List _list){
  _listaDeProductos=[]; 
  _listaDeProductos.addAll(_list); 
  print('TODOS LOS PRODUCTOS :$_listaDeProductos');
  notifyListeners();
}




 Future buscaAllProductos() async {
    final dataUser = await Auth.instance.getSession();
// print('usuario : ${dataUser!.rucempresa}');
    final response = await _api.searchAllProductos(
    
      token: '${dataUser!.token}',
    );

    if (response != null) {

      
        setListaDeProductos(response);
    }

    
    if (response == null) {
     
   
      return null;
    }
 }

//*********ENVIA ITEM PARA CALCULO***********//


Map<String,dynamic> _respuestaCalculoItem={};

Map<String,dynamic> get getRespuestaCalculoItem=>_respuestaCalculoItem;


void setRespuestaCalculoItem(Map<String,dynamic> _item){
   _respuestaCalculoItem={};
  _respuestaCalculoItem.addAll(_item); 
 
 
  print('RESPUESTA CALCULO ITEM :$_respuestaCalculoItem');
  notifyListeners();
}

 Future enviaProductoCalculo(Map<String,dynamic> _item, int _action) async {
    final dataUser = await Auth.instance.getSession();

final _data ={
  "porcentajeRecargo": 0, // default
  "tasaIVA": '${dataUser!.iva}',//15, // login => iva
  "listaProductos": _respuestaCalculoItem.isNotEmpty? _respuestaCalculoItem['venProductos']:[], // tomar del json del factura la propiedad 'venProductos'
  "nuevoItem":{
    "codigo":  _action==1?_item['invSerie']:0, // tomar del endpoint del producto seleccionado
    "descripcion": _action==1? _item['invNombre']:'', // tomar del endpoint del producto seleccionado
    "cantidad":  _action==1?_cantidad:0, // cantidad del producto que va vender
    "valUnitarioInterno": _action==1? _item['invprecios'][0]:0, // tomar del endpoint del producto seleccionado
    "descPorcentaje": 0, // Porcentaje de descuento en caso de existir (en la web existe un campo que coloca el porcentaje)
    "llevaIva":  _action==1?_item['invIva']:'', // tomar del endpoint del producto seleccionado
    "incluyeIva": _action==1?_item['invIncluyeIva']:'' // tomar del endpoint del producto seleccionado
  }
};

    final response = await _api.sendProductoCalculos(
      data: _data,
      token: '${dataUser.token}',
    );

    if (response != null) {

            setRespuestaCalculoItem(response);
    }
 if (response == null) {
       return null;
    }


 }





}
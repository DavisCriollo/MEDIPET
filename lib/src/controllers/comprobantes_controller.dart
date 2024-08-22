import 'dart:async';

import 'package:flutter/material.dart';


import 'package:neitorcont/src/api/api_provider.dart';
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

  AuthResponse? usuarios;
  bool validateForm() {
    if (comprobantesFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }


  String _tipoPlaca = '';
  String get getTipoPlaca  => _tipoPlaca;

  void setTipoPlaca(String _tipo) {
   _tipoPlaca =''; 
   _tipoPlaca = _tipo;
     print('==_tipoPlaca===> $_tipoPlaca');
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

//=============================================================//

}
// import 'package:flutter/material.dart';

// // import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// import 'package:neitorcont/src/controllers/comprobantes_controller.dart';
// import 'package:pdf/pdf.dart';
// import 'package:provider/provider.dart';
// // import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';
// import 'dart:typed_data'; // Importa esta biblioteca para utilizar Uint8List


// // class Prueba extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     final printerService = Provider.of<ComprobantesController>(context, listen: false);

// //     return Scaffold(
// //       appBar: AppBar(title: Text('Sunmi V2 Printer')),
// //       body: Center(
// //         child: ElevatedButton(
// //           onPressed: () async {
// //             printerService.printDocument();
// //           },
// //           child: Text('Print Text'),
// //         ),
// //       ),
// //     );
// //   }
// // }


// // ignore_for_file: public_member_api_docs, avoid_redundant_argument_values

// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:printing/printing.dart';

// // class Prueba extends StatelessWidget {




// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       home: Scaffold(
// //         appBar: AppBar(title: Text('title')),
// //         body: PdfPreview(
// //           build: (format) => _generatePdf(format, 'title'),
// //         ),
// //       ),
// //     );
// //   }

// //   Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
// //     final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
// //     final font = await PdfGoogleFonts.nunitoExtraLight();

// //     pdf.addPage(
// //       pw.Page(
// //         pageFormat: format,
// //         build: (context) {
// //           return pw.Column(
// //             children: [
// //               pw.SizedBox(
// //                 width: double.infinity,
// //                 child: pw.FittedBox(
// //                   child: pw.Text(title, style: pw.TextStyle(font: font)),
// //                 ),
// //               ),
// //               pw.SizedBox(height: 20),
// //               pw.Flexible(child: pw.FlutterLogo()),
// //             ],
// //           );
// //         },
// //       ),
// //     );

// //     return pdf.save();
// //   }
// // }

// // class Prueba extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     final bluetoothProvider = Provider.of<ComprobantesController>(context);

// //     return Column(
// //       children: [
// //         ElevatedButton(
// //           onPressed: () {
// //             bluetoothProvider.startScanning();
// //           },
// //           child: Text('Scan for Bluetooth Printers'),
// //         ),
// //         if (bluetoothProvider.isScanning)
// //           CircularProgressIndicator(),
// //         Expanded(
// //           child: ListView.builder(
// //             itemCount: bluetoothProvider.devicesList.length,
// //             itemBuilder: (context, index) {
// //               final device = bluetoothProvider.devicesList[index];
// //               return ListTile(
// //                 title: Text(device.name.isEmpty ? 'Unknown Device' : device.name),
// //                 subtitle: Text(device.id.toString()),
// //                 onTap: () => _connectToDevice(context, device),
// //               );
// //             },
// //           ),
// //         ),
// //       ],
// //     );
// //   }

// //   void _connectToDevice(BuildContext context, BluetoothDevice device) async {
// //     // Aquí puedes agregar el código para conectarte a la impresora y realizar la impresión
// //     print('Connecting to device: ${device.name}');
// //   }
// // }



// // class Prueba extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     final bluetoothProvider = Provider.of<ComprobantesController>(context);

// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Bluetooth Printers'),
// //         actions: [
// //           IconButton(
// //             icon: Icon(Icons.refresh),
// //             onPressed: () {
// //               bluetoothProvider.startScanning();
// //             },
// //           ),
// //         ],
// //       ),
// //       body: Column(
// //         children: [
// //           if (bluetoothProvider.isScanning)
// //             Padding(
// //               padding: const EdgeInsets.all(8.0),
// //               child: Center(child: CircularProgressIndicator()),
// //             ),
// //           Expanded(
// //             child: ListView.builder(
// //               itemCount: bluetoothProvider.devicesList.length,
// //               itemBuilder: (context, index) {
// //                 final device = bluetoothProvider.devicesList[index];
// //                 return ListTile(
// //                   title: Text(device.name.isEmpty ? 'Unknown Device' : device.name),
// //                   subtitle: Text(device.id.toString()),
// //                   onTap: () => _connectToDevice(context, device),
// //                 );
// //               },
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   void _connectToDevice(BuildContext context, BluetoothDevice device) async {
// //     // Aquí puedes agregar el código para conectarte a la impresora y realizar la impresión
// //     print('Connecting to device: ${device.name}');
// //     // Ejemplo: Conectar al dispositivo
// //     await device.connect();
// //     // Realizar acciones adicionales, como enviar datos a la impresora
// //   }
// // }



// // class Prueba extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     final bluetoothProvider = Provider.of<ComprobantesController>(context);

// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Bluetooth Printers'),
// //         actions: [
// //           IconButton(
// //             icon: Icon(Icons.refresh),
// //             onPressed: () {
// //               bluetoothProvider.startScanning();
// //             },
// //           ),
// //         ],
// //       ),
// //       body: Column(
// //         children: [
// //           if (bluetoothProvider.isScanning)
// //             Padding(
// //               padding: const EdgeInsets.all(8.0),
// //               child: Center(child: CircularProgressIndicator()),
// //             ),
// //           Expanded(
// //             child: ListView.builder(
// //               itemCount: bluetoothProvider.devicesList.length,
// //               itemBuilder: (context, index) {
// //                 final device = bluetoothProvider.devicesList[index];
// //                 return ListTile(
// //                   title: Text(device.name.isEmpty ? 'Unknown Device' : device.name),
// //                   subtitle: Text(device.id.toString()),
// //                   onTap: () => _connectToDevice(context, device),
// //                 );
// //               },
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   void _connectToDevice(BuildContext context, BluetoothDevice device) async {
// //     print('Connecting to device: ${device.name}');
// //     await device.connect();
// //   }
// // }


// // class Prueba extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     final bluetoothProvider = Provider.of<ComprobantesController>(context);

// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Bluetooth Printers'),
// //         actions: [
// //           IconButton(
// //             icon: Icon(Icons.refresh),
// //             onPressed: () {
// //               bluetoothProvider.startScanning();
// //             },
// //           ),
// //         ],
// //       ),
// //       body: Column(
// //         children: [
// //           if (bluetoothProvider.isScanning)
// //             Padding(
// //               padding: const EdgeInsets.all(8.0),
// //               child: Center(child: CircularProgressIndicator()),
// //             ),
// //           Expanded(
// //             child: ListView.builder(
// //               itemCount: bluetoothProvider.devicesList.length,
// //               itemBuilder: (context, index) {
// //                  print('Connecting to device: ${bluetoothProvider.devicesList[index]}');
// //                 final device = bluetoothProvider.devicesList[index];
// //                 return ListTile(
// //                   title: Text('asdasd'),//Text(device.platformName.isEmpty ? 'Unknown Device' : device.platformName),
// //                   subtitle: Text(device.id.toString()),
// //                   onTap: () => _connectToDevice(context, device),
// //                 );
// //               },
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   void _connectToDevice(BuildContext context, BluetoothDevice device) async {
// //     print('Connecting to device: ${device.platformName}');
// //     await device.connect();
// //   }
// // }



// // class Prueba extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     final bluetoothProvider = Provider.of<ComprobantesController>(context);

// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Bluetooth Printers'),
// //         actions: [
// //           IconButton(
// //             icon: Icon(Icons.refresh),
// //             onPressed: () {
// //               bluetoothProvider.startScanning();
// //             },
// //           ),
// //         ],
// //       ),
// //       body: Column(
// //         children: [
// //           if (bluetoothProvider.isScanning)
// //             Padding(
// //               padding: const EdgeInsets.all(8.0),
// //               child: Center(child: CircularProgressIndicator()),
// //             ),
// //           Expanded(
// //             child: ListView.builder(
// //               itemCount: bluetoothProvider.devicesList.length,
// //               itemBuilder: (context, index) {
// //                 final device = bluetoothProvider.devicesList[index];
// //                 print('Building item for device: ${device.platformName}'); // Debug: imprime el dispositivo en construcción
// //                 return ListTile(
// //                   title: Text(device.platformName.isEmpty ? 'Unknown Device' : device.platformName),
// //                   subtitle: Text(device.id.toString()),
// //                   onTap: () => _connectToDevice(context, device),
// //                 );
// //               },
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   void _connectToDevice(BuildContext context, BluetoothDevice device) async {
// //     print('Connecting to device: ${device.platformName}');
// //     await device.connect();
// //   }
// // }



// class Prueba extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final bluetoothProvider = Provider.of<ComprobantesController>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Bluetooth Devices'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.search),
//             onPressed: () {
//               bluetoothProvider.searchForConnectedDevices();
//             },
//           ),
//         ],
//       ),
//       body: ListView.builder(
//         itemCount: bluetoothProvider.devices.length,
//         itemBuilder: (context, index) {
//           final device = bluetoothProvider.devices[index];
//           return ListTile(
//             title: Text(device.name.isNotEmpty ? device.name : 'Unknown Device'),
//             subtitle: Text(device.id.toString()),
//             trailing: ElevatedButton(
//               onPressed: () {
//                 bluetoothProvider.connectToDevice(device);
//               },
//               child: Text('Connect'),
//             ),
//           );
//         },
//       ),
//     );
//   }






// }


import 'dart:async';

import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:neitorcont/src/controllers/comprobantes_controller.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';


class BluetoothPrintPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bluetoothProvider = Provider.of<ComprobantesController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Impresora Bluetooth'),
      ),
      body: Column(
        children: [
          // Botón para escanear dispositivos
          ElevatedButton(
            onPressed: () {
              bluetoothProvider.scanDispositivos();
            },
            child: Text('Buscar dispositivos Bluetooth'),
          ),
          // Indicador de carga o lista de dispositivos encontrados
          Expanded(
            child: bluetoothProvider.isScanning
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : bluetoothProvider.dispositivos.isEmpty
                    ? Center(
                        child: Text(
                          'No hay Dispositivos cerca',
                          style: TextStyle(fontSize: 16),
                        ),
                      )
                    : ListView.builder(
                        itemCount: bluetoothProvider.dispositivos.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(bluetoothProvider.dispositivos[index].name),
                            subtitle: Text(bluetoothProvider.dispositivos[index].id.toString()),
                            onTap: () {
                              bluetoothProvider.conectarDispositivo(bluetoothProvider.dispositivos[index]);
                              
                              // Mostrar Snackbar al conectar
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Conectado a ${bluetoothProvider.dispositivos[index].name}',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            },
                          );
                        },
                      ),
          ),
          // Botón para imprimir
          ElevatedButton(
            onPressed: () {
              bluetoothProvider.imprimir();
            },
            child: Text('Imprimir'),
          ),
        ],
      ),
    );
  }







}
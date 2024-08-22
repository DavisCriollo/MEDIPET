

// import 'package:bluetooth_print/bluetooth_print_model.dart';
// import 'package:flutter_blue/flutter_blue.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart' as flutterBlue;
// import 'package:bluetooth_print/bluetooth_print.dart';
// import 'package:bluetooth_print/bluetooth_print_model.dart' as btPrint;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';


// class PrintPage extends StatefulWidget {
//   final List<Map<String, dynamic>> data;
//   PrintPage(this.data);

//   @override
//   _PrintPageState createState() => _PrintPageState();
// }

// class _PrintPageState extends State<PrintPage> {
//   BluetoothPrint bluetoothPrint = BluetoothPrint.instance;
//   List<btPrint.BluetoothDevice> _devices = [];
//   String _devicesMsg = "";
//   final f = NumberFormat("\$###,###.00", "en_US");

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance?.addPostFrameCallback((_) => {initPrinter()});
//   }

//   Future<void> initPrinter() async {
//     bluetoothPrint.startScan(timeout: Duration(seconds: 2));

//     if (!mounted) return;
//     bluetoothPrint.scanResults.listen(
//       (val) {
//         if (!mounted) return;
//         setState(() => {_devices = val});
//         if (_devices.isEmpty)
//           setState(() {
//             _devicesMsg = "No Devices";
//           });
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Select Printer'),
//         backgroundColor: Colors.redAccent,
//       ),
//       body: _devices.isEmpty
//           ? Center(
//               child: Text(_devicesMsg ?? ''),
//             )
//           : ListView.builder(
//               itemCount: _devices.length,
//               itemBuilder: (c, i) {
//                 return ListTile(
//                   leading: Icon(Icons.print),
//                   title: Text(_devices[i].name!),
//                   subtitle: Text(_devices[i].address!),
//                   onTap: () {
//                     _startPrint(_devices[i]);
//                   },
//                 );
//               },
//             ),
//     );
//   }

//   Future<void> _startPrint(BluetoothDevice device) async {
//     if (device != null && device.address != null) {
//       await bluetoothPrint.connect(device);

//       Map<String, dynamic> config = Map();
//       List<LineText> list = [];

//       list.add(
//         LineText(
//           type: LineText.TYPE_TEXT,
//           content: "Grocery App",
//           weight: 2,
//           width: 2,
//           height: 2,
//           align: LineText.ALIGN_CENTER,
//           linefeed: 1,
//         ),
//       );

//       for (var i = 0; i < widget.data.length; i++) {
//         list.add(
//           LineText(
//             type: LineText.TYPE_TEXT,
//             content: widget.data[i]['title'],
//             weight: 0,
//             align: LineText.ALIGN_LEFT,
//             linefeed: 1,
//           ),
//         );

//         list.add(
//           LineText(
//             type: LineText.TYPE_TEXT,
//             content:
//                 "${f.format(this.widget.data[i]['price'])} x ${this.widget.data[i]['qty']}",
//             align: LineText.ALIGN_LEFT,
//             linefeed: 1,
//           ),
//         );
//       }
//     }
//   }
// }

// class HomePages extends StatelessWidget {
//   final List<Map<String, dynamic>> data = [
//     {'title': 'Cadbury Dairy Milk', 'price': 15, 'qty': 2},
//     {'title': 'Parle-G Gluco Biscut', 'price': 5, 'qty': 5},
//     {'title': 'Fresh Onion - 1KG', 'price': 20, 'qty': 1},
//     {'title': 'Fresh Sweet Lime', 'price': 20, 'qty': 5},
//     {'title': 'Maggi', 'price': 10, 'qty': 5},
//   ];

//   final f = NumberFormat("\$###,###.00", "en_US");

//   @override
//   Widget build(BuildContext context) {
//     int _total = 0;
//     _total = data.map((e) => e['price'] * e['qty']).reduce(
//           (value, element) => value + element,
//         );

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Flutter - Thermal Printer'),
//         backgroundColor: Colors.redAccent,
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: data.length,
//               itemBuilder: (c, i) {
//                 return ListTile(
//                   title: Text(
//                     data[i]['title'].toString(),
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   subtitle: Text(
//                     "${f.format(data[i]['price'])} x ${data[i]['qty']}",
//                   ),
//                   trailing: Text(
//                     f.format(
//                       data[i]['price'] * data[i]['qty'],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Container(
//             color: Colors.grey[200],
//             padding: EdgeInsets.all(20),
//             child: Row(
//               children: [
//                 Text(
//                   "Total: ${f.format(_total)}",
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(
//                   width: 80,
//                 ),
//                 Expanded(
//                   child: TextButton.icon(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => PrintPage(data),
//                         ),
//                       );
//                     },
//                     icon: Icon(Icons.print),
//                     label: Text('Print'),
//                     style: TextButton.styleFrom(
//                         primary: Colors.white, backgroundColor: Colors.green),
//                   ),
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }


//**********************CODIGO OK ****************/
// class HomePages extends StatelessWidget {
//   final List<Map<String, dynamic>> data = [
//     {'title': 'Cadbury Dairy Milk', 'price': 15, 'qty': 2},
//     {'title': 'Parle-G Gluco Biscut', 'price': 5, 'qty': 5},
//     {'title': 'Fresh Onion - 1KG', 'price': 20, 'qty': 1},
//     {'title': 'Fresh Sweet Lime', 'price': 20, 'qty': 5},
//     {'title': 'Maggi', 'price': 10, 'qty': 5},
//   ];

//   final f = NumberFormat("\$###,###.00", "en_US");

//   @override
//   Widget build(BuildContext context) {
//     int _total = data.fold<int>(
//       0,
//       (prev, item) => prev + (item['price'] as int )* (item['qty'] as int),
//     );

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Flutter - Thermal Printer'),
//         backgroundColor: Colors.redAccent,
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: data.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(
//                     data[index]['title'].toString(),
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   subtitle: Text(
//                     "${f.format(data[index]['price'])} x ${data[index]['qty']}",
//                   ),
//                   trailing: Text(
//                     f.format(data[index]['price'] * data[index]['qty']),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Container(
//             color: Colors.grey[200],
//             padding: EdgeInsets.all(20),
//             child: Row(
//               children: [
//                 Text(
//                   "Total: ${f.format(_total)}",
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(width: 80),
//                 Expanded(
//                   child: TextButton.icon(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => PrintPage(data),
//                         ),
//                       );
//                     },
//                     icon: Icon(Icons.print),
//                     label: Text('Print'),
//                     style: TextButton.styleFrom(
//                       primary: Colors.white,
//                       backgroundColor: Colors.green,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class PrintPage extends StatefulWidget {
//   final List<Map<String, dynamic>> data;
//   PrintPage(this.data);

//   @override
//   _PrintPageState createState() => _PrintPageState();
// }

// class _PrintPageState extends State<PrintPage> {
//   late BluetoothPrint bluetoothPrint;
//   List<btPrint.BluetoothDevice> _devices = [];
//   String _devicesMsg = "";
//   final f = NumberFormat("\$###,###.00", "en_US");

//   @override
//   void initState() {
//     super.initState();
//     bluetoothPrint = BluetoothPrint.instance;
//     WidgetsBinding.instance?.addPostFrameCallback((_) => initPrinter());
//   }

//   Future<void> initPrinter() async {
//     try {
//       bluetoothPrint.startScan(timeout: Duration(seconds: 2));

//       if (!mounted) return;

//       bluetoothPrint.scanResults.listen((val) {
//         if (!mounted) return;
//         setState(() {
//           _devices = val;
//           _devicesMsg = _devices.isEmpty ? "No Devices" : "";
//         });
//       });
//     } catch (e) {
//       print('Error initializing printer: $e');
//     }
//   }


// Future<void> _startPrint(btPrint.BluetoothDevice device) async {
//   if (device != null && device.address != null) {
//     try {
//       // Intentar conectar al dispositivo Bluetooth
//       await bluetoothPrint.connect(device);

//       // Espera el estado de la conexión
//       bool? isConnected = await bluetoothPrint.isConnected;

//       // Verifica si la conexión fue exitosa
//       if (isConnected == null || !isConnected) {
//         print('Error: No se pudo conectar al dispositivo.');
//         return;
//       }

//       // Configuración del impresor
//       Map<String, dynamic> config = {};
//       List<LineText> list = [];

//       // Agregar encabezado
//       list.add(
//         LineText(
//           type: LineText.TYPE_TEXT,
//           content: "Grocery App",
//           weight: 2,
//           width: 2,
//           height: 2,
//           align: LineText.ALIGN_CENTER,
//           linefeed: 1,
//         ),
//       );

//       // Agregar contenido de los datos
//       for (var item in widget.data) {
//         list.add(
//           LineText(
//             type: LineText.TYPE_TEXT,
//             content: item['title'],
//             weight: 0,
//             align: LineText.ALIGN_LEFT,
//             linefeed: 1,
//           ),
//         );

//         list.add(
//           LineText(
//             type: LineText.TYPE_TEXT,
//             content: "${f.format(item['price'])} x ${item['qty']}",
//             align: LineText.ALIGN_LEFT,
//             linefeed: 1,
//           ),
//         );
//       }

//       // Enviar datos para impresión
//       await bluetoothPrint.printReceipt(config, list);

//     } catch (e) {
//       print('Error during printing: $e');
//     } finally {
//       // Asegúrate de desconectar incluso si ocurre un error
//       bool? isConnected = await bluetoothPrint.isConnected;
//       if (isConnected == true) {
//         await bluetoothPrint.disconnect();
//       }
//     }
//   } else {
//     print('Invalid Bluetooth device.');
//   }
// }



//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Select Printer'),
//         backgroundColor: Colors.redAccent,
//       ),
//       body: _devices.isEmpty
//           ? Center(
//               child: Text(_devicesMsg),
//             )
//           : ListView.builder(
//               itemCount: _devices.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   leading: Icon(Icons.print),
//                   title: Text(_devices[index].name ?? 'Unknown'),
//                   subtitle: Text(_devices[index].address ?? 'No Address'),
//                   onTap: () => _startPrint(_devices[index]),
//                 );
//               },
//             ),
//     );
//   }
// }





// class HomePages extends StatelessWidget {
//   final List<Map<String, dynamic>> data = [
//     {'title': 'Cadbury Dairy Milk', 'price': 15, 'qty': 2},
//     {'title': 'Parle-G Gluco Biscut', 'price': 5, 'qty': 5},
//     {'title': 'Fresh Onion - 1KG', 'price': 20, 'qty': 1},
//     {'title': 'Fresh Sweet Lime', 'price': 20, 'qty': 5},
//     {'title': 'Maggi', 'price': 10, 'qty': 5},
//   ];

//   final f = NumberFormat("\$###,###.00", "en_US");

//   @override
//   Widget build(BuildContext context) {
//     int _total = data.fold<int>(
//       0,
//       (prev, item) => prev + (item['price'] as int) * (item['qty'] as int),
//     );

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Flutter - Thermal Printer'),
//         backgroundColor: Colors.redAccent,
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: data.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(
//                     data[index]['title'].toString(),
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   subtitle: Text(
//                     "${f.format(data[index]['price'])} x ${data[index]['qty']}",
//                   ),
//                   trailing: Text(
//                     f.format(data[index]['price'] * data[index]['qty']),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Container(
//             color: Colors.grey[200],
//             padding: EdgeInsets.all(20),
//             child: Row(
//               children: [
//                 Text(
//                   "Total: ${f.format(_total)}",
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(width: 80),
//                 Expanded(
//                   child: TextButton.icon(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => PrintPage(data),
//                         ),
//                       );
//                     },
//                     icon: Icon(Icons.print),
//                     label: Text('Print'),
//                     style: TextButton.styleFrom(
//                       primary: Colors.white,
//                       backgroundColor: Colors.green,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class PrintPage extends StatefulWidget {
//   final List<Map<String, dynamic>> data;
//   PrintPage(this.data);

//   @override
//   _PrintPageState createState() => _PrintPageState();
// }

// class _PrintPageState extends State<PrintPage> {
//   late BluetoothPrint bluetoothPrint;
//   List<btPrint.BluetoothDevice> _devices = [];
//   String _devicesMsg = "";
//   final f = NumberFormat("\$###,###.00", "en_US");

//   @override
//   void initState() {
//     super.initState();
//     bluetoothPrint = BluetoothPrint.instance;
//     WidgetsBinding.instance?.addPostFrameCallback((_) => initPrinter());
//   }

//   Future<void> initPrinter() async {
//     try {
//       bluetoothPrint.startScan(timeout: Duration(seconds: 2));

//       if (!mounted) return;

//       bluetoothPrint.scanResults.listen((val) {
//         if (!mounted) return;
//         setState(() {
//           _devices = val;
//           _devicesMsg = _devices.isEmpty ? "No Devices" : "";
//         });
//       });
//     } catch (e) {
//       print('Error initializing printer: $e');
//     }
//   }

// Future<void> _startPrint(btPrint.BluetoothDevice device) async {
//   if (device != null && device.address != null) {
//     try {
//       // Intentar conectar al dispositivo Bluetooth
//       await bluetoothPrint.connect(device);

//       // Esperar el estado de la conexión
//       await Future.delayed(Duration(seconds: 2)); // Espera 2 segundos
//       bool? isConnected = await bluetoothPrint.isConnected;

//       // Verifica si la conexión fue exitosa
//       if (isConnected == null || !isConnected) {
//         print('Error: No se pudo conectar al dispositivo.');
//         return;
//       }

//       // Configuración del impresor
//       Map<String, dynamic> config = {};
//       List<LineText> list = [];

//       // Agregar encabezado
//       list.add(
//         LineText(
//           type: LineText.TYPE_TEXT,
//           content: "Grocery App",
//           weight: 2,
//           width: 2,
//           height: 2,
//           align: LineText.ALIGN_CENTER,
//           linefeed: 1,
//         ),
//       );

//       // Agregar contenido de los datos
//       for (var item in widget.data) {
//         list.add(
//           LineText(
//             type: LineText.TYPE_TEXT,
//             content: item['title'],
//             weight: 0,
//             align: LineText.ALIGN_LEFT,
//             linefeed: 1,
//           ),
//         );

//         list.add(
//           LineText(
//             type: LineText.TYPE_TEXT,
//             content: "${f.format(item['price'])} x ${item['qty']}",
//             align: LineText.ALIGN_LEFT,
//             linefeed: 1,
//           ),
//         );
//       }

//       // Enviar datos para impresión
//       await bluetoothPrint.printReceipt(config, list);

//     } catch (e) {
//       print('Error during printing: $e');
//     } finally {
//       // Asegúrate de desconectar incluso si ocurre un error
//       bool? isConnected = await bluetoothPrint.isConnected;
//       if (isConnected == true) {
//         await bluetoothPrint.disconnect();
//       }
//     }
//   } else {
//     print('Invalid Bluetooth device.');
//   }
// }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Select Printer'),
//         backgroundColor: Colors.redAccent,
//       ),
//       body: _devices.isEmpty
//           ? Center(
//               child: Text(_devicesMsg),
//             )
//           : ListView.builder(
//               itemCount: _devices.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   leading: Icon(Icons.print),
//                   title: Text(_devices[index].name ?? 'Unknown'),
//                   subtitle: Text(_devices[index].address ?? 'No Address'),
//                   onTap: () async {
//                     await _startPrint(_devices[index]);
//                   },
//                 );
//               },
//             ),
//     );
//   }
// }

// class BluetoothPrintScreen extends StatefulWidget {
//   @override
//   _BluetoothPrintScreenState createState() => _BluetoothPrintScreenState();
// }

// class _BluetoothPrintScreenState extends State<BluetoothPrintScreen> {
//   FlutterBlue flutterBlue = FlutterBlue.instance;
//   BluetoothDevice? connectedDevice;
//   BluetoothCharacteristic? writeCharacteristic;
//   List<BluetoothDevice> scanResults = [];
//   bool isScanning = false;

//   @override
//   void initState() {
//     super.initState();
//     startScan();
//   }

//   void startScan() async {
//     setState(() {
//       isScanning = true;
//       scanResults.clear();
//     });

//     flutterBlue.startScan(timeout: Duration(seconds: 5));

//     flutterBlue.scanResults.listen((results) {
//       for (ScanResult r in results) {
//         if (!scanResults.contains(r.device)) {
//           setState(() {
//             scanResults.add(r.device);
//           });
//         }
//       }
//     });

//     flutterBlue.isScanning.listen((scanning) {
//       setState(() {
//         isScanning = scanning;
//       });
//     });
//   }

//   void connectToDevice(BluetoothDevice device) async {
//     await device.connect();
//     connectedDevice = device;

//     List<BluetoothService> services = await device.discoverServices();
//     for (var service in services) {
//       for (var characteristic in service.characteristics) {
//         if (characteristic.properties.write) {
//           writeCharacteristic = characteristic;
//           break;
//         }
//       }
//     }

//     if (writeCharacteristic != null) {
//       printReceipt();
//     } else {
//       print("No writable characteristic found");
//     }
//   }

//   void printReceipt() async {
//     if (writeCharacteristic == null) return;

//     List<int> bytes = [
//       // Convert the text to bytes, e.g., using UTF-8 encoding.
//       // These bytes should represent the commands/data for your printer.
//       0x1B, 0x40, // Initialize printer
//       0x1B, 0x21, 0x00, // Normal font size
//       ...utf8.encode("Grocery App\n"),
//       0x1B, 0x21, 0x00, // Normal font size
//       ...utf8.encode("Item 1: \$10.00\n"),
//       ...utf8.encode("Item 2: \$20.00\n"),
//       ...utf8.encode("Total: \$30.00\n"),
//     ];

//     await writeCharacteristic!.write(bytes);
//   }

//   void disconnectFromDevice() async {
//     if (connectedDevice != null) {
//       await connectedDevice!.disconnect();
//       connectedDevice = null;
//       writeCharacteristic = null;
//     }
//   }

//   @override
//   void dispose() {
//     disconnectFromDevice();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Bluetooth Print'),
//       ),
//       body: Column(
//         children: [
//           isScanning
//               ? CircularProgressIndicator()
//               : ElevatedButton(
//                   child: Text('Scan for Devices'),
//                   onPressed: startScan,
//                 ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: scanResults.length,
//               itemBuilder: (context, index) {
//                 BluetoothDevice device = scanResults[index];
//                 return ListTile(
//                   title: Text(device.name),
//                   subtitle: Text(device.id.toString()),
//                   onTap: () => connectToDevice(device),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

//**************************//

  // Future<void> _startPrint(btPrint.BluetoothDevice device) async {
  //   if (device != null && device.address != null) {
  //     try {
  //       await bluetoothPrint.connect(device);

  //       Map<String, dynamic> config = {};
  //       List<LineText> list = [];

  //       list.add(
  //         LineText(
  //           type: LineText.TYPE_TEXT,
  //           content: "Grocery App",
  //           weight: 2,
  //           width: 2,
  //           height: 2,
  //           align: LineText.ALIGN_CENTER,
  //           linefeed: 1,
  //         ),
  //       );

  //       for (var item in widget.data) {
  //         list.add(
  //           LineText(
  //             type: LineText.TYPE_TEXT,
  //             content: item['title'],
  //             weight: 0,
  //             align: LineText.ALIGN_LEFT,
  //             linefeed: 1,
  //           ),
  //         );

  //         list.add(
  //           LineText(
  //             type: LineText.TYPE_TEXT,
  //             content: "${f.format(item['price'])} x ${item['qty']}",
  //             align: LineText.ALIGN_LEFT,
  //             linefeed: 1,
  //           ),
  //         );
  //       }

  //       await bluetoothPrint.printReceipt(config, list);
  //       await bluetoothPrint.disconnect();
  //     } catch (e) {
  //       print('Error during printing: $e');
  //     }
  //   } else {
  //     print('Invalid Bluetooth device.');
  //   }
  // }
//   Future<void> _startPrint(btPrint.BluetoothDevice device) async {
//   if (device != null && device.address != null) {
//     try {
//       // Intentar conectar al dispositivo Bluetooth
//       await bluetoothPrint.connect(device);
      
//       // Verificar que la conexión se haya establecido
//       if (!bluetoothPrint.isConnected) {
//         print('Error: No se pudo conectar al dispositivo.');
//         return;
//       }

//       // Configuración del impresor
//       Map<String, dynamic> config = {};
//       List<LineText> list = [];

//       // Agregar encabezado
//       list.add(
//         LineText(
//           type: LineText.TYPE_TEXT,
//           content: "Grocery App",
//           weight: 2,
//           width: 2,
//           height: 2,
//           align: LineText.ALIGN_CENTER,
//           linefeed: 1,
//         ),
//       );

//       // Agregar contenido de los datos
//       for (var item in widget.data) {
//         list.add(
//           LineText(
//             type: LineText.TYPE_TEXT,
//             content: item['title'],
//             weight: 0,
//             align: LineText.ALIGN_LEFT,
//             linefeed: 1,
//           ),
//         );

//         list.add(
//           LineText(
//             type: LineText.TYPE_TEXT,
//             content: "${f.format(item['price'])} x ${item['qty']}",
//             align: LineText.ALIGN_LEFT,
//             linefeed: 1,
//           ),
//         );
//       }

//       // Enviar datos para impresión
//       await bluetoothPrint.printReceipt(config, list);

//     } catch (e) {
//       print('Error during printing: $e');
//     } finally {
//       // Asegúrate de desconectar incluso si ocurre un error
//       if (bluetoothPrint.isConnected==false) {
//         await bluetoothPrint.disconnect();
//       }
//     }
//   } else {
//     print('Invalid Bluetooth device.');
//   }
// }


// Future<void> _startPrint(btPrint.BluetoothDevice device) async {
//   if (device != null && device.address != null) {
//     try {
//       // Intentar conectar al dispositivo Bluetooth
//       bool isConnected = await bluetoothPrint.connect(device);

//       // Verificar que la conexión se haya establecido
//       if (!isConnected) {
//         print('Error: No se pudo conectar al dispositivo.');
//         return;
//       }

//       // Configuración del impresor
//       Map<String, dynamic> config = {};
//       List<LineText> list = [];

//       // Agregar encabezado
//       list.add(
//         LineText(
//           type: LineText.TYPE_TEXT,
//           content: "Grocery App",
//           weight: 2,
//           width: 2,
//           height: 2,
//           align: LineText.ALIGN_CENTER,
//           linefeed: 1,
//         ),
//       );

//       // Agregar contenido de los datos
//       for (var item in widget.data) {
//         list.add(
//           LineText(
//             type: LineText.TYPE_TEXT,
//             content: item['title'],
//             weight: 0,
//             align: LineText.ALIGN_LEFT,
//             linefeed: 1,
//           ),
//         );

//         list.add(
//           LineText(
//             type: LineText.TYPE_TEXT,
//             content: "${f.format(item['price'])} x ${item['qty']}",
//             align: LineText.ALIGN_LEFT,
//             linefeed: 1,
//           ),
//         );
//       }

//       // Enviar datos para impresión
//       await bluetoothPrint.printReceipt(config, list);

//     } catch (e) {
//       print('Error during printing: $e');
//     } finally {
//       // Asegúrate de desconectar incluso si ocurre un error
//       // `disconnect` debería ser una función para desconectar, verifica la documentación
//       await bluetoothPrint.disconnect();
//     }
//   } else {
//     print('Invalid Bluetooth device.');
//   }
// }



import 'dart:typed_data';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sunmi_printer_plus/column_maker.dart';
import 'package:sunmi_printer_plus/enums.dart';
import 'dart:async';

import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';
import 'package:sunmi_printer_plus/sunmi_style.dart';


class PrintTicket extends StatefulWidget {
  const PrintTicket({Key? key}) : super(key: key);

  @override
  _PrintTicketState createState() => _PrintTicketState();
}

class _PrintTicketState extends State<PrintTicket> {
  bool printBinded = false;
  int paperSize = 0;
  String serialNumber = "";
  String printerVersion = "";
  @override
  void initState() {
    super.initState();

    _bindingPrinter().then((bool? isBind) async {
      SunmiPrinter.paperSize().then((int size) {
        setState(() {
          paperSize = size;
        });
      });

      SunmiPrinter.printerVersion().then((String version) {
        setState(() {
          printerVersion = version;
        });
      });

      SunmiPrinter.serialNumber().then((String serial) {
        setState(() {
          serialNumber = serial;
        });
      });

      setState(() {
        printBinded = isBind!;
      });
    });
  }

  /// must binding ur printer at first init in app
  Future<bool?> _bindingPrinter() async {
    final bool? result = await SunmiPrinter.bindingPrinter();
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Mi Ticket'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                ),
                child: Text("Print binded: " + printBinded.toString()),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Text("Paper size: " + paperSize.toString()),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Text("Serial number: " + serialNumber),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Text("Printer version: " + printerVersion),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          await SunmiPrinter.initPrinter();
                          await SunmiPrinter.startTransactionPrint(true);
                          await SunmiPrinter.printQRCode(
                              'https://github.com/brasizza/sunmi_printer');
                          await SunmiPrinter.lineWrap(2);
                          await SunmiPrinter.exitTransactionPrint(true);
                        },
                        child: const Text('Print qrCode')),
                    ElevatedButton(
                        onPressed: () async {
                          await SunmiPrinter.initPrinter();
                          await SunmiPrinter.startTransactionPrint(true);
                          await SunmiPrinter.printBarCode('1234567890',
                              barcodeType: SunmiBarcodeType.CODE128,
                              textPosition: SunmiBarcodeTextPos.TEXT_UNDER,
                              height: 20);
                          await SunmiPrinter.lineWrap(2);
                          await SunmiPrinter.exitTransactionPrint(true);
                        },
                        child: const Text('Print barCode')),
                    ElevatedButton(
                        onPressed: () async {
                          await SunmiPrinter.initPrinter();
                          await SunmiPrinter.startTransactionPrint(true);
                          await SunmiPrinter.line();
                          await SunmiPrinter.lineWrap(2);
                          await SunmiPrinter.exitTransactionPrint(true);
                        },
                        child: const Text('Print line')),
                    ElevatedButton(
                        onPressed: () async {
                          await SunmiPrinter.lineWrap(2);
                        },
                        child: const Text('Wrap line')),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          await SunmiPrinter.initPrinter();
                          await SunmiPrinter.startTransactionPrint(true);
                          await SunmiPrinter.printText('Hello I\'m bold',
                              style: SunmiStyle(bold: true));
                          await SunmiPrinter.lineWrap(2);
                          await SunmiPrinter.exitTransactionPrint(true);
                        },
                        child: const Text('Bold Text')),
                    ElevatedButton(
                        onPressed: () async {
                          await SunmiPrinter.initPrinter();
                          await SunmiPrinter.startTransactionPrint(true);
                          await SunmiPrinter.printText('Very small!',
                              style: SunmiStyle(fontSize: SunmiFontSize.XS));
                          await SunmiPrinter.lineWrap(2);

                          await SunmiPrinter.exitTransactionPrint(true);
                        },
                        child: const Text('Very small font')),
                    ElevatedButton(
                        onPressed: () async {
                          await SunmiPrinter.initPrinter();
                          await SunmiPrinter.startTransactionPrint(true);
                          await SunmiPrinter.printText('Very small!',
                              style: SunmiStyle(fontSize: SunmiFontSize.SM));
                          await SunmiPrinter.lineWrap(2);
                          await SunmiPrinter.exitTransactionPrint(true);
                        },
                        child: const Text('Small font')),
                    ElevatedButton(
                        onPressed: () async {
                          await SunmiPrinter.initPrinter();
                          await SunmiPrinter.startTransactionPrint(true);
                          await SunmiPrinter.printText('Normal font',
                              style: SunmiStyle(fontSize: SunmiFontSize.MD));

                          await SunmiPrinter.lineWrap(2);
                          await SunmiPrinter.exitTransactionPrint(true);
                        },
                        child: const Text('Normal font')),
                    ElevatedButton(
                        onPressed: () async {
                          await SunmiPrinter.initPrinter();
                          await SunmiPrinter.printText('Large font',
                              style: SunmiStyle(fontSize: SunmiFontSize.LG));

                          await SunmiPrinter.lineWrap(2);
                          await SunmiPrinter.exitTransactionPrint(true);
                        },
                        child: const Text('Large font')),
                    ElevatedButton(
                        onPressed: () async {
                          await SunmiPrinter.initPrinter();
                          await SunmiPrinter.startTransactionPrint(true);
                          await SunmiPrinter.setFontSize(SunmiFontSize.XL);
                          await SunmiPrinter.printText('Very Large font!');
                          await SunmiPrinter.resetFontSize();
                          await SunmiPrinter.lineWrap(2);
                          await SunmiPrinter.exitTransactionPrint(true);
                        },
                        child: const Text('Very large font')),
                    ElevatedButton(
                        onPressed: () async {
                          await SunmiPrinter.initPrinter();
                          await SunmiPrinter.startTransactionPrint(true);
                          await SunmiPrinter.setCustomFontSize(13);
                          await SunmiPrinter.printText('Very Large font!');
                          await SunmiPrinter.resetFontSize();
                          await SunmiPrinter.lineWrap(2);
                          await SunmiPrinter.exitTransactionPrint(true);
                        },
                        child: const Text('Custom size font')),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          await SunmiPrinter.initPrinter();
                          await SunmiPrinter.startTransactionPrint(true);
                          await SunmiPrinter.printText('Align right',
                              style: SunmiStyle(align: SunmiPrintAlign.RIGHT));
                          await SunmiPrinter.lineWrap(2);
                          await SunmiPrinter.exitTransactionPrint(true);
                        },
                        child: const Text('Align right')),
                    ElevatedButton(
                        onPressed: () async {
                          await SunmiPrinter.initPrinter();

                          await SunmiPrinter.startTransactionPrint(true);
                          await SunmiPrinter.printText('Align left',
                              style: SunmiStyle(align: SunmiPrintAlign.LEFT));

                          await SunmiPrinter.lineWrap(2);
                          await SunmiPrinter.exitTransactionPrint(true);
                        },
                        child: const Text('Align left')),
                    ElevatedButton(
                      onPressed: () async {
                        await SunmiPrinter.initPrinter();

                        await SunmiPrinter.startTransactionPrint(true);
                        await SunmiPrinter.printText(
                          'Align center/ LARGE TEXT AND BOLD',
                          style: SunmiStyle(
                              align: SunmiPrintAlign.CENTER,
                              bold: true,
                              fontSize: SunmiFontSize.LG),
                        );

                        await SunmiPrinter.lineWrap(2);
                        await SunmiPrinter.exitTransactionPrint(true);
                      },
                      child: const Text('Align center'),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await SunmiPrinter.initPrinter();

                        Uint8List byte =
                            await _getImageFromAsset('assets/imgs/logo_neitor.png');
                        await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);

                        await SunmiPrinter.startTransactionPrint(true);
                        await SunmiPrinter.printImage(byte);
                        await SunmiPrinter.lineWrap(2);
                        await SunmiPrinter.exitTransactionPrint(true);
                      },
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/imgs/logo_neitor.png',
                            width: 100,
                          ),
                          const Text('Print this image from asset!')
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await SunmiPrinter.initPrinter();

                        String url =
                            'https://avatars.githubusercontent.com/u/14101776?s=100';
                        // convert image to Uint8List format
                        Uint8List byte =
                            (await NetworkAssetBundle(Uri.parse(url)).load(url))
                                .buffer
                                .asUint8List();
                        await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
                        await SunmiPrinter.startTransactionPrint(true);
                        await SunmiPrinter.printImage(byte);
                        await SunmiPrinter.lineWrap(2);
                        await SunmiPrinter.exitTransactionPrint(true);
                      },
                      child: Column(
                        children: [
                          Image.network(
                              'https://avatars.githubusercontent.com/u/14101776?s=100'),
                          const Text('Print this image from WEB!')
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          onPressed: () async {
                            await SunmiPrinter.cut();
                          },
                          child: const Text('CUT PAPER')),
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          onPressed: () async {
                            await SunmiPrinter.initPrinter();

                            await SunmiPrinter.startTransactionPrint(true);
                            await SunmiPrinter.setAlignment(
                                SunmiPrintAlign.CENTER);
                            await SunmiPrinter.line();
                            await SunmiPrinter.printText('Payment receipt');
                            await SunmiPrinter.printText(
                                'Using the old way to bold!');
                            await SunmiPrinter.line();

                            await SunmiPrinter.printRow(cols: [
                              ColumnMaker(
                                  text: 'Name',
                                  width: 12,
                                  align: SunmiPrintAlign.LEFT),
                              ColumnMaker(
                                  text: 'Qty',
                                  width: 6,
                                  align: SunmiPrintAlign.CENTER),
                              ColumnMaker(
                                  text: 'UN',
                                  width: 6,
                                  align: SunmiPrintAlign.RIGHT),
                              ColumnMaker(
                                  text: 'TOT',
                                  width: 6,
                                  align: SunmiPrintAlign.RIGHT),
                            ]);

                            await SunmiPrinter.printRow(cols: [
                              ColumnMaker(
                                  text: 'Fries',
                                  width: 12,
                                  align: SunmiPrintAlign.LEFT),
                              ColumnMaker(
                                  text: '4x',
                                  width: 6,
                                  align: SunmiPrintAlign.CENTER),
                              ColumnMaker(
                                  text: '3.00',
                                  width: 6,
                                  align: SunmiPrintAlign.RIGHT),
                              ColumnMaker(
                                  text: '12.00',
                                  width: 6,
                                  align: SunmiPrintAlign.RIGHT),
                            ]);

                            await SunmiPrinter.printRow(cols: [
                              ColumnMaker(
                                  text: 'Strawberry',
                                  width: 12,
                                  align: SunmiPrintAlign.LEFT),
                              ColumnMaker(
                                  text: '1x',
                                  width: 6,
                                  align: SunmiPrintAlign.CENTER),
                              ColumnMaker(
                                  text: '24.44',
                                  width: 6,
                                  align: SunmiPrintAlign.RIGHT),
                              ColumnMaker(
                                  text: '24.44',
                                  width: 6,
                                  align: SunmiPrintAlign.RIGHT),
                            ]);

                            await SunmiPrinter.printRow(cols: [
                              ColumnMaker(
                                  text: 'Soda',
                                  width: 12,
                                  align: SunmiPrintAlign.LEFT),
                              ColumnMaker(
                                  text: '1x',
                                  width: 6,
                                  align: SunmiPrintAlign.CENTER),
                              ColumnMaker(
                                  text: '1.99',
                                  width: 6,
                                  align: SunmiPrintAlign.RIGHT),
                              ColumnMaker(
                                  text: '1.99',
                                  width: 6,
                                  align: SunmiPrintAlign.RIGHT),
                            ]);

                            await SunmiPrinter.line();
                            await SunmiPrinter.printRow(cols: [
                              ColumnMaker(
                                  text: 'TOTAL',
                                  width: 25,
                                  align: SunmiPrintAlign.LEFT),
                              ColumnMaker(
                                  text: '38.43',
                                  width: 5,
                                  align: SunmiPrintAlign.RIGHT),
                            ]);

                            await SunmiPrinter.printRow(cols: [
                              ColumnMaker(
                                  text: 'ARABIC TEXT',
                                  width: 15,
                                  align: SunmiPrintAlign.LEFT),
                              ColumnMaker(
                                  text: 'اسم المشترك',
                                  width: 15,
                                  align: SunmiPrintAlign.LEFT),
                            ]);

                            await SunmiPrinter.printRow(cols: [
                              ColumnMaker(
                                  text: 'اسم المشترك',
                                  width: 15,
                                  align: SunmiPrintAlign.LEFT),
                              ColumnMaker(
                                  text: 'اسم المشترك',
                                  width: 15,
                                  align: SunmiPrintAlign.LEFT),
                            ]);

                            await SunmiPrinter.printRow(cols: [
                              ColumnMaker(
                                  text: 'RUSSIAN TEXT',
                                  width: 15,
                                  align: SunmiPrintAlign.LEFT),
                              ColumnMaker(
                                  text: 'Санкт-Петербу́рг',
                                  width: 15,
                                  align: SunmiPrintAlign.LEFT),
                            ]);
                            await SunmiPrinter.printRow(cols: [
                              ColumnMaker(
                                  text: 'Санкт-Петербу́рг',
                                  width: 15,
                                  align: SunmiPrintAlign.LEFT),
                              ColumnMaker(
                                  text: 'Санкт-Петербу́рг',
                                  width: 15,
                                  align: SunmiPrintAlign.LEFT),
                            ]);

                            await SunmiPrinter.printRow(cols: [
                              ColumnMaker(
                                  text: 'CHINESE TEXT',
                                  width: 15,
                                  align: SunmiPrintAlign.LEFT),
                              ColumnMaker(
                                  text: '風俗通義',
                                  width: 15,
                                  align: SunmiPrintAlign.LEFT),
                            ]);
                            await SunmiPrinter.printRow(cols: [
                              ColumnMaker(
                                  text: '風俗通義',
                                  width: 15,
                                  align: SunmiPrintAlign.LEFT),
                              ColumnMaker(
                                  text: '風俗通義',
                                  width: 15,
                                  align: SunmiPrintAlign.LEFT),
                            ]);

                            await SunmiPrinter.setAlignment(
                                SunmiPrintAlign.CENTER);
                            await SunmiPrinter.line();
                            await SunmiPrinter.bold();
                            await SunmiPrinter.printText(
                                'Transaction\'s Qrcode');
                            await SunmiPrinter.resetBold();
                            await SunmiPrinter.printQRCode(
                                'https://github.com/brasizza/sunmi_printer');
                            await SunmiPrinter.lineWrap(2);
                            await SunmiPrinter.exitTransactionPrint(true);
                          },
                          child: const Text('TICKET EXAMPLE')),
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          onPressed: () async {
                            final List<int> _escPos = await _customEscPos();
                            await SunmiPrinter.initPrinter();
                            await SunmiPrinter.startTransactionPrint(true);
                            await SunmiPrinter.printRawData(
                                Uint8List.fromList(_escPos));
                            await SunmiPrinter.exitTransactionPrint(true);
                          },
                          child: const Text('Custom ESC/POS to print')),
                    ]),
              ),
            ],
          ),
        ));
  }
}

Future<Uint8List> readFileBytes(String path) async {
  ByteData fileData = await rootBundle.load(path);
  Uint8List fileUnit8List = fileData.buffer
      .asUint8List(fileData.offsetInBytes, fileData.lengthInBytes);
  return fileUnit8List;
}

Future<Uint8List> _getImageFromAsset(String iconPath) async {
  return await readFileBytes(iconPath);
}

Future<List<int>> _customEscPos() async {
  final profile = await CapabilityProfile.load();
  final generator = Generator(PaperSize.mm58, profile);
  List<int> bytes = [];

  bytes += generator.text(
      'Regular: aA bB cC dD eE fF gG hH iI jJ kK lL mM nN oO pP qQ rR sS tT uU vV wW xX yY zZ');
  bytes += generator.text('Special 1: àÀ èÈ éÉ ûÛ üÜ çÇ ôÔ',
      styles: const PosStyles(codeTable: 'CP1252'));
  bytes += generator.text('Special 2: blåbærgrød',
      styles: const PosStyles(codeTable: 'CP1252'));

  bytes += generator.text('Bold text', styles: const PosStyles(bold: true));
  bytes +=
      generator.text('Reverse text', styles: const PosStyles(reverse: true));
  bytes += generator.text('Underlined text',
      styles: const PosStyles(underline: true), linesAfter: 1);
  bytes += generator.text('Align left',
      styles: const PosStyles(align: PosAlign.left));
  bytes += generator.text('Align center',
      styles: const PosStyles(align: PosAlign.center));
  bytes += generator.text('Align right',
      styles: const PosStyles(align: PosAlign.right), linesAfter: 1);
  bytes += generator.qrcode('Barcode by escpos',
      size: QRSize.Size4, cor: QRCorrection.H);
  bytes += generator.feed(2);

  bytes += generator.row([
    PosColumn(
      text: 'col3',
      width: 3,
      styles: const PosStyles(align: PosAlign.center, underline: true),
    ),
    PosColumn(
      text: 'col6',
      width: 6,
      styles: const PosStyles(align: PosAlign.center, underline: true),
    ),
    PosColumn(
      text: 'col3',
      width: 3,
      styles: const PosStyles(align: PosAlign.center, underline: true),
    ),
  ]);

  bytes += generator.text('Text size 200%',
      styles: const PosStyles(
        height: PosTextSize.size2,
        width: PosTextSize.size2,
      ));

  bytes += generator.reset();
  bytes += generator.cut();

  return bytes;
}

//====================================================================//
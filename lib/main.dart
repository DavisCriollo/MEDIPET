import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neitorcont/src/controllers/anuladas_controller.dart';
import 'package:neitorcont/src/controllers/comprobantes_controller.dart';
import 'package:neitorcont/src/controllers/facturas_controller.dart';
import 'package:neitorcont/src/controllers/historia_clinica.controller.dart';
import 'package:neitorcont/src/controllers/home_controller.dart';
import 'package:neitorcont/src/controllers/hospitalizacion_controller.dart';
import 'package:neitorcont/src/controllers/mascotas_controller.dart';
import 'package:neitorcont/src/controllers/notas_creditos_controller.dart';
import 'package:neitorcont/src/controllers/peluqueria_controller.dart';
import 'package:neitorcont/src/controllers/prefacturas_controller.dart';
import 'package:neitorcont/src/controllers/proformas_controller.dart';
import 'package:neitorcont/src/controllers/propietarios_controller.dart';
import 'package:neitorcont/src/controllers/recetas_controller.dart';
import 'package:neitorcont/src/controllers/reservas_controller.dart';
import 'package:neitorcont/src/controllers/vacunas_controller.dart';
import 'package:neitorcont/src/controllers/videos_controller.dart';
import 'package:neitorcont/src/routes/routes.dart';
import 'package:neitorcont/src/services/notifications_service.dart';
import 'package:neitorcont/src/services/socket_service.dart';
import 'package:neitorcont/src/theme/theme_provider.dart';
import 'package:neitorcont/src/theme/themes_app.dart';
// import 'package:neitor_vet/src/utils/theme.dart';
import 'package:provider/provider.dart';


// import 'dart:io';
// import 'dart:typed_data';


// import 'package:esc_pos_utils/esc_pos_utils.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';


// import 'package:neitorcont/src/controllers/comprobantes_controller.dart';
// import 'package:neitorcont/src/pages/print.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:pdf/pdf.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:printing/printing.dart';
// import 'package:provider/provider.dart';


// import 'dart:typed_data';
// import 'dart:async';
// import 'package:http/http.dart' as http;


// import 'package:bluetooth_print/bluetooth_print.dart';

// import 'package:flutter_blue_plus/flutter_blue_plus.dart' as flutterBlue;
// import 'package:bluetooth_print/bluetooth_print.dart';
// import 'package:bluetooth_print/bluetooth_print_model.dart' as btPrint;


void main() => runApp( MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      final homeController = HomeController();
      // final themeController = AppTheme();
      // final theme = themeController.themeApp('plus', Colors.green, Colors.yellow);
      // final  currentTheme = Provider.of<AppTheme>(context).currentTheme;
        final _primaryColor= Colors.green;
        // , Colors.yellow)
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
    );

    return MultiProvider(
      providers: [
         ChangeNotifierProvider(create: (_) => ThemeProvider()),


         ChangeNotifierProvider(create: (_) => AppTheme()),
         
         ChangeNotifierProvider(create: (_) => SocketService()),

    


        ChangeNotifierProvider(create: (_) => HomeController()),
        ChangeNotifierProvider(create: (_) => PropietariosController()),
        ChangeNotifierProvider(create: (_) => MascotasController()),
        ChangeNotifierProvider(create: (_) => HistoriaClinicaController()),
        ChangeNotifierProvider(create: (_) => VacunasController()),
        ChangeNotifierProvider(create: (_) => RecetasController()),
        ChangeNotifierProvider(create: (_) => HospitalizacionController()),
        ChangeNotifierProvider(create: (_) => PeluqueriaController()),
        ChangeNotifierProvider(create: (_) => FacturasController()),
        ChangeNotifierProvider(create: (_) => PreFacturasController()),
        ChangeNotifierProvider(create: (_) => ProformasController()),
        ChangeNotifierProvider(create: (_) => NotasCreditosController()),
        ChangeNotifierProvider(create: (_) => VideosController()),
        ChangeNotifierProvider(create: (_) => AnuladasController()),
        ChangeNotifierProvider(create: (_) => ReservasController()),
        ChangeNotifierProvider(create: (_) => ComprobantesController()),
      ],
      // child: Consumer<AppTheme>(
      child: Consumer<ThemeProvider>(
        builder: (_, theme, __) { 

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          
           //CONFIGURACION PARA EL DATEPICKER
          //  localizationsDelegates: [
          //   GlobalWidgetsLocalizations.delegate,
          //   GlobalMaterialLocalizations.delegate,
          //   GlobalCupertinoLocalizations.delegate,
          // ],
          // supportedLocales: const [
          //   Locale('en', 'US'), // English, no country code
          //   Locale('es', 'ES'), // Hebrew, no country code
          // ],
      
      
      // localizationsDelegates: [
      //    GlobalMaterialLocalizations.delegate,
      //    GlobalWidgetsLocalizations.delegate,
      //    GlobalCupertinoLocalizations.delegate,
      //  ],
      //  supportedLocales: [
      //     const Locale('en', ''), // English, no country code
      //     const Locale('he', ''), // Hebrew, no country code
      //     const Locale.fromSubtags(languageCode: 'zh')
      //   ],
      
      
          // theme: ThemeData(
          //   // primaryColor: primaryColor,
          //   // floatingActionButtonTheme:FloatingActionButtonThemeData(backgroundColor: secondaryColor),
          //   colorScheme: ColorScheme.fromSeed(seedColor: primaryColor,secondary: primaryColor,tertiary: tercearyColor),
         
          //   ),
          // theme: theme.currentTheme,
            theme: theme.appTheme.themeData,
          // ThemeData.light().copyWith(
          //   primaryColor: _primaryColor,
            
      
          //   //==== COLOR DEL APPBAR ======//
          //   appBarTheme:  AppBarTheme(
          //   color:  _primaryColor,  
          //    ),
          //   //==== COLOR DEL SCAFOLD ======//
          //   scaffoldBackgroundColor:  Colors.grey.shade100,
          //   // scaffoldBackgroundColor:  Colors.red,
          // ),
      
      
          
      
      
          initialRoute: 'splash',

          // initialRoute: 'SunmiScreen',

         
          routes: appRoutes,
          navigatorKey: homeController.navigatorKey,
          scaffoldMessengerKey: NotificatiosnService.messengerKey,
        );
        
        })
    );
  }
}



//***********************//

// import 'dart:typed_data';
// import 'package:esc_pos_utils/esc_pos_utils.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:sunmi_printer_plus/column_maker.dart';
// import 'package:sunmi_printer_plus/enums.dart';
// import 'dart:async';

// import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';
// import 'package:sunmi_printer_plus/sunmi_style.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   await SystemChrome.setPreferredOrientations(
//       [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeRight]);
//   runApp(const MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: 'Sunmi Printer',
//         theme: ThemeData(
//           primaryColor: Colors.black,
//         ),
//         debugShowCheckedModeBanner: false,
//         home: const Home());
//   }
// }

// class Home extends StatefulWidget {
//   const Home({Key? key}) : super(key: key);

//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   bool printBinded = false;
//   int paperSize = 0;
//   String serialNumber = "";
//   String printerVersion = "";
//   @override
//   void initState() {
//     super.initState();

//     _bindingPrinter().then((bool? isBind) async {
//       SunmiPrinter.paperSize().then((int size) {
//         setState(() {
//           paperSize = size;
//         });
//       });

//       SunmiPrinter.printerVersion().then((String version) {
//         setState(() {
//           printerVersion = version;
//         });
//       });

//       SunmiPrinter.serialNumber().then((String serial) {
//         setState(() {
//           serialNumber = serial;
//         });
//       });

//       setState(() {
//         printBinded = isBind!;
//       });
//     });
//   }

//   /// must binding ur printer at first init in app
//   Future<bool?> _bindingPrinter() async {
//     final bool? result = await SunmiPrinter.bindingPrinter();
//     return result;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Sunmi printer Example'),
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(
//                   top: 10,
//                 ),
//                 child: Text("Print binded: " + printBinded.toString()),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 2.0),
//                 child: Text("Paper size: " + paperSize.toString()),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 2.0),
//                 child: Text("Serial number: " + serialNumber),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 2.0),
//                 child: Text("Printer version: " + printerVersion),
//               ),
//               const Divider(),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     ElevatedButton(
//                         onPressed: () async {
//                           await SunmiPrinter.initPrinter();
//                           await SunmiPrinter.startTransactionPrint(true);
//                           await SunmiPrinter.printQRCode(
//                               'https://github.com/brasizza/sunmi_printer');
//                           await SunmiPrinter.lineWrap(2);
//                           await SunmiPrinter.exitTransactionPrint(true);
//                         },
//                         child: const Text('Print qrCode')),
//                     ElevatedButton(
//                         onPressed: () async {
//                           await SunmiPrinter.initPrinter();
//                           await SunmiPrinter.startTransactionPrint(true);
//                           await SunmiPrinter.printBarCode('1234567890',
//                               barcodeType: SunmiBarcodeType.CODE128,
//                               textPosition: SunmiBarcodeTextPos.TEXT_UNDER,
//                               height: 20);
//                           await SunmiPrinter.lineWrap(2);
//                           await SunmiPrinter.exitTransactionPrint(true);
//                         },
//                         child: const Text('Print barCode')),
//                     ElevatedButton(
//                         onPressed: () async {
//                           await SunmiPrinter.initPrinter();
//                           await SunmiPrinter.startTransactionPrint(true);
//                           await SunmiPrinter.line();
//                           await SunmiPrinter.lineWrap(2);
//                           await SunmiPrinter.exitTransactionPrint(true);
//                         },
//                         child: const Text('Print line')),
//                     ElevatedButton(
//                         onPressed: () async {
//                           await SunmiPrinter.lineWrap(2);
//                         },
//                         child: const Text('Wrap line')),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     ElevatedButton(
//                         onPressed: () async {
//                           await SunmiPrinter.initPrinter();
//                           await SunmiPrinter.startTransactionPrint(true);
//                           await SunmiPrinter.printText('Hello I\'m bold',
//                               style: SunmiStyle(bold: true));
//                           await SunmiPrinter.lineWrap(2);
//                           await SunmiPrinter.exitTransactionPrint(true);
//                         },
//                         child: const Text('Bold Text')),
//                     ElevatedButton(
//                         onPressed: () async {
//                           await SunmiPrinter.initPrinter();
//                           await SunmiPrinter.startTransactionPrint(true);
//                           await SunmiPrinter.printText('Very small!',
//                               style: SunmiStyle(fontSize: SunmiFontSize.XS));
//                           await SunmiPrinter.lineWrap(2);

//                           await SunmiPrinter.exitTransactionPrint(true);
//                         },
//                         child: const Text('Very small font')),
//                     ElevatedButton(
//                         onPressed: () async {
//                           await SunmiPrinter.initPrinter();
//                           await SunmiPrinter.startTransactionPrint(true);
//                           await SunmiPrinter.printText('Very small!',
//                               style: SunmiStyle(fontSize: SunmiFontSize.SM));
//                           await SunmiPrinter.lineWrap(2);
//                           await SunmiPrinter.exitTransactionPrint(true);
//                         },
//                         child: const Text('Small font')),
//                     ElevatedButton(
//                         onPressed: () async {
//                           await SunmiPrinter.initPrinter();
//                           await SunmiPrinter.startTransactionPrint(true);
//                           await SunmiPrinter.printText('Normal font',
//                               style: SunmiStyle(fontSize: SunmiFontSize.MD));

//                           await SunmiPrinter.lineWrap(2);
//                           await SunmiPrinter.exitTransactionPrint(true);
//                         },
//                         child: const Text('Normal font')),
//                     ElevatedButton(
//                         onPressed: () async {
//                           await SunmiPrinter.initPrinter();
//                           await SunmiPrinter.printText('Large font',
//                               style: SunmiStyle(fontSize: SunmiFontSize.LG));

//                           await SunmiPrinter.lineWrap(2);
//                           await SunmiPrinter.exitTransactionPrint(true);
//                         },
//                         child: const Text('Large font')),
//                     ElevatedButton(
//                         onPressed: () async {
//                           await SunmiPrinter.initPrinter();
//                           await SunmiPrinter.startTransactionPrint(true);
//                           await SunmiPrinter.setFontSize(SunmiFontSize.XL);
//                           await SunmiPrinter.printText('Very Large font!');
//                           await SunmiPrinter.resetFontSize();
//                           await SunmiPrinter.lineWrap(2);
//                           await SunmiPrinter.exitTransactionPrint(true);
//                         },
//                         child: const Text('Very large font')),
//                     ElevatedButton(
//                         onPressed: () async {
//                           await SunmiPrinter.initPrinter();
//                           await SunmiPrinter.startTransactionPrint(true);
//                           await SunmiPrinter.setCustomFontSize(13);
//                           await SunmiPrinter.printText('Very Large font!');
//                           await SunmiPrinter.resetFontSize();
//                           await SunmiPrinter.lineWrap(2);
//                           await SunmiPrinter.exitTransactionPrint(true);
//                         },
//                         child: const Text('Custom size font')),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     ElevatedButton(
//                         onPressed: () async {
//                           await SunmiPrinter.initPrinter();
//                           await SunmiPrinter.startTransactionPrint(true);
//                           await SunmiPrinter.printText('Align right',
//                               style: SunmiStyle(align: SunmiPrintAlign.RIGHT));
//                           await SunmiPrinter.lineWrap(2);
//                           await SunmiPrinter.exitTransactionPrint(true);
//                         },
//                         child: const Text('Align right')),
//                     ElevatedButton(
//                         onPressed: () async {
//                           await SunmiPrinter.initPrinter();

//                           await SunmiPrinter.startTransactionPrint(true);
//                           await SunmiPrinter.printText('Align left',
//                               style: SunmiStyle(align: SunmiPrintAlign.LEFT));

//                           await SunmiPrinter.lineWrap(2);
//                           await SunmiPrinter.exitTransactionPrint(true);
//                         },
//                         child: const Text('Align left')),
//                     ElevatedButton(
//                       onPressed: () async {
//                         await SunmiPrinter.initPrinter();

//                         await SunmiPrinter.startTransactionPrint(true);
//                         await SunmiPrinter.printText(
//                           'Align center/ LARGE TEXT AND BOLD',
//                           style: SunmiStyle(
//                               align: SunmiPrintAlign.CENTER,
//                               bold: true,
//                               fontSize: SunmiFontSize.LG),
//                         );

//                         await SunmiPrinter.lineWrap(2);
//                         await SunmiPrinter.exitTransactionPrint(true);
//                       },
//                       child: const Text('Align center'),
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     GestureDetector(
//                       onTap: () async {
//                         await SunmiPrinter.initPrinter();

//                         Uint8List byte =
//                             await _getImageFromAsset('assets/images/logo.png');
//                         await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);

//                         await SunmiPrinter.startTransactionPrint(true);
//                         await SunmiPrinter.printImage(byte);
//                         await SunmiPrinter.lineWrap(2);
//                         await SunmiPrinter.exitTransactionPrint(true);
//                       },
//                       child: Column(
//                         children: [
//                           Image.asset(
//                             'assets/images/logo.png',
//                             width: 100,
//                           ),
//                           const Text('Print this image from asset!')
//                         ],
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () async {
//                         await SunmiPrinter.initPrinter();

//                         String url =
//                             'https://avatars.githubusercontent.com/u/14101776?s=100';
//                         // convert image to Uint8List format
//                         Uint8List byte =
//                             (await NetworkAssetBundle(Uri.parse(url)).load(url))
//                                 .buffer
//                                 .asUint8List();
//                         await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
//                         await SunmiPrinter.startTransactionPrint(true);
//                         await SunmiPrinter.printImage(byte);
//                         await SunmiPrinter.lineWrap(2);
//                         await SunmiPrinter.exitTransactionPrint(true);
//                       },
//                       child: Column(
//                         children: [
//                           Image.network(
//                               'https://avatars.githubusercontent.com/u/14101776?s=100'),
//                           const Text('Print this image from WEB!')
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const Divider(),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       ElevatedButton(
//                           onPressed: () async {
//                             await SunmiPrinter.cut();
//                           },
//                           child: const Text('CUT PAPER')),
//                     ]),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       ElevatedButton(
//                           onPressed: () async {
//                             await SunmiPrinter.initPrinter();

//                             await SunmiPrinter.startTransactionPrint(true);
//                             await SunmiPrinter.setAlignment(
//                                 SunmiPrintAlign.CENTER);
//                             await SunmiPrinter.line();
//                             await SunmiPrinter.printText('Payment receipt');
//                             await SunmiPrinter.printText(
//                                 'Using the old way to bold!');
//                             await SunmiPrinter.line();

//                             await SunmiPrinter.printRow(cols: [
//                               ColumnMaker(
//                                   text: 'Name',
//                                   width: 12,
//                                   align: SunmiPrintAlign.LEFT),
//                               ColumnMaker(
//                                   text: 'Qty',
//                                   width: 6,
//                                   align: SunmiPrintAlign.CENTER),
//                               ColumnMaker(
//                                   text: 'UN',
//                                   width: 6,
//                                   align: SunmiPrintAlign.RIGHT),
//                               ColumnMaker(
//                                   text: 'TOT',
//                                   width: 6,
//                                   align: SunmiPrintAlign.RIGHT),
//                             ]);

//                             await SunmiPrinter.printRow(cols: [
//                               ColumnMaker(
//                                   text: 'Fries',
//                                   width: 12,
//                                   align: SunmiPrintAlign.LEFT),
//                               ColumnMaker(
//                                   text: '4x',
//                                   width: 6,
//                                   align: SunmiPrintAlign.CENTER),
//                               ColumnMaker(
//                                   text: '3.00',
//                                   width: 6,
//                                   align: SunmiPrintAlign.RIGHT),
//                               ColumnMaker(
//                                   text: '12.00',
//                                   width: 6,
//                                   align: SunmiPrintAlign.RIGHT),
//                             ]);

//                             await SunmiPrinter.printRow(cols: [
//                               ColumnMaker(
//                                   text: 'Strawberry',
//                                   width: 12,
//                                   align: SunmiPrintAlign.LEFT),
//                               ColumnMaker(
//                                   text: '1x',
//                                   width: 6,
//                                   align: SunmiPrintAlign.CENTER),
//                               ColumnMaker(
//                                   text: '24.44',
//                                   width: 6,
//                                   align: SunmiPrintAlign.RIGHT),
//                               ColumnMaker(
//                                   text: '24.44',
//                                   width: 6,
//                                   align: SunmiPrintAlign.RIGHT),
//                             ]);

//                             await SunmiPrinter.printRow(cols: [
//                               ColumnMaker(
//                                   text: 'Soda',
//                                   width: 12,
//                                   align: SunmiPrintAlign.LEFT),
//                               ColumnMaker(
//                                   text: '1x',
//                                   width: 6,
//                                   align: SunmiPrintAlign.CENTER),
//                               ColumnMaker(
//                                   text: '1.99',
//                                   width: 6,
//                                   align: SunmiPrintAlign.RIGHT),
//                               ColumnMaker(
//                                   text: '1.99',
//                                   width: 6,
//                                   align: SunmiPrintAlign.RIGHT),
//                             ]);

//                             await SunmiPrinter.line();
//                             await SunmiPrinter.printRow(cols: [
//                               ColumnMaker(
//                                   text: 'TOTAL',
//                                   width: 25,
//                                   align: SunmiPrintAlign.LEFT),
//                               ColumnMaker(
//                                   text: '38.43',
//                                   width: 5,
//                                   align: SunmiPrintAlign.RIGHT),
//                             ]);

//                             await SunmiPrinter.printRow(cols: [
//                               ColumnMaker(
//                                   text: 'ARABIC TEXT',
//                                   width: 15,
//                                   align: SunmiPrintAlign.LEFT),
//                               ColumnMaker(
//                                   text: 'اسم المشترك',
//                                   width: 15,
//                                   align: SunmiPrintAlign.LEFT),
//                             ]);

//                             await SunmiPrinter.printRow(cols: [
//                               ColumnMaker(
//                                   text: 'اسم المشترك',
//                                   width: 15,
//                                   align: SunmiPrintAlign.LEFT),
//                               ColumnMaker(
//                                   text: 'اسم المشترك',
//                                   width: 15,
//                                   align: SunmiPrintAlign.LEFT),
//                             ]);

//                             await SunmiPrinter.printRow(cols: [
//                               ColumnMaker(
//                                   text: 'RUSSIAN TEXT',
//                                   width: 15,
//                                   align: SunmiPrintAlign.LEFT),
//                               ColumnMaker(
//                                   text: 'Санкт-Петербу́рг',
//                                   width: 15,
//                                   align: SunmiPrintAlign.LEFT),
//                             ]);
//                             await SunmiPrinter.printRow(cols: [
//                               ColumnMaker(
//                                   text: 'Санкт-Петербу́рг',
//                                   width: 15,
//                                   align: SunmiPrintAlign.LEFT),
//                               ColumnMaker(
//                                   text: 'Санкт-Петербу́рг',
//                                   width: 15,
//                                   align: SunmiPrintAlign.LEFT),
//                             ]);

//                             await SunmiPrinter.printRow(cols: [
//                               ColumnMaker(
//                                   text: 'CHINESE TEXT',
//                                   width: 15,
//                                   align: SunmiPrintAlign.LEFT),
//                               ColumnMaker(
//                                   text: '風俗通義',
//                                   width: 15,
//                                   align: SunmiPrintAlign.LEFT),
//                             ]);
//                             await SunmiPrinter.printRow(cols: [
//                               ColumnMaker(
//                                   text: '風俗通義',
//                                   width: 15,
//                                   align: SunmiPrintAlign.LEFT),
//                               ColumnMaker(
//                                   text: '風俗通義',
//                                   width: 15,
//                                   align: SunmiPrintAlign.LEFT),
//                             ]);

//                             await SunmiPrinter.setAlignment(
//                                 SunmiPrintAlign.CENTER);
//                             await SunmiPrinter.line();
//                             await SunmiPrinter.bold();
//                             await SunmiPrinter.printText(
//                                 'Transaction\'s Qrcode');
//                             await SunmiPrinter.resetBold();
//                             await SunmiPrinter.printQRCode(
//                                 'https://github.com/brasizza/sunmi_printer');
//                             await SunmiPrinter.lineWrap(2);
//                             await SunmiPrinter.exitTransactionPrint(true);
//                           },
//                           child: const Text('TICKET EXAMPLE')),
//                     ]),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       ElevatedButton(
//                           onPressed: () async {
//                             final List<int> _escPos = await _customEscPos();
//                             await SunmiPrinter.initPrinter();
//                             await SunmiPrinter.startTransactionPrint(true);
//                             await SunmiPrinter.printRawData(
//                                 Uint8List.fromList(_escPos));
//                             await SunmiPrinter.exitTransactionPrint(true);
//                           },
//                           child: const Text('Custom ESC/POS to print')),
//                     ]),
//               ),
//             ],
//           ),
//         ));
//   }
// }

// Future<Uint8List> readFileBytes(String path) async {
//   ByteData fileData = await rootBundle.load(path);
//   Uint8List fileUnit8List = fileData.buffer
//       .asUint8List(fileData.offsetInBytes, fileData.lengthInBytes);
//   return fileUnit8List;
// }

// Future<Uint8List> _getImageFromAsset(String iconPath) async {
//   return await readFileBytes(iconPath);
// }

// Future<List<int>> _customEscPos() async {
//   final profile = await CapabilityProfile.load();
//   final generator = Generator(PaperSize.mm58, profile);
//   List<int> bytes = [];

//   bytes += generator.text(
//       'Regular: aA bB cC dD eE fF gG hH iI jJ kK lL mM nN oO pP qQ rR sS tT uU vV wW xX yY zZ');
//   bytes += generator.text('Special 1: àÀ èÈ éÉ ûÛ üÜ çÇ ôÔ',
//       styles: const PosStyles(codeTable: 'CP1252'));
//   bytes += generator.text('Special 2: blåbærgrød',
//       styles: const PosStyles(codeTable: 'CP1252'));

//   bytes += generator.text('Bold text', styles: const PosStyles(bold: true));
//   bytes +=
//       generator.text('Reverse text', styles: const PosStyles(reverse: true));
//   bytes += generator.text('Underlined text',
//       styles: const PosStyles(underline: true), linesAfter: 1);
//   bytes += generator.text('Align left',
//       styles: const PosStyles(align: PosAlign.left));
//   bytes += generator.text('Align center',
//       styles: const PosStyles(align: PosAlign.center));
//   bytes += generator.text('Align right',
//       styles: const PosStyles(align: PosAlign.right), linesAfter: 1);
//   bytes += generator.qrcode('Barcode by escpos',
//       size: QRSize.Size4, cor: QRCorrection.H);
//   bytes += generator.feed(2);

//   bytes += generator.row([
//     PosColumn(
//       text: 'col3',
//       width: 3,
//       styles: const PosStyles(align: PosAlign.center, underline: true),
//     ),
//     PosColumn(
//       text: 'col6',
//       width: 6,
//       styles: const PosStyles(align: PosAlign.center, underline: true),
//     ),
//     PosColumn(
//       text: 'col3',
//       width: 3,
//       styles: const PosStyles(align: PosAlign.center, underline: true),
//     ),
//   ]);

//   bytes += generator.text('Text size 200%',
//       styles: const PosStyles(
//         height: PosTextSize.size2,
//         width: PosTextSize.size2,
//       ));

//   bytes += generator.reset();
//   bytes += generator.cut();

//   return bytes;
// }



//************************//












// // lib/main.dart
// // import 'package:flutter/material.dart';
// // import 'package:neitorcont/src/controllers/comprobantes_controller.dart';
// // import 'package:provider/provider.dart';


// // void main() {
// //   runApp(
// //     ChangeNotifierProvider(
// //       create: (context) => BluetoothProvider(),
// //       child: MyApp(),
// //     ),
// //   );
// // }

// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MultiProvider(
// //       providers: [
// //          ChangeNotifierProvider(create: (_) => ComprobantesController()),
// //       ],
// //       child: MaterialApp(
// //         title: 'Bluetooth Example',
// //         theme: ThemeData(
// //           primarySwatch: Colors.blue,
// //         ),
// //         home: BluetoothScanScreen(),
// //       ),
// //     );
// //   }
// // }

// // void main() => runApp(MyApp());

// // class MyApp extends StatefulWidget {
// //   @override
// //   _MyAppState createState() => _MyAppState();
// // }



// // class BluetoothScanScreen extends StatefulWidget {
// //   @override
// //   _BluetoothScanScreenState createState() => _BluetoothScanScreenState();
// // }

// // class _BluetoothScanScreenState extends State<BluetoothScanScreen> {
// //   final FlutterBluePlus _flutterBlue = FlutterBluePlus();
// //   List<ScanResult> _devicesList = [];

// //   @override
// //   void initState() {
// //     super.initState();
// //     _startScan();
// //   }

// //   void _startScan() async {
// //     // Start scanning for devices
// //     await FlutterBluePlus.startScan(timeout: Duration(seconds: 4));

// //     // Listen for scan results
// //     FlutterBluePlus.scanResults.listen((results) {
// //       setState(() {
// //         _devicesList = results;
// //       });
// //     });

// //     // Stop scanning after the timeout
// //     Future.delayed(Duration(seconds: 4), () {
// //       FlutterBluePlus.stopScan();
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Bluetooth Devices'),
// //       ),
// //       body: ListView.builder(
// //         itemCount: _devicesList.length,
// //         itemBuilder: (context, index) {
// //           final device = _devicesList[index].device;
// //           return ListTile(
// //             title: Text(device.platformName.isNotEmpty ? device.platformName : 'Unknown Device'),
// //             subtitle: Text(device.remoteId.toString()), // Updated line
// //             onTap: () {
// //               // Aquí puedes añadir la lógica para conectarte al dispositivo
// //               print('Selected device: ${device.platformName}');
// //             },
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }


// // import 'package:blue_thermal_printer_example/testprint.dart';
// // import 'package:flutter/material.dart';
// // import 'dart:async';
// // import 'package:blue_thermal_printer/blue_thermal_printer.dart';
// // import 'package:flutter/services.dart';

// // void main() => runApp(new MyApp());

// // class MyApp extends StatefulWidget {
// //   @override
// //   _MyAppState createState() => new _MyAppState();
// // }


// //==================  O K ======================//
// //===============ok ok ok o k ===============//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyHomePage(),
//     );
//   }
// }

// // class MyHomePage extends StatefulWidget {
// //   @override
// //   _MyHomePageState createState() => _MyHomePageState();
// // }

// // class _MyHomePageState extends State<MyHomePage> {
// //   BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;

// //   List<BluetoothDevice> _devices = [];
// //   BluetoothDevice? _device;
// //   bool _connected = false;
// //   TestPrint testPrint = TestPrint();

// //   @override
// //   void initState() {
// //     super.initState();
// //     initPlatformState();
// //   }

// //   Future<void> initPlatformState() async {
// //     bool? isConnected = await bluetooth.isConnected;
// //     List<BluetoothDevice> devices = [];
// //     try {
// //       devices = await bluetooth.getBondedDevices();
// //     } on PlatformException {
// //       print("Error getting bonded devices.");
// //     }

// //     bluetooth.onStateChanged().listen((state) {
// //       switch (state) {
// //         case BlueThermalPrinter.CONNECTED:
// //           setState(() {
// //             _connected = true;
// //             print("Bluetooth device state: connected");
// //           });
// //           break;
// //         case BlueThermalPrinter.DISCONNECTED:
// //           setState(() {
// //             _connected = false;
// //             print("Bluetooth device state: disconnected");
// //           });
// //           break;
// //         case BlueThermalPrinter.DISCONNECT_REQUESTED:
// //           setState(() {
// //             _connected = false;
// //             print("Bluetooth device state: disconnect requested");
// //           });
// //           break;
// //         case BlueThermalPrinter.STATE_TURNING_OFF:
// //           setState(() {
// //             _connected = false;
// //             print("Bluetooth device state: bluetooth turning off");
// //           });
// //           break;
// //         case BlueThermalPrinter.STATE_OFF:
// //           setState(() {
// //             _connected = false;
// //             print("Bluetooth device state: bluetooth off");
// //           });
// //           break;
// //         case BlueThermalPrinter.STATE_ON:
// //           setState(() {
// //             _connected = false;
// //             print("Bluetooth device state: bluetooth on");
// //           });
// //           break;
// //         case BlueThermalPrinter.STATE_TURNING_ON:
// //           setState(() {
// //             _connected = false;
// //             print("Bluetooth device state: bluetooth turning on");
// //           });
// //           break;
// //         case BlueThermalPrinter.ERROR:
// //           setState(() {
// //             _connected = false;
// //             print("Bluetooth device state: error");
// //           });
// //           break;
// //         default:
// //           print("Unhandled state: $state");
// //           break;
// //       }
// //     });

// //     if (!mounted) return;
// //     setState(() {
// //       _devices = devices;
// //     });

// //     if (isConnected == true) {
// //       setState(() {
// //         _connected = true;
// //       });
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Blue Thermal Printer'),
// //       ),
// //       body: Container(
// //         child: Padding(
// //           padding: const EdgeInsets.all(8.0),
// //           child: ListView(
// //             children: <Widget>[
// //               Row(
// //                 crossAxisAlignment: CrossAxisAlignment.center,
// //                 mainAxisAlignment: MainAxisAlignment.start,
// //                 children: <Widget>[
// //                   SizedBox(
// //                     width: 10,
// //                   ),
// //                   Text(
// //                     'Device:',
// //                     style: TextStyle(
// //                       fontWeight: FontWeight.bold,
// //                     ),
// //                   ),
// //                   SizedBox(
// //                     width: 30,
// //                   ),
// //                   Expanded(
// //                     child: DropdownButton(
// //                       items: _getDeviceItems(),
// //                       onChanged: (BluetoothDevice? value) =>
// //                           setState(() => _device = value),
// //                       value: _device,
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //               SizedBox(
// //                 height: 10,
// //               ),
// //               Row(
// //                 crossAxisAlignment: CrossAxisAlignment.center,
// //                 mainAxisAlignment: MainAxisAlignment.end,
// //                 children: <Widget>[
// //                   ElevatedButton(
// //                     style: ElevatedButton.styleFrom(primary: Colors.brown),
// //                     onPressed: () {
// //                       initPlatformState();
// //                     },
// //                     child: Text(
// //                       'Refresh',
// //                       style: TextStyle(color: Colors.white),
// //                     ),
// //                   ),
// //                   SizedBox(
// //                     width: 20,
// //                   ),
// //                   ElevatedButton(
// //                     style: ElevatedButton.styleFrom(
// //                         primary: _connected ? Colors.red : Colors.green),
// //                     onPressed: _connected ? _disconnect : _connect,
// //                     child: Text(
// //                       _connected ? 'Disconnect' : 'Connect',
// //                       style: TextStyle(color: Colors.white),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //               Padding(
// //                 padding:
// //                     const EdgeInsets.only(left: 10.0, right: 10.0, top: 50),
// //                 child: ElevatedButton(
// //                   style: ElevatedButton.styleFrom(primary: Colors.brown),
// //                   onPressed: () {
// //                     testPrint.sample();
// //                   },
// //                   child: Text('PRINT TEST',
// //                       style: TextStyle(color: Colors.white)),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   List<DropdownMenuItem<BluetoothDevice>> _getDeviceItems() {
// //     List<DropdownMenuItem<BluetoothDevice>> items = [];
// //     if (_devices.isEmpty) {
// //       items.add(DropdownMenuItem(
// //         child: Text('NONE'),
// //       ));
// //     } else {
// //       _devices.forEach((device) {
// //         items.add(DropdownMenuItem(
// //           child: Text(device.name ?? ""),
// //           value: device,
// //         ));
// //       });
// //     }
// //     return items;
// //   }

// //   void _connect() async {
// //     if (_device != null) {
// //       try {
// //         await bluetooth.connect(_device!);
// //         setState(() {
// //           _connected = true;
// //         });
// //         print("Connected to device.");
// //       } catch (e) {
// //         setState(() {
// //           _connected = false;
// //         });
// //         print("Failed to connect: $e");
// //       }
// //     } else {
// //       show('No device selected.');
// //     }
// //   }

// //   void _disconnect() {
// //     bluetooth.disconnect();
// //     setState(() => _connected = false);
// //   }

// //   Future show(
// //     String message, {
// //     Duration duration: const Duration(seconds: 3),
// //   }) async {
// //     await Future.delayed(Duration(milliseconds: 100));
// //     ScaffoldMessenger.of(context).showSnackBar(
// //       SnackBar(
// //         content: Text(
// //           message,
// //           style: TextStyle(
// //             color: Colors.white,
// //           ),
// //         ),
// //         duration: duration,
// //       ),
// //     );
// //   }
// // }

// // class TestPrint {
// //   BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;

// //   // Define constantes para tamaño y alineación
// //   static const int SIZE_NORMAL = 0;
// //   static const int SIZE_BOLD = 1;
// //   static const int SIZE_BOLD_MEDIUM = 2;
// //   static const int SIZE_BOLD_LARGE = 3;

// //   static const int ALIGN_LEFT = 0;
// //   static const int ALIGN_CENTER = 1;
// //   static const int ALIGN_RIGHT = 2;

// //   Future<void> sample() async {
// //     // Cargar imagen desde Asset
// //     ByteData bytesAsset = await rootBundle.load("assets/imgs/logo.png");
// //     Uint8List imageBytesFromAsset = bytesAsset.buffer.asUint8List(bytesAsset.offsetInBytes, bytesAsset.lengthInBytes);

// //     bluetooth.isConnected.then((isConnected) {
// //       if (isConnected == true) {
// //         bluetooth.printNewLine();
// //         bluetooth.printCustom("HEADER", SIZE_BOLD_MEDIUM, ALIGN_CENTER);
// //         bluetooth.printNewLine();
// //         bluetooth.printImageBytes(imageBytesFromAsset); // Imprimir imagen desde Asset
// //         bluetooth.printNewLine();
// //         bluetooth.printLeftRight("LEFT", "RIGHT", SIZE_NORMAL);
// //         bluetooth.printLeftRight("LEFT", "RIGHT", SIZE_BOLD);
// //         bluetooth.printLeftRight("LEFT", "RIGHT", SIZE_BOLD, format: "%-15s %15s %n"); // Ajustar formato
// //         bluetooth.printNewLine();
// //         bluetooth.print3Column("Col1", "Col2", "Col3", SIZE_BOLD);
// //         bluetooth.print4Column("Col1", "Col2", "Col3", "Col4", SIZE_BOLD);
// //         bluetooth.printNewLine();
// //         bluetooth.printCustom("çĆžŽšŠ-H-ščđ", SIZE_BOLD, ALIGN_CENTER, charset: "windows-1250");
// //         bluetooth.printLeftRight("Številka:", "18000001", SIZE_BOLD, charset: "windows-1250");
// //         bluetooth.printCustom("Body left", SIZE_BOLD, ALIGN_LEFT);
// //         bluetooth.printCustom("Body right", SIZE_NORMAL, ALIGN_RIGHT);
// //         bluetooth.printNewLine();
// //         bluetooth.printCustom("Thank You", SIZE_BOLD, ALIGN_CENTER);
// //         bluetooth.printNewLine();
// //         bluetooth.printQRcode("Insert Your Own Text to Generate", 200, 200, ALIGN_CENTER);
// //         bluetooth.printNewLine();
// //         bluetooth.printNewLine();
// //         bluetooth.paperCut();
// //       }
// //     });
// //   }
// // }
//=============ookk=================//
// import 'dart:async';

// import 'package:esc_pos_utils/esc_pos_utils.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:provider/provider.dart';
// // import 'package:esc_pos_utils_plus/esc_pos_utils.dart';

// void main() {
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => BluetoothProvider()),
//       ],
//       child: MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: BluetoothPrintPage(),
//     );
//   }
// }
// // class BluetoothProvider with ChangeNotifier {
// //   final FlutterBluePlus flutterBlue = FlutterBluePlus(); // Instancia de FlutterBluePlus

// //   List<BluetoothDevice> _dispositivos = [];
// //   BluetoothDevice? _dispositivoConectado;
// //   BluetoothCharacteristic? _characteristic;
// //   bool _isScanning = false;
// //   StreamSubscription<List<ScanResult>>? _scanSubscription;

// //   List<BluetoothDevice> get dispositivos => _dispositivos;
// //   BluetoothDevice? get dispositivoConectado => _dispositivoConectado;
// //   bool get isScanning => _isScanning;

// //   void scanDispositivos() async {
// //     _dispositivos.clear();
// //     _isScanning = true;
// //     notifyListeners();

// //     // Iniciar el escaneo
// //     FlutterBluePlus.startScan(timeout: Duration(minutes: 1));

// //     // Escuchar los resultados del escaneo
// //     _scanSubscription = FlutterBluePlus.scanResults.listen((results) {
// //       for (ScanResult result in results) {
// //         if (!_dispositivos.contains(result.device) && result.device.name.isNotEmpty) {
// //           _dispositivos.add(result.device);
// //           notifyListeners();
// //         }
// //       }
// //     });

// //     // Manejo del final del escaneo
// //     await Future.delayed(Duration(seconds: 4));
// //     await FlutterBluePlus.stopScan(); // Detener el escaneo después de 4 segundos
// //     _isScanning = false;
// //     _scanSubscription?.cancel(); // Cancelar la suscripción
// //     notifyListeners();
// //   }

// //   Future<void> conectarDispositivo(BluetoothDevice dispositivo) async {
// //     try {
// //       await dispositivo.connect();
// //       _dispositivoConectado = dispositivo;
// //       notifyListeners();

// //       // Descubre los servicios del dispositivo
// //       List<BluetoothService> services = await dispositivo.discoverServices();
// //       for (BluetoothService service in services) {
// //         for (BluetoothCharacteristic characteristic in service.characteristics) {
// //           // Filtra por características que soporten escritura
// //           if (characteristic.properties.write) {
// //             _characteristic = characteristic;
// //             break;
// //           }
// //         }
// //       }
// //     } catch (e) {
// //       print("Error conectando al dispositivo: $e");
// //     }
// //   }


// //   void imprimir() async {
// //   if (_characteristic != null) {
// //     // Crea el perfil de capacidad para ESC/POS
// //     final profile = await CapabilityProfile.load();
// //     final generator = Generator(PaperSize.mm58, profile);

// //     // Configura el texto con diferentes estilos
// //     final List<int> bytes = [
// //       // Tamaño de fuente grande
// //       ...generator.setStyles(PosStyles(align: PosAlign.center, height: PosTextSize.size2, width: PosTextSize.size2)),
// //       ...generator.text('¡Hola desde Flutter!', styles: PosStyles(align: PosAlign.center)),
// //       ...generator.text('JESUS ES MI PASTOR', styles: PosStyles(align: PosAlign.center, height: PosTextSize.size2, width: PosTextSize.size2)),
      
// //       // Tamaño de fuente normal
// //       ...generator.setStyles(PosStyles(align: PosAlign.center, height: PosTextSize.size1, width: PosTextSize.size1)),
// //       ...generator.text('NADA ME FALTARA EN LUGARES DE DELICADOS PASTOS ME HARA DESCANZAR!'),
      
// //       // Espacio entre líneas
// //       ...generator.text(''), // Línea en blanco para espacio
      
// //       // Aplicar negrita
// //       ...generator.setStyles(PosStyles(bold: true)),
// //       ...generator.text('Texto en negrita'),
// //       ...generator.setStyles(PosStyles(bold: false)),

// //       // Aplicar subrayado
// //       ...generator.setStyles(PosStyles(underline: true)),
// //       ...generator.text('Texto subrayado'),
// //       ...generator.setStyles(PosStyles(underline: false)),

// //       // Alineación derecha
// //       ...generator.setStyles(PosStyles(align: PosAlign.right)),
// //       ...generator.text('Texto alineado a la derecha'),

// //       // Restablecer estilos
// //       ...generator.setStyles(PosStyles()),
      
// //       // Saltar una línea
// //       ...generator.text(''), // Línea en blanco para espacio
      
// //       // Finalizar el texto
// //       ...generator.feed(2), // Alimenta dos líneas hacia adelante
// //       ...generator.cut(),
// //     ];

// //     // Envía los bytes de impresión a la característica
// //     await _characteristic!.write(bytes, withoutResponse: true);
// //   } else {
// //     print("No hay dispositivo conectado o característica de impresión no encontrada.");
// //   }
// // }

// //   void desconectarDispositivo() {
// //     _dispositivoConectado?.disconnect();
// //     _dispositivoConectado = null;
// //     _characteristic = null;
// //     notifyListeners();
// //   }
// // }

// // class BluetoothPrintPage extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     final bluetoothProvider = Provider.of<BluetoothProvider>(context);

// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Impresora Bluetooth'),
// //       ),
// //       body: Column(
// //         children: [
// //           // Botón para escanear dispositivos
// //           ElevatedButton(
// //             onPressed: () {
// //               bluetoothProvider.scanDispositivos();
// //             },
// //             child: Text('Buscar dispositivos Bluetooth'),
// //           ),
// //           // Indicador de carga o lista de dispositivos encontrados
// //           Expanded(
// //             child: bluetoothProvider.isScanning
// //                 ? Center(
// //                     child: CircularProgressIndicator(),
// //                   )
// //                 : bluetoothProvider.dispositivos.isEmpty
// //                     ? Center(
// //                         child: Text(
// //                           'No hay Dispositivos cerca',
// //                           style: TextStyle(fontSize: 16),
// //                         ),
// //                       )
// //                     : ListView.builder(
// //                         itemCount: bluetoothProvider.dispositivos.length,
// //                         itemBuilder: (context, index) {
// //                           return ListTile(
// //                             title: Text(bluetoothProvider.dispositivos[index].name),
// //                             subtitle: Text(bluetoothProvider.dispositivos[index].id.toString()),
// //                             onTap: () {
// //                               bluetoothProvider.conectarDispositivo(bluetoothProvider.dispositivos[index]);
                              
// //                               // Mostrar Snackbar al conectar
// //                               ScaffoldMessenger.of(context).showSnackBar(
// //                                 SnackBar(
// //                                   content: Text(
// //                                     'Conectado a ${bluetoothProvider.dispositivos[index].name}',
// //                                     style: TextStyle(fontSize: 16),
// //                                   ),
// //                                   duration: Duration(seconds: 2),
// //                                 ),
// //                               );
// //                             },
// //                           );
// //                         },
// //                       ),
// //           ),
// //           // Botón para imprimir
// //           ElevatedButton(
// //             onPressed: () {
// //               bluetoothProvider.imprimir();
// //             },
// //             child: Text('Imprimir'),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }






// //=====================FUNCIONA OK==============================//




// class BluetoothProvider with ChangeNotifier {
//   final FlutterBluePlus flutterBlue = FlutterBluePlus();

//   List<BluetoothDevice> _dispositivos = [];
//   BluetoothDevice? _dispositivoConectado;
//   BluetoothCharacteristic? _characteristic;
//   bool _isScanning = false;
//   StreamSubscription<List<ScanResult>>? _scanSubscription;

//   List<BluetoothDevice> get dispositivos => _dispositivos;
//   BluetoothDevice? get dispositivoConectado => _dispositivoConectado;
//   bool get isScanning => _isScanning;

//   Future<void> checkPermissions() async {
//     final status = await Permission.bluetoothScan.status;
//     if (!status.isGranted) {
//       await Permission.bluetoothScan.request();
//     }
//     final locationStatus = await Permission.locationWhenInUse.status;
//     if (!locationStatus.isGranted) {
//       await Permission.locationWhenInUse.request();
//     }
//   }

//   Future<void> ensureBluetoothEnabled() async {
//     final isSupported = await FlutterBluePlus.isSupported;
//     final adapterState = await FlutterBluePlus.adapterState.first;

//     if (!isSupported) {
//       // Informar al usuario que Bluetooth no es compatible
//       // Puedes usar un diálogo para informar al usuario
//       print("Bluetooth no es compatible con este dispositivo.");
//       return;
//     }

//     if (adapterState != BluetoothAdapterState.on) {
//       // Solicitar al usuario que habilite Bluetooth
//       print("Bluetooth está apagado. Por favor, enciéndelo.");
//       // Puedes usar un diálogo para informar al usuario
//     }
//   }

//   void scanDispositivos() async {
//     await checkPermissions();
//     await ensureBluetoothEnabled();

//     _dispositivos.clear();
//     _isScanning = true;
//     notifyListeners();

//     // Iniciar el escaneo
//     await FlutterBluePlus.startScan(timeout: Duration(seconds: 4));

//     // Escuchar los resultados del escaneo
//     _scanSubscription = FlutterBluePlus.scanResults.listen((results) {
//       print('Resultados del escaneo: $results');
//       for (ScanResult result in results) {
//         print('Dispositivo encontrado: ${result.device.name}');
//         if (!_dispositivos.contains(result.device) && result.device.name.isNotEmpty) {
//           _dispositivos.add(result.device);
//           notifyListeners();
//         }
//       }
//     });

//     // Manejo del final del escaneo
//     await Future.delayed(Duration(seconds: 10)); // Asegúrate de que el tiempo de espera coincida con el timeout
//     await FlutterBluePlus.stopScan(); // Detener el escaneo después del timeout
//     _isScanning = false;
//     _scanSubscription?.cancel(); // Cancelar la suscripción
//     notifyListeners();
//   }

//   Future<void> conectarDispositivo(BluetoothDevice dispositivo) async {
//     try {
//       await dispositivo.connect();
//       _dispositivoConectado = dispositivo;
//       notifyListeners();

//       // Descubre los servicios del dispositivo
//       List<BluetoothService> services = await dispositivo.discoverServices();
//       for (BluetoothService service in services) {
//         for (BluetoothCharacteristic characteristic in service.characteristics) {
//           // Filtra por características que soporten escritura
//           if (characteristic.properties.write) {
//             _characteristic = characteristic;
//             break;
//           }
//         }
//       }
//     } catch (e) {
//       print("Error conectando al dispositivo: $e");
//     }
//   }

//   void imprimir() async {
//   if (_characteristic != null) {
//     // Crea el perfil de capacidad para ESC/POS
//     final profile = await CapabilityProfile.load();
//     final generator = Generator(PaperSize.mm58, profile);

//     // Configura el texto con diferentes estilos
//     final List<int> bytes = [
//       // Tamaño de fuente grande
//       ...generator.setStyles(PosStyles(align: PosAlign.center, height: PosTextSize.size2, width: PosTextSize.size2)),
//       ...generator.text('¡Hola desde Flutter!', styles: PosStyles(align: PosAlign.center)),
//       ...generator.text('JESUS ES MI PASTOR', styles: PosStyles(align: PosAlign.center, height: PosTextSize.size2, width: PosTextSize.size2)),
      
//       // Tamaño de fuente normal
//       ...generator.setStyles(PosStyles(align: PosAlign.center, height: PosTextSize.size1, width: PosTextSize.size1)),
//       ...generator.text('NADA ME FALTARA EN LUGARES DE DELICADOS PASTOS ME HARA DESCANZAR!'),
      
//       // Espacio entre líneas
//       ...generator.text(''), // Línea en blanco para espacio
      
//       // Aplicar negrita
//       ...generator.setStyles(PosStyles(bold: true)),
//       ...generator.text('Texto en negrita'),
//       ...generator.setStyles(PosStyles(bold: false)),

//       // Aplicar subrayado
//       ...generator.setStyles(PosStyles(underline: true)),
//       ...generator.text('Texto subrayado'),
//       ...generator.setStyles(PosStyles(underline: false)),

//       // Alineación derecha
//       ...generator.setStyles(PosStyles(align: PosAlign.right)),
//       ...generator.text('Texto alineado a la derecha'),

//       // Restablecer estilos
//       // ...generator.setStyles(),
      
//       // Saltar una línea
//       ...generator.text(''), // Línea en blanco para espacio
      
//       // Finalizar el texto
//       ...generator.feed(2), // Alimenta dos líneas hacia adelante
//       ...generator.cut(),
//     ];

//     // Tamaño máximo permitido por el dispositivo (ajustar según tu dispositivo)
//     const maxDataLength = 182;
    
//     // Fragmentar los datos y enviarlos
//     for (int i = 0; i < bytes.length; i += maxDataLength) {
//       final end = (i + maxDataLength < bytes.length) ? i + maxDataLength : bytes.length;
//       final chunk = bytes.sublist(i, end);
//       try {
//         await _characteristic!.write(chunk, withoutResponse: true);
//         // Puedes agregar un pequeño retraso entre envíos si es necesario
//         await Future.delayed(Duration(milliseconds: 100));
//       } catch (e) {
//         print("Error al escribir en la característica: $e");
//         break;
//       }
//     }
//   } else {
//     print("No hay dispositivo conectado o característica de impresión no encontrada.");
//   }
// }


//   void desconectarDispositivo() {
//     _dispositivoConectado?.disconnect();
//     _dispositivoConectado = null;
//     _characteristic = null;
//     notifyListeners();
//   }
// }



// class BluetoothPrintPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final bluetoothProvider = Provider.of<BluetoothProvider>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Impresora Bluetooth'),
//       ),
//       body: Column(
//         children: [
//           // Botón para escanear dispositivos
//           ElevatedButton(
//             onPressed: () {
//               bluetoothProvider.scanDispositivos();
//             },
//             child: Text('Buscar dispositivos Bluetooth'),
//           ),
//           // Indicador de carga o lista de dispositivos encontrados
//           Expanded(
//             child: bluetoothProvider.isScanning
//                 ? Center(
//                     child: CircularProgressIndicator(),
//                   )
//                 : bluetoothProvider.dispositivos.isEmpty
//                     ? Center(
//                         child: Text(
//                           'No hay Dispositivos cerca',
//                           style: TextStyle(fontSize: 16),
//                         ),
//                       )
//                     : ListView.builder(
//                         itemCount: bluetoothProvider.dispositivos.length,
//                         itemBuilder: (context, index) {
//                           return ListTile(
//                             title: Text(bluetoothProvider.dispositivos[index].name),
//                             subtitle: Text(bluetoothProvider.dispositivos[index].id.toString()),
//                             onTap: () {
//                               bluetoothProvider.conectarDispositivo(bluetoothProvider.dispositivos[index]);
                              
//                               // Mostrar Snackbar al conectar
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                   content: Text(
//                                     'Conectado a ${bluetoothProvider.dispositivos[index].name}',
//                                     style: TextStyle(fontSize: 16),
//                                   ),
//                                   duration: Duration(seconds: 2),
//                                 ),
//                               );
//                             },
//                           );
//                         },
//                       ),
//           ),
//           // Botón para imprimir
//           ElevatedButton(
//             onPressed: () {
//               // bluetoothProvider.imprimir();
//               imprimirConInnerPrinter();
//             },
//             child: Text('Imprimir'),
//           ),
//         ],
//       ),
//     );
//   }


//   void imprimirConInnerPrinter() async {
//     try {
//       // Iniciar la transacción de impresión
//       await SunmiPrinter.startTransactionPrint(true);

//       // Configurar el texto y alineación
//       await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
//       await SunmiPrinter.setFontSize(SunmiFontSize.LG);
//       await SunmiPrinter.printText('¡Hola desde Flutter!');

//       await SunmiPrinter.setFontSize(SunmiFontSize.SM);
//       await SunmiPrinter.printText('Este es un texto de prueba.');

//       // Finalizar la impresión
//       await SunmiPrinter.lineWrap(2);
//       await SunmiPrinter.submitTransactionPrint();
//     } catch (e) {
//       print("Error al imprimir: $e");
//     }
//   }

// // 
  
// }






// //===================TERMINA FUNCIONA OK===========================//

//=============================INICIA SUNMI=======================================//

// import 'dart:typed_data';
// import 'package:esc_pos_utils/esc_pos_utils.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:sunmi_printer_plus/column_maker.dart';
// import 'package:sunmi_printer_plus/enums.dart';
// import 'dart:async';

// import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';
// import 'package:sunmi_printer_plus/sunmi_style.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   await SystemChrome.setPreferredOrientations(
//         [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
//       );
//   runApp(const MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: 'Sunmi Printer',
//         theme: ThemeData(
//           primaryColor: Colors.black,
//         ),
//         debugShowCheckedModeBanner: false,
//         home: const Home());
//   }
// }

// class Home extends StatefulWidget {
//   const Home({Key? key}) : super(key: key);

//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   bool printBinded = false;
//   int paperSize = 0;
//   String serialNumber = "";
//   String printerVersion = "";
//   @override
//   void initState() {
//     super.initState();

//     _bindingPrinter().then((bool? isBind) async {
//       SunmiPrinter.paperSize().then((int size) {
//         setState(() {
//           paperSize = size;
//         });
//       });

//       SunmiPrinter.printerVersion().then((String version) {
//         setState(() {
//           printerVersion = version;
//         });
//       });

//       SunmiPrinter.serialNumber().then((String serial) {
//         setState(() {
//           serialNumber = serial;
//         });
//       });

//       setState(() {
//         printBinded = isBind!;
//       });
//     });
//   }

//   /// must binding ur printer at first init in app
//   Future<bool?> _bindingPrinter() async {
//     final bool? result = await SunmiPrinter.bindingPrinter();
//     return result;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Sunmi printer Example'),
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(
//                   top: 10,
//                 ),
//                 child: Text("Print binded: " + printBinded.toString()),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 2.0),
//                 child: Text("Paper size: " + paperSize.toString()),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 2.0),
//                 child: Text("Serial number: " + serialNumber),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 2.0),
//                 child: Text("Printer version: " + printerVersion),
//               ),
//               const Divider(),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     ElevatedButton(
//                         onPressed: () async {
//                           await SunmiPrinter.initPrinter();
//                           await SunmiPrinter.startTransactionPrint(true);
//                           await SunmiPrinter.printQRCode(
//                               'https://github.com/brasizza/sunmi_printer');
//                           await SunmiPrinter.lineWrap(2);
//                           await SunmiPrinter.exitTransactionPrint(true);
//                         },
//                         child: const Text('Print qrCode')),
//                     ElevatedButton(
//                         onPressed: () async {
//                           await SunmiPrinter.initPrinter();
//                           await SunmiPrinter.startTransactionPrint(true);
//                           await SunmiPrinter.printBarCode('1234567890',
//                               barcodeType: SunmiBarcodeType.CODE128,
//                               textPosition: SunmiBarcodeTextPos.TEXT_UNDER,
//                               height: 20);
//                           await SunmiPrinter.lineWrap(2);
//                           await SunmiPrinter.exitTransactionPrint(true);
//                         },
//                         child: const Text('Print barCode')),
//                     ElevatedButton(
//                         onPressed: () async {
//                           await SunmiPrinter.initPrinter();
//                           await SunmiPrinter.startTransactionPrint(true);
//                           await SunmiPrinter.line();
//                           await SunmiPrinter.lineWrap(2);
//                           await SunmiPrinter.exitTransactionPrint(true);
//                         },
//                         child: const Text('Print line')),
//                     ElevatedButton(
//                         onPressed: () async {
//                           await SunmiPrinter.lineWrap(2);
//                         },
//                         child: const Text('Wrap line')),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     ElevatedButton(
//                         onPressed: () async {
//                           await SunmiPrinter.initPrinter();
//                           await SunmiPrinter.startTransactionPrint(true);
//                           await SunmiPrinter.printText('Hello I\'m bold',
//                               style: SunmiStyle(bold: true));
//                           await SunmiPrinter.lineWrap(2);
//                           await SunmiPrinter.exitTransactionPrint(true);
//                         },
//                         child: const Text('Bold Text')),
//                     ElevatedButton(
//                         onPressed: () async {
//                           await SunmiPrinter.initPrinter();
//                           await SunmiPrinter.startTransactionPrint(true);
//                           await SunmiPrinter.printText('Very small!',
//                               style: SunmiStyle(fontSize: SunmiFontSize.XS));
//                           await SunmiPrinter.lineWrap(2);

//                           await SunmiPrinter.exitTransactionPrint(true);
//                         },
//                         child: const Text('Very small font')),
//                     ElevatedButton(
//                         onPressed: () async {
//                           await SunmiPrinter.initPrinter();
//                           await SunmiPrinter.startTransactionPrint(true);
//                           await SunmiPrinter.printText('Very small!',
//                               style: SunmiStyle(fontSize: SunmiFontSize.SM));
//                           await SunmiPrinter.lineWrap(2);
//                           await SunmiPrinter.exitTransactionPrint(true);
//                         },
//                         child: const Text('Small font')),
//                     ElevatedButton(
//                         onPressed: () async {
//                           await SunmiPrinter.initPrinter();
//                           await SunmiPrinter.startTransactionPrint(true);
//                           await SunmiPrinter.printText('Normal font',
//                               style: SunmiStyle(fontSize: SunmiFontSize.MD));

//                           await SunmiPrinter.lineWrap(2);
//                           await SunmiPrinter.exitTransactionPrint(true);
//                         },
//                         child: const Text('Normal font')),
//                     ElevatedButton(
//                         onPressed: () async {
//                           await SunmiPrinter.initPrinter();
//                           await SunmiPrinter.printText('Large font',
//                               style: SunmiStyle(fontSize: SunmiFontSize.LG));

//                           await SunmiPrinter.lineWrap(2);
//                           await SunmiPrinter.exitTransactionPrint(true);
//                         },
//                         child: const Text('Large font')),
//                     ElevatedButton(
//                         onPressed: () async {
//                           await SunmiPrinter.initPrinter();
//                           await SunmiPrinter.startTransactionPrint(true);
//                           await SunmiPrinter.setFontSize(SunmiFontSize.XL);
//                           await SunmiPrinter.printText('Very Large font!');
//                           await SunmiPrinter.resetFontSize();
//                           await SunmiPrinter.lineWrap(2);
//                           await SunmiPrinter.exitTransactionPrint(true);
//                         },
//                         child: const Text('Very large font')),
//                     ElevatedButton(
//                         onPressed: () async {
//                           await SunmiPrinter.initPrinter();
//                           await SunmiPrinter.startTransactionPrint(true);
//                           await SunmiPrinter.setCustomFontSize(13);
//                           await SunmiPrinter.printText('Very Large font!');
//                           await SunmiPrinter.resetFontSize();
//                           await SunmiPrinter.lineWrap(2);
//                           await SunmiPrinter.exitTransactionPrint(true);
//                         },
//                         child: const Text('Custom size font')),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     ElevatedButton(
//                         onPressed: () async {
//                           await SunmiPrinter.initPrinter();
//                           await SunmiPrinter.startTransactionPrint(true);
//                           await SunmiPrinter.printText('Align right',
//                               style: SunmiStyle(align: SunmiPrintAlign.RIGHT));
//                           await SunmiPrinter.lineWrap(2);
//                           await SunmiPrinter.exitTransactionPrint(true);
//                         },
//                         child: const Text('Align right')),
//                     ElevatedButton(
//                         onPressed: () async {
//                           await SunmiPrinter.initPrinter();

//                           await SunmiPrinter.startTransactionPrint(true);
//                           await SunmiPrinter.printText('Align left',
//                               style: SunmiStyle(align: SunmiPrintAlign.LEFT));

//                           await SunmiPrinter.lineWrap(2);
//                           await SunmiPrinter.exitTransactionPrint(true);
//                         },
//                         child: const Text('Align left')),
//                     ElevatedButton(
//                       onPressed: () async {
//                         await SunmiPrinter.initPrinter();

//                         await SunmiPrinter.startTransactionPrint(true);
//                         await SunmiPrinter.printText(
//                           'Align center/ LARGE TEXT AND BOLD',
//                           style: SunmiStyle(
//                               align: SunmiPrintAlign.CENTER,
//                               bold: true,
//                               fontSize: SunmiFontSize.LG),
//                         );

//                         await SunmiPrinter.lineWrap(2);
//                         await SunmiPrinter.exitTransactionPrint(true);
//                       },
//                       child: const Text('Align center'),
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     GestureDetector(
//                       onTap: () async {
//                         await SunmiPrinter.initPrinter();

//                         Uint8List byte =
//                             await _getImageFromAsset('assets/imgs/logo_neitor.png');
//                         await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);

//                         await SunmiPrinter.startTransactionPrint(true);
//                         await SunmiPrinter.printImage(byte);
//                         await SunmiPrinter.lineWrap(2);
//                         await SunmiPrinter.exitTransactionPrint(true);
//                       },
//                       child: Column(
//                         children: [
//                           Image.asset(
//                             'assets/imgs/logo_neitor.png',
//                             width: 100,
//                           ),
//                           const Text('Print this image from asset!')
//                         ],
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () async {
//                         await SunmiPrinter.initPrinter();

//                         String url =
//                             'https://avatars.githubusercontent.com/u/14101776?s=100';
//                         // convert image to Uint8List format
//                         Uint8List byte =
//                             (await NetworkAssetBundle(Uri.parse(url)).load(url))
//                                 .buffer
//                                 .asUint8List();
//                         await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
//                         await SunmiPrinter.startTransactionPrint(true);
//                         await SunmiPrinter.printImage(byte);
//                         await SunmiPrinter.lineWrap(2);
//                         await SunmiPrinter.exitTransactionPrint(true);
//                       },
//                       child: Column(
//                         children: [
//                           Image.network(
//                               'https://avatars.githubusercontent.com/u/14101776?s=100'),
//                           const Text('Print this image from WEB!')
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const Divider(),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       ElevatedButton(
//                           onPressed: () async {
//                             await SunmiPrinter.cut();
//                           },
//                           child: const Text('CUT PAPER')),
//                     ]),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       ElevatedButton(
//                           onPressed: () async {
//                             await SunmiPrinter.initPrinter();

//                             await SunmiPrinter.startTransactionPrint(true);
//                             await SunmiPrinter.setAlignment(
//                                 SunmiPrintAlign.CENTER);
//                             await SunmiPrinter.line();
//                             await SunmiPrinter.printText('Payment receipt');
//                             await SunmiPrinter.printText(
//                                 'Using the old way to bold!');
//                             await SunmiPrinter.line();

//                             await SunmiPrinter.printRow(cols: [
//                               ColumnMaker(
//                                   text: 'Name',
//                                   width: 12,
//                                   align: SunmiPrintAlign.LEFT),
//                               ColumnMaker(
//                                   text: 'Qty',
//                                   width: 6,
//                                   align: SunmiPrintAlign.CENTER),
//                               ColumnMaker(
//                                   text: 'UN',
//                                   width: 6,
//                                   align: SunmiPrintAlign.RIGHT),
//                               ColumnMaker(
//                                   text: 'TOT',
//                                   width: 6,
//                                   align: SunmiPrintAlign.RIGHT),
//                             ]);

//                             await SunmiPrinter.printRow(cols: [
//                               ColumnMaker(
//                                   text: 'Fries',
//                                   width: 12,
//                                   align: SunmiPrintAlign.LEFT),
//                               ColumnMaker(
//                                   text: '4x',
//                                   width: 6,
//                                   align: SunmiPrintAlign.CENTER),
//                               ColumnMaker(
//                                   text: '3.00',
//                                   width: 6,
//                                   align: SunmiPrintAlign.RIGHT),
//                               ColumnMaker(
//                                   text: '12.00',
//                                   width: 6,
//                                   align: SunmiPrintAlign.RIGHT),
//                             ]);

//                             await SunmiPrinter.printRow(cols: [
//                               ColumnMaker(
//                                   text: 'Strawberry',
//                                   width: 12,
//                                   align: SunmiPrintAlign.LEFT),
//                               ColumnMaker(
//                                   text: '1x',
//                                   width: 6,
//                                   align: SunmiPrintAlign.CENTER),
//                               ColumnMaker(
//                                   text: '24.44',
//                                   width: 6,
//                                   align: SunmiPrintAlign.RIGHT),
//                               ColumnMaker(
//                                   text: '24.44',
//                                   width: 6,
//                                   align: SunmiPrintAlign.RIGHT),
//                             ]);

//                             await SunmiPrinter.printRow(cols: [
//                               ColumnMaker(
//                                   text: 'Soda',
//                                   width: 12,
//                                   align: SunmiPrintAlign.LEFT),
//                               ColumnMaker(
//                                   text: '1x',
//                                   width: 6,
//                                   align: SunmiPrintAlign.CENTER),
//                               ColumnMaker(
//                                   text: '1.99',
//                                   width: 6,
//                                   align: SunmiPrintAlign.RIGHT),
//                               ColumnMaker(
//                                   text: '1.99',
//                                   width: 6,
//                                   align: SunmiPrintAlign.RIGHT),
//                             ]);

//                             await SunmiPrinter.line();
//                             await SunmiPrinter.printRow(cols: [
//                               ColumnMaker(
//                                   text: 'TOTAL',
//                                   width: 25,
//                                   align: SunmiPrintAlign.LEFT),
//                               ColumnMaker(
//                                   text: '38.43',
//                                   width: 5,
//                                   align: SunmiPrintAlign.RIGHT),
//                             ]);

//                             await SunmiPrinter.printRow(cols: [
//                               ColumnMaker(
//                                   text: 'ARABIC TEXT',
//                                   width: 15,
//                                   align: SunmiPrintAlign.LEFT),
//                               ColumnMaker(
//                                   text: 'اسم المشترك',
//                                   width: 15,
//                                   align: SunmiPrintAlign.LEFT),
//                             ]);

//                             await SunmiPrinter.printRow(cols: [
//                               ColumnMaker(
//                                   text: 'اسم المشترك',
//                                   width: 15,
//                                   align: SunmiPrintAlign.LEFT),
//                               ColumnMaker(
//                                   text: 'اسم المشترك',
//                                   width: 15,
//                                   align: SunmiPrintAlign.LEFT),
//                             ]);

//                             await SunmiPrinter.printRow(cols: [
//                               ColumnMaker(
//                                   text: 'RUSSIAN TEXT',
//                                   width: 15,
//                                   align: SunmiPrintAlign.LEFT),
//                               ColumnMaker(
//                                   text: 'Санкт-Петербу́рг',
//                                   width: 15,
//                                   align: SunmiPrintAlign.LEFT),
//                             ]);
//                             await SunmiPrinter.printRow(cols: [
//                               ColumnMaker(
//                                   text: 'Санкт-Петербу́рг',
//                                   width: 15,
//                                   align: SunmiPrintAlign.LEFT),
//                               ColumnMaker(
//                                   text: 'Санкт-Петербу́рг',
//                                   width: 15,
//                                   align: SunmiPrintAlign.LEFT),
//                             ]);

//                             await SunmiPrinter.printRow(cols: [
//                               ColumnMaker(
//                                   text: 'CHINESE TEXT',
//                                   width: 15,
//                                   align: SunmiPrintAlign.LEFT),
//                               ColumnMaker(
//                                   text: '風俗通義',
//                                   width: 15,
//                                   align: SunmiPrintAlign.LEFT),
//                             ]);
//                             await SunmiPrinter.printRow(cols: [
//                               ColumnMaker(
//                                   text: '風俗通義',
//                                   width: 15,
//                                   align: SunmiPrintAlign.LEFT),
//                               ColumnMaker(
//                                   text: '風俗通義',
//                                   width: 15,
//                                   align: SunmiPrintAlign.LEFT),
//                             ]);

//                             await SunmiPrinter.setAlignment(
//                                 SunmiPrintAlign.CENTER);
//                             await SunmiPrinter.line();
//                             await SunmiPrinter.bold();
//                             await SunmiPrinter.printText(
//                                 'Transaction\'s Qrcode');
//                             await SunmiPrinter.resetBold();
//                             await SunmiPrinter.printQRCode(
//                                 'https://github.com/brasizza/sunmi_printer');
//                             await SunmiPrinter.lineWrap(2);
//                             await SunmiPrinter.exitTransactionPrint(true);
//                           },
//                           child: const Text('TICKET EXAMPLE')),
//                     ]),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       ElevatedButton(
//                           onPressed: () async {
//                             final List<int> _escPos = await _customEscPos();
//                             await SunmiPrinter.initPrinter();
//                             await SunmiPrinter.startTransactionPrint(true);
//                             await SunmiPrinter.printRawData(
//                                 Uint8List.fromList(_escPos));
//                             await SunmiPrinter.exitTransactionPrint(true);
//                           },
//                           child: const Text('Custom ESC/POS to print')),
//                     ]),
//               ),
//             ],
//           ),
//         ));
//   }
// }

// Future<Uint8List> readFileBytes(String path) async {
//   ByteData fileData = await rootBundle.load(path);
//   Uint8List fileUnit8List = fileData.buffer
//       .asUint8List(fileData.offsetInBytes, fileData.lengthInBytes);
//   return fileUnit8List;
// }

// Future<Uint8List> _getImageFromAsset(String iconPath) async {
//   return await readFileBytes(iconPath);
// }

// Future<List<int>> _customEscPos() async {
//   final profile = await CapabilityProfile.load();
//   final generator = Generator(PaperSize.mm58, profile);
//   List<int> bytes = [];

//   bytes += generator.text(
//       'Regular: aA bB cC dD eE fF gG hH iI jJ kK lL mM nN oO pP qQ rR sS tT uU vV wW xX yY zZ');
//   bytes += generator.text('Special 1: àÀ èÈ éÉ ûÛ üÜ çÇ ôÔ',
//       styles: const PosStyles(codeTable: 'CP1252'));
//   bytes += generator.text('Special 2: blåbærgrød',
//       styles: const PosStyles(codeTable: 'CP1252'));

//   bytes += generator.text('Bold text', styles: const PosStyles(bold: true));
//   bytes +=
//       generator.text('Reverse text', styles: const PosStyles(reverse: true));
//   bytes += generator.text('Underlined text',
//       styles: const PosStyles(underline: true), linesAfter: 1);
//   bytes += generator.text('Align left',
//       styles: const PosStyles(align: PosAlign.left));
//   bytes += generator.text('Align center',
//       styles: const PosStyles(align: PosAlign.center));
//   bytes += generator.text('Align right',
//       styles: const PosStyles(align: PosAlign.right), linesAfter: 1);
//   bytes += generator.qrcode('Barcode by escpos',
//       size: QRSize.Size4, cor: QRCorrection.H);
//   bytes += generator.feed(2);

//   bytes += generator.row([
//     PosColumn(
//       text: 'col3',
//       width: 3,
//       styles: const PosStyles(align: PosAlign.center, underline: true),
//     ),
//     PosColumn(
//       text: 'col6',
//       width: 6,
//       styles: const PosStyles(align: PosAlign.center, underline: true),
//     ),
//     PosColumn(
//       text: 'col3',
//       width: 3,
//       styles: const PosStyles(align: PosAlign.center, underline: true),
//     ),
//   ]);

//   bytes += generator.text('Text size 200%',
//       styles: const PosStyles(
//         height: PosTextSize.size2,
//         width: PosTextSize.size2,
//       ));

//   bytes += generator.reset();
//   bytes += generator.cut();

//   return bytes;
// }

//====================================================================//


// class BluetoothPage extends StatefulWidget {
//   @override
//   _BluetoothPageState createState() => _BluetoothPageState();
// }

// class _BluetoothPageState extends State<BluetoothPage> {
//   List<ScanResult> _scanResults = [];
//   bool _scanning = false;

//   void _scanForDevices() async {
//     if (_scanning) {
//       FlutterBluePlus.stopScan();
//       setState(() {
//         _scanning = false;
//       });
//     } else {
//       FlutterBluePlus.startScan(timeout: Duration(seconds: 4));
//       setState(() {
//         _scanning = true;
//       });

//       FlutterBluePlus.scanResults.listen((results) {
//         setState(() {
//           _scanResults = results;
//           _scanning = false;
//         });
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Bluetooth Devices'),
//       ),
//       body: Column(
//         children: [
//           ElevatedButton(
//             onPressed: _scanForDevices,
//             child: Text(_scanning ? 'Stop Scanning' : 'Scan for Devices'),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: _scanResults.length,
//               itemBuilder: (context, index) {
//                 final result = _scanResults[index];
//                 final device = result.device;
//                 return ListTile(
//                   title: Text(device.name.isNotEmpty ? device.name : 'Unnamed Device'),
//                   subtitle: Text(device.id.toString()),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

//================ ok   ====================//

// class BluetoothPage extends StatefulWidget {
//   @override
//   _BluetoothPageState createState() => _BluetoothPageState();
// }

// class _BluetoothPageState extends State<BluetoothPage> {
//   List<ScanResult> _scanResults = [];
//   bool _scanning = false;
//   BluetoothDevice? _selectedDevice;

//   void _scanForDevices() async {
//     if (_scanning) {
//       FlutterBluePlus.stopScan();
//       setState(() {
//         _scanning = false;
//       });
//     } else {
//       FlutterBluePlus.startScan(timeout: Duration(seconds: 4));
//       setState(() {
//         _scanning = true;
//       });

//       FlutterBluePlus.scanResults.listen((results) {
//         setState(() {
//           _scanResults = results;
//           _scanning = false;
//         });
//       });
//     }
//   }

//   Future<void> _printTest() async {
//     if (_selectedDevice == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Please select a printer first')),
//       );
//       return;
//     }

//     // Crear un documento PDF
//     final pdf = await Printing.convertHtml(
//       html: '''
//       <html>
//       <body>
//         <h1>Hello from Flutter!</h1>
//         <p>This is a test print.</p>
//         <p>Powered by PDF printing</p>
//       </body>
//       </html>
//       ''',
//       format: PdfPageFormat.a4,
//     );

//     try {
//       // Enviar el documento PDF a la impresora seleccionada
//       await Printing.layoutPdf(
//         onLayout: (PdfPageFormat format) async => pdf,
//       );
//       print("Printing test message to ${_selectedDevice!.name}");
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to print: $e')),
//       );
//       print("Failed to print: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Bluetooth Devices'),
//       ),
//       body: Column(
//         children: [
//           ElevatedButton(
//             onPressed: _scanForDevices,
//             child: Text(_scanning ? 'Stop Scanning' : 'Scan for Devices'),
//           ),
//           ElevatedButton(
//             onPressed: _printTest,
//             child: Text('Print Test'),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: _scanResults.length,
//               itemBuilder: (context, index) {
//                 final result = _scanResults[index];
//                 final device = result.device;
//                 return ListTile(
//                   title: Text(device.name.isNotEmpty ? device.name : 'Unnamed Device'),
//                   subtitle: Text(device.id.toString()),
//                   onTap: () {
//                     setState(() {
//                       _selectedDevice = device;
//                     });
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text('Selected device: ${device.name}')),
//                     );
//                   },
//                   selected: _selectedDevice == device,
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


// class BluetoothPage extends StatefulWidget {
//   @override
//   _BluetoothPageState createState() => _BluetoothPageState();
// }

// class _BluetoothPageState extends State<BluetoothPage> {
//   // final BlueThermalPrinter printer = BlueThermalPrinter();
//   List<BluetoothDevice> _devices = [];
//   BluetoothDevice? _selectedDevice;

//   @override
//   void initState() {
//     super.initState();
//     _initPrinter();
//   }

//   void _initPrinter() {
//     // Verifica si hay impresoras ya conectadas
//     printer.getBondedDevices().then((devices) {
//       setState(() {
//         _devices = devices;
//       });
//     });
//   }

//   void _scanForDevices() async {
//     // Inicia el escaneo de dispositivos
//     printer.startScan().listen((device) {
//       setState(() {
//         _devices.add(device);
//       });
//     });
//   }

//   Future<void> _printTest() async {
//     if (_selectedDevice == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Please select a printer first')),
//       );
//       return;
//     }

//     try {
//       // Conectarse a la impresora seleccionada
//       await printer.connect(_selectedDevice!);

//       // Enviar comandos de impresión
//       printer.printNewLine();
//       printer.printCustom('Hello from Flutter!', 1, 1);
//       printer.printCustom('This is a test print.', 0, 0);
//       printer.printCustom('Powered by Blue Thermal Printer', 0, 0);
//       printer.printNewLine();
//       printer.paperCut();

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Printing test message to ${_selectedDevice!.name}')),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to print: $e')),
//       );
//       print("Failed to print: $e");
//     } finally {
//       // Desconectar la impresora
//       await printer.disconnect();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Bluetooth Devices'),
//       ),
//       body: Column(
//         children: [
//           ElevatedButton(
//             onPressed: _scanForDevices,
//             child: Text('Scan for Devices'),
//           ),
//           ElevatedButton(
//             onPressed: _printTest,
//             child: Text('Print Test'),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: _devices.length,
//               itemBuilder: (context, index) {
//                 final device = _devices[index];
//                 return ListTile(
//                   title: Text(device.name.isNotEmpty ? device.name : 'Unnamed Device'),
//                   subtitle: Text(device.id.toString()),
//                   onTap: () {
//                     setState(() {
//                       _selectedDevice = device;
//                     });
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text('Selected device: ${device.name}')),
//                     );
//                   },
//                   selected: _selectedDevice == device,
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class BluetoothPage extends StatefulWidget {
//   @override
//   _BluetoothPageState createState() => _BluetoothPageState();
// }

// class _BluetoothPageState extends State<BluetoothPage> {
//   BluetoothPrint _bluetoothPrint = BluetoothPrint.instance;
//   List<btPrint.BluetoothDevice> _devices = [];
//   btPrint.BluetoothDevice? _selectedDevice;
//   bool _connected = false;

//   @override
//   void initState() {
//     super.initState();
//     _scanForDevices();
//     _bluetoothPrint.state.listen((state) {
//       setState(() {
//         _connected = state == BluetoothPrint.CONNECTED;
//       });
//     });
//   }

//   void _scanForDevices() async {
//     _devices = [];
//     _bluetoothPrint.startScan(timeout: Duration(seconds: 4));
//     _bluetoothPrint.scanResults.listen((devices) {
//       setState(() {
//         _devices = devices;
//       });
//     });
//   }

//   void _connectToDevice() async {
//     if (_selectedDevice == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Please select a device first')),
//       );
//       return;
//     }

//     await _bluetoothPrint.connect(_selectedDevice!);
//   }

//   void _printTest() async {
//     if (!_connected) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Please connect to the printer first')),
//       );
//       return;
//     }

//     Map<String, dynamic> config = {};
//     List<btPrint.LineText> list = [];

//     list.add(btPrint.LineText(
//       type: btPrint.LineText.TYPE_TEXT,
//       content: '*-*-*-*-*-*-  Hello from *** FFFFFFSlutter!',
//       align: btPrint.LineText.ALIGN_CENTER,
//       weight: 1,
//       linefeed: 1,
//     ));
//     list.add(btPrint.LineText(
//       type: btPrint.LineText.TYPE_TEXT,
//       content: '++++++ This is a test print.',
//       align: btPrint.LineText.ALIGN_LEFT,
//       linefeed: 1,
//     ));
//     list.add(btPrint.LineText(
//       type: btPrint.LineText.TYPE_TEXT,
//       content: '333333 Powered by ESC/POS',
//       align: btPrint.LineText.ALIGN_LEFT,
//       linefeed: 1,
//     ));
//     list.add(btPrint.LineText(
//       type: '1',
//       linefeed: 2,
//     ));
//     list.add(btPrint.LineText(
//       type: '1',
//     ));

//     await _bluetoothPrint.printReceipt(config, list);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Bluetooth Devices'),
//       ),
//       body: Column(
//         children: [
//           ElevatedButton(
//             onPressed: _scanForDevices,
//             child: Text('Scan for Devices'),
//           ),
//           ElevatedButton(
//             onPressed: _connectToDevice,
//             child: Text('Connect'),
//           ),
//           ElevatedButton(
//             onPressed: _printTest,
//             child: Text('Print Test'),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: _devices.length,
//               itemBuilder: (context, index) {
//                 final device = _devices[index];
//                 return ListTile(
//                   title: Text(device.name ?? 'Unnamed Device'),
//                   subtitle: Text(device.address!),
//                   onTap: () {
//                     setState(() {
//                       _selectedDevice = device;
//                     });
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text('Selected device: ${device.name}')),
//                     );
//                   },
//                   selected: _selectedDevice == device,
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



// class BluetoothPage extends StatefulWidget {
//   @override
//   _BluetoothPageState createState() => _BluetoothPageState();
// }

// class _BluetoothPageState extends State<BluetoothPage> {
// BluetoothPrint bluetoothPrint = BluetoothPrint.instance;
//   List<btPrint.BluetoothDevice> _devices = [];
//   String _deviceMsg = '';

//   @override
//   void initState() {
//     super.initState();
//     bluetoothPrint = BluetoothPrint.instance;
//     WidgetsBinding.instance?.addPostFrameCallback((_) => initPrinter());
//   }

//   Future<void> initPrinter() async {
//     bluetoothPrint.startScan(timeout: Duration(seconds: 5));

//     // Asegúrate de que el widget sigue montado antes de actualizar el estado
//     if (!mounted) return;

//     bluetoothPrint.scanResults.listen((List<btPrint.BluetoothDevice> devices) {
//       if (!mounted) return;
//       setState(() {
//         _devices = devices;
//       });
//     });
//   }

  // BluetoothPrint _bluetoothPrint = BluetoothPrint.instance;
  // List<btPrint.BluetoothDevice> _devices = [];
  // btPrint.BluetoothDevice? _selectedDevice;
  // bool _connected = false;
  // bool _isScanning = false;

  // @override
  // void initState() {
  //   super.initState();
  //   _bluetoothPrint.state.listen((state) {
  //     setState(() {
  //       _connected = state == BluetoothPrint.CONNECTED;
  //     });
  //   });
  //   _scanForDevices();
  // }

  // void _scanForDevices() async {
  //   if (_isScanning) return;

  //   setState(() {
  //     _isScanning = true;
  //   });

  //   _devices = [];
  //   await _bluetoothPrint.startScan(timeout: Duration(seconds: 5));

  //   _bluetoothPrint.scanResults.listen((devices) {
  //     setState(() {
  //       _devices = devices;
  //       _isScanning = false;
  //     });
  //   }).onError((error) {
  //     setState(() {
  //       _isScanning = false;
  //     });
  //   });
  // }

  // void _connectToDevice() async {
  //   if (_selectedDevice == null) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Please select a device first')),
  //     );
  //     return;
  //   }

  //   final isConnected = await _bluetoothPrint.connect(_selectedDevice!);
  //   setState(() {
  //     _connected = isConnected;
  //   });
  // }

  // void _printTest() async {
  //   if (!_connected) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Please connect to the printer first')),
  //     );
  //     return;
  //   }

  //   Map<String, dynamic> config = {};
  //   List<btPrint.LineText> list = [];

  //   list.add(btPrint.LineText(
  //     type: btPrint.LineText.TYPE_TEXT,
  //     content: 'Hello from Flutter!',
  //     align: btPrint.LineText.ALIGN_CENTER,
  //     weight: 1,
  //     linefeed: 1,
  //   ));
  //   list.add(btPrint.LineText(
  //     type: btPrint.LineText.TYPE_TEXT,
  //     content: 'This is a test print.',
  //     align: btPrint.LineText.ALIGN_LEFT,
  //     linefeed: 1,
  //   ));
  //   list.add(btPrint.LineText(
  //     type: btPrint.LineText.TYPE_TEXT,
  //     content: 'Powered by ESC/POS',
  //     align: btPrint.LineText.ALIGN_LEFT,
  //     linefeed: 1,
  //   ));
  //   list.add(btPrint.LineText(
  //     type: '2',
  //     linefeed: 2,
  //   ));

  //   await _bluetoothPrint.printReceipt(config, list);
  // }






  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Bluetooth Devices'),
  //     ),
  //     body: Column(
  //       children: [
  //         // ElevatedButton(
  //         //   onPressed: *(_scanForDevices,
  //         //   child: _isScanning ? Text('Scanning...') : Text('Scan for Devices'),
  //         // ),
  //         // ElevatedButton(
  //         //   onPressed: _connectToDevice,
  //         //   child: Text('Connect'),
  //         // ),
  //         // ElevatedButton(
  //         //   onPressed: _printTest,
  //         //   child: Text('Print Test'),
  //         // ),
  //          ElevatedButton(
  //           onPressed: (){},
  //           child:  Text('Scan for Devices'),
  //         ),
  //         ElevatedButton(
  //           onPressed: (){},
  //           child: Text('Connect'),
  //         ),
  //         ElevatedButton(
  //            onPressed: (){},
  //           child: Text('Print Test'),
  //         ),
  //         Expanded(
  //           child: ListView.builder(
  //             itemCount: _devices.length,
  //             itemBuilder: (context, index) {
  //               final device = _devices[index];
  //               return ListTile(
  //                 title: Text(device.name ?? 'Unnamed Device'),
  //                 subtitle: Text(device.address!),
  //                 onTap: () {
  //                   // setState(() {
  //                   //   // _selectedDevice = device;
  //                   // });
  //                    _startPrint(device);
  //                   ScaffoldMessenger.of(context).showSnackBar(
  //                     SnackBar(content: Text('Selected device: ${device.name}')),
  //                   );
  //                 },
  //                 // selected: _selectedDevice == device,
  //               );
  //             },
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

// Future<void> _startPrint(BluetoothDevice device) async {
//   if (device != null && device.address != null) {
//     try {
//       // Conectar al dispositivo Bluetooth
//       await bluetoothPrint.connect(device);

//       // Configurar impresión
//       Map<String, dynamic> config = {};

//       List<btPrint.LineText> list = [];

//       // Agregar texto de prueba a la lista
//       list.add(
//         btPrint.LineText(
//           type: btPrint.LineText.TYPE_TEXT,
//           content: 'PRUEBA NEITOR',
//           weight: 2,
//           width: 2,
//           height: 2,
//           align: btPrint.LineText.ALIGN_CENTER,
//           linefeed: 1,
//         ),
//       );

//       // Agregar más elementos a la lista aquí si es necesario
//       // for (var item in items) {
//       //   // Aquí puedes agregar los elementos de `items` a `list`
//       //   // Ejemplo: list.add(btPrint.LineText(...));
//       // }

//       // Enviar la lista para imprimir
//       await bluetoothPrint.printReceipt(config, list);

//       // Desconectar después de imprimir
//       await bluetoothPrint.disconnect();

//     } catch (e) {
//       // Manejo de errores
//       print('Error durante la impresión: $e');
//     }
//   } else {
//     print('Dispositivo Bluetooth no válido.');
//   }
// }

// Future<void> _startPrint(flutterBlue.BluetoothDevice device) async{
// if (device!=null && device.address !=null) {

//   await bluetoothPrint.connect(device);


// Map<String,dynamic> config =Map();

// List<btPrint.LineText> list=[];

// list.add(
//   btPrint.LineText(
//     type: btPrint.LineText.TYPE_TEXT,
//     content: 'PRUEBA NEITOR',
//     weight: 2,
//     width: 2,
//     height: 2,
//     align: btPrint.LineText.ALIGN_CENTER,
//     linefeed: 1
//   ),
// );

// for (var item in items) {
  
// }


  
// }

// }





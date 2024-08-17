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

void main() => runApp(const MyApp());

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
          // initialRoute: 'crearReceta',
          
          // initialRoute: 'compras',
          routes: appRoutes,
          navigatorKey: homeController.navigatorKey,
          scaffoldMessengerKey: NotificatiosnService.messengerKey,
        );
        
        })
    );
  }
}
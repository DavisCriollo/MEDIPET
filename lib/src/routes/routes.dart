import 'package:flutter/material.dart';
import 'package:neitorcont/src/pages/crear_historia_clinica.dart';
import 'package:neitorcont/src/pages/crear_hospitalizacion.dart';
import 'package:neitorcont/src/pages/crear_mascota.dart';
import 'package:neitorcont/src/pages/crear_peluqueria.dart';
import 'package:neitorcont/src/pages/crear_propietario.dart';
import 'package:neitorcont/src/pages/crear_receta.dart';
import 'package:neitorcont/src/pages/crear_reserva.dart';
import 'package:neitorcont/src/pages/crear_tutorial.dart';
import 'package:neitorcont/src/pages/crear_vacunas.dart';
import 'package:neitorcont/src/pages/detalle_propietario.dart';
import 'package:neitorcont/src/pages/home_page.dart';
import 'package:neitorcont/src/pages/lista_clientes.dart';
import 'package:neitorcont/src/pages/lista_propietario.dart';
import 'package:neitorcont/src/pages/lista_propietarios_paginacion.dart';
import 'package:neitorcont/src/pages/listar_mascotas.dart';
import 'package:neitorcont/src/pages/listar_videos.dart';
import 'package:neitorcont/src/pages/login_page.dart';
import 'package:neitorcont/src/pages/password_page.dart';
import 'package:neitorcont/src/pages/print.dart';
import 'package:neitorcont/src/pages/prueba.dart';
import 'package:neitorcont/src/pages/splash_screen.dart';
import 'package:neitorcont/src/pages/submenu_mascotas.dart';
import 'package:neitorcont/src/pages/submenu_transacciones.dart';






final Map<String, Widget Function(BuildContext)> appRoutes = {
  'splash': (_) => const SplashPage(),
  'login': (_) => const LoginPage(),
  'home': (_) => const HomePage(),
  'password': (_) =>  const PasswordPage(),
  'SubmenuMascotas': (_) =>  const SubmenuMascotas(),
  'SubmenuTransacciones': (_) =>  const SubmenuTransacciones(),
  'listaPropietarios': (_) =>  const ListaPropietarios(),
  'listaPropietariosPaginacion': (_) =>  const ListaPropietariosPaginacion(),
  'crearPropietario': (_) =>  const CrearPropietario(),
  'detallePropietarioPage': (_) =>  const DetallePropietarioPage(),
  'ListaClientes': (_) =>  const ListaClientes(),
  'crearMascota': (_) =>  const CrearMascota(),
  'crearReceta': (_) =>  const CrearReceta(),
  'crearHistiriaClinica': (_) =>  const CrearHistiriaClinica(),
  'crearVacunas': (_) =>  const CrearVacunas(),
  'creaPeluqueria': (_) =>  const CreaPeluqueria(),
  'crearHospitalizacion': (_) =>  const CrearHospitalizacion(),
  'detalleHospitalizacion': (_) =>  const CrearHospitalizacion(),
  'detallePeluqueria': (_) =>  const CrearHospitalizacion(),
  'listaVideos': (_) =>  const ListaVideos(),
  'crearTutorial': (_) =>  const CrearTutorial(),
  'crearReserva': (_) =>  const CrearReserva(),

  // 'SunmiScreen': (_) =>   InnerPrinterExample(),
 
  
};


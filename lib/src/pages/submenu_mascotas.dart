import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:neitorcont/src/controllers/historia_clinica.controller.dart';
import 'package:neitorcont/src/controllers/hospitalizacion_controller.dart';
import 'package:neitorcont/src/controllers/mascotas_controller.dart';
import 'package:neitorcont/src/controllers/peluqueria_controller.dart';
import 'package:neitorcont/src/controllers/recetas_controller.dart';
import 'package:neitorcont/src/controllers/vacunas_controller.dart';
import 'package:neitorcont/src/pages/lista_historia_clinica.dart';
import 'package:neitorcont/src/pages/lista_hospitalizacion.dart';
import 'package:neitorcont/src/pages/lista_peluqueria.dart';
import 'package:neitorcont/src/pages/lista_recetas.dart';
import 'package:neitorcont/src/pages/lista_vacunas.dart';
import 'package:neitorcont/src/pages/listar_historia_clinica_paginacion.dart';
import 'package:neitorcont/src/pages/listar_hospitalizacion_paginacion.dart';
import 'package:neitorcont/src/pages/listar_mascotas.dart';
import 'package:neitorcont/src/pages/listar_mascotas_paginacion.dart';
import 'package:neitorcont/src/pages/listar_peluqueria_paginacion.dart';
import 'package:neitorcont/src/pages/listar_recetas_paginacion.dart';
import 'package:neitorcont/src/pages/listar_vacunas_paginacion.dart';
import 'package:neitorcont/src/services/socket_service.dart';
import 'package:neitorcont/src/utils/responsive.dart';
import 'package:neitorcont/src/widgets/elementos_submenu.dart';
import 'package:neitorcont/src/widgets/no_data.dart';
import 'package:provider/provider.dart';

class SubmenuMascotas extends StatelessWidget {
  const SubmenuMascotas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title:  Text('MASCOTAS'),
        ),
        body: Container(
            width: size.wScreen(100),
            height: size.hScreen(100),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF973592).withOpacity(0.5),
                  const Color(0xFF0092D0).withOpacity(0.3),
                ],
                stops: const [0.1, 0.6],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child:  Center(
                      child: Wrap(children: [
                        ElementosSubmenu(
                          enabled: true,
                          size: size,
                          image: 'assets/imgs/medical-record.png',
                          label: "HISTORIA\nCLíNICA",
                          color: Colors.green,
                          // onTap: () => Navigator.pushNamed(context, 'mascotas'),
                          onTap: () {

                                  final _controllerHistorias =
                                context.read<HistoriaClinicaController>();

                            _controllerHistorias
                                .onSearchTextHistoriaPaginacion("");

                            _controllerHistorias
                                .setBtnSearchHistoriaPaginacion(false);
                            _controllerHistorias
                                .setErrorHistoriasPaginacion(null);

                            _controllerHistorias
                                .setError401HistoriasPaginacion(false);

                            _controllerHistorias.resetFormHistClinica();
                            _controllerHistorias.setPage(0);
                            _controllerHistorias.setIsNext(false);
                            _controllerHistorias
                                .setInfoBusquedaHistoriasPaginacion([]);
                            _controllerHistorias.buscaAllHistoriasPaginacion(
                                '', true);





                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const ListaHistoriaClinicaPaginacion()));
                          },
                        ),
                        ElementosSubmenu(
                          enabled: true,
                          size: size,
                          image: 'assets/imgs/dog.png',
                          label: 'MASCOTAS',
                          color: Colors.pink,
                          // onTap: () => Navigator.pushNamed(context, 'listaMascotas'),
                          onTap: () {
                            final _controllerMascotas =
                                context.read<MascotasController>();

                            _controllerMascotas
                                .onSearchTextMascotaPaginacion("");

                            _controllerMascotas
                                .setBtnSearchMascotaPaginacion(false);
                            _controllerMascotas
                                .setErrorMascotasPaginacion(null);

                            _controllerMascotas
                                .setError401MascotasPaginacion(false);

                            _controllerMascotas.resetFormMascota();
                            _controllerMascotas.setPage(0);
                            _controllerMascotas.setIsNext(false);
                            _controllerMascotas
                                .setInfoBusquedaMascotasPaginacion([]);
                            _controllerMascotas.buscaAllMascotasPaginacion(
                                '', true);

                            Navigator.of(context).push(MaterialPageRoute(
                                // builder: (context) => const ListaMascotas()));
                                builder: (context) =>
                                    const ListaMascotaPaginacion()));
                          },
                        ),
                        ElementosSubmenu(
                          enabled: true,
                          size: size,
                          image: 'assets/imgs/prescription.png',
                          label: 'RECETAS',
                          color: Colors.blue,
                          // onTap: () => Navigator.pushNamed(context, 'mascotas'),
                          onTap: () {


 final _controllerReceta =
                                context.read<RecetasController>();

                            _controllerReceta
                                .onSearchTextRecetaPaginacion("");

                            _controllerReceta
                                .setBtnSearchRecetaPaginacion(false);
                            _controllerReceta
                                .setErrorRecetasPaginacion(null);

                            _controllerReceta
                                .setError401RecetasPaginacion(false);

                            _controllerReceta.resetFormReceta();
                            _controllerReceta.setPage(0);
                            _controllerReceta.setIsNext(false);
                            _controllerReceta
                                .setInfoBusquedaRecetasPaginacion([]);
                            _controllerReceta.buscaAllRecetasPaginacion(
                                '', true);












                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const ListaRecetasPaginacion()));
                          },
                        ),
                        ElementosSubmenu(
                          enabled: true,
                          size: size,
                          image: 'assets/imgs/syringe.png',
                          label: 'VACUNAS',
                          color: Colors.brown,
                          // onTap: () => Navigator.pushNamed(context, 'mascotas'),
                          onTap: () {
                            final _controllerVacunas =
                                context.read<VacunasController>();



                            _controllerVacunas
                                .onSearchTextVacunaPaginacion("");

                            _controllerVacunas
                                .setBtnSearchVacunaPaginacion(false);
                            _controllerVacunas
                                .setErrorVacunasPaginacion(null);

                            _controllerVacunas
                                .setError401VacunasPaginacion(false);





                            _controllerVacunas.resetFormVacuna();
                            _controllerVacunas.setPage(0);
                            _controllerVacunas.setIsNext(false);
                            _controllerVacunas
                                .setInfoBusquedaVacunasPaginacion([]);
                            _controllerVacunas.buscaAllVacunasPaginacion(
                                '', true);

                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const ListaVacunasPaginacion()));
                          },
                        ),
                        ElementosSubmenu(
                          enabled: true,
                          size: size,
                          image: 'assets/imgs/hospital_medical.png',
                          label: 'HOSPITALIZACIÓN',
                          color: Colors.purple.shade900,
                          // onTap: () => Navigator.pushNamed(context, 'mascotas'),
                          onTap: () {








                                 final _controllerHospitalizacion =
                                context.read<HospitalizacionController>();



                            _controllerHospitalizacion
                                .onSearchTextHospitalizacionPaginacion("");

                            _controllerHospitalizacion
                                .setBtnSearchHospitalizacionPaginacion(false);
                            _controllerHospitalizacion
                                .setErrorHospitalizacioinesPaginacion(null);

                            _controllerHospitalizacion
                                .setError401HospitalizacioinesPaginacion(false);





                            _controllerHospitalizacion.resetFormospitalizacion();
                            _controllerHospitalizacion.setPage(0);
                            _controllerHospitalizacion.setIsNext(false);
                            _controllerHospitalizacion
                                .setInfoBusquedaHospitalizacioinesPaginacion([]);
                            _controllerHospitalizacion.buscaAllHospitalizacioinesPaginacion(
                                '', true);









                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const ListaHospitalizacionPaginacion()));
                          },
                        ),
                        ElementosSubmenu(
                          enabled: true,
                          size: size,
                          image: 'assets/imgs/calendar.png',
                          label: 'PELUQUERIA',
                          color: Colors.purple,
                          // onTap: () => Navigator.pushNamed(context, 'mascotas'),
                          onTap: () {

                               final _controllerPeluqueria =
                                context.read<PeluqueriaController>();



                            _controllerPeluqueria
                                .onSearchTextPeluqueriaPaginacion("");

                            _controllerPeluqueria
                                .setBtnSearchPeluqueriaPaginacion(false);
                            _controllerPeluqueria
                                .setErrorPeluqueriasPaginacion(null);

                            _controllerPeluqueria
                                .setError401PeluqueriasPaginacion(false);





                            _controllerPeluqueria.resetFormPeluqueria();
                            _controllerPeluqueria.setPage(0);
                            _controllerPeluqueria.setIsNext(false);
                            _controllerPeluqueria
                                .setInfoBusquedaPeluqueriasPaginacion([]);
                            _controllerPeluqueria.buscaAllPeluqueriasPaginacion(
                                '', true);




                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const ListaPeluqueriaPagiacion()));
                          },
                        ),
                      ]),
                    )
              
              
            
            ));
  }
}

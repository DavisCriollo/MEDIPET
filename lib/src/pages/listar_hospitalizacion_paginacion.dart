import 'dart:io';

import 'package:awesome_icons/awesome_icons.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neitorcont/src/api/authentication_client.dart';
import 'package:neitorcont/src/controllers/historia_clinica.controller.dart';
import 'package:neitorcont/src/controllers/hospitalizacion_controller.dart';
import 'package:neitorcont/src/controllers/recetas_controller.dart';
import 'package:neitorcont/src/controllers/vacunas_controller.dart';
import 'package:neitorcont/src/models/sesison_model.dart';
import 'package:neitorcont/src/pages/crear_hospitalizacion.dart';
import 'package:neitorcont/src/pages/detalle_hospitalizacion.dart';
import 'package:neitorcont/src/pages/views_pdf.dart';
import 'package:neitorcont/src/services/notifications_service.dart';
import 'package:neitorcont/src/services/socket_service.dart';
import 'package:neitorcont/src/theme/themes_app.dart';
import 'package:neitorcont/src/utils/responsive.dart';
import 'package:neitorcont/src/utils/theme.dart';
import 'package:neitorcont/src/widgets/no_data.dart';
// import 'package:open_file/open_file.dart';
import 'package:open_file_safe/open_file_safe.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class ListaHospitalizacionPaginacion extends StatefulWidget {
  const ListaHospitalizacionPaginacion({Key? key}) : super(key: key);

  @override
  State<ListaHospitalizacionPaginacion> createState() =>
      _ListaHospitalizacionPaginacionState();
}

class _ListaHospitalizacionPaginacionState
    extends State<ListaHospitalizacionPaginacion> {
  final TextEditingController _textSearchController = TextEditingController();
  Session? _usuario;
  final _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        //  print('ESTAMOS EN EL FINAL DE LA PANTALLA');
        // _loadListScroll.getpage;
        // _loadListScroll.setPage(_loadListScroll.getpage);
        //  _loadListScroll.buscaAllPropietariosPaginacion('');

        final _next = context.read<HospitalizacionController>();
        if (_next.getpage != null) {
          _next.setPage(_next.getpage);
          //       providerSearchPropietario.setCantidad(25);
          _next.buscaAllHospitalizacioinesPaginacion('', false);
        } else {
          print("ES NULL POR ESO NO HACER PETICION ");
        }
      }
    });
    initData();
    super.initState();
  }

  @override
  void dispose() {
    _textSearchController.clear();
    _scrollController.dispose();
    super.dispose();
  }

  void initData() async {
    _usuario = await Auth.instance.getSession();
    final loadInfo = context.read<HospitalizacionController>();
    // Provider.of<PropietariosController>(context, listen: false);
    // await loadInfo.buscaAllHospitalizaciones('');
// await loadInfo.buscaRecomendaciones();
    // final serviceSocket = Provider.of<SocketService>(context, listen: false);
    final serviceSocket = context.read<SocketService>();
    serviceSocket.socket!.on('server:guardadoExitoso', (data) async {
      if (data['tabla'] == 'hospitalizacion') {
        loadInfo.buscaAllHospitalizacioinesPaginacion('', false);
        // NotificatiosnService.showSnackBarSuccsses(data['msg']);
      }
    });
    serviceSocket.socket!.on('server:actualizadoExitoso', (data) async {
      if (data['tabla'] == 'hospitalizacion') {
        loadInfo.buscaAllHospitalizacioinesPaginacion('', false);
        // NotificatiosnService.showSnackBarSuccsses(data['msg']);
      }
    });
    serviceSocket.socket!.on('server:eliminadoExitoso', (data) async {
      if (data['tabla'] == 'hospitalizacion') {
        loadInfo.buscaAllHospitalizacioinesPaginacion('', false);
        // NotificatiosnService.showSnackBarSuccsses(data['msg']);
      }
    });
    serviceSocket.socket?.on('server:error', (data) {
      NotificatiosnService.showSnackBarError(data['msg']);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
      final  themeColor=context.read<AppTheme>();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey.shade100,
          appBar: AppBar(
            // backgroundColor: primaryColor,
            // title: Text(
            //   'Propietarios',
            //   style: GoogleFonts.lexendDeca(
            //       fontSize: size.iScreen(2.45),
            //       color: Colors.white,
            //       fontWeight: FontWeight.normal),
            // ),
            title: Consumer<HospitalizacionController>(
              builder: (_, providerSearchHospitalizacion, __) {
                return Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: size.iScreen(0.1)),
                        child: (providerSearchHospitalizacion
                                .btnSearchHospitalizacioinesPaginacion)
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(5.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        // margin: EdgeInsets.symmetric(
                                        //     horizontal: size.iScreen(0.0)),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: size.iScreen(1.5)),
                                        color: Colors.white,
                                        height: size.iScreen(4.0),
                                        child: TextField(
                                          controller: _textSearchController,
                                          autofocus: true,
                                          onChanged: (text) {
                                            providerSearchHospitalizacion
                                                .onSearchTextHospitalizacionPaginacion(
                                                    text);

                                            if (providerSearchHospitalizacion
                                                .nameSearchHospitalizacionPaginacion
                                                .isEmpty) {
                                              //                 providerSearchHospitalizacion
                                              //     .setErrorMascotasPaginacion(null);

                                              // providerSearchHospitalizacion
                                              //     .setError401MascotasPaginacion(
                                              //         false);
                                              providerSearchHospitalizacion
                                                  .setPage(0);
                                              providerSearchHospitalizacion
                                                  .setCantidad(25);
                                              // providerSearchHospitalizacion.setIsNext(false);
                                              providerSearchHospitalizacion
                                                  .buscaAllHospitalizacioinesPaginacion(
                                                      '', true);

                                              //   providerSearchHospitalizacion
                                              //       .setBtnSearchPropietarioPaginacion(
                                              //           !providerSearchHospitalizacion
                                              //               .btnSearchPropietarioPaginacion);
                                              //   _textSearchController.text = "";
                                              //   providerSearchHospitalizacion
                                              //       .buscaAllPropietariosPaginacion(
                                              //           '', false);
                                            }

                                            // setState(() {});
                                          },
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Buscar...',
                                            // suffixIcon:
                                            // //  Icon(Icons.search),
                                            // // icon: Icon(Icons.search),
                                            //  GestureDetector(child: Icon(Icons.search),onTap: (){
                                            //   // providerSearchHospitalizacion
                                            //       // .setInfoBusquedaPropietariosPaginacion([]);
                                            //       providerSearchPropietario.setPage(0);
                                            //       providerSearchPropietario.setCantidad(25);

                                            //   providerSearchPropietario
                                            //       .buscaAllPropietariosPaginacion(
                                            //           // '0803395581');
                                            //           ' ${providerSearchPropietario.nameSearchPropietarioPaginacion}',true);

                                            // },),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Container(
                                alignment: Alignment.center,
                                width: size.wScreen(90.0),
                                child: Text(
                                  'Hospitalizaciones',
                                  style: Theme.of(context).textTheme.headline2,
                                  // style: GoogleFonts.lexendDeca(
                                  //     fontSize: size.iScreen(2.45),
                                  //     // color: Colors.white,
                                  //     fontWeight: FontWeight.normal),
                                ),
                              ),
                      ),
                    ),
                    Row(
                      children: [
                        providerSearchHospitalizacion
                                .btnSearchHospitalizacioinesPaginacion
                            ? IconButton(
                                splashRadius: size.iScreen(3.0),
                                icon: Icon(
                                  Icons.search,
                                  size: size.iScreen(3.5),
                                  // color: Colors.white,
                                ),
                                onPressed: () {
                                  //=====================//
                                  if (providerSearchHospitalizacion
                                          .nameSearchHospitalizacionPaginacion
                                          .length >=
                                      3) {
                                    providerSearchHospitalizacion
                                        .setErrorHospitalizacioinesPaginacion(
                                            null);

                                    providerSearchHospitalizacion
                                        .setError401HospitalizacioinesPaginacion(
                                            false);
                                    providerSearchHospitalizacion.setPage(0);
                                    providerSearchHospitalizacion
                                        .setCantidad(25);

                                    providerSearchHospitalizacion
                                        .buscaAllHospitalizacioinesPaginacion(
                                            // '0803395581');
                                            ' ${providerSearchHospitalizacion.nameSearchHospitalizacionPaginacion}',
                                            true);
                                  } else {
                                    print('NO HAACE NADA');
                                  }
                                })
                            : Container(),
                        IconButton(
                            splashRadius: 2.0,
                            icon: (!providerSearchHospitalizacion
                                    .btnSearchHospitalizacioinesPaginacion)
                                ? Icon(
                                    Icons.search,
                                    size: size.iScreen(3.5),
                                    // color: Colors.white,
                                  )
                                : Icon(
                                    Icons.clear,
                                    size: size.iScreen(3.5),
                                    // color: Colors.white,
                                  ),
                            onPressed: () {
                              providerSearchHospitalizacion
                                  .onSearchTextHospitalizacionPaginacion("");
                              _textSearchController.text = '';

                              providerSearchHospitalizacion
                                  .setBtnSearchHospitalizacionPaginacion(
                                      !providerSearchHospitalizacion
                                          .btnSearchHospitalizacioinesPaginacion);

                              if (providerSearchHospitalizacion
                                      .btnSearchHospitalizacioinesPaginacion ==
                                  false) {
                                //=====================//
                                providerSearchHospitalizacion
                                    .setErrorHospitalizacioinesPaginacion(null);

                                providerSearchHospitalizacion
                                    .setError401HospitalizacioinesPaginacion(
                                        false);

                                providerSearchHospitalizacion.setPage(0);
                                providerSearchHospitalizacion.setCantidad(25);
                                providerSearchHospitalizacion
                                    .buscaAllHospitalizacioinesPaginacion(
                                        '', true);
                                // } //=====================//

                              }
                            }),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
          body: Container(
            color: Colors.grey.shade100,
            width: size.wScreen(100.0),
            height: size.hScreen(100.0),
            padding: EdgeInsets.only(
              top: size.iScreen(0.0),
              right: size.iScreen(0.0),
              left: size.iScreen(0.0),
            ),
            child: Consumer<HospitalizacionController>(
                        builder: (_, providersHospitalizaciones, __) {
                          if (providersHospitalizaciones
                                      .getErrorHospitalizacioinesPaginacion ==
                                  null &&
                              providersHospitalizaciones
                                      .getError401HospitalizacioinesPaginacion ==
                                  false) {
                            return Center(
                              // child: CircularProgressIndicator(),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Cargando Datos...',
                                    style: GoogleFonts.lexendDeca(
                                        fontSize: size.iScreen(1.5),
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  //***********************************************/
                                  SizedBox(
                                    height: size.iScreen(1.0),
                                  ),
                                  //*****************************************/
                                  const CircularProgressIndicator(),
                                ],
                              ),
                            );
                          } else if (providersHospitalizaciones
                                  .getErrorHospitalizacioinesPaginacion ==
                              false) {
                            return const NoData(
                              label: 'No existen datos para mostar',
                            );
                            // Text("Error al cargar los datos");
                          } else if (providersHospitalizaciones
                                  .getListaHospitalizacioinesPaginacion
                                  .isEmpty &&
                              providersHospitalizaciones
                                      .getError401HospitalizacioinesPaginacion ==
                                  true) {
                            return const NoData(
                              label:
                                  'Su sesión ha expirado, vuelva a iniciar sesión',
                            );
                          } else if (providersHospitalizaciones
                                  .getListaHospitalizacioinesPaginacion
                                  .isEmpty &&
                              providersHospitalizaciones
                                      .getError401HospitalizacioinesPaginacion ==
                                  false) {
                            return const NoData(
                              label: 'No existen datos para mostar',
                            );
                          }
                          // print('esta es la lista*******************: ${providersHospitalizaciones.getListaPropietarios.length}');

                          return RefreshIndicator(
                            onRefresh: () => onRefresh(),
                            child: ListView.builder(
                              controller: _scrollController,
                              physics: const BouncingScrollPhysics(),
                              itemCount: providersHospitalizaciones
                                      .getListaHospitalizacioinesPaginacion
                                      .length +
                                  1,
                              itemBuilder: (BuildContext context, int index) {
                                if (index <
                                    providersHospitalizaciones
                                        .getListaHospitalizacioinesPaginacion
                                        .length) {
                                  final hospitalizacion = providersHospitalizaciones
                                          .getListaHospitalizacioinesPaginacion[
                                      index];
                                  return Slidable(
                                    startActionPane: ActionPane(
                                      // A motion is a widget used to control how the pane animates.
                                      motion: const ScrollMotion(),

                                      children: [
                                      

                                        SlidableAction(
                                               backgroundColor: themeColor.getTerciaryTextColor!,
                                          foregroundColor: Colors.white,
                                          icon: Icons.list_alt_outlined,
                                          label: 'Más acciones',
                                          onPressed: (context) {
                                            showCupertinoModalPopup(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  CupertinoActionSheet(
                                                      title: Text(
                                                        'Acciones',
                                                        style: GoogleFonts
                                                            .lexendDeca(
                                                                fontSize: size
                                                                    .iScreen(
                                                                        2.0),
                                                                color:
                                                                    primaryColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                      ),
                                                      // message: const Text('Your options are '),
                                                      actions: <Widget>[
                                                        CupertinoActionSheetAction(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Container(
                                                                margin: EdgeInsets.only(
                                                                    right: size
                                                                        .iScreen(
                                                                            2.0)),
                                                                child: Text(
                                                                  'Ver Detalle',
                                                                  style: GoogleFonts.lexendDeca(
                                                                      fontSize:
                                                                          size.iScreen(
                                                                              1.8),
                                                                      color: Colors
                                                                          .black87,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal),
                                                                ),
                                                              ),
                                                              const Icon(Icons
                                                                  .info_outline_rounded)
                                                              //    const Icon(
                                                              //     FontAwesomeIcons.infoCircle,
                                                              // //  color: Colors.red,
                                                              //   )
                                                            ],
                                                          ),
                                                          onPressed: () {
                                                            providersHospitalizaciones
                                                                .resetFormospitalizacion();
                                                            providersHospitalizaciones
                                                                .getInfoHospitalizacion(
                                                                    hospitalizacion);
                                                            Navigator.pop(
                                                                context);
                                                            Navigator.of(
                                                                    context)
                                                                .push(MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            const DetalleHospitalizacion()));
                                                          },
                                                        ),
                                                        CupertinoActionSheetAction(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Container(
                                                                margin: EdgeInsets.only(
                                                                    right: size
                                                                        .iScreen(
                                                                            2.0)),
                                                                child: Text(
                                                                  'Editar',
                                                                  style: GoogleFonts.lexendDeca(
                                                                      fontSize:
                                                                          size.iScreen(
                                                                              1.8),
                                                                      color: Colors
                                                                          .black87,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal),
                                                                ),
                                                              ),
                                                              const Icon(
                                                                  Icons.edit)
                                                              //    const Icon(
                                                              //     FontAwesomeIcons.edit,
                                                              // //  color: Colors.red,
                                                              //   )
                                                            ],
                                                          ),
                                                          onPressed: () {
                                                            providersHospitalizaciones
                                                                .resetFormospitalizacion();
                                                            providersHospitalizaciones
                                                                .getIdHospitalizacion(
                                                                    hospitalizacion[
                                                                        'hospId']);
                                                            providersHospitalizaciones
                                                                .getInfoHospitalizacion(
                                                                    hospitalizacion);
                                                            Navigator.pop(
                                                                context);

                                                            // Navigator.pushNamed(
                                                            //     context,
                                                            //     'crearHospitalizacion',
                                                            //     arguments: 'EDIT');

                                                            Navigator.of(
                                                                    context)
                                                                .push(
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            const CrearHospitalizacion(
                                                                              tipo: 'EDIT',
                                                                            )))
                                                                .then((value) =>
                                                                    onRefresh());
                                                          },
                                                        ),
                                                        CupertinoActionSheetAction(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Container(
                                                                margin: EdgeInsets.only(
                                                                    right: size
                                                                        .iScreen(
                                                                            2.0)),
                                                                child: Text(
                                                                  'Ver PDF',
                                                                  style: GoogleFonts.lexendDeca(
                                                                      fontSize:
                                                                          size.iScreen(
                                                                              1.8),
                                                                      color: Colors
                                                                          .black87,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal),
                                                                ),
                                                              ),
                                                              const Icon(
                                                                FontAwesomeIcons
                                                                    .filePdf,
                                                                color:
                                                                    Colors.red,
                                                              )
                                                            ],
                                                          ),
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);

                                                            // Navigator.push(
                                                            //   context,
                                                            //   MaterialPageRoute(
                                                            //       builder:
                                                            //           (context) =>
                                                            //               ViewsPDFs(
                                                            //                 infoPdf:
                                                            //                     // '${valueFiles.getFotoServer}'
                                                            //                     'https://sysvet.neitor.com/reportes/carnet.php?id=${mascota['mascId']}&empresa=${_usuario!.rucempresa}',
                                                            //               )),
                                                            // );
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) => ViewsPDFs(
                                                                      infoPdf:
                                                                          'https://sysvet.neitor.com/reportes/carnet.php?id=${hospitalizacion['hospId']}&empresa=${_usuario!.rucempresa}',
                                                                      labelPdf:
                                                                          'infoHospitalización.pdf')),
                                                            );

                                                            // openFile(
                                                            //     url:
                                                            //         'https://sysvet.neitor.com/reportes/carnet.php?id=${hospitalizacion['hospId']}&empresa=${_usuario!.rucempresa}',
                                                            //     fileName:
                                                            //         'infoHospitalización.pdf');
                                                          },
                                                        ),
                                                      ],
                                                      cancelButton:
                                                          CupertinoActionSheetAction(
                                                        child: Text('Cancel',
                                                            style: GoogleFonts.lexendDeca(
                                                                fontSize: size
                                                                    .iScreen(
                                                                        2.0),
                                                                color:
                                                                    Colors.red,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal)),
                                                        isDefaultAction: true,
                                                        onPressed: () {
                                                          Navigator.pop(context,
                                                              'Cancel');
                                                        },
                                                      )),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                    endActionPane: ActionPane(
                                        motion: const ScrollMotion(),
                                        children: [
                                          SlidableAction(
                                            onPressed: (context) async {
                                              _showAlertDialog(
                                                  providersHospitalizaciones,
                                                  hospitalizacion['hospId']);
                                            },
                                            backgroundColor: errorColor,
                                            foregroundColor: Colors.white,
                                            icon: Icons.delete,
                                            label: 'Eliminar',
                                          ),
                                        ]),
                                    child: Card(
                                      elevation: 5,
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            bottom: size.iScreen(0.0)),
                                        color: index % 2 == 0
                                            ? Colors.grey.shade50
                                            : Colors.grey.shade200,
                                        child: ListTile(
                                          dense: true,
                                          visualDensity:
                                              VisualDensity.comfortable,
                                          leading: CircleAvatar(
                                            child: Text(
                                              '${hospitalizacion['hospMascNombre'].substring(0, 1)}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1,
                                            ),
                                            backgroundColor: Colors.grey[300],
                                          ),
                                          title: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: size.wScreen(30.0),

                                                // padding:
                                                //     EdgeInsets.symmetric(
                                                //         horizontal: size
                                                //             .iScreen(1.0),
                                                //         vertical:
                                                //             size.iScreen(
                                                //                 0.2)),
                                                child: Text(
                                                  '${hospitalizacion['hospMascNombre']}',
                                                  style: GoogleFonts.lexendDeca(
                                                      // fontSize: size.iScreen(2.45),
                                                      // color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Container(
                                                // width:
                                                // size.wScreen(100.0),
                                                // color: Colors.red,
                                                // padding:
                                                //     EdgeInsets.symmetric(
                                                //         horizontal: size
                                                //             .iScreen(1.0),
                                                //         vertical:
                                                //             size.iScreen(
                                                //                 0.2)),
                                                child: Container(
                                                  // color: Colors.green,
                                                  // width:
                                                  // size.wScreen(100.0),
                                                  child: Text(
                                                    'Peso: ${hospitalizacion['hospMascPeso']} Kg',
                                                    style:
                                                        GoogleFonts.lexendDeca(
                                                            fontSize: size
                                                                .iScreen(1.5),
                                                            color: Colors.grey,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          subtitle: Column(
                                            children: [
                                              Container(
                                                child: Container(
                                                  // color: Colors.green,
                                                  width: size.wScreen(100.0),
                                                  child: Text(
                                                    '${hospitalizacion['hospPerNombreDoc']}',
                                                    style:
                                                        GoogleFonts.lexendDeca(
                                                            // fontSize: size.iScreen(2.45),
                                                            color: Colors.grey,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                // color: Colors.green,
                                                width: size.wScreen(100.0),
                                                child: Text(
                                                  hospitalizacion[
                                                              'hospFecReg'] !=
                                                          ''
                                                      ? '${hospitalizacion['hospFecReg'].replaceAll('T', "  ").replaceAll('.000Z', "  ")}'
                                                      : '--- --- ---',
                                                  style: GoogleFonts.lexendDeca(
                                                      // fontSize: size.iScreen(2.45),
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                              ),
                                            ],
                                          ),
                                          // trailing: Icon(Icons.more_vert),
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return Consumer<HospitalizacionController>(
                                    builder: (_, valueNext, __) {
                                      return valueNext.getpage == null
                                          ? Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: size.iScreen(2.0)),
                                              child: Center(
                                                child: Text(
                                                  'No existen más datos',
                                                  style: GoogleFonts.lexendDeca(
                                                      fontSize:
                                                          size.iScreen(1.8),
                                                      // color: primaryColor,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                              ))
                                          : providersHospitalizaciones
                                                      .getListaHospitalizacioinesPaginacion
                                                      .length >
                                                  25
                                              ? Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical:
                                                          size.iScreen(2.0)),
                                                  child: const Center(
                                                      child:
                                                          CircularProgressIndicator()))
                                              : Container();
                                    },
                                  );
                                }
                              },
                            ),
                          );
                        },
                      )
               
          ),
          floatingActionButton:
              Consumer<SocketService>(builder: (_, valueConexion, __) {
            return valueConexion.serverStatus == ServerStatus.Online
                ? FloatingActionButton(
                    child: const Icon(
                      Icons.add,
                      // color: Colors.white,
                    ),
                    onPressed: () {
                      context
                          .read<HospitalizacionController>()
                          .resetFormospitalizacion();

                      // Navigator.pushNamed(context, 'crearHospitalizacion',
                      //     arguments: 'CREATE');

                      Navigator.of(context)
                          .push(MaterialPageRoute(
                              builder: (context) => const CrearHospitalizacion(
                                    tipo: 'CREATE',
                                  )))
                          .then((value) => onRefresh());
                    })
                : Container();
          }),
        ),
      ),
    );
  }

  // ===================================//

  void _showAlertDialog(HospitalizacionController _controller, int _id) {
    showDialog(
        context: context,
        builder: (buildcontext) {
          return CupertinoAlertDialog(
            title: Text("¿ Eliminar Registro ?",
                style: GoogleFonts.lexendDeca(
                  // fontSize: size.iScreen(2.0),
                  fontWeight: FontWeight.normal,
                  // color: primaryColor,
                )),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    _controller.eliminaHospitalizacion(buildcontext, _id);
                    Navigator.pop(context);
                    onRefresh();
                  },
                  child: Text(
                    'Aceptar',
                    style: GoogleFonts.lexendDeca(
                        // fontSize: size.iScreen(2.0),
                        fontWeight: FontWeight.normal,
                        color: errorColor),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancelar ',
                    style: GoogleFonts.lexendDeca(
                        // fontSize: size.iScreen(2.0),
                        fontWeight: FontWeight.normal,
                        color: alertColor),
                  ),
                ),
              ],
            ),
          );

// ===================================//
        });
  }

//========================================//

  Future openFile({required String url, String? fileName}) async {
    final name = fileName ?? url.split('/').last;
    // final file=await   pickFile();
    final file = await downloadFile(url, name);
    if (file == null) return;

//  print('Phat====>: ${file.path}');
    OpenFile.open(file.path);
  }

//========================================//
  Future<File?> downloadFile(String url, String name) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final file = File('${appStorage.path}/$name');

//  print('Phat====>: ${file.path}');
//  final nameFile='$file'.split('/').last;
//  print('nameFile====>: $nameFile');

    try {
      final response = await Dio().get(url,
          options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            receiveTimeout: 0,
          ));
      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
      return file;
    } catch (e) {
      return null;
    }
  }

  Future<File?> pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return null;
    return File(result.files.first.path!);
  }

  Future<void> onRefresh() async {
    final _controller =
        Provider.of<HospitalizacionController>(context, listen: false);
    _controller.setPage(0);
    _controller.setCantidad(25);
    _controller.buscaAllHospitalizacioinesPaginacion('', true);
  }

//========================================//
}

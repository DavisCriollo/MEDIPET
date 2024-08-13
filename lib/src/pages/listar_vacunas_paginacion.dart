import 'dart:io';
import 'dart:ui';

import 'package:awesome_icons/awesome_icons.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neitorcont/src/api/authentication_client.dart';
// import 'package:neitorcont/src/controllers/historia_clinica.controller.dart';
import 'package:neitorcont/src/controllers/vacunas_controller.dart';
import 'package:neitorcont/src/models/sesison_model.dart';
import 'package:neitorcont/src/pages/crear_vacunas.dart';
import 'package:neitorcont/src/pages/detalle_vacuna.dart';
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

class ListaVacunasPaginacion extends StatefulWidget {
  const ListaVacunasPaginacion({Key? key}) : super(key: key);

  @override
  State<ListaVacunasPaginacion> createState() => _ListaVacunasPaginacionState();
}

class _ListaVacunasPaginacionState extends State<ListaVacunasPaginacion> {
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

        final _next = context.read<VacunasController>();
        if (_next.getpage != null) {
          _next.setPage(_next.getpage);
          //       providerSearchPropietario.setCantidad(25);
          _next.buscaAllVacunasPaginacion('', false);
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
    final loadInfo = context.read<VacunasController>();
    // // Provider.of<PropietariosController>(context, listen: false);
    // await loadInfo.buscaAllVacunas('');
// await loadInfo.buscaRecomendaciones();
    // final serviceSocket = Provider.of<SocketService>(context, listen: false);
    final serviceSocket = context.read<SocketService>();
    serviceSocket.socket!.on('server:guardadoExitoso', (data) async {
      if (data['tabla'] == 'carnetvacuna') {
        loadInfo.buscaAllVacunasPaginacion('', false);
        // NotificatiosnService.showSnackBarSuccsses(data['msg']);
      }
    });
    serviceSocket.socket!.on('server:actualizadoExitoso', (data) async {
      if (data['tabla'] == 'carnetvacuna') {
        loadInfo.buscaAllVacunasPaginacion('', false);
        // NotificatiosnService.showSnackBarSuccsses(data['msg']);
      }
    });
    serviceSocket.socket!.on('server:eliminadoExitoso', (data) async {
      if (data['tabla'] == 'carnetvacuna') {
        loadInfo.buscaAllVacunasPaginacion('', false);
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
          title: Consumer<VacunasController>(
            builder: (_, providerSearchVacunas, __) {
              return Row(
                children: [
                  Expanded(
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: size.iScreen(0.1)),
                      child: (providerSearchVacunas.btnSearchVacunPaginacion)
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
                                          providerSearchVacunas
                                              .onSearchTextVacunaPaginacion(
                                                  text);

                                          if (providerSearchVacunas
                                              .nameSearchVacunaPaginacion
                                              .isEmpty) {
                                            //                 providerSearchVacunas
                                            //     .setErrorMascotasPaginacion(null);

                                            // providerSearchVacunas
                                            //     .setError401MascotasPaginacion(
                                            //         false);
                                            providerSearchVacunas.setPage(0);
                                            providerSearchVacunas
                                                .setCantidad(25);
                                            // providerSearchVacunas.setIsNext(false);
                                            providerSearchVacunas
                                                .buscaAllVacunasPaginacion(
                                                    '', true);

                                            //   providerSearchVacunas
                                            //       .setBtnSearchPropietarioPaginacion(
                                            //           !providerSearchVacunas
                                            //               .btnSearchPropietarioPaginacion);
                                            //   _textSearchController.text = "";
                                            //   providerSearchVacunas
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
                                          //   // providerSearchVacunas
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
                                'Vacunas',
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
                      providerSearchVacunas.btnSearchVacunPaginacion
                          ? IconButton(
                              splashRadius: size.iScreen(3.0),
                              icon: Icon(
                                Icons.search,
                                size: size.iScreen(3.5),
                                // color: Colors.white,
                              ),
                              onPressed: () {
                                //=====================//
                                if (providerSearchVacunas
                                        .nameSearchVacunaPaginacion.length >=
                                    3) {
                                  providerSearchVacunas
                                      .setErrorVacunasPaginacion(null);

                                  providerSearchVacunas
                                      .setError401VacunasPaginacion(false);
                                  providerSearchVacunas.setPage(0);
                                  providerSearchVacunas.setCantidad(25);

                                  providerSearchVacunas.buscaAllVacunasPaginacion(
                                      // '0803395581');
                                      ' ${providerSearchVacunas.nameSearchVacunaPaginacion}',
                                      true);
                                } else {
                                  print('NO HAACE NADA');
                                }
                              })
                          : Container(),
                      IconButton(
                          splashRadius: 2.0,
                          icon:
                              (!providerSearchVacunas.btnSearchVacunPaginacion)
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
                            providerSearchVacunas
                                .onSearchTextVacunaPaginacion("");
                            _textSearchController.text = '';

                            providerSearchVacunas.setBtnSearchVacunaPaginacion(
                                !providerSearchVacunas
                                    .btnSearchVacunPaginacion);

                            if (providerSearchVacunas
                                    .btnSearchVacunPaginacion ==
                                false) {
                              //=====================//
                              providerSearchVacunas
                                  .setErrorVacunasPaginacion(null);

                              providerSearchVacunas
                                  .setError401VacunasPaginacion(false);

                              providerSearchVacunas.setPage(0);
                              providerSearchVacunas.setCantidad(25);
                              providerSearchVacunas.buscaAllVacunasPaginacion(
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
          child:  Consumer<VacunasController>(
                      builder: (_, providersVacunas, __) {
                        if (providersVacunas.getErrorVacunasPaginacion ==
                                null &&
                            providersVacunas.getError401VacunasPaginacion ==
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
                        } else if (providersVacunas.getErrorVacunasPaginacion ==
                            false) {
                          return const NoData(
                            label: 'No existen datos para mostar',
                          );
                          // Text("Error al cargar los datos");
                        }
                        // else if (providersVacunas.getListaVacunas.isEmpty) {
                        //   return const NoData(
                        //     label: 'No existen datos para mostar',
                        //   );
                        // }

                        else if (providersVacunas
                                .getListaVacunasPaginacion.isEmpty &&
                            providersVacunas.getError401VacunasPaginacion ==
                                true) {
                          return const NoData(
                            label:
                                'Su sesión ha expirado, vuelva a iniciar sesión',
                          );
                        } else if (providersVacunas
                                .getListaVacunasPaginacion.isEmpty &&
                            providersVacunas.getError401VacunasPaginacion ==
                                false) {
                          return const NoData(
                            label: 'No existen datos para mostar',
                          );
                        }

                        // print('esta es la lista*******************: ${providersVacunas.getListaPropietarios.length}');

                        return RefreshIndicator(
                          onRefresh: () => onRefresh(),
                          child: ListView.builder(
                            controller: _scrollController,
                            physics: const BouncingScrollPhysics(),
                            itemCount: providersVacunas
                                    .getListaVacunasPaginacion.length +
                                1,
                            itemBuilder: (BuildContext context, int index) {
                              if (index <
                                  providersVacunas
                                      .getListaVacunasPaginacion.length) {
                                final vacuna = providersVacunas
                                    .getListaVacunasPaginacion[index];
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
                                                                  .iScreen(2.0),
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
                                                                    fontSize: size
                                                                        .iScreen(
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
                                                          // providersVacunas
                                                          //     .getInfoMascota(
                                                          //         vacuna);

                                                          // Navigator.of(context).push(
                                                          //     MaterialPageRoute(
                                                          //         builder:
                                                          //             (context) =>
                                                          //                 const DetalleVacuna()));
                                                          // providersVacunas
                                                          //     .setVacunaInfo(
                                                          //         vacuna);

                                                          // Navigator.pushNamed(
                                                          //     context,
                                                          //     'crearVacunas',
                                                          //     arguments: 'EDIT');
                                                          //  providersVacunas.setVacunaInfo(vacuna);
                                                          Navigator.pop(
                                                              context);
                                                          providersVacunas
                                                              .setVacunaInfo(
                                                                  vacuna);

                                                          Navigator.of(context).push(
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          const DetalleVacuna()));
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
                                                                    fontSize: size
                                                                        .iScreen(
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
                                                          // providersVacunas
                                                          //     .getInfoMascota(
                                                          //         vacuna);

                                                          // Navigator.pushNamed(
                                                          //     context,
                                                          //     'crearMascota',
                                                          //     arguments: 'EDIT');
                                                          providersVacunas
                                                              .setVacunaInfo(
                                                                  vacuna);
                                                          Navigator.pop(
                                                              context);

                                                          // Navigator.pushNamed(
                                                          //     context, 'crearVacunas',
                                                          //     arguments: 'EDIT');

                                                          Navigator.of(context)
                                                              .push(
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              const CrearVacunas(
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
                                                                    fontSize: size
                                                                        .iScreen(
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
                                                              color: Colors.red,
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
                                                                builder: (context) =>
                                                                    ViewsPDFs(
                                                                        infoPdf:
                                                                            'https://sysvet.neitor.com/reportes/carnet.php?id=${vacuna['carnMascId']}&empresa=${_usuario!.rucempresa}',
                                                                        labelPdf:
                                                                            'infoVacuna.pdf')),
                                                          );

                                                          // openFile(
                                                          //     url:
                                                          //         'https://sysvet.neitor.com/reportes/carnet.php?id=${vacuna['carnMascId']}&empresa=${_usuario!.rucempresa}',
                                                          //     fileName:
                                                          //         'infoVacuna.pdf');
                                                        },
                                                      ),
                                                    ],
                                                    cancelButton:
                                                        CupertinoActionSheetAction(
                                                      child: Text('Cancel',
                                                          style: GoogleFonts
                                                              .lexendDeca(
                                                                  fontSize: size
                                                                      .iScreen(
                                                                          2.0),
                                                                  color: Colors
                                                                      .red,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal)),
                                                      isDefaultAction: true,
                                                      onPressed: () {
                                                        Navigator.pop(
                                                            context, 'Cancel');
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
                                            _showAlertDialog(providersVacunas,
                                                vacuna['carnId']);
                                          },
                                          backgroundColor: errorColor,
                                          foregroundColor: Colors.white,
                                          icon: Icons.delete,
                                          label: 'Eliminar',
                                        ),
                                      ]),
                                  child: GestureDetector(
                                    onTap: () {
                                      // providersVacunas.setVacunaInfo(vacuna);

                                      // Navigator.of(context).push(MaterialPageRoute(
                                      //     builder: (context) =>
                                      //         const DetalleVacuna()));
                                    },
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
                                           '${vacuna['carnMascNombre'].substring(0, 1)}',
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
                                                  '${vacuna['carnMascNombre']}',
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
                                                    'Peso: ${vacuna['carnPeso']} Kg',
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
                                                    '${vacuna['carnPerNombreVet']}',
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
                                                  vacuna['carnFecReg'] != ''
                                                      ? '${vacuna['carnFecReg'].replaceAll('T', "  ").replaceAll('.000Z', "  ")}'
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
                                  ),
                                );
                              } else {
                                return Consumer<VacunasController>(
                                  builder: (_, valueNext, __) {
                                    return valueNext.getpage == null
                                        ? Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: size.iScreen(2.0)),
                                            child: Center(
                                              child: Text(
                                                'No existen más datos',
                                                style: GoogleFonts.lexendDeca(
                                                    fontSize: size.iScreen(1.8),
                                                    // color: primaryColor,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ))
                                        : providersVacunas
                                                    .getListaVacunasPaginacion
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

                                    //  Container(
                                    //     margin: EdgeInsets.symmetric(
                                    //         vertical: size.iScreen(2.0)),
                                    //     child: const Center(
                                    //         child:
                                    //             CircularProgressIndicator()));
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
                    context.read<VacunasController>().resetFormVacuna();

                    // Navigator.pushNamed(context, 'crearVacunas',
                    //     arguments: 'CREATE');
                    Navigator.of(context)
                        .push(MaterialPageRoute(
                            builder: (context) => const CrearVacunas(
                                  tipo: 'CREATE',
                                )))
                        .then((value) => onRefresh());
                  })
              : Container();
        }),
      ),
    );
  }
  // ===================================//

  void _showAlertDialog(VacunasController _controller, int _id) {
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
                    _controller.eliminaVacuna(buildcontext, _id);
                    Navigator.pop(context);
                    _controller.setPage(0);
                    _controller.setCantidad(25);
                    _controller.buscaAllVacunasPaginacion('', true);
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
    final _controller = Provider.of<VacunasController>(context, listen: false);
    _controller.setPage(0);
    _controller.setCantidad(25);
    _controller.buscaAllVacunasPaginacion('', true);
  }
//========================================//
//========================================//
}

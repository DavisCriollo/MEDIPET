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
import 'package:neitorcont/src/models/sesison_model.dart';
import 'package:neitorcont/src/pages/crear_historia_clinica.dart';
import 'package:neitorcont/src/pages/detalle_historia_clinica.dart';
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

class ListaHistoriaClinicaPaginacion extends StatefulWidget {
  const ListaHistoriaClinicaPaginacion({Key? key}) : super(key: key);

  @override
  State<ListaHistoriaClinicaPaginacion> createState() =>
      _ListaHistoriaClinicaPaginacionState();
}

class _ListaHistoriaClinicaPaginacionState
    extends State<ListaHistoriaClinicaPaginacion> {
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

        final _next = context.read<HistoriaClinicaController>();
        if (_next.getpage != null) {
          _next.setPage(_next.getpage);
          //       providerSearchPropietario.setCantidad(25);
          _next.buscaAllHistoriasPaginacion('', false);
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
    final loadInfo = context.read<HistoriaClinicaController>();

    // Provider.of<PropietariosController>(context, listen: false);
    // await loadInfo.buscaAllHistoriasPaginacion('',false);
// await loadInfo.buscaRecomendaciones();
    // final serviceSocket = Provider.of<SocketService>(context, listen: false);
    final serviceSocket = context.read<SocketService>();
    serviceSocket.socket!.on('server:guardadoExitoso', (data) async {
      if (data['tabla'] == 'historiaclinica') {
        loadInfo.buscaAllHistoriasPaginacion('', false);
        // NotificatiosnService.showSnackBarSuccsses(data['msg']);
      }
    });
    serviceSocket.socket!.on('server:actualizadoExitoso', (data) async {
      if (data['tabla'] == 'historiaclinica') {
        loadInfo.buscaAllHistoriasPaginacion('', false);
        // NotificatiosnService.showSnackBarSuccsses(data['msg']);
      }
    });
    serviceSocket.socket!.on('server:eliminadoExitoso', (data) async {
      if (data['tabla'] == 'historiaclinica') {
        loadInfo.buscaAllHistoriasPaginacion('', false);
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
          title: Consumer<HistoriaClinicaController>(
            builder: (_, providerSearchHistorias, __) {
              return Row(
                children: [
                  Expanded(
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: size.iScreen(0.1)),
                      child: (providerSearchHistorias
                              .btnSearchHistoriaPaginacion)
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
                                          providerSearchHistorias
                                              .onSearchTextHistoriaPaginacion(
                                                  text);

                                          if (providerSearchHistorias
                                              .nameSearchHistoriaPaginacion
                                              .isEmpty) {
                                            providerSearchHistorias.setPage(0);
                                            providerSearchHistorias
                                                .setCantidad(25);
                                            // providerSearchHistorias.setIsNext(false);
                                            providerSearchHistorias
                                                .buscaAllHistoriasPaginacion(
                                                    '', false);

                                            //   providerSearchHistorias
                                            //       .setBtnSearchHistoriaPaginacion(
                                            //           !providerSearchHistorias
                                            //               .btnSearchHistoriaPaginacion);
                                            //   _textSearchController.text = "";
                                            //   providerSearchHistorias
                                            //       .buscaAllHistoriasPaginacion(
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
                                          //   // providerSearchHistorias
                                          //       // .setInfoBusquedaHistoriasPaginacion([]);
                                          //       providerSearchHistorias.setPage(0);
                                          //       providerSearchHistorias.setCantidad(25);

                                          //   providerSearchHistorias
                                          //       .buscaAllHistoriasPaginacion(
                                          //           // '0803395581');
                                          //           ' ${providerSearchHistorias.nameSearchHistoriaPaginacion}',true);

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
                                'Historias',style:  Theme.of(context).textTheme.headline2,
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
                      providerSearchHistorias.btnSearchHistoriaPaginacion
                          ? IconButton(
                              splashRadius: size.iScreen(3.0),
                              icon: Icon(
                                Icons.search,
                                size: size.iScreen(3.5),
                                // color: Colors.white,
                              ),
                              onPressed: () {
                                //=====================//
                                if (providerSearchHistorias
                                        .nameSearchHistoriaPaginacion.length >=
                                    3) {
                                  providerSearchHistorias
                                      .setErrorHistoriasPaginacion(null);

                                  providerSearchHistorias
                                      .setError401HistoriasPaginacion(false);
                                  providerSearchHistorias.setPage(0);
                                  providerSearchHistorias.setCantidad(25);

                                  providerSearchHistorias
                                      .buscaAllHistoriasPaginacion(
                                          // '0803395581');
                                          ' ${providerSearchHistorias.nameSearchHistoriaPaginacion}',
                                          true);
                                } else {
                                  print('NO HAACE NADA');
                                }
                              })
                          : Container(),
                      IconButton(
                          splashRadius: 2.0,
                          icon: (!providerSearchHistorias
                                  .btnSearchHistoriaPaginacion)
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
                            providerSearchHistorias
                                .onSearchTextHistoriaPaginacion("");
                            _textSearchController.text = '';

                            providerSearchHistorias
                                .setBtnSearchHistoriaPaginacion(
                                    !providerSearchHistorias
                                        .btnSearchHistoriaPaginacion);

                            if (providerSearchHistorias
                                    .btnSearchHistoriaPaginacion ==
                                false) {
                              //=====================//
                              providerSearchHistorias
                                  .setErrorHistoriasPaginacion(null);

                              providerSearchHistorias
                                  .setError401HistoriasPaginacion(false);

                              providerSearchHistorias.setPage(0);
                              providerSearchHistorias.setCantidad(25);
                              providerSearchHistorias
                                  .buscaAllHistoriasPaginacion('', true);
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
          child:  Consumer<HistoriaClinicaController>(
                      builder: (_, providerHistorias, __) {
                        if (providerHistorias.getErrorHistoriasPaginacion ==
                                null &&
                            providerHistorias.getError401HistoriasPaginacion ==
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
                        } else if (providerHistorias
                                .getErrorHistoriasPaginacion ==
                            false) {
                          return const NoData(
                            label: 'No existen datos para mostar',
                          );
                          // Text("Error al cargar los datos");
                        }
                        // else if (providerHistorias
                        //     .getListaHistorias.isEmpty) {
                        //   return const NoData(
                        //     label: 'No existen datos para mostar',
                        //   );
                        // }

                        else if (providerHistorias
                                .getListaHistoriasPaginacion.isEmpty &&
                            providerHistorias.getError401HistoriasPaginacion ==
                                true) {
                          return const NoData(
                            label:
                                'Su sesión ha expirado, vuelva a iniciar sesión',
                          );
                        } else if (providerHistorias
                                .getListaHistoriasPaginacion.isEmpty &&
                            providerHistorias.getError401HistoriasPaginacion ==
                                false) {
                          return const NoData(
                            label: 'No existen datos para mostar',
                          );
                        }

                        // print('esta es la lista*******************: ${providerHistorias.getListaPropietarios.length}');

                        return RefreshIndicator(
                          onRefresh: () => onRefresh(),
                          child: ListView.builder(
                            controller: _scrollController,
                            physics: const BouncingScrollPhysics(),
                            itemCount: providerHistorias
                                    .getListaHistoriasPaginacion.length +
                                1,
                            itemBuilder: (BuildContext context, int index) {
                              if (index <
                                  providerHistorias
                                      .getListaHistoriasPaginacion.length) {
                                final historia = providerHistorias
                                    .getListaHistoriasPaginacion[index];
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
                                                          // Navigator.of(context).push(MaterialPageRoute(
                                                          //     builder: (context) =>
                                                          //         const DetalleHospitalizacion()));
                                                          providerHistorias
                                                              .setInfoHistoriaClinica(
                                                                  historia);

                                                          Navigator.of(context).push(
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          const DetalleHistoriaClinica()));
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
                                                          providerHistorias
                                                              .setInfoHistoriaClinica(
                                                                  historia);

                                                          // Navigator.pushNamed(
                                                          //     context,
                                                          //     'crearHistiriaClinica',
                                                          //     arguments: 'EDIT');

                                                          Navigator.pop(
                                                              context);
                                                          Navigator.of(context)
                                                              .push(
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              const CrearHistiriaClinica(
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

                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    ViewsPDFs(
                                                                        infoPdf:
                                                                            'https://sysvet.neitor.com/reportes/historiaIndividual.php?id=${historia['hcliId']}&empresa=${_usuario!.rucempresa}',
                                                                        labelPdf:
                                                                            'infoHistoria.pdf')),
                                                          );

                                                          // openFile(
                                                          //     url:
                                                          //         'https://sysvet.neitor.com/reportes/historiaIndividual.php?id=${historia['hcliId']}&empresa=${_usuario!.rucempresa}',
                                                          //     fileName:
                                                          //         'infoHistoria.pdf');
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
                                        // SlidableAction(
                                        //   onPressed: (context) async {
                                        //  context
                                        //       .read<HistoriaClinicaController>()
                                        //       .eliminaHistoriaCinica(
                                        //           context, historia['hcliId']);
                                        //   },
                                        //   backgroundColor: errorColor,
                                        //   foregroundColor: Colors.white,
                                        //   icon: Icons.delete_forever_outlined,

                                        //   // label: 'Eliminar',
                                        // ),
                                        SlidableAction(
                                          onPressed: (context) async {
                                            _showAlertDialog(providerHistorias,
                                                historia['hcliId']);
                                          },
                                          backgroundColor: errorColor,
                                          foregroundColor: Colors.white,
                                          icon: Icons.delete,
                                          label: 'Eliminar',
                                        ),
                                      ]),
                                  child:

                                     
                                      Card(
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
                                           '${historia['hcliMascNombre'].substring(0, 1)}',
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
                                                '${historia['hcliMascNombre']}',
                                                style: GoogleFonts.lexendDeca(
                                                    // fontSize: size.iScreen(2.45),
                                                    // color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.normal),
                                                overflow: TextOverflow.ellipsis,
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
                                                  'Peso: ${historia['hcliPeso']} Kg',
                                                  style: GoogleFonts.lexendDeca(
                                                      fontSize:
                                                          size.iScreen(1.5),
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.normal),
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
                                                  '${historia['hcliPerNombreVetInt']}',
                                                  style: GoogleFonts.lexendDeca(
                                                      // fontSize: size.iScreen(2.45),
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              // color: Colors.green,
                                              width: size.wScreen(100.0),
                                              child: Text(
                                                historia['hcliFecReg'] != ''
                                                    ? '${historia['hcliFecReg'].replaceAll('T', "  ").replaceAll('.000Z', "  ")}'
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
                                return Consumer<HistoriaClinicaController>(
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
                                        : providerHistorias
                                                    .getListaHistoriasPaginacion
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
                    final controller =
                        context.read<HistoriaClinicaController>();
                    // Navigator.of(context)
                    //     .push(MaterialPageRoute(
                    //         builder: (context) =>
                    //             CrearMascota(action: 'CREATE')));
                    controller.resetFormHistClinica();
                    controller.onInputFechaChange(
                        '${DateTime.now().year}-${(DateTime.now().month) < 10 ? '0${DateTime.now().month}' : '${DateTime.now().month}'}-${(DateTime.now().day) < 10 ? '0${DateTime.now().day}' : '${DateTime.now().day}'}');

                    // Navigator.pushNamed(context, 'crearHistiriaClinica',
                    //     arguments: 'CREATE');

                    Navigator.of(context)
                        .push(MaterialPageRoute(
                            builder: (context) => const CrearHistiriaClinica(
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

  void _showAlertDialog(HistoriaClinicaController _controller, int _id) {
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
                    final controll = context.read<HistoriaClinicaController>();
                    controll.eliminaHistoriaCinica(buildcontext, _id);
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
        Provider.of<HistoriaClinicaController>(context, listen: false);
    _controller.setPage(0);
    _controller.setCantidad(25);
    _controller.buscaAllHistoriasPaginacion('', true);
  }

//========================================//
}

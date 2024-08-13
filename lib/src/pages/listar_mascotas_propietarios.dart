import 'dart:io';

import 'package:awesome_icons/awesome_icons.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neitorcont/src/api/authentication_client.dart';
import 'package:neitorcont/src/controllers/mascotas_controller.dart';
import 'package:neitorcont/src/controllers/propietarios_controller.dart';
import 'package:neitorcont/src/models/sesison_model.dart';
import 'package:neitorcont/src/pages/crear_mascota.dart';
import 'package:neitorcont/src/pages/crear_propietario.dart';
import 'package:neitorcont/src/pages/detalle_mascota.dart';
import 'package:neitorcont/src/pages/detalle_propietario.dart';
import 'package:neitorcont/src/pages/views_pdf.dart';
import 'package:neitorcont/src/services/notifications_service.dart';
import 'package:neitorcont/src/services/socket_service.dart';
import 'package:neitorcont/src/utils/responsive.dart';
import 'package:neitorcont/src/utils/theme.dart';
import 'package:neitorcont/src/widgets/no_data.dart';
// import 'package:open_file/open_file.dart';
import 'package:open_file_safe/open_file_safe.dart';
import 'package:path_provider/path_provider.dart';

import 'package:provider/provider.dart';

class ListaMascotasPropietario extends StatefulWidget {
  final dynamic propietario;
  const ListaMascotasPropietario({Key? key, required this.propietario})
      : super(key: key);

  @override
  State<ListaMascotasPropietario> createState() =>
      _ListaMascotasPropietarioState();
}

class _ListaMascotasPropietarioState extends State<ListaMascotasPropietario> {
  final TextEditingController _textSearchController = TextEditingController();
  // final serviceSocket = SocketService();
  // final propietarioContrtoller = SocketService();
  // final loadInfo =PropietariosController();
  // Provider.of<PropietariosController>(context, listen: false);
  Session? _usuario;

  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  void dispose() {
    _textSearchController.clear();
    super.dispose();
  }

  void initData() async {
    _usuario = await Auth.instance.getSession();

    // print('informacion usuario=====> :${_usuario!.nomComercial}');
    final loadInfo = context.read<MascotasController>();
    // Provider.of<PropietariosController>(context, listen: false);
    await loadInfo.buscaAllMascotasPropietario(
        '', widget.propietario['perDocNumero']);
// await loadInfo.buscaRecomendaciones();
    // final serviceSocket = Provider.of<SocketService>(context, listen: false);
    final serviceSocket = context.read<SocketService>();
    serviceSocket.socket!.on('server:guardadoExitoso', (data) async {
      if (data['tabla'] == 'mascota') {
        loadInfo.buscaAllMascotasPropietario(
            '', widget.propietario['perDocNumero']);
        // NotificatiosnService.showSnackBarSuccsses(data['msg']);
      }
    });
    serviceSocket.socket!.on('server:actualizadoExitoso', (data) async {
      if (data['tabla'] == 'mascota') {
        loadInfo.buscaAllMascotasPropietario(
            '', widget.propietario['perDocNumero']);
        // NotificatiosnService.showSnackBarSuccsses(data['msg']);
      }
    });
    serviceSocket.socket!.on('server:eliminadoExitoso', (data) async {
      if (data['tabla'] == 'mascota') {
        loadInfo.buscaAllMascotasPropietario(
            '', widget.propietario['perDocNumero']);
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

    // print('informacion usuario=====> :$_usuario');
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Colors.grey.shade100,
          appBar: AppBar(
            // backgroundColor: primaryColor,
            title: Text(
              'Mis Mascotas',style:  Theme.of(context).textTheme.headline2,
              // style: GoogleFonts.lexendDeca(
              //     fontSize: size.iScreen(2.45),
              //     color: Colors.white,
              //     fontWeight: FontWeight.normal),
            ),
          ),
          //   title: Consumer<MascotasController>(
          //     builder: (_, providerSearchMascotas, __) {
          //       return Row(
          //         children: [
          //           Expanded(
          //             child: Container(
          //               margin:
          //                   EdgeInsets.symmetric(horizontal: size.iScreen(0.1)),
          //               child: (providerSearchMascotas.btnSearchMascotaPropietario)
          //                   ? ClipRRect(
          //                       borderRadius: BorderRadius.circular(5.0),
          //                       child: Row(
          //                         children: [
          //                           Expanded(
          //                             child: Container(
          //                               // margin: EdgeInsets.symmetric(
          //                               //     horizontal: size.iScreen(0.0)),
          //                               padding: EdgeInsets.symmetric(
          //                                   horizontal: size.iScreen(1.5)),
          //                               color: Colors.white,
          //                               height: size.iScreen(4.0),
          //                               child: TextField(
          //                                 controller: _textSearchController,
          //                                 autofocus: true,
          //                                 onChanged: (text) {
          //                                   providerSearchMascotas
          //                                       .onSearchTextMascotaPropietario(text);

          //                                   if (providerSearchMascotas
          //                                       .nameSearchMascotaPropietario.isEmpty) {
          //                                     providerSearchMascotas
          //                                         .buscaAllMascotasPropietario('',widget.propietario['perDocNumero']);
          //                                   }

          //                                   // setState(() {});
          //                                 },
          //                                 decoration: const InputDecoration(
          //                                   border: InputBorder.none,
          //                                   hintText: 'Buscar...',
          //                                   icon: Icon(Icons.search),
          //                                 ),
          //                               ),
          //                             ),
          //                           ),
          //                         ],
          //                       ),
          //                     )
          //                   : Container(
          //                       alignment: Alignment.center,
          //                       width: size.wScreen(90.0),
          //                       child: Text(
          //                         'Mis Mascotas',
          //                         style: GoogleFonts.lexendDeca(
          //                             fontSize: size.iScreen(2.45),
          //                             color: Colors.white,
          //                             fontWeight: FontWeight.normal),
          //                       ),
          //                     ),
          //             ),
          //           ),
          //           IconButton(
          //               splashRadius: 2.0,
          //               icon: (!providerSearchMascotas.btnSearchMascotaPropietario)
          //                   ? Icon(
          //                       Icons.search,
          //                       size: size.iScreen(3.5),
          //                       color: Colors.white,
          //                     )
          //                   : Icon(
          //                       Icons.clear,
          //                       size: size.iScreen(3.5),
          //                       color: Colors.white,
          //                     ),
          //               onPressed: () {
          //                 providerSearchMascotas.setBtnSearchMascotaPropietario(
          //                     !providerSearchMascotas.btnSearchMascotaPropietario);
          //                 _textSearchController.text = "";
          //                 providerSearchMascotas.buscaAllMascotasPropietario('',widget.propietario['perDocNumero']);
          //               }),
          //         ],
          //       );
          //     },
          //   ),
          // ),
          body: Container(
            // color: Colors.grey.shade100,
            color: Colors.white,
            width: size.wScreen(100.0),
            height: size.hScreen(100.0),
            padding: EdgeInsets.only(
              top: size.iScreen(0.0),
              right: size.iScreen(0.0),
              left: size.iScreen(0.0),
            ),
            child:  Consumer<MascotasController>(
                        builder: (_, providerMascota, __) {
                          if (providerMascota.getError401MascotasPropietario ==
                                  null &&
                              providerMascota.getError401MascotasPropietario ==
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
                          } else if (providerMascota
                                  .getErrorMascotasPripietario ==
                              false) {
                            return const NoData(
                              label: 'No existen datos para mostar',
                            );
                            // Text("Error al cargar los datos");
                          } else if (providerMascota
                                  .getListaMascotasPropietario.isEmpty &&
                              providerMascota.getError401MascotasPropietario ==
                                  true) {
                            return const NoData(
                              label:
                                  'Su sesión ha expirado, vuelva a iniciar sesión',
                            );
                          } else if (providerMascota
                                  .getListaMascotasPropietario.isEmpty &&
                              providerMascota.getError401MascotasPropietario ==
                                  false) {
                            return const NoData(
                              label: 'No existen datos para mostar',
                            );
                          }
                          // print('esta es la lista*******************: ${providerMascota.getListaPropietarios.length}');

                          return ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: providerMascota
                                .getListaMascotasPropietario.length,
                            itemBuilder: (BuildContext context, int index) {
                              final mascota = providerMascota
                                  .getListaMascotasPropietario[index];
                              return Slidable(
                                startActionPane: ActionPane(
                                  // A motion is a widget used to control how the pane animates.
                                  motion: const ScrollMotion(),

                                  children: [
                                    SlidableAction(
                                      backgroundColor: tercearyColor,
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
                                                    style:
                                                        GoogleFonts.lexendDeca(
                                                            fontSize: size
                                                                .iScreen(2.0),
                                                            color: primaryColor,
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
                                                            margin:
                                                                EdgeInsets.only(
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
                                                        providerMascota
                                                            .getInfoMascota(
                                                                mascota);
                                                        Navigator.pop(context);
                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        const DetalleMascotas()));
                                                      },
                                                    ),
                                                    // CupertinoActionSheetAction(
                                                    //   child: Row(
                                                    //     mainAxisAlignment:
                                                    //         MainAxisAlignment
                                                    //             .center,
                                                    //     children: [
                                                    //       Container(
                                                    //         margin:
                                                    //             EdgeInsets.only(
                                                    //                 right: size
                                                    //                     .iScreen(
                                                    //                         2.0)),
                                                    //         child: Text(
                                                    //           'Editar',
                                                    //           style: GoogleFonts.lexendDeca(
                                                    //               fontSize: size
                                                    //                   .iScreen(
                                                    //                       1.8),
                                                    //               color: Colors
                                                    //                   .black87,
                                                    //               fontWeight:
                                                    //                   FontWeight
                                                    //                       .normal),
                                                    //         ),
                                                    //       ),
                                                    //       const Icon(Icons.edit)
                                                    //       //    const Icon(
                                                    //       //     FontAwesomeIcons.edit,
                                                    //       // //  color: Colors.red,
                                                    //       //   )
                                                    //     ],
                                                    //   ),
                                                    //   onPressed: () {
                                                    //     providerMascota
                                                    //         .getInfoMascota(
                                                    //             mascota);

                                                    //     Navigator.pop(context);
                                                    //     Navigator.pushNamed(
                                                    //         context,
                                                    //         'crearMascota',
                                                    //         arguments: 'EDIT');
                                                    //   },
                                                    // ),
                                                    CupertinoActionSheetAction(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
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
                                                        Navigator.pop(context);

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
                                                                          "https://sysvet.neitor.com/reportes/carnet.php?id=${mascota['mascId']}&empresa=${_usuario!.rucempresa}",
                                                                      labelPdf:
                                                                          'infoMascota.pdf')),
                                                        );

                                                        // openFile(
                                                        //     url:
                                                        //         "https://sysvet.neitor.com/reportes/carnet.php?id=${mascota['mascId']}&empresa=${_usuario!.rucempresa}",
                                                        //     fileName:
                                                        //         'infoMascota.pdf');
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
                                                                color:
                                                                    Colors.red,
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
                                // endActionPane: ActionPane(
                                //     motion: const ScrollMotion(),
                                //     children: [
                                //       SlidableAction(
                                //         onPressed: (context) async {
                                //           _showAlertDialog(providerMascota,
                                //               mascota['mascId']);
                                //         },
                                //         backgroundColor: errorColor,
                                //         foregroundColor: Colors.white,
                                //         icon: Icons.delete,
                                //         label: 'Eliminar',
                                //       ),
                                //     ]),
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
                                      visualDensity: VisualDensity.comfortable,
                                      leading: mascota['mascFoto'] != ''
                                          ? CircleAvatar(
                                              radius: 20.0,
                                              backgroundImage: NetworkImage(
                                                  "${mascota['mascFoto']}"),
                                              backgroundColor:
                                                  Colors.transparent,
                                            )
                                          : const CircleAvatar(
                                              radius: 20.0,
                                              backgroundImage: AssetImage(
                                                  'assets/imgs/no-photo.png'),
                                              backgroundColor:
                                                  Colors.transparent,
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
                                              '${mascota['mascNombre']}',
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
                                            child: SizedBox(
                                              // color: Colors.green,
                                              width: size.wScreen(20.0),
                                              child: Text(
                                                '${mascota['mascRaza']}',
                                                style: GoogleFonts.lexendDeca(
                                                    fontSize: size.iScreen(1.5),
                                                    color: Colors.grey,
                                                    fontWeight:
                                                        FontWeight.normal),
                                                overflow: TextOverflow.ellipsis,
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
                                                '${mascota['mascEdad']}',
                                                style: GoogleFonts.lexendDeca(
                                                    // fontSize: size.iScreen(2.45),
                                                    color: Colors.grey,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            // color: Colors.green,
                                            width: size.wScreen(100.0),
                                            child: Text(
                                              mascota['mascFecReg'] != ''
                                                  ? '${mascota['mascFecReg'].replaceAll('T', "  ").replaceAll('.000Z', "  ")}'
                                                  : '--- --- ---',
                                              style: GoogleFonts.lexendDeca(
                                                  // fontSize: size.iScreen(2.45),
                                                  color: Colors.grey,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ),
                                          // Container(
                                          //   // color: Colors.green,
                                          //   width: size.wScreen(100.0),
                                          //   child: Text(
                                          //     mascota['mascFecReg'] != ''
                                          //         ? '${mascota['mascFecReg'].replaceAll('T', "  ").replaceAll('.000Z', "  ")}'
                                          //         : '--- --- ---',
                                          //     style: GoogleFonts.lexendDeca(
                                          //         // fontSize: size.iScreen(2.45),
                                          //         color: Colors.grey,
                                          //         fontWeight:
                                          //             FontWeight.normal),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                      // trailing: Icon(Icons.more_vert),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      )
                 
          ),
          // floatingActionButton:
          //     Consumer<SocketService>(builder: (_, valueConexion, __) {
          //   return valueConexion.serverStatus == ServerStatus.Online
          //       ? FloatingActionButton(
          //           child: const Icon(
          //             Icons.add,
          //             color: Colors.white,
          //           ),
          //           onPressed: () {
          //             context.read<MascotasController>().resetFormMascota();
          //             // Navigator.of(context)
          //             //     .push(MaterialPageRoute(
          //             //         builder: (context) =>
          //             //             CrearMascota(action: 'CREATE')));

          //             Navigator.pushNamed(context, 'crearMascota',
          //                 arguments: 'CREATE');
          //           })
          //       : Container();
          // }

          // ),
        ));
  }

// ===================================//
  void _modalBottomSheetMenu(Responsive size) {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        builder: (builder) {
          return Container(
              height: size.hScreen(100.0),
              color:
                  Colors.transparent, //could change this to Color(0xFF737373),
              //so you don't have to change MaterialApp canvasColor
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.iScreen(1.5),
                      vertical: size.iScreen(1.5)),
                  width: size.wScreen(100),
                  // color: Colors.red,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(size.iScreen(3.0)),
                          topRight: Radius.circular(size.iScreen(3.0)))),
                  child: Column(
                    children: [
                      Container(
                        // width: size.wScreen(30.0),

                        // color: Colors.blue,
                        child: Text('BUSCAR PERSONA ',
                            style: GoogleFonts.lexendDeca(
                                // fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.bold,
                                color: Colors.grey)),
                      ),
                      Consumer<PropietariosController>(
                        builder: (_, providerCedula, __) {
                          return Row(children: [
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: size.iScreen(1.5),
                                  vertical: size.iScreen(0.0)),
                              // color: Colors.blue,
                              width: size.wScreen(85.0),
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: size.iScreen(5.0),
                                    vertical: size.iScreen(0.0)),
                                width: size.wScreen(20.0),
                                child: TextFormField(
                                  // readOnly:
                                  //     widget.action == 'CREATE'
                                  //         ? false
                                  //         : true,
                                  // // controller: _textCedula,
                                  // initialValue:
                                  //     widget.action == 'CREATE'
                                  //         ? ''
                                  //         : controller.getDocumento,
                                  decoration: InputDecoration(
                                      // suffixIcon:
                                      //     providerCedula.getIsCedula == true
                                      //         ? const Icon(
                                      //             Icons.check_circle,
                                      //             color: alertColor,
                                      //           )
                                      //         : const Icon(
                                      //             Icons.error_outline,
                                      //             color: errorColor,
                                      //           )
                                      ),
                                  // keyboardType: TextInputType.number,
                                  // inputFormatters: <TextInputFormatter>[
                                  //   FilteringTextInputFormatter.allow(
                                  //       RegExp(r'[0-9]')),
                                  // ],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: size.iScreen(2.3),
                                    // fontWeight: FontWeight.bold,
                                    // letterSpacing: 2.0,
                                  ),
                                  onChanged: (text) {
                                    // providerCedula.setDocumento(text);

                                    providerCedula.onSearchTextPersona(text);

                                    if (providerCedula
                                        .nameSearchPersona.isEmpty) {
                                      providerCedula.searchAllPersinas('');
                                    }
                                  },
                                  validator: (text) {
                                    if (text!.trim().isNotEmpty) {
                                      return null;
                                    } else {
                                      return 'Ingrese Ruc/Ced/Pas';
                                    }
                                  },
                                ),
                              ),
                            ),
                          ]);
                        },
                      ),
                      //***********************************************/
                      SizedBox(
                        height: size.iScreen(1.0),
                      ),
                      //*****************************************/
                      Container(
                          width: size.wScreen(90.0),
                          height: size.hScreen(40.0),
                          child: Consumer<PropietariosController>(
                            builder: (_, providerPersonas, __) {
                              if (providerPersonas.getErrorBusquedaPersona ==
                                  null) {
                                return const NoData(
                                  label: 'No existen datos para mostar',
                                );
                              } else if (providerPersonas
                                      .getErrorBusquedaPersona ==
                                  false) {
                                return const NoData(
                                  label: 'No existen datos para mostar',
                                );
                                // Text("Error al cargar los datos");
                              } else if (providerPersonas
                                  .getListaBusquedaPersonas.isEmpty) {
                                return const NoData(
                                  label: 'Ingrese # de documento',
                                );
                                // Text("sin datos");
                              }
                              // print('esta es la lista*******************: ${providerPersonas.getListaPropietarios.length}');

                              return ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: providerPersonas
                                    .getListaBusquedaPersonas.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final persona = providerPersonas
                                      .getListaBusquedaPersonas[index];
                                  return GestureDetector(
                                    onTap: () {
                                      // providerPropietarios
                                      //     .getInfoPropietario(propietario);

                                      // Navigator.of(context).push(MaterialPageRoute(
                                      //     builder: (context) =>
                                      //         const DetallePropietarioPage()));

                                      //   Navigator.push(
                                      //       context,
                                      //       MaterialPageRoute(
                                      //           builder: ((context) =>
                                      //               const DetallePropietarioPage())));

                                      providerPersonas.getInfoPropietario(
                                          persona, false);

                                      Navigator.pop(context);
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) =>
                                                  const CrearPropietario(
                                                      action: 'SEARCH')))
                                          .then((value) => setState(() {
                                                providerPersonas
                                                    .buscaAllPropietarios('');
                                              }));

//                                             Navigator.pushNamed(context, 'crearPropietario').then((value) => setState(() {

// }));

                                      //  Navigator.of(context).push(MaterialPageRoute(
                                      // builder: (context) =>  CrearPropietario(action: 'EDIT')));
                                    },
                                    child: Card(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        margin: EdgeInsets.symmetric(
                                            vertical: size.iScreen(0.5),
                                            horizontal: size.iScreen(1.0)),
                                        elevation: 2,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal:
                                                          size.iScreen(0.0),
                                                      vertical:
                                                          size.iScreen(1.0)),
                                                  child: Column(
                                                    children: <Widget>[
                                                      Container(
                                                        width:
                                                            size.wScreen(100.0),
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: size
                                                                    .iScreen(
                                                                        1.0),
                                                                vertical: size
                                                                    .iScreen(
                                                                        0.2)),
                                                        child: Text(
                                                          '${persona['perNombre']}',
                                                          style: GoogleFonts
                                                              .lexendDeca(
                                                                  // fontSize: size.iScreen(2.45),
                                                                  // color: Colors.white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                        ),
                                                      ),
                                                      Container(
                                                        width:
                                                            size.wScreen(100.0),
                                                        // color: Colors.red,
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: size
                                                                    .iScreen(
                                                                        1.0),
                                                                vertical: size
                                                                    .iScreen(
                                                                        0.2)),
                                                        child: Container(
                                                          // color: Colors.green,
                                                          width: size
                                                              .wScreen(30.0),
                                                          child: Text(
                                                            '${persona['perDocNumero']}',
                                                            style: GoogleFonts
                                                                .lexendDeca(
                                                                    // fontSize: size.iScreen(2.45),
                                                                    color: Colors
                                                                        .grey,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Column(
                                                children: <Widget>[
                                                  Container(
                                                    // width: size.wScreen(100.0),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: size
                                                                .iScreen(1.0),
                                                            vertical: size
                                                                .iScreen(0.5)),
                                                    child: const Icon(
                                                      Icons.chevron_right,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )),
                                  );
                                },
                              );
                            },
                          )),
                    ],
                  ),
                ),
              ));
        });
  }
// ===================================//

  void _showAlertDialog(MascotasController _controller, int _id) {
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
                    _controller.eliminaMascota(buildcontext, _id);
                    Navigator.pop(context);
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

//========================================//

}

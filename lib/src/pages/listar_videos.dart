import 'dart:io';

import 'package:awesome_icons/awesome_icons.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neitorcont/src/api/authentication_client.dart';
import 'package:neitorcont/src/controllers/videos_controller.dart';
import 'package:neitorcont/src/models/sesison_model.dart';
import 'package:neitorcont/src/pages/view_video.dart';
import 'package:neitorcont/src/services/notifications_service.dart';
import 'package:neitorcont/src/services/socket_service.dart';
import 'package:neitorcont/src/utils/responsive.dart';
import 'package:neitorcont/src/utils/theme.dart';
import 'package:neitorcont/src/widgets/no_data.dart';
// import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ListaVideos extends StatefulWidget {
  const ListaVideos({Key? key}) : super(key: key);

  @override
  State<ListaVideos> createState() => _ListaVideosState();
}

class _ListaVideosState extends State<ListaVideos> {
  final TextEditingController _textSearchController = TextEditingController();

  Session? _usuario;

  @override
  void initState() {
    // initData();
    super.initState();
  }

  @override
  void dispose() {
    _textSearchController.clear();

    super.dispose();
  }

  void initData() async {
    _usuario = await Auth.instance.getSession();
//     final loadInfo = context.read<VideosController>();
//     // loadInfo.eliminaVideo(context, 11);
//     // Provider.of<PropietariosController>(context, listen: false);
//     await loadInfo.buscaAllVideos('');
// // await loadInfo.buscaRecomendaciones();
//     // final serviceSocket = Provider.of<SocketService>(context, listen: false);
//     final serviceSocket = context.read<SocketService>();
//     serviceSocket.socket!.on('server:guardadoExitoso', (data) async {
//       if (data['tabla'] == 'tutorial') {
//         loadInfo.buscaAllVideos('');
//         // NotificatiosnService.showSnackBarSuccsses(data['msg']);
//       }
//     });
//     serviceSocket.socket!.on('server:actualizadoExitoso', (data) async {
//       if (data['tabla'] == 'tutorial') {
//         loadInfo.buscaAllVideos('');
//         // NotificatiosnService.showSnackBarSuccsses(data['msg']);
//       }
//     });
//     serviceSocket.socket!.on('server:eliminadoExitoso', (data) async {
//       if (data['tabla'] == 'tutorial') {
//         loadInfo.buscaAllVideos('');
//         // NotificatiosnService.showSnackBarSuccsses(data['msg']);
//       }
//     });
//     serviceSocket.socket?.on('server:error', (data) {
//       NotificatiosnService.showSnackBarError(data['msg']);
//     });
  }

  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          backgroundColor: Colors.grey.shade100,
          appBar: AppBar(
            title: Consumer<VideosController>(
              builder: (_, providerSearchVideos, __) {
                return Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: size.iScreen(0.1)),
                        child: (providerSearchVideos.btnSearchVideos)
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
                                            providerSearchVideos
                                                .onSearchTextVideos(text);

                                            if (providerSearchVideos
                                                .nameSearchVideos.isEmpty) {
                                              // providerSearchVideos
                                              //     .buscaAllVideos('');
                                            }

                                            // setState(() {});
                                          },
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Buscar...',
                                            icon: Icon(Icons.search),
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
                                  'Tutoriales',
                                  // style: GoogleFonts.lexendDeca(
                                  //     fontSize: size.iScreen(2.45),
                                  //     color: Colors.white,
                                  //     fontWeight: FontWeight.normal),
                                ),
                              ),
                      ),
                    ),
                    IconButton(
                        splashRadius: 2.0,
                        icon: (!providerSearchVideos.btnSearchVideos)
                            ? Icon(
                                Icons.search,
                                size: size.iScreen(3.5),
                                color: Colors.white,
                              )
                            : Icon(
                                Icons.clear,
                                size: size.iScreen(3.5),
                                color: Colors.white,
                              ),
                        onPressed: () {
                          providerSearchVideos.setBtnSearchVideos(
                              !providerSearchVideos.btnSearchVideos);
                          _textSearchController.text = "";
                          // providerSearchVideos.buscaAllVideos('');
                        }),
                  ],
                );
              },
            ),
          ),
          body: Container(
            color: Colors.grey.shade100,
            // color: Colors.white,
            width: size.wScreen(100.0),
            height: size.hScreen(100.0),
            padding: EdgeInsets.only(
              top: size.iScreen(0.0),
              right: size.iScreen(0.0),
              left: size.iScreen(0.0),
            ),
            child: Consumer<VideosController>(
                        builder: (_, providersVideos, __) {
                          if (providersVideos.getErrorVideos == null &&
                              providersVideos.getError401Videos == false) {
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
                          } else if (providersVideos.getErrorVideos == false) {
                            return const NoData(
                              label: 'No existen datos para mostar',
                            );
                            // Text("Error al cargar los datos");
                          }
                          // else if (providersVideos.getListaVacunas.isEmpty) {
                          //   return const NoData(
                          //     label: 'No existen datos para mostar',
                          //   );
                          // }

                          else if (providersVideos.getListaVideos.isEmpty &&
                              providersVideos.getError401Videos == true) {
                            return const NoData(
                              label:
                                  'Su sesión ha expirado, vuelva a iniciar sesión',
                            );
                          } else if (providersVideos.getListaVideos.isEmpty &&
                              providersVideos.getError401Videos == false) {
                            return const NoData(
                              label: 'No existen datos para mostar',
                            );
                          }

                          // print('esta es la lista*******************: ${providersVideos.getListaPropietarios.length}');

                          return ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: providersVideos.getListaVideos.length,
                            itemBuilder: (BuildContext context, int index) {
                              final _video =
                                  providersVideos.getListaVideos[index];
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
                                                    // CupertinoActionSheetAction(
                                                    //   child: Row(
                                                    //     mainAxisAlignment:
                                                    //         MainAxisAlignment
                                                    //             .center,
                                                    //     children: [
                                                    //       Container(
                                                    //         margin: EdgeInsets.only(
                                                    //             right:
                                                    //                 size.iScreen(2.0)),
                                                    //         child:
                                                    //             Text(
                                                    //           'Ver Detalle',
                                                    //           style: GoogleFonts.lexendDeca(
                                                    //               fontSize: size.iScreen(1.8),
                                                    //               color: Colors.black87,
                                                    //               fontWeight: FontWeight.normal),
                                                    //         ),
                                                    //       ),
                                                    //       const Icon(
                                                    //           Icons
                                                    //               .info_outline_rounded)
                                                    //       //    const Icon(
                                                    //       //     FontAwesomeIcons.infoCircle,
                                                    //       // //  color: Colors.red,
                                                    //       //   )
                                                    //     ],
                                                    //   ),
                                                    //   onPressed:
                                                    //       () {
                                                    //     // providersVideos.setVacunaInfo(vacuna);

                                                    //     // Navigator.of(context).push(MaterialPageRoute(
                                                    //     //     builder: (context) =>
                                                    //     //         const DetalleVacuna()));
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
                                                          const Icon(Icons.edit)
                                                          //    const Icon(
                                                          //     FontAwesomeIcons.edit,
                                                          // //  color: Colors.red,
                                                          //   )
                                                        ],
                                                      ),
                                                      onPressed: () {
                                                        providersVideos
                                                            .resetFormVideos();
                                                        providersVideos
                                                            .setInfoTutorial(
                                                                _video);
                                                        Navigator.pop(context);

                                                        Navigator.pushNamed(
                                                            context,
                                                            'crearTutorial',
                                                            arguments: 'EDIT');
                                                      },
                                                    ),
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

                                                        //    Navigator.push(
                                                        //   context,
                                                        //   // MaterialPageRoute(
                                                        //   //     builder: (context) =>
                                                        //   //         ViewsPDFs(
                                                        //   //             infoPdf:
                                                        //   //                 'https://sysvet.neitor.com/reportes/carnet.php?id=${vacuna['carnMascId']}&empresa=${_usuario!.rucempresa}',
                                                        //   //             labelPdf:
                                                        //   //                 'infoVacuna.pdf')),
                                                        // );
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
                                endActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (context) async {
                                          providersVideos
                                              .setInfoTutorial(_video);
                                          _showAlertDialog(
                                              providersVideos,
                                              _video['tutoId'],
                                              '',
                                              '',
                                              'TUTORIAL');
                                        },
                                        backgroundColor: errorColor,
                                        foregroundColor: Colors.white,
                                        icon: Icons.delete,
                                        label: 'Eliminar',
                                      ),
                                    ]),
                                child: ExpansionTile(
                                    // backgroundColor:Colors.grey[300],
                                    backgroundColor: Colors.white,
                                    title: Row(
                                      children: [
                                        IconButton(
                                            splashRadius: size.iScreen(10.0),
                                            onPressed: () {
                                              context
                                                  .read<VideosController>()
                                                  .resetFormVideos();
                                              providersVideos
                                                  .setInfoTutorial(_video);
                                              Navigator.pushNamed(
                                                  context, 'crearTutorial',
                                                  arguments: 'ITEM');
                                            },
                                            icon: const Icon(
                                              Icons.add,
                                              color: primaryColor,
                                            )),
                                        Text(
                                          _video['tutoNombre'],
                                          style: GoogleFonts.lexendDeca(
                                              fontSize: size.iScreen(1.7),
                                              // color: Colors.white,
                                              fontWeight: FontWeight.normal),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                    children: [
                                      SizedBox(
                                        height: size.iScreen(
                                            _video['tutoInformacion']
                                                    .length
                                                    .toDouble() *
                                                8.0),
                                        child: ListView.builder(
                                          itemCount:
                                              _video['tutoInformacion'].length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            final _itemVideo =
                                                _video['tutoInformacion']
                                                    [index];
                                            return Slidable(
                                              startActionPane: ActionPane(
                                                // A motion is a widget used to control how the pane animates.
                                                motion: const ScrollMotion(),

                                                children: [
                                                  //     SlidableAction(
                                                  //       backgroundColor:
                                                  //           tercearyColor,
                                                  //       foregroundColor:
                                                  //           Colors.white,
                                                  //       icon:
                                                  //           Icons.list_alt_outlined,
                                                  //       label: 'Más acciones',
                                                  //       onPressed: (context) {
                                                  //         showCupertinoModalPopup(
                                                  //           context: context,
                                                  //           builder: (BuildContext
                                                  //                   context) =>
                                                  //               CupertinoActionSheet(
                                                  //                   title: Text(
                                                  //                     'Acciones',
                                                  //                     style: GoogleFonts.lexendDeca(
                                                  //                         fontSize:
                                                  //                             size.iScreen(
                                                  //                                 2.0),
                                                  //                         color:
                                                  //                             primaryColor,
                                                  //                         fontWeight:
                                                  //                             FontWeight
                                                  //                                 .normal),
                                                  //                   ),
                                                  //                   // message: const Text('Your options are '),
                                                  //                   actions: <
                                                  //                       Widget>[
                                                  //                     // CupertinoActionSheetAction(
                                                  //                     //   child: Row(
                                                  //                     //     mainAxisAlignment:
                                                  //                     //         MainAxisAlignment
                                                  //                     //             .center,
                                                  //                     //     children: [
                                                  //                     //       Container(
                                                  //                     //         margin:
                                                  //                     //             EdgeInsets.only(right: size.iScreen(2.0)),
                                                  //                     //         child:
                                                  //                     //             Text(
                                                  //                     //           'Ver Tutorial',
                                                  //                     //           style: GoogleFonts.lexendDeca(
                                                  //                     //               fontSize: size.iScreen(1.8),
                                                  //                     //               color: Colors.black87,
                                                  //                     //               fontWeight: FontWeight.normal),
                                                  //                     //         ),
                                                  //                     //       ),
                                                  //                     //       const Icon(
                                                  //                     //           Icons.video_file_outlined)
                                                  //                     //       //    const Icon(
                                                  //                     //       //     FontAwesomeIcons.infoCircle,
                                                  //                     //       // //  color: Colors.red,
                                                  //                     //       //   )
                                                  //                     //     ],
                                                  //                     //   ),
                                                  //                     //   onPressed:
                                                  //                     //       () {
                                                  //                     //     // Navigator.push(
                                                  //                     //     //     context,
                                                  //                     //     //     MaterialPageRoute(
                                                  //                     //     //         builder: (context) => VideoScreenPage(infoVideo: {
                                                  //                     //     //               'label': _video['tutoInformacion'][index]['tutoTitulo'],
                                                  //                     //     //               "url": _video['tutoInformacion'][index]['tutoUrl']
                                                  //                     //     //             })));

                                                  //                     //     //     Navigator.pop(context);
                                                  //                     //     // _launchUrl(_video['tutoInformacion'][index]['tutoUrl']);

                                                  //                     //   },
                                                  //                     // ),
                                                  //                     CupertinoActionSheetAction(
                                                  //                       child: Row(
                                                  //                         mainAxisAlignment:
                                                  //                             MainAxisAlignment
                                                  //                                 .center,
                                                  //                         children: [
                                                  //                           Container(
                                                  //                             margin:
                                                  //                                 EdgeInsets.only(right: size.iScreen(2.0)),
                                                  //                             child:
                                                  //                                 Text(
                                                  //                               'Editar',
                                                  //                               style: GoogleFonts.lexendDeca(
                                                  //                                   fontSize: size.iScreen(1.8),
                                                  //                                   color: Colors.black87,
                                                  //                                   fontWeight: FontWeight.normal),
                                                  //                             ),
                                                  //                           ),
                                                  //                           const Icon(
                                                  //                               Icons.edit)
                                                  //                           //    const Icon(
                                                  //                           //     FontAwesomeIcons.edit,
                                                  //                           // //  color: Colors.red,
                                                  //                           //   )
                                                  //                         ],
                                                  //                       ),
                                                  //                       onPressed:
                                                  //                           () {
                                                  //                         // providersVideos
                                                  //                         //     .getInfoMascota(
                                                  //                         //         vacuna);

                                                  //                         // Navigator.pushNamed(
                                                  //                         //     context,
                                                  //                         //     'crearMascota',
                                                  //                         //     arguments: 'EDIT');

                                                  //                       //  providersVideos.setInfoItemTutorial(_video['tutoId'],_video['tutoTitulo'],_video['tutoUrl'],);
                                                  //           Navigator.pop(context);

                                                  //           Navigator.pushNamed(
                                                  //               context, 'crearTutorial',
                                                  //               arguments:[ 'EDIT','ITEM',true]);
                                                  //                       },
                                                  //                     ),
                                                  //                     CupertinoActionSheetAction(
                                                  //                       child: Row(
                                                  //                         mainAxisAlignment:
                                                  //                             MainAxisAlignment
                                                  //                                 .center,
                                                  //                         children: [
                                                  //                           Container(
                                                  //                             margin:
                                                  //                                 EdgeInsets.only(right: size.iScreen(2.0)),
                                                  //                             child:
                                                  //                                 Text(
                                                  //                               'Ver PDF',
                                                  //                               style: GoogleFonts.lexendDeca(
                                                  //                                   fontSize: size.iScreen(1.8),
                                                  //                                   color: Colors.black87,
                                                  //                                   fontWeight: FontWeight.normal),
                                                  //                             ),
                                                  //                           ),
                                                  //                           const Icon(
                                                  //                             FontAwesomeIcons
                                                  //                                 .filePdf,
                                                  //                             color:
                                                  //                                 Colors.red,
                                                  //                           )
                                                  //                         ],
                                                  //                       ),
                                                  //                       onPressed:
                                                  //                           () {
                                                  //                         Navigator.pop(
                                                  //                             context);

                                                  //                         //    Navigator.push(
                                                  //                         //   context,
                                                  //                         //   // MaterialPageRoute(
                                                  //                         //   //     builder: (context) =>
                                                  //                         //   //         ViewsPDFs(
                                                  //                         //   //             infoPdf:
                                                  //                         //   //                 'https://sysvet.neitor.com/reportes/carnet.php?id=${vacuna['carnMascId']}&empresa=${_usuario!.rucempresa}',
                                                  //                         //   //             labelPdf:
                                                  //                         //   //                 'infoVacuna.pdf')),
                                                  //                         // );
                                                  //                       },
                                                  //                     ),
                                                  //                   ],
                                                  //                   cancelButton:
                                                  //                       CupertinoActionSheetAction(
                                                  //                     child: Text(
                                                  //                         'Cancel',
                                                  //                         style: GoogleFonts.lexendDeca(
                                                  //                             fontSize: size.iScreen(
                                                  //                                 2.0),
                                                  //                             color: Colors
                                                  //                                 .red,
                                                  //                             fontWeight:
                                                  //                                 FontWeight.normal)),
                                                  //                     isDefaultAction:
                                                  //                         true,
                                                  //                     onPressed:
                                                  //                         () {
                                                  //                       Navigator.pop(
                                                  //                           context,
                                                  //                           'Cancel');
                                                  //                     },
                                                  //                   )),
                                                  //         );
                                                  //       },
                                                  //     ),
                                                ],
                                              ),
                                              endActionPane: ActionPane(
                                                  motion: const ScrollMotion(),
                                                  children: [
                                                    SlidableAction(
                                                      onPressed:
                                                          (context) async {
                                                        providersVideos
                                                            .resetFormVideos();
                                                        providersVideos
                                                            .setInfoTutorial(
                                                                _video);
                                                        _showAlertDialog(
                                                            providersVideos,
                                                            _video['tutoId'],
                                                            _itemVideo[
                                                                'tutoTitulo'],
                                                            _itemVideo[
                                                                'tutoUrl'],
                                                            'ITEM');
                                                      },
                                                      backgroundColor:
                                                          errorColor,
                                                      foregroundColor:
                                                          Colors.white,
                                                      icon: Icons.delete,
                                                      label: 'Eliminar',
                                                    ),
                                                  ]),
                                              child: Card(
                                                elevation: 5,
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      bottom:
                                                          size.iScreen(0.0)),
                                                  color: 1 % 2 == 0
                                                      ? Colors.grey.shade50
                                                      : Colors.grey.shade100,
                                                  child: ListTile(
                                                    dense: true,
                                                    visualDensity: VisualDensity
                                                        .comfortable,
                                                    leading: Icon(
                                                        Icons
                                                            .video_file_outlined,
                                                        size:
                                                            size.iScreen(4.0)),

                                                    title: Container(
                                                      width:
                                                          size.wScreen(100.0),
                                                      child: Text(
                                                        _video['tutoInformacion']
                                                                [index]
                                                            ['tutoTitulo'],
                                                        style: GoogleFonts
                                                            .lexendDeca(
                                                                fontSize: size
                                                                    .iScreen(
                                                                        1.7),
                                                                // color: Colors.white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                    subtitle: Container(
                                                      // color: Colors.green,
                                                      width:
                                                          size.wScreen(100.0),
                                                      child: Text(
                                                        _video['tutoFecReg'] !=
                                                                ''
                                                            ? '${_video['tutoFecReg'].replaceAll('T', "  ").replaceAll('.000Z', "  ")}'
                                                            : '--- --- ---',
                                                        style: GoogleFonts
                                                            .lexendDeca(
                                                                // fontSize: size.iScreen(2.45),
                                                                color:
                                                                    Colors.grey,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      //  Navigator.pop(context);
                                                      //             _launchUrl(_video['tutoInformacion'][index]['tutoUrl']);

                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  VideoScreenPage(
                                                                      infoVideo: {
                                                                        'label':
                                                                            _video['tutoInformacion'][index]['tutoTitulo'],
                                                                        "url": _video['tutoInformacion'][index]
                                                                            [
                                                                            'tutoUrl']
                                                                      })));
                                                    },
                                                    // trailing: Icon(Icons.more_vert),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ]),
                              );
                            },
                          );
                        },
                      )
                   ,
          ),
          floatingActionButton:
              Consumer<SocketService>(builder: (_, valueConexion, __) {
            return valueConexion.serverStatus == ServerStatus.Online
                ? FloatingActionButton(
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      context.read<VideosController>().resetFormVideos();

                      Navigator.pushNamed(context, 'crearTutorial',
                          arguments: 'CREATE');
                    })
                : Container();
          })),
    );
  }

  // ===================================//

  void _showAlertDialog(
      VideosController _controller, int _id, _titulo, _url, String _origen) {
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
                    _origen == 'TUTORIAL'
                        ? _controller.eliminaVideo(buildcontext, _id)
                        : _origen == 'ITEM'
                            ? _controller.eliminaItemVideo(
                                buildcontext, _titulo, _url)
                            : null;
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

//   Future openFile({required String url, String? fileName}) async {
//     final name = fileName ?? url.split('/').last;
//     // final file=await   pickFile();
//     final file = await downloadFile(url, name);
//     if (file == null) return;

// //  print('Phat====>: ${file.path}');
//     OpenFile.open(file.path);
//   }

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
  Future<void> _launchUrl(String _urls) async {
    //  final Uri _url = Uri.parse('https://www.youtube.com/watch?v=GQyWIur03aw');
    final Uri _url = Uri.parse(_urls);
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
//========================================//
}

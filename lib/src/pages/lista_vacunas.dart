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
import 'package:neitorcont/src/pages/detalle_vacuna.dart';
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

class ListaVacunas extends StatefulWidget {
  const ListaVacunas({Key? key}) : super(key: key);

  @override
  State<ListaVacunas> createState() => _ListaVacunasState();
}

class _ListaVacunasState extends State<ListaVacunas> {
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
//     final loadInfo = context.read<VacunasController>();
//     // Provider.of<PropietariosController>(context, listen: false);
//     await loadInfo.buscaAllVacunas('');
// // await loadInfo.buscaRecomendaciones();
//     // final serviceSocket = Provider.of<SocketService>(context, listen: false);
//     final serviceSocket = context.read<SocketService>();
//     serviceSocket.socket!.on('server:guardadoExitoso', (data) async {
//       if (data['tabla'] == 'carnetvacuna') {
//         loadInfo.buscaAllVacunas('');
//         // NotificatiosnService.showSnackBarSuccsses(data['msg']);
//       }
//     });
//     serviceSocket.socket!.on('server:actualizadoExitoso', (data) async {
//       if (data['tabla'] == 'carnetvacuna') {
//         loadInfo.buscaAllVacunas('');
//         // NotificatiosnService.showSnackBarSuccsses(data['msg']);
//       }
//     });
//     serviceSocket.socket!.on('server:eliminadoExitoso', (data) async {
//       if (data['tabla'] == 'carnetvacuna') {
//         loadInfo.buscaAllVacunas('');
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
          title: Consumer<VacunasController>(
            builder: (_, providerSearchVacunas, __) {
              return Row(
                children: [
                  Expanded(
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: size.iScreen(0.1)),
                      child: (providerSearchVacunas.btnSearchVacunas)
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
                                              .onSearchTextVacunas(text);

                                          if (providerSearchVacunas
                                              .nameSearchVacunas.isEmpty) {
                                            providerSearchVacunas
                                                .buscaAllVacunas('');
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
                                'Vacunas',
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
                      icon: (!providerSearchVacunas.btnSearchVacunas)
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
                        providerSearchVacunas.setBtnSearchVacunas(
                            !providerSearchVacunas.btnSearchVacunas);
                        _textSearchController.text = "";
                        providerSearchVacunas.buscaAllVacunas('');
                      }),
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
          child: Consumer<VacunasController>(
                      builder: (_, providersVacunas, __) {
                        if (providersVacunas.getErrorVacunas == null &&
                            providersVacunas.getError401Vacunas == false) {
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
                        } else if (providersVacunas.getErrorVacunas == false) {
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

                        else if (providersVacunas.getListaVacunas.isEmpty &&
                            providersVacunas.getError401Vacunas == true) {
                          return const NoData(
                            label:
                                'Su sesión ha expirado, vuelva a iniciar sesión',
                          );
                        } else if (providersVacunas.getListaVacunas.isEmpty &&
                            providersVacunas.getError401Vacunas == false) {
                          return const NoData(
                            label: 'No existen datos para mostar',
                          );
                        }

                        // print('esta es la lista*******************: ${providersVacunas.getListaPropietarios.length}');

                        return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: providersVacunas.getListaVacunas.length,
                          itemBuilder: (BuildContext context, int index) {
                            final vacuna =
                                providersVacunas.getListaVacunas[index];
                            return 
                            Slidable(
                              startActionPane: ActionPane(
                                // A motion is a widget used to control how the pane animates.
                                motion: const ScrollMotion(),

                                children: [
                                  // SlidableAction(
                                  //   backgroundColor: tercearyColor,
                                  //   foregroundColor: Colors.white,
                                  //   icon: Icons.edit,
                                  //   // label: 'Editar',
                                  //   onPressed: (context) {
                                  //     providersVacunas.setVacunaInfo(vacuna);

                                  //     Navigator.pushNamed(
                                  //         context, 'crearVacunas',
                                  //         arguments: 'EDIT');
                                  //   },
                                  // ),
                                  // SlidableAction(
                                  //   onPressed: (context) async {
                                  //     context
                                  //         .read<VacunasController>()
                                  //         .eliminaVacuna(
                                  //             context, vacuna['carnId']);
                                  //   },
                                  //   backgroundColor: alertColor,
                                  //   foregroundColor: Colors.white,
                                  //   icon: Icons.delete_forever_outlined,
                                  //   // label: 'Eliminar',
                                  // ),
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
                                                  style: GoogleFonts.lexendDeca(
                                                      fontSize:
                                                          size.iScreen(2.0),
                                                      color: primaryColor,
                                                      fontWeight:
                                                          FontWeight.normal),
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
                                                        providersVacunas.setVacunaInfo(vacuna);

                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
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
                                                      // providersVacunas
                                                      //     .getInfoMascota(
                                                      //         vacuna);

                                                      // Navigator.pushNamed(
                                                      //     context,
                                                      //     'crearMascota',
                                                      //     arguments: 'EDIT');
                                                        providersVacunas.setVacunaInfo(vacuna);
                                                      Navigator.pop(context);

                                      Navigator.pushNamed(
                                          context, 'crearVacunas',
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
                                                                  .iScreen(2.0),
                                                              color: Colors.red,
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
                                        _showAlertDialog(
                                            providersVacunas, vacuna['carnId']);
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
                                      visualDensity: VisualDensity.comfortable,
                                      leading:
                                          // vacuna['mascFoto'] != ''
                                          //     ? CircleAvatar(
                                          //         radius: 20.0,
                                          //         backgroundImage: NetworkImage(
                                          //             "${vacuna['mascFoto']}"),
                                          //         backgroundColor:
                                          //             Colors.transparent,
                                          //       )
                                          //     : const CircleAvatar(
                                          //         radius: 20.0,
                                          //         backgroundImage: AssetImage(
                                          //             'assets/imgs/no-photo.png'),
                                          //         backgroundColor:
                                          //             Colors.transparent,
                                          //       ),
                                          CircleAvatar(
                                        //         radius: 20.0,
                                        child: Text(
                                            '${vacuna['carnMascNombre'].substring(0, 1)}',
                                            style:
                                                TextStyle(color: primaryColor)),
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
                                                'Peso: ${vacuna['carnPeso']} Kg',
                                                style: GoogleFonts.lexendDeca(
                                                    fontSize: size.iScreen(1.5),
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
                                                '${vacuna['carnPerNombreVet']}',
                                                style: GoogleFonts.lexendDeca(
                                                    // fontSize: size.iScreen(2.45),
                                                    color: Colors.grey,
                                                    fontWeight:
                                                        FontWeight.normal),
                                                overflow: TextOverflow.ellipsis,
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
                    context.read<VacunasController>().resetFormVacuna();

                    Navigator.pushNamed(context, 'crearVacunas',
                        arguments: 'CREATE');
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
//========================================//
}

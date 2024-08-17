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
import 'package:neitorcont/src/controllers/peluqueria_controller.dart';
import 'package:neitorcont/src/controllers/recetas_controller.dart';
import 'package:neitorcont/src/controllers/vacunas_controller.dart';
import 'package:neitorcont/src/models/sesison_model.dart';
import 'package:neitorcont/src/pages/crear_peluqueria.dart';
import 'package:neitorcont/src/pages/detalle_peluqueria.dart';
import 'package:neitorcont/src/pages/detalle_propietario.dart';
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

class ListaPeluqueriaPagiacion extends StatefulWidget {
  const ListaPeluqueriaPagiacion({Key? key}) : super(key: key);

  @override
  State<ListaPeluqueriaPagiacion> createState() => _ListaPeluqueriaPagiacionState();
}

class _ListaPeluqueriaPagiacionState extends State<ListaPeluqueriaPagiacion> {
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

        final _next = context.read<PeluqueriaController>();
        if (_next.getpage != null) {
          _next.setPage(_next.getpage);
          //       providerSearchPropietario.setCantidad(25);
          _next.buscaAllPeluqueriasPaginacion('', false);
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
    final loadInfo = context.read<PeluqueriaController>();
    // Provider.of<PropietariosController>(context, listen: false);
    // await loadInfo.buscaAllPeluqueria('');
// await loadInfo.buscaRecomendaciones();
    // final serviceSocket = Provider.of<SocketService>(context, listen: false);
    final serviceSocket = context.read<SocketService>();
    serviceSocket.socket!.on('server:guardadoExitoso', (data) async {
      if (data['tabla'] == 'peluqueria') {
        loadInfo.buscaAllPeluqueriasPaginacion('',false);
        // NotificatiosnService.showSnackBarSuccsses(data['msg']);
      }
    });
    serviceSocket.socket!.on('server:actualizadoExitoso', (data) async {
      if (data['tabla'] == 'peluqueria') {
        loadInfo.buscaAllPeluqueriasPaginacion('',false);
        // NotificatiosnService.showSnackBarSuccsses(data['msg']);
      }
    });
    serviceSocket.socket!.on('server:eliminadoExitoso', (data) async {
      if (data['tabla'] == 'peluqueria') {
      
  //  loadInfo.setPage(0);
  //                   loadInfo.setCantidad(25);
  //                   loadInfo.buscaAllPeluqueriasPaginacion('', false);

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
            title: Consumer<PeluqueriaController>(
              builder: (_, providerSearchPeluqueria, __) {
                return Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: size.iScreen(0.1)),
                        child: (providerSearchPeluqueria
                                .btnSearchPeluqueriaPaginacion)
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
                                            providerSearchPeluqueria
                                                .onSearchTextPeluqueriaPaginacion(
                                                    text);

                                            if (providerSearchPeluqueria
                                                .nameSearchPeluqueriaPaginacion
                                                .isEmpty) {
                                    //                 providerSearchPeluqueria
                                    //     .setErrorMascotasPaginacion(null);

                                    // providerSearchPeluqueria
                                    //     .setError401MascotasPaginacion(
                                    //         false);
                                              providerSearchPeluqueria
                                                  .setPage(0);
                                              providerSearchPeluqueria
                                                  .setCantidad(25);
                                              // providerSearchPeluqueria.setIsNext(false);
                                              providerSearchPeluqueria
                                                  .buscaAllPeluqueriasPaginacion(
                                                      '', true);

                                              //   providerSearchPeluqueria
                                              //       .setBtnSearchPropietarioPaginacion(
                                              //           !providerSearchPeluqueria
                                              //               .btnSearchPropietarioPaginacion);
                                              //   _textSearchController.text = "";
                                              //   providerSearchPeluqueria
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
                                            //   // providerSearchPeluqueria
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
                                  'Peluquería',
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
                        providerSearchPeluqueria.btnSearchPeluqueriaPaginacion
                            ? IconButton(
                                splashRadius: size.iScreen(3.0),
                                icon: Icon(
                                  Icons.search,
                                  size: size.iScreen(3.5),
                                  // color: Colors.white,
                                ),
                                onPressed: () {
                                  
                                  //=====================//
                                  if (providerSearchPeluqueria
                                          .nameSearchPeluqueriaPaginacion
                                          .length >=
                                      3) {
                                    providerSearchPeluqueria
                                        .setErrorPeluqueriasPaginacion(null);

                                    providerSearchPeluqueria
                                        .setError401PeluqueriasPaginacion(
                                            false);
                                    providerSearchPeluqueria.setPage(0);
                                    providerSearchPeluqueria.setCantidad(25);

                                    providerSearchPeluqueria
                                        .buscaAllPeluqueriasPaginacion(
                                            // '0803395581');
                                            ' ${providerSearchPeluqueria.nameSearchPeluqueriaPaginacion}',
                                            true);
                                  } else {
                                    print('NO HAACE NADA');
                                  }
                                })
                            : Container(),
                        IconButton(
                            splashRadius: 2.0,
                            icon: (!providerSearchPeluqueria
                                    .btnSearchPeluqueriaPaginacion)
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
                            
                                   providerSearchPeluqueria.onSearchTextPeluqueriaPaginacion("");
                                   _textSearchController.text='';
                                   
                              providerSearchPeluqueria
                                  .setBtnSearchPeluqueriaPaginacion(
                                      !providerSearchPeluqueria
                                          .btnSearchPeluqueriaPaginacion);

                              if (providerSearchPeluqueria
                                      .btnSearchPeluqueriaPaginacion ==
                                  false) {

 //=====================//
                              providerSearchPeluqueria
                                  .setErrorPeluqueriasPaginacion(null);

                              providerSearchPeluqueria
                                  .setError401PeluqueriasPaginacion(false);

                              providerSearchPeluqueria.setPage(0);
                              providerSearchPeluqueria.setCantidad(25);
                              providerSearchPeluqueria
                                  .buscaAllPeluqueriasPaginacion('', true);
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
          child:  Consumer<PeluqueriaController>(
                      builder: (_, providersPeluqueria, __) {
                        if (providersPeluqueria.getErrorPeluqueriasPaginacion == null && providersPeluqueria.getError401PeluqueriasPaginacion == false) {
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
                        } else if (providersPeluqueria.getErrorPeluqueriasPaginacion ==
                            false) {
                          return const NoData(
                            label: 'No existen datos para mostar',
                          );
                          // Text("Error al cargar los datos");
                        }
                        //  else if (providersPeluqueria
                        //     .getListaPeluqueria.isEmpty) {
                        //   return const NoData(
                        //     label: 'No existen datos para mostar',
                        //   );
                        // }
                         else if (providersPeluqueria.getListaPeluqueriasPaginacion.isEmpty &&
                              providersPeluqueria.getError401PeluqueriasPaginacion == true) {
                            return const NoData(
                              label:
                                  'Su sesión ha expirado, vuelva a iniciar sesión',
                            );
                          } else if (providersPeluqueria.getListaPeluqueriasPaginacion.isEmpty &&
                              providersPeluqueria.getError401PeluqueriasPaginacion == false) {
                            return const NoData(
                              label: 'No existen datos para mostar',
                            );
                          }
                        // print('esta es la lista*******************: ${providersPeluqueria.getListaPropietarios.length}');

                        return RefreshIndicator(
                                onRefresh: () => onRefresh(),
                          child: ListView.builder(
                            controller: _scrollController,
                            physics: const BouncingScrollPhysics(),
                            itemCount: providersPeluqueria.getListaPeluqueriasPaginacion.length +1,
                            itemBuilder: (BuildContext context, int index) {

                                if (index <
                                    providersPeluqueria
                                        .getListaPeluqueriasPaginacion.length) {


                              final peluqueria =
                                  providersPeluqueria.getListaPeluqueriasPaginacion[index];
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
                                                            providersPeluqueria.setPeluqueriaInfo(peluqueria);
                        
                                                  
                                                   Navigator.pop(context);
                                                                 Navigator.of(context).push(
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          const DetallePeluqueria()));
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
                                                          // providersPeluqueria
                                                          //     .getInfoMascota(
                                                          //         peluqueria);
                                                           providersPeluqueria.setPeluqueriaInfo(peluqueria);
                                                           providersPeluqueria. buscaAllPedidosPeluqueria('');
                        
                                                          Navigator.pop(context);
                                                          // Navigator.pushNamed(
                                                          //     context,
                                                          //     'creaPeluqueria',
                                                          //     arguments: 'EDIT');

                                 Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const CreaPeluqueria(tipo: 'EDIT',))).then((value) => onRefresh());
                        
                                                              // providersPeluqueria.setPeluqueriaInfo(peluqueria);
                                                              //    Navigator.of(context).push(
                                                              // MaterialPageRoute(
                                                              //     builder:
                                                              //         (context) =>
                                                              //             const DetallePeluqueria()));
                                                        // Navigator.pop(context);
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
                                                      //           'Ver PDF',
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
                                                      //       const Icon(
                                                      //         FontAwesomeIcons
                                                      //             .filePdf,
                                                      //         color: Colors.red,
                                                      //       )
                                                      //     ],
                                                      //   ),
                                                      //   onPressed: () {
                                                      //     Navigator.pop(context);
                        
                                                      //     openFile(
                                                      //         url:
                                                      //             "https://sysvet.neitor.com/reportes/carnet.php?id=${peluqueria['mascId']}&empresa=${_usuario!.rucempresa}",
                                                      //         fileName:
                                                      //             'infoMascota.pdf');
                                                      //   },
                                                      // ),
                                                    
                                                    
                                                    
                                                    
                                                    
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
                                        // SlidableAction(
                                        //   onPressed: (context) async {
                                            //  context
                                            // .read<PeluqueriaController>()
                                            // .eliminaPeluqueria(
                                            //     context, peluqueria['pelId']);
                                             SlidableAction(
                                          onPressed: (context) async {
                                            _showAlertDialog(providersPeluqueria,
                                                peluqueria['pelId']);
                                          },
                                          backgroundColor: errorColor,
                                          foregroundColor: Colors.white,
                                          icon: Icons.delete,
                                          label: 'Eliminar',
                                        ),
                                        //   },
                                        //   backgroundColor: errorColor,
                                        //   foregroundColor: Colors.white,
                                        //   icon: Icons.delete_forever_outlined,
                        
                                        //   // label: 'Eliminar',
                                        // ),
                                      ]),
                                child: GestureDetector(
                                  onTap: () {
                                    // providerHistorias.getInfoMascota(
                                    //     mascota);
                        
                                    // Navigator.of(context).push(MaterialPageRoute(
                                    //     builder: (context) =>
                                    //         const DetalleMascotas()));
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
                                        
                                     
                                        leading: CircleAvatar(
                                          child: Text(
                                          '${peluqueria['pelMascNombre'].substring(0, 1)}',
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
                                                '${peluqueria['pelMascNombre']}',
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
                                                  '${peluqueria['pelTemperamento']}',
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
                                                  '${peluqueria['pelPerNombreDoc']}',
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
                                                peluqueria['pelFecReg'] != ''
                                                    ? '${peluqueria['pelFecReg'].replaceAll('T', "  ").replaceAll('.000Z', "  ")}'
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
                                
                                
                                ),
                              );}
                              else{
                                return Consumer<PeluqueriaController>(
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
                                          :  providersPeluqueria
                                  .getListaPeluqueriasPaginacion.length>25?
                                      
                                      Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: size.iScreen(2.0)),
                                          child: const Center(
                                              child:
                                                  CircularProgressIndicator())): Container();

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
                    final controllers=context
                        .read<PeluqueriaController>();
                        controllers.resetFormPeluqueria();
                        controllers.buscaAllPedidosPeluqueria('');



                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const CreaPeluqueria(tipo: 'CREATE',))).then((value) => onRefresh());

                    // Navigator.pushNamed(context, 'creaPeluqueria',
                    //     arguments: 'CREATE');
                  })
              : Container();
        }),
      ),
    );
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

// ===================================//

  void _showAlertDialog(PeluqueriaController _controller, int _id) {
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
                    _controller.eliminaPeluqueria(buildcontext, _id);
                    Navigator.pop(context);
                    onRefresh() ;
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

Future<void> onRefresh() async {
    final _controller =
        Provider.of<PeluqueriaController>(context, listen: false);
    _controller.setPage(0);
    _controller.setCantidad(25);
    _controller.buscaAllPeluqueriasPaginacion('', true);
  }    

}

import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neitorcont/src/api/authentication_client.dart';
import 'package:neitorcont/src/controllers/comprobantes_controller.dart';

import 'package:neitorcont/src/controllers/proformas_controller.dart';

import 'package:neitorcont/src/models/sesison_model.dart';
import 'package:neitorcont/src/pages/crear_comprobante_print.dart';
import 'package:neitorcont/src/pages/views_pdf.dart';
import 'package:neitorcont/src/services/notifications_service.dart';
import 'package:neitorcont/src/services/socket_service.dart';
import 'package:neitorcont/src/theme/themes_app.dart';
import 'package:neitorcont/src/utils/responsive.dart';
import 'package:neitorcont/src/utils/theme.dart';
import 'package:neitorcont/src/widgets/no_data.dart';
import 'package:provider/provider.dart';

class ListarProformasProformas extends StatefulWidget {
  const ListarProformasProformas({Key? key}) : super(key: key);

  @override
  State<ListarProformasProformas> createState() => _ListarProformasProformasState();
}

class _ListarProformasProformasState extends State<ListarProformasProformas> {
  final TextEditingController _textSearchController = TextEditingController();
  Session? _usuario;
   final _scrollController = ScrollController();


  @override
  void initState() {
     _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
       
        final _next = context.read<ProformasController>();
        if (_next.getpage != null) {
          _next.setPage(_next.getpage);
          //       providerSearchPropietario.setCantidad(25);
          _next.buscaAllProformasPaginacion('', false,_next.getTabIndex);
        } else {
          // print("ES NULL POR ESO NO HACER PETICION ");
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
    final loadInfo = context.read<ProformasController>();
    // Provider.of<PropietariosController>(context, listen: false);
    // await loadInfo.buscaAllProformas('');

    final serviceSocket = context.read<SocketService>();
    serviceSocket.socket!.on('server:guardadoExitoso', (data) async {
      if (data['tabla'] == 'proformas') {
        loadInfo.buscaAllProformasPaginacion('',false,loadInfo.getTabIndex);
        // NotificatiosnService.showSnackBarSuccsses(data['msg']);
      }
    });
    serviceSocket.socket!.on('server:actualizadoExitoso', (data) async {
      if (data['tabla'] == 'proformas') {
        loadInfo.buscaAllProformasPaginacion('',false,loadInfo.getTabIndex);
        // NotificatiosnService.showSnackBarSuccsses(data['msg']);
      }
    });
    serviceSocket.socket!.on('server:eliminadoExitoso', (data) async {
      if (data['tabla'] == 'proformas') {
        loadInfo.buscaAllProformasPaginacion('',false,loadInfo.getTabIndex);
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
          
            title: Consumer<ProformasController>(
              builder: (_, providerSearchProformas, __) {
                return Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: size.iScreen(0.1)),
                        child: (providerSearchProformas
                                .btnSearchProformasPaginacion)
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
                                            providerSearchProformas
                                                .onSearchTextProformasPaginacion(
                                                    text);

                                            if (providerSearchProformas
                                                .nameSearchProformasPaginacion
                                                .isEmpty) {
                                              //                 providerSearchProformas
                                              //     .setErrorMascotasPaginacion(null);

                                              // providerSearchProformas
                                              //     .setError401MascotasPaginacion(
                                              //         false);
                                              providerSearchProformas.setPage(0);
                                              providerSearchProformas
                                                  .setCantidad(25);
                                              // providerSearchProformas.setIsNext(false);
                                              providerSearchProformas
                                                  .buscaAllProformasPaginacion(
                                                      '', true,providerSearchProformas.getTabIndex);

                                              //   providerSearchProformas
                                              //       .setBtnSearchPropietarioPaginacion(
                                              //           !providerSearchProformas
                                              //               .btnSearchPropietarioPaginacion);
                                              //   _textSearchController.text = "";
                                              //   providerSearchProformas
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
                                            //   // providerSearchProformas
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
                                  'PROFORMAS',
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
                        providerSearchProformas.btnSearchProformasPaginacion
                            ? IconButton(
                                splashRadius: size.iScreen(3.0),
                                icon: Icon(
                                  Icons.search,
                                  size: size.iScreen(3.5),
                                  // color: Colors.white,
                                ),
                                onPressed: () {
                                  //=====================//
                                  if (providerSearchProformas
                                          .nameSearchProformasPaginacion.length >=
                                      3) {
                                    providerSearchProformas
                                        .setErrorProformasPaginacion(null);

                                    providerSearchProformas
                                        .setError401ProformasPaginacion(false);
                                    providerSearchProformas.setPage(0);
                                    providerSearchProformas.setCantidad(25);

                                    providerSearchProformas
                                        .buscaAllProformasPaginacion(
                                            // '0803395581');
                                            ' ${providerSearchProformas.nameSearchProformasPaginacion}',
                                            true,providerSearchProformas.getTabIndex);
                                  } else {
                                    print('NO HAACE NADA');
                                  }
                                })
                            : Container(),
                        IconButton(
                            splashRadius: 2.0,
                            icon: (!providerSearchProformas
                                    .btnSearchProformasPaginacion)
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
                              providerSearchProformas
                                  .onSearchTextProformasPaginacion("");
                              _textSearchController.text = '';

                              providerSearchProformas
                                  .setBtnSearchProformasPaginacion(
                                      !providerSearchProformas
                                          .btnSearchProformasPaginacion);

                              if (providerSearchProformas
                                      .btnSearchProformasPaginacion ==
                                  false) {
                                //=====================//
                                providerSearchProformas
                                    .setErrorProformasPaginacion(null);

                                providerSearchProformas
                                    .setError401ProformasPaginacion(false);

                                providerSearchProformas.setPage(0);
                                providerSearchProformas.setCantidad(25);
                                providerSearchProformas
                                    .buscaAllProformasPaginacion('', true,providerSearchProformas.getTabIndex);
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
          
          body: 
          
          // Container(
          //   color: Colors.grey.shade100,
          //   width: size.wScreen(100.0),
          //   height: size.hScreen(100.0),
          //   padding: EdgeInsets.only(
          //     top: size.iScreen(0.0),
          //     right: size.iScreen(0.0),
          //     left: size.iScreen(0.0),
          //   ),
          //   child: Consumer<ProformasController>(
          //               builder: (_, providersProformas, __) {
          //                 if (providersProformas.getErrorProformasPaginacion == null &&
          //                     providersProformas.getError401ProformasPaginacion == false) {
          //                   return Center(
          //                     // child: CircularProgressIndicator(),
          //                     child: Column(
          //                       mainAxisSize: MainAxisSize.min,
          //                       children: [
          //                         Text(
          //                           'Cargando Datos...',
          //                           style: GoogleFonts.lexendDeca(
          //                               fontSize: size.iScreen(1.5),
          //                               color: Colors.black87,
          //                               fontWeight: FontWeight.bold),
          //                         ),
          //                         //***********************************************/
          //                         SizedBox(
          //                           height: size.iScreen(1.0),
          //                         ),
          //                         //*****************************************/
          //                         const CircularProgressIndicator(),
          //                       ],
          //                     ),
          //                   );
          //                 } else if (providersProformas.getErrorProformasPaginacion ==
          //                     false) {
          //                   return const NoData(
          //                     label: 'No existen datos para mostar',
          //                   );
          //                 } else if (providersProformas
          //                         .getListaProformasPaginacion.isEmpty &&
          //                     providersProformas.getError401ProformasPaginacion == true) {
          //                   return const NoData(
          //                     label:
          //                         'Su sesión ha expirado, vuelva a iniciar sesión',
          //                   );
          //                 } else if (providersProformas
          //                         .getListaProformasPaginacion.isEmpty &&
          //                     providersProformas.getError401ProformasPaginacion == false) {
          //                   return const NoData(
          //                     label: 'No existen datos para mostar',
          //                   );
          //                 }

          //                 return RefreshIndicator(
          //                             onRefresh: () => onRefresh(),
          //                   child: ListView.builder(
          //                     controller: _scrollController,
          //                     physics: const BouncingScrollPhysics(),
          //                     itemCount: providersProformas.getListaProformasPaginacion.length+1,
          //                     itemBuilder: (BuildContext context, int index) {
          //                        if (index <
          //                          providersProformas.getListaProformasPaginacion.length) {
          //                       var _color;
          //                       final _proformas =
          //                           providersProformas.getListaProformasPaginacion[index];
                          
          //                       if (_proformas['venEstado'] == 'ACTIVA') {
          //                         _color = Colors.green;
          //                       } else if (_proformas['venEstado'] ==
          //                           'SIN AUTORIZAR') {
          //                         _color = Colors.orange;
          //                       }
          //                       if (_proformas['venEstado'] == 'ANULADA') {
          //                         _color = Colors.red;
          //                       }
                          
          //                       return Slidable(
          //                         startActionPane: ActionPane(
          //                           // A motion is a widget used to control how the pane animates.
          //                           motion: const ScrollMotion(),
                          
          //                           children: [
          //                             SlidableAction(
          //                                     backgroundColor: Colors.grey,
          //                                 foregroundColor: Colors.white,
          //                               icon: Icons.list_alt_outlined,
          //                               label: 'Más acciones',
          //                               onPressed: (context) {
          //                                 showCupertinoModalPopup(
          //                                   context: context,
          //                                   builder: (BuildContext context) =>
          //                                       CupertinoActionSheet(
          //                                           title: Text(
          //                                             'Acciones',
          //                                             style:
          //                                                 GoogleFonts.lexendDeca(
          //                                                     fontSize: size
          //                                                         .iScreen(2.0),
          //                                                     color: primaryColor,
          //                                                     fontWeight:
          //                                                         FontWeight
          //                                                             .normal),
          //                                           ),
          //                                           // message: const Text('Your options are '),
          //                                           actions: <Widget>[
          //                                             CupertinoActionSheetAction(
          //                                               child: Row(
          //                                                 mainAxisAlignment:
          //                                                     MainAxisAlignment
          //                                                         .center,
          //                                                 children: [
          //                                                   Container(
          //                                                     margin:
          //                                                         EdgeInsets.only(
          //                                                             right: size
          //                                                                 .iScreen(
          //                                                                     2.0)),
          //                                                     child: Text(
          //                                                       'Ver PDF',
          //                                                       style: GoogleFonts.lexendDeca(
          //                                                           fontSize: size
          //                                                               .iScreen(
          //                                                                   1.8),
          //                                                           color: Colors
          //                                                               .black87,
          //                                                           fontWeight:
          //                                                               FontWeight
          //                                                                   .normal),
          //                                                     ),
          //                                                   ),
          //                                                   const Icon(
          //                                                     FontAwesomeIcons
          //                                                         .filePdf,
          //                                                     color: Colors.red,
          //                                                   )
          //                                                 ],
          //                                               ),
          //                                               onPressed: () {
          //                                                 Navigator.pop(context);
                          
          //                                                 Navigator.push(
          //                                                   context,
          //                                                   MaterialPageRoute(
          //                                                       builder: (context) =>
          //                                                           ViewsPDFs(
          //                                                               infoPdf:
          //                                                                   // 'https://sysvet.neitor.com/reportes/carnet.php?id=${factura['venId']}&empresa=${_usuario!.rucempresa}',
          //                                                                   'https://syscontable.neitor.com/reportes/factura.php?codigo=${_proformas['venId']}&empresa=${_usuario!.rucempresa}',
          //                                                               labelPdf:
          //                                                                   'infoFactura.pdf')),
          //                                                 );
          //                                               },
          //                                             ),
          //                                           ],
          //                                           cancelButton:
          //                                               CupertinoActionSheetAction(
          //                                             child: Text('Cancel',
          //                                                 style: GoogleFonts
          //                                                     .lexendDeca(
          //                                                         fontSize: size
          //                                                             .iScreen(
          //                                                                 2.0),
          //                                                         color:
          //                                                             Colors.red,
          //                                                         fontWeight:
          //                                                             FontWeight
          //                                                                 .normal)),
          //                                             isDefaultAction: true,
          //                                             onPressed: () {
          //                                               Navigator.pop(
          //                                                   context, 'Cancel');
          //                                             },
          //                                           )),
          //                                 );
          //                               },
          //                             ),
          //                           ],
          //                         ),
          //                         child: Card(
          //                           elevation: 5,
          //                           child: Container(
          //                             margin: EdgeInsets.only(
          //                                 bottom: size.iScreen(0.0)),
          //                             color: index % 2 == 0
          //                                 ? Colors.grey.shade50
          //                                 : Colors.grey.shade200,
          //                             child: ListTile(
          //                               dense: true,
          //                               visualDensity: VisualDensity.comfortable,
                                   
          //                               leading: CircleAvatar(
          //                                   child: Text(
          //                                     '${_proformas['venNomCliente'].substring(0, 1)}',
          //                                     style: Theme.of(context)
          //                                         .textTheme
          //                                         .subtitle1,
          //                                   ),
          //                                   backgroundColor: Colors.grey[300],
          //                                 ),
          //                               title: Row(
          //                                 mainAxisAlignment:
          //                                     MainAxisAlignment.spaceBetween,
          //                                 children: [
          //                                   SizedBox(
          //                                     width: size.wScreen(50.0),
          //                                     child: Text(
          //                                       '${_proformas['venNomCliente']}',
          //                                       style: GoogleFonts.lexendDeca(
          //                                           // fontSize: size.iScreen(2.45),
          //                                           // color: Colors.white,
          //                                           fontWeight:
          //                                               FontWeight.normal),
          //                                       overflow: TextOverflow.ellipsis,
          //                                     ),
          //                                   ),
          //                                   Text(
          //                                     '${_proformas['venEstado']}',
          //                                     // 'Estado: ',
          //                                     style: GoogleFonts.lexendDeca(
          //                                         fontSize: size.iScreen(1.5),
          //                                         color: _color,
          //                                         fontWeight: FontWeight.bold),
          //                                   ),
          //                                 ],
          //                               ),
          //                               subtitle: Row(
          //                                 mainAxisAlignment:
          //                                     MainAxisAlignment.spaceBetween,
          //                                 children: [
          //                                   Column(
          //                                     mainAxisAlignment:
          //                                         MainAxisAlignment.start,
          //                                     children: [
          //                                       Container(
          //                                         // color: Colors.green,
          //                                         width: size.wScreen(50.0),
          //                                         child: Text(
          //                                           '${_proformas['venNumFactura']}',
          //                                           style: GoogleFonts.lexendDeca(
          //                                               fontSize:
          //                                                   size.iScreen(1.5),
          //                                               color: Colors.black54,
          //                                               fontWeight:
          //                                                   FontWeight.normal),
          //                                           overflow:
          //                                               TextOverflow.ellipsis,
          //                                         ),
          //                                       ),
          //                                       Container(
          //                                         // color: Colors.green,
          //                                         width: size.wScreen(50.0),
          //                                         child: Text(
          //                                           _proformas['venFecReg'] != ''
          //                                               ? '${_proformas['venFecReg'].replaceAll('T', "  ").replaceAll('.000Z', "  ")}'
          //                                               : '--- --- ---',
          //                                           style: GoogleFonts.lexendDeca(
          //                                               // fontSize: size.iScreen(2.45),
          //                                               color: Colors.grey,
          //                                               fontWeight:
          //                                                   FontWeight.normal),
          //                                         ),
          //                                       ),
          //                                     ],
          //                                   ),
          //                                   Container(
          //                                     // color: Colors.green,
          //                                     // width: size.wScreen(100.0),
          //                                     child: Text(
          //                                       '\$${_proformas['venTotal']}',
          //                                       style: GoogleFonts.lexendDeca(
          //                                           fontSize: size.iScreen(2.0),
          //                                           color: Colors.black87,
          //                                           fontWeight:
          //                                               FontWeight.normal),
          //                                       overflow: TextOverflow.ellipsis,
          //                                     ),
          //                                   ),
          //                                 ],
          //                               ),
          //                               // trailing: Icon(Icons.more_vert),
          //                             ),
          //                           ),
          //                         ),
          //                       );}else{
          //                          return Consumer<ProformasController>(
          //                           builder: (_, valueNext, __) {
          //                             return valueNext.getpage == null
          //                                 ? Container(
          //                                     margin: EdgeInsets.symmetric(
          //                                         vertical: size.iScreen(2.0)),
          //                                     child: Center(
          //                                       child: Text(
          //                                         'No existen más datos',
          //                                         style: GoogleFonts.lexendDeca(
          //                                             fontSize: size.iScreen(1.8),
          //                                             // color: primaryColor,
          //                                             fontWeight:
          //                                                 FontWeight.normal),
          //                                       ),
          //                                     ))
          //                                 // : Container();
                          
          //                                 : valueNext.getListaProformasPaginacion
          //                                             .length >
          //                                         25
          //                                     ? Container(
          //                                         margin: EdgeInsets.symmetric(
          //                                             vertical:
          //                                                 size.iScreen(2.0)),
          //                                         child: const Center(
          //                                             child:
          //                                                 CircularProgressIndicator()))
          //                                     : Container();
          //                           },
          //                         );
          //                       }
          //                     },
          //                   ),
          //                 );
          //               },
          //             )
          //          ,
          // ),
          
          Container(
  color: Colors.grey.shade100,
  width: size.wScreen(100.0),
  height: size.hScreen(100.0),
  padding: EdgeInsets.only(
    top: size.iScreen(0.0),
    right: size.iScreen(0.0),
    left: size.iScreen(0.0),
  ),
  child: DefaultTabController(
    length: 2,  // Número de tabs
    child: Column(
      children: [
        TabBar(
          tabs: [
            Tab(
              child:
              Consumer<ProformasController>(builder: (_, valueHoy, __) {  
                return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('HOY', style: TextStyle(fontSize: size.iScreen(1.8))),
                  // Espacio entre los textos
                  Text('\$${valueHoy.getValorTotalFacturasHoy}', style: TextStyle(fontSize: size.iScreen(2.5))),
                ],
              );
              },)
               
            ),
            Tab(
              child:
              Consumer<ProformasController>(builder: (_, valueAnteriores, __) {  
                return   Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('ANTERIORES',style: TextStyle(fontSize: size.iScreen(1.8))),
                   // Espacio entre los textos
                   Text('\$${valueAnteriores.getValorTotalFacturasAntes}', style: TextStyle(fontSize: size.iScreen(2.5))),
                ],
              );
              },)
              
             
            ),
          ],
           onTap: (index) {
                        print('EL INDICE :$index');
                        final ctrl=context.read<ProformasController>();
                       ctrl.setTabIndex(index);
                        if (  index==0) {
                          ctrl. setInfoBusquedaProformasPaginacion([]);
                          ctrl.resetValorTotal();
                            // ctrl.buscaAllProformasPaginacion(
                            //     '',false,ctrl.getTabIndex);

                          final _controllerProformas =
                                context.read<ProformasController>();

                            _controllerProformas
                                .onSearchTextProformasPaginacion("");

                            _controllerProformas
                                .setBtnSearchProformasPaginacion(false);
                            _controllerProformas
                                .setErrorProformasPaginacion(null);

                            _controllerProformas
                                .setError401ProformasPaginacion(false);

                            _controllerProformas.resetFormProformas();
                            _controllerProformas.setPage(0);
                            _controllerProformas.setIsNext(false);
                            _controllerProformas
                                .setInfoBusquedaProformasPaginacion([]);
                            _controllerProformas.buscaAllProformasPaginacion(
                                '', true,_controllerProformas.getTabIndex);



                        }
                        if ( index==1) {
                           ctrl.setInfoBusquedaProformasPaginacion([]);
                           ctrl.resetValorTotal();
                             ctrl.buscaAllProformasPaginacion(
                                '',false,ctrl.getTabIndex);
                        }
                      },
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.blue,
        ),
        Expanded(
          child: TabBarView(
            children: [
              // Contenido de Tab 1
              Consumer<ProformasController>(
                builder: (_, providersProformas, __) {
                  if (providersProformas.getErrorProformasPaginacion == null &&
                      providersProformas.getError401ProformasPaginacion == false) {
                    return Center(
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
                          SizedBox(
                            height: size.iScreen(1.0),
                          ),
                          const CircularProgressIndicator(),
                        ],
                      ),
                    );
                  } else if (providersProformas.getErrorProformasPaginacion == false) {
                    return const NoData(
                      label: 'No existen datos para mostrar',
                    );
                  } else if (providersProformas.getListaProformasPaginacion.isEmpty &&
                      providersProformas.getError401ProformasPaginacion == true) {
                    return const NoData(
                      label: 'Su sesión ha expirado, vuelva a iniciar sesión',
                    );
                  } else if (providersProformas.getListaProformasPaginacion.isEmpty &&
                      providersProformas.getError401ProformasPaginacion == false) {
                    return const NoData(
                      label: 'No existen datos para mostrar',
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () => onRefresh(),
                    child: ListView.builder(
                      controller: _scrollController,
                      physics: const BouncingScrollPhysics(),
                      itemCount: providersProformas.getListaProformasPaginacion.length + 1,
                      itemBuilder: (BuildContext context, int index) {
                        if (index < providersProformas.getListaProformasPaginacion.length) {
                          var _color;
                          final _proformas = providersProformas.getListaProformasPaginacion[index];

                          if (_proformas['venEstado'] == 'ACTIVA') {
                            _color = Colors.green;
                          } else if (_proformas['venEstado'] == 'SIN AUTORIZAR') {
                            _color = Colors.orange;
                          }
                          if (_proformas['venEstado'] == 'ANULADA') {
                            _color = Colors.red;
                          }

                          return Slidable(
                            startActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  backgroundColor: Colors.grey,
                                  foregroundColor: Colors.white,
                                  icon: Icons.list_alt_outlined,
                                  label: 'Más acciones',
                                  onPressed: (context) {
                                    showCupertinoModalPopup(
                                      context: context,
                                      builder: (BuildContext context) => CupertinoActionSheet(
                                        title: Text(
                                          'Acciones',
                                          style: GoogleFonts.lexendDeca(
                                              fontSize: size.iScreen(2.0),
                                              color: primaryColor,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        actions: <Widget>[
                                          CupertinoActionSheetAction(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(right: size.iScreen(2.0)),
                                                  child: Text(
                                                    'Ver PDF',
                                                    style: GoogleFonts.lexendDeca(
                                                        fontSize: size.iScreen(1.8),
                                                        color: Colors.black87,
                                                        fontWeight: FontWeight.normal),
                                                  ),
                                                ),
                                                const Icon(
                                                  FontAwesomeIcons.filePdf,
                                                  color: Colors.red,
                                                ),
                                              ],
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => ViewsPDFs(
                                                        infoPdf: 'https://syscontable.neitor.com/reportes/factura.php?codigo=${_proformas['venId']}&empresa=${_usuario!.rucempresa}',
                                                        labelPdf: 'infoFactura.pdf')),
                                              );
                                            },
                                          ),
                                        ],
                                        cancelButton: CupertinoActionSheetAction(
                                          child: Text(
                                            'Cancel',
                                            style: GoogleFonts.lexendDeca(
                                                fontSize: size.iScreen(2.0),
                                                color: Colors.red,
                                                fontWeight: FontWeight.normal),
                                          ),
                                          isDefaultAction: true,
                                          onPressed: () {
                                            Navigator.pop(context, 'Cancel');
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            child: Card(
                              elevation: 5,
                              child: Container(
                                margin: EdgeInsets.only(bottom: size.iScreen(0.0)),
                                color: index % 2 == 0 ? Colors.grey.shade50 : Colors.grey.shade200,
                                child: ListTile(
                                  dense: true,
                                  visualDensity: VisualDensity.comfortable,
                                  leading: CircleAvatar(
                                    child: Text(
                                      '${_proformas['venNomCliente'].substring(0, 1)}',
                                      style: Theme.of(context).textTheme.subtitle1,
                                    ),
                                    backgroundColor: Colors.grey[300],
                                  ),
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: size.wScreen(50.0),
                                        child: Text(
                                          '${_proformas['venNomCliente']}',
                                          style: GoogleFonts.lexendDeca(fontWeight: FontWeight.normal),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Text(
                                        '${_proformas['venEstado']}',
                                        style: GoogleFonts.lexendDeca(
                                            fontSize: size.iScreen(1.5),
                                            color: _color,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  subtitle: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: size.wScreen(50.0),
                                            child: Text(
                                              '${_proformas['venNumFactura']}',
                                              style: GoogleFonts.lexendDeca(
                                                  fontSize: size.iScreen(1.5),
                                                  color: Colors.black54,
                                                  fontWeight: FontWeight.normal),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Container(
                                            width: size.wScreen(50.0),
                                            child: Text(
                                              _proformas['venFecReg'] != ''
                                                  ? '${_proformas['venFecReg'].replaceAll('T', "  ").replaceAll('.000Z', "  ")}'
                                                  : '--- --- ---',
                                              style: GoogleFonts.lexendDeca(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.normal),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        child: Text(
                                          '\$${_proformas['venTotal']}',
                                          style: GoogleFonts.lexendDeca(
                                              fontSize: size.iScreen(2.0),
                                              color: Colors.black87,
                                              fontWeight: FontWeight.normal),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Consumer<ProformasController>(
                            builder: (_, valueNext, __) {
                              return valueNext.getpage == null
                                  ? Container(
                                      margin: EdgeInsets.symmetric(vertical: size.iScreen(2.0)),
                                      child: Center(
                                        child: Text(
                                          'No existen más datos',
                                          style: GoogleFonts.lexendDeca(
                                              fontSize: size.iScreen(1.8),
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                    )
                                  : valueNext.getListaProformasPaginacion.length > 25
                                      ? Container(
                                          margin: EdgeInsets.symmetric(vertical: size.iScreen(2.0)),
                                          child: const Center(child: CircularProgressIndicator()),
                                        )
                                      : Container();
                            },
                          );
                        }
                      },
                    ),
                  );
                },
              ),
             
             
              // Contenido de Tab 2
               Consumer<ProformasController>(
                builder: (_, providersProformas, __) {
                  if (providersProformas.getErrorProformasPaginacion == null &&
                      providersProformas.getError401ProformasPaginacion == false) {
                    return Center(
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
                          SizedBox(
                            height: size.iScreen(1.0),
                          ),
                          const CircularProgressIndicator(),
                        ],
                      ),
                    );
                  } else if (providersProformas.getErrorProformasPaginacion == false) {
                    return const NoData(
                      label: 'No existen datos para mostrar',
                    );
                  } else if (providersProformas.getListaProformasPaginacion.isEmpty &&
                      providersProformas.getError401ProformasPaginacion == true) {
                    return const NoData(
                      label: 'Su sesión ha expirado, vuelva a iniciar sesión',
                    );
                  } else if (providersProformas.getListaProformasPaginacion.isEmpty &&
                      providersProformas.getError401ProformasPaginacion == false) {
                    return const NoData(
                      label: 'No existen datos para mostrar',
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () => onRefresh(),
                    child: ListView.builder(
                      controller: _scrollController,
                      physics: const BouncingScrollPhysics(),
                      itemCount: providersProformas.getListaProformasPaginacion.length + 1,
                      itemBuilder: (BuildContext context, int index) {
                        if (index < providersProformas.getListaProformasPaginacion.length) {
                          var _color;
                          final _proformas = providersProformas.getListaProformasPaginacion[index];

                          if (_proformas['venEstado'] == 'ACTIVA') {
                            _color = Colors.green;
                          } else if (_proformas['venEstado'] == 'SIN AUTORIZAR') {
                            _color = Colors.orange;
                          }
                          if (_proformas['venEstado'] == 'ANULADA') {
                            _color = Colors.red;
                          }

                          return Slidable(
                            startActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  backgroundColor: Colors.grey,
                                  foregroundColor: Colors.white,
                                  icon: Icons.list_alt_outlined,
                                  label: 'Más acciones',
                                  onPressed: (context) {
                                    showCupertinoModalPopup(
                                      context: context,
                                      builder: (BuildContext context) => CupertinoActionSheet(
                                        title: Text(
                                          'Acciones',
                                          style: GoogleFonts.lexendDeca(
                                              fontSize: size.iScreen(2.0),
                                              color: primaryColor,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        actions: <Widget>[
                                          CupertinoActionSheetAction(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(right: size.iScreen(2.0)),
                                                  child: Text(
                                                    'Ver PDF',
                                                    style: GoogleFonts.lexendDeca(
                                                        fontSize: size.iScreen(1.8),
                                                        color: Colors.black87,
                                                        fontWeight: FontWeight.normal),
                                                  ),
                                                ),
                                                const Icon(
                                                  FontAwesomeIcons.filePdf,
                                                  color: Colors.red,
                                                ),
                                              ],
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => ViewsPDFs(
                                                        infoPdf: 'https://syscontable.neitor.com/reportes/factura.php?codigo=${_proformas['venId']}&empresa=${_usuario!.rucempresa}',
                                                        labelPdf: 'infoFactura.pdf')),
                                              );
                                            },
                                          ),
                                        ],
                                        cancelButton: CupertinoActionSheetAction(
                                          child: Text(
                                            'Cancel',
                                            style: GoogleFonts.lexendDeca(
                                                fontSize: size.iScreen(2.0),
                                                color: Colors.red,
                                                fontWeight: FontWeight.normal),
                                          ),
                                          isDefaultAction: true,
                                          onPressed: () {
                                            Navigator.pop(context, 'Cancel');
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            child: Card(
                              elevation: 5,
                              child: Container(
                                margin: EdgeInsets.only(bottom: size.iScreen(0.0)),
                                color: index % 2 == 0 ? Colors.grey.shade50 : Colors.grey.shade200,
                                child: ListTile(
                                  dense: true,
                                  visualDensity: VisualDensity.comfortable,
                                  leading: CircleAvatar(
                                    child: Text(
                                      '${_proformas['venNomCliente'].substring(0, 1)}',
                                      style: Theme.of(context).textTheme.subtitle1,
                                    ),
                                    backgroundColor: Colors.grey[300],
                                  ),
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: size.wScreen(50.0),
                                        child: Text(
                                          '${_proformas['venNomCliente']}',
                                          style: GoogleFonts.lexendDeca(fontWeight: FontWeight.normal),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Text(
                                        '${_proformas['venEstado']}',
                                        style: GoogleFonts.lexendDeca(
                                            fontSize: size.iScreen(1.5),
                                            color: _color,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  subtitle: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: size.wScreen(50.0),
                                            child: Text(
                                              '${_proformas['venNumFactura']}',
                                              style: GoogleFonts.lexendDeca(
                                                  fontSize: size.iScreen(1.5),
                                                  color: Colors.black54,
                                                  fontWeight: FontWeight.normal),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Container(
                                            width: size.wScreen(50.0),
                                            child: Text(
                                              _proformas['venFecReg'] != ''
                                                  ? '${_proformas['venFecReg'].replaceAll('T', "  ").replaceAll('.000Z', "  ")}'
                                                  : '--- --- ---',
                                              style: GoogleFonts.lexendDeca(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.normal),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        child: Text(
                                          '\$${_proformas['venTotal']}',
                                          style: GoogleFonts.lexendDeca(
                                              fontSize: size.iScreen(2.0),
                                              color: Colors.black87,
                                              fontWeight: FontWeight.normal),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Consumer<ProformasController>(
                            builder: (_, valueNext, __) {
                              return valueNext.getpage == null
                                  ? Container(
                                      margin: EdgeInsets.symmetric(vertical: size.iScreen(2.0)),
                                      child: Center(
                                        child: Text(
                                          'No existen más datos',
                                          style: GoogleFonts.lexendDeca(
                                              fontSize: size.iScreen(1.8),
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                    )
                                  : valueNext.getListaProformasPaginacion.length > 25
                                      ? Container(
                                          margin: EdgeInsets.symmetric(vertical: size.iScreen(2.0)),
                                          child: const Center(child: CircularProgressIndicator()),
                                        )
                                      : Container();
                            },
                          );
                        }
                      },
                    ),
                  );
                },
              ),
             
            ],
          ),
        ),
      ],
    ),
  ),
),

          
           floatingActionButton: 
         FloatingActionButton(
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        //  final _ctrl =context.read<ComprobantesController>();

                        //       _ctrl.setTotal();
                        //       _ctrl.setTarifa({});
                        //        _ctrl.setTipoDocumento('');
                        //     Navigator.of(context).push(MaterialPageRoute(
                        //         builder: (context) =>
                        //             const CrearComprobante(
                        //               tipo: 'CREATE',
                        //             )));

                             final _ctrl =context.read<ComprobantesController>();
                              _ctrl.resetListasProdutos();
                              _ctrl.resetPlacas();
                                _ctrl.setDocumento('');
                                 _ctrl.setClienteComprbante({});
                              _ctrl.setTotal();
                              _ctrl.setTarifa({});
                               _ctrl.setTipoDocumento('');
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const CrearComprobante(
                                      tipo: 'CREATE',
                                    )));

                       
                      }
                  
            ,
          ),
          
          
          
          ),
    );
  }

  Future<void> onRefresh() async {
    final _controller = Provider.of<ProformasController>(context, listen: false);
    _controller.setPage(0);
    _controller.setCantidad(25);
    _controller.buscaAllProformasPaginacion('', true,_controller.getTabIndex);
  }
}

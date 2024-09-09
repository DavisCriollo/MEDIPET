import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neitorcont/src/api/authentication_client.dart';
import 'package:neitorcont/src/controllers/notas_creditos_controller.dart';
import 'package:neitorcont/src/controllers/prefacturas_controller.dart';

import 'package:neitorcont/src/controllers/proformas_controller.dart';

import 'package:neitorcont/src/models/sesison_model.dart';
import 'package:neitorcont/src/pages/views_pdf.dart';
import 'package:neitorcont/src/services/notifications_service.dart';
import 'package:neitorcont/src/services/socket_service.dart';
import 'package:neitorcont/src/theme/themes_app.dart';
import 'package:neitorcont/src/utils/responsive.dart';
import 'package:neitorcont/src/utils/theme.dart';
import 'package:neitorcont/src/widgets/no_data.dart';
import 'package:provider/provider.dart';

class ListarNotasCreditoPaginacion extends StatefulWidget {
  const ListarNotasCreditoPaginacion({Key? key}) : super(key: key);

  @override
  State<ListarNotasCreditoPaginacion> createState() => _ListarNotasCreditoPaginacionState();
}

class _ListarNotasCreditoPaginacionState extends State<ListarNotasCreditoPaginacion> {
  final TextEditingController _textSearchController = TextEditingController();
  Session? _usuario;
   final _scrollController = ScrollController();

  @override
  void initState() {

 _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
       
        final _next = context.read<NotasCreditosController>();
        if (_next.getpage != null) {
          _next.setPage(_next.getpage);
          //       providerSearchPropietario.setCantidad(25);
          _next.buscaAllNotasCreditosPaginacion('', false,_next.getTabIndex);
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
    final loadInfo = context.read<NotasCreditosController>();
    // Provider.of<PropietariosController>(context, listen: false);
    // await loadInfo.buscaAllNotasCreditos('');

    // final serviceSocket = context.read<SocketService>();
    // serviceSocket.socket!.on('server:guardadoExitoso', (data) async {
    //   if (data['tabla'] == 'notascredito') {
    //     loadInfo.buscaAllNotasCreditosPaginacion('',false,loadInfo.getTabIndex);
    //     // NotificatiosnService.showSnackBarSuccsses(data['msg']);
    //   }
    // });
    // serviceSocket.socket!.on('server:actualizadoExitoso', (data) async {
    //   if (data['tabla'] == 'notascredito') {
    //     loadInfo.buscaAllNotasCreditosPaginacion('',false,loadInfo.getTabIndex);
    //     // NotificatiosnService.showSnackBarSuccsses(data['msg']);
    //   }
    // });
    // serviceSocket.socket!.on('server:eliminadoExitoso', (data) async {
    //   if (data['tabla'] == 'notascredito') {
    //     loadInfo.buscaAllNotasCreditosPaginacion('',false,loadInfo.getTabIndex);
    //     // NotificatiosnService.showSnackBarSuccsses(data['msg']);
    //   }
    // });
    // serviceSocket.socket?.on('server:error', (data) {
    //   NotificatiosnService.showSnackBarError(data['msg']);
    // });
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
          
            title: Consumer<NotasCreditosController>(
              builder: (_, providerSearchNotasCredito, __) {
                return Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: size.iScreen(0.1)),
                        child: (providerSearchNotasCredito
                                .btnSearchNotasCreditoPaginacion)
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

                                             providerSearchNotasCredito.search(text);

                                            // providerSearchNotasCredito
                                            //     .onSearchTextNotasCreditoPaginacion(
                                            //         text);

                                            // if (providerSearchNotasCredito
                                            //     .nameSearchNotasCreditoPaginacion
                                            //     .isEmpty) {
                                            //   //                 providerSearchNotasCredito
                                            //   //     .setErrorMascotasPaginacion(null);

                                            //   // providerSearchNotasCredito
                                            //   //     .setError401MascotasPaginacion(
                                            //   //         false);
                                            //   providerSearchNotasCredito.setPage(0);
                                            //   providerSearchNotasCredito
                                            //       .setCantidad(25);
                                            //   // providerSearchNotasCredito.setIsNext(false);
                                            //   providerSearchNotasCredito
                                            //       .buscaAllNotasCreditosPaginacion(
                                            //           '', true,providerSearchNotasCredito.getTabIndex);

                                           
                                            // }

                                            // // setState(() {});
                                          },
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Buscar...',
                                      
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
                                  'Notas de Creditos',
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
                        providerSearchNotasCredito.btnSearchNotasCreditoPaginacion
                            ? IconButton(
                                splashRadius: size.iScreen(3.0),
                                icon: Icon(
                                  Icons.search,
                                  size: size.iScreen(3.5),
                                  // color: Colors.white,
                                ),
                                onPressed: () {
                                  //=====================//
                                  if (providerSearchNotasCredito
                                          .nameSearchNotasCreditoPaginacion.length >=
                                      3) {
                                    providerSearchNotasCredito
                                        .setErrorNotasCreditosPaginacion(null);

                                    providerSearchNotasCredito
                                        .setError401NotasCreditosPaginacion(false);
                                    providerSearchNotasCredito.setPage(0);
                                    providerSearchNotasCredito.setCantidad(25);

                                    providerSearchNotasCredito
                                        .buscaAllNotasCreditosPaginacion(
                                            // '0803395581');
                                            ' ${providerSearchNotasCredito.nameSearchNotasCreditoPaginacion}',
                                            true,providerSearchNotasCredito.getTabIndex);
                                  } else {
                                    print('NO HAACE NADA');
                                  }
                                })
                            : Container(),
                        IconButton(
                            splashRadius: 2.0,
                            icon: (!providerSearchNotasCredito
                                    .btnSearchNotasCreditoPaginacion)
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
                              providerSearchNotasCredito
                                  .onSearchTextNotasCreditoPaginacion("");
                              _textSearchController.text = '';

                              providerSearchNotasCredito
                                  .setBtnSearchNotasCreditoPaginacion(
                                      !providerSearchNotasCredito
                                          .btnSearchNotasCreditoPaginacion);

                              if (providerSearchNotasCredito
                                      .btnSearchNotasCreditoPaginacion ==
                                  false) {
                                //=====================//
                                providerSearchNotasCredito
                                    .setErrorNotasCreditosPaginacion(null);

                                providerSearchNotasCredito
                                    .setError401NotasCreditosPaginacion(false);

                                providerSearchNotasCredito.setPage(0);
                                providerSearchNotasCredito.setCantidad(25);
                                providerSearchNotasCredito
                                    .buscaAllNotasCreditosPaginacion('', true,providerSearchNotasCredito.getTabIndex);
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
          
          
         
          body:Container(
  color: Colors.grey.shade100,
  width: size.wScreen(100.0),
  height: size.hScreen(100.0),
  padding: EdgeInsets.only(
    top: size.iScreen(0.0),
    right: size.iScreen(0.0),
    left: size.iScreen(0.0),
  ),
  child: DefaultTabController(
    length: 2, // Número de tabs
    child: Column(
      children: [
        // TabBar
        TabBar(
          tabs: [
                 Tab(
              child:
              Consumer<NotasCreditosController>(builder: (_, valueHoy, __) {  
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
              Consumer<NotasCreditosController>(builder: (_, valueAnteriores, __) {  
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
            final ctrl=context.read<NotasCreditosController>();
                        print('EL INDICE :$index');
                       ctrl.setTabIndex(index);
                        if (  index==0) {
                          ctrl. setInfoBusquedaNotasCreditosPaginacion([]);
                          ctrl.resetValorTotal();
                            // ctrl.buscaAllNotasCreditosPaginacion(
                            //     '',false,ctrl.getTabIndex);
                             final _controllerNotasCredito =
                                context.read<NotasCreditosController>();

                            _controllerNotasCredito
                                .onSearchTextNotasCreditoPaginacion("");

                            _controllerNotasCredito
                                .setBtnSearchNotasCreditoPaginacion(false);
                            _controllerNotasCredito
                                .setErrorNotasCreditosPaginacion(null);

                            _controllerNotasCredito
                                .setError401NotasCreditosPaginacion(false);

                            _controllerNotasCredito.resetFormNotasCreditos();
                            _controllerNotasCredito.setPage(0);
                            _controllerNotasCredito.setIsNext(false);
                            _controllerNotasCredito
                                .setInfoBusquedaNotasCreditosPaginacion([]);
                            _controllerNotasCredito.buscaAllNotasCreditosPaginacion(
                                '', true,_controllerNotasCredito.getTabIndex);



                        }
                        if ( index==1) {
                           ctrl.setInfoBusquedaNotasCreditosPaginacion([]);
                           ctrl.resetValorTotal();
                             ctrl.buscaAllNotasCreditosPaginacion(
                                '',false,ctrl.getTabIndex);
                        }
                      },
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.blue,
      
        ),
        // TabBarView
        Expanded(
          child: TabBarView(
            children: [

                 Consumer<NotasCreditosController>(
                        builder: (_, provider, __) {
                         
                         if (provider.allItemsFilters.isEmpty) {
                            return const NoData(
                              label: 'No existen datos para mostar',
                            );
                            // Text("sin datos");
                          }

                          return 
                          
                          (provider.allItemsFilters.isEmpty)
                                        ? Center(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              
                                              CircularProgressIndicator(),
                                              Text('Por favor espere ....')
                                            ],
                                          ))
                                        : (provider.allItemsFilters.length > 0)
                                            ?
                                             RefreshIndicator(
                    onRefresh: () => onRefresh(),
                    child: ListView.builder(
                      controller: _scrollController,
                      physics: const BouncingScrollPhysics(),
                      itemCount: provider.allItemsFilters.length + 1,
                      itemBuilder: (BuildContext context, int index) {
                        if (index < provider.allItemsFilters.length) {
                          var _color;
                          final _notasCredito = provider.allItemsFilters[index];

                          if (_notasCredito['venEstado'] == 'AUTORIZADO') {
                            _color = Colors.green;
                          } else if (_notasCredito['venEstado'] == 'SIN AUTORIZAR') {
                            _color = Colors.orange;
                          } else if (_notasCredito['venEstado'] == 'ANULADA') {
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
                                            fontWeight: FontWeight.normal,
                                          ),
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
                                                      fontWeight: FontWeight.normal,
                                                    ),
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
                                                    infoPdf: 'https://syscontable.neitor.com/reportes/factura.php?codigo=${_notasCredito['venId']}&empresa=${_usuario!.rucempresa}',
                                                    labelPdf: 'infoFactura.pdf',
                                                  ),
                                                ),
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
                                              fontWeight: FontWeight.normal,
                                            ),
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
                                      '${_notasCredito['venNomCliente'].substring(0, 1)}',
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
                                          '${_notasCredito['venNomCliente']}',
                                          style: GoogleFonts.lexendDeca(fontWeight: FontWeight.normal),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Text(
                                        '${_notasCredito['venEstado']}',
                                        style: GoogleFonts.lexendDeca(
                                          fontSize: size.iScreen(1.5),
                                          color: _color,
                                          fontWeight: FontWeight.bold,
                                        ),
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
                                              '${_notasCredito["venNumFactura"]}',
                                              style: GoogleFonts.lexendDeca(
                                                fontSize: size.iScreen(1.5),
                                                color: Colors.black54,
                                                fontWeight: FontWeight.normal,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Container(
                                            width: size.wScreen(50.0),
                                            child: Text(
                                              _notasCredito['venFecReg'] != ''
                                                  ? '${_notasCredito['venFecReg'].replaceAll('T', "  ").replaceAll('.000Z', "  ")}'
                                                  : '--- --- ---',
                                              style: GoogleFonts.lexendDeca(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        child: Text(
                                          '\$${_notasCredito['venTotal']}',
                                          style: GoogleFonts.lexendDeca(
                                            fontSize: size.iScreen(2.0),
                                            color: Colors.black87,
                                            fontWeight: FontWeight.normal,
                                          ),
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
                          return Consumer<NotasCreditosController>(
                            builder: (_, valueNext, __) {
                              return valueNext.getpage == null
                                  ? Container(
                                      margin: EdgeInsets.symmetric(vertical: size.iScreen(2.0)),
                                      child: Center(
                                        child: Text(
                                          'No existen más datos',
                                          style: GoogleFonts.lexendDeca(
                                            fontSize: size.iScreen(1.8),
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    )
                                  : valueNext.getListaNotasCreditosPaginacion.length > 25
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
                  )
                          //  RefreshIndicator(
                          //    onRefresh: () => onRefresh(),
                          //   child: ListView.builder(
                          //     controller: _scrollController,
                          //     physics: const BouncingScrollPhysics(),
                          //     itemCount: provider
                          //             .allItemsFilters.length +
                          //         1,
                          //     itemBuilder: (BuildContext context, int index) {
                          //       if (index <
                          //           provider
                          //               .allItemsFilters.length) {
                          //         var _color;
                          //         final _prefacturas = provider
                          //             .allItemsFilters[index];
                          
                          //         if (_prefacturas['venEstado'] == 'AUTORIZADO') {
                          //           _color = Colors.green;
                          //         } else if (_prefacturas['venEstado'] ==
                          //             'SIN AUTORIZAR') {
                          //           _color = Colors.orange;
                          //         }
                          //         if (_prefacturas['venEstado'] == 'ANULADA') {
                          //           _color = Colors.red;
                          //         }
                          
                          //         return Slidable(
                          //           startActionPane: ActionPane(
                          //             // A motion is a widget used to control how the pane animates.
                          //             motion: const ScrollMotion(),
                          
                          //             children: [
                          //               SlidableAction(
                          //                     backgroundColor: Colors.grey,
                          //                 foregroundColor: Colors.white,
                          //                 icon: Icons.list_alt_outlined,
                          //                 label: 'Más acciones',
                          //                 onPressed: (context) {
                          //                   showCupertinoModalPopup(
                          //                     context: context,
                          //                     builder: (BuildContext context) =>
                          //                         CupertinoActionSheet(
                          //                             title: Text(
                          //                               'Acciones',
                          //                               style: GoogleFonts
                          //                                   .lexendDeca(
                          //                                       fontSize: size
                          //                                           .iScreen(2.0),
                          //                                       color:
                          //                                           primaryColor,
                          //                                       fontWeight:
                          //                                           FontWeight
                          //                                               .normal),
                          //                             ),
                          //                             // message: const Text('Your options are '),
                          //                             actions: <Widget>[
                          //                               CupertinoActionSheetAction(
                          //                                 child: Row(
                          //                                   mainAxisAlignment:
                          //                                       MainAxisAlignment
                          //                                           .center,
                          //                                   children: [
                          //                                     Container(
                          //                                       margin: EdgeInsets.only(
                          //                                           right: size
                          //                                               .iScreen(
                          //                                                   2.0)),
                          //                                       child: Text(
                          //                                         'Ver PDF',
                          //                                         style: GoogleFonts.lexendDeca(
                          //                                             fontSize: size
                          //                                                 .iScreen(
                          //                                                     1.8),
                          //                                             color: Colors
                          //                                                 .black87,
                          //                                             fontWeight:
                          //                                                 FontWeight
                          //                                                     .normal),
                          //                                       ),
                          //                                     ),
                          //                                     const Icon(
                          //                                       FontAwesomeIcons
                          //                                           .filePdf,
                          //                                       color: Colors.red,
                          //                                     )
                          //                                   ],
                          //                                 ),
                          //                                 onPressed: () {
                          //                                   Navigator.pop(
                          //                                       context);
                          
                          //                                   Navigator.push(
                          //                                     context,
                          //                                     MaterialPageRoute(
                          //                                         builder: (context) =>
                          //                                             ViewsPDFs(
                          //                                                 infoPdf:
                          //                                                     // 'https://sysvet.neitor.com/reportes/carnet.php?id=${factura['venId']}&empresa=${_usuario!.rucempresa}',
                          //                                                     'https://syscontable.neitor.com/reportes/factura.php?codigo=${_prefacturas['venId']}&empresa=${_usuario!.rucempresa}',
                          //                                                 labelPdf:
                          //                                                     'infoFactura.pdf')),
                          //                                   );
                          //                                 },
                          //                               ),
                          //                             ],
                          //                             cancelButton:
                          //                                 CupertinoActionSheetAction(
                          //                               child: Text('Cancel',
                          //                                   style: GoogleFonts
                          //                                       .lexendDeca(
                          //                                           fontSize: size
                          //                                               .iScreen(
                          //                                                   2.0),
                          //                                           color: Colors
                          //                                               .red,
                          //                                           fontWeight:
                          //                                               FontWeight
                          //                                                   .normal)),
                          //                               isDefaultAction: true,
                          //                               onPressed: () {
                          //                                 Navigator.pop(
                          //                                     context, 'Cancel');
                          //                               },
                          //                             )),
                          //                   );
                          //                 },
                          //               ),
                          //             ],
                          //           ),
                          //           child: Card(
                          //             elevation: 5,
                          //             child: Container(
                          //               margin: EdgeInsets.only(
                          //                   bottom: size.iScreen(0.0)),
                          //               color: index % 2 == 0
                          //                   ? Colors.grey.shade50
                          //                   : Colors.grey.shade200,
                          //               child: ListTile(
                          //                 dense: true,
                          //                 visualDensity:
                          //                     VisualDensity.comfortable,
                                      
                          //                  leading: CircleAvatar(
                          //                   child: Text(
                          //                      '${_prefacturas['venNomCliente'].substring(0, 1)}',
                          //                     style: Theme.of(context)
                          //                         .textTheme
                          //                         .subtitle1,
                          //                   ),
                          //                   backgroundColor: Colors.grey[300],
                          //                 ),
                          //                 title: Row(
                          //                   mainAxisAlignment:
                          //                       MainAxisAlignment.spaceBetween,
                          //                   children: [
                          //                     SizedBox(
                          //                       width: size.wScreen(40.0),
                          //                       child: Text(
                          //                         '${_prefacturas['venNomCliente']}',
                          //                         style: GoogleFonts.lexendDeca(
                          //                             // fontSize: size.iScreen(2.45),
                          //                             // color: Colors.white,
                          //                             fontWeight:
                          //                                 FontWeight.normal),
                          //                         overflow: TextOverflow.ellipsis,
                          //                       ),
                          //                     ),
                          //                     Text(
                          //                       '${_prefacturas['venEstado']}',
                          //                       // 'Estado: ',
                          //                       style: GoogleFonts.lexendDeca(
                          //                           fontSize: size.iScreen(1.5),
                          //                           color: _color,
                          //                           fontWeight: FontWeight.bold),
                          //                     ),
                          //                   ],
                          //                 ),
                          //                 subtitle: Row(
                          //                   mainAxisAlignment:
                          //                       MainAxisAlignment.spaceBetween,
                          //                   children: [
                          //                     Column(
                          //                       mainAxisAlignment:
                          //                           MainAxisAlignment.start,
                          //                       children: [
                          //                         Container(
                          //                           // color: Colors.green,
                          //                           width: size.wScreen(50.0),
                          //                           child: Text(
                          //                             '${_prefacturas['venNumFactura']}',
                          //                             style:
                          //                                 GoogleFonts.lexendDeca(
                          //                                     fontSize: size
                          //                                         .iScreen(1.5),
                          //                                     color:
                          //                                         Colors.black54,
                          //                                     fontWeight:
                          //                                         FontWeight
                          //                                             .normal),
                          //                             overflow:
                          //                                 TextOverflow.ellipsis,
                          //                           ),
                          //                         ),
                          //                         Container(
                          //                           // color: Colors.green,
                          //                           width: size.wScreen(50.0),
                          //                           child: Text(
                          //                             _prefacturas['venFecReg'] !=
                          //                                     ''
                          //                                 ? '${_prefacturas['venFecReg'].replaceAll('T', "  ").replaceAll('.000Z', "  ")}'
                          //                                 : '--- --- ---',
                          //                             style:
                          //                                 GoogleFonts.lexendDeca(
                          //                                     // fontSize: size.iScreen(2.45),
                          //                                     color: Colors.grey,
                          //                                     fontWeight:
                          //                                         FontWeight
                          //                                             .normal),
                          //                           ),
                          //                         ),
                          //                       ],
                          //                     ),
                          //                     Container(
                          //                       // color: Colors.green,
                          //                       // width: size.wScreen(100.0),
                          //                       child: Text(
                          //                         '\$${_prefacturas['venTotal']}',
                          //                         style: GoogleFonts.lexendDeca(
                          //                             fontSize: size.iScreen(2.0),
                          //                             color: Colors.black87,
                          //                             fontWeight:
                          //                                 FontWeight.normal),
                          //                         overflow: TextOverflow.ellipsis,
                          //                       ),
                          //                     ),
                          //                   ],
                          //                 ),
                          //                 // trailing: Icon(Icons.more_vert),
                          //               ),
                          //             ),
                          //           ),
                          //         );
                          //       } else {
                          //         return Consumer<PreFacturasController>(
                          //           builder: (_, valueNext, __) {
                          //             return valueNext.getpage == null
                          //                 ? Container(
                          //                     margin: EdgeInsets.symmetric(
                          //                         vertical: size.iScreen(2.0)),
                          //                     child: Center(
                          //                       child: Text(
                          //                         'No existen más datos',
                          //                         style: GoogleFonts.lexendDeca(
                          //                             fontSize: size.iScreen(1.8),
                          //                             // color: primaryColor,
                          //                             fontWeight:
                          //                                 FontWeight.normal),
                          //                       ),
                          //                     ))
                          //                 // : Container();
                          
                          //                 : provider.allItemsFilters.length > 25
                          //                     ? Container(
                          //                         margin: EdgeInsets.symmetric(
                          //                             vertical:
                          //                                 size.iScreen(2.0)),
                          //                         child: const Center(
                          //                             child:
                          //                                 CircularProgressIndicator()))
                          //                     : Container();
                          //           },
                          //         );
                          //       }
                          //     },
                          //   ),
                          // )
                          
                          
                          
                          : const NoData(
                              label: 'No existen datos para mostar',
                            );

                        },
                      ),
                     
 
              




              // Primer tab
              // Consumer<NotasCreditosController>(
              //   builder: (_, providersNotasCreditos, __) {
              //     if (providersNotasCreditos.getErrorNotasCreditosPaginacion == null &&
              //         providersNotasCreditos.getError401NotasCreditosPaginacion == false) {
              //       return Center(
              //         child: Column(
              //           mainAxisSize: MainAxisSize.min,
              //           children: [
              //             Text(
              //               'Cargando Datos...',
              //               style: GoogleFonts.lexendDeca(
              //                 fontSize: size.iScreen(1.5),
              //                 color: Colors.black87,
              //                 fontWeight: FontWeight.bold,
              //               ),
              //             ),
              //             SizedBox(height: size.iScreen(1.0)),
              //             const CircularProgressIndicator(),
              //           ],
              //         ),
              //       );
              //     } else if (providersNotasCreditos.getErrorNotasCreditosPaginacion == false) {
              //       return const NoData(label: 'No existen datos para mostrar');
              //     } else if (providersNotasCreditos.getListaNotasCreditosPaginacion.isEmpty &&
              //         providersNotasCreditos.getErrorNotasCreditosPaginacion == false) {
              //       return const NoData(label: 'No existen datos para mostrar');
              //     } else if (providersNotasCreditos.getListaNotasCreditosPaginacion.isEmpty &&
              //         providersNotasCreditos.getError401NotasCreditosPaginacion == true) {
              //       return const NoData(label: 'Su sesión ha expirado, vuelva a iniciar sesión');
              //     } else if (providersNotasCreditos.getListaNotasCreditosPaginacion.isEmpty &&
              //         providersNotasCreditos.getError401NotasCreditosPaginacion == false) {
              //       return const NoData(label: 'No existen datos para mostrar');
              //     }

              //     return 
              // RefreshIndicator(
              //       onRefresh: () => onRefresh(),
              //       child: ListView.builder(
              //         controller: _scrollController,
              //         physics: const BouncingScrollPhysics(),
              //         itemCount: providersNotasCreditos.getListaNotasCreditosPaginacion.length + 1,
              //         itemBuilder: (BuildContext context, int index) {
              //           if (index < providersNotasCreditos.getListaNotasCreditosPaginacion.length) {
              //             var _color;
              //             final _notasCredito = providersNotasCreditos.getListaNotasCreditosPaginacion[index];

              //             if (_notasCredito['venEstado'] == 'AUTORIZADO') {
              //               _color = Colors.green;
              //             } else if (_notasCredito['venEstado'] == 'SIN AUTORIZAR') {
              //               _color = Colors.orange;
              //             } else if (_notasCredito['venEstado'] == 'ANULADA') {
              //               _color = Colors.red;
              //             }

              //             return Slidable(
              //               startActionPane: ActionPane(
              //                 motion: const ScrollMotion(),
              //                 children: [
              //                   SlidableAction(
              //                     backgroundColor: Colors.grey,
              //                     foregroundColor: Colors.white,
              //                     icon: Icons.list_alt_outlined,
              //                     label: 'Más acciones',
              //                     onPressed: (context) {
              //                       showCupertinoModalPopup(
              //                         context: context,
              //                         builder: (BuildContext context) => CupertinoActionSheet(
              //                           title: Text(
              //                             'Acciones',
              //                             style: GoogleFonts.lexendDeca(
              //                               fontSize: size.iScreen(2.0),
              //                               color: primaryColor,
              //                               fontWeight: FontWeight.normal,
              //                             ),
              //                           ),
              //                           actions: <Widget>[
              //                             CupertinoActionSheetAction(
              //                               child: Row(
              //                                 mainAxisAlignment: MainAxisAlignment.center,
              //                                 children: [
              //                                   Container(
              //                                     margin: EdgeInsets.only(right: size.iScreen(2.0)),
              //                                     child: Text(
              //                                       'Ver PDF',
              //                                       style: GoogleFonts.lexendDeca(
              //                                         fontSize: size.iScreen(1.8),
              //                                         color: Colors.black87,
              //                                         fontWeight: FontWeight.normal,
              //                                       ),
              //                                     ),
              //                                   ),
              //                                   const Icon(
              //                                     FontAwesomeIcons.filePdf,
              //                                     color: Colors.red,
              //                                   ),
              //                                 ],
              //                               ),
              //                               onPressed: () {
              //                                 Navigator.pop(context);
              //                                 Navigator.push(
              //                                   context,
              //                                   MaterialPageRoute(
              //                                     builder: (context) => ViewsPDFs(
              //                                       infoPdf: 'https://syscontable.neitor.com/reportes/factura.php?codigo=${_notasCredito['venId']}&empresa=${_usuario!.rucempresa}',
              //                                       labelPdf: 'infoFactura.pdf',
              //                                     ),
              //                                   ),
              //                                 );
              //                               },
              //                             ),
              //                           ],
              //                           cancelButton: CupertinoActionSheetAction(
              //                             child: Text(
              //                               'Cancel',
              //                               style: GoogleFonts.lexendDeca(
              //                                 fontSize: size.iScreen(2.0),
              //                                 color: Colors.red,
              //                                 fontWeight: FontWeight.normal,
              //                               ),
              //                             ),
              //                             isDefaultAction: true,
              //                             onPressed: () {
              //                               Navigator.pop(context, 'Cancel');
              //                             },
              //                           ),
              //                         ),
              //                       );
              //                     },
              //                   ),
              //                 ],
              //               ),
              //               child: Card(
              //                 elevation: 5,
              //                 child: Container(
              //                   margin: EdgeInsets.only(bottom: size.iScreen(0.0)),
              //                   color: index % 2 == 0 ? Colors.grey.shade50 : Colors.grey.shade200,
              //                   child: ListTile(
              //                     dense: true,
              //                     visualDensity: VisualDensity.comfortable,
              //                     leading: CircleAvatar(
              //                       child: Text(
              //                         '${_notasCredito['venNomCliente'].substring(0, 1)}',
              //                         style: Theme.of(context).textTheme.subtitle1,
              //                       ),
              //                       backgroundColor: Colors.grey[300],
              //                     ),
              //                     title: Row(
              //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                       children: [
              //                         SizedBox(
              //                           width: size.wScreen(50.0),
              //                           child: Text(
              //                             '${_notasCredito['venNomCliente']}',
              //                             style: GoogleFonts.lexendDeca(fontWeight: FontWeight.normal),
              //                             overflow: TextOverflow.ellipsis,
              //                           ),
              //                         ),
              //                         Text(
              //                           '${_notasCredito['venEstado']}',
              //                           style: GoogleFonts.lexendDeca(
              //                             fontSize: size.iScreen(1.5),
              //                             color: _color,
              //                             fontWeight: FontWeight.bold,
              //                           ),
              //                         ),
              //                       ],
              //                     ),
              //                     subtitle: Row(
              //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                       children: [
              //                         Column(
              //                           mainAxisAlignment: MainAxisAlignment.start,
              //                           children: [
              //                             Container(
              //                               width: size.wScreen(50.0),
              //                               child: Text(
              //                                 '${_notasCredito['venNum_notasCredito']}',
              //                                 style: GoogleFonts.lexendDeca(
              //                                   fontSize: size.iScreen(1.5),
              //                                   color: Colors.black54,
              //                                   fontWeight: FontWeight.normal,
              //                                 ),
              //                                 overflow: TextOverflow.ellipsis,
              //                               ),
              //                             ),
              //                             Container(
              //                               width: size.wScreen(50.0),
              //                               child: Text(
              //                                 _notasCredito['venFecReg'] != ''
              //                                     ? '${_notasCredito['venFecReg'].replaceAll('T', "  ").replaceAll('.000Z', "  ")}'
              //                                     : '--- --- ---',
              //                                 style: GoogleFonts.lexendDeca(
              //                                   color: Colors.grey,
              //                                   fontWeight: FontWeight.normal,
              //                                 ),
              //                               ),
              //                             ),
              //                           ],
              //                         ),
              //                         Container(
              //                           child: Text(
              //                             '\$${_notasCredito['venTotal']}',
              //                             style: GoogleFonts.lexendDeca(
              //                               fontSize: size.iScreen(2.0),
              //                               color: Colors.black87,
              //                               fontWeight: FontWeight.normal,
              //                             ),
              //                             overflow: TextOverflow.ellipsis,
              //                           ),
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //             );
              //           } else {
              //             return Consumer<NotasCreditosController>(
              //               builder: (_, valueNext, __) {
              //                 return valueNext.getpage == null
              //                     ? Container(
              //                         margin: EdgeInsets.symmetric(vertical: size.iScreen(2.0)),
              //                         child: Center(
              //                           child: Text(
              //                             'No existen más datos',
              //                             style: GoogleFonts.lexendDeca(
              //                               fontSize: size.iScreen(1.8),
              //                               fontWeight: FontWeight.normal,
              //                             ),
              //                           ),
              //                         ),
              //                       )
              //                     : valueNext.getListaNotasCreditosPaginacion.length > 25
              //                         ? Container(
              //                             margin: EdgeInsets.symmetric(vertical: size.iScreen(2.0)),
              //                             child: const Center(child: CircularProgressIndicator()),
              //                           )
              //                         : Container();
              //               },
              //             );
              //           }
              //         },
              //       ),
              //     );
              //   },
              // ),






              // Segundo tab

               Consumer<NotasCreditosController>(
                        builder: (_, provider, __) {
                         
                         if (provider.allItemsFilters.isEmpty) {
                            return const NoData(
                              label: 'No existen datos para mostar',
                            );
                            // Text("sin datos");
                          }

                          return 
                          
                          (provider.allItemsFilters.isEmpty)
                                        ? Center(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              
                                              CircularProgressIndicator(),
                                              Text('Por favor espere ....')
                                            ],
                                          ))
                                        : (provider.allItemsFilters.length > 0)
                                            ?
                                             RefreshIndicator(
                    onRefresh: () => onRefresh(),
                    child: ListView.builder(
                      controller: _scrollController,
                      physics: const BouncingScrollPhysics(),
                      itemCount: provider.allItemsFilters.length + 1,
                      itemBuilder: (BuildContext context, int index) {
                        if (index < provider.allItemsFilters.length) {
                          var _color;
                          final _notasCredito = provider.allItemsFilters[index];

                          if (_notasCredito['venEstado'] == 'AUTORIZADO') {
                            _color = Colors.green;
                          } else if (_notasCredito['venEstado'] == 'SIN AUTORIZAR') {
                            _color = Colors.orange;
                          } else if (_notasCredito['venEstado'] == 'ANULADA') {
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
                                            fontWeight: FontWeight.normal,
                                          ),
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
                                                      fontWeight: FontWeight.normal,
                                                    ),
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
                                                    infoPdf: 'https://syscontable.neitor.com/reportes/factura.php?codigo=${_notasCredito['venId']}&empresa=${_usuario!.rucempresa}',
                                                    labelPdf: 'infoFactura.pdf',
                                                  ),
                                                ),
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
                                              fontWeight: FontWeight.normal,
                                            ),
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
                                      '${_notasCredito['venNomCliente'].substring(0, 1)}',
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
                                          '${_notasCredito['venNomCliente']}',
                                          style: GoogleFonts.lexendDeca(fontWeight: FontWeight.normal),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Text(
                                        '${_notasCredito['venEstado']}',
                                        style: GoogleFonts.lexendDeca(
                                          fontSize: size.iScreen(1.5),
                                          color: _color,
                                          fontWeight: FontWeight.bold,
                                        ),
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
                                              '${_notasCredito['venNumFactura']}',
                                              style: GoogleFonts.lexendDeca(
                                                fontSize: size.iScreen(1.5),
                                                color: Colors.black54,
                                                fontWeight: FontWeight.normal,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Container(
                                            width: size.wScreen(50.0),
                                            child: Text(
                                              _notasCredito['venFecReg'] != ''
                                                  ? '${_notasCredito['venFecReg'].replaceAll('T', "  ").replaceAll('.000Z', "  ")}'
                                                  : '--- --- ---',
                                              style: GoogleFonts.lexendDeca(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        child: Text(
                                          '\$${_notasCredito['venTotal']}',
                                          style: GoogleFonts.lexendDeca(
                                            fontSize: size.iScreen(2.0),
                                            color: Colors.black87,
                                            fontWeight: FontWeight.normal,
                                          ),
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
                          return Consumer<NotasCreditosController>(
                            builder: (_, valueNext, __) {
                              return valueNext.getpage == null
                                  ? Container(
                                      margin: EdgeInsets.symmetric(vertical: size.iScreen(2.0)),
                                      child: Center(
                                        child: Text(
                                          'No existen más datos',
                                          style: GoogleFonts.lexendDeca(
                                            fontSize: size.iScreen(1.8),
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    )
                                  : valueNext.getListaNotasCreditosPaginacion.length > 25
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
                  )
                          //  RefreshIndicator(
                          //    onRefresh: () => onRefresh(),
                          //   child: ListView.builder(
                          //     controller: _scrollController,
                          //     physics: const BouncingScrollPhysics(),
                          //     itemCount: provider
                          //             .allItemsFilters.length +
                          //         1,
                          //     itemBuilder: (BuildContext context, int index) {
                          //       if (index <
                          //           provider
                          //               .allItemsFilters.length) {
                          //         var _color;
                          //         final _prefacturas = provider
                          //             .allItemsFilters[index];
                          
                          //         if (_prefacturas['venEstado'] == 'AUTORIZADO') {
                          //           _color = Colors.green;
                          //         } else if (_prefacturas['venEstado'] ==
                          //             'SIN AUTORIZAR') {
                          //           _color = Colors.orange;
                          //         }
                          //         if (_prefacturas['venEstado'] == 'ANULADA') {
                          //           _color = Colors.red;
                          //         }
                          
                          //         return Slidable(
                          //           startActionPane: ActionPane(
                          //             // A motion is a widget used to control how the pane animates.
                          //             motion: const ScrollMotion(),
                          
                          //             children: [
                          //               SlidableAction(
                          //                     backgroundColor: Colors.grey,
                          //                 foregroundColor: Colors.white,
                          //                 icon: Icons.list_alt_outlined,
                          //                 label: 'Más acciones',
                          //                 onPressed: (context) {
                          //                   showCupertinoModalPopup(
                          //                     context: context,
                          //                     builder: (BuildContext context) =>
                          //                         CupertinoActionSheet(
                          //                             title: Text(
                          //                               'Acciones',
                          //                               style: GoogleFonts
                          //                                   .lexendDeca(
                          //                                       fontSize: size
                          //                                           .iScreen(2.0),
                          //                                       color:
                          //                                           primaryColor,
                          //                                       fontWeight:
                          //                                           FontWeight
                          //                                               .normal),
                          //                             ),
                          //                             // message: const Text('Your options are '),
                          //                             actions: <Widget>[
                          //                               CupertinoActionSheetAction(
                          //                                 child: Row(
                          //                                   mainAxisAlignment:
                          //                                       MainAxisAlignment
                          //                                           .center,
                          //                                   children: [
                          //                                     Container(
                          //                                       margin: EdgeInsets.only(
                          //                                           right: size
                          //                                               .iScreen(
                          //                                                   2.0)),
                          //                                       child: Text(
                          //                                         'Ver PDF',
                          //                                         style: GoogleFonts.lexendDeca(
                          //                                             fontSize: size
                          //                                                 .iScreen(
                          //                                                     1.8),
                          //                                             color: Colors
                          //                                                 .black87,
                          //                                             fontWeight:
                          //                                                 FontWeight
                          //                                                     .normal),
                          //                                       ),
                          //                                     ),
                          //                                     const Icon(
                          //                                       FontAwesomeIcons
                          //                                           .filePdf,
                          //                                       color: Colors.red,
                          //                                     )
                          //                                   ],
                          //                                 ),
                          //                                 onPressed: () {
                          //                                   Navigator.pop(
                          //                                       context);
                          
                          //                                   Navigator.push(
                          //                                     context,
                          //                                     MaterialPageRoute(
                          //                                         builder: (context) =>
                          //                                             ViewsPDFs(
                          //                                                 infoPdf:
                          //                                                     // 'https://sysvet.neitor.com/reportes/carnet.php?id=${factura['venId']}&empresa=${_usuario!.rucempresa}',
                          //                                                     'https://syscontable.neitor.com/reportes/factura.php?codigo=${_prefacturas['venId']}&empresa=${_usuario!.rucempresa}',
                          //                                                 labelPdf:
                          //                                                     'infoFactura.pdf')),
                          //                                   );
                          //                                 },
                          //                               ),
                          //                             ],
                          //                             cancelButton:
                          //                                 CupertinoActionSheetAction(
                          //                               child: Text('Cancel',
                          //                                   style: GoogleFonts
                          //                                       .lexendDeca(
                          //                                           fontSize: size
                          //                                               .iScreen(
                          //                                                   2.0),
                          //                                           color: Colors
                          //                                               .red,
                          //                                           fontWeight:
                          //                                               FontWeight
                          //                                                   .normal)),
                          //                               isDefaultAction: true,
                          //                               onPressed: () {
                          //                                 Navigator.pop(
                          //                                     context, 'Cancel');
                          //                               },
                          //                             )),
                          //                   );
                          //                 },
                          //               ),
                          //             ],
                          //           ),
                          //           child: Card(
                          //             elevation: 5,
                          //             child: Container(
                          //               margin: EdgeInsets.only(
                          //                   bottom: size.iScreen(0.0)),
                          //               color: index % 2 == 0
                          //                   ? Colors.grey.shade50
                          //                   : Colors.grey.shade200,
                          //               child: ListTile(
                          //                 dense: true,
                          //                 visualDensity:
                          //                     VisualDensity.comfortable,
                                      
                          //                  leading: CircleAvatar(
                          //                   child: Text(
                          //                      '${_prefacturas['venNomCliente'].substring(0, 1)}',
                          //                     style: Theme.of(context)
                          //                         .textTheme
                          //                         .subtitle1,
                          //                   ),
                          //                   backgroundColor: Colors.grey[300],
                          //                 ),
                          //                 title: Row(
                          //                   mainAxisAlignment:
                          //                       MainAxisAlignment.spaceBetween,
                          //                   children: [
                          //                     SizedBox(
                          //                       width: size.wScreen(40.0),
                          //                       child: Text(
                          //                         '${_prefacturas['venNomCliente']}',
                          //                         style: GoogleFonts.lexendDeca(
                          //                             // fontSize: size.iScreen(2.45),
                          //                             // color: Colors.white,
                          //                             fontWeight:
                          //                                 FontWeight.normal),
                          //                         overflow: TextOverflow.ellipsis,
                          //                       ),
                          //                     ),
                          //                     Text(
                          //                       '${_prefacturas['venEstado']}',
                          //                       // 'Estado: ',
                          //                       style: GoogleFonts.lexendDeca(
                          //                           fontSize: size.iScreen(1.5),
                          //                           color: _color,
                          //                           fontWeight: FontWeight.bold),
                          //                     ),
                          //                   ],
                          //                 ),
                          //                 subtitle: Row(
                          //                   mainAxisAlignment:
                          //                       MainAxisAlignment.spaceBetween,
                          //                   children: [
                          //                     Column(
                          //                       mainAxisAlignment:
                          //                           MainAxisAlignment.start,
                          //                       children: [
                          //                         Container(
                          //                           // color: Colors.green,
                          //                           width: size.wScreen(50.0),
                          //                           child: Text(
                          //                             '${_prefacturas['venNumFactura']}',
                          //                             style:
                          //                                 GoogleFonts.lexendDeca(
                          //                                     fontSize: size
                          //                                         .iScreen(1.5),
                          //                                     color:
                          //                                         Colors.black54,
                          //                                     fontWeight:
                          //                                         FontWeight
                          //                                             .normal),
                          //                             overflow:
                          //                                 TextOverflow.ellipsis,
                          //                           ),
                          //                         ),
                          //                         Container(
                          //                           // color: Colors.green,
                          //                           width: size.wScreen(50.0),
                          //                           child: Text(
                          //                             _prefacturas['venFecReg'] !=
                          //                                     ''
                          //                                 ? '${_prefacturas['venFecReg'].replaceAll('T', "  ").replaceAll('.000Z', "  ")}'
                          //                                 : '--- --- ---',
                          //                             style:
                          //                                 GoogleFonts.lexendDeca(
                          //                                     // fontSize: size.iScreen(2.45),
                          //                                     color: Colors.grey,
                          //                                     fontWeight:
                          //                                         FontWeight
                          //                                             .normal),
                          //                           ),
                          //                         ),
                          //                       ],
                          //                     ),
                          //                     Container(
                          //                       // color: Colors.green,
                          //                       // width: size.wScreen(100.0),
                          //                       child: Text(
                          //                         '\$${_prefacturas['venTotal']}',
                          //                         style: GoogleFonts.lexendDeca(
                          //                             fontSize: size.iScreen(2.0),
                          //                             color: Colors.black87,
                          //                             fontWeight:
                          //                                 FontWeight.normal),
                          //                         overflow: TextOverflow.ellipsis,
                          //                       ),
                          //                     ),
                          //                   ],
                          //                 ),
                          //                 // trailing: Icon(Icons.more_vert),
                          //               ),
                          //             ),
                          //           ),
                          //         );
                          //       } else {
                          //         return Consumer<PreFacturasController>(
                          //           builder: (_, valueNext, __) {
                          //             return valueNext.getpage == null
                          //                 ? Container(
                          //                     margin: EdgeInsets.symmetric(
                          //                         vertical: size.iScreen(2.0)),
                          //                     child: Center(
                          //                       child: Text(
                          //                         'No existen más datos',
                          //                         style: GoogleFonts.lexendDeca(
                          //                             fontSize: size.iScreen(1.8),
                          //                             // color: primaryColor,
                          //                             fontWeight:
                          //                                 FontWeight.normal),
                          //                       ),
                          //                     ))
                          //                 // : Container();
                          
                          //                 : provider.allItemsFilters.length > 25
                          //                     ? Container(
                          //                         margin: EdgeInsets.symmetric(
                          //                             vertical:
                          //                                 size.iScreen(2.0)),
                          //                         child: const Center(
                          //                             child:
                          //                                 CircularProgressIndicator()))
                          //                     : Container();
                          //           },
                          //         );
                          //       }
                          //     },
                          //   ),
                          // )
                          
                          
                          
                          : const NoData(
                              label: 'No existen datos para mostar',
                            );

                        },
                      ),
                     
 
              


              // Consumer<NotasCreditosController>(
              //   builder: (_, providersNotasCreditos, __) {
              //     if (providersNotasCreditos.getErrorNotasCreditosPaginacion == null &&
              //         providersNotasCreditos.getError401NotasCreditosPaginacion == false) {
              //       return Center(
              //         child: Column(
              //           mainAxisSize: MainAxisSize.min,
              //           children: [
              //             Text(
              //               'Cargando Datos...',
              //               style: GoogleFonts.lexendDeca(
              //                 fontSize: size.iScreen(1.5),
              //                 color: Colors.black87,
              //                 fontWeight: FontWeight.bold,
              //               ),
              //             ),
              //             SizedBox(height: size.iScreen(1.0)),
              //             const CircularProgressIndicator(),
              //           ],
              //         ),
              //       );
              //     } else if (providersNotasCreditos.getErrorNotasCreditosPaginacion == false) {
              //       return const NoData(label: 'No existen datos para mostrar');
              //     } else if (providersNotasCreditos.getListaNotasCreditosPaginacion.isEmpty &&
              //         providersNotasCreditos.getErrorNotasCreditosPaginacion == false) {
              //       return const NoData(label: 'No existen datos para mostrar');
              //     } else if (providersNotasCreditos.getListaNotasCreditosPaginacion.isEmpty &&
              //         providersNotasCreditos.getError401NotasCreditosPaginacion == true) {
              //       return const NoData(label: 'Su sesión ha expirado, vuelva a iniciar sesión');
              //     } else if (providersNotasCreditos.getListaNotasCreditosPaginacion.isEmpty &&
              //         providersNotasCreditos.getError401NotasCreditosPaginacion == false) {
              //       return const NoData(label: 'No existen datos para mostrar');
              //     }

              //     return RefreshIndicator(
              //       onRefresh: () => onRefresh(),
              //       child: ListView.builder(
              //         controller: _scrollController,
              //         physics: const BouncingScrollPhysics(),
              //         itemCount: providersNotasCreditos.getListaNotasCreditosPaginacion.length + 1,
              //         itemBuilder: (BuildContext context, int index) {
              //           if (index < providersNotasCreditos.getListaNotasCreditosPaginacion.length) {
              //             var _color;
              //             final _notasCredito = providersNotasCreditos.getListaNotasCreditosPaginacion[index];

              //             if (_notasCredito['venEstado'] == 'AUTORIZADO') {
              //               _color = Colors.green;
              //             } else if (_notasCredito['venEstado'] == 'SIN AUTORIZAR') {
              //               _color = Colors.orange;
              //             } else if (_notasCredito['venEstado'] == 'ANULADA') {
              //               _color = Colors.red;
              //             }

              //             return Slidable(
              //               startActionPane: ActionPane(
              //                 motion: const ScrollMotion(),
              //                 children: [
              //                   SlidableAction(
              //                     backgroundColor: Colors.grey,
              //                     foregroundColor: Colors.white,
              //                     icon: Icons.list_alt_outlined,
              //                     label: 'Más acciones',
              //                     onPressed: (context) {
              //                       showCupertinoModalPopup(
              //                         context: context,
              //                         builder: (BuildContext context) => CupertinoActionSheet(
              //                           title: Text(
              //                             'Acciones',
              //                             style: GoogleFonts.lexendDeca(
              //                               fontSize: size.iScreen(2.0),
              //                               color: primaryColor,
              //                               fontWeight: FontWeight.normal,
              //                             ),
              //                           ),
              //                           actions: <Widget>[
              //                             CupertinoActionSheetAction(
              //                               child: Row(
              //                                 mainAxisAlignment: MainAxisAlignment.center,
              //                                 children: [
              //                                   Container(
              //                                     margin: EdgeInsets.only(right: size.iScreen(2.0)),
              //                                     child: Text(
              //                                       'Ver PDF',
              //                                       style: GoogleFonts.lexendDeca(
              //                                         fontSize: size.iScreen(1.8),
              //                                         color: Colors.black87,
              //                                         fontWeight: FontWeight.normal,
              //                                       ),
              //                                     ),
              //                                   ),
              //                                   const Icon(
              //                                     FontAwesomeIcons.filePdf,
              //                                     color: Colors.red,
              //                                   ),
              //                                 ],
              //                               ),
              //                               onPressed: () {
              //                                 Navigator.pop(context);
              //                                 Navigator.push(
              //                                   context,
              //                                   MaterialPageRoute(
              //                                     builder: (context) => ViewsPDFs(
              //                                       infoPdf: 'https://syscontable.neitor.com/reportes/factura.php?codigo=${_notasCredito['venId']}&empresa=${_usuario!.rucempresa}',
              //                                       labelPdf: 'infoFactura.pdf',
              //                                     ),
              //                                   ),
              //                                 );
              //                               },
              //                             ),
              //                           ],
              //                           cancelButton: CupertinoActionSheetAction(
              //                             child: Text(
              //                               'Cancel',
              //                               style: GoogleFonts.lexendDeca(
              //                                 fontSize: size.iScreen(2.0),
              //                                 color: Colors.red,
              //                                 fontWeight: FontWeight.normal,
              //                               ),
              //                             ),
              //                             isDefaultAction: true,
              //                             onPressed: () {
              //                               Navigator.pop(context, 'Cancel');
              //                             },
              //                           ),
              //                         ),
              //                       );
              //                     },
              //                   ),
              //                 ],
              //               ),
              //               child: Card(
              //                 elevation: 5,
              //                 child: Container(
              //                   margin: EdgeInsets.only(bottom: size.iScreen(0.0)),
              //                   color: index % 2 == 0 ? Colors.grey.shade50 : Colors.grey.shade200,
              //                   child: ListTile(
              //                     dense: true,
              //                     visualDensity: VisualDensity.comfortable,
              //                     leading: CircleAvatar(
              //                       child: Text(
              //                         '${_notasCredito['venNomCliente'].substring(0, 1)}',
              //                         style: Theme.of(context).textTheme.subtitle1,
              //                       ),
              //                       backgroundColor: Colors.grey[300],
              //                     ),
              //                     title: Row(
              //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                       children: [
              //                         SizedBox(
              //                           width: size.wScreen(50.0),
              //                           child: Text(
              //                             '${_notasCredito['venNomCliente']}',
              //                             style: GoogleFonts.lexendDeca(fontWeight: FontWeight.normal),
              //                             overflow: TextOverflow.ellipsis,
              //                           ),
              //                         ),
              //                         Text(
              //                           '${_notasCredito['venEstado']}',
              //                           style: GoogleFonts.lexendDeca(
              //                             fontSize: size.iScreen(1.5),
              //                             color: _color,
              //                             fontWeight: FontWeight.bold,
              //                           ),
              //                         ),
              //                       ],
              //                     ),
              //                     subtitle: Row(
              //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                       children: [
              //                         Column(
              //                           mainAxisAlignment: MainAxisAlignment.start,
              //                           children: [
              //                             Container(
              //                               width: size.wScreen(50.0),
              //                               child: Text(
              //                                 '${_notasCredito['venNum_notasCredito']}',
              //                                 style: GoogleFonts.lexendDeca(
              //                                   fontSize: size.iScreen(1.5),
              //                                   color: Colors.black54,
              //                                   fontWeight: FontWeight.normal,
              //                                 ),
              //                                 overflow: TextOverflow.ellipsis,
              //                               ),
              //                             ),
              //                             Container(
              //                               width: size.wScreen(50.0),
              //                               child: Text(
              //                                 _notasCredito['venFecReg'] != ''
              //                                     ? '${_notasCredito['venFecReg'].replaceAll('T', "  ").replaceAll('.000Z', "  ")}'
              //                                     : '--- --- ---',
              //                                 style: GoogleFonts.lexendDeca(
              //                                   color: Colors.grey,
              //                                   fontWeight: FontWeight.normal,
              //                                 ),
              //                               ),
              //                             ),
              //                           ],
              //                         ),
              //                         Container(
              //                           child: Text(
              //                             '\$${_notasCredito['venTotal']}',
              //                             style: GoogleFonts.lexendDeca(
              //                               fontSize: size.iScreen(2.0),
              //                               color: Colors.black87,
              //                               fontWeight: FontWeight.normal,
              //                             ),
              //                             overflow: TextOverflow.ellipsis,
              //                           ),
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //             );
              //           } else {
              //             return Consumer<NotasCreditosController>(
              //               builder: (_, valueNext, __) {
              //                 return valueNext.getpage == null
              //                     ? Container(
              //                         margin: EdgeInsets.symmetric(vertical: size.iScreen(2.0)),
              //                         child: Center(
              //                           child: Text(
              //                             'No existen más datos',
              //                             style: GoogleFonts.lexendDeca(
              //                               fontSize: size.iScreen(1.8),
              //                               fontWeight: FontWeight.normal,
              //                             ),
              //                           ),
              //                         ),
              //                       )
              //                     : valueNext.getListaNotasCreditosPaginacion.length > 25
              //                         ? Container(
              //                             margin: EdgeInsets.symmetric(vertical: size.iScreen(2.0)),
              //                             child: const Center(child: CircularProgressIndicator()),
              //                           )
              //                         : Container();
              //               },
              //             );
              //           }
              //         },
              //       ),
              //     );
              //   },
              // ),
             






            ],
          ),
        ),
      ],
    ),
  ),
),


          // Container(
          //   color: Colors.grey.shade100,
          //   width: size.wScreen(100.0),
          //   height: size.hScreen(100.0),
          //   padding: EdgeInsets.only(
          //     top: size.iScreen(0.0),
          //     right: size.iScreen(0.0),
          //     left: size.iScreen(0.0),
          //   ),
          //   child: Consumer<NotasCreditosController>(
          //               builder: (_, providersNotasCreditos, __) {
          //                 if (providersNotasCreditos.getErrorNotasCreditosPaginacion == null &&
          //                     providersNotasCreditos.getError401NotasCreditosPaginacion == false) {
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
          //                 }
          //                  else if (providersNotasCreditos.getErrorNotasCreditosPaginacion ==
          //                     false) {
          //                   return const NoData(
          //                     label: 'No existen datos para mostar',
          //                   );
          //                 }
          //                  else if (providersNotasCreditos
          //                         .getListaNotasCreditosPaginacion.isEmpty &&providersNotasCreditos.getErrorNotasCreditosPaginacion ==
          //                     false ) {
          //                   return const NoData(
          //                     label: 'No existen datos para mostar',
          //                   );
          //                 }
          //                  else if (providersNotasCreditos
          //                         .getListaNotasCreditosPaginacion.isEmpty &&
          //                     providersNotasCreditos.getError401NotasCreditosPaginacion == true) {
          //                   return const NoData(
          //                     label:
          //                         'Su sesión ha expirado, vuelva a iniciar sesión',
          //                   );
          //                 } else if (providersNotasCreditos
          //                         .getListaNotasCreditosPaginacion.isEmpty &&
          //                     providersNotasCreditos.getError401NotasCreditosPaginacion == false) {
          //                   return const NoData(
          //                     label: 'No existen datos para mostar',
          //                   );
          //                 }

          //                 return RefreshIndicator(
          //                        onRefresh: () => onRefresh(),
          //                   child: ListView.builder(
          //                     controller: _scrollController,
          //                     physics: const BouncingScrollPhysics(),
          //                     itemCount: providersNotasCreditos.getListaNotasCreditosPaginacion.length +1,
          //                     itemBuilder: (BuildContext context, int index) {
          //                       if (index <
          //                          providersNotasCreditos.getListaNotasCreditosPaginacion.length) {
          //                       var _color;
          //                       final _notasCredito =
          //                           providersNotasCreditos.getListaNotasCreditosPaginacion[index];
                          
          //                       if (_notasCredito['venEstado'] == 'AUTORIZADO') {
          //                         _color = Colors.green;
          //                       } else if (_notasCredito['venEstado'] ==
          //                           'SIN AUTORIZAR') {
          //                         _color = Colors.orange;
          //                       }
          //                       if (_notasCredito['venEstado'] == 'ANULADA') {
          //                         _color = Colors.red;
          //                       }
                          
          //                       return Slidable(
          //                         startActionPane: ActionPane(
          //                           // A motion is a widget used to control how the pane animates.
          //                           motion: const ScrollMotion(),
                          
          //                           children: [
          //                             SlidableAction(
          //                                   backgroundColor: Colors.grey,
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
          //                                                                   'https://syscontable.neitor.com/reportes/factura.php?codigo=${_notasCredito['venId']}&empresa=${_usuario!.rucempresa}',
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
                                    
          //                                leading: CircleAvatar(
          //                                   child: Text(
          //                                     '${_notasCredito['venNomCliente'].substring(0, 1)}',
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
          //                                       '${_notasCredito['venNomCliente']}',
          //                                       style: GoogleFonts.lexendDeca(
          //                                           // fontSize: size.iScreen(2.45),
          //                                           // color: Colors.white,
          //                                           fontWeight:
          //                                               FontWeight.normal),
          //                                       overflow: TextOverflow.ellipsis,
          //                                     ),
          //                                   ),
          //                                   Text(
          //                                     '${_notasCredito['venEstado']}',
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
          //                                           '${_notasCredito['venNum_notasCredito']}',
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
          //                                           _notasCredito['venFecReg'] != ''
          //                                               ? '${_notasCredito['venFecReg'].replaceAll('T', "  ").replaceAll('.000Z', "  ")}'
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
          //                                       '\$${_notasCredito['venTotal']}',
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
          //                       );} else{
          //                          return Consumer<NotasCreditosController>(
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
                          
          //                                 : valueNext.getListaNotasCreditosPaginacion
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
          // )),
    
    
    
    ));
  }


  Future<void> onRefresh() async {
    final _controller = Provider.of<NotasCreditosController>(context, listen: false);
    _controller.setPage(0);
    _controller.setCantidad(25);
    _controller.buscaAllNotasCreditosPaginacion('', true,_controller.getTabIndex);
  }


}

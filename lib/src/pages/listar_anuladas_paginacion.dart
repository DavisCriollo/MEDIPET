import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neitorcont/src/api/authentication_client.dart';
import 'package:neitorcont/src/controllers/anuladas_controller.dart';
import 'package:neitorcont/src/controllers/facturas_controller.dart';

import 'package:neitorcont/src/models/sesison_model.dart';
import 'package:neitorcont/src/pages/views_pdf.dart';
import 'package:neitorcont/src/services/notifications_service.dart';
import 'package:neitorcont/src/services/socket_service.dart';
import 'package:neitorcont/src/theme/themes_app.dart';
import 'package:neitorcont/src/utils/responsive.dart';
import 'package:neitorcont/src/utils/theme.dart';
import 'package:neitorcont/src/widgets/no_data.dart';
import 'package:provider/provider.dart';

class ListarAnuladasPaginacion extends StatefulWidget {
  const ListarAnuladasPaginacion({Key? key}) : super(key: key);

  @override
  State<ListarAnuladasPaginacion> createState() => _ListarAnuladasPaginacionState();
}

class _ListarAnuladasPaginacionState extends State<ListarAnuladasPaginacion> {
  final TextEditingController _textSearchController = TextEditingController();
  Session? _usuario;
   final _scrollController = ScrollController();

  @override
  void initState() {
 _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
       
        final _next = context.read<FacturasController>();
        if (_next.getpage != null) {
          _next.setPage(_next.getpage);
          //       providerSearchPropietario.setCantidad(25);
          _next.buscaAllFacturasPaginacion('', false,_next.getTabIndex);
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
    // final loadInfo = context.read<AnuladasController>();
    // // Provider.of<PropietariosController>(context, listen: false);
    // // await loadInfo.buscaAllFacturas('');

    // final serviceSocket = context.read<SocketService>();
    // serviceSocket.socket!.on('server:guardadoExitoso', (data) async {
    //   if (data['tabla'] == 'facturas') {
    //     loadInfo.buscaAllAnuladasPaginacion('', false,loadInfo.getTabIndex);
    //     // NotificatiosnService.showSnackBarSuccsses(data['msg']);
    //   }
    // });
    // serviceSocket.socket!.on('server:actualizadoExitoso', (data) async {
    //   if (data['tabla'] == 'facturas') {
    //     loadInfo.buscaAllAnuladasPaginacion('', false,loadInfo.getTabIndex);
    //     // NotificatiosnService.showSnackBarSuccsses(data['msg']);
    //   }
    // });
    // serviceSocket.socket!.on('server:eliminadoExitoso', (data) async {
    //   if (data['tabla'] == 'facturas') {
    //     loadInfo.buscaAllAnuladasPaginacion('', false,loadInfo.getTabIndex);
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
          
            title: Consumer<AnuladasController>(
              builder: (_, providerSearchAnuladas, __) {
                return Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: size.iScreen(0.1)),
                        child: (providerSearchAnuladas
                                .btnSearchAnuladaPaginacion)
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

                                                 providerSearchAnuladas.search(text);

                                            // providerSearchAnuladas
                                            //     .onSearchTextAnuladaPaginacion(
                                            //         text);

                                            // if (providerSearchAnuladas
                                            //     .nameSearchAnuladaPaginacion
                                            //     .isEmpty) {
                                            //   //                 providerSearchAnuladas
                                            //   //     .setErrorMascotasPaginacion(null);

                                            //   // providerSearchAnuladas
                                            //   //     .setError401MascotasPaginacion(
                                            //   //         false);
                                            //   providerSearchAnuladas.setPage(0);
                                            //   providerSearchAnuladas
                                            //       .setCantidad(25);
                                            //   // providerSearchAnuladas.setIsNext(false);
                                            //   providerSearchAnuladas
                                            //       .buscaAllAnuladasPaginacion(
                                            //           '', true,providerSearchAnuladas.getTabIndex);

                                            //   //   providerSearchAnuladas
                                            //   //       .setBtnSearchPropietarioPaginacion(
                                            //   //           !providerSearchAnuladas
                                            //   //               .btnSearchPropietarioPaginacion);
                                            //   //   _textSearchController.text = "";
                                            //   //   providerSearchAnuladas
                                            //   //       .buscaAllPropietariosPaginacion(
                                            //   //           '', false);
                                            // }

                                            // // setState(() {});
                                          },
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Buscar...',
                                            // suffixIcon:
                                            // //  Icon(Icons.search),
                                            // // icon: Icon(Icons.search),
                                            //  GestureDetector(child: Icon(Icons.search),onTap: (){
                                            //   // providerSearchAnuladas
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
                                  'Sin Autorizar / Anuladas',
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
                        providerSearchAnuladas.btnSearchAnuladaPaginacion
                            ? IconButton(
                                splashRadius: size.iScreen(3.0),
                                icon: Icon(
                                  Icons.search,
                                  size: size.iScreen(3.5),
                                  // color: Colors.white,
                                ),
                                onPressed: () {
                                  //=====================//
                                  if (providerSearchAnuladas
                                          .nameSearchAnuladaPaginacion.length >=
                                      3) {
                                    providerSearchAnuladas
                                        .setErrorAnuladasPaginacion(null);

                                    providerSearchAnuladas
                                        .setError401AnuladasPaginacion(false);
                                    providerSearchAnuladas.setPage(0);
                                    providerSearchAnuladas.setCantidad(25);

                                    providerSearchAnuladas
                                        .buscaAllAnuladasPaginacion(
                                            // '0803395581');
                                            ' ${providerSearchAnuladas.nameSearchAnuladaPaginacion}',
                                            true,providerSearchAnuladas.getTabIndex);
                                  } else {
                                    print('NO HAACE NADA');
                                  }
                                })
                            : Container(),
                        IconButton(
                            splashRadius: 2.0,
                            icon: (!providerSearchAnuladas
                                    .btnSearchAnuladaPaginacion)
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
                              providerSearchAnuladas
                                  .onSearchTextAnuladaPaginacion("");
                              _textSearchController.text = '';

                              providerSearchAnuladas
                                  .setBtnSearchAnuladaPaginacion(
                                      !providerSearchAnuladas
                                          .btnSearchAnuladaPaginacion);

                              if (providerSearchAnuladas
                                      .btnSearchAnuladaPaginacion ==
                                  false) {
                                //=====================//
                                providerSearchAnuladas
                                    .setErrorAnuladasPaginacion(null);

                                providerSearchAnuladas
                                    .setError401AnuladasPaginacion(false);

                                providerSearchAnuladas.setPage(0);
                                providerSearchAnuladas.setCantidad(25);
                                providerSearchAnuladas
                                    .buscaAllAnuladasPaginacion('', true,providerSearchAnuladas.getTabIndex);
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
  child: DefaultTabController(
    length: 2, // Número de pestañas
    child: Column(
      children: [
        TabBar(
          tabs: [
             Tab(
              child:
              Consumer<AnuladasController>(builder: (_, valueHoy, __) {  
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
              Consumer<AnuladasController>(builder: (_, valueAnteriores, __) {  
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
            final ctrl=context.read<AnuladasController>();
                        print('EL INDICE :$index');
                       ctrl.setTabIndex(index);
                        if (  index==0) {
                          ctrl. setInfoBusquedaAnuladasPaginacion([]);
                          ctrl.resetValorTotal();
                            // ctrl.buscaAllAnuladasPaginacion(
                            //     '',false,ctrl.getTabIndex);
                             final _controllerAnuladas =
                                context.read<AnuladasController>();

                            _controllerAnuladas
                                .onSearchTextAnuladaPaginacion("");

                            _controllerAnuladas
                                .setBtnSearchAnuladaPaginacion(false);
                            _controllerAnuladas
                                .setErrorAnuladasPaginacion(null);

                            _controllerAnuladas
                                .setError401AnuladasPaginacion(false);

                            _controllerAnuladas.resetFormAnuladas();
                            _controllerAnuladas.setPage(0);
                            _controllerAnuladas.setIsNext(false);
                            _controllerAnuladas
                                .setInfoBusquedaAnuladasPaginacion([]);
                            _controllerAnuladas.buscaAllAnuladasPaginacion(
                                '', true,_controllerAnuladas.getTabIndex);


                        }
                        if ( index==1) {
                           ctrl.setInfoBusquedaAnuladasPaginacion([]);
                           ctrl.resetValorTotal();
                             ctrl.buscaAllAnuladasPaginacion(
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
              // Contenido de la primera pestaña
              Container(
                color: Colors.grey.shade100,
  width: size.wScreen(100.0),
  height: size.hScreen(100.0),
  padding: EdgeInsets.only(
    top: size.iScreen(0.0),
    right: size.iScreen(0.0),
    left: size.iScreen(0.0),
  ),
                child: 
                Consumer<AnuladasController>(
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
                            final anulada = provider.allItemsFilters[index];

                            if (anulada['venEstado'] == 'AUTORIZADO') {
                              _color = Colors.green;
                            } else if (anulada['venEstado'] == 'SIN AUTORIZAR') {
                              _color = Colors.orange;
                            }
                            if (anulada['venEstado'] == 'ANULADA') {
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
                                                fontSize: MediaQuery.of(context).size.height * 0.02,
                                                color: Colors.blue,
                                                fontWeight: FontWeight.normal),
                                          ),
                                          actions: <Widget>[
                                            CupertinoActionSheetAction(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        right: MediaQuery.of(context).size.width * 0.02),
                                                    child: Text(
                                                      'Ver PDF',
                                                      style: GoogleFonts.lexendDeca(
                                                          fontSize: MediaQuery.of(context).size.height * 0.018,
                                                          color: Colors.black87,
                                                          fontWeight: FontWeight.normal),
                                                    ),
                                                  ),
                                                  const Icon(
                                                    Icons.picture_as_pdf,
                                                    color: Colors.red,
                                                  )
                                                ],
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context);
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => ViewsPDFs(
                                                      infoPdf: 'https://example.com/pdf',
                                                      labelPdf: 'infoFactura.pdf',
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                          cancelButton: CupertinoActionSheetAction(
                                            child: Text('Cancel',
                                                style: GoogleFonts.lexendDeca(
                                                    fontSize: MediaQuery.of(context).size.height * 0.02,
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.normal)),
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
                                  margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.0),
                                  color: index % 2 == 0
                                      ? Colors.grey.shade50
                                      : Colors.grey.shade200,
                                  child: ListTile(
                                    dense: true,
                                    visualDensity: VisualDensity.comfortable,
                                    leading: CircleAvatar(
                                      child: Text(
                                        '${anulada['venNomCliente'].substring(0, 1)}',
                                        style: Theme.of(context).textTheme.subtitle1,
                                      ),
                                      backgroundColor: Colors.grey[300],
                                    ),
                                    title: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context).size.width * 0.45,
                                          child: Text(
                                            '${anulada['venNomCliente']}',
                                            style: GoogleFonts.lexendDeca(
                                                fontWeight: FontWeight.normal),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Text(
                                          '${anulada['venEstado']}',
                                          style: GoogleFonts.lexendDeca(
                                              fontSize: MediaQuery.of(context).size.height * 0.015,
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
                                              width: MediaQuery.of(context).size.width * 0.5,
                                              child: Text(
                                                '${anulada['venNumFactura']}',
                                                style: GoogleFonts.lexendDeca(
                                                    fontSize: MediaQuery.of(context).size.height * 0.015,
                                                    color: Colors.black54,
                                                    fontWeight: FontWeight.normal),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.5,
                                              child: Text(
                                                anulada['venFecReg'] != ''
                                                    ? '${anulada['venFecReg'].replaceAll('T', "  ").replaceAll('.000Z', "  ")}'
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
                                            '\$${anulada['venTotal']}',
                                            style: GoogleFonts.lexendDeca(
                                                fontSize: MediaQuery.of(context).size.height * 0.02,
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
                            return Container(
                              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01),
                              child: provider.getListaAnuladasPaginacion.isEmpty
                                  ? Center(
                                      child: Text(
                                        'No hay más datos para mostrar',
                                        style: GoogleFonts.lexendDeca(
                                            fontSize: MediaQuery.of(context).size.height * 0.015,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  : Center(
                                      child: CircularProgressIndicator(),
                                    ),
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


                          
                          // ListView.builder(
                          //   itemCount: provider.allItemsFilters.length,
                          //   itemBuilder: (BuildContext context, int index) {
                          //     final producto =
                          //         provider.allItemsFilters[index];
                          //     return 
                          //    RefreshIndicator(
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
                          // );





                              
                          //   },
                          // ) : const NoData(
                          //     label: 'No existen datos para mostar',
                          //   );
                        },
                      ),
                     

                
                // Consumer<AnuladasController>(
                //   builder: (_, providersAnulada, __) {
                //     if (providersAnulada.getErrorAnuladasPaginacion == null &&
                //         providersAnulada.getError401AnuladasPaginacion == false) {
                //       return Center(
                //         child: Column(
                //           mainAxisSize: MainAxisSize.min,
                //           children: [
                //             Text(
                //               'Cargando Datos...',
                //               style: GoogleFonts.lexendDeca(
                //                   fontSize: MediaQuery.of(context).size.height * 0.015,
                //                   color: Colors.black87,
                //                   fontWeight: FontWeight.bold),
                //             ),
                //             SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                //             const CircularProgressIndicator(),
                //           ],
                //         ),
                //       );
                //     } else if (providersAnulada.getErrorAnuladasPaginacion == false) {
                //       return const NoData(label: 'No existen datos para mostrar');
                //     } else if (providersAnulada.getListaAnuladasPaginacion.isEmpty &&
                //         providersAnulada.getErrorAnuladasPaginacion == false) {
                //       return const NoData(label: 'No existen datos para mostrar');
                //     } else if (providersAnulada.getListaAnuladasPaginacion.isEmpty &&
                //         providersAnulada.getError401AnuladasPaginacion == true) {
                //       return const NoData(label: 'Su sesión ha expirado, vuelva a iniciar sesión');
                //     } else if (providersAnulada.getListaAnuladasPaginacion.isEmpty &&
                //         providersAnulada.getError401AnuladasPaginacion == false) {
                //       return const NoData(label: 'No existen datos para mostrar');
                //     }

                //     return
                //
                //
                // RefreshIndicator(
                //       onRefresh: () => onRefresh(),
                //       child: ListView.builder(
                //         controller: _scrollController,
                //         physics: const BouncingScrollPhysics(),
                //         itemCount: providersAnulada.getListaAnuladasPaginacion.length + 1,
                //         itemBuilder: (BuildContext context, int index) {
                //           if (index < providersAnulada.getListaAnuladasPaginacion.length) {
                //             var _color;
                //             final anulada = providersAnulada.getListaAnuladasPaginacion[index];

                //             if (anulada['venEstado'] == 'AUTORIZADO') {
                //               _color = Colors.green;
                //             } else if (anulada['venEstado'] == 'SIN AUTORIZAR') {
                //               _color = Colors.orange;
                //             }
                //             if (anulada['venEstado'] == 'ANULADA') {
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
                //                                 fontSize: MediaQuery.of(context).size.height * 0.02,
                //                                 color: Colors.blue,
                //                                 fontWeight: FontWeight.normal),
                //                           ),
                //                           actions: <Widget>[
                //                             CupertinoActionSheetAction(
                //                               child: Row(
                //                                 mainAxisAlignment: MainAxisAlignment.center,
                //                                 children: [
                //                                   Container(
                //                                     margin: EdgeInsets.only(
                //                                         right: MediaQuery.of(context).size.width * 0.02),
                //                                     child: Text(
                //                                       'Ver PDF',
                //                                       style: GoogleFonts.lexendDeca(
                //                                           fontSize: MediaQuery.of(context).size.height * 0.018,
                //                                           color: Colors.black87,
                //                                           fontWeight: FontWeight.normal),
                //                                     ),
                //                                   ),
                //                                   const Icon(
                //                                     Icons.picture_as_pdf,
                //                                     color: Colors.red,
                //                                   )
                //                                 ],
                //                               ),
                //                               onPressed: () {
                //                                 Navigator.pop(context);
                //                                 Navigator.push(
                //                                   context,
                //                                   MaterialPageRoute(
                //                                     builder: (context) => ViewsPDFs(
                //                                       infoPdf: 'https://example.com/pdf',
                //                                       labelPdf: 'infoFactura.pdf',
                //                                     ),
                //                                   ),
                //                                 );
                //                               },
                //                             ),
                //                           ],
                //                           cancelButton: CupertinoActionSheetAction(
                //                             child: Text('Cancel',
                //                                 style: GoogleFonts.lexendDeca(
                //                                     fontSize: MediaQuery.of(context).size.height * 0.02,
                //                                     color: Colors.red,
                //                                     fontWeight: FontWeight.normal)),
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
                //                   margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.0),
                //                   color: index % 2 == 0
                //                       ? Colors.grey.shade50
                //                       : Colors.grey.shade200,
                //                   child: ListTile(
                //                     dense: true,
                //                     visualDensity: VisualDensity.comfortable,
                //                     leading: CircleAvatar(
                //                       child: Text(
                //                         '${anulada['venNomCliente'].substring(0, 1)}',
                //                         style: Theme.of(context).textTheme.subtitle1,
                //                       ),
                //                       backgroundColor: Colors.grey[300],
                //                     ),
                //                     title: Row(
                //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                       children: [
                //                         SizedBox(
                //                           width: MediaQuery.of(context).size.width * 0.45,
                //                           child: Text(
                //                             '${anulada['venNomCliente']}',
                //                             style: GoogleFonts.lexendDeca(
                //                                 fontWeight: FontWeight.normal),
                //                             overflow: TextOverflow.ellipsis,
                //                           ),
                //                         ),
                //                         Text(
                //                           '${anulada['venEstado']}',
                //                           style: GoogleFonts.lexendDeca(
                //                               fontSize: MediaQuery.of(context).size.height * 0.015,
                //                               color: _color,
                //                               fontWeight: FontWeight.bold),
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
                //                               width: MediaQuery.of(context).size.width * 0.5,
                //                               child: Text(
                //                                 '${anulada['venNumFactura']}',
                //                                 style: GoogleFonts.lexendDeca(
                //                                     fontSize: MediaQuery.of(context).size.height * 0.015,
                //                                     color: Colors.black54,
                //                                     fontWeight: FontWeight.normal),
                //                                 overflow: TextOverflow.ellipsis,
                //                               ),
                //                             ),
                //                             Container(
                //                               width: MediaQuery.of(context).size.width * 0.5,
                //                               child: Text(
                //                                 anulada['venFecReg'] != ''
                //                                     ? '${anulada['venFecReg'].replaceAll('T', "  ").replaceAll('.000Z', "  ")}'
                //                                     : '--- --- ---',
                //                                 style: GoogleFonts.lexendDeca(
                //                                     color: Colors.grey,
                //                                     fontWeight: FontWeight.normal),
                //                               ),
                //                             ),
                //                           ],
                //                         ),
                //                         Container(
                //                           child: Text(
                //                             '\$${anulada['venTotal']}',
                //                             style: GoogleFonts.lexendDeca(
                //                                 fontSize: MediaQuery.of(context).size.height * 0.02,
                //                                 color: Colors.black87,
                //                                 fontWeight: FontWeight.normal),
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
                //             return Container(
                //               margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01),
                //               child: providersAnulada.getListaAnuladasPaginacion.isEmpty
                //                   ? Center(
                //                       child: Text(
                //                         'No hay más datos para mostrar',
                //                         style: GoogleFonts.lexendDeca(
                //                             fontSize: MediaQuery.of(context).size.height * 0.015,
                //                             color: Colors.black54,
                //                             fontWeight: FontWeight.bold),
                //                       ),
                //                     )
                //                   : Center(
                //                       child: CircularProgressIndicator(),
                //                     ),
                //             );
                //           }
                //         },
                //       ),
                //     );
                //   },
                // ),
             
             
             
             
              ),
              
              
              // Contenido de la segunda pestaña
               Container(
                color: Colors.grey.shade100,
  width: size.wScreen(100.0),
  height: size.hScreen(100.0),
  padding: EdgeInsets.only(
    top: size.iScreen(0.0),
    right: size.iScreen(0.0),
    left: size.iScreen(0.0),
  ),
                child: 
                  Consumer<AnuladasController>(
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
                            final anulada = provider.allItemsFilters[index];

                            if (anulada['venEstado'] == 'AUTORIZADO') {
                              _color = Colors.green;
                            } else if (anulada['venEstado'] == 'SIN AUTORIZAR') {
                              _color = Colors.orange;
                            }
                            if (anulada['venEstado'] == 'ANULADA') {
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
                                                fontSize: MediaQuery.of(context).size.height * 0.02,
                                                color: Colors.blue,
                                                fontWeight: FontWeight.normal),
                                          ),
                                          actions: <Widget>[
                                            CupertinoActionSheetAction(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        right: MediaQuery.of(context).size.width * 0.02),
                                                    child: Text(
                                                      'Ver PDF',
                                                      style: GoogleFonts.lexendDeca(
                                                          fontSize: MediaQuery.of(context).size.height * 0.018,
                                                          color: Colors.black87,
                                                          fontWeight: FontWeight.normal),
                                                    ),
                                                  ),
                                                  const Icon(
                                                    Icons.picture_as_pdf,
                                                    color: Colors.red,
                                                  )
                                                ],
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context);
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => ViewsPDFs(
                                                      infoPdf: 'https://example.com/pdf',
                                                      labelPdf: 'infoFactura.pdf',
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                          cancelButton: CupertinoActionSheetAction(
                                            child: Text('Cancel',
                                                style: GoogleFonts.lexendDeca(
                                                    fontSize: MediaQuery.of(context).size.height * 0.02,
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.normal)),
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
                                  margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.0),
                                  color: index % 2 == 0
                                      ? Colors.grey.shade50
                                      : Colors.grey.shade200,
                                  child: ListTile(
                                    dense: true,
                                    visualDensity: VisualDensity.comfortable,
                                    leading: CircleAvatar(
                                      child: Text(
                                        '${anulada['venNomCliente'].substring(0, 1)}',
                                        style: Theme.of(context).textTheme.subtitle1,
                                      ),
                                      backgroundColor: Colors.grey[300],
                                    ),
                                    title: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context).size.width * 0.45,
                                          child: Text(
                                            '${anulada['venNomCliente']}',
                                            style: GoogleFonts.lexendDeca(
                                                fontWeight: FontWeight.normal),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Text(
                                          '${anulada['venEstado']}',
                                          style: GoogleFonts.lexendDeca(
                                              fontSize: MediaQuery.of(context).size.height * 0.015,
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
                                              width: MediaQuery.of(context).size.width * 0.5,
                                              child: Text(
                                                '${anulada['venNumFactura']}',
                                                style: GoogleFonts.lexendDeca(
                                                    fontSize: MediaQuery.of(context).size.height * 0.015,
                                                    color: Colors.black54,
                                                    fontWeight: FontWeight.normal),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.5,
                                              child: Text(
                                                anulada['venFecReg'] != ''
                                                    ? '${anulada['venFecReg'].replaceAll('T', "  ").replaceAll('.000Z', "  ")}'
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
                                            '\$${anulada['venTotal']}',
                                            style: GoogleFonts.lexendDeca(
                                                fontSize: MediaQuery.of(context).size.height * 0.02,
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
                            return Container(
                              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01),
                              child: provider.getListaAnuladasPaginacion.isEmpty
                                  ? Center(
                                      child: Text(
                                        'No hay más datos para mostrar',
                                        style: GoogleFonts.lexendDeca(
                                            fontSize: MediaQuery.of(context).size.height * 0.015,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  : Center(
                                      child: CircularProgressIndicator(),
                                    ),
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


                          
                          // ListView.builder(
                          //   itemCount: provider.allItemsFilters.length,
                          //   itemBuilder: (BuildContext context, int index) {
                          //     final producto =
                          //         provider.allItemsFilters[index];
                          //     return 
                          //    RefreshIndicator(
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
                          // );





                              
                          //   },
                          // ) : const NoData(
                          //     label: 'No existen datos para mostar',
                          //   );
                        },
                      ),
                
                
                // Consumer<AnuladasController>(
                //   builder: (_, providersAnulada, __) {
                //     if (providersAnulada.getErrorAnuladasPaginacion == null &&
                //         providersAnulada.getError401AnuladasPaginacion == false) {
                //       return Center(
                //         child: Column(
                //           mainAxisSize: MainAxisSize.min,
                //           children: [
                //             Text(
                //               'Cargando Datos...',
                //               style: GoogleFonts.lexendDeca(
                //                   fontSize: MediaQuery.of(context).size.height * 0.015,
                //                   color: Colors.black87,
                //                   fontWeight: FontWeight.bold),
                //             ),
                //             SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                //             const CircularProgressIndicator(),
                //           ],
                //         ),
                //       );
                //     } else if (providersAnulada.getErrorAnuladasPaginacion == false) {
                //       return const NoData(label: 'No existen datos para mostrar');
                //     } else if (providersAnulada.getListaAnuladasPaginacion.isEmpty &&
                //         providersAnulada.getErrorAnuladasPaginacion == false) {
                //       return const NoData(label: 'No existen datos para mostrar');
                //     } else if (providersAnulada.getListaAnuladasPaginacion.isEmpty &&
                //         providersAnulada.getError401AnuladasPaginacion == true) {
                //       return const NoData(label: 'Su sesión ha expirado, vuelva a iniciar sesión');
                //     } else if (providersAnulada.getListaAnuladasPaginacion.isEmpty &&
                //         providersAnulada.getError401AnuladasPaginacion == false) {
                //       return const NoData(label: 'No existen datos para mostrar');
                //     }

                //     return RefreshIndicator(
                //       onRefresh: () => onRefresh(),
                //       child: ListView.builder(
                //         controller: _scrollController,
                //         physics: const BouncingScrollPhysics(),
                //         itemCount: providersAnulada.getListaAnuladasPaginacion.length + 1,
                //         itemBuilder: (BuildContext context, int index) {
                //           if (index < providersAnulada.getListaAnuladasPaginacion.length) {
                //             var _color;
                //             final anulada = providersAnulada.getListaAnuladasPaginacion[index];

                //             if (anulada['venEstado'] == 'AUTORIZADO') {
                //               _color = Colors.green;
                //             } else if (anulada['venEstado'] == 'SIN AUTORIZAR') {
                //               _color = Colors.orange;
                //             }
                //             if (anulada['venEstado'] == 'ANULADA') {
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
                //                                 fontSize: MediaQuery.of(context).size.height * 0.02,
                //                                 color: Colors.blue,
                //                                 fontWeight: FontWeight.normal),
                //                           ),
                //                           actions: <Widget>[
                //                             CupertinoActionSheetAction(
                //                               child: Row(
                //                                 mainAxisAlignment: MainAxisAlignment.center,
                //                                 children: [
                //                                   Container(
                //                                     margin: EdgeInsets.only(
                //                                         right: MediaQuery.of(context).size.width * 0.02),
                //                                     child: Text(
                //                                       'Ver PDF',
                //                                       style: GoogleFonts.lexendDeca(
                //                                           fontSize: MediaQuery.of(context).size.height * 0.018,
                //                                           color: Colors.black87,
                //                                           fontWeight: FontWeight.normal),
                //                                     ),
                //                                   ),
                //                                   const Icon(
                //                                     Icons.picture_as_pdf,
                //                                     color: Colors.red,
                //                                   )
                //                                 ],
                //                               ),
                //                               onPressed: () {
                //                                 Navigator.pop(context);
                //                                 Navigator.push(
                //                                   context,
                //                                   MaterialPageRoute(
                //                                     builder: (context) => ViewsPDFs(
                //                                       infoPdf: 'https://example.com/pdf',
                //                                       labelPdf: 'infoFactura.pdf',
                //                                     ),
                //                                   ),
                //                                 );
                //                               },
                //                             ),
                //                           ],
                //                           cancelButton: CupertinoActionSheetAction(
                //                             child: Text('Cancel',
                //                                 style: GoogleFonts.lexendDeca(
                //                                     fontSize: MediaQuery.of(context).size.height * 0.02,
                //                                     color: Colors.red,
                //                                     fontWeight: FontWeight.normal)),
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
                //                   margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.0),
                //                   color: index % 2 == 0
                //                       ? Colors.grey.shade50
                //                       : Colors.grey.shade200,
                //                   child: ListTile(
                //                     dense: true,
                //                     visualDensity: VisualDensity.comfortable,
                //                     leading: CircleAvatar(
                //                       child: Text(
                //                         '${anulada['venNomCliente'].substring(0, 1)}',
                //                         style: Theme.of(context).textTheme.subtitle1,
                //                       ),
                //                       backgroundColor: Colors.grey[300],
                //                     ),
                //                     title: Row(
                //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                       children: [
                //                         SizedBox(
                //                           width: MediaQuery.of(context).size.width * 0.45,
                //                           child: Text(
                //                             '${anulada['venNomCliente']}',
                //                             style: GoogleFonts.lexendDeca(
                //                                 fontWeight: FontWeight.normal),
                //                             overflow: TextOverflow.ellipsis,
                //                           ),
                //                         ),
                //                         Text(
                //                           '${anulada['venEstado']}',
                //                           style: GoogleFonts.lexendDeca(
                //                               fontSize: MediaQuery.of(context).size.height * 0.015,
                //                               color: _color,
                //                               fontWeight: FontWeight.bold),
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
                //                               width: MediaQuery.of(context).size.width * 0.5,
                //                               child: Text(
                //                                 '${anulada['venNumFactura']}',
                //                                 style: GoogleFonts.lexendDeca(
                //                                     fontSize: MediaQuery.of(context).size.height * 0.015,
                //                                     color: Colors.black54,
                //                                     fontWeight: FontWeight.normal),
                //                                 overflow: TextOverflow.ellipsis,
                //                               ),
                //                             ),
                //                             Container(
                //                               width: MediaQuery.of(context).size.width * 0.5,
                //                               child: Text(
                //                                 anulada['venFecReg'] != ''
                //                                     ? '${anulada['venFecReg'].replaceAll('T', "  ").replaceAll('.000Z', "  ")}'
                //                                     : '--- --- ---',
                //                                 style: GoogleFonts.lexendDeca(
                //                                     color: Colors.grey,
                //                                     fontWeight: FontWeight.normal),
                //                               ),
                //                             ),
                //                           ],
                //                         ),
                //                         Container(
                //                           child: Text(
                //                             '\$${anulada['venTotal']}',
                //                             style: GoogleFonts.lexendDeca(
                //                                 fontSize: MediaQuery.of(context).size.height * 0.02,
                //                                 color: Colors.black87,
                //                                 fontWeight: FontWeight.normal),
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
                //             return Container(
                //               margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01),
                //               child: providersAnulada.getListaAnuladasPaginacion.isEmpty
                //                   ? Center(
                //                       child: Text(
                //                         'No hay más datos para mostrar',
                //                         style: GoogleFonts.lexendDeca(
                //                             fontSize: MediaQuery.of(context).size.height * 0.015,
                //                             color: Colors.black54,
                //                             fontWeight: FontWeight.bold),
                //                       ),
                //                     )
                //                   : Center(
                //                       child: CircularProgressIndicator(),
                //                     ),
                //             );
                //           }
                //         },
                //       ),
                //     );
                //   },
                // ),
             
             
             
              ),
              
              
            ],
          ),
        ),
      ],
    ),
  ),
))
,
         
          // body: 
          // Container(
          //   color: Colors.grey.shade100,
          //   width: size.wScreen(100.0),
          //   height: size.hScreen(100.0),
          //   padding: EdgeInsets.only(
          //     top: size.iScreen(0.0),
          //     right: size.iScreen(0.0),
          //     left: size.iScreen(0.0),
          //   ),
          //   child: Consumer<AnuladasController>(
          //               builder: (_, providersAnulada, __) {
          //                 if (providersAnulada.getErrorAnuladasPaginacion == null &&
          //                     providersAnulada.getError401AnuladasPaginacion == false) {
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
          //                 } else if (providersAnulada.getErrorAnuladasPaginacion ==
          //                     false) {
          //                   return const NoData(
          //                     label: 'No existen datos para mostar',
          //                   );
          //                 } 
          //                  else if (providersAnulada
          //                         .getListaAnuladasPaginacion.isEmpty &&providersAnulada.getErrorAnuladasPaginacion ==
          //                     false ) {
          //                   return const NoData(
          //                     label: 'No existen datos para mostar',
          //                   );
          //                 }
          //                 else if (providersAnulada
          //                         .getListaAnuladasPaginacion.isEmpty &&
          //                     providersAnulada.getError401AnuladasPaginacion == true) {
          //                   return const NoData(
          //                     label:
          //                         'Su sesión ha expirado, vuelva a iniciar sesión',
          //                   );
          //                 } else if (providersAnulada
          //                         .getListaAnuladasPaginacion.isEmpty &&
          //                     providersAnulada.getError401AnuladasPaginacion == false) {
          //                   return const NoData(
          //                     label: 'No existen datos para mostar',
          //                   );
          //                 }

          //                 return RefreshIndicator(
          //                     onRefresh: () => onRefresh(),
          //                   child: ListView.builder(
          //                     controller: _scrollController,
          //                     physics: const BouncingScrollPhysics(),
          //                     itemCount: providersAnulada.getListaAnuladasPaginacion.length+1,
          //                     itemBuilder: (BuildContext context, int index) {

          //                          if (index <
          //                           providersAnulada.getListaAnuladasPaginacion.length) {


          //                       var _color;
          //                       final anulada =
          //                           providersAnulada.getListaAnuladasPaginacion[index];
                          
          //                       if (anulada['venEstado'] == 'AUTORIZADO') {
          //                         _color = Colors.green;
          //                       } else if (anulada['venEstado'] ==
          //                           'SIN AUTORIZAR') {
          //                         _color = Colors.orange;
          //                       }
          //                       if (anulada['venEstado'] == 'ANULADA') {
          //                         _color = Colors.red;
          //                       }
                          
          //                       return Slidable(
          //                         startActionPane: ActionPane(
          //                           // A motion is a widget used to control how the pane animates.
          //                           motion: const ScrollMotion(),
                          
          //                           children: [
          //                             SlidableAction(
          //                               backgroundColor: Colors.grey,
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
          //                                                                   'https://syscontable.neitor.com/reportes/factura.php?codigo=${anulada['venId']}&empresa=${_usuario!.rucempresa}',
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
          //                                     '${anulada['venNomCliente'].substring(0, 1)}',
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
          //                                     width: size.wScreen(45.0),
          //                                     child: Text(
          //                                       '${anulada['venNomCliente']}',
          //                                       style: GoogleFonts.lexendDeca(
          //                                           // fontSize: size.iScreen(2.45),
          //                                           // color: Colors.white,
          //                                           fontWeight:
          //                                               FontWeight.normal),
          //                                       overflow: TextOverflow.ellipsis,
          //                                     ),
          //                                   ),
          //                                   Text(
          //                                     '${anulada['venEstado']}',
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
          //                                           '${anulada['venNumFactura']}',
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
          //                                           anulada['venFecReg'] != ''
          //                                               ? '${anulada['venFecReg'].replaceAll('T', "  ").replaceAll('.000Z', "  ")}'
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
          //                                       '\$${anulada['venTotal']}',
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
          //                       );
          //                           }
          //                           else{

          //                              return Consumer<AnuladasController>(
          //                           builder: (_, valueNext, __) {
          //                             return valueNext.getpage == null
          //                                 ? Container(
          //                                     margin: EdgeInsets.symmetric(
          //                                         vertical: size.iScreen(2.0)),
          //                                     child: Center(
          //                                       child: Text(
          //                                         'No existen más datos',
          //                                         style: GoogleFonts.lexendDeca(
          //                                             fontSize:
          //                                                 size.iScreen(1.8),
          //                                         //  color:  colorTheme.getPrimaryTextColor,
          //                                             fontWeight:
          //                                                 FontWeight.normal),
          //                                       ),
          //                                     ))
          //                                 // : Container();

          //                             : 
                                      
          //                             providersAnulada.getListaAnuladasPaginacion.length>25?
                                      
          //                             Container(
          //                                 margin: EdgeInsets.symmetric(
          //                                     vertical: size.iScreen(2.0)),
          //                                 child: const Center(
          //                                     child:
          //                                         CircularProgressIndicator())): Container();
          //                           },
          //                         );


          //                           }
          //                     },
          //                   ),
          //                 );
          //               },
          //             )
          //           ,
          // )),
   
   
   
   
   
    );
  }

  Future<void> onRefresh() async {
    final _controller = Provider.of<AnuladasController>(context, listen: false);
    _controller.setPage(0);
    _controller.setCantidad(25);
    _controller.buscaAllAnuladasPaginacion('', true,_controller.getTabIndex);
  }



}

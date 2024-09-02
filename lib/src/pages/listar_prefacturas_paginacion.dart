import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neitorcont/src/api/authentication_client.dart';
import 'package:neitorcont/src/controllers/comprobantes_controller.dart';
import 'package:neitorcont/src/controllers/prefacturas_controller.dart';

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

class ListarPreFacturasPaginacion extends StatefulWidget {
  const ListarPreFacturasPaginacion({Key? key}) : super(key: key);

  @override
  State<ListarPreFacturasPaginacion> createState() =>
      _ListarPreFacturasPaginacionState();
}

class _ListarPreFacturasPaginacionState
    extends State<ListarPreFacturasPaginacion> {
  final TextEditingController _textSearchController = TextEditingController();
  Session? _usuario;
  final _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        final _next = context.read<PreFacturasController>();
        if (_next.getpage != null) {
          _next.setPage(_next.getpage);
          //       providerSearchPropietario.setCantidad(25);
          _next.buscaAllPreFacturasPaginacion('', false,_next.getTabIndex);
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
    // final loadInfo = context.read<PreFacturasController>();
    // // Provider.of<PropietariosController>(context, listen: false);
    // // await loadInfo.buscaAllPreFacturas('');

    // final serviceSocket = context.read<SocketService>();
    // serviceSocket.socket!.on('server:guardadoExitoso', (data) async {
    //   if (data['tabla'] == 'prefacturas') {
    //     loadInfo.buscaAllPreFacturasPaginacion('', false,loadInfo.getTabIndex);
    //     // NotificatiosnService.showSnackBarSuccsses(data['msg']);
    //   }
    // });
    // serviceSocket.socket!.on('server:actualizadoExitoso', (data) async {
    //   if (data['tabla'] == 'prefacturas') {
    //     loadInfo.buscaAllPreFacturasPaginacion('', false,loadInfo.getTabIndex);
    //     // NotificatiosnService.showSnackBarSuccsses(data['msg']);
    //   }
    // });
    // serviceSocket.socket!.on('server:eliminadoExitoso', (data) async {
    //   if (data['tabla'] == 'prefacturas') {
    //     loadInfo.buscaAllPreFacturasPaginacion('', false,loadInfo.getTabIndex);
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
            title: Consumer<PreFacturasController>(
              builder: (_, providerSearchPreFacturas, __) {
                return Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: size.iScreen(0.1)),
                        child: (providerSearchPreFacturas
                                .btnSearchPreFacturaPaginacion)
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
                                            providerSearchPreFacturas
                                                .onSearchTextPreFacturaPaginacion(
                                                    text);

                                            if (providerSearchPreFacturas
                                                .nameSearchPreFacturaPaginacion
                                                .isEmpty) {
                                              //                 providerSearchFacturas
                                              //     .setErrorMascotasPaginacion(null);

                                              // providerSearchFacturas
                                              //     .setError401MascotasPaginacion(
                                              //         false);
                                              providerSearchPreFacturas
                                                  .setPage(0);
                                              providerSearchPreFacturas
                                                  .setCantidad(25);
                                              // providerSearchFacturas.setIsNext(false);
                                              providerSearchPreFacturas
                                                  .buscaAllPreFacturasPaginacion(
                                                      '', true,providerSearchPreFacturas.getTabIndex);

                                              //   providerSearchFacturas
                                              //       .setBtnSearchPropietarioPaginacion(
                                              //           !providerSearchFacturas
                                              //               .btnSearchPropietarioPaginacion);
                                              //   _textSearchController.text = "";
                                              //   providerSearchFacturas
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
                                            //   // providerSearchFacturas
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
                                  'PREFACTURAS',
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
                        providerSearchPreFacturas.btnSearchPreFacturaPaginacion
                            ? IconButton(
                                splashRadius: size.iScreen(3.0),
                                icon: Icon(
                                  Icons.search,
                                  size: size.iScreen(3.5),
                                  // color: Colors.white,
                                ),
                                onPressed: () {
                                  //=====================//
                                  if (providerSearchPreFacturas
                                          .nameSearchPreFacturaPaginacion
                                          .length >=
                                      3) {
                                    providerSearchPreFacturas
                                        .setErrorPreFacturasPaginacion(null);

                                    providerSearchPreFacturas
                                        .setError401PreFacturasPaginacion(
                                            false);
                                    providerSearchPreFacturas.setPage(0);
                                    providerSearchPreFacturas.setCantidad(25);

                                    providerSearchPreFacturas
                                        .buscaAllPreFacturasPaginacion(
                                            // '0803395581');
                                            ' ${providerSearchPreFacturas.nameSearchPreFacturaPaginacion}',
                                            true,providerSearchPreFacturas.getTabIndex);
                                  } else {
                                    print('NO HAACE NADA');
                                  }
                                })
                            : Container(),
                        IconButton(
                            splashRadius: 2.0,
                            icon: (!providerSearchPreFacturas
                                    .btnSearchPreFacturaPaginacion)
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
                              providerSearchPreFacturas
                                  .onSearchTextPreFacturaPaginacion("");
                              _textSearchController.text = '';

                              providerSearchPreFacturas
                                  .setBtnSearchPreFacturaPaginacion(
                                      !providerSearchPreFacturas
                                          .btnSearchPreFacturaPaginacion);

                              if (providerSearchPreFacturas
                                      .btnSearchPreFacturaPaginacion ==
                                  false) {
                                //=====================//
                                providerSearchPreFacturas
                                    .setErrorPreFacturasPaginacion(null);

                                providerSearchPreFacturas
                                    .setError401PreFacturasPaginacion(false);

                                providerSearchPreFacturas.setPage(0);
                                providerSearchPreFacturas.setCantidad(25);
                                providerSearchPreFacturas
                                    .buscaAllPreFacturasPaginacion('', true,providerSearchPreFacturas.getTabIndex);
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
    length: 2, // Número de tabs
    child: Column(
      children: [
        // TabBar
        TabBar(
          tabs: [
           Tab(
              child:
              Consumer<PreFacturasController>(builder: (_, valueHoy, __) {  
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
              Consumer<PreFacturasController>(builder: (_, valueAnteriores, __) {  
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
                        final ctrl=context.read<PreFacturasController>();
                       ctrl.setTabIndex(index);
                        if (  index==0) {
                          ctrl. setInfoBusquedaPreFacturasPaginacion([]);
                          ctrl.resetValorTotal();
                          //   ctrl.buscaAllPreFacturasPaginacion(
                          //       '',false,ctrl.getTabIndex);

                         final _controllerPreFacturas =
                                context.read<PreFacturasController>();

                            _controllerPreFacturas
                                .onSearchTextPreFacturaPaginacion("");

                            _controllerPreFacturas
                                .setBtnSearchPreFacturaPaginacion(false);
                            _controllerPreFacturas
                                .setErrorPreFacturasPaginacion(null);

                            _controllerPreFacturas
                                .setError401PreFacturasPaginacion(false);

                            _controllerPreFacturas.resetFormPreFacturas();
                            _controllerPreFacturas.setPage(0);
                            _controllerPreFacturas.setIsNext(false);
                            _controllerPreFacturas
                                .setInfoBusquedaPreFacturasPaginacion([]);
                            _controllerPreFacturas
                                .buscaAllPreFacturasPaginacion('', true,_controllerPreFacturas.getTabIndex);





                        }
                        if ( index==1) {
                           ctrl.setInfoBusquedaPreFacturasPaginacion([]);
                           ctrl.resetValorTotal();
                             ctrl.buscaAllPreFacturasPaginacion(
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
               Consumer<PreFacturasController>(
                        builder: (_, providersPrefacturas, __) {
                          if (providersPrefacturas
                                      .getErrorPreFacturasPaginacion ==
                                  null &&
                              providersPrefacturas
                                      .getError401PreFacturasPaginacion ==
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
                          } else if (providersPrefacturas
                                  .getErrorPreFacturasPaginacion ==
                              false) {
                            return const NoData(
                              label: 'No existen datos para mostar',
                            );
                          } else if (providersPrefacturas
                                  .getListaPreFacturasPaginacion.isEmpty &&
                              providersPrefacturas
                                      .getErrorPreFacturasPaginacion ==
                                  false) {
                            return const NoData(
                              label: 'No existen datos para mostar',
                            );
                          } else if (providersPrefacturas
                                  .getListaPreFacturasPaginacion.isEmpty &&
                              providersPrefacturas
                                      .getError401PreFacturasPaginacion ==
                                  true) {
                            return const NoData(
                              label:
                                  'Su sesión ha expirado, vuelva a iniciar sesión',
                            );
                          } else if (providersPrefacturas
                                  .getListaPreFacturasPaginacion.isEmpty &&
                              providersPrefacturas
                                      .getError401PreFacturasPaginacion ==
                                  false) {
                            return const NoData(
                              label: 'No existen datos para mostar',
                            );
                          }

                          return RefreshIndicator(
                             onRefresh: () => onRefresh(),
                            child: ListView.builder(
                              controller: _scrollController,
                              physics: const BouncingScrollPhysics(),
                              itemCount: providersPrefacturas
                                      .getListaPreFacturasPaginacion.length +
                                  1,
                              itemBuilder: (BuildContext context, int index) {
                                if (index <
                                    providersPrefacturas
                                        .getListaPreFacturasPaginacion.length) {
                                  var _color;
                                  final _prefacturas = providersPrefacturas
                                      .getListaPreFacturasPaginacion[index];
                          
                                  if (_prefacturas['venEstado'] == 'AUTORIZADO') {
                                    _color = Colors.green;
                                  } else if (_prefacturas['venEstado'] ==
                                      'SIN AUTORIZAR') {
                                    _color = Colors.orange;
                                  }
                                  if (_prefacturas['venEstado'] == 'ANULADA') {
                                    _color = Colors.red;
                                  }
                          
                                  return Slidable(
                                    startActionPane: ActionPane(
                                      // A motion is a widget used to control how the pane animates.
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
                                                                              // 'https://sysvet.neitor.com/reportes/carnet.php?id=${factura['venId']}&empresa=${_usuario!.rucempresa}',
                                                                              'https://syscontable.neitor.com/reportes/factura.php?codigo=${_prefacturas['venId']}&empresa=${_usuario!.rucempresa}',
                                                                          labelPdf:
                                                                              'infoFactura.pdf')),
                                                            );
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
                                               '${_prefacturas['venNomCliente'].substring(0, 1)}',
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
                                              SizedBox(
                                                width: size.wScreen(40.0),
                                                child: Text(
                                                  '${_prefacturas['venNomCliente']}',
                                                  style: GoogleFonts.lexendDeca(
                                                      // fontSize: size.iScreen(2.45),
                                                      // color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Text(
                                                '${_prefacturas['venEstado']}',
                                                // 'Estado: ',
                                                style: GoogleFonts.lexendDeca(
                                                    fontSize: size.iScreen(1.5),
                                                    color: _color,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          subtitle: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    // color: Colors.green,
                                                    width: size.wScreen(50.0),
                                                    child: Text(
                                                      '${_prefacturas['venNumFactura']}',
                                                      style:
                                                          GoogleFonts.lexendDeca(
                                                              fontSize: size
                                                                  .iScreen(1.5),
                                                              color:
                                                                  Colors.black54,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  Container(
                                                    // color: Colors.green,
                                                    width: size.wScreen(50.0),
                                                    child: Text(
                                                      _prefacturas['venFecReg'] !=
                                                              ''
                                                          ? '${_prefacturas['venFecReg'].replaceAll('T', "  ").replaceAll('.000Z', "  ")}'
                                                          : '--- --- ---',
                                                      style:
                                                          GoogleFonts.lexendDeca(
                                                              // fontSize: size.iScreen(2.45),
                                                              color: Colors.grey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                // color: Colors.green,
                                                // width: size.wScreen(100.0),
                                                child: Text(
                                                  '\$${_prefacturas['venTotal']}',
                                                  style: GoogleFonts.lexendDeca(
                                                      fontSize: size.iScreen(2.0),
                                                      color: Colors.black87,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                  overflow: TextOverflow.ellipsis,
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
                                  return Consumer<PreFacturasController>(
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
                                          // : Container();
                          
                                          : providersPrefacturas
                                                      .getListaPreFacturasPaginacion
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
                    ,
              Consumer<PreFacturasController>(
                        builder: (_, providersPrefacturas, __) {
                          if (providersPrefacturas
                                      .getErrorPreFacturasPaginacion ==
                                  null &&
                              providersPrefacturas
                                      .getError401PreFacturasPaginacion ==
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
                          } else if (providersPrefacturas
                                  .getErrorPreFacturasPaginacion ==
                              false) {
                            return const NoData(
                              label: 'No existen datos para mostar',
                            );
                          } else if (providersPrefacturas
                                  .getListaPreFacturasPaginacion.isEmpty &&
                              providersPrefacturas
                                      .getErrorPreFacturasPaginacion ==
                                  false) {
                            return const NoData(
                              label: 'No existen datos para mostar',
                            );
                          } else if (providersPrefacturas
                                  .getListaPreFacturasPaginacion.isEmpty &&
                              providersPrefacturas
                                      .getError401PreFacturasPaginacion ==
                                  true) {
                            return const NoData(
                              label:
                                  'Su sesión ha expirado, vuelva a iniciar sesión',
                            );
                          } else if (providersPrefacturas
                                  .getListaPreFacturasPaginacion.isEmpty &&
                              providersPrefacturas
                                      .getError401PreFacturasPaginacion ==
                                  false) {
                            return const NoData(
                              label: 'No existen datos para mostar',
                            );
                          }

                          return RefreshIndicator(
                             onRefresh: () => onRefresh(),
                            child: ListView.builder(
                              controller: _scrollController,
                              physics: const BouncingScrollPhysics(),
                              itemCount: providersPrefacturas
                                      .getListaPreFacturasPaginacion.length +
                                  1,
                              itemBuilder: (BuildContext context, int index) {
                                if (index <
                                    providersPrefacturas
                                        .getListaPreFacturasPaginacion.length) {
                                  var _color;
                                  final _prefacturas = providersPrefacturas
                                      .getListaPreFacturasPaginacion[index];
                          
                                  if (_prefacturas['venEstado'] == 'AUTORIZADO') {
                                    _color = Colors.green;
                                  } else if (_prefacturas['venEstado'] ==
                                      'SIN AUTORIZAR') {
                                    _color = Colors.orange;
                                  }
                                  if (_prefacturas['venEstado'] == 'ANULADA') {
                                    _color = Colors.red;
                                  }
                          
                                  return Slidable(
                                    startActionPane: ActionPane(
                                      // A motion is a widget used to control how the pane animates.
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
                                                                              // 'https://sysvet.neitor.com/reportes/carnet.php?id=${factura['venId']}&empresa=${_usuario!.rucempresa}',
                                                                              'https://syscontable.neitor.com/reportes/factura.php?codigo=${_prefacturas['venId']}&empresa=${_usuario!.rucempresa}',
                                                                          labelPdf:
                                                                              'infoFactura.pdf')),
                                                            );
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
                                               '${_prefacturas['venNomCliente'].substring(0, 1)}',
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
                                              SizedBox(
                                                width: size.wScreen(40.0),
                                                child: Text(
                                                  '${_prefacturas['venNomCliente']}',
                                                  style: GoogleFonts.lexendDeca(
                                                      // fontSize: size.iScreen(2.45),
                                                      // color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Text(
                                                '${_prefacturas['venEstado']}',
                                                // 'Estado: ',
                                                style: GoogleFonts.lexendDeca(
                                                    fontSize: size.iScreen(1.5),
                                                    color: _color,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          subtitle: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    // color: Colors.green,
                                                    width: size.wScreen(50.0),
                                                    child: Text(
                                                      '${_prefacturas['venNumFactura']}',
                                                      style:
                                                          GoogleFonts.lexendDeca(
                                                              fontSize: size
                                                                  .iScreen(1.5),
                                                              color:
                                                                  Colors.black54,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  Container(
                                                    // color: Colors.green,
                                                    width: size.wScreen(50.0),
                                                    child: Text(
                                                      _prefacturas['venFecReg'] !=
                                                              ''
                                                          ? '${_prefacturas['venFecReg'].replaceAll('T', "  ").replaceAll('.000Z', "  ")}'
                                                          : '--- --- ---',
                                                      style:
                                                          GoogleFonts.lexendDeca(
                                                              // fontSize: size.iScreen(2.45),
                                                              color: Colors.grey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                // color: Colors.green,
                                                // width: size.wScreen(100.0),
                                                child: Text(
                                                  '\$${_prefacturas['venTotal']}',
                                                  style: GoogleFonts.lexendDeca(
                                                      fontSize: size.iScreen(2.0),
                                                      color: Colors.black87,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                  overflow: TextOverflow.ellipsis,
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
                                  return Consumer<PreFacturasController>(
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
                                          // : Container();
                          
                                          : providersPrefacturas
                                                      .getListaPreFacturasPaginacion
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
                    ,
            ],
          ),
        ),
      ],
    ),
  ),
),

          //  Container(
          //   color: Colors.grey.shade100,
          //   width: size.wScreen(100.0),
          //   height: size.hScreen(100.0),
          //   padding: EdgeInsets.only(
          //     top: size.iScreen(0.0),
          //     right: size.iScreen(0.0),
          //     left: size.iScreen(0.0),
          //   ),
          //   child: 
          //    Consumer<PreFacturasController>(
          //               builder: (_, providersPrefacturas, __) {
          //                 if (providersPrefacturas
          //                             .getErrorPreFacturasPaginacion ==
          //                         null &&
          //                     providersPrefacturas
          //                             .getError401PreFacturasPaginacion ==
          //                         false) {
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
          //                 } else if (providersPrefacturas
          //                         .getErrorPreFacturasPaginacion ==
          //                     false) {
          //                   return const NoData(
          //                     label: 'No existen datos para mostar',
          //                   );
          //                 } else if (providersPrefacturas
          //                         .getListaPreFacturasPaginacion.isEmpty &&
          //                     providersPrefacturas
          //                             .getErrorPreFacturasPaginacion ==
          //                         false) {
          //                   return const NoData(
          //                     label: 'No existen datos para mostar',
          //                   );
          //                 } else if (providersPrefacturas
          //                         .getListaPreFacturasPaginacion.isEmpty &&
          //                     providersPrefacturas
          //                             .getError401PreFacturasPaginacion ==
          //                         true) {
          //                   return const NoData(
          //                     label:
          //                         'Su sesión ha expirado, vuelva a iniciar sesión',
          //                   );
          //                 } else if (providersPrefacturas
          //                         .getListaPreFacturasPaginacion.isEmpty &&
          //                     providersPrefacturas
          //                             .getError401PreFacturasPaginacion ==
          //                         false) {
          //                   return const NoData(
          //                     label: 'No existen datos para mostar',
          //                   );
          //                 }

          //                 return RefreshIndicator(
          //                    onRefresh: () => onRefresh(),
          //                   child: ListView.builder(
          //                     controller: _scrollController,
          //                     physics: const BouncingScrollPhysics(),
          //                     itemCount: providersPrefacturas
          //                             .getListaPreFacturasPaginacion.length +
          //                         1,
          //                     itemBuilder: (BuildContext context, int index) {
          //                       if (index <
          //                           providersPrefacturas
          //                               .getListaPreFacturasPaginacion.length) {
          //                         var _color;
          //                         final _prefacturas = providersPrefacturas
          //                             .getListaPreFacturasPaginacion[index];
                          
          //                         if (_prefacturas['venEstado'] == 'AUTORIZADO') {
          //                           _color = Colors.green;
          //                         } else if (_prefacturas['venEstado'] ==
          //                             'SIN AUTORIZAR') {
          //                           _color = Colors.orange;
          //                         }
          //                         if (_prefacturas['venEstado'] == 'ANULADA') {
          //                           _color = Colors.red;
          //                         }
                          
          //                         return Slidable(
          //                           startActionPane: ActionPane(
          //                             // A motion is a widget used to control how the pane animates.
          //                             motion: const ScrollMotion(),
                          
          //                             children: [
          //                               SlidableAction(
          //                                     backgroundColor: Colors.grey,
          //                                 foregroundColor: Colors.white,
          //                                 icon: Icons.list_alt_outlined,
          //                                 label: 'Más acciones',
          //                                 onPressed: (context) {
          //                                   showCupertinoModalPopup(
          //                                     context: context,
          //                                     builder: (BuildContext context) =>
          //                                         CupertinoActionSheet(
          //                                             title: Text(
          //                                               'Acciones',
          //                                               style: GoogleFonts
          //                                                   .lexendDeca(
          //                                                       fontSize: size
          //                                                           .iScreen(2.0),
          //                                                       color:
          //                                                           primaryColor,
          //                                                       fontWeight:
          //                                                           FontWeight
          //                                                               .normal),
          //                                             ),
          //                                             // message: const Text('Your options are '),
          //                                             actions: <Widget>[
          //                                               CupertinoActionSheetAction(
          //                                                 child: Row(
          //                                                   mainAxisAlignment:
          //                                                       MainAxisAlignment
          //                                                           .center,
          //                                                   children: [
          //                                                     Container(
          //                                                       margin: EdgeInsets.only(
          //                                                           right: size
          //                                                               .iScreen(
          //                                                                   2.0)),
          //                                                       child: Text(
          //                                                         'Ver PDF',
          //                                                         style: GoogleFonts.lexendDeca(
          //                                                             fontSize: size
          //                                                                 .iScreen(
          //                                                                     1.8),
          //                                                             color: Colors
          //                                                                 .black87,
          //                                                             fontWeight:
          //                                                                 FontWeight
          //                                                                     .normal),
          //                                                       ),
          //                                                     ),
          //                                                     const Icon(
          //                                                       FontAwesomeIcons
          //                                                           .filePdf,
          //                                                       color: Colors.red,
          //                                                     )
          //                                                   ],
          //                                                 ),
          //                                                 onPressed: () {
          //                                                   Navigator.pop(
          //                                                       context);
                          
          //                                                   Navigator.push(
          //                                                     context,
          //                                                     MaterialPageRoute(
          //                                                         builder: (context) =>
          //                                                             ViewsPDFs(
          //                                                                 infoPdf:
          //                                                                     // 'https://sysvet.neitor.com/reportes/carnet.php?id=${factura['venId']}&empresa=${_usuario!.rucempresa}',
          //                                                                     'https://syscontable.neitor.com/reportes/factura.php?codigo=${_prefacturas['venId']}&empresa=${_usuario!.rucempresa}',
          //                                                                 labelPdf:
          //                                                                     'infoFactura.pdf')),
          //                                                   );
          //                                                 },
          //                                               ),
          //                                             ],
          //                                             cancelButton:
          //                                                 CupertinoActionSheetAction(
          //                                               child: Text('Cancel',
          //                                                   style: GoogleFonts
          //                                                       .lexendDeca(
          //                                                           fontSize: size
          //                                                               .iScreen(
          //                                                                   2.0),
          //                                                           color: Colors
          //                                                               .red,
          //                                                           fontWeight:
          //                                                               FontWeight
          //                                                                   .normal)),
          //                                               isDefaultAction: true,
          //                                               onPressed: () {
          //                                                 Navigator.pop(
          //                                                     context, 'Cancel');
          //                                               },
          //                                             )),
          //                                   );
          //                                 },
          //                               ),
          //                             ],
          //                           ),
          //                           child: Card(
          //                             elevation: 5,
          //                             child: Container(
          //                               margin: EdgeInsets.only(
          //                                   bottom: size.iScreen(0.0)),
          //                               color: index % 2 == 0
          //                                   ? Colors.grey.shade50
          //                                   : Colors.grey.shade200,
          //                               child: ListTile(
          //                                 dense: true,
          //                                 visualDensity:
          //                                     VisualDensity.comfortable,
                                      
          //                                  leading: CircleAvatar(
          //                                   child: Text(
          //                                      '${_prefacturas['venNomCliente'].substring(0, 1)}',
          //                                     style: Theme.of(context)
          //                                         .textTheme
          //                                         .subtitle1,
          //                                   ),
          //                                   backgroundColor: Colors.grey[300],
          //                                 ),
          //                                 title: Row(
          //                                   mainAxisAlignment:
          //                                       MainAxisAlignment.spaceBetween,
          //                                   children: [
          //                                     SizedBox(
          //                                       width: size.wScreen(40.0),
          //                                       child: Text(
          //                                         '${_prefacturas['venNomCliente']}',
          //                                         style: GoogleFonts.lexendDeca(
          //                                             // fontSize: size.iScreen(2.45),
          //                                             // color: Colors.white,
          //                                             fontWeight:
          //                                                 FontWeight.normal),
          //                                         overflow: TextOverflow.ellipsis,
          //                                       ),
          //                                     ),
          //                                     Text(
          //                                       '${_prefacturas['venEstado']}',
          //                                       // 'Estado: ',
          //                                       style: GoogleFonts.lexendDeca(
          //                                           fontSize: size.iScreen(1.5),
          //                                           color: _color,
          //                                           fontWeight: FontWeight.bold),
          //                                     ),
          //                                   ],
          //                                 ),
          //                                 subtitle: Row(
          //                                   mainAxisAlignment:
          //                                       MainAxisAlignment.spaceBetween,
          //                                   children: [
          //                                     Column(
          //                                       mainAxisAlignment:
          //                                           MainAxisAlignment.start,
          //                                       children: [
          //                                         Container(
          //                                           // color: Colors.green,
          //                                           width: size.wScreen(50.0),
          //                                           child: Text(
          //                                             '${_prefacturas['venNumFactura']}',
          //                                             style:
          //                                                 GoogleFonts.lexendDeca(
          //                                                     fontSize: size
          //                                                         .iScreen(1.5),
          //                                                     color:
          //                                                         Colors.black54,
          //                                                     fontWeight:
          //                                                         FontWeight
          //                                                             .normal),
          //                                             overflow:
          //                                                 TextOverflow.ellipsis,
          //                                           ),
          //                                         ),
          //                                         Container(
          //                                           // color: Colors.green,
          //                                           width: size.wScreen(50.0),
          //                                           child: Text(
          //                                             _prefacturas['venFecReg'] !=
          //                                                     ''
          //                                                 ? '${_prefacturas['venFecReg'].replaceAll('T', "  ").replaceAll('.000Z', "  ")}'
          //                                                 : '--- --- ---',
          //                                             style:
          //                                                 GoogleFonts.lexendDeca(
          //                                                     // fontSize: size.iScreen(2.45),
          //                                                     color: Colors.grey,
          //                                                     fontWeight:
          //                                                         FontWeight
          //                                                             .normal),
          //                                           ),
          //                                         ),
          //                                       ],
          //                                     ),
          //                                     Container(
          //                                       // color: Colors.green,
          //                                       // width: size.wScreen(100.0),
          //                                       child: Text(
          //                                         '\$${_prefacturas['venTotal']}',
          //                                         style: GoogleFonts.lexendDeca(
          //                                             fontSize: size.iScreen(2.0),
          //                                             color: Colors.black87,
          //                                             fontWeight:
          //                                                 FontWeight.normal),
          //                                         overflow: TextOverflow.ellipsis,
          //                                       ),
          //                                     ),
          //                                   ],
          //                                 ),
          //                                 // trailing: Icon(Icons.more_vert),
          //                               ),
          //                             ),
          //                           ),
          //                         );
          //                       } else {
          //                         return Consumer<PreFacturasController>(
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
                          
          //                                 : providersPrefacturas
          //                                             .getListaPreFacturasPaginacion
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
          //           ,
          // ),
     
     
     
     
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
                                 
                                     //*************** RESET LA VARIABLE DE RESPONSE SOCKET***************************//
    final ctrlSocket=context.read<SocketService>();
     ctrlSocket.resetResponseSocket();
      //******************************************//

                                _ctrl.setFacturaOk(false);
                                 _ctrl.setExistCliente(true);
                                   _ctrl.setFormaDePago('');
                                _ctrl.setTipoDeTransaccion('N');
   _ctrl.setClienteComprbante({
			"perId": 1,
			"perNombre": "CONSUMIDOR FINAL",
			"perDocNumero": "9999999999999",
			"perDocTipo": "RUC",
			"perTelefono": "0000000001",
			"perDireccion": "s/n",
			"perEmail": [
				"sin@sincorreo.com"
			],
			"perCelular": [],
			"perOtros": [
				"ZZZ9999"
			]
		});
  
                              _ctrl.setTotal();
                              _ctrl.setTarifa({});
                               _ctrl.setTipoDocumento('');
                           
                     
                           
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                     CrearComprobante(
                                      user:_usuario ,
                                      tipo: 'CREATE',
                                    )));
                       
                      }
                  
            ,
          ),
          
          
          ),
    );
  }

    Future<void> onRefresh() async {
    final _controller = Provider.of<PreFacturasController>(context, listen: false);
    _controller.setPage(0);
    _controller.setCantidad(25);
    _controller.buscaAllPreFacturasPaginacion('', true,_controller.getTabIndex);
  }
}

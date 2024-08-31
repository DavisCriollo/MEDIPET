import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neitorcont/src/api/authentication_client.dart';
import 'package:neitorcont/src/controllers/comprobantes_controller.dart';
import 'package:neitorcont/src/controllers/facturas_controller.dart';

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

class ListarFacturasPaginacion extends StatefulWidget {
  const ListarFacturasPaginacion({Key? key}) : super(key: key);

  @override
  State<ListarFacturasPaginacion> createState() => _ListarFacturasPaginacionState();
}

class _ListarFacturasPaginacionState extends State<ListarFacturasPaginacion> {
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
    final loadInfo = context.read<FacturasController>();
    // Provider.of<PropietariosController>(context, listen: false);
    // await loadInfo.buscaAllFacturas('');

    final serviceSocket = context.read<SocketService>();
    serviceSocket.socket!.on('server:guardadoExitoso', (data) async {
      if (data['tabla'] == 'facturas') {
        loadInfo.buscaAllFacturasPaginacion('', false,loadInfo.getTabIndex);
        // NotificatiosnService.showSnackBarSuccsses(data['msg']);
      }
    });
    serviceSocket.socket!.on('server:actualizadoExitoso', (data) async {
      if (data['tabla'] == 'facturas') {
        loadInfo.buscaAllFacturasPaginacion('', false,loadInfo.getTabIndex);
        // NotificatiosnService.showSnackBarSuccsses(data['msg']);
      }
    });
    serviceSocket.socket!.on('server:eliminadoExitoso', (data) async {
      if (data['tabla'] == 'facturas') {
        loadInfo.buscaAllFacturasPaginacion('', false,loadInfo.getTabIndex);
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
       final  ctrl=context.read<FacturasController>();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          backgroundColor: Colors.grey.shade100,
           appBar: AppBar(
            // backgroundColor: primaryColor,
          
            title: Consumer<FacturasController>(
              builder: (_, providerSearchFacturas, __) {
                return Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: size.iScreen(0.1)),
                        child: (providerSearchFacturas
                                .btnSearchFacturaPaginacion)
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
                                            providerSearchFacturas
                                                .onSearchTextFacturaPaginacion(
                                                    text);

                                            if (providerSearchFacturas
                                                .nameSearchFacturaPaginacion
                                                .isEmpty) {
                                              //                 providerSearchFacturas
                                              //     .setErrorMascotasPaginacion(null);

                                              // providerSearchFacturas
                                              //     .setError401MascotasPaginacion(
                                              //         false);
                                              providerSearchFacturas.setPage(0);
                                              providerSearchFacturas
                                                  .setCantidad(25);
                                              // providerSearchFacturas.setIsNext(false);
                                              providerSearchFacturas
                                                  .buscaAllFacturasPaginacion(
                                                      '', true,ctrl.getTabIndex);

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
                                  'Facturas',
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
                        providerSearchFacturas.btnSearchFacturaPaginacion
                            ? IconButton(
                                splashRadius: size.iScreen(3.0),
                                icon: Icon(
                                  Icons.search,
                                  size: size.iScreen(3.5),
                                  // color: Colors.white,
                                ),
                                onPressed: () {
                                  //=====================//
                                  if (providerSearchFacturas
                                          .nameSearchFacturaPaginacion.length >=
                                      3) {
                                    providerSearchFacturas
                                        .setErrorFacturasPaginacion(null);

                                    providerSearchFacturas
                                        .setError401FacturasPaginacion(false);
                                    providerSearchFacturas.setPage(0);
                                    providerSearchFacturas.setCantidad(25);

                                    providerSearchFacturas
                                        .buscaAllFacturasPaginacion(
                                            // '0803395581');
                                            ' ${providerSearchFacturas.nameSearchFacturaPaginacion}',
                                            true,ctrl.getTabIndex);
                                  } else {
                                    print('NO HAACE NADA');
                                  }
                                })
                            : Container(),
                        IconButton(
                            splashRadius: 2.0,
                            icon: (!providerSearchFacturas
                                    .btnSearchFacturaPaginacion)
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
                              providerSearchFacturas
                                  .onSearchTextFacturaPaginacion("");
                              _textSearchController.text = '';

                              providerSearchFacturas
                                  .setBtnSearchFacturaPaginacion(
                                      !providerSearchFacturas
                                          .btnSearchFacturaPaginacion);

                              if (providerSearchFacturas
                                      .btnSearchFacturaPaginacion ==
                                  false) {
                                //=====================//
                                providerSearchFacturas
                                    .setErrorFacturasPaginacion(null);

                                providerSearchFacturas
                                    .setError401FacturasPaginacion(false);

                                providerSearchFacturas.setPage(0);
                                providerSearchFacturas.setCantidad(25);
                                providerSearchFacturas
                                    .buscaAllFacturasPaginacion('', true, ctrl.getTabIndex);
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
        // Aquí colocas el TabBar después del Container
        TabBar(
          labelStyle:TextStyle(
            fontSize:size.iScreen(2.5)
          ),
          tabs: [
            Tab(
              child:
              Consumer<FacturasController>(builder: (_, valueHoy, __) {  
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
              Consumer<FacturasController>(builder: (_, valueAnteriores, __) {  
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
                       ctrl.setTabIndex(index);
                        if (  index==0) {
                          ctrl. setInfoBusquedaFacturasPaginacion([]);
                          ctrl.resetValorTotal();
                              final _controllerFacturas =
                                context.read<FacturasController>();

                            _controllerFacturas
                                .onSearchTextFacturaPaginacion("");

                            _controllerFacturas
                                .setBtnSearchFacturaPaginacion(false);
                            _controllerFacturas
                                .setErrorFacturasPaginacion(null);

                            _controllerFacturas
                                .setError401FacturasPaginacion(false);

                            _controllerFacturas.resetFormFacturas();
                            _controllerFacturas.setPage(0);
                            _controllerFacturas.setIsNext(false);
                            _controllerFacturas
                                .setInfoBusquedaFacturasPaginacion([]);
                            _controllerFacturas.buscaAllFacturasPaginacion(
                                '',false,_controllerFacturas.getTabIndex);
                          
                          //   ctrl.buscaAllFacturasPaginacion(
                          //       '',false,ctrl.getTabIndex);

                        }
                        if ( index==1) {
                           ctrl.setInfoBusquedaFacturasPaginacion([]);
                           ctrl.resetValorTotal();
                             ctrl.buscaAllFacturasPaginacion(
                                '',false,ctrl.getTabIndex);
                        }
                      },
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.blue,
        ),
        // Utiliza Expanded para que TabBarView ocupe el espacio restante
        Expanded(
          child: TabBarView(
            children: [
              Container(
                color: Colors.grey.shade200,
                child: Consumer<FacturasController>(
                  builder: (_, providersfactura, __) {
                    if (providersfactura.getErrorFacturasPaginacion == null &&
                        providersfactura.getError401FacturasPaginacion == false) {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Cargando Datos...',
                              style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(1.5),
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: size.iScreen(1.0),
                            ),
                            const CircularProgressIndicator(),
                          ],
                        ),
                      );
                    } else if (providersfactura.getErrorFacturasPaginacion == false) {
                      return const NoData(
                        label: 'No existen datos para mostrar',
                      );
                    } else if (providersfactura.getListaFacturasPaginacion.isEmpty &&
                        providersfactura.getErrorFacturasPaginacion == false) {
                      return const NoData(
                        label: 'No existen datos para mostrar',
                      );
                    } else if (providersfactura.getListaFacturasPaginacion.isEmpty &&
                        providersfactura.getError401FacturasPaginacion == true) {
                      return const NoData(
                        label: 'Su sesión ha expirado, vuelva a iniciar sesión',
                      );
                    } else if (providersfactura.getListaFacturasPaginacion.isEmpty &&
                        providersfactura.getError401FacturasPaginacion == false) {
                      return const NoData(
                        label: 'No existen datos para mostrar',
                      );
                    }

                    return RefreshIndicator(
                      onRefresh: () => onRefresh(),
                      child: ListView.builder(
                        controller: _scrollController,
                        physics: const BouncingScrollPhysics(),
                        itemCount: providersfactura.getListaFacturasPaginacion.length + 1,
                        itemBuilder: (BuildContext context, int index) {
                          if (index < providersfactura.getListaFacturasPaginacion.length) {
                            var _color;
                             final factura = providersfactura.getListaFacturasPaginacion[index];
                            if (factura['venFecReg']==DateTime.now()) {
                               final factura = providersfactura.getListaFacturasPaginacion[index];
                            }
                           

                            if (factura['venEstado'] == 'AUTORIZADO') {
                              _color = Colors.green;
                            } else if (factura['venEstado'] == 'SIN AUTORIZAR') {
                              _color = Colors.orange;
                            }
                            if (factura['venEstado'] == 'ANULADA') {
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
                                                  )
                                                ],
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context);

                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => ViewsPDFs(
                                                      infoPdf:
                                                        'https://syscontable.neitor.com/reportes/factura.php?codigo=${factura['venId']}&empresa=${_usuario!.rucempresa}',
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
                                                  fontSize: size.iScreen(2.0),
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.normal,
                                                )),
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
                                        '${factura['venNomCliente'].substring(0, 1)}',
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
                                            '${factura['venNomCliente']}',
                                            style: GoogleFonts.lexendDeca(
                                              fontWeight: FontWeight.normal,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Text(
                                          '${factura['venEstado']}',
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
                                                '${factura['venNumFactura']}',
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
                                                factura['venFecReg'] != ''
                                                    ? '${factura['venFecReg'].replaceAll('T', "  ").replaceAll('.000Z', "  ")}'
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
                                            '\$${factura['venTotal']}',
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
                            return Consumer<FacturasController>(
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
                                        ))
                                    : providersfactura.getListaFacturasPaginacion.length > 25
                                        ? Container(
                                            margin: EdgeInsets.symmetric(vertical: size.iScreen(2.0)),
                                            child: const Center(child: CircularProgressIndicator()))
                                        : Container();
                              },
                            );
                          }
                        },
                      ),
                    );
                  },
                ),
              ),
             
             //*********** tab 2 *************//
Container(
                color: Colors.grey.shade200,
                child: Consumer<FacturasController>(
                  builder: (_, providersfactura, __) {
                    if (providersfactura.getErrorFacturasPaginacion == null &&
                        providersfactura.getError401FacturasPaginacion == false) {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Cargando Datos...',
                              style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(1.5),
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: size.iScreen(1.0),
                            ),
                            const CircularProgressIndicator(),
                          ],
                        ),
                      );
                    } else if (providersfactura.getErrorFacturasPaginacion == false) {
                      return const NoData(
                        label: 'No existen datos para mostrar',
                      );
                    } else if (providersfactura.getListaFacturasPaginacion.isEmpty &&
                        providersfactura.getErrorFacturasPaginacion == false) {
                      return const NoData(
                        label: 'No existen datos para mostrar',
                      );
                    } else if (providersfactura.getListaFacturasPaginacion.isEmpty &&
                        providersfactura.getError401FacturasPaginacion == true) {
                      return const NoData(
                        label: 'Su sesión ha expirado, vuelva a iniciar sesión',
                      );
                    } else if (providersfactura.getListaFacturasPaginacion.isEmpty &&
                        providersfactura.getError401FacturasPaginacion == false) {
                      return const NoData(
                        label: 'No existen datos para mostrar',
                      );
                    }

                    return RefreshIndicator(
                      onRefresh: () => onRefresh(),
                      child: ListView.builder(
                        controller: _scrollController,
                        physics: const BouncingScrollPhysics(),
                        itemCount: providersfactura.getListaFacturasPaginacion.length + 1,
                        itemBuilder: (BuildContext context, int index) {
                          if (index < providersfactura.getListaFacturasPaginacion.length) {
                            var _color;
                             final factura = providersfactura.getListaFacturasPaginacion[index];
                            if (factura['venFecReg']==DateTime.now()) {
                               final factura = providersfactura.getListaFacturasPaginacion[index];
                            }
                           

                            if (factura['venEstado'] == 'AUTORIZADO') {
                              _color = Colors.green;
                            } else if (factura['venEstado'] == 'SIN AUTORIZAR') {
                              _color = Colors.orange;
                            }
                            if (factura['venEstado'] == 'ANULADA') {
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
                                                  )
                                                ],
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context);

                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => ViewsPDFs(
                                                      infoPdf:
                                                        'https://syscontable.neitor.com/reportes/factura.php?codigo=${factura['venId']}&empresa=${_usuario!.rucempresa}',
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
                                                  fontSize: size.iScreen(2.0),
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.normal,
                                                )),
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
                                        '${factura['venNomCliente'].substring(0, 1)}',
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
                                            '${factura['venNomCliente']}',
                                            style: GoogleFonts.lexendDeca(
                                              fontWeight: FontWeight.normal,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Text(
                                          '${factura['venEstado']}',
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
                                                '${factura['venNumFactura']}',
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
                                                factura['venFecReg'] != ''
                                                    ? '${factura['venFecReg'].replaceAll('T', "  ").replaceAll('.000Z', "  ")}'
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
                                            '\$${factura['venTotal']}',
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
                            return Consumer<FacturasController>(
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
                                        ))
                                    : providersfactura.getListaFacturasPaginacion.length > 25
                                        ? Container(
                                            margin: EdgeInsets.symmetric(vertical: size.iScreen(2.0)),
                                            child: const Center(child: CircularProgressIndicator()))
                                        : Container();
                              },
                            );
                          }
                        },
                      ),
                    );
                  },
                ),
              ),
             
             


             //**********************************//
              
            ],
          ),
        ),
      ],
    ),
  ),
),

         
         
          // body: Container(
          //   color: Colors.grey.shade100,
          //   width: size.wScreen(100.0),
          //   height: size.hScreen(100.0),
          //   padding: EdgeInsets.only(
          //     top: size.iScreen(0.0),
          //     right: size.iScreen(0.0),
          //     left: size.iScreen(0.0),
          //   ),
          //   child: Consumer<FacturasController>(
          //               builder: (_, providersfactura, __) {
          //                 if (providersfactura.getErrorFacturasPaginacion == null &&
          //                     providersfactura.getError401FacturasPaginacion == false) {
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
          //                 } else if (providersfactura.getErrorFacturasPaginacion ==
          //                     false) {
          //                   return const NoData(
          //                     label: 'No existen datos para mostar',
          //                   );
          //                 } 
          //                  else if (providersfactura
          //                         .getListaFacturasPaginacion.isEmpty &&providersfactura.getErrorFacturasPaginacion ==
          //                     false ) {
          //                   return const NoData(
          //                     label: 'No existen datos para mostar',
          //                   );
          //                 }
          //                 else if (providersfactura
          //                         .getListaFacturasPaginacion.isEmpty &&
          //                     providersfactura.getError401FacturasPaginacion == true) {
          //                   return const NoData(
          //                     label:
          //                         'Su sesión ha expirado, vuelva a iniciar sesión',
          //                   );
          //                 } else if (providersfactura
          //                         .getListaFacturasPaginacion.isEmpty &&
          //                     providersfactura.getError401FacturasPaginacion == false) {
          //                   return const NoData(
          //                     label: 'No existen datos para mostar',
          //                   );
          //                 }

          //                 return RefreshIndicator(
          //                     onRefresh: () => onRefresh(),
          //                   child: ListView.builder(
          //                     controller: _scrollController,
          //                     physics: const BouncingScrollPhysics(),
          //                     itemCount: providersfactura.getListaFacturasPaginacion.length+1,
          //                     itemBuilder: (BuildContext context, int index) {

          //                          if (index <
          //                           providersfactura.getListaFacturasPaginacion.length) {


          //                       var _color;
          //                       final factura =
          //                           providersfactura.getListaFacturasPaginacion[index];
                          
          //                       if (factura['venEstado'] == 'AUTORIZADO') {
          //                         _color = Colors.green;
          //                       } else if (factura['venEstado'] ==
          //                           'SIN AUTORIZAR') {
          //                         _color = Colors.orange;
          //                       }
          //                       if (factura['venEstado'] == 'ANULADA') {
          //                         _color = Colors.red;
          //                       }
                          
          //                       return Slidable(
          //                         startActionPane: ActionPane(
          //                           // A motion is a widget used to control how the pane animates.
          //                           motion: const ScrollMotion(),
                          
          //                           children: [
          //                             SlidableAction(
          //                                       backgroundColor: Colors.grey,
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
          //                                                                   'https://syscontable.neitor.com/reportes/factura.php?codigo=${factura['venId']}&empresa=${_usuario!.rucempresa}',
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
                                
          //                                 leading: CircleAvatar(
          //                                 child: Text(
          //                                 '${factura['venNomCliente'].substring(0, 1)}',
          //                                   style: Theme.of(context)
          //                                       .textTheme
          //                                       .subtitle1,
          //                                 ),
          //                                 backgroundColor: Colors.grey[300],
          //                               ),
          //                               title: Row(
          //                                 mainAxisAlignment:
          //                                     MainAxisAlignment.spaceBetween,
          //                                 children: [
          //                                   SizedBox(
          //                                     width: size.wScreen(50.0),
          //                                     child: Text(
          //                                       '${factura['venNomCliente']}',
          //                                       style: GoogleFonts.lexendDeca(
          //                                           // fontSize: size.iScreen(2.45),
          //                                           // color: Colors.white,
          //                                           fontWeight:
          //                                               FontWeight.normal),
          //                                       overflow: TextOverflow.ellipsis,
          //                                     ),
          //                                   ),
          //                                   Text(
          //                                     '${factura['venEstado']}',
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
          //                                           '${factura['venNumFactura']}',
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
          //                                           factura['venFecReg'] != ''
          //                                               ? '${factura['venFecReg'].replaceAll('T', "  ").replaceAll('.000Z', "  ")}'
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
          //                                       '\$${factura['venTotal']}',
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

          //                              return Consumer<FacturasController>(
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
          //                                             // color: primaryColor,
          //                                             fontWeight:
          //                                                 FontWeight.normal),
          //                                       ),
          //                                     ))
          //                                 // : Container();

          //                             : 
                                      
          //                             providersfactura.getListaFacturasPaginacion.length>25?
                                      
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
          //          ,
          // ),
          floatingActionButton: 
         FloatingActionButton(
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      onPressed: () {
                         final _ctrl =context.read<ComprobantesController>();
                           _ctrl.resetListasProdutos();
                         _ctrl.resetPlacas();
                                _ctrl.setDocumento('');
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
    final _controller = Provider.of<FacturasController>(context, listen: false);
    _controller.setPage(0);
    _controller.setCantidad(25);
    _controller.buscaAllFacturasPaginacion('', true,_controller.getTabIndex);
  }



}

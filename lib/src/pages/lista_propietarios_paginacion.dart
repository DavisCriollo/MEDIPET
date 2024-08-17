import 'dart:io';


import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neitorcont/src/api/authentication_client.dart';
import 'package:neitorcont/src/controllers/mascotas_controller.dart';
import 'package:neitorcont/src/controllers/propietarios_controller.dart';
import 'package:neitorcont/src/models/sesison_model.dart';
import 'package:neitorcont/src/pages/crear_propietario.dart';
import 'package:neitorcont/src/pages/detalle_propietario.dart';
import 'package:neitorcont/src/pages/listar_mascotas_propietarios.dart';
import 'package:neitorcont/src/services/notifications_service.dart';
import 'package:neitorcont/src/services/socket_service.dart';
import 'package:neitorcont/src/theme/theme_provider.dart';
import 'package:neitorcont/src/theme/themes_app.dart';
import 'package:neitorcont/src/utils/responsive.dart';
import 'package:neitorcont/src/utils/theme.dart';
import 'package:neitorcont/src/widgets/no_data.dart';
// import 'package:open_file/open_file.dart';
import 'package:open_file_safe/open_file_safe.dart';
import 'package:path_provider/path_provider.dart';

import 'package:provider/provider.dart';

class ListaPropietariosPaginacion extends StatefulWidget {
  const ListaPropietariosPaginacion({Key? key}) : super(key: key);

  @override
  State<ListaPropietariosPaginacion> createState() =>
      _ListaPropietariosPaginacionState();
}

class _ListaPropietariosPaginacionState
    extends State<ListaPropietariosPaginacion> {
  final TextEditingController _textSearchController = TextEditingController();
  Session? _usuario;
  final serviceSocket = SocketService();

  final _loadListScroll = PropietariosController();
  final _scrollController = ScrollController();
  // final propietarioContrtoller = SocketService();
  // final loadInfo =PropietariosController();
  // Provider.of<PropietariosController>(context, listen: false);

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        //  print('ESTAMOS EN EL FINAL DE LA PANTALLA');
        // _loadListScroll.getpage;
        // _loadListScroll.setPage(_loadListScroll.getpage);
        //  _loadListScroll.buscaAllPropietariosPaginacion('');

        final _next = context.read<PropietariosController>();
        if (_next.getpage != null) {
          _next.setPage(_next.getpage);
          //       providerSearchPropietario.setCantidad(25);
          _next.buscaAllPropietariosPaginacion('', false);
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

    // print('object:${_usuario!.nomEmpresa}');
    final loadInfo = context.read<PropietariosController>();
    // Provider.of<PropietariosController>(context, listen: false);
    // loadInfo.setPage(0);
    //  loadInfo.setIsNext(false);
    // await loadInfo.buscaAllPropietariosPaginacion('', false);
    // _loadListScroll.setPage(0);
// await loadInfo.buscaRecomendaciones();
    // final serviceSocket = Provider.of<SocketService>(context, listen: false);
    serviceSocket.socket!.on('server:guardadoExitoso', (data) async {
      if (data['tabla'] == 'proveedor') {
        loadInfo.buscaAllPropietariosPaginacion('', false);
        // NotificatiosnService.showSnackBarSuccsses(data['msg']);
      }
    });
    serviceSocket.socket!.on('server:actualizadoExitoso', (data) async {
      if (data['tabla'] == 'proveedor') {
        loadInfo.buscaAllPropietariosPaginacion('', false);
        // NotificatiosnService.showSnackBarSuccsses(data['msg']);
      }
    });
    serviceSocket.socket!.on('server:eliminadoExitoso', (data) async {
      if (data['tabla'] == 'proveedor') {
        loadInfo.buscaAllPropietariosPaginacion('', false);
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

      final colorTheme=context.read<ThemeProvider>();


    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          // backgroundColor: Colors.grey.shade100,
          appBar: AppBar(
            // backgroundColor: primaryColor,
            // title: Text(
            //   'Propietarios',
            //   style: GoogleFonts.lexendDeca(
            //       fontSize: size.iScreen(2.45),
            //       color: Colors.white,
            //       fontWeight: FontWeight.normal),
            // ),
            
            title: Consumer<PropietariosController>(
              builder: (_, providerSearchPropietario, __) {
                return Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: size.iScreen(0.1)),
                        child: (providerSearchPropietario
                                .btnSearchPropietarioPaginacion)
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
                                            providerSearchPropietario
                                                .onSearchTextPropietarioPaginacion(
                                                    text);

                                            if (providerSearchPropietario
                                                .nameSearchPropietarioPaginacion
                                                .isEmpty) {
                                              providerSearchPropietario
                                                  .setPage(0);
                                              providerSearchPropietario
                                                  .setCantidad(25);
                                              // providerSearchPropietario.setIsNext(false);
                                              providerSearchPropietario
                                                  .buscaAllPropietariosPaginacion(
                                                      '', false);

                                              //   providerSearchPropietario
                                              //       .setBtnSearchPropietarioPaginacion(
                                              //           !providerSearchPropietario
                                              //               .btnSearchPropietarioPaginacion);
                                              //   _textSearchController.text = "";
                                              //   providerSearchPropietario
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
                                            //   // providerSearchPropietario
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
                                  'Propietarios',
                                  style:  
                                  
                                  GoogleFonts.lexendDeca(
                                      fontSize: size.iScreen(2.45),
                                      // color: Colors.white,
                                      fontWeight: FontWeight.normal),
                                 
                                ),
                              ),
                      ),
                    ),
                    Row(
                      children: [
                        providerSearchPropietario.btnSearchPropietarioPaginacion
                            ? IconButton(
                                splashRadius: size.iScreen(3.0),
                                icon: Icon(
                                  Icons.search,
                                  size: size.iScreen(3.5),
                                  // color: Colors.white,
                                ),
                                onPressed: () {
                                  
                                  //=====================//
                                  if (providerSearchPropietario
                                          .nameSearchPropietarioPaginacion
                                          .length >=
                                      3) {
                                    providerSearchPropietario
                                        .setErrorPropietariosPaginacion(null);

                                    providerSearchPropietario
                                        .setError401PropietariosPaginacion(
                                            false);
                                    providerSearchPropietario.setPage(0);
                                    providerSearchPropietario.setCantidad(25);

                                    providerSearchPropietario
                                        .buscaAllPropietariosPaginacion(
                                            // '0803395581');
                                            ' ${providerSearchPropietario.nameSearchPropietarioPaginacion}',
                                            true);
                                  } else {
                                    print('NO HAACE NADA');
                                  }
                                })
                            : Container(),
                        IconButton(
                            splashRadius: 2.0,
                            icon: (!providerSearchPropietario
                                    .btnSearchPropietarioPaginacion)
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
                            
                                   providerSearchPropietario.onSearchTextPropietarioPaginacion("");
                                   _textSearchController.text='';
                                   
                              providerSearchPropietario
                                  .setBtnSearchPropietarioPaginacion(
                                      !providerSearchPropietario
                                          .btnSearchPropietarioPaginacion);

                              if (providerSearchPropietario
                                      .btnSearchPropietarioPaginacion ==
                                  false) {

 //=====================//
                              providerSearchPropietario
                                  .setErrorPropietariosPaginacion(null);

                              providerSearchPropietario
                                  .setError401PropietariosPaginacion(false);

                              providerSearchPropietario.setPage(0);
                              providerSearchPropietario.setCantidad(25);
                              providerSearchPropietario
                                  .buscaAllPropietariosPaginacion('', true);
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
            child: Consumer<PropietariosController>(
                        builder: (_, providerPropietariosPaginacion, __) {
                          if (providerPropietariosPaginacion
                                      .getErrorPropietariosPaginacion ==
                                  null &&
                              providerPropietariosPaginacion
                                      .getError401PropietariosPaginacion ==
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
                          } else if (providerPropietariosPaginacion
                                  .getErrorPropietariosPaginacion ==
                              false) {
                            return const NoData(
                              label: 'No existen datos para mostar',
                            );
                            // Text("Error al cargar los datos");
                          } else if (providerPropietariosPaginacion
                                  .getListaPropietariosPaginacion.isEmpty &&
                              providerPropietariosPaginacion
                                      .getError401PropietariosPaginacion ==
                                  true) {
                            return const NoData(
                              label:
                                  'Su sesión ha expirado, vuelva a iniciar sesión',
                            );
                          }
                           else if (providerPropietariosPaginacion
                                  .getListaPropietariosPaginacion.isEmpty &&
                              providerPropietariosPaginacion
                                      .getError401PropietariosPaginacion ==
                                  false) {
                            return const NoData(
                              label: 'No existen datos para mostar',
                            );
                          }
                           else if (providerPropietariosPaginacion
                              .getListaPropietariosPaginacion.isEmpty) {
                            return Center(
                              // child: CircularProgressIndicator(),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const NoData(
                                      label:
                                          'No se encuenra registro, pero puede realizar en otro de nuestros servidores '),
                                  //***********************************************/
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(30.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        providerPropietariosPaginacion
                                            .getListaBusquedaPersonas
                                            .clear();
                                        _modalBottomSheetMenu(size);
                                        // context
                                        //     .read<PropietariosController>()
                                        //     .searchAllPersinas('');
                                        // Navigator.of(context).push(
                                        //     MaterialPageRoute(
                                        //         builder: (context) =>
                                        //             BuscarPropietario()));
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        color: alertColor,
                                        width: size.iScreen(5.0),
                                        padding: EdgeInsets.only(
                                          top: size.iScreen(0.5),
                                          bottom: size.iScreen(0.5),
                                          left: size.iScreen(0.5),
                                          right: size.iScreen(0.5),
                                        ),
                                        child: Icon(
                                          Icons.search_outlined,
                                          color: Colors.white,
                                          size: size.iScreen(3.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: size.iScreen(1.0),
                                  // ),
                                  //*****************************************/
                                  //  Container(
                                  //   color:Colors.red,child: IconButton(color: primaryColor,onPressed: (){}, icon: const Icon(Icons.search_outlined))),
                                ],
                              ),
                            );
                            // Text("sin datos");
                          }
                          // print('esta es la lista*******************: ${providerPropietariosPaginacion.getListaPropietariosPaginacion.length}');

                          return RefreshIndicator(
                            onRefresh: () => onRefresh(),
                            child: ListView.builder(
                              controller: _scrollController,
                              physics: const BouncingScrollPhysics(),
                              itemCount: providerPropietariosPaginacion
                                      .getListaPropietariosPaginacion.length +
                                  1,
                              itemBuilder: (BuildContext context, int index) {
                                if (index <
                                    providerPropietariosPaginacion
                                        .getListaPropietariosPaginacion
                                        .length) {
                                  final propietario =
                                      providerPropietariosPaginacion
                                              .getListaPropietariosPaginacion[
                                          index];
                                  return Slidable(
                                    startActionPane: ActionPane(
                                      // A motion is a widget used to control how the pane animates.
                                      motion:  ScrollMotion(),

                                      children: [
                                        SlidableAction(
                                    backgroundColor: colorTheme.appTheme.primaryColor,
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
                                                                    .iScreen(
                                                                        2.0),
                                                                // color:
                                                                //     primaryColor,
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
                                                                      fontSize:
                                                                          size.iScreen(
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
                                                            providerPropietariosPaginacion
                                                                .getInfoPropietario(
                                                                    propietario,
                                                                    true);
                                                            Navigator.pop(
                                                                context);

                                                            Navigator.of(
                                                                    context)
                                                                .push(MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            const DetallePropietarioPage()));
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
                                                                      fontSize:
                                                                          size.iScreen(
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
                                                            providerPropietariosPaginacion
                                                                .getInfoPropietario(
                                                                    propietario,
                                                                    true);
                                                            Navigator.pop(
                                                                context);
                                                            Navigator.of(
                                                                    context)
                                                                .push(MaterialPageRoute(
                                                                    builder: (context) =>
                                                                        const CrearPropietario(
                                                                            action:
                                                                                'EDIT')))
                                                                .then((value) =>
                                                                    onRefresh());
                                                          },
                                                        ),
                                                      ],
                                                      cancelButton:
                                                          CupertinoActionSheetAction(
                                                        child: Text('Cancel',
                                                            style: GoogleFonts.lexendDeca(
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
                                                          Navigator.pop(context,
                                                              'Cancel');
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
                                                  providerPropietariosPaginacion,
                                                  propietario['perId']);
                                            },
                                            backgroundColor: errorColor,
                                            foregroundColor: Colors.white,
                                            icon: Icons.delete,
                                            label: 'Eliminar',
                                          ),
                                        ]),
                                    child: GestureDetector(
                                      onTap: () {
                                        // providerPropietarios.getInfoPropietario(
                                        //     propietario, true);

                                        // Navigator.of(context).push(MaterialPageRoute(
                                        //     builder: (context) =>
                                        //         const DetallePropietarioPage()));

                                        //   Navigator.push(
                                        //       context,
                                        //       MaterialPageRoute(
                                        //           builder: ((context) =>
                                        //               const DetallePropietarioPage())));
                                      },
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
                                              //         radius: 20.0,
                                              child: Text(
                                                  '${propietario['perNombre'].substring(0, 1)}',
                                                  style:  Theme.of(context).textTheme.subtitle1,
                                                  // style: TextStyle(
                                                  //     color: colorTheme.getTerciaryTextColor,
                                                  //     )
                                                      ),
                                              backgroundColor: Colors.grey[300],
                                            ),
                                            title: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  width: size.wScreen(50.0),
                                                  child: Text(
                                                    '${propietario['perNombre']}',
                                                    style:Theme.of(context).textTheme.subtitle2,
                                                        // GoogleFonts.lexendDeca(
                                                        //     // fontSize: size.iScreen(2.45),
                                                        //     // color: Colors.white,
                                                        //     fontWeight:
                                                        //         FontWeight
                                                        //             .normal),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            subtitle: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  //  color: Colors.green,
                                                  //  width: size.wScreen(65.0),
                                                  child: Text(
                                                    propietario['perEmail']
                                                                .length >
                                                            0
                                                        ? '${propietario['perEmail'][0]}'
                                                        : '',
                                                    style:
                                                        GoogleFonts.lexendDeca(
                                                            // fontSize: size.iScreen(2.45),
                                                            color: Colors.grey,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  //  color: Colors.red,
                                                  //  width: size.wScreen(100.0),
                                                  child: Text(
                                                    propietario['perFecReg'] !=
                                                            ''
                                                        ? '${propietario['perFecReg'].replaceAll('T', "  ").replaceAll('.000Z', "  ")}'
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
                                            trailing: InkWell(
                                              onTap: () {
                                                final _mascotas = context
                                                    .read<MascotasController>();
                                                _mascotas
                                                    .buscaAllMascotasPropietario(
                                                        '',
                                                        propietario[
                                                            'perDocNumero']);
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ListaMascotasPropietario(
                                                              propietario:
                                                                  propietario,
                                                            )));
                                              },
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    child: Text(
                                                      'Mascotas',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              fontSize: size
                                                                  .hScreen(1.5),
                                                              color:
                                                                  colorTheme.appTheme.primaryColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal),
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Text(
                                                      '${propietario['mascotas']}',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              fontSize: size
                                                                  .iScreen(1.8),
                                                              color:
                                                                  colorTheme.appTheme.primaryColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return Consumer<PropietariosController>(
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
                                                      color:  colorTheme.appTheme.primaryColor,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                              ))
                                          : providerPropietariosPaginacion
                                        .getListaPropietariosPaginacion.length>25?
                                      
                                      Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: size.iScreen(2.0)),
                                          child: const Center(
                                              child:
                                                  CircularProgressIndicator())): Container();
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
              
                FloatingActionButton(
                    child: const Icon(
                      Icons.add,
                      // color: Colors.white,
                    ),
                    onPressed: () {
                      context
                          .read<PropietariosController>()
                          .resetFormPropietario();
                      Navigator.of(context)
                          .push(MaterialPageRoute(
                              builder: (context) =>
                                  const CrearPropietario(action: 'CREATE')))
                          .then((value) {
                       onRefresh();
                      });

                      // final _next = context.read<PropietariosController>();
                      // if (_next.getpage != null) {
                      //   _next.buscaAllPropietariosPaginacion('');
                      // } else {
                      //   print("ES NULL POR ESO NO HACER PETICION ");
                      // }
                    })
                
         ,
        ));
  }

  Future<void> onRefresh() async {
    final _controller =
        Provider.of<PropietariosController>(context, listen: false);
    _controller.setPage(0);
    _controller.setCantidad(25);
    _controller.buscaAllPropietariosPaginacion('', true);
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
                              // print('esta es la lista*******************: ${providerPersonas.getListaPropietariosPaginacion.length}');

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
                                                    .buscaAllPropietariosPaginacion(
                                                        '', false);
                                              }));

//                                             Navigator.pushNamed(context, 'crearPropietario').then((value) => setState(() {

// }));

                                      //  Navigator.of(context).push(MaterialPageRoute(
                                      // builder: (context) =>  CrearPropietario(action: 'EDIT')));
                                    },
                                    child:

                                        //  Card(
                                        //     color: Colors.white,
                                        //     shape: RoundedRectangleBorder(
                                        //         borderRadius:
                                        //             BorderRadius.circular(8)),
                                        //     margin: EdgeInsets.symmetric(
                                        //         vertical: size.iScreen(0.5),
                                        //         horizontal: size.iScreen(1.0)),
                                        //     elevation: 2,
                                        //     child: ClipRRect(
                                        //       borderRadius:
                                        //           BorderRadius.circular(8),
                                        //       child: Row(
                                        //         children: [
                                        //           Expanded(
                                        //             child: Container(
                                        //               padding: EdgeInsets.symmetric(
                                        //                   horizontal:
                                        //                       size.iScreen(0.0),
                                        //                   vertical:
                                        //                       size.iScreen(1.0)),
                                        //               child: Column(
                                        //                 children: <Widget>[
                                        //                   Container(
                                        //                     width:
                                        //                         size.wScreen(100.0),
                                        //                     padding: EdgeInsets
                                        //                         .symmetric(
                                        //                             horizontal: size
                                        //                                 .iScreen(
                                        //                                     1.0),
                                        //                             vertical: size
                                        //                                 .iScreen(
                                        //                                     0.2)),
                                        //                     child: Text(
                                        //                       '${persona['perNombre']}',
                                        //                       style: GoogleFonts
                                        //                           .lexendDeca(
                                        //                               // fontSize: size.iScreen(2.45),
                                        //                               // color: Colors.white,
                                        //                               fontWeight:
                                        //                                   FontWeight
                                        //                                       .normal),
                                        //                     ),
                                        //                   ),
                                        //                   Container(
                                        //                     width:
                                        //                         size.wScreen(100.0),
                                        //                     // color: Colors.red,
                                        //                     padding: EdgeInsets
                                        //                         .symmetric(
                                        //                             horizontal: size
                                        //                                 .iScreen(
                                        //                                     1.0),
                                        //                             vertical: size
                                        //                                 .iScreen(
                                        //                                     0.2)),
                                        //                     child: Container(
                                        //                       // color: Colors.green,
                                        //                       width: size
                                        //                           .wScreen(30.0),
                                        //                       child: Text(
                                        //                         '${persona['perDocNumero']}',
                                        //                         style: GoogleFonts
                                        //                             .lexendDeca(
                                        //                                 // fontSize: size.iScreen(2.45),
                                        //                                 color: Colors
                                        //                                     .grey,
                                        //                                 fontWeight:
                                        //                                     FontWeight
                                        //                                         .normal),
                                        //                       ),
                                        //                     ),
                                        //                   ),
                                        //                 ],
                                        //               ),
                                        //             ),
                                        //           ),
                                        //           Column(
                                        //             children: <Widget>[
                                        //               Container(
                                        //                 // width: size.wScreen(100.0),
                                        //                 padding:
                                        //                     EdgeInsets.symmetric(
                                        //                         horizontal: size
                                        //                             .iScreen(1.0),
                                        //                         vertical: size
                                        //                             .iScreen(0.5)),
                                        //                 child: const Icon(
                                        //                   Icons.chevron_right,
                                        //                   color: Colors.grey,
                                        //                 ),
                                        //               ),
                                        //             ],
                                        //           ),
                                        //         ],
                                        //       ),
                                        //     )),

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
                                            //         radius: 20.0,
                                            child: Text(
                                                '${persona['perNombre'].substring(0, 1)}',
                                                style: TextStyle(
                                                    color: primaryColor)),
                                            backgroundColor: Colors.grey[300],
                                          ),
                                          title: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: size.wScreen(30.0),
                                                child: Text(
                                                  '${persona['perNombre']} asdasd',
                                                  style: GoogleFonts.lexendDeca(
                                                      // fontSize: size.iScreen(2.45),
                                                      // color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Container(
                                                // color: Colors.green,
                                                // width:
                                                // size.wScreen(100.0),
                                                child: Text(
                                                  'Doc: ${persona['perDocNumero']}',
                                                  style: GoogleFonts.lexendDeca(
                                                      fontSize:
                                                          size.iScreen(1.5),
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.normal),
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
                                                    '${persona['perDocNumero']}',
                                                    style:
                                                        GoogleFonts.lexendDeca(
                                                            // fontSize: size.iScreen(2.45),
                                                            color: Colors.grey,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                // color: Colors.green,
                                                width: size.wScreen(100.0),
                                                child: Text(
                                                  persona['hospFecReg'] != ''
                                                      ? '${persona['hospFecReg'].replaceAll('T', "  ").replaceAll('.000Z', "  ")}'
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

  void _showAlertDialog(PropietariosController _controller, int _id) {
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
                    _controller.eliminaPropietario(buildcontext, _id);
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

//========================================//
// ===================================//

}

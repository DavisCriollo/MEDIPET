import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neitorcont/src/api/authentication_client.dart';
import 'package:neitorcont/src/controllers/prefacturas_controller.dart';

import 'package:neitorcont/src/controllers/proformas_controller.dart';

import 'package:neitorcont/src/models/sesison_model.dart';
import 'package:neitorcont/src/pages/views_pdf.dart';
import 'package:neitorcont/src/services/notifications_service.dart';
import 'package:neitorcont/src/services/socket_service.dart';
import 'package:neitorcont/src/utils/responsive.dart';
import 'package:neitorcont/src/utils/theme.dart';
import 'package:neitorcont/src/widgets/no_data.dart';
import 'package:provider/provider.dart';

class ListarPreFacturas extends StatefulWidget {
  const ListarPreFacturas({Key? key}) : super(key: key);

  @override
  State<ListarPreFacturas> createState() => _ListarPreFacturasState();
}

class _ListarPreFacturasState extends State<ListarPreFacturas> {
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
    // final loadInfo = context.read<PreFacturasController>();
    // // Provider.of<PropietariosController>(context, listen: false);
    // // await loadInfo.buscaAllPreFacturas('');

    // final serviceSocket = context.read<SocketService>();
    // serviceSocket.socket!.on('server:guardadoExitoso', (data) async {
    //   if (data['tabla'] == 'prefacturas') {
    //     loadInfo.buscaAllPreFacturas('');
    //     // NotificatiosnService.showSnackBarSuccsses(data['msg']);
    //   }
    // });
    // serviceSocket.socket!.on('server:actualizadoExitoso', (data) async {
    //   if (data['tabla'] == 'prefacturas') {
    //     loadInfo.buscaAllPreFacturas('');
    //     // NotificatiosnService.showSnackBarSuccsses(data['msg']);
    //   }
    // });
    // serviceSocket.socket!.on('server:eliminadoExitoso', (data) async {
    //   if (data['tabla'] == 'prefacturas') {
    //     loadInfo.buscaAllPreFacturas('');
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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          backgroundColor: Colors.grey.shade100,
          appBar: AppBar(
            title: Consumer<PreFacturasController>(
              builder: (_, providerSearchPrefacturas, __) {
                return Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: size.iScreen(0.1)),
                        child: (providerSearchPrefacturas.btnSearchPreFacturas)
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
                                            providerSearchPrefacturas
                                                .onSearchTextPrefacturas(text);

                                            if (providerSearchPrefacturas
                                                .nameSearchPrefacturas
                                                .isEmpty) {
                                              providerSearchPrefacturas
                                                  .buscaAllPreFacturas('');
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
                                  'Prefacturas',
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
                        icon: (!providerSearchPrefacturas.btnSearchPreFacturas)
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
                          providerSearchPrefacturas.setBtnSearchPreFacturas(
                              !providerSearchPrefacturas.btnSearchPreFacturas);
                          _textSearchController.text = "";
                          providerSearchPrefacturas.buscaAllPreFacturas('');
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
            child: Consumer<PreFacturasController>(
                        builder: (_, providersPrefacturas, __) {
                          if (providersPrefacturas.getErrorPreFacturas ==
                                  null &&
                              providersPrefacturas.getError401PreFacturas ==
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
                          } else if (providersPrefacturas.getErrorPreFacturas ==
                              false) {
                            return const NoData(
                              label: 'No existen datos para mostar',
                            );
                          } else if (providersPrefacturas
                                  .getListaPreFacturas.isEmpty &&
                              providersPrefacturas.getErrorPreFacturas ==
                                  false) {
                            return const NoData(
                              label: 'No existen datos para mostar',
                            );
                          } else if (providersPrefacturas
                                  .getListaPreFacturas.isEmpty &&
                              providersPrefacturas.getError401PreFacturas ==
                                  true) {
                            return const NoData(
                              label:
                                  'Su sesión ha expirado, vuelva a iniciar sesión',
                            );
                          } 
                          else if (providersPrefacturas
                                  .getListaPreFacturas.isEmpty &&
                              providersPrefacturas.getError401PreFacturas ==
                                  false) {
                            return const NoData(
                              label: 'No existen datos para mostar',
                            );
                          }

                          return ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount:
                                providersPrefacturas.getListaPreFacturas.length +1,
                            itemBuilder: (BuildContext context, int index) {
                              

                              
                              var _color;
                              final _prefacturas = providersPrefacturas
                                  .getListaPreFacturas[index];

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

                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  ViewsPDFs(
                                                                      infoPdf:
                                                                          // 'https://sysvet.neitor.com/reportes/carnet.php?id=${factura['venId']}&empresa=${_usuario!.rucempresa}',
                                                                          'https://syscontable.neitor.com/reportes/proformas.php?codigo=${_prefacturas['venId']}&empresa=${_usuario!.rucempresa}',
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
                                      leading: CircleAvatar(
                                        //         radius: 20.0,
                                        child: Text(
                                            '${_prefacturas['venNomCliente'].substring(0, 1)}',
                                            style: const TextStyle(
                                                color: primaryColor)),
                                        backgroundColor: Colors.grey[300],
                                      ),
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: size.wScreen(50.0),
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
                                                  '${_prefacturas['venNum_prefacturas']}',
                                                  style: GoogleFonts.lexendDeca(
                                                      fontSize:
                                                          size.iScreen(1.5),
                                                      color: Colors.black54,
                                                      fontWeight:
                                                          FontWeight.normal),
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
                                                  style: GoogleFonts.lexendDeca(
                                                      // fontSize: size.iScreen(2.45),
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.normal),
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
                            },
                          );
                        },
                      )
                    ,
          )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neitorcont/src/controllers/propietarios_controller.dart';
import 'package:neitorcont/src/pages/crear_propietario.dart';
import 'package:neitorcont/src/pages/detalle_propietario.dart';
import 'package:neitorcont/src/services/notifications_service.dart';
import 'package:neitorcont/src/services/socket_service.dart';
import 'package:neitorcont/src/utils/responsive.dart';
import 'package:neitorcont/src/utils/theme.dart';
import 'package:neitorcont/src/widgets/no_data.dart';

import 'package:provider/provider.dart';

class BuscarPropietario extends StatefulWidget {
  const BuscarPropietario({Key? key}) : super(key: key);

  @override
  State<BuscarPropietario> createState() => _BuscarPropietarioState();
}

class _BuscarPropietarioState extends State<BuscarPropietario> {
  final TextEditingController _textSearchController = TextEditingController();
  final serviceSocket = SocketService();
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
    final loadInfo =
        Provider.of<PropietariosController>(context, listen: false);
    loadInfo.buscaAllPropietarios('');

    // final serviceSocket = Provider.of<SocketService>(context, listen: false);
    serviceSocket.socket!.on('server:guardadoExitoso', (data) async {
      if (data['tabla'] == 'proveedor') {
        loadInfo.buscaAllPropietarios('');
        NotificatiosnService.showSnackBarSuccsses(data['msg']);
      }
    });
    serviceSocket.socket!.on('server:actualizadoExitoso', (data) async {
      if (data['tabla'] == 'proveedor') {
        loadInfo.buscaAllPropietarios('');
        NotificatiosnService.showSnackBarSuccsses(data['msg']);
      }
    });
    serviceSocket.socket!.on('server:eliminadoExitoso', (data) async {
      if (data['tabla'] == 'proveedor') {
        loadInfo.buscaAllPropietarios('');
        NotificatiosnService.showSnackBarSuccsses(data['msg']);
      }
    });
    serviceSocket.socket?.on('server:error', (data) {
      NotificatiosnService.showSnackBarError(data['msg']);
    });
  }

  @override
  Widget build(BuildContext context) {
 
    final Responsive size = Responsive.of(context);
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Colors.grey.shade100,
          appBar: AppBar(
            
            // backgroundColor: primaryColor,
            // title: Text(
            //   'Mis Ausencias',
            //   style: GoogleFonts.lexendDeca(
            //       fontSize: size.iScreen(2.45),
            //       color: Colors.white,
            //       fontWeight: FontWeight.normal),
            // ),
            title: Consumer<PropietariosController>(
              builder: (_, providerSearchPersona, __) {
                return Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: size.iScreen(0.1)),
                        child: (providerSearchPersona.btnSearchPersona)
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
                                            providerSearchPersona
                                                .onSearchTextPersona(text);

                                            if (providerSearchPersona
                                                .nameSearchPersona.isEmpty) {
                                              providerSearchPersona
                                                  .searchAllPersinas('');
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
                                  'Buscar Persona',
                                  style:  Theme.of(context).textTheme.headline2,
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
                        icon: (!providerSearchPersona.btnSearchPersona)
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
                          providerSearchPersona.setBtnSearchPersona(
                              !providerSearchPersona.btnSearchPersona);
                          _textSearchController.text = "";
                          providerSearchPersona.searchAllPersinas('');
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
            child: Consumer<PropietariosController>(
                        builder: (_, providerPersonas, __) {
                          if (providerPersonas.getErrorBusquedaPersona ==
                              null) {
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
                          } else if (providerPersonas.getErrorBusquedaPersona ==
                              false) {
                            return const NoData(
                              label: 'No existen datos para mostar',
                            );
                            // Text("Error al cargar los datos");
                          } else if (providerPersonas
                              .getListaBusquedaPersonas.isEmpty) {
                            return const NoData(
                              label: 'No existen datos para mostar',
                            );
                            // Text("sin datos");
                          }
                          // print('esta es la lista*******************: ${providerPersonas.getListaPropietarios.length}');

                          return ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: providerPersonas
                                .getListaBusquedaPersonas.length,
                            itemBuilder: (BuildContext context, int index) {
                              final persona = providerPersonas
                                  .getListaBusquedaPersonas[index];
                              return GestureDetector(
                                onTap: () {
                                

                                  providerPersonas.getInfoPropietario(
                                      persona, true);
                                  Navigator.pop(context);



//                                             Navigator.pushNamed(context, 'crearPropietario').then((value) => setState(() {

// }));

                                  //  Navigator.of(context).push(MaterialPageRoute(
                                  // builder: (context) =>  CrearPropietario(action: 'EDIT'))).then((value) => setState(() {
                                    
                                  // },));
                                },
                                child: Card(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    margin: EdgeInsets.symmetric(
                                        vertical: size.iScreen(0.5),
                                        horizontal: size.iScreen(1.0)),
                                    elevation: 2,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: size.iScreen(0.0),
                                                  vertical: size.iScreen(1.0)),
                                              child: Column(
                                                children: <Widget>[
                                                  Container(
                                                    width: size.wScreen(100.0),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: size
                                                                .iScreen(1.0),
                                                            vertical: size
                                                                .iScreen(0.2)),
                                                    child: Text(
                                                      '${persona['perNombre']}',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.45),
                                                              // color: Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: size.wScreen(100.0),
                                                    // color: Colors.red,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: size
                                                                .iScreen(1.0),
                                                            vertical: size
                                                                .iScreen(0.2)),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          // color: Colors.green,
                                                          width: size
                                                              .wScreen(30.0),
                                                          child: Text(
                                                            '${persona['perDocNumero']}',
                                                            style: GoogleFonts
                                                                .lexendDeca(
                                                                    // fontSize: size.iScreen(2.45),
                                                                    color: Colors
                                                                        .grey,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: size
                                                              .wScreen(50.0),
                                                          // color: Colors.blue,
                                                          child: Text(
                                                            '${persona['perEmail'].first}',
                                                            style: GoogleFonts
                                                                .lexendDeca(
                                                                    // fontSize: size.iScreen(2.45),

                                                                    color: Colors
                                                                        .grey,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Column(
                                            children: <Widget>[
                                              Container(
                                                // width: size.wScreen(100.0),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        size.iScreen(1.0),
                                                    vertical:
                                                        size.iScreen(0.5)),
                                                child: const Icon(
                                                  Icons.chevron_right,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )),
                              );
                            },
                          );
                        },
                      )
                    
          ),
        ));
  }
}

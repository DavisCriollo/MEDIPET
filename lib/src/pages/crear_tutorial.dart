import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:neitorcont/src/controllers/videos_controller.dart';
import 'package:neitorcont/src/services/notifications_service.dart';
import 'package:neitorcont/src/services/socket_service.dart';
import 'package:neitorcont/src/utils/letras_mayusculas_minusculas.dart';

import 'package:neitorcont/src/utils/responsive.dart';
import 'package:neitorcont/src/utils/theme.dart';
import 'package:neitorcont/src/widgets/no_data.dart';
import 'package:provider/provider.dart';

class CrearTutorial extends StatefulWidget {
  const CrearTutorial({Key? key}) : super(key: key);

  @override
  State<CrearTutorial> createState() => _CrearTutorialState();
}

class _CrearTutorialState extends State<CrearTutorial> {
  @override
  Widget build(BuildContext context) {
    final _action = ModalRoute.of(context)!.settings.arguments;
    final Responsive size = Responsive.of(context);
    final controllerVideos = context.read<VideosController>();
    // _action as List;
    // print('object: ${_action[1]}');

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: _action == 'CREATE' || _action == 'SEARCH'
              ?  Text('Crear Tutorial',style:  Theme.of(context).textTheme.headline2,)
              :  Text('Editar Tutorial',style:  Theme.of(context).textTheme.headline2,),
          actions: [
            Consumer<SocketService>(builder: (_, valueConexion, __) {
              return valueConexion.serverStatus == ServerStatus.Online
                  ? Container(
                      margin: EdgeInsets.only(right: size.iScreen(1.5)),
                      child: IconButton(
                          splashRadius: 28,
                          onPressed: () {
                            _onSubmit(
                                context, controllerVideos, _action.toString());
                          },
                          icon: Icon(
                            Icons.save_outlined,
                            size: size.iScreen(4.0),
                          )),
                    )
                  : Container();
            })
            // Container(
            //   margin: EdgeInsets.only(right: size.iScreen(1.5)),
            //   child: IconButton(
            //       splashRadius: 28,
            //       onPressed: () {
            //         _onSubmit(context, controllerReceta,_action.toString());
            //       },
            //       icon: Icon(
            //         Icons.save_outlined,
            //         size: size.iScreen(4.0),
            //       )),
            // )
          ],
        ),
        body: Container(
            // color: Colors.red,
            margin: EdgeInsets.only(
                left: size.iScreen(1.0),
                right: size.iScreen(1.0),
                bottom: size.iScreen(1.0)),
            width: size.wScreen(100),
            height: size.hScreen(100),
            child:  SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Form(
                        key: controllerVideos.videosFormKey,
                        child: Column(
                          children: [
                            SizedBox(
                              height: size.iScreen(0.0),
                            ),
                            //***********************************************/
                            SizedBox(
                              height: size.iScreen(1.5),
                            ),
                            //*****************************************/
                            Row(
                              children: [
                                SizedBox(
                                  // width: size.wScreen(100.0),

                                  // color: Colors.blue,
                                  child: Text('Categoría ',
                                      style: GoogleFonts.lexendDeca(
                                          // fontSize: size.iScreen(2.0),
                                          fontWeight: FontWeight.normal,
                                          color: Colors.grey)),
                                ),
                                SizedBox(
                                  width: size.iScreen(2.0),
                                ),
                                _action == 'CREATE' || _action == 'EDIT'
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: GestureDetector(
                                          onTap: () {
                                            _buscarCategoria(context, size);

                                            //*******************************************/
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            color: primaryColor,
                                            width: size.iScreen(3.5),
                                            padding: EdgeInsets.only(
                                              top: size.iScreen(0.5),
                                              bottom: size.iScreen(0.5),
                                              left: size.iScreen(0.5),
                                              right: size.iScreen(0.5),
                                            ),
                                            child: Icon(
                                              Icons.search_outlined,
                                              color: Colors.white,
                                              size: size.iScreen(2.0),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                            //***********************************************/
                            SizedBox(
                              height: size.iScreen(1.0),
                            ),
                            //*****************************************/
                            Consumer<VideosController>(
                              builder: (_, valueCategoria, __) {
                                return SizedBox(
                                  width: size.wScreen(100.0),

                                  // color: Colors.blue,
                                  child: Text(
                                      valueCategoria.getNombreCategoria!.isEmpty
                                          ? 'DEBE AGREGAR CATEGORÍA '
                                          : valueCategoria.getNombreCategoria!,
                                      style: GoogleFonts.lexendDeca(
                                          // fontSize: size.iScreen(2.0),
                                          fontWeight: FontWeight.normal,
                                          color: valueCategoria
                                                  .getNombreCategoria!.isEmpty
                                              ? Colors.grey
                                              : Colors.black)),
                                );
                              },
                            ),

                            //***********************************************/
                            SizedBox(
                              height: size.iScreen(1.5),
                            ),
                            //*****************************************/
                            Container(
                              width: size.wScreen(100.0),

                              // color: Colors.blue,
                              child: Text('Título:',
                                  style: GoogleFonts.lexendDeca(
                                      // fontSize: size.iScreen(2.0),
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey)),
                            ),
                            Container(
                              // width: size.wScreen(20.0),
                              child: TextFormField(
                                initialValue:
                                    _action == 'CREATE' || _action == 'EDIT'
                                        ? ''
                                        : controllerVideos.getTituloVideo,
                                // keyboardType: TextInputType.number,
                                // inputFormatters: <TextInputFormatter>[
                                //   FilteringTextInputFormatter.allow(
                                //       RegExp(r'[0-9.]')),
                                // ],
                                decoration: const InputDecoration(
                                    // suffixIcon: Icon(Icons.beenhere_outlined)
                                    ),
                                readOnly: _action == 'EDIT' ? true : false,
                                inputFormatters: [
                                  UpperCaseText(),
                                ],
                                // textAlign: TextAlign.center,
                                maxLines: 3,
                                minLines: 1,
                                style: TextStyle(
                                  fontSize: size.iScreen(2.0),
                                  // fontWeight: FontWeight.bold,
                                  // letterSpacing: 2.0,
                                ),
                                onChanged: (text) {
                                  controllerVideos.setTituloVideo(text);
                                },
                              ),
                            ),
                            //***********************************************/
                            SizedBox(
                              height: size.iScreen(1.5),
                            ),
                            //*****************************************/
                            Container(
                              width: size.wScreen(100.0),

                              // color: Colors.blue,
                              child: Text('Url del video:',
                                  style: GoogleFonts.lexendDeca(
                                      // fontSize: size.iScreen(2.0),
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey)),
                            ),
                            Container(
                              // width: size.wScreen(20.0),
                              child: TextFormField(
                                initialValue:
                                    _action == 'CREATE' || _action == 'EDIT'
                                        ? ''
                                        : controllerVideos.getUrlVideo,
                                // keyboardType: TextInputType.number,
                                // inputFormatters: <TextInputFormatter>[
                                //   FilteringTextInputFormatter.allow(
                                //       RegExp(r'[0-9.]')),
                                // ],
                                decoration: const InputDecoration(
                                    // suffixIcon: Icon(Icons.beenhere_outlined)
                                    ),
                                readOnly: _action == 'EDIT' ? true : false,
                                // textAlign: TextAlign.center,
                                maxLines: 3,
                                minLines: 3,
                                style: TextStyle(
                                  fontSize: size.iScreen(2.0),
                                  // fontWeight: FontWeight.bold,
                                  // letterSpacing: 2.0,
                                ),
                                onChanged: (text) {
                                  controllerVideos.setUrlVideo(text);
                                },
                                // validator: (text) {
                                //   if (text!.trim().isNotEmpty) {
                                //     return null;
                                //   } else {
                                //     return 'Ingrese peso de la mascota';
                                //   }
                                // },
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ),
      ),
    );
  }

  //********************************************************************************************************************//
  void _onSubmit(BuildContext context, VideosController controller,
      String? _action) async {
    final isValid = controller.validateForm();
    if (!isValid) return;
    if (isValid) {
      if (_action == 'EDIT') {
        await controller.editarTutorial(context);
        Navigator.pop(context);
      } else {
        if (controller.getNombreCategoria == '') {
          NotificatiosnService.showSnackBarDanger('Debe seleccionar Categoría');
        } else if (controller.getTituloVideo == '') {
          NotificatiosnService.showSnackBarDanger(
              'Debe agregar Titulo del video');
        } else if (controller.getUrlVideo == '') {
          NotificatiosnService.showSnackBarDanger('Debe agregar URL del video');
        }
        if (controller.getNombreCategoria != '' &&
            controller.getTituloVideo != '' &&
            controller.getUrlVideo != '') {
          if (_action == 'CREATE') {
            await controller.crearTurorial(context);
            Navigator.pop(context);
          }
           else if (_action == 'ITEM') {
            await controller.crearItemTurorial(context);
            Navigator.pop(context);
          }
          
        }
      }
    }
  }

  //**********************************************BUSCA MASCOTA **********************************************************************//
  Future<bool?> _buscarCategoria(BuildContext context, Responsive size) {
    return showDialog<bool>(
      barrierColor: Colors.black54,
      context: context,
      builder: (context) {
        // final controller = context.read<PropietariosController>();
        final controllerVideos = context.read<VideosController>();

        return AlertDialog(
            title: const Text("CATEGORÍAS"),
            content: Card(
              color: Colors.transparent,
              elevation: 0.0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                      // color: Colors.red,
                      width: size.wScreen(100),
                      height: size.hScreen(30.0),
                      child: ListView.builder(
                        itemCount: controllerVideos.getListaCategorias.length,
                        itemBuilder: (BuildContext context, int index) {
                          final _categoria =
                              controllerVideos.getListaCategorias[index];
                          return Card(
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
                                            GestureDetector(
                                              onTap: () {
                                                final _resul = controllerVideos
                                                    .validaTutorial(_categoria);

                                                // print('la info es: ${_resul}');
                                                if (_resul == false) {
                                                  controllerVideos
                                                      .setNombreCategoria(
                                                          _categoria);
                                                  Navigator.pop(context);
                                                } else {
                                                  Navigator.pop(context);
                                                  NotificatiosnService
                                                      .showSnackBarError(
                                                          'Ya existe la categoría');
                                                }
                                              },
                                              child: Container(
                                                width: size.wScreen(100.0),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        size.iScreen(1.0),
                                                    vertical:
                                                        size.iScreen(0.2)),
                                                child: Text(
                                                  '$_categoria',
                                                  style: GoogleFonts.lexendDeca(
                                                      // fontSize: size.iScreen(2.45),
                                                      // color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ));
                        },
                      )),

                  // )
                ],
              ),
            )

            //  },)

            );
      },
    );
  }

//   Future<String?> _modalTipoProductos(
//       BuildContext context, Responsive size, VacunasController controller) {
//     final List<dynamic> lista_Tipos_Productos = [
//       "ANTIPULGAS",
//       "DESPARASITANTES",
//       "MEDICAMENTO ESPECIAL",
//       "VACUNAS"
//     ];

//     return showDialog<String>(
//         context: context,
//         builder: (BuildContext context) => AlertDialog(
//               title: const Center(child: Text('Tipo de Productos')),
//               content: SizedBox(
//                   height: size.hScreen(40.0),
//                   width: double.maxFinite,
//                   child: ListView.builder(
//                     itemCount: lista_Tipos_Productos.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       final _tipo = lista_Tipos_Productos[index];
//                       // final List razasList =
//                       //     controller.getListaProductos[index]['espRazas'];

//                       return ListTile(
//                         onTap: () {
//                           controller.setLabelTipoProducto(_tipo);
//                           controller.buscaAllProductos(_tipo);
//                           controller.setLabelProducto('');

//                           Navigator.pop(context);
//                         },
//                         title: Text('${_tipo}'),
//                       );
// //
//                     },
//                   )

//                   // },
//                   ),
//             ));
//   }

//   Future<String?> _modalAllProductos(BuildContext context, Responsive size) {
//     // final List<dynamic> lista_Tipos_Productos=["ANTIPULGAS","DESPARASITANTES","MEDICAMENTO ESPECIAL","VACUNAS"];

//     return showDialog<String>(
//       context: context,
//       builder: (BuildContext context) => AlertDialog(
//         title: const Center(child: Text('Productos')),
//         content: SizedBox(
//             height: size.hScreen(40.0),
//             width: double.maxFinite,
//             child: Consumer<VacunasController>(builder: (_, valueProduct, __) {
//               return Wrap(
//                   children: valueProduct.getListaProductos.isNotEmpty
//                       ? valueProduct.getListaProductos
//                           .map(
//                             (e) => ListTile(
//                               onTap: () {
//                                 valueProduct.setLabelProducto(e['invNombre']);
//                                 Navigator.pop(context);
//                               },
//                               title: Text('${e['invNombre']}'),
//                             ),
//                           )
//                           .toList()
//                       : []);
//             })),
//       ),
//     );
//   }
}

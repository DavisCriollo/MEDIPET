import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neitorcont/src/controllers/hospitalizacion_controller.dart';
import 'package:neitorcont/src/services/notifications_service.dart';
import 'package:neitorcont/src/utils/letras_mayusculas_minusculas.dart';
import 'package:neitorcont/src/utils/responsive.dart';
import 'package:neitorcont/src/utils/theme.dart';
import 'package:neitorcont/src/widgets/no_data.dart';

import 'package:provider/provider.dart';

class CabeceraInfusionHospitalizacionDTS extends DataTableSource {
  final BuildContext context;
  final List<dynamic> _listaInfusion;
  final Responsive size;
  final String? accion;
   final bool? detalle;

  CabeceraInfusionHospitalizacionDTS(
      this._listaInfusion, this.size, this.context, this.accion, this.detalle);

  final controllersHome = HospitalizacionController();
  @override
  DataRow? getRow(int index) {
    _listaInfusion.sort((a, b) => b['idInfusion'].compareTo(a['idInfusion']));

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Row(
          children: [
                detalle==true? 
            IconButton(
              onPressed: () {
                // controllersHome.resetFormAddFluido();
                //  final controller = context.read<c>();
                final controller = Provider.of<HospitalizacionController>(
                    context,
                    listen: false);
                controller.setNombreInfusion(_listaInfusion[index]['infusion']);
                controller.setDosisInfusion(_listaInfusion[index]['dosis']);
                controller.setUnidadInfusion(_listaInfusion[index]['unidad']);
                // controller
                //     .setViaFluido(_listaInfusion[index]['via']);
                // controller
                //     .setInicioFluido(_listaInfusion[index]['inicio']);
                // controller.setFrecuenciaFluido(
                //     _listaInfusion[index]['frecuencia']);

                //  _agregaCabeceraMedicamentos(
                //   context,
                //   size,
                //   index,
                //   _listaMedicamentos[index]['Fluido'],
                //   _listaMedicamentos[index]['dosis'],
                //   _listaMedicamentos[index]['cantidad'],
                //   _listaMedicamentos[index]['via'],
                //   _listaMedicamentos[index]['inicio'],
                //   _listaMedicamentos[index]['frecuencia'],
                //   controllersHome
                // );

                ///===========================================//
                showDialog<bool>(
                    barrierColor: Colors.black54,
                    context: context,
                    builder: (context) {
                      // final controller = context.read<PropietariosController>();

                      // print('object ${controllerHosp.getNombreFluido}');

                      // controller.setNombreFluido('${controller.getNombreFluido}');
                      return AlertDialog(
                          // title: const Text(" INFUSIÓN "),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Expanded(child: Text("INGRESE INFUSIÓN")),
                              IconButton(
                                  splashRadius: 25.0,
                                  onPressed: () {
                                    // final isValidS =
                                    //     controllerHospital.validateFormAgregaInfusion();
                                    // if (!isValidS) return;
                                    // if (isValidS) {
                                    //   if (controllerHospital.getNombreInfusion == '') {
                                    //     FocusScope.of(context).unfocus();
                                    //     NotificatiosnService.showSnackBarDanger(
                                    //         'Debe agregar Infusión');
                                    //   }
                                    //   if (controllerHospital.getNombreInfusion != '') {
                                    //     controllerHospital.addCabeceraInfusion();
                                    //     Navigator.pop(context);
                                    //   }
                                    // }
                                    controller.getInfoRowInfusion(
                                        _listaInfusion[index]['idInfusion']);
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(Icons.save_outlined,
                                      size: size.iScreen(3.5),
                                      color: primaryColor)),
                            ],
                          ),
                          content: Card(
                              color: Colors.transparent,
                              elevation: 0.0,
                              child: SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      // color: Colors.red,
                                      width: size.wScreen(100),
                                      height: size.hScreen(35.0),

                                      child: SingleChildScrollView(
                                        physics: const BouncingScrollPhysics(),
                                        child: Form(
                                          key: controllersHome
                                              .hospitalizacionInfusionFormKey,
                                          child: Column(
                                            children: [
                                              // //***********************************************/
                                              // SizedBox(
                                              //   height: size.iScreen(1.5),
                                              // ),
                                              // //*****************************************/
                                              // Row(
                                              //   children: [
                                              //     SizedBox(
                                              //       // width: size.wScreen(100.0),

                                              //       // color: Colors.blue,
                                              //       child: Text('Fluido ',
                                              //           style: GoogleFonts.lexendDeca(
                                              //               // fontSize: size.iScreen(2.0),
                                              //               fontWeight: FontWeight.normal,
                                              //               color: Colors.grey)),
                                              //     ),
                                              //     SizedBox(
                                              //       width: size.iScreen(2.0),
                                              //     ),
                                              //     ClipRRect(
                                              //       borderRadius: BorderRadius.circular(8),
                                              //       child: GestureDetector(
                                              //         onTap: () {
                                              //           // context
                                              //           //     .read<
                                              //           //         HospitalizacionController>()
                                              //           //     .buscaAllFluidos('');

                                              //           // _buscarMascota(context, size);
                                              //           // _buscarFluido(context, size);

                                              //           //*******************************************/
                                              //         },
                                              //         child: Container(
                                              //           alignment: Alignment.center,
                                              //           color: primaryColor,
                                              //           width: size.iScreen(3.5),
                                              //           padding: EdgeInsets.only(
                                              //             top: size.iScreen(0.5),
                                              //             bottom: size.iScreen(0.5),
                                              //             left: size.iScreen(0.5),
                                              //             right: size.iScreen(0.5),
                                              //           ),
                                              //           child: Icon(
                                              //             Icons.search_outlined,
                                              //             color: Colors.white,
                                              //             size: size.iScreen(2.0),
                                              //           ),
                                              //         ),
                                              //       ),
                                              //     ),
                                              //   ],
                                              // ),
                                              // //***********************************************/
                                              // SizedBox(
                                              //   height: size.iScreen(1.0),
                                              // ),
                                              // //*****************************************/
                                              // Consumer<HospitalizacionController>(
                                              //   builder: (context, valueFluidos, __) {
                                              //      valueFluidos.setNombreFluido('${valueFluidos.getNombreFluido}');
                                              //     return SizedBox(
                                              //       width: size.wScreen(100.0),

                                              //       // color: Colors.blue,
                                              //       child: Text(
                                              //          '${valueFluidos.getNombreFluido}',
                                              //               // : '${controllersHome.getNombreFluido}',
                                              //           style: GoogleFonts.lexendDeca(
                                              //               // fontSize: size.iScreen(2.0),
                                              //               fontWeight: FontWeight.normal,
                                              //               color: valueFluidos
                                              //                           .getNombreFluido ==
                                              //                       ''
                                              //                   ? Colors.grey
                                              //                   : Colors.black)),
                                              //     );
                                              //   },
                                              // ),
                                              //***********************************************/
                                              SizedBox(
                                                height: size.iScreen(1.5),
                                              ),
                                              //*****************************************/
                                              Row(
                                                children: [
                                                  Container(
                                                    width: size.wScreen(16.0),

                                                    // color: Colors.blue,
                                                    child: Text('Infusión: ',
                                                        style: GoogleFonts
                                                            .lexendDeca(
                                                                // fontSize: size.iScreen(2.0),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                color: Colors
                                                                    .grey)),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      // width: size.wScreen(20.0),
                                                      child: TextFormField(
                                                        initialValue:
                                                            _listaInfusion[
                                                                    index]
                                                                ['infusion'],
                                                        // keyboardType: TextInputType.number,
                                                        // inputFormatters: <TextInputFormatter>[
                                                        //   FilteringTextInputFormatter.allow(
                                                        //       RegExp(r'[0-9.]')),
                                                        // ],
                                                        decoration:
                                                            const InputDecoration(
                                                                // suffixIcon: Icon(Icons.beenhere_outlined)
                                                                ),
                                                        textAlign:
                                                            TextAlign.center,
                                                        //  maxLines: 3,
                                                        //  minLines: 1,
                                                        style: TextStyle(
                                                          fontSize:
                                                              size.iScreen(2.0),
                                                          // fontWeight: FontWeight.bold,
                                                          // letterSpacing: 2.0,
                                                        ),
                                                        onChanged: (text) {
                                                          controller
                                                              .setNombreInfusion(
                                                                  text);
                                                        },
                                                        validator: (text) {
                                                          if (text!
                                                              .trim()
                                                              .isNotEmpty) {
                                                            return null;
                                                          } else {
                                                            return 'Ingrese Infusión';
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              //***********************************************/
                                              SizedBox(
                                                height: size.iScreen(1.5),
                                              ),
                                              //*****************************************/
                                              Row(
                                                children: [
                                                  Container(
                                                    width: size.wScreen(12.0),

                                                    // color: Colors.blue,
                                                    child: Text('Dosis : ',
                                                        style: GoogleFonts
                                                            .lexendDeca(
                                                                // fontSize: size.iScreen(2.0),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                color: Colors
                                                                    .grey)),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      // width: size.wScreen(20.0),
                                                      child: TextFormField(
                                                        initialValue:
                                                            _listaInfusion[
                                                                index]['dosis'],
                                                        // keyboardType: TextInputType.number,
                                                        // inputFormatters: <TextInputFormatter>[
                                                        //   FilteringTextInputFormatter.allow(
                                                        //       RegExp(r'[0-9.]')),
                                                        // ],
                                                        decoration:
                                                            const InputDecoration(
                                                                // suffixIcon: Icon(Icons.beenhere_outlined)
                                                                ),
                                                        textAlign:
                                                            TextAlign.center,
                                                        //  maxLines: 3,
                                                        //  minLines: 1,
                                                        style: TextStyle(
                                                          fontSize:
                                                              size.iScreen(2.0),
                                                          // fontWeight: FontWeight.bold,
                                                          // letterSpacing: 2.0,
                                                        ),
                                                        onChanged: (text) {
                                                          controller
                                                              .setDosisInfusion(
                                                                  text);
                                                        },
                                                        validator: (text) {
                                                          if (text!
                                                              .trim()
                                                              .isNotEmpty) {
                                                            return null;
                                                          } else {
                                                            return 'Ingrese la Dosis';
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              //***********************************************/
                                              SizedBox(
                                                height: size.iScreen(1.5),
                                              ),
                                              //*****************************************/
                                              Row(
                                                children: [
                                                  Container(
                                                    width: size.wScreen(15.0),

                                                    // color: Colors.blue,
                                                    child: Text('Unidad : ',
                                                        style: GoogleFonts
                                                            .lexendDeca(
                                                                // fontSize: size.iScreen(2.0),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                color: Colors
                                                                    .grey)),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      // width: size.wScreen(20.0),
                                                      child: TextFormField(
                                                        initialValue:
                                                            _listaInfusion[
                                                                    index]
                                                                ['unidad'],
                                                        // keyboardType: TextInputType.number,
                                                        // inputFormatters: <TextInputFormatter>[
                                                        //   FilteringTextInputFormatter.allow(
                                                        //       RegExp(r'[0-9.]')),
                                                        // ],
                                                        decoration:
                                                            const InputDecoration(
                                                                // suffixIcon: Icon(Icons.beenhere_outlined)
                                                                ),
                                                        textAlign:
                                                            TextAlign.center,
                                                        //  maxLines: 3,
                                                        //  minLines: 1,
                                                        style: TextStyle(
                                                          fontSize:
                                                              size.iScreen(2.0),
                                                          // fontWeight: FontWeight.bold,
                                                          // letterSpacing: 2.0,
                                                        ),
                                                        onChanged: (text) {
                                                          controller
                                                              .setUnidadInfusion(
                                                                  text);
                                                        },
                                                        validator: (text) {
                                                          if (text!
                                                              .trim()
                                                              .isNotEmpty) {
                                                            return null;
                                                          } else {
                                                            return 'Ingrese la unidad';
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              // //***********************************************/
                                              // SizedBox(
                                              //   height: size.iScreen(1.5),
                                              // ),
                                              // //*****************************************/
                                              // Row(
                                              //   mainAxisAlignment:
                                              //       MainAxisAlignment.spaceAround,
                                              //   children: [
                                              //     Column(
                                              //       children: [
                                              //         Container(
                                              //           // width: size.wScreen(18.0),

                                              //           // color: Colors.blue,
                                              //           child: Text('Cantidad ',
                                              //               style: GoogleFonts.lexendDeca(
                                              //                   // fontSize: size.iScreen(2.0),
                                              //                   fontWeight:
                                              //                       FontWeight.normal,
                                              //                   color: Colors.grey)),
                                              //         ),
                                              //         Container(
                                              //           width: size.wScreen(15.0),
                                              //           child: TextFormField(
                                              //             initialValue:   _listaInfusion[index]['cantidad'],

                                              //             keyboardType:
                                              //                 TextInputType.number,
                                              //             inputFormatters: <
                                              //                 TextInputFormatter>[
                                              //               FilteringTextInputFormatter
                                              //                   .allow(RegExp(r'[0-9]')),
                                              //             ],
                                              //             decoration: const InputDecoration(
                                              //                 // suffixIcon: Icon(Icons.beenhere_outlined)
                                              //                 ),
                                              //             textAlign: TextAlign.center,
                                              //             //  maxLines: 3,
                                              //             //  minLines: 1,
                                              //             style: TextStyle(
                                              //               fontSize: size.iScreen(2.0),
                                              //               // fontWeight: FontWeight.bold,
                                              //               // letterSpacing: 2.0,s
                                              //             ),
                                              //             onChanged: (text) {
                                              //               controller
                                              //                   .setCantidadFluido(text);
                                              //               // if(text.isNotEmpty){

                                              //               // controller
                                              //               //     .setInicioAlimento(text);
                                              //               // }
                                              //               // else{
                                              //               // controller
                                              //               //     .setInicioAlimento('0');

                                              //               // }
                                              //             },
                                              //             validator: (text) {
                                              //               if (text!.trim().isNotEmpty) {
                                              //                 return null;
                                              //               } else {
                                              //                 return 'Ingrese Cantidad';
                                              //               }
                                              //             },
                                              //           ),
                                              //         ),
                                              //       ],
                                              //     ),

                                              //     Column(
                                              //       children: [
                                              //         Container(
                                              //           // width: size.wScreen(18.0),

                                              //           // color: Colors.blue,
                                              //           child: Text('Inicio ',
                                              //               style: GoogleFonts.lexendDeca(
                                              //                   // fontSize: size.iScreen(2.0),
                                              //                   fontWeight:
                                              //                       FontWeight.normal,
                                              //                   color: Colors.grey)),
                                              //         ),
                                              //         Container(
                                              //           width: size.wScreen(15.0),
                                              //           child: TextFormField(
                                              //             initialValue:  _listaInfusion[index]['inicio'],

                                              //             keyboardType:
                                              //                 TextInputType.number,
                                              //             inputFormatters: <
                                              //                 TextInputFormatter>[
                                              //               FilteringTextInputFormatter
                                              //                   .allow(RegExp(r'[0-9]')),
                                              //             ],
                                              //             decoration: const InputDecoration(
                                              //                 // suffixIcon: Icon(Icons.beenhere_outlined)
                                              //                 ),
                                              //             textAlign: TextAlign.center,
                                              //             //  maxLines: 3,
                                              //             //  minLines: 1,
                                              //             style: TextStyle(
                                              //               fontSize: size.iScreen(2.0),
                                              //               // fontWeight: FontWeight.bold,
                                              //               // letterSpacing: 2.0,s
                                              //             ),
                                              //             onChanged: (text) {
                                              //               controller
                                              //                   .setInicioFluido(text);
                                              //               // if(text.isNotEmpty){

                                              //               // controllerHospital
                                              //               //     .setInicioAlimento(text);
                                              //               // }
                                              //               // else{
                                              //               // controllerHospital
                                              //               //     .setInicioAlimento('0');

                                              //               // }
                                              //             },
                                              //             validator: (text) {
                                              //               if (text!.trim().isNotEmpty) {
                                              //                 return null;
                                              //               } else {
                                              //                 return 'Ingrese Inicio';
                                              //               }
                                              //             },
                                              //           ),
                                              //         ),
                                              //       ],
                                              //     ),

                                              //   ],
                                              // ),
                                              // //***********************************************/
                                              // SizedBox(
                                              //   height: size.iScreen(1.5),
                                              // ),
                                              // //*****************************************/

                                              // TextButton(
                                              //     onPressed: () {
                                              //       final isValidS = controllersHome
                                              //           .validateFormAgregaInfusion();
                                              //       if (!isValidS) return;
                                              //       if (isValidS) {
                                              //         // print('object: ${controller.getNombreFluido}');
                                              //         // print('object: ${controller.getDosisFluido}');
                                              //         // print('object: ${controller.getCantidadFluido}');
                                              //         // print('object: ${controller.getViaFluido}');
                                              //         // print('object: ${controller.getInicioFluido}');
                                              //         // print('object: ${controller.getFrecuenciaFluido}');

                                              //         //  if (controllersHome
                                              //         //         .getNombreFluido ==
                                              //         //     '') {
                                              //         //   FocusScope.of(context).unfocus();
                                              //         //   NotificatiosnService
                                              //         //       .showSnackBarDanger(
                                              //         //           'Debe seleccionar Fluido');
                                              //         // }
                                              //         // if (controllersHome
                                              //         //         .getNombreFluido !=
                                              //         //     '') {
                                              //         // controllersHome
                                              //         //     .addCabeceraMedicamento();
                                              //         controller
                                              //             .getInfoRowInfusion(
                                              //                 _listaInfusion[
                                              //                         index][
                                              //                     'idInfusion']);
                                              //         Navigator.pop(context);
                                              //         // }
                                              //         //                                         if (controllersHome
                                              //         //                                                 .getNombreFluido ==
                                              //         //                                             '') {
                                              //         //                                           FocusScope.of(context).unfocus();
                                              //         //                                           NotificatiosnService
                                              //         //                                               .showSnackBarDanger(
                                              //         //                                                   'Debe seleccionar Fluido');
                                              //         //                                         }
                                              //         //                                         if (controllersHome
                                              //         //                                                 .getNombreFluido !=
                                              //         //                                             '') {
                                              //         //                                           _eliminaRow(index);
                                              //         //                                           controllersHome
                                              //         //                                               .addCabeceraMedicamento();
                                              //         //                                                   // controllersHome.setNombreFluido('');
                                              //         // // controllersHome.resetFormAddFluido();
                                              //         //                                           Navigator.pop(context);
                                              //         //                                         }
                                              //       }
                                              //     },
                                              //     child: Container(
                                              //       decoration: BoxDecoration(
                                              //           color: primaryColor,
                                              //           borderRadius:
                                              //               BorderRadius
                                              //                   .circular(5.0)),
                                              //       // color: primaryColor,
                                              //       padding:
                                              //           EdgeInsets.symmetric(
                                              //               vertical: size
                                              //                   .iScreen(0.5),
                                              //               horizontal: size
                                              //                   .iScreen(0.5)),
                                              //       child: Text('Agregar',
                                              //           style: GoogleFonts
                                              //               .lexendDeca(
                                              //                   // fontSize: size.iScreen(2.0),
                                              //                   fontWeight:
                                              //                       FontWeight
                                              //                           .normal,
                                              //                   color: Colors
                                              //                       .white)),
                                              //     ))
                                            
                                            
                                            
                                            
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )

                              //  },)

                              ));
                    });

                ///===========================================//
              },
              icon: const Icon(
                Icons.edit,
                color: tercearyColor,
              ),
              splashRadius: 20.0,
            ):Container(),
            Text(
                '${_listaInfusion[index]['infusion']}-${_listaInfusion[index]['idInfusion']}'),
          ],
        )),
        DataCell(Text(_listaInfusion[index]['dosis'])),
        DataCell(Text(_listaInfusion[index]['unidad'])),
        // DataCell(Text(_listaInfusion[index]['via'])),
        // DataCell(Text(_listaInfusion[index]['inicio'])),
      ],
      onLongPress: accion == 'NUEVO'
          ? () {
              // context.read<HospitalizacionController>().eliminaFluidoAgregada(_listaMedicamentos[index]['idCabeceraAlimendo']);
              // print('ESTE SE ELIMINARA: ${_listaMedicamentos[index]['idItem']}');
              _eliminaRow(index);
            }
          : null,
    );
  }

  void _eliminaRow(int index) {
    context
        .read<HospitalizacionController>()
        .eliminaInfusionAgregada(_listaInfusion[index]['idInfusion']);
  }

  //**********************************************BUSCA MASCOTA **********************************************************************//
  // Future<bool?> _buscarFluido(BuildContext context, Responsive size) {
  //   return showDialog<bool>(
  //     barrierColor: Colors.black54,
  //     context: context,
  //     builder: (context) {
  //       // final controller = context.read<PropietariosController>();
  //       final controllerFluido = context.read<HospitalizacionController>();

  //       return AlertDialog(
  //           title: const Text("BUSCAR Fluido"),
  //           content: Card(
  //             color: Colors.transparent,
  //             elevation: 0.0,
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 SizedBox(
  //                   width: size.iScreen(100.0),
  //                   child: Container(
  //                     // width: size.wScreen(45.0),
  //                     child: SizedBox(
  //                       width: size.iScreen(4.0),
  //                       child: TextFormField(
  //                         // controller: _textAddCorreo,
  //                         autofocus: true,
  //                         keyboardType: TextInputType.emailAddress,
  //                         textCapitalization: TextCapitalization.none,

  //                         autovalidateMode: AutovalidateMode.onUserInteraction,
  //                         // validator: (value) {
  //                         //   final validador = validateEmail(value);
  //                         //   if (validador == null) {
  //                         //     controller.setIsCorreo(true);
  //                         //   }
  //                         //   return validateEmail(value);
  //                         // },
  //                         decoration:
  //                             const InputDecoration(hintText: '  Buscar...'
  //                                 // suffixIcon: Icon(Icons.beenhere_outlined)
  //                                 ),
  //                         inputFormatters: [
  //                           LowerCaseText(),
  //                         ],
  //                         textAlign: TextAlign.center,
  //                         style: const TextStyle(

  //                             // fontSize: size.iScreen(3.5),
  //                             // fontWeight: FontWeight.bold,
  //                             // letterSpacing: 2.0,
  //                             ),
  //                         onChanged: (text) {
  //                           controllerFluido.onSearchTextFluido(text);

  //                           if (controllerFluido.nameSearchFluido.isEmpty) {
  //                             controllerFluido.buscaAllFluidos('');
  //                           }
  //                         },
  //                       ),
  //                     ),
  //                     //===============================================//
  //                   ),
  //                 ),
  //                 SizedBox(
  //                     // color: Colors.red,
  //                     width: size.wScreen(100),
  //                     height: size.hScreen(30.0),
  //                     child:
  //                         // Text('DFD'),

  //                         Consumer<HospitalizacionController>(
  //                       builder: (_, providerFluido, __) {
  //                         if (providerFluido.getErrorFluidos == null) {
  //                           return Center(
  //                             // child: CircularProgressIndicator(),
  //                             child: Column(
  //                               mainAxisSize: MainAxisSize.min,
  //                               children: [
  //                                 Text(
  //                                   'Cargando Datos...',
  //                                   style: GoogleFonts.lexendDeca(
  //                                       fontSize: size.iScreen(1.5),
  //                                       color: Colors.black87,
  //                                       fontWeight: FontWeight.bold),
  //                                 ),
  //                                 //***********************************************/
  //                                 SizedBox(
  //                                   height: size.iScreen(1.0),
  //                                 ),
  //                                 //*****************************************/
  //                                 const CircularProgressIndicator(),
  //                               ],
  //                             ),
  //                           );
  //                         } else if (providerFluido.getErrorFluidos ==
  //                             false) {
  //                           return const NoData(
  //                             label: 'No existen datos para mostar',
  //                           );
  //                           // Text("Error al cargar los datos");
  //                         } else if (providerFluido
  //                             .getListaFluidos.isEmpty) {
  //                           return const NoData(
  //                             label: 'No existen datos para mostar',
  //                           );
  //                         }
  //                         // print('esta es la lista*******************: ${providerFluido.getListaPropietarios.length}');

  //                         return ListView.builder(
  //                           physics: const BouncingScrollPhysics(),
  //                           itemCount:
  //                               providerFluido.getListaFluidos.length,
  //                           itemBuilder: (BuildContext context, int index) {
  //                             final _Fluido =
  //                                 providerFluido.getListaFluidos[index];
  //                             return GestureDetector(
  //                               onTap: () {
  //                                 context
  //                                     .read<HospitalizacionController>()
  //                                     .setFluidoInfo(_Fluido);

  //                                 Navigator.pop(context);
  //                               },
  //                               child: Card(
  //                                   color: Colors.white,
  //                                   shape: RoundedRectangleBorder(
  //                                       borderRadius: BorderRadius.circular(8)),
  //                                   margin: EdgeInsets.symmetric(
  //                                       vertical: size.iScreen(0.5),
  //                                       horizontal: size.iScreen(1.0)),
  //                                   elevation: 2,
  //                                   child: ClipRRect(
  //                                     borderRadius: BorderRadius.circular(8),
  //                                     child: Row(
  //                                       children: [
  //                                         Expanded(
  //                                           child: Container(
  //                                             padding: EdgeInsets.symmetric(
  //                                                 horizontal: size.iScreen(0.0),
  //                                                 vertical: size.iScreen(1.0)),
  //                                             child: Column(
  //                                               children: <Widget>[
  //                                                 Container(
  //                                                   width: size.wScreen(100.0),
  //                                                   padding:
  //                                                       EdgeInsets.symmetric(
  //                                                           horizontal: size
  //                                                               .iScreen(1.0),
  //                                                           vertical: size
  //                                                               .iScreen(0.2)),
  //                                                   child: Text(
  //                                                     '${_Fluido['invNombre']}',
  //                                                     style: GoogleFonts
  //                                                         .lexendDeca(
  //                                                             // fontSize: size.iScreen(2.45),
  //                                                             // color: Colors.white,
  //                                                             fontWeight:
  //                                                                 FontWeight
  //                                                                     .normal),
  //                                                   ),
  //                                                 ),
  //                                               ],
  //                                             ),
  //                                           ),
  //                                         ),
  //                                       ],
  //                                     ),
  //                                   )),
  //                             );
  //                           },
  //                         );
  //                       },
  //                     ))
  //               ],
  //             ),
  //           )

  //           //  },)

  //           );
  //     },
  //   );
  // }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _listaInfusion.length;

  @override
  int get selectedRowCount => 0;
}

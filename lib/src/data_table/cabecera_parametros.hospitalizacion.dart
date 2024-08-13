import 'package:flutter/cupertino.dart';
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

class CabeceraParametrosHospitalizacionDTS extends DataTableSource {
  final BuildContext context;
  final List<dynamic> _listaParametros;
  final Responsive size;
  final String? accion;
    final bool? detalle;

  CabeceraParametrosHospitalizacionDTS(
      this._listaParametros, this.size, this.context, this.accion, this.detalle);

  final controllersHome = HospitalizacionController();
  @override
  DataRow? getRow(int index) {
    _listaParametros.sort(
        (a, b) => b['idCabeceraParametro'].compareTo(a['idCabeceraParametro']));

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Row(
          children: [
             detalle==true? 
            IconButton(
              onPressed: () {
                // controllersHome.resetFormAddMedicina();
                //  final controller = context.read<c>();
                final controller = Provider.of<HospitalizacionController>(
                    context,
                    listen: false);
                controller
                    .setNombreParametro(_listaParametros[index]['parametro']);
                controller.setDosisParametro(_listaParametros[index]['dosis']);
                controller.setInicioParametro(_listaParametros[index]['inicio']);
                controller.setFrecuenciaParametro(
                    _listaParametros[index]['frecuencia']);

                ///===========================================//

                showDialog<bool>(
                    barrierColor: Colors.black54,
                    context: context,
                    builder: (context) {
                      // final controller = context.read<PropietariosController>();
                      final controllerHosp =
                          context.read<HospitalizacionController>();
                      // _dosisParametro.text = '';

                      return AlertDialog(
                          // title: const Text("INGRESE PARÁMETRO"),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Expanded(child: Text("INGRESE PARÁMETRO")),
                              IconButton(
                                  splashRadius: 25.0,
                                  onPressed: () {

                                   final isValidS = controllerHosp.validateFormAgregaParametro();
                                    if (!isValidS) return;
                                    if (isValidS) {
                                      controller.getInfoRowParametro(
                                          _listaParametros[index]
                                              ['idCabeceraParametro']);
                                      Navigator.pop(context);
                                    }
                                    // final isValidS = controllerHosp
                                    //     .validateFormAgregaParametro();
                                    // if (!isValidS) return;
                                    // if (isValidS) {
                                    //   if (controllerHosp.getNombreParametro ==
                                    //       '') {
                                    //     FocusScope.of(context).unfocus();
                                    //     NotificatiosnService.showSnackBarDanger(
                                    //         'Debe seleccionar Parametro');
                                    //   }
                                    //   if (controllerHosp.getNombreParametro !=
                                    //       '') {
                                    //     controllerHosp.getInfoRowParametro(
                                    //         _listaParametros[index]
                                    //             ['idCabeceraParametro']);
                                    //     Navigator.pop(context);
                                    //   }
                                    // }
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
                                          key: controllerHosp
                                              .hospitalizacionParametroFormKey,
                                          child: Column(
                                            children: [
                                              Consumer<
                                                  HospitalizacionController>(
                                                builder: (_,
                                                    valuefechaParametro, __) {
                                                  return Row(
                                                    children: [
                                                      Text(
                                                        'Fecha: ',
                                                        style: GoogleFonts
                                                            .lexendDeca(
                                                          // fontSize: size.iScreen(1.8),
                                                          color: Colors.black45,
                                                          // fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            size.iScreen(1.0),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          FocusScope.of(context)
                                                              .requestFocus(
                                                                  FocusNode());
                                                          _fechaHoraParametros(
                                                              context,
                                                              valuefechaParametro);
                                                        },
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              valuefechaParametro
                                                                      .getFechaHoraParametros ??
                                                                  'yyyy-mm-dd',
                                                              style: GoogleFonts
                                                                  .lexendDeca(
                                                                fontSize: size
                                                                    .iScreen(
                                                                        1.8),
                                                                color: Colors
                                                                    .black45,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: size
                                                                  .iScreen(1.0),
                                                            ),
                                                            const Icon(
                                                              Icons
                                                                  .date_range_outlined,
                                                              color:
                                                                  primaryColor,
                                                              size: 30,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
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
                                                    // child: GestureDetector(
                                                    //   onTap: (){
                                                    //         final controllerData=  context.read<HospitalizacionController>();
                                                    //     setState(() {
                                                    //         _dosisParametro.text=controllerData.getDosisParametro;

                                                    //     });
                                                    //     print('object${controllerData.getDosisParametro}');

                                                    //   },
                                                    child: Text('Parámetro ',
                                                        style: GoogleFonts
                                                            .lexendDeca(
                                                                // fontSize: size.iScreen(2.0),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                color: Colors
                                                                    .grey)),
                                                  ),
                                                  // ),
                                                  SizedBox(
                                                    width: size.iScreen(2.0),
                                                  ),
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        context
                                                            .read<
                                                                HospitalizacionController>()
                                                            .buscaAllParametros(
                                                                '');

                                                        _buscarParametro(
                                                            context, size);

                                                        //*******************************************/
                                                      },
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        color: primaryColor,
                                                        width:
                                                            size.iScreen(3.5),
                                                        padding:
                                                            EdgeInsets.only(
                                                          top:
                                                              size.iScreen(0.5),
                                                          bottom:
                                                              size.iScreen(0.5),
                                                          left:
                                                              size.iScreen(0.5),
                                                          right:
                                                              size.iScreen(0.5),
                                                        ),
                                                        child: Icon(
                                                          Icons.search_outlined,
                                                          color: Colors.white,
                                                          size:
                                                              size.iScreen(2.0),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              //***********************************************/
                                              SizedBox(
                                                height: size.iScreen(1.0),
                                              ),
                                              //*****************************************/
                                              Consumer<
                                                  HospitalizacionController>(
                                                builder:
                                                    (_, valueParametro, __) {
                                                  return SizedBox(
                                                    width: size.wScreen(100.0),

                                                    // color: Colors.blue,
                                                    child: Text(
                                                        valueParametro
                                                                    .getNombreParametro ==
                                                                ''
                                                            ? 'DEBE AGREGAR PARÁMETRO '
                                                            : '${valueParametro.getNombreParametro}',
                                                        style: GoogleFonts
                                                            .lexendDeca(
                                                                // fontSize: size.iScreen(2.0),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                color: valueParametro
                                                                            .getNombreParametro ==
                                                                        ''
                                                                    ? Colors
                                                                        .grey
                                                                    : Colors
                                                                        .black)),
                                                  );
                                                },
                                              ),
                                              //***********************************************/
                                              // SizedBox(
                                              //   height: size.iScreen(1.5),
                                              // ),
                                              // //*****************************************/
                                              // Row(
                                              //   children: [
                                              //     Container(
                                              //       width: size.wScreen(16.0),

                                              //       // color: Colors.blue,
                                              //       child: Text('Parámetro: ',
                                              //           style: GoogleFonts.lexendDeca(
                                              //               // fontSize: size.iScreen(2.0),
                                              //               fontWeight: FontWeight.normal,
                                              //               color: Colors.grey)),
                                              //     ),
                                              //     Expanded(
                                              //       child: Container(
                                              //         // width: size.wScreen(20.0),
                                              //         child: TextFormField(
                                              //           initialValue: _estado == 'NUEVO'
                                              //               ? ""
                                              //               : controllerHosp
                                              //                   .getNombreParametro,
                                              //           // keyboardType: TextInputType.number,
                                              //           // inputFormatters: <TextInputFormatter>[
                                              //           //   FilteringTextInputFormatter.allow(
                                              //           //       RegExp(r'[0-9.]')),
                                              //           // ],
                                              //           decoration: const InputDecoration(
                                              //               // suffixIcon: Icon(Icons.beenhere_outlined)
                                              //               ),
                                              //           textAlign: TextAlign.center,
                                              //           //  maxLines: 3,
                                              //           //  minLines: 1,
                                              //           style: TextStyle(
                                              //             fontSize: size.iScreen(2.0),
                                              //             // fontWeight: FontWeight.bold,
                                              //             // letterSpacing: 2.0,
                                              //           ),
                                              //           onChanged: (text) {
                                              //             controllerHosp
                                              //                 .setNombreParametro(text);
                                              //           },
                                              //           validator: (text) {
                                              //             if (text!.trim().isNotEmpty) {
                                              //               return null;
                                              //             } else {
                                              //               return 'Ingrese Parámetro';
                                              //             }
                                              //           },
                                              //         ),
                                              //       ),
                                              //     ),
                                              //   ],
                                              // ),
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
                                                  // Consumer<HospitalizacionController>(
                                                  //   builder: (_, valueDosisParm,
                                                  //      __) {
                                                  //         _dosisParametro.text=valueDosisParm.getDosisParametro;

                                                  //     return Text('');

                                                  //   },
                                                  // ),
                                                  Expanded(
                                                    child: Container(
                                                      // width: size.wScreen(20.0),
                                                      child: TextFormField(
                                                        // controller: _dosisParametro,
                                                        initialValue:
                                                            //_estado == 'NUEVO'
                                                            //     ? ""
                                                            //     :
                                                            controllerHosp
                                                                .getDosisParametro,
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
                                                          controllerHosp
                                                              .setDosisParametro(
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
                                                  )
                                                ],
                                              ),
                                              // //***********************************************/
                                              // SizedBox(
                                              //   height: size.iScreen(1.5),
                                              // ),
                                              // //*****************************************/
                                              // Row(
                                              //   children: [
                                              //     Container(
                                              //       width: size.wScreen(18.0),

                                              //       // color: Colors.blue,
                                              //       child: Text('Cantidad : ',
                                              //           style: GoogleFonts.lexendDeca(
                                              //               // fontSize: size.iScreen(2.0),
                                              //               fontWeight: FontWeight.normal,
                                              //               color: Colors.grey)),
                                              //     ),
                                              //     Expanded(
                                              //       child: Container(
                                              //         width: size.wScreen(10.0),
                                              //         child: TextFormField(
                                              //           initialValue: _estado == 'NUEVO'
                                              //               ? "1"
                                              //               : controllerHosp
                                              //                   .getCantidadAlimento,

                                              //           keyboardType: TextInputType.number,
                                              //           inputFormatters: <
                                              //               TextInputFormatter>[
                                              //             FilteringTextInputFormatter.allow(
                                              //                 RegExp(r'[0-9]')),
                                              //           ],
                                              //           decoration: const InputDecoration(
                                              //               // suffixIcon: Icon(Icons.beenhere_outlined)
                                              //               ),
                                              //           textAlign: TextAlign.center,
                                              //           //  maxLines: 3,
                                              //           //  minLines: 1,
                                              //           style: TextStyle(
                                              //             fontSize: size.iScreen(2.0),
                                              //             // fontWeight: FontWeight.bold,
                                              //             // letterSpacing: 2.0,s
                                              //           ),
                                              //           onChanged: (text) {
                                              //             controllerHosp
                                              //                 .setCantidadAlimento(text);
                                              //           },
                                              //           validator: (text) {
                                              //             if (text!.trim().isNotEmpty) {
                                              //               return null;
                                              //             } else {
                                              //               return 'Ingrese Cantidad';
                                              //             }
                                              //           },
                                              //         ),
                                              //       ),
                                              //     ),
                                              //   ],
                                              // ),
                                              // //***********************************************/
                                              // SizedBox(
                                              //   height: size.iScreen(1.5),
                                              // ),
                                              // //*****************************************/
                                              // Row(
                                              //   children: [
                                              //     Container(
                                              //       width: size.wScreen(12.0),

                                              //       // color: Colors.blue,
                                              //       child: Text('Vía : ',
                                              //           style: GoogleFonts.lexendDeca(
                                              //               // fontSize: size.iScreen(2.0),
                                              //               fontWeight: FontWeight.normal,
                                              //               color: Colors.grey)),
                                              //     ),
                                              //     Expanded(
                                              //       child: Container(
                                              //         // width: size.wScreen(20.0),
                                              //         child: TextFormField(
                                              //           initialValue: _estado == 'NUEVO'
                                              //               ? ""
                                              //               : controllerHosp.getViaAlimento,
                                              //           //     ? ''
                                              //           //     : controllerHospitalizacion.getExamenesComplementarios,
                                              //           // keyboardType: TextInputType.number,
                                              //           // inputFormatters: <TextInputFormatter>[
                                              //           //   FilteringTextInputFormatter.allow(
                                              //           //       RegExp(r'[0-9.]')),
                                              //           // ],
                                              //           decoration: const InputDecoration(
                                              //               // suffixIcon: Icon(Icons.beenhere_outlined)
                                              //               ),
                                              //           textAlign: TextAlign.center,
                                              //           //  maxLines: 3,
                                              //           //  minLines: 1,
                                              //           style: TextStyle(
                                              //             fontSize: size.iScreen(2.0),
                                              //             // fontWeight: FontWeight.bold,
                                              //             // letterSpacing: 2.0,
                                              //           ),
                                              //           onChanged: (text) {
                                              //             controllerHosp
                                              //                 .setViaAlimento(text);
                                              //           },
                                              //           validator: (text) {
                                              //             if (text!.trim().isNotEmpty) {
                                              //               return null;
                                              //             } else {
                                              //               return 'Ingrese Vía';
                                              //             }
                                              //           },
                                              //         ),
                                              //       ),
                                              //     ),
                                              //   ],
                                              // ),

                                              //***********************************************/
                                              SizedBox(
                                                height: size.iScreen(1.5),
                                              ),
                                              //*****************************************/
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Container(
                                                        // width: size.wScreen(18.0),

                                                        // color: Colors.blue,
                                                        child: Text('Inicio ',
                                                            style: GoogleFonts
                                                                .lexendDeca(
                                                                    // fontSize: size.iScreen(2.0),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    color: Colors
                                                                        .grey)),
                                                      ),
                                                      Container(
                                                        width:
                                                            size.wScreen(15.0),
                                                        child: TextFormField(
                                                          initialValue:
                                                              //  _estado == 'NUEVO'
                                                              //     ? "0"
                                                              //     :
                                                              controllerHosp
                                                                  .getInicioParametro,

                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          inputFormatters: <
                                                              TextInputFormatter>[
                                                            FilteringTextInputFormatter
                                                                .allow(RegExp(
                                                                    r'[0-9]')),
                                                          ],
                                                          decoration:
                                                              const InputDecoration(
                                                                  // suffixIcon: Icon(Icons.beenhere_outlined)
                                                                  ),
                                                          textAlign:
                                                              TextAlign.center,
                                                          //  maxLines: 3,
                                                          //  minLines: 1,
                                                          style: TextStyle(
                                                            fontSize: size
                                                                .iScreen(2.0),
                                                            // fontWeight: FontWeight.bold,
                                                            // letterSpacing: 2.0,s
                                                          ),
                                                          onChanged: (text) {
                                                            controllerHosp
                                                                .setInicioParametro(
                                                                    text);
                                                            // if(text.isNotEmpty){

                                                            // controllerHosp
                                                            //     .setInicioParametro(text);
                                                            // }
                                                            // else{
                                                            // controllerHosp
                                                            //     .setInicioParametro('0');

                                                            // }
                                                          },
                                                          validator: (text) {
                                                            if (text!
                                                                .trim()
                                                                .isNotEmpty) {
                                                              return null;
                                                            } else {
                                                              return 'Ingrese Inicio';
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      Container(
                                                        // width: size.wScreen(18.0),

                                                        // color: Colors.blue,
                                                        child: Text(
                                                            'Frecuencia ',
                                                            style: GoogleFonts
                                                                .lexendDeca(
                                                                    // fontSize: size.iScreen(2.0),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    color: Colors
                                                                        .grey)),
                                                      ),
                                                      Container(
                                                        width:
                                                            size.wScreen(15.0),
                                                        child: TextFormField(
                                                          initialValue:
                                                              // _estado == 'NUEVO'
                                                              //     ? "1"
                                                              //     :
                                                              controllerHosp
                                                                  .getFrecuenciaParametro,
                                                          //     ? ''
                                                          //     : controllerHosp.getExamenesComplementarios,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          inputFormatters: <
                                                              TextInputFormatter>[
                                                            FilteringTextInputFormatter
                                                                .allow(RegExp(
                                                                    r'[0-9]')),
                                                          ],
                                                          decoration:
                                                              const InputDecoration(
                                                                  // suffixIcon: Icon(Icons.beenhere_outlined)
                                                                  ),
                                                          textAlign:
                                                              TextAlign.center,
                                                          //  maxLines: 3,
                                                          //  minLines: 1,
                                                          style: TextStyle(
                                                            fontSize: size
                                                                .iScreen(2.0),
                                                            // fontWeight: FontWeight.bold,
                                                            // letterSpacing: 2.0,s
                                                          ),
                                                          onChanged: (text) {
                                                            controllerHosp
                                                                .setFrecuenciaParametro(
                                                                    text);
                                                            //  if(text.isNotEmpty){
                                                            // }
                                                            // else{
                                                            //   controllerHosp
                                                            //     .setFrecuenciaMedicina('1');
                                                            // }
                                                          },
                                                          validator: (text) {
                                                            if (text!
                                                                .trim()
                                                                .isNotEmpty) {
                                                              return null;
                                                            } else {
                                                              return 'Ingrese Frecuencia';
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              //***********************************************/
                                              SizedBox(
                                                height: size.iScreen(1.5),
                                              ),
                                              //*****************************************/

                                              // TextButton(
                                              //     onPressed: () {
                                              //       final isValidS = controllerHosp
                                              //           .validateFormAgregaParametro();
                                              //       if (!isValidS) return;
                                              //       if (isValidS) {
                                              //         if (controllerHosp
                                              //                 .getNombreParametro ==
                                              //             '') {
                                              //           FocusScope.of(context).unfocus();
                                              //           NotificatiosnService
                                              //               .showSnackBarDanger(
                                              //                   'Debe seleccionar Parametro');
                                              //         }
                                              //         if (controllerHosp
                                              //                 .getNombreParametro !=
                                              //             '') {
                                              //           controllerHosp
                                              //               .addCabeceraParametro();
                                              //           Navigator.pop(context);
                                              //         }
                                              //       }
                                              //     },
                                              //     child: Container(
                                              //       decoration: BoxDecoration(
                                              //           color: primaryColor,
                                              //           borderRadius:
                                              //               BorderRadius.circular(5.0)),
                                              //       // color: primaryColor,
                                              //       padding: EdgeInsets.symmetric(
                                              //           vertical: size.iScreen(0.5),
                                              //           horizontal: size.iScreen(0.5)),
                                              //       child: Text('Agregar',
                                              //           style: GoogleFonts.lexendDeca(
                                              //               // fontSize: size.iScreen(2.0),
                                              //               fontWeight: FontWeight.normal,
                                              //               color: Colors.white)),
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
            Text('${_listaParametros[index]['parametro']}'),
          ],
        )),
        DataCell(Text(_listaParametros[index]['dosis']??_listaParametros[index]['dosis'])),
        DataCell(Text(_listaParametros[index]['inicio'])),
        DataCell(Text(_listaParametros[index]['frecuencia'])),
      ],
      onLongPress: accion == 'NUEVO'
          ? () {
              // _eliminaRow(index);
              _showAlertDialog(index, _listaParametros[index]['parametro']);
            }
          : null,
    );
  }

  void _showAlertDialog(int _id, String _label) {
    showDialog(
        context: context,
        builder: (buildcontext) {
          return CupertinoAlertDialog(
            title: Text("¿ Eliminar $_label ?",
                style: GoogleFonts.lexendDeca(
                  // fontSize: size.iScreen(2.0),s
                  fontWeight: FontWeight.normal,
                  // color: primaryColor,
                )),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    _eliminaRow(_id);
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Si',
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
                    'No ',
                    style: GoogleFonts.lexendDeca(
                        // fontSize: size.iScreen(2.0),
                        fontWeight: FontWeight.normal,
                        color: tercearyColor),
                  ),
                ),
              ],
            ),
          );
        });
  }

  void _eliminaRow(int index) {
    context.read<HospitalizacionController>().eliminaParametroAgregada(
        _listaParametros[index]['idCabeceraParametro']);
  }

  //================================================= SELECCIONA FECHA PARAMETROS ==================================================//
  _fechaHoraParametros(
      BuildContext context, HospitalizacionController controller) async {
   
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      // locale: const Locale('es', 'ES'),
    );
    if (picked != null) {
      String? anio, mes, dia;
      anio = '${picked.year}';
      mes = (picked.month < 10) ? '0${picked.month}' : '${picked.month}';
      dia = (picked.day < 10) ? '0${picked.day}' : '${picked.day}';

      // setState(() {
      final _fechaInicio =
          '${anio.toString()}-${mes.toString()}-${dia.toString()}';
      // _fechaController.text = _fechaInicio;
      controller.setFechaHoraParametros(_fechaInicio);
      // print('FechaInicio: $_fechaInicio');
      // });
    }
  }

  //**********************************************BUSCA MASCOTA **********************************************************************//
  Future<bool?> _buscarParametro(BuildContext context, Responsive size) {
    return showDialog<bool>(
      barrierColor: Colors.black54,
      context: context,
      builder: (context) {
        // final controller = context.read<PropietariosController>();
        final controllerParametro = context.read<HospitalizacionController>();

        return AlertDialog(
            title: const Text("BUSCAR PARÁMETRO"),
            content: Card(
              color: Colors.transparent,
              elevation: 0.0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: size.iScreen(100.0),
                    child: Container(
                      // width: size.wScreen(45.0),
                      child: SizedBox(
                        width: size.iScreen(4.0),
                        child: TextFormField(
                          // controller: _textAddCorreo,
                          autofocus: true,
                          keyboardType: TextInputType.emailAddress,
                          textCapitalization: TextCapitalization.none,

                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          // validator: (value) {
                          //   final validador = validateEmail(value);
                          //   if (validador == null) {
                          //     controller.setIsCorreo(true);
                          //   }
                          //   return validateEmail(value);
                          // },
                          decoration:
                              const InputDecoration(hintText: '  Buscar...'
                                  // suffixIcon: Icon(Icons.beenhere_outlined)
                                  ),
                          inputFormatters: [
                            LowerCaseText(),
                          ],
                          textAlign: TextAlign.center,
                          style: const TextStyle(

                              // fontSize: size.iScreen(3.5),
                              // fontWeight: FontWeight.bold,
                              // letterSpacing: 2.0,
                              ),
                          onChanged: (text) {
                            controllerParametro.onSearchTextParametro(text);

                            if (controllerParametro
                                .nameSearchParametro.isEmpty) {
                              controllerParametro.buscaAllParametros('');
                            }
                          },
                        ),
                      ),
                      //===============================================//
                    ),
                  ),
                  SizedBox(
                      // color: Colors.red,
                      width: size.wScreen(100),
                      height: size.hScreen(30.0),
                      child:
                          // Text('DFD'),

                          Consumer<HospitalizacionController>(
                        builder: (_, providerParametro, __) {
                          if (providerParametro.getErrorParametros == null) {
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
                          } else if (providerParametro.getErrorParametros ==
                              false) {
                            return const NoData(
                              label: 'No existen datos para mostar',
                            );
                            // Text("Error al cargar los datos");
                          } else if (providerParametro
                              .getListaParametros.isEmpty) {
                            return const NoData(
                              label: 'No existen datos para mostar',
                            );
                          }
                          // print('esta es la lista*******************: ${providerParametro.getListaPropietarios.length}');

                          return ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount:
                                providerParametro.getListaParametros.length,
                            itemBuilder: (BuildContext context, int index) {
                              final _parametro =
                                  providerParametro.getListaParametros[index];
                              return GestureDetector(
                                onTap: () {
                                  context
                                      .read<HospitalizacionController>()
                                      .setParametroInfo(_parametro);
                                  // print('esta es la lista*******************: ${providerParametro.getDosisParametro}');
                                  // setState(() {
                                  //   _dosisParametro.text =
                                  //       providerParametro.getDosisParametro;
                                  // });

                                  Navigator.pop(context);
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
                                                      '${_parametro['paramNombre']}',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.45),
                                                              // color: Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                              );
                            },
                          );
                        },
                      ))
                ],
              ),
            )

            //  },)

            );
      },
    );
  }


  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _listaParametros.length;

  @override
  int get selectedRowCount => 0;
}

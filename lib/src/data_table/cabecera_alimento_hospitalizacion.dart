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

class CabeceraAlimentoHospitalizacionDTS extends DataTableSource {
  final BuildContext context;
  final List<dynamic> _listaAlimentos;
  final Responsive size;
  final String? accion;
    final bool? detalle;

  CabeceraAlimentoHospitalizacionDTS(
      this._listaAlimentos, this.size, this.context, this.accion, this.detalle);

  final controllersHome = HospitalizacionController();
  @override
  DataRow? getRow(int index) {

    _listaAlimentos.sort(
        (a, b) => b['idCabeceraAlimento'].compareTo(a['idCabeceraAlimento']));

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Row(
          children: [
          detalle==true? 
            IconButton(
              onPressed: () {
                // controllersHome.resetFormAddAlimento();
                //  final controller = context.read<c>();
                final controller = Provider.of<HospitalizacionController>(
                    context,
                    listen: false);
                controller
                    .setNombreAlimento(_listaAlimentos[index]['alimento']);
                controller.setDosisAlimento(_listaAlimentos[index]['dosis']);
                controller
                    .setCantidadAlimento(_listaAlimentos[index]['cantidad']);
                // controller
                //     .setViaAlimento(_listaAlimentos[index]['via']);
                controller.setInicioAlimento(_listaAlimentos[index]['inicio']);
                controller.setFrecuenciaAlimento(
                    _listaAlimentos[index]['frecuencia']);

                ///===========================================//
                showDialog<bool>(
                    barrierColor: Colors.black54,
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                          // title:  Text(" ALIMENTO ${controller.getNombreAlimento}"),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Expanded(child: Text("INGRESE ALIMENTO")),
                              IconButton(
                                  splashRadius: 25.0,
                                  onPressed: () {
                                    controller.getInfoRowAlimento(
                                        _listaAlimentos[index]
                                            ['idCabeceraAlimento']);
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
                                      height: size.hScreen(50.0),

                                      child: SingleChildScrollView(
                                        physics: const BouncingScrollPhysics(),
                                        child: Form(
                                          key: controllersHome
                                              .hospitalizacionAlimentoFormKey,
                                          child: Column(
                                            children: [
                                              Consumer<
                                                  HospitalizacionController>(
                                                builder: (_, valuefechaAlimento,
                                                    __) {
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
                                                          _fechaHoraAlimentos(
                                                              context,
                                                              valuefechaAlimento);
                                                        },
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              valuefechaAlimento
                                                                      .getFechaHoraAlimentos ??
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
                                              Row(
                                                children: [
                                                  Container(
                                                    width: size.wScreen(17.0),

                                                    // color: Colors.blue,
                                                    child: Text('Alimento:',
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
                                                            // _estado == 'NUEVO'
                                                            //     ? ""
                                                            //     :
                                                            controller
                                                                .getNombreAlimento,
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
                                                              .setNombreAlimento(
                                                                  text);
                                                        },
                                                        validator: (text) {
                                                          if (text!
                                                              .trim()
                                                              .isNotEmpty) {
                                                            return null;
                                                          } else {
                                                            return 'Ingrese Alimento';
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
                                                            _listaAlimentos[
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
                                                              .setDosisAlimento(
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
                                                    width: size.wScreen(17.0),

                                                    // color: Colors.blue,
                                                    child: Text('Cantidad: ',
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
                                                      width: size.wScreen(10.0),
                                                      child: TextFormField(
                                                        initialValue:
                                                            _listaAlimentos[
                                                                    index]
                                                                ['cantidad'],

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
                                                          fontSize:
                                                              size.iScreen(2.0),
                                                          // fontWeight: FontWeight.bold,
                                                          // letterSpacing: 2.0,s
                                                        ),
                                                        onChanged: (text) {
                                                          controller
                                                              .setCantidadAlimento(
                                                                  text);
                                                        },
                                                        validator: (text) {
                                                          if (text!
                                                              .trim()
                                                              .isNotEmpty) {
                                                            return null;
                                                          } else {
                                                            return 'Ingrese Cantidad';
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
                                                              _listaAlimentos[
                                                                      index]
                                                                  ['inicio'],

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
                                                            controller
                                                                .setInicioAlimento(
                                                                    text);
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
                                                      SizedBox(
                                                        width:
                                                            size.wScreen(15.0),
                                                        child: TextFormField(
                                                          initialValue:
                                                              _listaAlimentos[
                                                                      index][
                                                                  'frecuencia'],
                                                          //     ? ''
                                                          //     : controllersHome.getExamenesComplementarios,
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
                                                            controller
                                                                .setFrecuenciaAlimento(
                                                                    text);
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
            Text('${_listaAlimentos[index]['alimento']}'),
          ],
        )),
        DataCell(Text(_listaAlimentos[index]['dosis'])),
        DataCell(Text(_listaAlimentos[index]['cantidad'])),
        // DataCell(Text(_listaAlimentos[index]['via'])),
        DataCell(Text(_listaAlimentos[index]['inicio'])),
        DataCell(Text(_listaAlimentos[index]['frecuencia'])),
      ],
      onLongPress: accion == 'NUEVO'
          ? () {
              // context.read<HospitalizacionController>().eliminaAlimentoAgregada(_listaMedicamentos[index]['idCabeceraAlimendo']);
              // print('ESTE SE ELIMINARA: ${_listaMedicamentos[index]['idItem']}');
              // _eliminaRow(index);
               _showAlertDialog(index,_listaAlimentos[index]['alimento']);
            }
          : null,
    );
  }
  void _showAlertDialog(int _id,String _label) {
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
    context
        .read<HospitalizacionController>()
        .eliminaAlimentoAgregada(_listaAlimentos[index]['idCabeceraAlimento']);
  }

//================================================= SELECCIONA FECHA ALIMENTOS ==================================================//
  _fechaHoraAlimentos(
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
      controller.setFechaHoraAlimentos(_fechaInicio);
      // print('FechaInicio: $_fechaInicio');
      // });
    }
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _listaAlimentos.length;

  @override
  int get selectedRowCount => 0;
}

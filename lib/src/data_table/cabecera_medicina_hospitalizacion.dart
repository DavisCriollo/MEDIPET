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

class CabeceraMedicinaHospitalizacionDTS extends DataTableSource {
  final BuildContext context;
  final List<dynamic> _listaMedicamentos;
  final Responsive size;
  final String? accion;
  final bool? detalle;

  CabeceraMedicinaHospitalizacionDTS(
      this._listaMedicamentos, this.size, this.context, this.accion, this.detalle);

  final controllersHome = HospitalizacionController();
  @override
  DataRow? getRow(int index) {
    // _listaMedicamentos
    //     .sort((a, b) => b['idCabecera'].compareTo(a['idCabecera']));

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Row(
          children: [
      detalle==true? 
      // accion=='NUEVO' ||  accion=='EDITAR'? 
           IconButton(
              onPressed: () {
                final controller = Provider.of<HospitalizacionController>(
                    context,
                    listen: false);
                controller
                    .setNombreMedicina(_listaMedicamentos[index]['medicina']);
                controller.setDosisMedicina(_listaMedicamentos[index]['dosis']);
                controller
                    .setCantidadMedicina(_listaMedicamentos[index]['cantidad']);
                controller.setViaMedicina(_listaMedicamentos[index]['via']);
                controller
                    .setInicioMedicina(_listaMedicamentos[index]['inicio']);
                controller.setFrecuenciaMedicina(
                    _listaMedicamentos[index]['frecuencia']);

                ///===========================================//
                showDialog<bool>(
                    barrierColor: Colors.black54,
                    context: context,
                    builder: (context) {
                      // final controller = context.read<PropietariosController>();

                      // print('object ${controllerHosp.getNombreMedicina}');

                      // controller.setNombreMedicina('${controller.getNombreMedicina}');
                      return AlertDialog(
                          // title:  Text(" MEDICAMENTO ${controller.getNombreMedicina}"),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Expanded(child: Text("MEDICAMENTO")),
                              IconButton(
                                  splashRadius: 25.0,
                                  onPressed: () {
                                    final isValidS = controllersHome
                                        .validateFormAgregaMedicina();
                                    if (!isValidS) return;
                                    if (isValidS) {
                                      controller.getInfoRowMedicina(
                                          _listaMedicamentos[index]
                                              ['idCabecera']);
                                      Navigator.pop(context);
                                    }
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
                                              .hospitalizacionMedicinaFormKey,
                                          child: Column(
                                            children: [
                                              //***********************************************/
                                              SizedBox(
                                                height: size.iScreen(1.5),
                                              ),
                                              //*****************************************/
                                              Consumer<
                                                  HospitalizacionController>(
                                                builder: (_, valuefechaMedicina,
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
                                                          _fechaHoraMedicina(
                                                              context,
                                                              valuefechaMedicina);
                                                        },
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              valuefechaMedicina
                                                                      .getFechaHoraMedicina ??
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
                                                    child: Text('Medicina ',
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
                                                            .buscaAllMedicinas(
                                                                '');

                                                        // _buscarMascota(context, size);
                                                        _buscarMedicina(
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
                                                builder: (context,
                                                    valueMediciva, __) {
                                                  valueMediciva.setNombreMedicina(
                                                      '${valueMediciva.getNombreMedicina}');
                                                  return SizedBox(
                                                    width: size.wScreen(100.0),

                                                    // color: Colors.blue,
                                                    child: Text(
                                                        '${valueMediciva.getNombreMedicina}',
                                                        // : '${controllersHome.getNombreMedicina}',
                                                        style: GoogleFonts
                                                            .lexendDeca(
                                                                // fontSize: size.iScreen(2.0),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                color: valueMediciva
                                                                            .getNombreMedicina ==
                                                                        ''
                                                                    ? Colors
                                                                        .grey
                                                                    : Colors
                                                                        .black)),
                                                  );
                                                },
                                              ),
                                              //

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
                                                            _listaMedicamentos[
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
                                                              .setDosisMedicina(
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
                                                    child: Text('Cantidad:',
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
                                                            _listaMedicamentos[
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
                                                              .setCantidadMedicina(
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
                                                children: [
                                                  Container(
                                                    width: size.wScreen(12.0),

                                                    // color: Colors.blue,
                                                    child: Text('Vía : ',
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
                                                            _listaMedicamentos[
                                                                index]['via'],
                                                        //     ? ''
                                                        //     : controllersHomeitalizacion.getExamenesComplementarios,
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
                                                              .setViaMedicina(
                                                                  text);
                                                        },
                                                        validator: (text) {
                                                          if (text!
                                                              .trim()
                                                              .isNotEmpty) {
                                                            return null;
                                                          } else {
                                                            return 'Ingrese Vía';
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
                                                              _listaMedicamentos[
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
                                                                .setInicioMedicina(
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
                                                              _listaMedicamentos[
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
                                                                .setFrecuenciaMedicina(
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
            )
            :Container(),
            Text(
                '${_listaMedicamentos[index]['idCabecera']} - ${_listaMedicamentos[index]['medicina']}'),
          ],
        )),
        DataCell(Text(_listaMedicamentos[index]['dosis'])),
        DataCell(Text(_listaMedicamentos[index]['cantidad'])),
        DataCell(Text(_listaMedicamentos[index]['via'])),
        DataCell(Text(_listaMedicamentos[index]['inicio'].toString())),
        DataCell(Text(_listaMedicamentos[index]['frecuencia'].toString())),
      ],
      onLongPress: accion == 'NUEVO'
          ? () {
              // _eliminaRow(index);

              _showAlertDialog(index,_listaMedicamentos[index]['medicina']);
            }
          : null,
    );
  }

  void _showAlertDialog(int _id,String _medicamento) {
    showDialog(
        context: context,
        builder: (buildcontext) {
          return CupertinoAlertDialog(
            title: Text("¿ Eliminar $_medicamento ?",
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
        .eliminaMedicinaAgregada(_listaMedicamentos[index]['idCabecera']);
  }

//================================================= SELECCIONA FECHA MEDICINA ==================================================//
  _fechaHoraMedicina(
      BuildContext context, HospitalizacionController controller) async {
    // _selectFechaNacimiento(
    //                                     context, controller);
    // _selectFechaInicio(
    //     BuildContext context, MascotasController mascotaController) async {
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
      controller.setFechaHoraMedicina(_fechaInicio);
      // print('FechaInicio: $_fechaInicio');
      // });
    }
  }

  //**********************************************BUSCA MASCOTA **********************************************************************//
  Future<bool?> _buscarMedicina(BuildContext context, Responsive size) {
    return showDialog<bool>(
      barrierColor: Colors.black54,
      context: context,
      builder: (context) {
        // final controller = context.read<PropietariosController>();
        final controllerMedicina = context.read<HospitalizacionController>();

        return AlertDialog(
            title: const Text("BUSCAR MEDICINA"),
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
                            controllerMedicina.onSearchTextMedicina(text);

                            if (controllerMedicina.nameSearchMedicina.isEmpty) {
                              controllerMedicina.buscaAllMedicinas('');
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
                        builder: (_, providerMedicina, __) {
                          if (providerMedicina.getErrorMedicinas == null) {
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
                          } else if (providerMedicina.getErrorMedicinas ==
                              false) {
                            return const NoData(
                              label: 'No existen datos para mostar',
                            );
                            // Text("Error al cargar los datos");
                          } else if (providerMedicina
                              .getListaMedicinas.isEmpty) {
                            return const NoData(
                              label: 'No existen datos para mostar',
                            );
                          }
                          // print('esta es la lista*******************: ${providerMedicina.getListaPropietarios.length}');

                          return ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount:
                                providerMedicina.getListaMedicinas.length,
                            itemBuilder: (BuildContext context, int index) {
                              final _medicina =
                                  providerMedicina.getListaMedicinas[index];
                              return GestureDetector(
                                onTap: () {
                                  context
                                      .read<HospitalizacionController>()
                                      .setMedicinaInfo(_medicina);

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
                                                      '${_medicina['invNombre']}',
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
  int get rowCount => _listaMedicamentos.length;

  @override
  int get selectedRowCount => 0;
}

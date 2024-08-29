import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:neitorcont/src/controllers/home_controller.dart';

import 'package:neitorcont/src/controllers/propietarios_controller.dart';
import 'package:neitorcont/src/models/sesison_model.dart';
import 'package:neitorcont/src/pages/buscar_propietario.dart';
import 'package:neitorcont/src/services/notifications_service.dart';
import 'package:neitorcont/src/services/socket_service.dart';
import 'package:neitorcont/src/theme/theme_provider.dart';
import 'package:neitorcont/src/theme/themes_app.dart';
import 'package:neitorcont/src/utils/dialogs.dart';
import 'package:neitorcont/src/utils/letras_mayusculas_minusculas.dart';
import 'package:neitorcont/src/utils/responsive.dart';
import 'package:neitorcont/src/utils/theme.dart';
import 'package:neitorcont/src/utils/valida_cedula.dart';
import 'package:neitorcont/src/utils/valida_email.dart';
import 'package:neitorcont/src/widgets/dropdown_tipo_documento.dart';

import 'package:neitorcont/src/widgets/no_data.dart';

import 'package:provider/provider.dart';

class CrearPropietario extends StatefulWidget {
  final String? action;
  final Session? user;
  const CrearPropietario({Key? key, this.action,  this.user}) : super(key: key);

  @override
  State<CrearPropietario> createState() => _CrearPropietarioState();
}

enum Documento { cedula, ruc, pasaporte }
enum Genero { masculino, femenino }

class _CrearPropietarioState extends State<CrearPropietario> {
  TextEditingController _textCedula = TextEditingController();
  TextEditingController _textNombre = TextEditingController();
  TextEditingController _textDireccion = TextEditingController();
  TextEditingController _textTelefono = TextEditingController();
  TextEditingController _textObservacion = TextEditingController();
  TextEditingController _textAddTelefono = TextEditingController();
  TextEditingController _textAddCorreo = TextEditingController();
 TextEditingController _textAddPlaca = TextEditingController();

  TextEditingController controllerTextCountry = TextEditingController();
  Genero? _genero;
  // PhoneCountryData? _initialCountryData;
//  String initialCountry = 'NG';
//   PhoneNumber number = PhoneNumber(isoCode: 'NG');

  final listaDepaises = [];
  final _listaRecomendaciones = [];

  final controllerPropietarios = PropietariosController();

  // int _value = 2;
  // // int _valueGenero = 2;
  // Documento? _docum = Documento.cedula;

  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  void dispose() {
    _textCedula.clear();
    _textNombre.clear();
    _textDireccion.clear();
    _textTelefono.clear();
    _textObservacion.clear();
    _textAddCorreo.clear();
    _textAddTelefono.clear();
    controllerTextCountry.clear();
    super.dispose();
  }

  initData() async {
    controllerPropietarios.resetFormPropietario();
    // _textCedula.text = '';

    await controllerPropietarios.buscaRecomendaciones();
    await controllerPropietarios.buscaPaises();

    final _paises = controllerPropietarios.getListaTodosLosPaises;
    final _recomendacion = controllerPropietarios.getListaRecomendaciones;
// controllerPropietarios.setListaTodosLosPaises(_paises);
    listaDepaises.addAll(_paises);

    //  widget.action == 'CREATE'?
    _listaRecomendaciones.addAll(_recomendacion);

    // print('PAISES: ${_listaDepaises}');

_textCedula.text='';
    _textNombre.text='';
    _textDireccion.text='';
    _textTelefono.text='';
    _textObservacion.text='';
    _textAddCorreo.text='';
    _textAddTelefono.text='';
    controllerTextCountry.text='';
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.read<PropietariosController>();
      final ctrlHome = context.read<HomeController>();
     final colorTheme=context.read<AppTheme>();
    if (controller.getGeneros == 'M') {
      _genero = Genero.masculino;
    } else if (controller.getGeneros == 'F') {
      _genero = Genero.femenino;
    } else if (controller.getGeneros == null) {
      _genero = Genero.masculino;
    }

// _textCedula.text= widget.action == 'CREATE' ? controller.getDocumento!:'';
// _textNombre.text= widget.action == 'CREATE' ?controller.getNombres!:'';
// _textDireccion.text= widget.action == 'CREATE' ? controller.getDireccion!:'';
// _textTelefono.text= (widget.action == 'CREATE' ? controller.labelTelefono!=null?controller.labelTelefono:'':'')!;
// _textObservacion.text= widget.action == 'CREATE' ? controller.getDireccion!:'';

    _textCedula.text = controller.getDocumento!;
    _textNombre.text = controller.getNombres!;
    _textDireccion.text =controller.getDireccion!;
    // _textTelefono.text = controller.labelTelefono!; //=null?controller.labelTelefono:'';
    _textObservacion.text =controller.getObservacion!;

    // _textCedula.text = controller.getDocumento!;
    // _textNombre.text = controller.getNombres!;
    // _textDireccion.text = controller.getDireccion!;
    // _textTelefono.text = (widget.action == 'CREATE'
    //     ? ''
    //     : controller.labelTelefono != null
    //         ? controller.labelTelefono
    //         : '')!;
    // _textObservacion.text = controller.getDireccion!;

    // print('ACTION: ${widget.action}');

    controller.getGeneros;
    final Responsive size = Responsive.of(context);
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            title: widget.action == 'CREATE' || widget.action == 'SEARCH'
                ?  Text('Crear Cliente')
                :  Text('Editar Cliente'),
            actions: [
              Container(
                margin: EdgeInsets.only(right: size.iScreen(1.5)),
                child: IconButton(
                    splashRadius: 28,
                    onPressed: () {
                      _onSubmit(context, controller, widget.action);
                    },
                    icon: Icon(
                      Icons.save_outlined,
                      size: size.iScreen(4.0),
                    )),
              )
            ],
          ),
          body: Container(
            // color: Colors.red,
            margin: EdgeInsets.only(
                left: size.iScreen(1.5),
                right: size.iScreen(1.5),
                bottom: size.iScreen(1.0)),
            width: size.wScreen(100),
            height: size.hScreen(100),
            child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Form(
                        key: controller.propietariosFormKey,
                        child: Column(
                          children: [
                            //***********************************************/
                            SizedBox(
                              height: size.iScreen(1.0),
                            ),
                            //*****************************************/

                            Container(
                              width: size.wScreen(100.0),

                              // color: Colors.blue,
                              child: Row(
                                children: [
                                  Text('Tipo de Documento: ',
                                      style: GoogleFonts.lexendDeca(
                                          // fontSize: size.iScreen(2.0),
                                          fontWeight: FontWeight.normal,
                                          color: Colors.grey)),
                                  widget.action == 'CREATE' ||
                                          widget.action == 'SEARCH'
                                      ? const DropMenuTipoDocumento(
                                          data: [
                                            'CEDULA',
                                            'RUC',
                                            'PASAPORTE',
                                          ],
                                          hinText: 'seleccione Tipo',
                                        )
                                      : Container(
                                          child: Text(
                                              ' ${controller.labelTipoDocumento}',
                                              style: GoogleFonts.lexendDeca(
                                                  // fontSize: size.iScreen(2.0),
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black)),
                                        ),
                                ],
                              ),
                            ),

                            //***********************************************/
                            SizedBox(
                              height: size.iScreen(1.0),
                            ),
                            //*****************************************/

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    SizedBox(
                                      // width: size.wScreen(30.0),

                                      // color: Colors.blue,
                                      child: Text('Documento ',
                                          style: GoogleFonts.lexendDeca(
                                              // fontSize: size.iScreen(2.0),
                                              fontWeight: FontWeight.normal,
                                              color: Colors.grey)),
                                    ),
                                    Consumer<PropietariosController>(
                                      builder: (_, providerCedula, __) {
                                        return Row(children: [
                                          Container(
                                            width: size.wScreen(40.0),
                                            child: TextFormField(
                                              // controller: _textCedula,
                                              maxLength: 13,
                                              readOnly:
                                                  widget.action == 'CREATE'
                                                      ? false
                                                      : true,
                                              // controller: _textCedula,
                                              initialValue:
                                                  widget.action == 'CREATE'
                                                      ? ''
                                                      : controller.getDocumento,
                                              decoration: InputDecoration(
                                                  suffixIcon: controller
                                                                  .getDocumento!
                                                                  .length ==
                                                              10 &&
                                                          controller
                                                                  .getIsCedula ==
                                                              true
                                                      ?
                                                      // controller.getIsCedula ==
                                                      //     true
                                                      //     ?
                                                      const Icon(
                                                          Icons.check_circle,
                                                          color: alertColor,
                                                        )
                                                      : null
                                                  // const Icon(
                                                  //     Icons.error_outline,
                                                  //     color: errorColor,
                                                  //   )
                                                  ),
                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: <
                                                  TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .allow(RegExp(r'[0-9]')),
                                              ],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: size.iScreen(2.3),
                                                // fontWeight: FontWeight.bold,
                                                // letterSpacing: 2.0,
                                              ),
                                              onChanged: (text) {
                                                controller.setDocumento(text);
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
                                         
                                         
                                         
                                          SizedBox(
                                            width: size.iScreen(2.0),
                                          ),
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: GestureDetector(
                                              onTap: controller.getDocumento!.isNotEmpty? () async {
                                                final ctrlPropi=context.read<PropietariosController>();

           ProgressDialog.show(context);
            final response = await   ctrlPropi.searchCliente();
            ProgressDialog.dissmiss(context);
              
               if (response != null) {
                    _textNombre.text=ctrlPropi.getNombres!.toUpperCase();
                     _textDireccion.text=ctrlPropi.getDireccion!.toUpperCase();
                      _textTelefono.text=ctrlPropi.labelTelefono!;
                    _textObservacion.text=ctrlPropi.getObservacion!.toUpperCase();
                    
               }else{
                 _textCedula.text='';
                // NotificatiosnService.showSnackBarDanger( 'No se encuentra información o Documento incorrecto, ingrese datos manualmente');
                
               }
                                              

                                                //     .searchAllPersinas('');
                                                // Navigator.of(context).push(
                                                //     MaterialPageRoute(
                                                //         builder: (context) =>
                                                //             BuscarPropietario()));
                                              }:(){

                                     NotificatiosnService.showSnackBarDanger( 'Debe ingresar Documento para buscar');

                                              },
                                              child: 
                                              // Container(
                                              //   alignment: Alignment.center,
                                              //   color: primaryColor,
                                              //   width: size.iScreen(3.5),
                                              //   padding: EdgeInsets.only(
                                              //     top: size.iScreen(0.5),
                                              //     bottom: size.iScreen(0.5),
                                              //     left: size.iScreen(0.5),
                                              //     right: size.iScreen(0.5),
                                              //   ),
                                              //   child: Icon(
                                              //     Icons.search_outlined,
                                              //     color: Colors.white,
                                              //     size: size.iScreen(2.0),
                                              //   ),
                                              // ),
                                               Consumer<ThemeProvider>(builder: (_, valueTheme, __) {  
                                        return Container(
                                          alignment: Alignment.center,
                                          color: valueTheme.appTheme.primaryColor,
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
                                        );
                                      },
                                      ),
                                            ),
                                          ),
                                            
                                       
                                       
                                        ]);
                                      },
                                    ),
                                  ],
                                ),
                            widget.user!.empCategoria!='CONTABLE'
                            ?    Column(
                                  children: [
                                    SizedBox(
                                      // width: size.wScreen(30.0),

                                      // color: Colors.blue,
                                      child: Text('Género ',
                                          style: GoogleFonts.lexendDeca(
                                              // fontSize: size.iScreen(2.0),
                                              fontWeight: FontWeight.normal,
                                              color: Colors.grey)),
                                    ),
                                    //***********************************************/
                                    SizedBox(
                                      height: size.iScreen(0.5),
                                    ),
                                    //*****************************************/
                                    // Row(
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment.spaceAround,
                                    //   children: [
                                    //     Column(
                                    //       children: [
                                    //         Container(
                                    //           child: Text('M',
                                    //               style: GoogleFonts.lexendDeca(
                                    //                   // fontSize: size.iScreen(2.0),
                                    //                   fontWeight:
                                    //                       FontWeight.normal,
                                    //                   color: Colors.black)),
                                    //         ),
                                    //         Column(
                                    //           children: <Widget>[
                                    //             Container(
                                    //               // width: size.iScreen(7.0),
                                    //               child: Radio<Genero>(
                                    //                 visualDensity:
                                    //                     VisualDensity.compact,
                                    //                 value: Genero.masculino,
                                    //                 groupValue: _genero,
                                    //                 onChanged: (Genero? value) {
                                    //                   setState(() {
                                    //                     _genero = value;
                                    //                     controller
                                    //                         .setGeneros('M');
                                    //                     // print('GENERO: $value');
                                    //                   });
                                    //                 },
                                    //               ),
                                    //             ),
                                    //           ],
                                    //         )
                                    //       ],
                                    //     ),
                                    //     Column(
                                    //       children: [
                                    //         Container(
                                    //           // width: size.iScreen(7.0),
                                    //           child: Text('F',
                                    //               style: GoogleFonts.lexendDeca(
                                    //                   // fontSize: size.iScreen(2.0),
                                    //                   fontWeight:
                                    //                       FontWeight.normal,
                                    //                   color: Colors.black)),
                                    //         ),
                                    //         Container(
                                    //           child: Radio<Genero>(
                                    //             visualDensity:
                                    //                 VisualDensity.compact,
                                    //             value: Genero.femenino,
                                    //             groupValue: _genero,
                                    //             onChanged: (Genero? value) {
                                    //               setState(() {
                                    //                 _genero = value;
                                    //                 // print('GENERO: $value');
                                    //                 controller.setGeneros('F');
                                    //               });
                                    //             },
                                    //           ),
                                    //         ),
                                    //       ],
                                    //     ),
                                    //   ],
                                    // ),
                                  
                                    Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Text('M',
                style: GoogleFonts.lexendDeca(
                    fontWeight: FontWeight.normal, color: Colors.black)),
            Consumer<PropietariosController>(
              builder: (context, generoProvider, _) {
                return Radio<String>(
                  visualDensity: VisualDensity.compact,
                  value: 'M',
                  groupValue: generoProvider.getGeneros,
                  onChanged: (String? value) {
                    generoProvider.setGeneros(value!);
                    // Realiza acciones adicionales si es necesario
                  },
                );
              },
            ),
          ],
        ),
        Column(
          children: [
            Text('F',
                style: GoogleFonts.lexendDeca(
                    fontWeight: FontWeight.normal, color: Colors.black)),
            Consumer<PropietariosController>(
              builder: (context, generoProvider, _) {
                return Radio<String>(
                  visualDensity: VisualDensity.compact,
                  value: 'F',
                  groupValue: generoProvider.getGeneros,
                  onChanged: (String? value) {
                    generoProvider.setGeneros(value!);
                    // Realiza acciones adicionales si es necesario
                  },
                );
              },
            ),
          ],
        ),
    
    
                                  
                                  ],
                                ),
                             

                                  
                                  
                                  
                                  ],
                                ):Container(),
                              ],
                            ),

                            //***********************************************/
                            SizedBox(
                              height: size.iScreen(1.5),
                            ),
                            //*****************************************/

                            SizedBox(
                              width: size.wScreen(100.0),

                              // color: Colors.blue,
                              child: Text('Apellidos y Nombres ',
                                  style: GoogleFonts.lexendDeca(
                                      // fontSize: size.iScreen(2.0),
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey)),
                            ),


                            Consumer<PropietariosController>(builder: (_, value, __) {  

                                // _textNombre.text=value.getNombres!;
                              return   Container(
                              // width: size.wScreen(45.0),
                              child: TextFormField(
                                controller: _textNombre,
                                //  widget.action == 'CREATE'
                                //                       ? _textNombre
                                //                       : null,

                                // initialValue:  controller.getNombres,
                                // initialValue:
                                //     // controller.getNombres,
                                //     widget.action == 'CREATE'
                                //         ? controller.getNombres
                                //         : controller.getNombres,
                                decoration: const InputDecoration(),
                                inputFormatters: [
                                  UpperCaseText(),
                                ],
                                // suffixIcon: Icon(Icons.beenhere_outlined)

                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: size.iScreen(2.0),
                                  // fontWeight: FontWeight.bold,
                                  // letterSpacing: 2.0,
                                ),
                                onChanged: (text) {
                                  controller.setNombres(text);
                                },
                                validator: (text) {
                                  if (text!.trim().isNotEmpty) {
                                    return null;
                                  } else {
                                    return 'Ingrese Nombres del Cliente';
                                  }
                                },
                              ),
                            );

                         
                            },),
                           
                            // //***********************************************/
                            // SizedBox(
                            //   height: size.iScreen(2.0),
                            // ),
                            // //*****************************************/

                            // SizedBox(
                            //   width: size.wScreen(100.0),

                            //   // color: Colors.blue,
                            //   child: Text('Ocupación',
                            //       style: GoogleFonts.lexendDeca(
                            //           // fontSize: size.iScreen(2.0),
                            //           fontWeight: FontWeight.normal,
                            //           color: Colors.grey)),
                            // ),
                            // Container(
                            //   // width: size.wScreen(45.0),
                            //   child: TextFormField(
                            //     initialValue: controller.getOcupacion,
                            //     decoration: const InputDecoration(
                            //         // suffixIcon: Icon(Icons.beenhere_outlined)
                            //         ),
                            //     // textAlign: TextAlign.center,
                            //     style: TextStyle(
                            //       fontSize: size.iScreen(2.0),
                            //       // fontWeight: FontWeight.bold,
                            //       // letterSpacing: 2.0,
                            //     ),
                            //     onChanged: (text) {
                            //       controller.setOcupacion(text);
                            //     },
                            //     validator: (text) {
                            //       if (text!.trim().isNotEmpty) {
                            //         return null;
                            //       } else {
                            //         return 'Ingrese Ocupación';
                            //       }
                            //     },
                            //   ),
                            // ),

                            //***********************************************/
                            SizedBox(
                              height: size.iScreen(2.0),
                            ),
                            //*****************************************/

                            SizedBox(
                              width: size.wScreen(100.0),

                              // color: Colors.blue,
                              child: Text('Dirección',
                                  style: GoogleFonts.lexendDeca(
                                      // fontSize: size.iScreen(2.0),
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey)),
                            ),
                            Container(
                              // width: size.wScreen(45.0),
                              child: TextFormField(
                                // initialValue: widget.action == 'CREATE'
                                //     ? ''
                                //     : controller.getDireccion,
                                controller: _textDireccion,
                                decoration: const InputDecoration(
                                    // suffixIcon: Icon(Icons.beenhere_outlined)
                                    ),
                                // textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: size.iScreen(2.0),
                                  // fontWeight: FontWeight.bold,
                                  // letterSpacing: 2.0,
                                ),
                                onChanged: (text) {
                                  controller.setDireccion(text);
                                },
                                validator: (text) {
                                  if (text!.trim().isNotEmpty) {
                                    return null;
                                  } else {
                                    return 'Ingrese Dirección';
                                  }
                                },
                              ),
                            ),

                            //***********************************************/
                            SizedBox(
                              height: size.iScreen(2.0),
                            ),
                            //*****************************************/

                            SizedBox(
                              width: size.wScreen(100.0),

                              // color: Colors.blue,
                              child: Text('Teléfono',
                                  style: GoogleFonts.lexendDeca(
                                      // fontSize: size.iScreen(2.0),
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey)),
                            ),
                            Container(
                              // width: size.wScreen(45.0),
                              child: TextFormField(
                                controller: _textTelefono,
                                // initialValue: widget.action == 'CREATE'
                                //     ? ''
                                //     : controller.labelTelefono,
                                decoration: const InputDecoration(
                                    // suffixIcon: Icon(Icons.beenhere_outlined)
                                    ),
                                // textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]')),
                                ],
                                style: TextStyle(
                                  fontSize: size.iScreen(2.0),
                                  // fontWeight: FontWeight.bold,
                                  // letterSpacing: 2.0,
                                ),
                                onChanged: (text) {
                                  controller.setLabelTelefono(text);
                                },
                                // validator: (text) {
                                //   if (text!.trim().isNotEmpty) {
                                //     return null;
                                //   } else {
                                //     return 'Ingrese Teléfono';
                                //   }
                                // },
                              ),
                            ),

                            //***********************************************/
                            SizedBox(
                              height: size.iScreen(2.0),
                            ),
                            //*****************************************/

                            Row(
                              children: [
                                SizedBox(
                                    width: size.wScreen(20.0),

                                    // color: Colors.blue,
                                    child: Consumer<PropietariosController>(
                                      builder: (_, valuePlaca, __) {
                                        return Row(
                                          children: [
                                            Text('Placa: ',
                                                style: GoogleFonts.lexendDeca(
                                                    // fontSize: size.iScreen(2.0),
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.grey)),
                                            valuePlaca
                                                    .getlistaAddPlacas!
                                                    .isNotEmpty
                                                ? Text(
                                                    '${valuePlaca.getlistaAddPlacas!.length} ',
                                                    style:
                                                        GoogleFonts.lexendDeca(
                                                            // fontSize: size.iScreen(2.0),
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color: Colors.grey))
                                                : Container(),
                                          ],
                                        );
                                      },
                                    )),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: GestureDetector(
                                    onTap: () {
                                      _agregaPlaca(context, controller, size);
                                    },
                                    child: 
                                    // Consumer<AppTheme>(builder: (_, valueTheme, __) {  
                                    //   return Container(
                                    //     alignment: Alignment.center,
                                    //     color: valueTheme.getPrimaryTextColor,
                                    //     width: size.iScreen(3.5),
                                    //     padding: EdgeInsets.only(
                                    //       top: size.iScreen(0.5),
                                    //       bottom: size.iScreen(0.5),
                                    //       left: size.iScreen(0.5),
                                    //       right: size.iScreen(0.5),
                                    //     ),
                                    //     child: Icon(
                                    //       Icons.add,
                                    //       color: valueTheme.getSecondryTextColor,
                                    //       size: size.iScreen(2.0),
                                    //     ),
                                    //   );
                                    // },
                                    
                                    // ),
                                       Consumer<ThemeProvider>(builder: (_, valueTheme, __) {  
                                        return Container(
                                          alignment: Alignment.center,
                                          color: valueTheme.appTheme.primaryColor,
                                          width: size.iScreen(3.5),
                                          padding: EdgeInsets.only(
                                            top: size.iScreen(0.5),
                                            bottom: size.iScreen(0.5),
                                            left: size.iScreen(0.5),
                                            right: size.iScreen(0.5),
                                          ),
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.white,
                                            size: size.iScreen(2.0),
                                          ),
                                        );
                                      },
                                      ),
                                  ),
                                ),
                              ],
                            ),

//***********************************************/
                            SizedBox(
                              height: size.iScreen(0.0),
                            ),
                            //*****************************************/

                            Consumer<PropietariosController>(
                              builder: (_, valuePlacas, __) {
                                return SizedBox(
                                  // color: Colors.red,
                                  width: size.wScreen(100.0),
                                  child: Wrap(
                                    children: valuePlacas
                                        .getlistaAddPlacas!
                                        .map(
                                          (e) => Row(
                                            children: [
                                              Expanded(
                                                child: GestureDetector(
                                                  onDoubleTap: () {
                                                    // print(e);
                                                    valuePlacas
                                                        .eliminaPlaca(e);
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors
                                                            .grey.shade200,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0)),
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            vertical: size
                                                                .iScreen(0.5)),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: size
                                                                .iScreen(1.0),
                                                            vertical: size
                                                                .iScreen(0.5)),
                                                    child: Text('$e',
                                                        style: GoogleFonts
                                                            .lexendDeca(
                                                                fontSize: size
                                                                    .iScreen(
                                                                        2.0),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                color: Colors
                                                                    .black)),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                        .toList(),
                                  ),
                                );
                              },
                            ),
//
                         
                           
                            //***********************************************/
                            SizedBox(
                              height: size.iScreen(2.0),
                            ),
                            //*****************************************/

                            Row(
                              children: [
                                SizedBox(
                                    width: size.wScreen(20.0),

                                    // color: Colors.blue,
                                    child: Consumer<PropietariosController>(
                                      builder: (_, valueCantCelulares, __) {
                                        return Row(
                                          children: [
                                            Text('Celular: ',
                                                style: GoogleFonts.lexendDeca(
                                                    // fontSize: size.iScreen(2.0),
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.grey)),
                                            valueCantCelulares
                                                    .getlistaAddCelulares!
                                                    .isNotEmpty
                                                ? Text(
                                                    '${valueCantCelulares.getlistaAddCelulares!.length} ',
                                                    style:
                                                        GoogleFonts.lexendDeca(
                                                            // fontSize: size.iScreen(2.0),
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color: Colors.grey))
                                                : Container(),
                                          ],
                                        );
                                      },
                                    )),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: GestureDetector(
                                    onTap: () {
                                      _agregaCelular(context, controller, size);
                                    },
                                    child: 
                                    // Consumer<AppTheme>(builder: (_, valueTheme, __) {  
                                    //   return Container(
                                    //     alignment: Alignment.center,
                                    //     color: valueTheme.getPrimaryTextColor,
                                    //     width: size.iScreen(3.5),
                                    //     padding: EdgeInsets.only(
                                    //       top: size.iScreen(0.5),
                                    //       bottom: size.iScreen(0.5),
                                    //       left: size.iScreen(0.5),
                                    //       right: size.iScreen(0.5),
                                    //     ),
                                    //     child: Icon(
                                    //       Icons.add,
                                    //       color: valueTheme.getSecondryTextColor,
                                    //       size: size.iScreen(2.0),
                                    //     ),
                                    //   );
                                    // },
                                    
                                    // ),
                                       Consumer<ThemeProvider>(builder: (_, valueTheme, __) {  
                                        return Container(
                                          alignment: Alignment.center,
                                          color: valueTheme.appTheme.primaryColor,
                                          width: size.iScreen(3.5),
                                          padding: EdgeInsets.only(
                                            top: size.iScreen(0.5),
                                            bottom: size.iScreen(0.5),
                                            left: size.iScreen(0.5),
                                            right: size.iScreen(0.5),
                                          ),
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.white,
                                            size: size.iScreen(2.0),
                                          ),
                                        );
                                      },
                                      ),
                                  ),
                                ),
                              ],
                            ),

//
                            //***********************************************/
                            SizedBox(
                              height: size.iScreen(0.0),
                            ),
                            //*****************************************/

                            Consumer<PropietariosController>(
                              builder: (_, valueCelulares, __) {
                                return SizedBox(
                                  // color: Colors.red,
                                  width: size.wScreen(100.0),
                                  child: Wrap(
                                    children: valueCelulares
                                        .getlistaAddCelulares!
                                        .map(
                                          (e) => Row(
                                            children: [
                                              Expanded(
                                                child: GestureDetector(
                                                  onDoubleTap: () {
                                                    // print(e);
                                                    valueCelulares
                                                        .eliminaCelular(e);
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors
                                                            .grey.shade200,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0)),
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            vertical: size
                                                                .iScreen(0.5)),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: size
                                                                .iScreen(1.0),
                                                            vertical: size
                                                                .iScreen(0.5)),
                                                    child: Text('$e',
                                                        style: GoogleFonts
                                                            .lexendDeca(
                                                                fontSize: size
                                                                    .iScreen(
                                                                        2.0),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                color: Colors
                                                                    .black)),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                        .toList(),
                                  ),
                                );
                              },
                            ),
//
                            //***********************************************/
                            SizedBox(
                              height: size.iScreen(2.0),
                            ),
                            //*****************************************/

                            Row(
                              children: [
                                SizedBox(
                                    width: size.wScreen(20.0),

                                    // color: Colors.blue,
                                    child: Consumer<PropietariosController>(
                                      builder: (_, valueCantCorreos, __) {
                                        return Row(
                                          children: [
                                            Text('Correo: ',
                                                style: GoogleFonts.lexendDeca(
                                                    // fontSize: size.iScreen(2.0),
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.grey)),
                                            valueCantCorreos.getlistaAddCorreos!
                                                    .isNotEmpty
                                                ? Text(
                                                    '${valueCantCorreos.getlistaAddCorreos!.length} ',
                                                    style:
                                                        GoogleFonts.lexendDeca(
                                                            // fontSize: size.iScreen(2.0),
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color: Colors.grey))
                                                : Container(),
                                          ],
                                        );
                                      },
                                    )),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: GestureDetector(
                                    onTap: () {
                                      _agregaCorreo(context, controller, size);

//*******************************************/
                                    },
                                    child: 
                                    // Consumer<AppTheme>(builder: (_, valueTheme, __) {  
                                    //   return Container(
                                    //     alignment: Alignment.center,
                                    //     color: valueTheme.getPrimaryTextColor,
                                    //     width: size.iScreen(3.5),
                                    //     padding: EdgeInsets.only(
                                    //       top: size.iScreen(0.5),
                                    //       bottom: size.iScreen(0.5),
                                    //       left: size.iScreen(0.5),
                                    //       right: size.iScreen(0.5),
                                    //     ),
                                    //     child: Icon(
                                    //       Icons.add,
                                    //       color: valueTheme.getSecondryTextColor,
                                    //       size: size.iScreen(2.0),
                                    //     ),
                                    //   );
                                    // },
                           
                                    // ),
                                     Consumer<ThemeProvider>(builder: (_, valueTheme, __) {  
                                        return Container(
                                          alignment: Alignment.center,
                                          color: valueTheme.appTheme.primaryColor,
                                          width: size.iScreen(3.5),
                                          padding: EdgeInsets.only(
                                            top: size.iScreen(0.5),
                                            bottom: size.iScreen(0.5),
                                            left: size.iScreen(0.5),
                                            right: size.iScreen(0.5),
                                          ),
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.white,
                                            size: size.iScreen(2.0),
                                          ),
                                        );
                                      },
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
                           widget.user!.empCategoria!='CONTABLE'
                            ?Container(
                              width: size.wScreen(100.0),

                              // color: Colors.blue,
                              child: Row(
                                children: [
                                  Text('Recomendación:',
                                      style: GoogleFonts.lexendDeca(
                                          // fontSize: size.iScreen(2.0),
                                          fontWeight: FontWeight.normal,
                                          color: Colors.grey)),
                                  Expanded(
                                    child: Container(
                                      width: size.wScreen(100.0),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: size.iScreen(2.0),
                                          vertical: size.iScreen(0)),
                                      alignment: Alignment.center,
                                      child: Consumer<PropietariosController>(
                                        builder: (_, valueRecomendacion, __) {
                                          return DropdownButton<String>(
                                            value: valueRecomendacion
                                                        .getRecomendacion !=
                                                    null
                                                ? valueRecomendacion
                                                    .getRecomendacion
                                                : null,
                                            isExpanded: true,
                                            hint: const Text('Seleccione Tipo'),
                                            items:
                                                _listaRecomendaciones.map((e) {
                                              // valueRecomendacion.getListaRecomendaciones.map((e) {
                                              return DropdownMenuItem<String>(
                                                onTap: () {
                                                  // print('object: ${e['paisId']}');
                                                  // valueRecomendacion
                                                  //     .buscaProvincias(e['paisId']);
                                                },
                                                value: e['recoNombre'],
                                                child: Text(
                                                  e['recoNombre'],
                                                  style: GoogleFonts.lexendDeca(
                                                      fontSize:
                                                          size.iScreen(1.7),
                                                      color: Colors.black87,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                              );
                                            }).toList(),
                                            onChanged: (text) {
                                              valueRecomendacion
                                                  .setRecomendacion(text);
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ):Container(),
                            //***********************************************/
                            SizedBox(
                              height: size.iScreen(0.0),
                            ),
                            //*****************************************/

                            Consumer<PropietariosController>(
                              builder: (_, valueCorreos, __) {
                                return SizedBox(
                                  // color: Colors.red,
                                  width: size.wScreen(100.0),
                                  child: Wrap(
                                    children: valueCorreos.getlistaAddCorreos!
                                        .map(
                                          (e) => Row(
                                            children: [
                                              Expanded(
                                                child: GestureDetector(
                                                  onDoubleTap: () {
                                                    // print(e);
                                                    valueCorreos
                                                        .eliminaCorreo(e);
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors
                                                            .grey.shade300,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0)),
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            vertical: size
                                                                .iScreen(0.5)),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: size
                                                                .iScreen(1.0),
                                                            vertical: size
                                                                .iScreen(0.5)),
                                                    child: Text('$e',
                                                        style: GoogleFonts
                                                            .lexendDeca(
                                                                fontSize: size
                                                                    .iScreen(
                                                                        2.0),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                color: Colors
                                                                    .black)),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                        .toList(),
                                  ),

                                  // Column(
                                  //   children: [
                                  //     Row(
                                  //       children: [
                                  //         Expanded(
                                  //           child: Container(
                                  //             decoration: BoxDecoration(
                                  //                 color: Colors.grey.shade300,
                                  //                 borderRadius:
                                  //                     BorderRadius.circular(5.0)),
                                  //             margin: EdgeInsets.symmetric(
                                  //                 vertical: size.iScreen(0.5)),
                                  //             padding: EdgeInsets.symmetric(
                                  //                 horizontal: size.iScreen(1.0),
                                  //                 vertical: size.iScreen(0.5)),
                                  //             child: Text('correo@corresdf.com',
                                  //                 style: GoogleFonts.lexendDeca(
                                  //                     fontSize: size.iScreen(1.7),
                                  //                     fontWeight: FontWeight.normal,
                                  //                     color: Colors.black)),
                                  //           ),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   ],
                                  // ),
                                );
                              },
                            ),
                            //***********************************************/
                            SizedBox(
                              height: size.iScreen(1.5),
                            ),
                            //*****************************************/
                            SizedBox(
                              width: size.wScreen(100.0),

                              // color: Colors.blue,
                              child: Text('Nacionalidad ',
                                  style: GoogleFonts.lexendDeca(
                                      // fontSize: size.iScreen(2.0),
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey)),
                            ),
                            //***********************************************/
                            // Container(
                            //   width: size.wScreen(100.0),

                            //   // color: Colors.blue,
                            //   child: Row(
                            //     children: [
                            //       Text('Pais:',
                            //           style: GoogleFonts.lexendDeca(
                            //               // fontSize: size.iScreen(2.0),
                            //               fontWeight: FontWeight.normal,
                            //               color: Colors.grey)),
                            //       Expanded(
                            //         child: Container(
                            //           width: size.wScreen(100.0),
                            //           padding: EdgeInsets.symmetric(
                            //               horizontal: size.iScreen(2.0),
                            //               vertical: size.iScreen(0)),
                            //           alignment: Alignment.center,
                            //           child: Consumer<PropietariosController>(
                            //             builder: (_, valuePais, __) {
                            //               return DropdownButton<String>(
                            //                 value: valuePais.getPais,
                            //                 isExpanded: true,
                            //                 hint: widget.action == 'CREATE'
                            //                     ? const Text('Seleccione Pais')
                            //                     : valuePais.getPais != null
                            //                         ? Text(
                            //                             '${valuePais.getPais}')
                            //                         : const Text(
                            //                             'Seleccione Pais'), //valuePais.getPais,
                            //                 // const Text('Seleccione Pais'),
                            //                 items: listaDepaises.map((e) {
                            //                   return DropdownMenuItem<String>(
                            //                     onTap: () {
                            //                       print(
                            //                           'object: ${e['paisId']}');
                            //                       valuePais.buscaProvincias(
                            //                           e['paisId']);
                            //                     },
                            //                     value: e['paisNombre'],
                            //                     child: Text(
                            //                       e['paisNombre'],
                            //                       style: GoogleFonts.lexendDeca(
                            //                           fontSize:
                            //                               size.iScreen(1.7),
                            //                           color: Colors.black87,
                            //                           fontWeight:
                            //                               FontWeight.normal),
                            //                     ),
                            //                   );
                            //                 }).toList(),
                            //                 onChanged: (text) {
                            //                   valuePais.setPais(text);
                            //                 },
                            //               );
                            //             },
                            //           ),
                            //         ),
                            //       )
                            //     ],
                            //   ),
                            // ),
                            // // //***********************************************/
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
                            child: Text('Pais : ',
                                style: GoogleFonts.lexendDeca(
                                    // fontSize: size.iScreen(2.0),
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey)),
                          ),
                           Consumer<PropietariosController>(
                        builder: (_, valuePais, __) {
                          return Container(
                            // color: Colors.red,
                            width: size.wScreen(50.0),
    
                            // color: Colors.blue,
                            child: Text(
                                valuePais.getPais!.isEmpty
                                    ? ' --- --- --- --- ---'
                                    : '  ${valuePais.getPais} ',
                                style: GoogleFonts.lexendDeca(
                                    fontSize: size.iScreen(2.0),
                                    fontWeight: FontWeight.normal,
                                    color: valuePais.getPais!.isEmpty
                                        ? Colors.grey
                                        : Colors.black)),
                          );
                        },
                      ),
                          Spacer(),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: GestureDetector(
                              onTap: () {
                                // context
                                //     .read<MascotasController>()
                                //     .buscaAllMascotas('');
    
                                // // _buscarMascota(context, size);
                                //  await controllerPropietarios.buscaPaises();
                                _modalSeleccionaPaises(context, size);
    
                                // //*******************************************/
                              },
                              child:  Consumer<ThemeProvider>(builder: (_, valueTheme, __) {  
                                        return Container(
                                          alignment: Alignment.center,
                                          color: valueTheme.appTheme.primaryColor,
                                          width: size.iScreen(3.5),
                                          padding: EdgeInsets.only(
                                            top: size.iScreen(0.5),
                                            bottom: size.iScreen(0.5),
                                            left: size.iScreen(0.5),
                                            right: size.iScreen(0.5),
                                          ),
                                          child: Icon(
                                            Icons.keyboard_arrow_down_outlined,
                                            color: Colors.white,
                                            size: size.iScreen(2.0),
                                          ),
                                        );
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
                      //       //***********************************************/
                      // SizedBox(
                      //   height: size.iScreen(1.5),
                      // ),
                      // //*****************************************/
                      Row(
                        children: [
                          SizedBox(
                            // width: size.wScreen(100.0),
    
                            // color: Colors.blue,
                            child: Text('Provincia : ',
                                style: GoogleFonts.lexendDeca(
                                    // fontSize: size.iScreen(2.0),
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey)),
                          ),
                           Consumer<PropietariosController>(
                        builder: (_, valueTipo, __) {
                          return Container(
                            // color: Colors.red,
                            width: size.wScreen(50.0),
    
                            // color: Colors.blue,
                            child: Text(
                                valueTipo.getProvincia.isEmpty
                                    ? ' --- --- --- --- ---'
                                    : '  ${valueTipo.getProvincia} ',
                                style: GoogleFonts.lexendDeca(
                                    fontSize: size.iScreen(2.0),
                                    fontWeight: FontWeight.normal,
                                    color: valueTipo.getProvincia.isEmpty
                                        ? Colors.grey
                                        : Colors.black)),
                          );
                        },
                      ),
                          Spacer(),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: GestureDetector(
                              onTap: () {
                                // context
                                //     .read<MascotasController>()
                                //     .buscaAllMascotas('');
    
                                // // _buscarMascota(context, size);
                                _modalSeleccionaProvincia(context, size);
    
                                // //*******************************************/
                              },
                              child:  Consumer<ThemeProvider>(builder: (_, valueTheme, __) {  
                                        return Container(
                                          alignment: Alignment.center,
                                          color: valueTheme.appTheme.primaryColor,
                                          width: size.iScreen(3.5),
                                          padding: EdgeInsets.only(
                                            top: size.iScreen(0.5),
                                            bottom: size.iScreen(0.5),
                                            left: size.iScreen(0.5),
                                            right: size.iScreen(0.5),
                                          ),
                                          child: Icon(
                                           Icons.keyboard_arrow_down_outlined,
                                            color: Colors.white,
                                            size: size.iScreen(2.0),
                                          ),
                                        );
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
                          SizedBox(
                            // width: size.wScreen(100.0),
    
                            // color: Colors.blue,
                            child: Text('Cantón : ',
                                style: GoogleFonts.lexendDeca(
                                    // fontSize: size.iScreen(2.0),
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey)),
                          ),
                           Consumer<PropietariosController>(
                        builder: (_, valueTipo, __) {
                          return Container(
                            // color: Colors.red,
                            width: size.wScreen(50.0),
    
                            // color: Colors.blue,
                            child: Text(
                                valueTipo.getCanton!.isEmpty
                                    ? ' --- --- --- --- ---'
                                    : '  ${valueTipo.getCanton} ',
                                style: GoogleFonts.lexendDeca(
                                    fontSize: size.iScreen(2.0),
                                    fontWeight: FontWeight.normal,
                                    color: valueTipo.getProvincia.isEmpty
                                        ? Colors.grey
                                        : Colors.black)),
                          );
                        },
                      ),
                          Spacer(),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: GestureDetector(
                              onTap: () {
                                // context
                                //     .read<MascotasController>()
                                //     .buscaAllMascotas('');
    
                                // // _buscarMascota(context, size);
                                _modalSeleccionaCantones(context, size);
    
                                // //*******************************************/
                              },
                              child:  Consumer<ThemeProvider>(builder: (_, valueTheme, __) {  
                                        return Container(
                                          alignment: Alignment.center,
                                          color: valueTheme.appTheme.primaryColor,
                                          width: size.iScreen(3.5),
                                          padding: EdgeInsets.only(
                                            top: size.iScreen(0.5),
                                            bottom: size.iScreen(0.5),
                                            left: size.iScreen(0.5),
                                            right: size.iScreen(0.5),
                                          ),
                                          child: Icon(
                                            Icons.keyboard_arrow_down_outlined,
                                            color: Colors.white,
                                            size: size.iScreen(2.0),
                                          ),
                                        );
                                      },
                                      ),
                            ),
                          ),
                        ],
                      ),
                      
                      //    Spacer(),
                      //      //***********************************************/
                      // SizedBox(
                      //   height: size.iScreen(1.0),
                      // ),
                      // //*****************************************/
                      //       //***********************************************/
                      //       Container(
                      //         width: size.wScreen(100.0),

                      //         // color: Colors.blue,
                      //         child: Row(
                      //           children: [
                      //             Text('Provincia:',
                      //                 style: GoogleFonts.lexendDeca(
                      //                     // fontSize: size.iScreen(2.0),
                      //                     fontWeight: FontWeight.normal,
                      //                     color: Colors.grey)),
                      //             // const DropMenuTipoCliente(
                      //             //   data: [
                      //             //     'FRECUENTE',
                      //             //     'TEMPORAL',
                      //             //     'OCASIONAL',
                      //             //     'ESPECIAL',
                      //             //   ],
                      //             //   hinText: 'Seleccione Provinciaa',
                      //             // ),
                      //             Expanded(
                      //               child: Container(
                      //                 width: size.wScreen(100.0),
                      //                 padding: EdgeInsets.symmetric(
                      //                     horizontal: size.iScreen(2.0),
                      //                     vertical: size.iScreen(0)),
                      //                 alignment: Alignment.center,
                      //                 child: Consumer<PropietariosController>(
                      //                   builder: (_, valueProvincia, __) {
                      //                     return DropdownButton<String>(
                      //                       value: valueProvincia
                      //                                   .getProvincia !=
                      //                               null
                      //                           ? valueProvincia.getProvincia
                      //                           : null,
                      //                       isExpanded: true,
                      //                       hint: widget.action == 'CREATE'
                      //                           ? const Text(
                      //                               'Seleccione Provincia')
                      //                           : valueProvincia.getProvincia !=
                      //                                   null
                      //                               ? Text(
                      //                                   '${valueProvincia.getProvincia}')
                      //                               : const Text(
                      //                                   'Seleccione Provincia'),

                      //                       //  const Text(
                      //                       //     'Seleccione Provincia'),
                      //                       items:
                      //                           // _listaDepaises.map((e) {
                      //                           valueProvincia
                      //                               .getListaTodasLasProvincias
                      //                               .map((e) {
                      //                         return DropdownMenuItem<String>(
                      //                           onTap: () {
                      //                             print(
                      //                                 'object: ${e['provId']}');
                      //                             valueProvincia.buscaCantones(
                      //                                 e['provId']);
                      //                           },
                      //                           value: e['provNombre'],
                      //                           child: Text(
                      //                             e['provNombre'],
                      //                             style: GoogleFonts.lexendDeca(
                      //                                 fontSize:
                      //                                     size.iScreen(1.7),
                      //                                 color: Colors.black87,
                      //                                 fontWeight:
                      //                                     FontWeight.normal),
                      //                           ),
                      //                         );
                      //                       }).toList(),
                      //                       onChanged: (text) {
                      //                         valueProvincia.setProvincia(text);
                      //                       },
                      //                     );
                      //                   },
                      //                 ),
                      //               ),
                      //             )
                      //           ],
                      //         ),
                      //       ),
                            //***********************************************/
                            //***********************************************/
                            // Container(
                            //   width: size.wScreen(100.0),

                            //   // color: Colors.blue,
                            //   child: Row(
                            //     children: [
                            //       Text('Cantón:',
                            //           style: GoogleFonts.lexendDeca(
                            //               // fontSize: size.iScreen(2.0),
                            //               fontWeight: FontWeight.normal,
                            //               color: Colors.grey)),
                            //       // const DropMenuTipoCliente(
                            //       //   data: [
                            //       //     'FRECUENTE',
                            //       //     'TEMPORAL',
                            //       //     'OCASIONAL',
                            //       //     'ESPECIAL',
                            //       //   ],
                            //       //   hinText: 'Seleccione Cantón',
                            //       // ),
                            //       Expanded(
                            //         child: Container(
                            //           width: size.wScreen(100.0),
                            //           padding: EdgeInsets.symmetric(
                            //               horizontal: size.iScreen(2.0),
                            //               vertical: size.iScreen(0)),
                            //           alignment: Alignment.center,
                            //           child: Consumer<PropietariosController>(
                            //             builder: (_, valueCanton, __) {
                            //               return DropdownButton<String>(
                            //                 value: valueCanton.getCanton != null
                            //                     ? valueCanton.getCanton
                            //                     : null,
                            //                 isExpanded: true,
                            //                 // hint:
                            //                 hint: widget.action == 'CREATE'
                            //                     ? const Text(
                            //                         'Seleccione Cantón')
                            //                     : valueCanton.getCanton != null
                            //                         ? Text(
                            //                             '${valueCanton.getCanton}')
                            //                         : const Text(
                            //                             'Seleccione Cantón'),
                            //                 // const Text('Seleccione Cantón'),
                            //                 items:
                            //                     // _listaDepaises.map((e) {
                            //                     valueCanton
                            //                         .getListaTodosLosCantones
                            //                         .map((e) {
                            //                   return DropdownMenuItem<String>(
                            //                     onTap: () {
                            //                       print(
                            //                           'object: ${e['canId']}');
                            //                       // valueCanton
                            //                       // .buscaCantons(e['paisId']);
                            //                     },
                            //                     value: e['canNombre'],
                            //                     child: Text(
                            //                       e['canNombre'],
                            //                       style: GoogleFonts.lexendDeca(
                            //                           fontSize:
                            //                               size.iScreen(1.7),
                            //                           color: Colors.black87,
                            //                           fontWeight:
                            //                               FontWeight.normal),
                            //                     ),
                            //                   );
                            //                 }).toList(),
                            //                 onChanged: (text) {
                            //                   valueCanton.setCanton(text);
                            //                 },
                            //               );
                            //             },
                            //           ),
                            //         ),
                            //       )
                            //     ],
                            //   ),
                            // ),
                            //***********************************************/
                            SizedBox(
                              height: size.iScreen(2.0),
                            ),
                            //*****************************************/

                            SizedBox(
                              width: size.wScreen(100.0),

                              // color: Colors.blue,
                              child: Text('Observación',
                                  style: GoogleFonts.lexendDeca(
                                      // fontSize: size.iScreen(2.0),
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey)),
                            ),
                            Container(
                              // width: size.wScreen(45.0),
                              child: TextFormField(
                                // initialValue: widget.action == 'CREATE'
                                //     ? ''
                                //     : controller.getObservacion,
                                controller: _textObservacion,
                                decoration: const InputDecoration(
                                    // suffixIcon: Icon(Icons.beenhere_outlined)
                                    ),
                                // textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: size.iScreen(2.0),
                                  // fontWeight: FontWeight.bold,
                                  // letterSpacing: 2.0,
                                ),
                                onChanged: (text) {
                                  controller.setObservacion(text);
                                },
                                // validator: (text) {
                                //   if (text!.trim().isNotEmpty) {
                                //     return null;
                                //   } else {
                                //     return 'Ingrese Observación';
                                //   }
                                // },
                              ),
                            ),

                            //***********************************************/
                            //***********************************************/
                            SizedBox(
                              height: size.iScreen(1.0),
                            ),
                            //*****************************************/

                            //***********************************************/
                            SizedBox(
                              height: size.iScreen(1.5),
                            ),
                            //*****************************************/
                          ],
                        ),
                      ),
                    )
                  ,
          ),
        ));
  }

  Future<bool?> _agregaPlaca(BuildContext context,
      PropietariosController controller, Responsive size) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
            title: Container(child: const Text("AGREGAR PLACA")),
            content: Card(
              color: Colors.transparent,
              elevation: 0.0,
              child: Form(
                key: controller.placaFormKey,
                child: 
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: size.iScreen(50.0),
                      child: 
                      Container(
                        // width: size.wScreen(45.0),
                        child: TextFormField(
                         textAlign: TextAlign.center,
                          autofocus: true,
                          controller: _textAddPlaca,
                          decoration: const InputDecoration(
                         

                             
                              ),
                              style:TextStyle(
                                fontSize:size.iScreen(3.5),
                                color:Colors.black
                              ),
                              
//  initialCountryCode: 'EC',

                          // keyboardType: TextInputType.none,
                          inputFormatters: <TextInputFormatter>[
                            UpperCaseText(),
                          ],
                          onChanged: (text) {
                           
                            controller.seItemAddPlaca(text);
                          },
                          
                        ),
                      ),
                    ),
                   TextButton(
                        onPressed: () {
                          final isValidS = controller.validateFormPlaca();
                          if (!isValidS) return;
                          if (isValidS) {
                            _textAddPlaca.text = '';
                            controller.agregaListaPlacas();
                            Navigator.pop(context);
                          }
                          //  print(countries.firstWhere((element) => element['code'] == phone.countryISOCode)['max_length']);
                        },
                        child: 
                        // Consumer<ThemeProvider>(builder: (_, valueTheme, __) {  
                        //                 return Container(
                        //                   alignment: Alignment.center,
                        //                   color: valueTheme.appTheme.primaryColor,
                        //                   width: size.iScreen(3.5),
                        //                   padding: EdgeInsets.only(
                        //                     top: size.iScreen(0.5),
                        //                     bottom: size.iScreen(0.5),
                        //                     left: size.iScreen(0.5),
                        //                     right: size.iScreen(0.5),
                        //                   ),
                        //                   child: Icon(
                        //                     Icons.add,
                        //                     color: Colors.white,
                        //                     size: size.iScreen(2.0),
                        //                   ),
                        //                 );
                        //               },
                        //               ),
                     Consumer<ThemeProvider>(builder: (_, valueTheme, __) {  
                          return    Container(
                          decoration: BoxDecoration(
                              color: valueTheme.appTheme.primaryColor,
                              borderRadius: BorderRadius.circular(5.0)),
                          // color: primaryColor,
                          padding: EdgeInsets.symmetric(
                              vertical: size.iScreen(0.5),
                              horizontal: size.iScreen(0.5)),
                          child: Text('Agregar',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white)),
                        );

                       },)
                        
                        
                     
                    )
                  ],
                ),
              ),
            )

            //  },)

            );
      },
    );
  }

  Future<bool?> _agregaCelular(BuildContext context,
      PropietariosController controller, Responsive size) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
            title: Container(child: const Text("AGREGAR CELULAR")),
            content: Card(
              color: Colors.transparent,
              elevation: 0.0,
              child: Form(
                key: controller.celularFormKey,
                child: 
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: size.iScreen(100.0),
                      child: 
                      Container(
                        // width: size.wScreen(45.0),
                        child: IntlPhoneField(
                          autofocus: true,
                          controller: controllerTextCountry,
                          decoration: const InputDecoration(
                         

                             
                              ),
                              style:TextStyle(
                                color:Colors.black
                              ),
                              
//  initialCountryCode: 'EC',

                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          onChanged: (phone) {
                            // print(phone.completeNumber);
                            controller.seItemAddCelulars(phone.completeNumber);
                          },
                          onCountryChanged: (country) {
                            controller.seItemCodeCelular(country.dialCode);
                          },
                        ),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          controller.seItemAddCelulars(
                              controller.getItemAddCelular!.replaceAll(
                                  '+593', controller.getItemCodeCelular!));

                          final isValidS = controller.validateFormCelular();
                          if (!isValidS) return;
                          if (isValidS) {
                            controllerTextCountry.text = '';
                            controller.agregaListaCelulares();
                            Navigator.pop(context);
                          }
                          //  print(countries.firstWhere((element) => element['code'] == phone.countryISOCode)['max_length']);
                        },


                        child:Consumer<ThemeProvider>(builder: (_, valueTheme, __) { 
                          return    Container(
                          decoration: BoxDecoration(
                             color: valueTheme.appTheme.primaryColor,
                              borderRadius: BorderRadius.circular(5.0)),
                          // color: primaryColor,
                          padding: EdgeInsets.symmetric(
                              vertical: size.iScreen(0.5),
                              horizontal: size.iScreen(0.5)),
                          child: Text('Agregar',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white)),
                        );

                       },)
                        )
                  ],
                ),
              ),
            )

            //  },)

            );
      },
    );
  }

  Future<bool?> _agregaCorreo(BuildContext context,
      PropietariosController controller, Responsive size) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
            title: Container(child: const Text("AGREGAR CORREO")),
            content: Card(
              color: Colors.transparent,
              elevation: 0.0,
              child: Form(
                key: controller.correoFormKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: size.iScreen(100.0),
                      child: Container(
                        // width: size.wScreen(45.0),
                        child:
                            // IntlPhoneField(
                            //   controller: controllerTextCountry,
                            //   decoration: const InputDecoration(

                            //       // labelText: 'Phone Number',
                            //       // border: OutlineInputBorder(
                            //       //   // borderSide: BorderSide(),
                            //       // ),
                            //       ),
                            //   onChanged: (phone) {
                            //     print(phone.completeNumber);
                            //     controller.seItemAddCelulars(phone.completeNumber);
                            //   },
                            //   onCountryChanged: (country) {
                            //     controller.seItemCodeCelular(country.dialCode);
                            //   },
                            // ),
                            //===============================================//
                            SizedBox(
                          width: size.iScreen(40.0),
                          child: TextFormField(
                            controller: _textAddCorreo,

                            keyboardType: TextInputType.emailAddress,
                            textCapitalization: TextCapitalization.none,

                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              final validador = validateEmail(value);
                              if (validador == null) {
                                controller.setIsCorreo(true);
                              }
                              return validateEmail(value);
                            },
                            decoration: const InputDecoration(
                                hintText: '  Ingrese un Correo'
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
                              controller.seItemAddCorreos(text);
                              // final _estado=
                              // valueCantidad.validaStock(text);
                              // if(_estado==true){
                              // print('@VERDADERO@ $_estado');

                              // }else{
                              // print('@FALSE@ $_estado');

                              // }
                            },
                            // validator: (text) {
                            //   if (text!.trim().isNotEmpty) {
                            //     return null;
                            //   } else {
                            //     return 'Cantidad inválida';
                            //   }
                            // },
                          ),
                        ),
                        //===============================================//
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          final isValidS = controller.validateFormCorreo();
                          if (!isValidS) return;
                          if (isValidS) {
                            _textAddCorreo.text = '';
                            controller.agregaListaCorreos();
                            Navigator.pop(context);
                          }
                          //  print(countries.firstWhere((element) => element['code'] == phone.countryISOCode)['max_length']);
                        },
                        child: 
                    Consumer<ThemeProvider>(builder: (_, valueTheme, __) { 
                          return    Container(
                          decoration: BoxDecoration(
                              color: valueTheme.appTheme.primaryColor,
                              borderRadius: BorderRadius.circular(5.0)),
                          // color: primaryColor,
                          padding: EdgeInsets.symmetric(
                              vertical: size.iScreen(0.5),
                              horizontal: size.iScreen(0.5)),
                          child: Text('Agregar',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white)),
                        );

                       },)
                        
                        
                     
                    )
                  ],
                ),
              ),
            )

            //  },)

            );
      },
    );
  }

  //********************************************************************************************************************//
  void _onSubmit(BuildContext context, PropietariosController controller,
      String? action) async {
    final isValid = controller.validateFormPropietario();
    if (!isValid) return;
    if (isValid) {
      if (controller.labelTipoDocumento == null) {
        NotificatiosnService.showSnackBarDanger(
            'Debe seleccionar Tipo de Documento');
      }
       else if ( widget.user!.empCategoria!='CONTABLE') {
            if (  controller.getRecomendacion == null) {
               NotificatiosnService.showSnackBarDanger(
            'Debe seleccionar Recomendación');
            }
       
      }
       else if ( widget.user!.empCategoria!='CONTABLE') {
            if (  controller.getGeneros == null) {
               NotificatiosnService.showSnackBarDanger(
            'Debe seleccionar Género');
            }
       
      }
       else if (controller.getIsCedula == false) {
        NotificatiosnService.showSnackBarDanger('Debe validar Celulare');
      } else if (controller.getlistaAddCorreos!.isEmpty) {
        NotificatiosnService.showSnackBarDanger('Debe agregar Correo');
      } else if (controller.getPais == null) {
        NotificatiosnService.showSnackBarDanger('Debe selecionar Pais');
      } else if (controller.getPais == 'ECUADOR' &&
          controller.getProvincia == null) {
        NotificatiosnService.showSnackBarDanger('Debe selecionar Provincia');
      } else {
        if (widget.action == 'CREATE' || widget.action == 'SEARCH') {
          await controller.crearPropietario(context);
        } else if (widget.action == 'EDIT') {
          await controller.editaPropietario(context);
        }

        Navigator.pop(context);
      }
    }
  }





//*************MODAL PAISES*************//

  void _modalSeleccionaPaises(BuildContext context, Responsive size) {
   
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return 
          Consumer<PropietariosController>(builder: (_, ctrl, __) {  
              return   GestureDetector(
            // onTap: () => FocusScope.of(context).unfocus(),
            child: AlertDialog(
              insetPadding: EdgeInsets.symmetric(
                  horizontal: size.wScreen(5.0), vertical: size.wScreen(3.0)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('SELECCIONAR PAIS',
                          style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.bold,
                            // color: Colors.white,
                          )),
                      IconButton(
                          splashRadius: size.iScreen(3.0),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.close,
                            color: Colors.red,
                            size: size.iScreen(3.5),
                          )),
                    ],
                  ),
                  SizedBox(
                    width: size.wScreen(100),
                    height: size.hScreen(26),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: listaDepaises.length,
                      itemBuilder: (BuildContext context, int index) {

                        final pais=listaDepaises[index];
                        return GestureDetector(
                          onTap: () {
                        
                           ctrl.setPais(pais['paisNombre']);
                            ctrl.buscaProvincias( pais['paisId']);
                            ctrl.setProvincia('');
                            ctrl.setCanton('');
                           
                            //  ctrl.buscaProvincias( pais['provId']);
                            Navigator.pop(context);
                          },
                          child: Container(
                            color: Colors.grey[100],
                            margin: EdgeInsets.symmetric(
                                vertical: size.iScreen(0.3)),
                            padding: EdgeInsets.symmetric(
                                horizontal: size.iScreen(1.0),
                                vertical: size.iScreen(1.0)),
                            child:  Container(
                                      // color: Colors.red,
                                      width: size.wScreen(50.0),
                                      child: Text(
                                        '${pais['paisNombre']}',
                                        // 'ASDAS',
                                        style: GoogleFonts.lexendDeca(
                                          fontSize: size.iScreen(1.8),
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ),
                            // Column(
                            //   mainAxisSize: MainAxisSize.min,
                            //   children: [
                            //     Row(
                            //       children: [
                            //         Text(
                            //           'Ubicación: ',
                            //           style: GoogleFonts.lexendDeca(
                            //             fontSize: size.iScreen(1.8),
                            //             fontWeight: FontWeight.normal,
                            //             color: Colors.black54,
                            //           ),
                            //         ),
                            //         Container(
                            //           // color: Colors.red,
                            //           width: size.wScreen(50.0),
                            //           child: Text(
                            //             '${_data[index]['ubicacion']} ',
                            //             style: GoogleFonts.lexendDeca(
                            //               fontSize: size.iScreen(1.8),
                            //               fontWeight: FontWeight.bold,
                            //               color: Colors.black54,
                            //             ),
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //     Row(
                            //       children: [
                            //         Text(
                            //           'Puesto: ',
                            //           style: GoogleFonts.lexendDeca(
                            //             fontSize: size.iScreen(1.8),
                            //             fontWeight: FontWeight.normal,
                            //             color: Colors.black54,
                            //           ),
                            //         ),
                            //         Container(
                                      
                            //            width: size.wScreen(50.0),
                            //           child: Text(
                            //             '${_data[index]['puesto']} ',
                            //             style: GoogleFonts.lexendDeca(
                            //               fontSize: size.iScreen(1.8),
                            //               fontWeight: FontWeight.bold,
                            //               color: Colors.black54,
                            //             ),
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                              
                            //   ],
                            // ),
                         
                         
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
       


          },);
          
         
       
       
        });
  }


//*************MODAL PROVINCIA*************//

  void _modalSeleccionaProvincia(BuildContext context, Responsive size) {
    // final _data = [
    //   'RENUNCIA',
    //   'RENUNCIA ART 190 CT',
    // ];
    final ctrl=context.read<PropietariosController>();
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: AlertDialog(
              insetPadding: EdgeInsets.symmetric(
                  horizontal: size.wScreen(5.0), vertical: size.wScreen(3.0)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('SELECCIONAR PROVINCIA',
                          style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.bold,
                            // color: Colors.white,
                          )),
                      IconButton(
                          splashRadius: size.iScreen(3.0),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.close,
                            color: Colors.red,
                            size: size.iScreen(3.5),
                          )),
                    ],
                  ),
                  SizedBox(
                    width: size.wScreen(100),
                    height: size.hScreen(26),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: ctrl.getListaTodasLasProvincias.length,
                      itemBuilder: (BuildContext context, int index) {

                        final provincia=ctrl.getListaTodasLasProvincias[index];
                        return GestureDetector(
                          onTap: () {
                            // _controller.setNombreUbicacion(_data[index]['ubicacion']);
                            // _controller.setNombrePuesto(_data[index]['puesto']);
                            ctrl.setProvincia(provincia['provNombre']);
                             ctrl.buscaCantones( provincia['provId']);
                              ctrl.setCanton('');
                            Navigator.pop(context);
                          },
                          child: Container(
                            color: Colors.grey[100],
                            margin: EdgeInsets.symmetric(
                                vertical: size.iScreen(0.3)),
                            padding: EdgeInsets.symmetric(
                                horizontal: size.iScreen(1.0),
                                vertical: size.iScreen(1.0)),
                            child:  Container(
                                      // color: Colors.red,
                                      width: size.wScreen(50.0),
                                      child: Text(
                                        '${provincia['provNombre']} ',
                                        style: GoogleFonts.lexendDeca(
                                          fontSize: size.iScreen(1.8),
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ),
                            // Column(
                            //   mainAxisSize: MainAxisSize.min,
                            //   children: [
                            //     Row(
                            //       children: [
                            //         Text(
                            //           'Ubicación: ',
                            //           style: GoogleFonts.lexendDeca(
                            //             fontSize: size.iScreen(1.8),
                            //             fontWeight: FontWeight.normal,
                            //             color: Colors.black54,
                            //           ),
                            //         ),
                            //         Container(
                            //           // color: Colors.red,
                            //           width: size.wScreen(50.0),
                            //           child: Text(
                            //             '${_data[index]['ubicacion']} ',
                            //             style: GoogleFonts.lexendDeca(
                            //               fontSize: size.iScreen(1.8),
                            //               fontWeight: FontWeight.bold,
                            //               color: Colors.black54,
                            //             ),
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //     Row(
                            //       children: [
                            //         Text(
                            //           'Puesto: ',
                            //           style: GoogleFonts.lexendDeca(
                            //             fontSize: size.iScreen(1.8),
                            //             fontWeight: FontWeight.normal,
                            //             color: Colors.black54,
                            //           ),
                            //         ),
                            //         Container(
                                      
                            //            width: size.wScreen(50.0),
                            //           child: Text(
                            //             '${_data[index]['puesto']} ',
                            //             style: GoogleFonts.lexendDeca(
                            //               fontSize: size.iScreen(1.8),
                            //               fontWeight: FontWeight.bold,
                            //               color: Colors.black54,
                            //             ),
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                              
                            //   ],
                            // ),
                         
                         
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }


//*************MODAL CANTONES*************//

  void _modalSeleccionaCantones(BuildContext context, Responsive size) {
  
    final ctrl=context.read<PropietariosController>();
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: AlertDialog(
              insetPadding: EdgeInsets.symmetric(
                  horizontal: size.wScreen(5.0), vertical: size.wScreen(3.0)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('SELECCIONAR CANTÓN',
                          style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.bold,
                            // color: Colors.white,
                          )),
                      IconButton(
                          splashRadius: size.iScreen(3.0),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.close,
                            color: Colors.red,
                            size: size.iScreen(3.5),
                          )),
                    ],
                  ),
                  SizedBox(
                    width: size.wScreen(100),
                    height: size.hScreen(26),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: ctrl.getListaTodosLosCantones.length,
                      itemBuilder: (BuildContext context, int index) {

                        final canton=ctrl.getListaTodosLosCantones[index];
                        return GestureDetector(
                          onTap: () {
                            // _controller.setNombreUbicacion(_data[index]['ubicacion']);
                            // _controller.setNombrePuesto(_data[index]['puesto']);
                            ctrl.setCanton(canton['canNombre']);
                             
                            Navigator.pop(context);
                          },
                          child: Container(
                            color: Colors.grey[100],
                            margin: EdgeInsets.symmetric(
                                vertical: size.iScreen(0.3)),
                            padding: EdgeInsets.symmetric(
                                horizontal: size.iScreen(1.0),
                                vertical: size.iScreen(1.0)),
                            child:  Container(
                                      // color: Colors.red,
                                      width: size.wScreen(50.0),
                                      child: Text(
                                        '${canton['canNombre']} ',
                                        style: GoogleFonts.lexendDeca(
                                          fontSize: size.iScreen(1.8),
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ),
                            // Column(
                            //   mainAxisSize: MainAxisSize.min,
                            //   children: [
                            //     Row(
                            //       children: [
                            //         Text(
                            //           'Ubicación: ',
                            //           style: GoogleFonts.lexendDeca(
                            //             fontSize: size.iScreen(1.8),
                            //             fontWeight: FontWeight.normal,
                            //             color: Colors.black54,
                            //           ),
                            //         ),
                            //         Container(
                            //           // color: Colors.red,
                            //           width: size.wScreen(50.0),
                            //           child: Text(
                            //             '${_data[index]['ubicacion']} ',
                            //             style: GoogleFonts.lexendDeca(
                            //               fontSize: size.iScreen(1.8),
                            //               fontWeight: FontWeight.bold,
                            //               color: Colors.black54,
                            //             ),
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //     Row(
                            //       children: [
                            //         Text(
                            //           'Puesto: ',
                            //           style: GoogleFonts.lexendDeca(
                            //             fontSize: size.iScreen(1.8),
                            //             fontWeight: FontWeight.normal,
                            //             color: Colors.black54,
                            //           ),
                            //         ),
                            //         Container(
                                      
                            //            width: size.wScreen(50.0),
                            //           child: Text(
                            //             '${_data[index]['puesto']} ',
                            //             style: GoogleFonts.lexendDeca(
                            //               fontSize: size.iScreen(1.8),
                            //               fontWeight: FontWeight.bold,
                            //               color: Colors.black54,
                            //             ),
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                              
                            //   ],
                            // ),
                         
                         
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }







}

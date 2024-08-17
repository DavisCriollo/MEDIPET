import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neitorcont/src/controllers/mascotas_controller.dart';

import 'package:neitorcont/src/controllers/recetas_controller.dart';
import 'package:neitorcont/src/controllers/vacunas_controller.dart';
import 'package:neitorcont/src/services/notifications_service.dart';
import 'package:neitorcont/src/services/socket_service.dart';
import 'package:neitorcont/src/theme/themes_app.dart';
import 'package:neitorcont/src/utils/letras_mayusculas_minusculas.dart';

import 'package:neitorcont/src/utils/responsive.dart';
import 'package:neitorcont/src/utils/theme.dart';
import 'package:neitorcont/src/widgets/no_data.dart';
import 'package:provider/provider.dart';

class CrearVacunas extends StatefulWidget {
    final String? tipo;
  const CrearVacunas({Key? key, this.tipo}) : super(key: key);

  @override
  State<CrearVacunas> createState() => _CrearVacunasState();
}

class _CrearVacunasState extends State<CrearVacunas> {
  late TimeOfDay timeFecha;

  @override
  Widget build(BuildContext context) {
    // final widget.tipo = ModalRoute.of(context)!.settings.arguments;
    final Responsive size = Responsive.of(context);
    final controllerReceta = context.read<VacunasController>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: widget.tipo == 'CREATE' || widget.tipo == 'SEARCH'
              ?  Text('Crear Vacuna')
              :  Text('Editar Vacuna'),
          actions: [
            Consumer<SocketService>(builder: (_, valueConexion, __) {
              return valueConexion.serverStatus == ServerStatus.Online
                  ? Container(
                      margin: EdgeInsets.only(right: size.iScreen(1.5)),
                      child: IconButton(
                          splashRadius: 28,
                          onPressed: () {
                            _onSubmit(
                                context, controllerReceta);
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
            //         _onSubmit(context, controllerReceta,widget.tipo.toString());
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
                        key: controllerReceta.vacunasFormKey,
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
                                  child: Text('Mascota ',
                                      style: GoogleFonts.lexendDeca(
                                          // fontSize: size.iScreen(2.0),
                                          fontWeight: FontWeight.normal,
                                          color: Colors.grey)),
                                ),
                                SizedBox(
                                  width: size.iScreen(2.0),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: GestureDetector(
                                    onTap: () {
                                      context
                                          .read<MascotasController>()
                                          .buscaAllMascotas('');

                                      // _buscarMascota(context, size);
                                      _buscarMascota(context, size);

                                      //*******************************************/
                                    },
                                    child:   Consumer<AppTheme>(builder: (_, valueTheme, __) {  
                                      return Container(
                                        alignment: Alignment.center,
                                        color: valueTheme.getPrimaryTextColor,
                                        width: size.iScreen(3.5),
                                        padding: EdgeInsets.only(
                                          top: size.iScreen(0.5),
                                          bottom: size.iScreen(0.5),
                                          left: size.iScreen(0.5),
                                          right: size.iScreen(0.5),
                                        ),
                                        child: Icon(
                                          Icons.add,
                                          color: valueTheme.getSecondryTextColor,
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
                            Consumer<VacunasController>(
                              builder: (_, valueMascota, __) {
                                return SizedBox(
                                  width: size.wScreen(100.0),

                                  // color: Colors.blue,
                                  child: Text(
                                      valueMascota.getNombreMascota!.isEmpty
                                          ? 'DEBE AGREGAR MASCOTA '
                                          : '${valueMascota.getNombreMascota}',
                                      style: GoogleFonts.lexendDeca(
                                          // fontSize: size.iScreen(2.0),
                                          fontWeight: FontWeight.normal,
                                          color: valueMascota
                                                  .getNombreMascota!.isEmpty
                                              ? Colors.grey
                                              : Colors.black)),
                                );
                              },
                            ),
                            //***********************************************/
                            // SizedBox(
                            //   height: size.iScreen(1.0),
                            // ),
                            // //*****************************************/

                            Row(
                              children: [
                                Container(
                                  // width: size.wScreen(20.0),

                                  // color: Colors.blue,
                                  child: Text('Peso kg :',
                                      style: GoogleFonts.lexendDeca(
                                          // fontSize: size.iScreen(2.0),
                                          fontWeight: FontWeight.normal,
                                          color: Colors.grey)),
                                ),
                                //***********************************************/
                                SizedBox(
                                  width: size.iScreen(2.0),
                                ),
                                //*****************************************/
                                Container(
                                  width: size.wScreen(30.0),
                                  child: TextFormField(
                                    initialValue: widget.tipo == 'CREATE'
                                        ? ''
                                        : controllerReceta.getPesoMascota,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9.]')),
                                    ],
                                    decoration: const InputDecoration(
                                        // suffixIcon: Icon(Icons.beenhere_outlined)
                                        ),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: size.iScreen(2.0),
                                      // fontWeight: FontWeight.bold,
                                      // letterSpacing: 2.0,
                                    ),
                                    onChanged: (text) {
                                      controllerReceta.setPesoMascota(text);
                                    },
                                    validator: (text) {
                                      if (text!.trim().isNotEmpty) {
                                        return null;
                                      } else {
                                        return 'Ingrese peso ';
                                      }
                                    },
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
                                  child: Text('Tipo Producto',
                                      style: GoogleFonts.lexendDeca(
                                          // fontSize: size.iScreen(2.0),
                                          fontWeight: FontWeight.normal,
                                          color: Colors.grey)),
                                ),
                                SizedBox(
                                  width: size.iScreen(2.0),
                                ),
                                //*****************************************/
                                Consumer<VacunasController>(
                                  builder: (_, valueTipoProd, __) {
                                    return SizedBox(
                                      // width: size.wScreen(100.0),

                                      // color: Colors.blue,
                                      child: GestureDetector(
                                        onTap: () async {
                                          //                                   // await controller.buscaEspecies();
                                          _modalTipoProductos(
                                              context, size, valueTipoProd);

                                          // //*******************************************/
                                        },
                                        child: Text(
                                            valueTipoProd.labelTipoProducto ==
                                                    ''
                                                ? ' Seleccione tipo  de Producto'
                                                : '${valueTipoProd.labelTipoProducto}',
                                            style: GoogleFonts.lexendDeca(
                                                // fontSize: size.iScreen(2.0),
                                                fontWeight: FontWeight.normal,
                                                color: valueTipoProd
                                                            .labelTipoProducto ==
                                                        ''
                                                    ? Colors.grey
                                                    : Colors.black)),
                                      ),
                                    );
                                  },
                                ),

                       
                              ],
                            ),
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
                                  Text('Producto: ',
                                      style: GoogleFonts.lexendDeca(
                                          // fontSize: size.iScreen(2.0),
                                          fontWeight: FontWeight.normal,
                                          color: Colors.grey)),
                                  //*****************************************/
                                  Consumer<VacunasController>(
                                    builder: (_, valueProducto, __) {
                                      return SizedBox(
                                        // width: size.wScreen(100.0),

                                        // color: Colors.blue,
                                        child:  valueProducto.labelTipoProducto != ''?
                                        
                                        
                                        GestureDetector(
                                          onTap: () {
                                            _modalAllProductos(
                                              context,
                                              size,
                                            );
                                          },
                                          child: Text(
                                              valueProducto.labelProducto == ''
                                                  ? '  Seleccionado Producto '
                                                  : ' ${valueProducto.labelProducto}',
                                              style: GoogleFonts.lexendDeca(
                                                  // fontSize: size.iScreen(2.0),
                                                  fontWeight: FontWeight.normal,
                                                  color:
                                                      valueProducto.labelProducto == ''
                                                          ? Colors.grey
                                                          : Colors.black)),
                                        ):Text( '   ------ ----- ----- ',
                                                  
                                              style: GoogleFonts.lexendDeca(
                                                  // fontSize: size.iScreen(2.0),
                                                  fontWeight: FontWeight.normal,
                                                  color:Colors.grey)
                                                          ),
                                      );
                                    },
                                  ),

                                  //***********************************************/
                                ],
                              ),
                            ),

                            Row(
                              children: [
                                Container(
                                  // width: size.wScreen(20.0),

                                  // color: Colors.blue,
                                  child: Text('Fecha de Caducidad:',
                                      style: GoogleFonts.lexendDeca(
                                          // fontSize: size.iScreen(2.0),
                                          fontWeight: FontWeight.normal,
                                          color: Colors.grey)),
                                ),
                                //***********************************************/
                                SizedBox(
                                  width: size.iScreen(2.0),
                                ),
                                //*****************************************/
                                Container(
                                  width: size.wScreen(50.0),
                                  child: TextFormField(
                                    initialValue: widget.tipo == 'CREATE'
                                        ? ''
                                        : controllerReceta.getFechaCaducudad,
                                    // keyboardType: TextInputType.number,
                                    // inputFormatters: <TextInputFormatter>[
                                    //   FilteringTextInputFormatter.allow(
                                    //       RegExp(r'[0-9.]')),
                                    // ],
                                    decoration: const InputDecoration(
                                        // suffixIcon: Icon(Icons.beenhere_outlined)
                                        ),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: size.iScreen(2.0),
                                      // fontWeight: FontWeight.bold,
                                      // letterSpacing: 2.0,
                                    ),
                                    onChanged: (text) {
                                      controllerReceta.setFechaCaducudad(text);
                                    },
                                    // validator: (text) {
                                    //   if (text!.trim().isNotEmpty) {
                                    //     return null;
                                    //   } else {
                                    //     return 'Ingrese fecha de Caducidad';
                                    //   }
                                    // },
                                  ),
                                ),
                              ],
                            ),
                            //***********************************************//
                            SizedBox(
                              height: size.iScreen(2.0),
                            ),
                            //***********************************************//

                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: size.iScreen(1.0),
                                  horizontal: size.iScreen(1.0)),
                              width: size.wScreen(100.0),
                              color: Colors.grey[200],
                              child: Row(
                                children: [
                                  SizedBox(
                                    // color: Colors.blue,
                                    child: Text('Veterinario Interno ',
                                        style: GoogleFonts.lexendDeca(
                                            // fontSize: size.iScreen(2.0),
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey)),
                                  ),
                                  SizedBox(
                                    width: size.iScreen(2.0),
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: GestureDetector(
                                      onTap: () {
                                        context
                                            .read<RecetasController>()
                                            .buscaAllDoctores('');

                                        _buscarMedico(context, size);

                                        //*******************************************/
                                      },
                                      child:  Consumer<AppTheme>(builder: (_, valueTheme, __) {  
                                      return Container(
                                        alignment: Alignment.center,
                                        color: valueTheme.getPrimaryTextColor,
                                        width: size.iScreen(3.5),
                                        padding: EdgeInsets.only(
                                          top: size.iScreen(0.5),
                                          bottom: size.iScreen(0.5),
                                          left: size.iScreen(0.5),
                                          right: size.iScreen(0.5),
                                        ),
                                        child: Icon(
                                          Icons.add,
                                          color: valueTheme.getSecondryTextColor,
                                          size: size.iScreen(2.0),
                                        ),
                                      );
                                    },
                                    ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //*****************************************/
                            SizedBox(
                              height: size.iScreen(1.0),
                            ),
                            //*****************************************/
                            Consumer<VacunasController>(
                              builder: (_, valueDoctor, __) {
                                return SizedBox(
                                  width: size.wScreen(100.0),

                                  // color: Colors.blue,
                                  child: Text(
                                      valueDoctor.getVetDoctorNombre!.isEmpty
                                          ? 'DEBE SELECCIONAR VERETINARIO '
                                          : '${valueDoctor.getVetDoctorNombre} ',
                                      style: GoogleFonts.lexendDeca(
                                          // fontSize: size.iScreen(2.0),
                                          fontWeight: FontWeight.normal,
                                          color: valueDoctor
                                                  .getVetDoctorNombre!.isEmpty
                                              ? Colors.grey
                                              : Colors.black)),
                                );
                              },
                            ),

                            //*****************************************/
                            SizedBox(
                              height: size.iScreen(2.0),
                            ),
                            //*****************************************/

                            Consumer<VacunasController>(
                              builder: (_, valuFechas, __) {
                                return Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Fecha Colocación : ',
                                          style: GoogleFonts.lexendDeca(
                                            // fontSize: size.iScreen(1.8),
                                            color: Colors.black45,
                                            // fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          width: size.iScreen(1.0),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            FocusScope.of(context)
                                                .requestFocus(FocusNode());
                                            _fechaColocacion(
                                                context, valuFechas);
                                          },
                                          child: Row(
                                            children: [
                                              Text(
                                                // valuFechas.getFechaColocacion ??
                                                //     'yyyy-mm-dd',


 valuFechas.getFechaColocacion!=""? valuFechas.getFechaColocacion:'${DateTime.now().year}-${(DateTime.now().month) < 10 ? '0${DateTime.now().month}' : '${DateTime.now().month}'}-${(DateTime.now().day) < 10 ? '0${DateTime.now().day}' : '${DateTime.now().day}'}',

                                                style: GoogleFonts.lexendDeca(
                                                  fontSize: size.iScreen(1.8),
                                                  color: Colors.black45,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                width: size.iScreen(0.5),
                                              ),
                                              const Icon(
                                                Icons.date_range_outlined,
                                                // color: primaryColor,
                                                size: 30,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    //*****************************************/
                                    SizedBox(
                                      height: size.iScreen(0.0),
                                    ),
                                    //*****************************************/

                                    Row(
                                      children: [
                                        Text(
                                          '# Días Recolocación : ',
                                          style: GoogleFonts.lexendDeca(
                                            // fontSize: size.iScreen(1.8),
                                            color: Colors.black45,
                                            // fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        //*****************************************/
                                        SizedBox(
                                          width: size.iScreen(1.0),
                                        ),
                                        //*****************************************/
                                        Container(
                                          width: size.wScreen(15.0),
                                          child: TextFormField(
                                            // maxLength: 2,
                                               initialValue: widget.tipo == 'CREATE'
                                        ? ''
                                        : controllerReceta.getInputDiasRec,
                                            decoration: const InputDecoration(),
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter.allow(
                                                  RegExp(r'[0-9]')),
                                            ],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: size.iScreen(2.0),
                                              // fontWeight: FontWeight.bold,
                                              // letterSpacing: 2.0,
                                            ),
                                            onChanged: (text) {
                                              valuFechas.setInputDiasRec(text);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    //*****************************************/
                                    SizedBox(
                                      height: size.iScreen(1.0),
                                    ),
                                    //*****************************************/
                                    Row(
                                      children: [
                                        Text(
                                          'Fecha Recolocación : ',
                                          style: GoogleFonts.lexendDeca(
                                            // fontSize: size.iScreen(1.8),
                                            color: Colors.black45,
                                            // fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          width: size.iScreen(1.0),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            FocusScope.of(context)
                                                .requestFocus(FocusNode());
                                            _fechaRecolocacion(
                                                context, valuFechas);
                                          },
                                          child: Row(
                                            children: [
                                              Text(
                                                valuFechas
                                                        .getFechaRecolocacion ??
                                                    'yyyy-mm-dd',
                                                style: GoogleFonts.lexendDeca(
                                                  fontSize: size.iScreen(1.8),
                                                  color: Colors.black45,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                width: size.iScreen(1.0),
                                              ),
                                              const Icon(
                                                Icons.date_range_outlined,
                                                // color: primaryColor,
                                                size: 30,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),

                                    
                                  ],
                                );
                              },
                            ),

                            //  //***********************************************/
                            // SizedBox(
                            //   height: size.iScreen(1.0),
                            // ),
                            // //*****************************************/

                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                            //   children: [
                            //     Column(
                            //       children: [
                            //         Container(
                            //           // width: size.wScreen(20.0),

                            //           // color: Colors.blue,
                            //           child: Text('Peso kg',
                            //               style: GoogleFonts.lexendDeca(
                            //                   // fontSize: size.iScreen(2.0),
                            //                   fontWeight: FontWeight.normal,
                            //                   color: Colors.grey)),
                            //         ),
                            //         Container(
                            //           width: size.wScreen(30.0),
                            //           child: TextFormField(
                            //             initialValue: widget.tipo == 'CREATE'
                            //                 ? ''
                            //                 : controllerReceta.getPesoMascota,
                            //             keyboardType: TextInputType.number,
                            //             inputFormatters: <TextInputFormatter>[
                            //               FilteringTextInputFormatter.allow(
                            //                   RegExp(r'[0-9.]')),
                            //             ],
                            //             decoration: const InputDecoration(
                            //                 // suffixIcon: Icon(Icons.beenhere_outlined)
                            //                 ),
                            //             textAlign: TextAlign.center,
                            //             style: TextStyle(
                            //               fontSize: size.iScreen(2.0),
                            //               // fontWeight: FontWeight.bold,
                            //               // letterSpacing: 2.0,
                            //             ),
                            //             onChanged: (text) {
                            //               controllerReceta.setPesoMascota(text);
                            //             },
                            //             validator: (text) {
                            //               if (text!.trim().isNotEmpty) {
                            //                 return null;
                            //               } else {
                            //                 return 'Ingrese peso de la mascota';
                            //               }
                            //             },
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //     Column(
                            //       children: [
                            //         Container(
                            //           // width: size.wScreen(22.0),

                            //           // color: Colors.blue,
                            //           child: Text('Temperatura',
                            //               style: GoogleFonts.lexendDeca(
                            //                   // fontSize: size.iScreen(2.0),
                            //                   fontWeight: FontWeight.normal,
                            //                   color: Colors.grey)),
                            //         ),
                            //         Container(
                            //           width: size.wScreen(50.0),
                            //           child: TextFormField(
                            //             initialValue: widget.tipo == 'CREATE'
                            //                 ? ''
                            //                 : controllerReceta.getFechaCaducudad,
                            //             keyboardType: TextInputType.number,
                            //             inputFormatters: <TextInputFormatter>[
                            //               FilteringTextInputFormatter.allow(
                            //                   RegExp(r'[0-9.]')),
                            //             ],
                            //             decoration: const InputDecoration(
                            //                 // suffixIcon: Icon(Icons.beenhere_outlined)
                            //                 ),
                            //             textAlign: TextAlign.center,
                            //             style: TextStyle(
                            //               fontSize: size.iScreen(2.0),
                            //               // fontWeight: FontWeight.bold,
                            //               // letterSpacing: 2.0,
                            //             ),
                            //             onChanged: (text) {
                            //               controllerReceta.setFechaCaducudad(text);
                            //             },
                            //             // validator: (text) {
                            //             //   if (text!.trim().isNotEmpty) {
                            //             //     return null;
                            //             //   } else {
                            //             //     return 'Ingrese peso de la mascota';
                            //             //   }
                            //             // },
                            //           ),
                            //         ),
                            //       ],
                            //     ),

                            //   ],
                            // ),
                            //***********************************************/
                            SizedBox(
                              height: size.iScreen(1.5),
                            ),
                            //*****************************************/
                            Container(
                              width: size.wScreen(100.0),

                              // color: Colors.blue,
                              child: Text('Observación',
                                  style: GoogleFonts.lexendDeca(
                                      // fontSize: size.iScreen(2.0),
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey)),
                            ),
                            Container(
                              // width: size.wScreen(20.0),
                              child: TextFormField(
                                initialValue: widget.tipo == 'CREATE'
                                    ? ''
                                    : controllerReceta.getObservacacion,
                                // keyboardType: TextInputType.number,
                                // inputFormatters: <TextInputFormatter>[
                                //   FilteringTextInputFormatter.allow(
                                //       RegExp(r'[0-9.]')),
                                // ],
                                decoration: const InputDecoration(
                                    // suffixIcon: Icon(Icons.beenhere_outlined)
                                    ),
                                // textAlign: TextAlign.center,
                                maxLines: 3,
                                minLines: 1,
                                style: TextStyle(
                                  fontSize: size.iScreen(2.0),
                                  // fontWeight: FontWeight.bold,
                                  // letterSpacing: 2.0,
                                ),
                                onChanged: (text) {
                                  controllerReceta.setObservacacion(text);
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
  void _onSubmit(BuildContext context, VacunasController controller,
      ) async {
    final isValid = controller.validateForm();
    if (!isValid) return;
    if (isValid) {
      if (controller.getNombreMascota == '') {
        NotificatiosnService.showSnackBarDanger('Debe seleccionar Mascota');
      } 
      else if (controller.labelTipoProducto == '') {
        NotificatiosnService.showSnackBarDanger('Debe seleccionar Tipo de Producto');
      }
      else if (controller.labelProducto == '') {
        NotificatiosnService.showSnackBarDanger('Debe seleccionar Producto');
      }
     
      else if (controller.getVetDoctorNombre == '') {
        NotificatiosnService.showSnackBarDanger('Debe seleccionar Veterinario');
      }
      if (controller.getNombreMascota != '' &&
          controller.labelTipoProducto != ''&&
          controller.labelProducto != '' &&
          controller.getVetDoctorNombre != '') {
        
        if (widget.tipo == 'CREATE') {
          await controller.crearVacuna(context);
          Navigator.pop(context);
        }
        if (widget.tipo == 'EDIT') {
            await controller.editarVacuna(context);
          Navigator.pop(context);
        }
          context.read<VacunasController>().resetFormVacuna();
        // Navigator.pop(context);
      }
      
      
  
     
   
    }
  }

  _fechaColocacion(BuildContext context, VacunasController controller) async {
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
      controller.setFechaColocacion(_fechaInicio);
      // print('FechaInicio: $_fechaInicio');
      // });
    }
  }

  _fechaRecolocacion(BuildContext context, VacunasController controller) async {
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
      controller.setFechaRecolocacion(_fechaInicio);
      // print('FechaInicio: $_fechaInicio');
      // });
    }
  }

  //******************************************************BUSCA VETERINARIO INTERNO**************************************************************//
  Future<bool?> _buscarMedico(BuildContext context, Responsive size) {
    return showDialog<bool>(
      barrierColor: Colors.black54,
      context: context,
      builder: (context) {
        // final controller = context.read<PropietariosController>();
        final controllerMascota = context.read<MascotasController>();

        return AlertDialog(
            title: const Text("BUSCAR DOCTOR"),
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
                            controllerMascota.onSearchTextMascota(text);

                            if (controllerMascota.nameSearchMascota.isEmpty) {
                              controllerMascota.buscaAllMascotas('');
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

                          Consumer<RecetasController>(
                        builder: (_, providerMascota, __) {
                          if (providerMascota.getErrorAllPersonas == null) {
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
                          } else if (providerMascota.getErrorAllPersonas ==
                              false) {
                            return const NoData(
                              label: 'No existen datos para mostar',
                            );
                            // Text("Error al cargar los datos");
                          } else if (providerMascota
                              .getListaAllPersonas.isEmpty) {
                            return const NoData(
                              label: 'No existen datos para mostar',
                            );
                          }
                          // print('esta es la lista*******************: ${providerMascota.getListaPropietarios.length}');

                          return ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount:
                                providerMascota.getListaAllPersonas.length,
                            itemBuilder: (BuildContext context, int index) {
                              final _persona =
                                  providerMascota.getListaAllPersonas[index];
                              return GestureDetector(
                                onTap: () {
                                  context
                                      .read<VacunasController>()
                                      .setDoctorInfo(_persona);

                                  // print('SSSSSSSSSSS :$propietario ');
                                  // (
                                  // propietario['perNombre']);
                                  // controllerMascota
                                  //     .getInfoPropietarioMascota(_mascota);
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
                                                      '${_persona['perNombre']}',
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

  //**********************************************BUSCA MASCOTA **********************************************************************//
  Future<bool?> _buscarMascota(BuildContext context, Responsive size) {
    return showDialog<bool>(
      barrierColor: Colors.black54,
      context: context,
      builder: (context) {
        // final controller = context.read<PropietariosController>();
        final controllerMascota = context.read<MascotasController>();

        return AlertDialog(
            title: const Text("BUSCAR MASCOTA"),
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
                            controllerMascota.onSearchTextMascota(text);

                            if (controllerMascota.nameSearchMascota.isEmpty) {
                              controllerMascota.buscaAllMascotas('');
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

                          Consumer<MascotasController>(
                        builder: (_, providerMascota, __) {
                          if (providerMascota.getErrorMascotas == null) {
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
                          } else if (providerMascota.getErrorMascotas ==
                              false) {
                            return const NoData(
                              label: 'No existen datos para mostar',
                            );
                            // Text("Error al cargar los datos");
                          } else if (providerMascota.getListaMascotas.isEmpty) {
                            return const NoData(
                              label: 'No existen datos para mostar',
                            );
                          }
                          // print('esta es la lista*******************: ${providerMascota.getListaPropietarios.length}');

                          return ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: providerMascota.getListaMascotas.length,
                            itemBuilder: (BuildContext context, int index) {
                              final _mascota =
                                  providerMascota.getListaMascotas[index];
                              return GestureDetector(
                                onTap: () {
                                  context
                                      .read<VacunasController>()
                                      .setMascotaInfo(_mascota);

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
                                                      '${_mascota['mascNombre']}',
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

  Future<String?> _modalTipoProductos(
      BuildContext context, Responsive size, VacunasController controller) {
    final List<dynamic> lista_Tipos_Productos = [
      "ANTIPULGAS",
      "DESPARASITANTES",
      "MEDICAMENTO ESPECIAL",
      "VACUNAS"
    ];

    return showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Center(child: Text('Tipo de Productos')),
              content: SizedBox(
                  height: size.hScreen(40.0),
                  width: double.maxFinite,
                  child: ListView.builder(
                    itemCount: lista_Tipos_Productos.length,
                    itemBuilder: (BuildContext context, int index) {
                      final _tipo = lista_Tipos_Productos[index];
                      // final List razasList =
                      //     controller.getListaProductos[index]['espRazas'];

                      return ListTile(
                        onTap: () {
                          controller.setLabelTipoProducto(_tipo);
                          controller.buscaAllProductos(_tipo);
                          controller.setLabelProducto('');

                          Navigator.pop(context);
                        },
                        title: Text('${_tipo}'),
                      );
//
                    },
                  )

                  // },
                  ),
            ));
  }

  Future<String?> _modalAllProductos(BuildContext context, Responsive size) {
    // final List<dynamic> lista_Tipos_Productos=["ANTIPULGAS","DESPARASITANTES","MEDICAMENTO ESPECIAL","VACUNAS"];

    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Center(child: Text('Productos')),
        content: SizedBox(
            height: size.hScreen(40.0),
            width: double.maxFinite,
            child: Consumer<VacunasController>(builder: (_, valueProduct, __) {
              return Wrap(
                  children: valueProduct.getListaProductos.isNotEmpty
                      ? valueProduct.getListaProductos
                          .map(
                            (e) => ListTile(
                              onTap: () {
                                valueProduct
                                    .setLabelProducto(e['invNombre']);
                                Navigator.pop(context);
                              },
                              title: Text('${e['invNombre']}'),
                            ),
                          )
                          .toList()
                      : []);
            })),
      ),
    );
  }
}

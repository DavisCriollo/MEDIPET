import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:neitor_vet/src/controllers/recetas_controller.dart';
import 'package:neitorcont/src/controllers/reservas_controller.dart';
// import 'package:neitorcont/src/data_table/lista_medicina_datasource.dart';
import 'package:neitorcont/src/utils/responsive.dart';
import 'package:neitorcont/src/utils/theme.dart';
// import 'package:neitor_vet/src/widgets/no_data.dart';
import 'package:provider/provider.dart';

class DetalleReserva extends StatelessWidget {
  const DetalleReserva({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final infoReserva = context.read<ReservasController>().getInfoReserva;
    final controlReserva = context.read<ReservasController>();
    final Responsive size = Responsive.of(context);
    return Scaffold(
        appBar: AppBar(
          title:  Text('Detalle de Reserva',style:  Theme.of(context).textTheme.headline2,),
        ),
        body: Container(
            // color: Colors.red,
            margin: EdgeInsets.only(
                left: size.iScreen(1.5),
                right: size.iScreen(1.5),
                bottom: size.iScreen(0.0)),
            width: size.wScreen(100),
            height: size.hScreen(100),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  //*****************************************/
                  SizedBox(
                    height: size.iScreen(1.0),
                  ),
                  //         //==========================================//
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: size.iScreen(1.0),
                        horizontal: size.iScreen(1.0)),
                    width: size.wScreen(100.0),
                    color: Colors.grey[200],
                    child: Text('Paciente',
                        style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.normal,
                            color: Colors.grey)),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                    width: size.wScreen(100.0),
                    child: Text(
                      '${controlReserva.getNombreMascota}',
                      style: GoogleFonts.lexendDeca(
                          fontSize: size.iScreen(1.8),
                          // color: Colors.white,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  //*****************************************/
                  SizedBox(
                    height: size.iScreen(0.0),
                  ),
                  //==========================================//
                  Row(
                    children: [
                      SizedBox(
                        width: size.wScreen(12.0),
                        // color: Colors.blue,
                        child: Text('Raza:',
                            style: GoogleFonts.lexendDeca(
                                // fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                      ),
                       Container(
                    margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                    // width: size.wScreen(100.0),
                    child: Text(
                       '${controlReserva.getRazaMascota}',
                      style: GoogleFonts.lexendDeca(
                          fontSize: size.iScreen(1.8),
                          // color: Colors.white,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                    ],
                  ),
                 
                  //*****************************************/
                  SizedBox(
                    height: size.iScreen(0.0),
                  ),
                  //         //==========================================//
                  SizedBox(
                    width: size.wScreen(100.0),
                    // color: Colors.blue,
                    child: Text('Propietario:',
                        style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.normal,
                            color: Colors.grey)),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                    width: size.wScreen(100.0),
                    child: Text(
                     '${controlReserva.getPropietarioMascota}',
                      style: GoogleFonts.lexendDeca(
                          fontSize: size.iScreen(1.8),
                          // color: Colors.white,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                   //*****************************************/
                  SizedBox(
                    height: size.iScreen(0.0),
                  ),
             //==========================================//
                  SizedBox(
                    width: size.wScreen(100.0),
                    // color: Colors.blue,
                    child: Text('Celular:',
                        style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.normal,
                            color: Colors.grey)),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                    width: size.wScreen(100.0),
                    child: controlReserva.getPropietarioCelularMascota!.isEmpty
                        ? Text('--- --- --- ',
                            style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                            ))
                        : Wrap(
                            children: (controlReserva.getPropietarioCelularMascota!)
                                .map(
                                  (e) => InkWell(
                                    onDoubleTap: () async {
                                      _callNumber(e);
                                    },
                                    child: Row(
                                      children: [
                                        Container(
                                          // width: size.wScreen(100.0),
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade200,
                                              borderRadius:
                                                  BorderRadius.circular(5.0)),
                                          margin: EdgeInsets.symmetric(
                                              vertical: size.iScreen(0.3)),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: size.iScreen(1.0),
                                              vertical: size.iScreen(0.5)),
                                          child: Text('$e',
                                              style: GoogleFonts.lexendDeca(
                                                  fontSize: size.iScreen(1.7),
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black)),
                                        ),

                                        //***********************************************/
                                        SizedBox(
                                          width: size.iScreen(3.0),
                                        ),
                                        //*****************************************/
                                        Icon(
                                          Icons.phone_forwarded_outlined,
                                          size: size.iScreen(3.0),
                                          color: primaryColor,
                                        )
                                      ],
                                    ),
                                  ),

                                  // Text('$e',
                                  //     style: GoogleFonts.lexendDeca(
                                  //         // fontSize: size.iScreen(2.0),
                                  //         fontWeight: FontWeight.normal,
                                  //         color: Colors.black)),
                                )
                                .toList()),
                  ),
                  //*****************************************/
                  SizedBox(
                    height: size.iScreen(0.0),
                  ),
                  //         //==========================================//
                  SizedBox(
                    width: size.wScreen(100.0),
                    // color: Colors.blue,
                    child: Text('Correo:',
                        style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.normal,
                            color: Colors.grey)),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                    width: size.wScreen(100.0),
                    child: controlReserva.getPropietarioEmailMascota!.isEmpty
                        ? Text('--- --- --- ',
                            style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                            ))
                        : Wrap(
                            children:
                                (controlReserva.getPropietarioEmailMascota!)
                                    .map(
                                      (e) => Text('$e',
                                          style: GoogleFonts.lexendDeca(
                                              // fontSize: size.iScreen(2.0),
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black)),
                                    )
                                    .toList()),
                  ),
                  //*****************************************/
                  SizedBox(
                    height: size.iScreen(1.0),
                  ),
                  //         //==========================================//
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: size.iScreen(1.0),
                        horizontal: size.iScreen(1.0)),
                    width: size.wScreen(100.0),
                    color: Colors.grey[200],
                    child: Text('Tipo de Reserva:',
                        style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.normal,
                            color: Colors.grey)),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                    width: size.wScreen(100.0),
                    child: Text(
                      '${controlReserva.getTipoReservaNombre}',
                      style: GoogleFonts.lexendDeca(
                          fontSize: size.iScreen(1.8),
                          // color: Colors.white,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                   //*****************************************/
                  SizedBox(
                    height: size.iScreen(0.0),
                  ),
                  //==========================================//
                  Row(
                    children: [
                      SizedBox(
                        width: size.wScreen(25.0),
                        // color: Colors.blue,
                        child: Text('Fecha y hora:',
                            style: GoogleFonts.lexendDeca(
                                // fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                      ),
                       Container(
                    margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                    // width: size.wScreen(100.0),
                    child: Text(
                       '${controlReserva.getInputfechaProximaCita}',
                      style: GoogleFonts.lexendDeca(
                          fontSize: size.iScreen(1.8),
                          // color: Colors.white,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                    ],
                  ),
                   //*****************************************/
                  SizedBox(
                    height: size.iScreen(0.0),
                  ),
                  //         //==========================================//
                  SizedBox(
                    width: size.wScreen(100.0),
                    // color: Colors.blue,
                    child: Text('Veterninario:',
                        style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.normal,
                            color: Colors.grey)),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                    width: size.wScreen(100.0),
                    child: Text(
                        controlReserva.getDoctoNombre!=''? '${controlReserva.getDoctoNombre}':'--- --- ---',
                
                      style: GoogleFonts.lexendDeca(
                          fontSize: size.iScreen(1.8),
                          // color: Colors.white,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  //*****************************************/
                  SizedBox(
                    height: size.iScreen(1.0),
                  ),
                 //==========================================//
                  SizedBox(
                    width: size.wScreen(100.0),
                    // color: Colors.blue,
                    child: Text('Observaciones:',
                        style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.normal,
                            color: Colors.grey)),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                    width: size.wScreen(100.0),
                    child: Text(
                      controlReserva.getObservaciones!=''? '${controlReserva.getObservaciones}':'--- --- ---',
                      style: GoogleFonts.lexendDeca(
                          fontSize: size.iScreen(1.8),
                          // color: Colors.white,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  // //*****************************************/
                  // SizedBox(
                  //   height: size.iScreen(0.0),
                  // ),
                  // //         //==========================================//
                  // SizedBox(
                  //   width: size.wScreen(100.0),
                  //   // color: Colors.blue,
                  //   child: Text('Edad:',
                  //       style: GoogleFonts.lexendDeca(
                  //           // fontSize: size.iScreen(2.0),
                  //           fontWeight: FontWeight.normal,
                  //           color: Colors.grey)),
                  // ),
                  // Container(
                  //   margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                  //   width: size.wScreen(100.0),
                  //   child: Text(
                  //     '${infoReceta['recMascEdad']}',
                  //     style: GoogleFonts.lexendDeca(
                  //         fontSize: size.iScreen(1.8),
                  //         // color: Colors.white,
                  //         fontWeight: FontWeight.normal),
                  //   ),
                  // ),

                  // //*****************************************/
                  // SizedBox(
                  //   height: size.iScreen(0.0),
                  // ),
                  // //         //==========================================//
                  // Row(
                  //   children: [
                  //     SizedBox(
                  //       // width: size.wScreen(100.0),
                  //       // color: Colors.blue,
                  //       child: Text('Peso:',
                  //           style: GoogleFonts.lexendDeca(
                  //               // fontSize: size.iScreen(2.0),
                  //               fontWeight: FontWeight.normal,
                  //               color: Colors.grey)),
                  //     ),
                  //     Container(
                  //       margin: EdgeInsets.symmetric(
                  //           vertical: size.iScreen(0.5),
                  //           horizontal: size.iScreen(1.5)),
                  //       // width: size.wScreen(100.0),
                  //       child: Text(
                  //         '${infoReceta['recPeso']}',
                  //         style: GoogleFonts.lexendDeca(
                  //             fontSize: size.iScreen(1.8),
                  //             // color: Colors.white,
                  //             fontWeight: FontWeight.normal),
                  //       ),
                  //     ),
                  //   ],
                  // ),

                  // //*****************************************/
                  // SizedBox(
                  //   height: size.iScreen(1.0),
                  // ),
                  // //         //==========================================//
                  // Container(
                  //   padding: EdgeInsets.symmetric(
                  //       vertical: size.iScreen(1.0),
                  //       horizontal: size.iScreen(1.0)),
                  //   width: size.wScreen(100.0),
                  //   color: Colors.grey[200],
                  //   child: Text('Propietario',
                  //       style: GoogleFonts.lexendDeca(
                  //           // fontSize: size.iScreen(2.0),
                  //           fontWeight: FontWeight.normal,
                  //           color: Colors.grey)),
                  // ),
                  // Container(
                  //   margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                  //   width: size.wScreen(100.0),
                  //   child: Text(
                  //     '${infoReceta['recPerNombrePropietario']}',
                  //     style: GoogleFonts.lexendDeca(
                  //         fontSize: size.iScreen(1.8),
                  //         // color: Colors.white,
                  //         fontWeight: FontWeight.normal),
                  //   ),
                  // ),
                  // //*****************************************/
                  // SizedBox(
                  //   height: size.iScreen(0.0),
                  // ),
                  // //         //==========================================//
                  // SizedBox(
                  //   width: size.wScreen(100.0),
                  //   // color: Colors.blue,
                  //   child: Text('Dirección:',
                  //       style: GoogleFonts.lexendDeca(
                  //           // fontSize: size.iScreen(2.0),
                  //           fontWeight: FontWeight.normal,
                  //           color: Colors.grey)),
                  // ),
                  // Container(
                  //   margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                  //   width: size.wScreen(100.0),
                  //   child: Text(
                  //     '${infoReceta['recPerDireccionPropietario']}',
                  //     style: GoogleFonts.lexendDeca(
                  //         fontSize: size.iScreen(1.8),
                  //         // color: Colors.white,
                  //         fontWeight: FontWeight.normal),
                  //   ),
                  // ),
                  // //*****************************************/
                  // SizedBox(
                  //   height: size.iScreen(0.0),
                  // ),
                  // //         //==========================================//
                  // SizedBox(
                  //   width: size.wScreen(100.0),
                  //   // color: Colors.blue,
                  //   child: Text('Celular:',
                  //       style: GoogleFonts.lexendDeca(
                  //           // fontSize: size.iScreen(2.0),
                  //           fontWeight: FontWeight.normal,
                  //           color: Colors.grey)),
                  // ),
                  // Container(
                  //   margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                  //   width: size.wScreen(100.0),
                  //   child: infoReceta['recPerCelularPropietario']!.isEmpty
                  //       ? Text('--- --- --- ',
                  //           style: GoogleFonts.lexendDeca(
                  //             // fontSize: size.iScreen(2.0),
                  //             fontWeight: FontWeight.normal,
                  //           ))
                  //       : Wrap(
                  //           children: (infoReceta['recPerCelularPropietario']!
                  //                   as List)
                  //               .map(
                  //                 (e) => InkWell(
                  //                   onDoubleTap: () async {
                  //                     _callNumber(e);
                  //                   },
                  //                   child: Row(
                  //                     children: [
                  //                       Container(
                  //                         // width: size.wScreen(100.0),
                  //                         decoration: BoxDecoration(
                  //                             color: Colors.grey.shade200,
                  //                             borderRadius:
                  //                                 BorderRadius.circular(5.0)),
                  //                         margin: EdgeInsets.symmetric(
                  //                             vertical: size.iScreen(0.3)),
                  //                         padding: EdgeInsets.symmetric(
                  //                             horizontal: size.iScreen(1.0),
                  //                             vertical: size.iScreen(0.5)),
                  //                         child: Text('$e',
                  //                             style: GoogleFonts.lexendDeca(
                  //                                 fontSize: size.iScreen(1.7),
                  //                                 fontWeight: FontWeight.normal,
                  //                                 color: Colors.black)),
                  //                       ),

                  //                       //***********************************************/
                  //                       SizedBox(
                  //                         width: size.iScreen(3.0),
                  //                       ),
                  //                       //*****************************************/
                  //                       Icon(
                  //                         Icons.phone_forwarded_outlined,
                  //                         size: size.iScreen(3.0),
                  //                         color: primaryColor,
                  //                       )
                  //                     ],
                  //                   ),
                  //                 ),

                  //                 // Text('$e',
                  //                 //     style: GoogleFonts.lexendDeca(
                  //                 //         // fontSize: size.iScreen(2.0),
                  //                 //         fontWeight: FontWeight.normal,
                  //                 //         color: Colors.black)),
                  //               )
                  //               .toList()),
                  // ),
                  // //*****************************************/
                  // SizedBox(
                  //   height: size.iScreen(0.0),
                  // ),
                  // //         //==========================================//
                  // SizedBox(
                  //   width: size.wScreen(100.0),
                  //   // color: Colors.blue,
                  //   child: Text('Correo:',
                  //       style: GoogleFonts.lexendDeca(
                  //           // fontSize: size.iScreen(2.0),
                  //           fontWeight: FontWeight.normal,
                  //           color: Colors.grey)),
                  // ),
                  // Container(
                  //   margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                  //   width: size.wScreen(100.0),
                  //   child: infoReceta['recPerEmailPropietario']!.isEmpty
                  //       ? Text('--- --- --- ',
                  //           style: GoogleFonts.lexendDeca(
                  //             // fontSize: size.iScreen(2.0),
                  //             fontWeight: FontWeight.normal,
                  //           ))
                  //       : Wrap(
                  //           children:
                  //               (infoReceta['recPerEmailPropietario']! as List)
                  //                   .map(
                  //                     (e) => Text('$e',
                  //                         style: GoogleFonts.lexendDeca(
                  //                             // fontSize: size.iScreen(2.0),
                  //                             fontWeight: FontWeight.normal,
                  //                             color: Colors.black)),
                  //                   )
                  //                   .toList()),
                  // ),
                  // //*****************************************/
                  // SizedBox(
                  //   height: size.iScreen(1.0),
                  // ),
                  // //         //==========================================//
                  // Container(
                  //   padding: EdgeInsets.symmetric(
                  //       vertical: size.iScreen(1.0),
                  //       horizontal: size.iScreen(1.0)),
                  //   width: size.wScreen(100.0),
                  //   color: Colors.grey[200],
                  //   child: Text('Doctor',
                  //       style: GoogleFonts.lexendDeca(
                  //           // fontSize: size.iScreen(2.0),
                  //           fontWeight: FontWeight.normal,
                  //           color: Colors.grey)),
                  // ),
                  // Container(
                  //   margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                  //   width: size.wScreen(100.0),
                  //   child: Text(
                  //     '${infoReceta['recPerNombreDoc']}',
                  //     style: GoogleFonts.lexendDeca(
                  //         fontSize: size.iScreen(1.8),
                  //         // color: Colors.white,
                  //         fontWeight: FontWeight.normal),
                  //   ),
                  // ),

                  // //*****************************************/
                  // SizedBox(
                  //   height: size.iScreen(0.0),
                  // ),
                  // //         //==========================================//
                  // Row(
                  //   children: [
                  //     SizedBox(
                  //       // width: size.wScreen(100.0),
                  //       // color: Colors.blue,
                  //       child: Text('Próxima Cita:',
                  //           style: GoogleFonts.lexendDeca(
                  //               // fontSize: size.iScreen(2.0),
                  //               fontWeight: FontWeight.normal,
                  //               color: Colors.grey)),
                  //     ),
                  //     Container(
                  //       margin: EdgeInsets.symmetric(
                  //           vertical: size.iScreen(0.5),
                  //           horizontal: size.iScreen(1.5)),
                  //       // width: size.wScreen(100.0),
                  //       child: Text(
                  //          infoReceta['recProxCita']!=''? '${infoReceta['recProxCita'].replaceAll('T', "  ")}':'--- --- ---',
                  //         style: GoogleFonts.lexendDeca(
                  //             fontSize: size.iScreen(1.8),
                  //             // color: Colors.white,
                  //             fontWeight: FontWeight.normal),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // //*****************************************/
                  // SizedBox(
                  //   height: size.iScreen(0.0),
                  // ),
                  // //         //==========================================//
                  // SizedBox(
                  //   width: size.wScreen(100.0),
                  //   // color: Colors.blue,
                  //   child: Text('Recomendaciones:',
                  //       style: GoogleFonts.lexendDeca(
                  //           // fontSize: size.iScreen(2.0),
                  //           fontWeight: FontWeight.normal,
                  //           color: Colors.grey)),
                  // ),
                  // Container(
                  //   margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                  //   width: size.wScreen(100.0),
                  //   child: Text(
                  //      infoReceta['recRecomendacion']!=''? '${infoReceta['recRecomendacion']}':'--- --- ---',
                  //     style: GoogleFonts.lexendDeca(
                  //         fontSize: size.iScreen(1.8),
                  //         // color: Colors.white,
                  //         fontWeight: FontWeight.normal),
                  //   ),
                  // ),
                  //***********************************************/
                  SizedBox(
                    height: size.iScreen(2.0),
                  ),
                  //*****************************************/

                
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(8),
//                           child: GestureDetector(
//                             onTap: () {
//                               // context
//                               //     .read<MascotasController>()
//                               //     .buscaAllMascotas('');

//                               _agregaMedicamento(context, size);

// //*******************************************/
//                             },
//                             child: Container(
//                               alignment: Alignment.center,
//                               color: primaryColor,
//                               width: size.iScreen(3.5),
//                               padding: EdgeInsets.only(
//                                 top: size.iScreen(0.5),
//                                 bottom: size.iScreen(0.5),
//                                 left: size.iScreen(0.5),
//                                 right: size.iScreen(0.5),
//                               ),
//                               child: Icon(
//                                 Icons.search_outlined,
//                                 color: Colors.white,
//                                 size: size.iScreen(2.0),
//                               ),
//                             ),
//                           ),
                        // ),
                      ],
                    ),
                  )));
                  // //***********************************************/
                
  }

  _callNumber(String numero) async {
    await FlutterPhoneDirectCaller.callNumber(numero);
  }
}

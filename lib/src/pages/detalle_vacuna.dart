import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neitorcont/src/controllers/recetas_controller.dart';
import 'package:neitorcont/src/controllers/vacunas_controller.dart';
import 'package:neitorcont/src/utils/responsive.dart';
import 'package:neitorcont/src/utils/theme.dart';
import 'package:provider/provider.dart';

class DetalleVacuna extends StatelessWidget {
  const DetalleVacuna({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final infoVacuna = context.read<VacunasController>().getInfoVacuna;
    final Responsive size = Responsive.of(context);
    return Scaffold(
        appBar: AppBar(
          title:  Text('Detalle de Vacuna',style:  Theme.of(context).textTheme.headline2,),
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
              child:Column( children: [
                 //*****************************************/
                  SizedBox(
                    height: size.iScreen(1.0),
                  ),
                  //         //==========================================//
                    Container(
                    padding: EdgeInsets.symmetric(vertical:size.iScreen(1.0),horizontal:size.iScreen(1.0)),
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
                      '${infoVacuna['carnMascNombre']}',
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
                  //         //==========================================//
                    SizedBox(
                    width: size.wScreen(100.0),
                    // color: Colors.blue,
                    child: Text('Peso:',
                        style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.normal,
                            color: Colors.grey)),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                    width: size.wScreen(100.0),
                    child: Text(
                      '${infoVacuna['carnPeso']}',
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
                  //         //==========================================//
                    SizedBox(
                    width: size.wScreen(100.0),
                    // color: Colors.blue,
                    child: Text('Veterinario:',
                        style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.normal,
                            color: Colors.grey)),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                    width: size.wScreen(100.0),
                    child: Text(
                      '${infoVacuna['carnPerNombreVet']}',
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
                  //         //==========================================//
                    Container(
                    padding: EdgeInsets.symmetric(vertical:size.iScreen(1.0),horizontal:size.iScreen(1.0)),
                    width: size.wScreen(100.0),
                    color: Colors.grey[200],
                    child: Text('Producto',
                        style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.normal,
                            color: Colors.grey)),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                    width: size.wScreen(100.0),
                    child: Text(
                      '${infoVacuna['carnProdNombre']}',
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
                  //         //==========================================//
                    SizedBox(
                    width: size.wScreen(100.0),
                    // color: Colors.blue,
                    child: Text('Tipo Producto:',
                        style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.normal,
                            color: Colors.grey)),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                    width: size.wScreen(100.0),
                    child: Text(
                      '${infoVacuna['carnProdTipo']}',
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
                  //         //==========================================//
                    Row(
                      children: [
                        SizedBox(
                        // width: size.wScreen(100.0),
                        // color: Colors.blue,
                        child: Text('Fecha Caducidad:',
                            style: GoogleFonts.lexendDeca(
                                // fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                  ),
                    Container(
                    margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5), horizontal: size.iScreen(1.5)),
                    // width: size.wScreen(100.0),
                    child: Text(
                      '${infoVacuna['carnProdFecCaducidad']}',
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
                    Row(
                      children: [
                        SizedBox(
                        // width: size.wScreen(100.0),
                        // color: Colors.blue,
                        child: Text('Fecha Colocación:',
                            style: GoogleFonts.lexendDeca(
                                // fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                  ),
                    Container(
                    margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5), horizontal: size.iScreen(1.5)),
                    // width: size.wScreen(100.0),
                    child: Text(
                      '${infoVacuna['carnFecVacuColocacion']}',
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
                    Row(
                      children: [
                        SizedBox(
                        // width: size.wScreen(100.0),
                        // color: Colors.blue,
                        child: Text('Fecha Recolocación:',
                            style: GoogleFonts.lexendDeca(
                                // fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                  ),
                    Container(
                    margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5), horizontal: size.iScreen(1.5)),
                    // width: size.wScreen(100.0),
                    child: Text(
                      '${infoVacuna['carnFecVacuRecolocacion']}',
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
                    Row(
                      children: [
                        SizedBox(
                        // width: size.wScreen(100.0),
                        // color: Colors.blue,
                        child: Text('Días Recolocación:',
                            style: GoogleFonts.lexendDeca(
                                // fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                  ),
                    Container(
                    margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5), horizontal: size.iScreen(1.5)),
                    // width: size.wScreen(100.0),
                    child: Text(
                      '${infoVacuna['carnDiasVacuRecolocacion']}',
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
                    child: Text('Observación:',
                        style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.normal,
                            color: Colors.grey)),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                    width: size.wScreen(100.0),
                    child: Text(
                      '${infoVacuna['carnObservacion']}',
                      style: GoogleFonts.lexendDeca(
                          fontSize: size.iScreen(1.8),
                          // color: Colors.white,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                 
                
                  // //*****************************************/
                  // SizedBox(
                  //   height: size.iScreen(1.0),
                  // ),
                  // //         //==========================================//
                  //   Container(
                  //   padding: EdgeInsets.symmetric(vertical:size.iScreen(1.0),horizontal:size.iScreen(1.0)),
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
                  //     '${infoVacuna['recPerNombrePropietario']}',
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
                  //   SizedBox(
                  //       width: size.wScreen(100.0),
                  //       // color: Colors.blue,
                  //       child: Text('Dirección:',
                  //           style: GoogleFonts.lexendDeca(
                  //               // fontSize: size.iScreen(2.0),
                  //               fontWeight: FontWeight.normal,
                  //               color: Colors.grey)),
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
                  //   SizedBox(
                  //       width: size.wScreen(100.0),
                  //       // color: Colors.blue,
                  //       child: Text('Celular:',
                  //           style: GoogleFonts.lexendDeca(
                  //               // fontSize: size.iScreen(2.0),
                  //               fontWeight: FontWeight.normal,
                  //               color: Colors.grey)),
                  // ),
                  // Container(
                  //   margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                  //   width: size.wScreen(100.0),
                  //   child: infoReceta['recPerCelularPropietario']!.isEmpty
                  //           ? Text('--- --- --- ',
                  //               style: GoogleFonts.lexendDeca(
                  //                 // fontSize: size.iScreen(2.0),
                  //                 fontWeight: FontWeight.normal,
                  //               ))
                  //           : Wrap(
                  //               children:
                  //                   (infoReceta['recPerCelularPropietario']! as List)
                  //                       .map(
                  //                         (e) =>  InkWell(
                  //                            onDoubleTap: () async {
                  //                 _callNumber(e);
                  //               },
                  //                           child: Row(
                  //                                                                 children: [
                  //                           Container(
                  //                             // width: size.wScreen(100.0),
                  //                             decoration: BoxDecoration(
                  //                                 color: Colors.grey.shade200,
                  //                                 borderRadius:
                  //                                     BorderRadius.circular(5.0)),
                  //                             margin: EdgeInsets.symmetric(
                  //                                 vertical: size.iScreen(0.3)),
                  //                             padding: EdgeInsets.symmetric(
                  //                                 horizontal: size.iScreen(1.0),
                  //                                 vertical: size.iScreen(0.5)),
                  //                             child: Text('$e',
                  //                                 style: GoogleFonts.lexendDeca(
                  //                                     fontSize: size.iScreen(1.7),
                  //                                     fontWeight:
                  //                                         FontWeight.normal,
                  //                                     color: Colors.black)),
                  //                           ),
                                          
                  //                           //***********************************************/
                  //                           SizedBox(
                  //                             width: size.iScreen(3.0),
                  //                           ),
                  //                           //*****************************************/
                  //                           Icon(
                  //                             Icons.phone_forwarded_outlined,
                  //                             size: size.iScreen(3.0),
                  //                             color: primaryColor,
                  //                           )
                  //                                                                 ],
                  //                                                               ),
                  //                         ),
                                          
                  //                         // Text('$e',
                  //                         //     style: GoogleFonts.lexendDeca(
                  //                         //         // fontSize: size.iScreen(2.0),
                  //                         //         fontWeight: FontWeight.normal,
                  //                         //         color: Colors.black)),
                  //                       )
                  //                       .toList()),
                  // ),
                  // //*****************************************/
                  // SizedBox(
                  //   height: size.iScreen(0.0),
                  // ),
                  // //         //==========================================//
                  //   SizedBox(
                  //       width: size.wScreen(100.0),
                  //       // color: Colors.blue,
                  //       child: Text('Correo:',
                  //           style: GoogleFonts.lexendDeca(
                  //               // fontSize: size.iScreen(2.0),
                  //               fontWeight: FontWeight.normal,
                  //               color: Colors.grey)),
                  // ),
                  // Container(
                  //   margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                  //   width: size.wScreen(100.0),
                  //   child: infoReceta['recPerEmailPropietario']!.isEmpty
                  //           ? Text('--- --- --- ',
                  //               style: GoogleFonts.lexendDeca(
                  //                 // fontSize: size.iScreen(2.0),
                  //                 fontWeight: FontWeight.normal,
                  //               ))
                  //           : 
                  //                                      Wrap(
                  //               children:
                  //                   (infoReceta['recPerEmailPropietario']! as List)
                  //                       .map(
                  //                         (e) => Text('$e',
                  //                             style: GoogleFonts.lexendDeca(
                  //                                 // fontSize: size.iScreen(2.0),
                  //                                 fontWeight: FontWeight.normal,
                  //                                 color: Colors.black)),
                  //                       )
                  //                       .toList()),
                  // ),
                  // //*****************************************/
                  // SizedBox(
                  //   height: size.iScreen(1.0),
                  // ),
                  // //         //==========================================//
                  //   Container(
                  //   padding: EdgeInsets.symmetric(vertical:size.iScreen(1.0),horizontal:size.iScreen(1.0)),
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
                 
                  //  //*****************************************/
                  // SizedBox(
                  //   height: size.iScreen(0.0),
                  // ),
                  // //         //==========================================//
                  //   Row(
                  //     children: [
                  //       SizedBox(
                  //       // width: size.wScreen(100.0),
                  //       // color: Colors.blue,
                  //       child: Text('Próxima Cita:',
                  //           style: GoogleFonts.lexendDeca(
                  //               // fontSize: size.iScreen(2.0),
                  //               fontWeight: FontWeight.normal,
                  //               color: Colors.grey)),
                  // ),
                  //   Container(
                  //   margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5), horizontal: size.iScreen(1.5)),
                  //   // width: size.wScreen(100.0),
                  //   child: Text(
                  //     '${infoReceta['recProxCita'].replaceAll('T',"  ")}',
                  //     style: GoogleFonts.lexendDeca(
                  //         fontSize: size.iScreen(1.8),
                  //         // color: Colors.white,
                  //         fontWeight: FontWeight.normal),
                  //   ),
                  // ),
                  //     ],
                  //   ),
                
              ],) ,
            )));
  }
   _callNumber(String numero) async {
    await FlutterPhoneDirectCaller.callNumber(numero);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neitorcont/src/controllers/mascotas_controller.dart';
import 'package:neitorcont/src/controllers/propietarios_controller.dart';
import 'package:neitorcont/src/utils/responsive.dart';
import 'package:neitorcont/src/utils/theme.dart';
import 'package:provider/provider.dart';

class DetalleMascotas extends StatelessWidget {
  const DetalleMascotas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final infoMascota = context.read<MascotasController>().infoMascota;
    final Responsive size = Responsive.of(context);
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title:  Text('Detalle del Mascota'),
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
                  SizedBox(
                    height: size.iScreen(1.0),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(size.iScreen(2.0)),
                    child: Container(
                      width: size.wScreen(100),
                      // height: size.hScreen(30.0),
                      child: infoMascota['mascFoto'] != ''
                          ? FadeInImage.assetNetwork(
                              // fit: BoxFit.fitHeight,
                              placeholder: 'assets/imgs/loading.gif',
                              image: infoMascota[
                                  'mascFoto'], //'https://picsum.photos/id/237/500/300',
                            )
                          : Image.asset('assets/imgs/no-photo.png'),
                    ),
                  ),

                  //*****************************************/
                  Container(
                    width: size.wScreen(100.0),
                    height: size.hScreen(6.0),
                    // color: Colors.red,
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: size.iScreen(0.3)),
                          child: Chip(
                            label: Text(
                              'Vacuna',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(1.8),
                                  // color: Colors.white,
                                  fontWeight: FontWeight.normal),
                            ),
                            avatar: Container(
                               margin: EdgeInsets.only(left: size.iScreen(0.5)),
                              decoration: BoxDecoration(
                                // color: primaryColor,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: primaryColor,
                                  width: size.iScreen(0.2),
                                ),
                              ),
                              width: size.iScreen(3),
                              height: size.iScreen(3),
                              alignment: Alignment.center,
                              child: Text(
                                '0',
                                style: TextStyle(
                                    // fontSize: size.iScreen(50),
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: size.iScreen(0.3),
                          ),
                          child: Chip(
                              label: Text(
                            'Historia Clínica',
                            style: GoogleFonts.lexendDeca(
                                // fontSize: size.iScreen(1.8),
                                // color: Colors.white,
                                fontWeight: FontWeight.normal),
                          ), avatar: Container(
                             margin: EdgeInsets.only(left: size.iScreen(0.5)),
                              decoration: BoxDecoration(
                                // color: primaryColor,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: primaryColor,
                                  width: size.iScreen(0.2),
                                ),
                              ),
                              width: size.iScreen(3),
                              height: size.iScreen(3),
                              alignment: Alignment.center,
                              child: Text(
                                '3',
                                style: TextStyle(
                                    // fontSize: size.iScreen(50),
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: size.iScreen(0.3),
                          ),
                          child: Chip(
                              label: Text(
                            'Peluquería',
                            style: GoogleFonts.lexendDeca(
                                // fontSize: size.iScreen(1.8),
                                // color: Colors.white,
                                fontWeight: FontWeight.normal),
                          ), avatar: Container(
                            margin: EdgeInsets.only(left: size.iScreen(0.5)),
                              decoration: BoxDecoration(
                                // color: primaryColor,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: primaryColor,
                                  width: size.iScreen(0.2),
                                ),
                              ),
                              width: size.iScreen(3),
                              height: size.iScreen(3),
                              alignment: Alignment.center,
                              child: Text(
                                '6',
                                style: TextStyle(
                                    // fontSize: size.iScreen(50),
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: size.iScreen(0.3),
                          ),
                          child: Chip(
                              label: Text(
                            'Receta',
                            style: GoogleFonts.lexendDeca(
                                // fontSize: size.iScreen(1.8),
                                // color: Colors.white,
                                fontWeight: FontWeight.normal),
                          ), avatar: Container(
                            margin: EdgeInsets.only(left: size.iScreen(0.5)),
                              decoration: BoxDecoration(
                                // color: primaryColor,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: primaryColor,
                                  width: size.iScreen(0.2),
                                ),
                              ),
                              width: size.iScreen(3),
                              height: size.iScreen(3),
                              alignment: Alignment.center,
                              child: Text(
                                '6',
                                style: TextStyle(
                                    // fontSize: size.iScreen(50),
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),),
                        ),
                      ],
                    ),
                  ),
                  //*****************************************/

                  //         //==========================================//
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Row(
                  //       children: [
                  //         SizedBox(
                  //           // width: size.wScreen(100.0),
                  //           // color: Colors.blue,
                  //           child: Text('${infoMascota['perDocTipo']} : ',
                  //               style: GoogleFonts.lexendDeca(
                  //                   // fontSize: size.iScreen(2.0),
                  //                   fontWeight: FontWeight.normal,
                  //                   color: Colors.grey)),
                  //         ),
                  //         Container(
                  //           margin: EdgeInsets.symmetric(
                  //               vertical: size.iScreen(0.5)),
                  //           // width: size.wScreen(100.0),
                  //           child: Text(
                  //             '${infoMascota['perDocNumero']}',
                  //             style: GoogleFonts.lexendDeca(
                  //                 fontSize: size.iScreen(1.8),
                  //                 // color: Colors.white,
                  //                 fontWeight: FontWeight.normal),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //     Row(
                  //       children: [
                  //         SizedBox(
                  //           // width: size.wScreen(100.0),
                  //           // color: Colors.blue,
                  //           child: Text('Género : ',
                  //               style: GoogleFonts.lexendDeca(
                  //                   // fontSize: size.iScreen(2.0),
                  //                   fontWeight: FontWeight.normal,
                  //                   color: Colors.grey)),
                  //         ),
                  //         Container(
                  //           margin: EdgeInsets.symmetric(
                  //               vertical: size.iScreen(0.5)),
                  //           // width: size.wScreen(100.0),
                  //           child: Text(
                  //             infoMascota['perGenero']=='M'
                  //             ? 'MASCULINO':'FEMENINO',
                  //             style: GoogleFonts.lexendDeca(
                  //                 fontSize: size.iScreen(1.8),
                  //                 // color: Colors.white,
                  //                 fontWeight: FontWeight.normal),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ],
                  // ),

                  //*****************************************/

                  SizedBox(
                    height: size.iScreen(1.0),
                  ),
                  //         //==========================================//
                  SizedBox(
                    width: size.wScreen(100.0),
                    // color: Colors.blue,
                    child: Text('Nombre',
                        style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.normal,
                            color: Colors.grey)),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                    width: size.wScreen(100.0),
                    child: Text(
                      '${infoMascota['mascNombre']}',
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: size.wScreen(40.0),
                            // color: Colors.blue,
                            child: Text('Sexo',
                                style: GoogleFonts.lexendDeca(
                                    // fontSize: size.iScreen(2.0),
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey)),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: size.iScreen(0.5)),
                            width: size.wScreen(40.0),
                            child: Text(
                              '${infoMascota['mascSexo']}',
                              style: GoogleFonts.lexendDeca(
                                  fontSize: size.iScreen(1.8),
                                  // color: Colors.white,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            width: size.wScreen(40.0),
                            // color: Colors.blue,
                            child: Text('Color',
                                style: GoogleFonts.lexendDeca(
                                    // fontSize: size.iScreen(2.0),
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey)),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: size.iScreen(0.5)),
                            width: size.wScreen(40.0),
                            child: Text(
                              '${infoMascota['mascColor']}',
                              style: GoogleFonts.lexendDeca(
                                  fontSize: size.iScreen(1.8),
                                  // color: Colors.white,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ],
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
                        child: Text('Fecha de nacimiento: ',
                            style: GoogleFonts.lexendDeca(
                                // fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                        // width: size.wScreen(100.0),
                        child: Text(
                          ' ${infoMascota['mascFechaNacimiento']}',
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
                        child: Text('Edad: ',
                            style: GoogleFonts.lexendDeca(
                                // fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                        // width: size.wScreen(100.0),
                        child: Text(
                          ' ${infoMascota['mascEdad']}',
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: size.wScreen(40.0),
                            // color: Colors.blue,
                            child: Text('Especie',
                                style: GoogleFonts.lexendDeca(
                                    // fontSize: size.iScreen(2.0),
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey)),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: size.iScreen(0.5)),
                            width: size.wScreen(40.0),
                            child: Text(
                              '${infoMascota['mascEspecie']}',
                              style: GoogleFonts.lexendDeca(
                                  fontSize: size.iScreen(1.8),
                                  // color: Colors.white,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            width: size.wScreen(40.0),
                            // color: Colors.blue,
                            child: Text('Raza',
                                style: GoogleFonts.lexendDeca(
                                    // fontSize: size.iScreen(2.0),
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey)),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: size.iScreen(0.5)),
                            width: size.wScreen(40.0),
                            child: Text(
                              '${infoMascota['mascRaza']}',
                              style: GoogleFonts.lexendDeca(
                                  fontSize: size.iScreen(1.8),
                                  // color: Colors.white,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  //*****************************************/

                  SizedBox(
                    height: size.iScreen(0.0),
                  ),
                  //         //==========================================//
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: size.wScreen(40.0),
                            // color: Colors.blue,
                            child: Text('Alimento',
                                style: GoogleFonts.lexendDeca(
                                    // fontSize: size.iScreen(2.0),
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey)),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: size.iScreen(0.5)),
                            width: size.wScreen(40.0),
                            child: Text(
                              '${infoMascota['mascAlimento']}',
                              style: GoogleFonts.lexendDeca(
                                  fontSize: size.iScreen(1.8),
                                  // color: Colors.white,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            width: size.wScreen(40.0),
                            // color: Colors.blue,
                            child: Text('Tipo Alimento',
                                style: GoogleFonts.lexendDeca(
                                    // fontSize: size.iScreen(2.0),
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey)),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: size.iScreen(0.5)),
                            width: size.wScreen(40.0),
                            child: Text(
                              '${infoMascota['mascTipoAlimento']}',
                              style: GoogleFonts.lexendDeca(
                                  fontSize: size.iScreen(1.8),
                                  // color: Colors.white,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ],
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
                    child: Text('Caracter',
                        style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.normal,
                            color: Colors.grey)),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                    width: size.wScreen(100.0),
                    child: Text(
                      infoMascota['mascCaracter'] != ''
                          ? '${infoMascota['mascCaracter']}'
                          : 'No definido',
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
                    child: Text('Observación',
                        style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.normal,
                            color: Colors.grey)),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                    width: size.wScreen(100.0),
                    child: Text(
                      infoMascota['mascObservacion'] != ''
                          ? '${infoMascota['mascObservacion']}'
                          : 'ninguna',
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
                    child: Text('Propietario',
                        style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.normal,
                            color: Colors.grey)),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                    width: size.wScreen(100.0),
                    child: Text(
                      '${infoMascota['mascPerNombre']}',
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
                  //     '${infoProveedor['perDireccion']}',
                  //     style: GoogleFonts.lexendDeca(
                  //         fontSize: size.iScreen(1.8),
                  //         // color: Colors.white,
                  //         fontWeight: FontWeight.normal),
                  //   ),
                  // ),
                  //*****************************************/

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
                  //     '${infoProveedor['perDireccion']}',
                  //     style: GoogleFonts.lexendDeca(
                  //         fontSize: size.iScreen(1.8),
                  //         // color: Colors.white,
                  //         fontWeight: FontWeight.normal),
                  //   ),
                  // ),
                  //*****************************************/

                  // SizedBox(
                  //   height: size.iScreen(0.0),
                  // ),
                  // //         //==========================================//
                  // SizedBox(
                  //   width: size.wScreen(100.0),
                  //   // color: Colors.blue,
                  //   child: Text('Telefono:',
                  //       style: GoogleFonts.lexendDeca(
                  //           // fontSize: size.iScreen(2.0),
                  //           fontWeight: FontWeight.normal,
                  //           color: Colors.grey)),
                  // ),
                  // Container(
                  //   margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                  //   width: size.wScreen(100.0),
                  //   child: InkWell(
                  //     onDoubleTap: (() =>
                  //         _callNumber(infoProveedor['perTelefono'])),
                  //     child: Row(
                  //       children: [
                  //         Text(
                  //           '${infoProveedor['perTelefono']}',
                  //           style: GoogleFonts.lexendDeca(
                  //               fontSize: size.iScreen(1.8),
                  //               // color: Colors.white,
                  //               fontWeight: FontWeight.normal),
                  //         ),
                  //         //***********************************************/
                  //         SizedBox(
                  //           width: size.iScreen(3.0),
                  //         ),
                  //         //*****************************************/
                  //         Icon(
                  //           Icons.phone_forwarded_outlined,
                  //           size: size.iScreen(3.0),
                  //           color: primaryColor,
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // //*****************************************/

                  SizedBox(
                    height: size.iScreen(0.0),
                  ),
                  //         //==========================================//
                  // SizedBox(
                  //   width: size.wScreen(100.0),
                  //   // color: Colors.blue,
                  //   child: Text('Contacto Extra :',
                  //       style: GoogleFonts.lexendDeca(
                  //           // fontSize: size.iScreen(2.0),
                  //           fontWeight: FontWeight.normal,
                  //           color: Colors.grey)),
                  // ),
                  //==========================================//
                  infoMascota['mascContactoExtra'].isNotEmpty
                      ? Container(
                          padding: EdgeInsets.symmetric(
                              vertical: size.iScreen(1.0),
                              horizontal: size.iScreen(0.5)),
                          width: size.wScreen(100.0),
                          color: Colors.grey[200],
                          child: Text('Contacto Extra ',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey)),
                        )
                      : Container(),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                      width: size.wScreen(100.0),
                      child: Wrap(
                        children: (infoMascota['mascContactoExtra'] as List)
                            .map(
                              (e) => InkWell(
                                onDoubleTap: () async {
                                  _callNumber(e);
                                },
                                child: Container(
                                  width: size.wScreen(100.0),
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: size.iScreen(0.5)),
                                        width: size.wScreen(100.0),
                                        child: Column(
                                          children: [
                                            Container(
                                              width: size.wScreen(100.0),
                                              // color: Colors.blue,
                                              child: Text('Nombre:',
                                                  style: GoogleFonts.lexendDeca(
                                                      // fontSize: size.iScreen(2.0),
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.grey)),
                                            ),
                                            Container(
                                              width: size.wScreen(100.0),
                                              child: Text(
                                                '${e['nombre']}',
                                                style: GoogleFonts.lexendDeca(
                                                    fontSize: size.iScreen(1.8),
                                                    // color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // //*****************************************/

                                      SizedBox(
                                        height: size.iScreen(0.5),
                                      ),
                                      //         //==========================================//
                                      Container(
                                        width: size.wScreen(100.0),
                                        child: Text(
                                          '${e['correo']}',
                                          style: GoogleFonts.lexendDeca(
                                              fontSize: size.iScreen(1.8),
                                              // color: Colors.white,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                      // //*****************************************/

                                      SizedBox(
                                        height: size.iScreen(1.0),
                                      ),
                                      //         //==========================================//
                                      Row(
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
                                            child: Text('${e['celular']}',
                                                style: GoogleFonts.lexendDeca(
                                                    fontSize: size.iScreen(1.7),
                                                    fontWeight:
                                                        FontWeight.normal,
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
                                    ],
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      )),
                  // //*****************************************/
                ],
              ),
            ),
          )),
    );
  }

  _callNumber(String numero) async {
    await FlutterPhoneDirectCaller.callNumber(numero);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neitorcont/src/controllers/propietarios_controller.dart';
import 'package:neitorcont/src/utils/responsive.dart';
import 'package:neitorcont/src/utils/theme.dart';
import 'package:provider/provider.dart';

class DetallePropietarioPage extends StatelessWidget {
  const DetallePropietarioPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final infoProveedor =
        context.read<PropietariosController>().infoPropietario;
    final Responsive size = Responsive.of(context);
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title:  Text('Detalle del Propietario',style:  Theme.of(context).textTheme.headline2,),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            // width: size.wScreen(100.0),
                            // color: Colors.blue,
                            child: Text('${infoProveedor['perDocTipo']} : ',
                                style: GoogleFonts.lexendDeca(
                                    // fontSize: size.iScreen(2.0),
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey)),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: size.iScreen(0.5)),
                            // width: size.wScreen(100.0),
                            child: Text(
                              '${infoProveedor['perDocNumero']}',
                              style: GoogleFonts.lexendDeca(
                                  fontSize: size.iScreen(1.8),
                                  // color: Colors.white,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            // width: size.wScreen(100.0),
                            // color: Colors.blue,
                            child: Text('Género : ',
                                style: GoogleFonts.lexendDeca(
                                    // fontSize: size.iScreen(2.0),
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey)),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: size.iScreen(0.5)),
                            // width: size.wScreen(100.0),
                            child: Text(
                              infoProveedor['perGenero']=='M'
                              ? 'MASCULINO':'FEMENINO',
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
                    child: Text('Nombre:',
                        style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.normal,
                            color: Colors.grey)),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                    width: size.wScreen(100.0),
                    child: Text(
                      '${infoProveedor['perNombre']}',
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

                  SizedBox(
                    height: size.iScreen(0.0),
                  ),
                  //         //==========================================//
                  SizedBox(
                    width: size.wScreen(100.0),
                    // color: Colors.blue,
                    child: Text('Telefono:',
                        style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.normal,
                            color: Colors.grey)),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                    width: size.wScreen(100.0),
                    child: InkWell(
                      onDoubleTap: (() =>
                          _callNumber(infoProveedor['perTelefono'])),
                      child: Row(
                        children: [
                          Text(
                            '${infoProveedor['perTelefono']}',
                            style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(1.8),
                                // color: Colors.white,
                                fontWeight: FontWeight.normal),
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
                  ),
                  //*****************************************/

                  SizedBox(
                    height: size.iScreen(0.0),
                  ),
                  //         //==========================================//
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
                      child: Wrap(
                        children: (infoProveedor['perCelular'] as List)
                            .map(
                              (e) => InkWell(
                                onDoubleTap: () async {
                                  _callNumber(e);
                                },
                                child: Container(
                                  width: size.wScreen(100.0),
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
                              ),
                            )
                            .toList(),
                      )
                      // Text(
                      //   '${infoProveedor['perCelular']}',
                      //   style: GoogleFonts.lexendDeca(
                      //       fontSize: size.iScreen(1.8),
                      //       // color: Colors.white,
                      //       fontWeight: FontWeight.normal),
                      // ),
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
                      child: Wrap(
                        children: (infoProveedor['perEmail'] as List)
                            .map(
                              (e) => Container(
                                width: size.wScreen(100.0),
                                child: Container(
                                  // width: size.wScreen(100.0),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(5.0)),
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
                              ),
                            )
                            .toList(),
                      )
                      // Text(
                      //   '${infoProveedor['perCelular']}',
                      //   style: GoogleFonts.lexendDeca(
                      //       fontSize: size.iScreen(1.8),
                      //       // color: Colors.white,
                      //       fontWeight: FontWeight.normal),
                      // ),
                      ),
                  //*****************************************/

                  SizedBox(
                    height: size.iScreen(0.0),
                  ),
                  //         //==========================================//
                  SizedBox(
                    width: size.wScreen(100.0),
                    // color: Colors.blue,
                    child: Text('Correos:',
                        style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.normal,
                            color: Colors.grey)),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                    width: size.wScreen(100.0),
                    child: Text(
                      '${infoProveedor['perDireccion']}',
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
                    child: Text('Recomendación:',
                        style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.normal,
                            color: Colors.grey)),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                    width: size.wScreen(100.0),
                    child: Text(
                      '${infoProveedor['perRecomendacion']}',
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
                      '${infoProveedor['perObsevacion']}',
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
                    child: Text('Transacciones:',
                        style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.normal,
                            color: Colors.grey)),
                  ),
                  //*****************************************/

                  SizedBox(
                    height: size.iScreen(1.0),
                  ),
                  //==========================================//

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
                              'Facturas',
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
                            'PreFacturas',
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
                            'Proformas',
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
                            'Notas Crédito',
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

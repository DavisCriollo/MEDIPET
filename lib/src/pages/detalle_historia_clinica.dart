import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neitorcont/src/controllers/historia_clinica.controller.dart';
import 'package:neitorcont/src/utils/responsive.dart';
import 'package:provider/provider.dart';


class DetalleHistoriaClinica extends StatelessWidget {
  const DetalleHistoriaClinica({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
        final Responsive size = Responsive.of(context);
      final infohistoria = context.read<HistoriaClinicaController>().getInfoHistoriaClinica;
    return Scaffold(
        appBar: AppBar(
          title:  Text('Detalle de Historia Clínica'),
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
                //==========================================//
                   SizedBox(
                    height: size.iScreen(1.0),
                  ),
                //==========================================//
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: size.iScreen(1.0),
                        horizontal: size.iScreen(0.5)),
                    width: size.wScreen(100.0),
                    color: Colors.grey[200],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text( 'Paciente:',
                            style: GoogleFonts.lexendDeca(
                                // fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                        Text( '${infohistoria['hcliFecha']}',
                            style: GoogleFonts.lexendDeca(
                                // fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                    width: size.wScreen(100.0),
                    child: Text(
                      '${infohistoria['hcliMascNombre']}',
                      style: GoogleFonts.lexendDeca(
                          fontSize: size.iScreen(1.8),
                          // color: Colors.white,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
              

                //==========================================//
                   SizedBox(
                    height: size.iScreen(1.0),
                  ),
               // ==========================================//
                  
                  SizedBox(
                    width: size.wScreen(100.0),
                    // color: Colors.blue,
                    child: Text('Motivo',
                        style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.normal,
                            color: Colors.grey)),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                    width: size.wScreen(100.0),
                    child: Text(
                      '${infohistoria['hcliMotiConsulMedica']}',
                      style: GoogleFonts.lexendDeca(
                          fontSize: size.iScreen(1.8),
                          // color: Colors.white,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                //==========================================//
                   SizedBox(
                    height: size.iScreen(1.0),
                  ),
               // ==========================================//
                  
                  SizedBox(
                    width: size.wScreen(100.0),
                    // color: Colors.blue,
                    child: Text('Veterinario',
                        style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.normal,
                            color: Colors.grey)),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                    width: size.wScreen(100.0),
                    child: Text(
                      '${infohistoria['hcliPerNombreVetInt']}',
                      style: GoogleFonts.lexendDeca(
                          fontSize: size.iScreen(1.8),
                          // color: Colors.white,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                //==========================================//
                   SizedBox(
                    height: size.iScreen(1.0),
                  ),
               // ==========================================//
                  
                  SizedBox(
                    width: size.wScreen(100.0),
                    // color: Colors.blue,
                    child: Text('Descripción',
                        style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.normal,
                            color: Colors.grey)),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                    width: size.wScreen(100.0),
                    child: Text(
                      '${infohistoria['hcliDescripcion']}',
                      style: GoogleFonts.lexendDeca(
                          fontSize: size.iScreen(1.8),
                          // color: Colors.white,
                          fontWeight: FontWeight.normal),
                    ),
                  ),

//==========================================//
                   SizedBox(
                    height: size.iScreen(1.0),
                  ),
                //==========================================//
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: size.iScreen(1.0),
                        horizontal: size.iScreen(0.5)),
                    width: size.wScreen(100.0),
                    color: Colors.grey[200],
                    child: Text( 'CHECK 1 ',
                        style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.normal,
                            color: Colors.grey)),
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
                        child: Text('Peso Kg:',
                            style: GoogleFonts.lexendDeca(
                                // fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: size.iScreen(0.5),
                            horizontal: size.iScreen(1.5)),
                        // width: size.wScreen(100.0),
                        child: Text(
                          '${infohistoria['hcliPeso']}',
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
                        child: Text('Temperatura:',
                            style: GoogleFonts.lexendDeca(
                                // fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: size.iScreen(0.5),
                            horizontal: size.iScreen(1.5)),
                        // width: size.wScreen(100.0),
                        child: Text(
                          '${infohistoria['hcliTemperatura']}',
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
                        child: Text('Hidratación:',
                            style: GoogleFonts.lexendDeca(
                                // fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: size.iScreen(0.5),
                            horizontal: size.iScreen(1.5)),
                        // width: size.wScreen(100.0),
                        child: Text(
                          '${infohistoria['hcliHidratacion']}',
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
                        child: Text('Frecuencia Cardiaca:',
                            style: GoogleFonts.lexendDeca(
                                // fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: size.iScreen(0.5),
                            horizontal: size.iScreen(1.5)),
                        // width: size.wScreen(100.0),
                        child: Text(
                          '${infohistoria['hcliFrecuCardiaca']}',
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
                        child: Text('Pulso:',
                            style: GoogleFonts.lexendDeca(
                                // fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: size.iScreen(0.5),
                            horizontal: size.iScreen(1.5)),
                        // width: size.wScreen(100.0),
                        child: Text(
                          '${infohistoria['hcliPulso']}',
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
                        child: Text('Frecuencia Respiratoria:',
                            style: GoogleFonts.lexendDeca(
                                // fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: size.iScreen(0.5),
                            horizontal: size.iScreen(1.5)),
                        // width: size.wScreen(100.0),
                        child: Text(
                          '${infohistoria['hcliFrecuRespiratoria']}',
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
                        child: Text('General:',
                            style: GoogleFonts.lexendDeca(
                                // fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: size.iScreen(0.5),
                            horizontal: size.iScreen(1.5)),
                        // width: size.wScreen(100.0),
                        child: Text(
                          '${infohistoria['hcliGeneral']}',
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
                        child: Text('Foong:',
                            style: GoogleFonts.lexendDeca(
                                // fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: size.iScreen(0.5),
                            horizontal: size.iScreen(1.5)),
                        // width: size.wScreen(100.0),
                        child: Text(
                          '${infohistoria['hcliFoong']}',
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
                        child: Text('TP:',
                            style: GoogleFonts.lexendDeca(
                                // fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: size.iScreen(0.5),
                            horizontal: size.iScreen(1.5)),
                        // width: size.wScreen(100.0),
                        child: Text(
                          '${infohistoria['hcliTp']}',
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
                        child: Text('ME:',
                            style: GoogleFonts.lexendDeca(
                                // fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: size.iScreen(0.5),
                            horizontal: size.iScreen(1.5)),
                        // width: size.wScreen(100.0),
                        child: Text(
                          '${infohistoria['hcliMe']}',
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
                        child: Text('Cardio Vascular:',
                            style: GoogleFonts.lexendDeca(
                                // fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: size.iScreen(0.5),
                            horizontal: size.iScreen(1.5)),
                        // width: size.wScreen(100.0),
                        child: Text(
                          '${infohistoria['hcliCardioVascular']}',
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
                        child: Text('Respiratorio:',
                            style: GoogleFonts.lexendDeca(
                                // fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: size.iScreen(0.5),
                            horizontal: size.iScreen(1.5)),
                        // width: size.wScreen(100.0),
                        child: Text(
                          '${infohistoria['hcliRespiratorio']}',
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
                        child: Text('GastroIntestinal:',
                            style: GoogleFonts.lexendDeca(
                                // fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: size.iScreen(0.5),
                            horizontal: size.iScreen(1.5)),
                        // width: size.wScreen(100.0),
                        child: Text(
                          '${infohistoria['hcliGastroIntestinal']}',
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
                        child: Text('GR:',
                            style: GoogleFonts.lexendDeca(
                                // fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: size.iScreen(0.5),
                            horizontal: size.iScreen(1.5)),
                        // width: size.wScreen(100.0),
                        child: Text(
                          '${infohistoria['hcliGr']}',
                          style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.8),
                              // color: Colors.white,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ],
                  ),
//==========================================//
                   SizedBox(
                    height: size.iScreen(1.0),
                  ),
                //==========================================//
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: size.iScreen(1.0),
                        horizontal: size.iScreen(0.5)),
                    width: size.wScreen(100.0),
                    color: Colors.grey[200],
                    child: Text( 'CHECK 2 ',
                        style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.normal,
                            color: Colors.grey)),
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
                        child: Text('Neurológico:',
                            style: GoogleFonts.lexendDeca(
                                // fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: size.iScreen(0.5),
                            horizontal: size.iScreen(1.5)),
                        // width: size.wScreen(100.0),
                        child: Text(
                          '${infohistoria['hcliNeurologico']}',
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
                        child: Text('Linfático:',
                            style: GoogleFonts.lexendDeca(
                                // fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: size.iScreen(0.5),
                            horizontal: size.iScreen(1.5)),
                        // width: size.wScreen(100.0),
                        child: Text(
                          '${infohistoria['hcliLinfatico']}',
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
                        child: Text('Respiratorio:',
                            style: GoogleFonts.lexendDeca(
                                // fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: size.iScreen(0.5),
                            horizontal: size.iScreen(1.5)),
                        // width: size.wScreen(100.0),
                        child: Text(
                          '${infohistoria['hcliPatronRespiratorio']}',
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
                   //==========================================//
                  Row(
                    children: [
                      SizedBox(
                        // width: size.wScreen(100.0),
                        // color: Colors.blue,
                        child: Text('Glasgow Modificado:',
                            style: GoogleFonts.lexendDeca(
                                // fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: size.iScreen(0.5),
                            horizontal: size.iScreen(1.5)),
                        // width: size.wScreen(100.0),
                        child: Text(
                          '${infohistoria['hcliGlasgowModificado']}',
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
                   //==========================================//
                  Row(
                    children: [
                      SizedBox(
                        // width: size.wScreen(100.0),
                        // color: Colors.blue,
                        child: Text('Ritmo Cardiaco:',
                            style: GoogleFonts.lexendDeca(
                                // fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: size.iScreen(0.5),
                            horizontal: size.iScreen(1.5)),
                        // width: size.wScreen(100.0),
                        child: Text(
                          '${infohistoria['hcliRitmoCardiaco']}',
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
                   //==========================================//
                  Row(
                    children: [
                      SizedBox(
                        // width: size.wScreen(100.0),
                        // color: Colors.blue,
                        child: Text('Reflujo Pupilar:',
                            style: GoogleFonts.lexendDeca(
                                // fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: size.iScreen(0.5),
                            horizontal: size.iScreen(1.5)),
                        // width: size.wScreen(100.0),
                        child: Text(
                          '${infohistoria['hcliReflejoPupilar']}',
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
                   //==========================================//
                  Row(
                    children: [
                      SizedBox(
                        // width: size.wScreen(100.0),
                        // color: Colors.blue,
                        child: Text('Reflujo Tusigeno:',
                            style: GoogleFonts.lexendDeca(
                                // fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: size.iScreen(0.5),
                            horizontal: size.iScreen(1.5)),
                        // width: size.wScreen(100.0),
                        child: Text(
                          '${infohistoria['hcliReflejoTusigeno']}',
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
                   //==========================================//
                  Row(
                    children: [
                      SizedBox(
                        // width: size.wScreen(100.0),
                        // color: Colors.blue,
                        child: Text('Llenado Vascular:',
                            style: GoogleFonts.lexendDeca(
                                // fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: size.iScreen(0.5),
                            horizontal: size.iScreen(1.5)),
                        // width: size.wScreen(100.0),
                        child: Text(
                          '${infohistoria['hcliTLlenadoVascular']}',
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
                   //==========================================//
                  Row(
                    children: [
                      SizedBox(
                        // width: size.wScreen(100.0),
                        // color: Colors.blue,
                        child: Text('Color Mascota:',
                            style: GoogleFonts.lexendDeca(
                                // fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: size.iScreen(0.5),
                            horizontal: size.iScreen(1.5)),
                        // width: size.wScreen(100.0),
                        child: Text(
                          '${infohistoria['hcliColorMocosas']}',
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
                   //==========================================//
                  Row(
                    children: [
                      SizedBox(
                        // width: size.wScreen(100.0),
                        // color: Colors.blue,
                        child: Text('Amígdalas:',
                            style: GoogleFonts.lexendDeca(
                                // fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: size.iScreen(0.5),
                            horizontal: size.iScreen(1.5)),
                        // width: size.wScreen(100.0),
                        child: Text(
                          '${infohistoria['hcliAmigdalas']}',
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
                   //==========================================//
                  Row(
                    children: [
                      SizedBox(
                        // width: size.wScreen(100.0),
                        // color: Colors.blue,
                        child: Text('Dolor Paciente:',
                            style: GoogleFonts.lexendDeca(
                                // fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: size.iScreen(0.5),
                            horizontal: size.iScreen(1.5)),
                        // width: size.wScreen(100.0),
                        child: Text(
                          '${infohistoria['hcliDolorPaciente']}',
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
                   //==========================================//
                  Row(
                    children: [
                      SizedBox(
                        // width: size.wScreen(100.0),
                        // color: Colors.blue,
                        child: Text('Lesiones:',
                            style: GoogleFonts.lexendDeca(
                                // fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: size.iScreen(0.5),
                            horizontal: size.iScreen(1.5)),
                        // width: size.wScreen(100.0),
                        child: Text(
                          '${infohistoria['hcliLesiones']}',
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
                   //==========================================//
                  Row(
                    children: [
                      SizedBox(
                        // width: size.wScreen(100.0),
                        // color: Colors.blue,
                        child: Text('PAS/PAM/PAD:',
                            style: GoogleFonts.lexendDeca(
                                // fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: size.iScreen(0.5),
                            horizontal: size.iScreen(1.5)),
                        // width: size.wScreen(100.0),
                        child: Text(
                          '${infohistoria['hcliPasPamPad']}',
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
                   //==========================================//
                  Row(
                    children: [
                      SizedBox(
                        // width: size.wScreen(100.0),
                        // color: Colors.blue,
                        child: Text('Otros:',
                            style: GoogleFonts.lexendDeca(
                                // fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: size.iScreen(0.5),
                            horizontal: size.iScreen(1.5)),
                        // width: size.wScreen(100.0),
                        child: Text(
                          '${infohistoria['hcliOtros']}',
                          style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.8),
                              // color: Colors.white,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ],
                  ),
          
  //==========================================//
                   SizedBox(
                    height: size.iScreen(1.0),
                  ),
               // ==========================================//
                  
                  SizedBox(
                    width: size.wScreen(100.0),
                    // color: Colors.blue,
                    child: Text('Tratamiento',
                        style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.normal,
                            color: Colors.grey)),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                    width: size.wScreen(100.0),
                    child: Text(
                     '${infohistoria['hcliTratamiento']}',
                      style: GoogleFonts.lexendDeca(
                          fontSize: size.iScreen(1.8),
                          // color: Colors.white,
                          fontWeight: FontWeight.normal),
                    ),
                  ),



















                ],
              ),
            ),)
   );
  }
}
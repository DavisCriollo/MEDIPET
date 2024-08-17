import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neitorcont/src/controllers/peluqueria_controller.dart';
import 'package:neitorcont/src/utils/responsive.dart';
import 'package:provider/provider.dart';

class DetallePeluqueria extends StatelessWidget {
  const DetallePeluqueria({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final infoPeluqueria = context.read<PeluqueriaController>();
    final Responsive size = Responsive.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title:  Text('Detalle del Peluquería'),
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
                //***********************************************/
                SizedBox(
                  height: size.iScreen(1.5),
                ),
                //*****************************************/
                Container(
                  width: size.wScreen(100),
                  child: Text('Mascota ',
                      style: GoogleFonts.lexendDeca(
                          // fontSize: size.iScreen(2.0),
                          fontWeight: FontWeight.normal,
                          color: Colors.grey)),
                ),

                Container(
                  width: size.wScreen(100),
                  child: Text('${infoPeluqueria.getNombreMascota}',
                      style: GoogleFonts.lexendDeca(
                          // fontSize: size.iScreen(2.0),
                          fontWeight: FontWeight.normal,
                          color: infoPeluqueria.getNombreMascota!.isEmpty
                              ? Colors.grey
                              : Colors.black)),
                ),

                // //***********************************************/
                // SizedBox(
                //   height: size.iScreen(0.5),
                // ),
                // //*****************************************/
                // Container(
                //   width: size.wScreen(100),
                //   child: Text('Temperamento ',
                //       style: GoogleFonts.lexendDeca(
                //           // fontSize: size.iScreen(2.0),
                //           fontWeight: FontWeight.normal,
                //           color: Colors.grey)),
                // ),

                // Container(
                //   width: size.wScreen(100),
                //   child: Text('${infoPeluqueria.getTemperamentoMascota}',
                //       style: GoogleFonts.lexendDeca(
                //           // fontSize: size.iScreen(2.0),
                //           fontWeight: FontWeight.normal,
                //           color: infoPeluqueria.getNombreMascota!.isEmpty
                //               ? Colors.grey
                //               : Colors.black)),
                // ),
                Row(
                  children: [
                    Text(
                      'Temperamento: ',
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
                      // width: size.wScreen(100),
                      child: Text(
                          infoPeluqueria.getTemperamentoMascota != ''
                              ? '${infoPeluqueria.getTemperamentoMascota}'
                              : '--- --- ---',
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color:
                                  infoPeluqueria.getTemperamentoMascota!.isEmpty
                                      ? Colors.grey
                                      : Colors.black)),
                    ),
                  ],
                ),
                //***********************************************/
                SizedBox(
                  height: size.iScreen(0.5),
                ),
                //*****************************************/
                Container(
                  width: size.wScreen(100),
                  child: Text('Autorizado por: ',
                      style: GoogleFonts.lexendDeca(
                          // fontSize: size.iScreen(2.0),
                          fontWeight: FontWeight.normal,
                          color: Colors.grey)),
                ),

                Container(
                  width: size.wScreen(100),
                  child: Text(
                      infoPeluqueria.getAutorizadoPor != ''
                          ? '${infoPeluqueria.getAutorizadoPor}'
                          : '--- --- ---',
                      style: GoogleFonts.lexendDeca(
                          // fontSize: size.iScreen(2.0),
                          fontWeight: FontWeight.normal,
                          color: infoPeluqueria.getNombreMascota!.isEmpty
                              ? Colors.grey
                              : Colors.black)),
                ),
                //***********************************************/
                SizedBox(
                  height: size.iScreen(0.5),
                ),
                //*****************************************/
                Container(
                  width: size.wScreen(100),
                  child: Text('Doc. Responsable: ',
                      style: GoogleFonts.lexendDeca(
                          // fontSize: size.iScreen(2.0),
                          fontWeight: FontWeight.normal,
                          color: Colors.grey)),
                ),

                Container(
                  width: size.wScreen(100),
                  child: Text('${infoPeluqueria.getVetDoctorNombre}',
                      style: GoogleFonts.lexendDeca(
                          // fontSize: size.iScreen(2.0),
                          fontWeight: FontWeight.normal,
                          color: infoPeluqueria.getNombreMascota!.isEmpty
                              ? Colors.grey
                              : Colors.black)),
                ),
                //***********************************************/
                SizedBox(
                  height: size.iScreen(0.5),
                ),
                //*****************************************/
                Row(
                  children: [
                    Container(
                      // width: size.wScreen(100),
                      child: Text('Fecha: ',
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: Colors.grey)),
                    ),
                    Container(
                      // width: size.wScreen(100),
                      child: Text(
                          infoPeluqueria.getFecha != ''
                              ? '${infoPeluqueria.getFecha}'
                              : '--- --- ---',
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: infoPeluqueria.getNombreMascota!.isEmpty
                                  ? Colors.grey
                                  : Colors.black)),
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Turno : ',
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
                          // width: size.wScreen(100),
                          child: Text(
                              infoPeluqueria.getTurno != ''
                                  ? '${infoPeluqueria.getTurno}'
                                  : '--- --- ---',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color:
                                      infoPeluqueria.getNombreMascota!.isEmpty
                                          ? Colors.grey
                                          : Colors.black)),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'H.Ingreso',
                          style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(1.8),
                            color: Colors.black45,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: size.iScreen(1.0),
                        ),
                        Container(
                          // width: size.wScreen(100),
                          child: Text(
                              infoPeluqueria.getInputHoraIngreso != ''
                                  ? '${infoPeluqueria.getInputHoraIngreso}'
                                  : '--- --- ---',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color:
                                      infoPeluqueria.getNombreMascota!.isEmpty
                                          ? Colors.grey
                                          : Colors.black)),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'H.Salida',
                          style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(1.8),
                            color: Colors.black45,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: size.iScreen(1.0),
                        ),
                        Container(
                          // width: size.wScreen(100),
                          child: Text(
                              infoPeluqueria.getInputHoraSalida != ''
                                  ? '${infoPeluqueria.getInputHoraSalida}'
                                  : '--- --- ---',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color:
                                      infoPeluqueria.getNombreMascota!.isEmpty
                                          ? Colors.grey
                                          : Colors.black)),
                        ),
                      ],
                    ),
                  ],
                ),

                Row(
                  children: [
                    Text(
                      'Estado: ',
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
                      // width: size.wScreen(100),
                      child: Text(
                          infoPeluqueria.getEstadoCabello != ''
                              ? '${infoPeluqueria.getEstadoCabello}'
                              : '--- --- ---',
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: infoPeluqueria.getNombreMascota!.isEmpty
                                  ? Colors.grey
                                  : Colors.black)),
                    ),
                  ],
                ),
                //***********************************************/
                SizedBox(
                  height: size.iScreen(0.5),
                ),
                //*****************************************/
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Próxima Cita : ',
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
                          // width: size.wScreen(100),
                          child: Text(
                              infoPeluqueria.getInputfechaProximaCita != ''
                                  ? '${infoPeluqueria.getInputfechaProximaCita}   '
                                  : '--- --- ---   ',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color:
                                      infoPeluqueria.getNombreMascota!.isEmpty
                                          ? Colors.grey
                                          : Colors.black)),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          ' Hora',
                          style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(1.8),
                            color: Colors.black45,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: size.iScreen(1.0),
                        ),
                        Container(
                          // width: size.wScreen(100),
                          child: Text(
                              infoPeluqueria.getInputHoraProximaCita != ''
                                  ? ' ${infoPeluqueria.getInputHoraProximaCita}'
                                  : '  --- --- ---',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color:
                                      infoPeluqueria.getNombreMascota!.isEmpty
                                          ? Colors.grey
                                          : Colors.black)),
                        ),
                      ],
                    ),
                  ],
                ),
                 //***********************************************/
                SizedBox(
                  height: size.iScreen(1.0),
                ),
                //*****************************************/
                Row(
                  children: [
                    Text(
                      'Llamar 30 minutos antes: ',
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
                      // width: size.wScreen(100),
                      child: Text(
                          infoPeluqueria.getProcesoLlamar != ''
                              ? '${infoPeluqueria.getProcesoLlamar}'
                              : '--- --- ---',
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: infoPeluqueria.getNombreMascota!.isEmpty
                                  ? Colors.grey
                                  : Colors.black)),
                    ),
                  ],
                ),
                //***********************************************/
                SizedBox(
                  height: size.iScreen(1.5),
                ),
                //*****************************************/
                Container(
                  width: size.wScreen(100),
                  child: Text('Observación al ingresar Mascota ',
                      style: GoogleFonts.lexendDeca(
                          // fontSize: size.iScreen(2.0),
                          fontWeight: FontWeight.normal,
                          color: Colors.grey)),
                ),

                Container(
                  width: size.wScreen(100),
                  child: Text(
                      infoPeluqueria.getObservacionIngresoMascota != ''
                          ? '${infoPeluqueria.getObservacionIngresoMascota}'
                          : '--- --- ---',
                      style: GoogleFonts.lexendDeca(
                          // fontSize: size.iScreen(2.0),
                          fontWeight: FontWeight.normal,
                          color: infoPeluqueria.getNombreMascota!.isEmpty
                              ? Colors.grey
                              : Colors.black)),
                ),
                SizedBox(
                  height: size.iScreen(1.5),
                ),
                //         //==========================================//
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.iScreen(1.0),
                      vertical: size.iScreen(1.0)),
                  width: size.wScreen(100.0),
                  color: Colors.grey[300],
                  child: Text('PEDIDOS CLIENTE:',
                      style: GoogleFonts.lexendDeca(
                          // fontSize: size.iScreen(2.0),
                          fontWeight: FontWeight.normal,
                          color: Colors.grey)),
                ),
                //***********************************************/
                SizedBox(
                  height: size.iScreen(1.5),
                ),
                //*****************************************/
                Row(
                  children: [
                    Text(
                      'Cara: ',
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
                      // width: size.wScreen(100),
                      child: Text(
                          infoPeluqueria.getPedidoCara != ''
                              ? '${infoPeluqueria.getPedidoCara}'
                              : '--- --- ---',
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: infoPeluqueria.getNombreMascota!.isEmpty
                                  ? Colors.grey
                                  : Colors.black)),
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
                    Text(
                      'Copete: ',
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
                      // width: size.wScreen(100),
                      child: Text(
                          infoPeluqueria.getPedidoCopete != ''
                              ? '${infoPeluqueria.getPedidoCopete}'
                              : '--- --- ---',
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: infoPeluqueria.getNombreMascota!.isEmpty
                                  ? Colors.grey
                                  : Colors.black)),
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
                    Text(
                      'Bigotes: ',
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
                      // width: size.wScreen(100),
                      child: Text(
                          infoPeluqueria.getPedidoBigotes != ''
                              ? '${infoPeluqueria.getPedidoBigotes}'
                              : '--- --- ---',
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: infoPeluqueria.getNombreMascota!.isEmpty
                                  ? Colors.grey
                                  : Colors.black)),
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
                    Text(
                      'Cejas: ',
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
                      // width: size.wScreen(100),
                      child: Text(
                          infoPeluqueria.getPedidoCejas != ''
                              ? '${infoPeluqueria.getPedidoCejas}'
                              : '--- --- ---',
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: infoPeluqueria.getNombreMascota!.isEmpty
                                  ? Colors.grey
                                  : Colors.black)),
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
                    Text(
                      'Solo Lomo: ',
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
                      // width: size.wScreen(100),
                      child: Text(
                          infoPeluqueria.getPedidoSoloLomo != ''
                              ? '${infoPeluqueria.getPedidoSoloLomo}'
                              : '--- --- ---',
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: infoPeluqueria.getNombreMascota!.isEmpty
                                  ? Colors.grey
                                  : Colors.black)),
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
                    Text(
                      'Cola: ',
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
                      // width: size.wScreen(100),
                      child: Text(
                          infoPeluqueria.getPedidoCola != ''
                              ? '${infoPeluqueria.getPedidoCola}'
                              : '--- --- ---',
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: infoPeluqueria.getNombreMascota!.isEmpty
                                  ? Colors.grey
                                  : Colors.black)),
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
                    Text(
                      'Manos y patas: ',
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
                      // width: size.wScreen(100),
                      child: Text(
                          infoPeluqueria.getPedidoManosYPatas != ''
                              ? '${infoPeluqueria.getPedidoManosYPatas}'
                              : '--- --- ---',
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: infoPeluqueria.getNombreMascota!.isEmpty
                                  ? Colors.grey
                                  : Colors.black)),
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
                    Text(
                      'Forma de la Cabeza: ',
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
                      // width: size.wScreen(100),
                      child: Text(
                          infoPeluqueria.getPedidoFormaDeLaCabeza != ''
                              ? '${infoPeluqueria.getPedidoFormaDeLaCabeza}'
                              : '--- --- ---',
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: infoPeluqueria.getNombreMascota!.isEmpty
                                  ? Colors.grey
                                  : Colors.black)),
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
                    Text(
                      'Orejas: ',
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
                      // width: size.wScreen(100),
                      child: Text(
                          infoPeluqueria.getPedidoOrejas != ''
                              ? '${infoPeluqueria.getPedidoOrejas}'
                              : '--- --- ---',
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: infoPeluqueria.getNombreMascota!.isEmpty
                                  ? Colors.grey
                                  : Colors.black)),
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
                    Text(
                      'Bigotes Forma: ',
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
                      // width: size.wScreen(100),
                      child: Text(
                          infoPeluqueria.getPedidoBigotesForma != ''
                              ? '${infoPeluqueria.getPedidoBigotesForma}'
                              : '--- --- ---',
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: infoPeluqueria.getNombreMascota!.isEmpty
                                  ? Colors.grey
                                  : Colors.black)),
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
                    Text(
                      'Todo el Cuerpo: ',
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
                      // width: size.wScreen(100),
                      child: Text(
                          infoPeluqueria.getPedidoTodoElCuerpo != ''
                              ? '${infoPeluqueria.getPedidoTodoElCuerpo}'
                              : '--- --- ---',
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: infoPeluqueria.getNombreMascota!.isEmpty
                                  ? Colors.grey
                                  : Colors.black)),
                    ),
                  ],
                ),
                //***********************************************/
                SizedBox(
                  height: size.iScreen(1.5),
                ),
                //*****************************************/
                Container(
                    width: size.wScreen(100),
                  child: Text(
                    'Faldón-pecho-patitas: ',
                    style: GoogleFonts.lexendDeca(
                      // fontSize: size.iScreen(1.8),
                      color: Colors.black45,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                //*****************************************/
                SizedBox(
                  width: size.iScreen(1.0),
                ),
                //*****************************************/
                Container(
                  width: size.wScreen(100),
                  child: Text(
                      infoPeluqueria.getPedidoFaldonPechoPatitas != ''
                          ? '${infoPeluqueria.getPedidoFaldonPechoPatitas}'
                          : '--- --- ---',
                      style: GoogleFonts.lexendDeca(
                          // fontSize: size.iScreen(2.0),
                          fontWeight: FontWeight.normal,
                          color: infoPeluqueria.getNombreMascota!.isEmpty
                              ? Colors.grey
                              : Colors.black)),
                ),
                //***************************************************************************/

                SizedBox(
                  height: size.iScreen(1.5),
                ),
                //         //==========================================//
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.iScreen(1.0),
                      vertical: size.iScreen(1.0)),
                  width: size.wScreen(100.0),
                  color: Colors.grey[300],
                  child: Text('PROCESOS DE PELUQUERIA',
                      style: GoogleFonts.lexendDeca(
                          // fontSize: size.iScreen(2.0),
                          fontWeight: FontWeight.normal,
                          color: Colors.grey)),
                ),
                  //***********************************************/
                SizedBox(
                  height: size.iScreen(1.5),
                ),
                //*****************************************/
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Declaro haber pedido el corte al gusto de la veterinaria: ',
                        style: GoogleFonts.lexendDeca(
                          // fontSize: size.iScreen(1.8),
                          color: Colors.black45,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    //*****************************************/
                    SizedBox(
                      width: size.iScreen(1.0),
                    ),
                    //*****************************************/
                    Container(
                      // width: size.wScreen(100),
                      child: Text(
                          infoPeluqueria.getDeclaro != ''
                              ? '${infoPeluqueria.getDeclaro}'
                              : '--- --- ---',
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: infoPeluqueria.getNombreMascota!.isEmpty
                                  ? Colors.grey
                                  : Colors.black)),
                    ),
                  ],
                ),  //***********************************************/
                SizedBox(
                  height: size.iScreen(1.5),
                ),
                //*****************************************/
                Row(
                  children: [
                    Text(
                      'Oidos: ',
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
                      // width: size.wScreen(100),
                      child: Text(
                          infoPeluqueria.getProcesoOidos != ''
                              ? '${infoPeluqueria.getProcesoOidos}'
                              : '--- --- ---',
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: infoPeluqueria.getNombreMascota!.isEmpty
                                  ? Colors.grey
                                  : Colors.black)),
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
                    Text(
                      'Lavado de dientes: ',
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
                      // width: size.wScreen(100),
                      child: Text(
                          infoPeluqueria.getLavadoDientes != ''
                              ? '${infoPeluqueria.getLavadoDientes}'
                              : '--- --- ---',
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: infoPeluqueria.getNombreMascota!.isEmpty
                                  ? Colors.grey
                                  : Colors.black)),
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
                    Text(
                      'Uñas dedos supernumerarios: ',
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
                      // width: size.wScreen(100),
                      child: Text(
                          infoPeluqueria.getUniasDedos != ''
                              ? '${infoPeluqueria.getUniasDedos}'
                              : '--- --- ---',
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: infoPeluqueria.getNombreMascota!.isEmpty
                                  ? Colors.grey
                                  : Colors.black)),
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
                    Text(
                      'Drenaje G. Perinales: ',
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
                      // width: size.wScreen(100),
                      child: Text(
                          infoPeluqueria.getDrenaje != ''
                              ? '${infoPeluqueria.getDrenaje}'
                              : '--- --- ---',
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: infoPeluqueria.getNombreMascota!.isEmpty
                                  ? Colors.grey
                                  : Colors.black)),
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
                    Text(
                      'Secado: ',
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
                      // width: size.wScreen(100),
                      child: Text(
                          infoPeluqueria.getSecado != ''
                              ? '${infoPeluqueria.getSecado}'
                              : '--- --- ---',
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: infoPeluqueria.getNombreMascota!.isEmpty
                                  ? Colors.grey
                                  : Colors.black)),
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
                    Text(
                      'Perfume: ',
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
                      // width: size.wScreen(100),
                      child: Text(
                          infoPeluqueria.getPerfume != ''
                              ? '${infoPeluqueria.getPerfume}'
                              : '--- --- ---',
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: infoPeluqueria.getNombreMascota!.isEmpty
                                  ? Colors.grey
                                  : Colors.black)),
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
                    Text(
                      'Limpieza Ocular: ',
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
                      // width: size.wScreen(100),
                      child: Text(
                          infoPeluqueria.getLimpiezaOcular != ''
                              ? '${infoPeluqueria.getLimpiezaOcular}'
                              : '--- --- ---',
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: infoPeluqueria.getNombreMascota!.isEmpty
                                  ? Colors.grey
                                  : Colors.black)),
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
                    Text(
                      'Corte uñas: ',
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
                      // width: size.wScreen(100),
                      child: Text(
                          infoPeluqueria.getCorteUnias != ''
                              ? '${infoPeluqueria.getCorteUnias}'
                              : '--- --- ---',
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: infoPeluqueria.getNombreMascota!.isEmpty
                                  ? Colors.grey
                                  : Colors.black)),
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
                    Text(
                      'Rapado Genital: ',
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
                      // width: size.wScreen(100),
                      child: Text(
                          infoPeluqueria.getRapadoGenital != ''
                              ? '${infoPeluqueria.getRapadoGenital}'
                              : '--- --- ---',
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: infoPeluqueria.getNombreMascota!.isEmpty
                                  ? Colors.grey
                                  : Colors.black)),
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
                    Text(
                      'Baño: ',
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
                      // width: size.wScreen(100),
                      child: Text(
                          infoPeluqueria.getBanio != ''
                              ? '${infoPeluqueria.getBanio}'
                              : '--- --- ---',
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: infoPeluqueria.getNombreMascota!.isEmpty
                                  ? Colors.grey
                                  : Colors.black)),
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
                    Text(
                      'Corte y Acabados: ',
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
                      // width: size.wScreen(100),
                      child: Text(
                          infoPeluqueria.getCorteYAcabados != ''
                              ? '${infoPeluqueria.getCorteYAcabados}'
                              : '--- --- ---',
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: infoPeluqueria.getNombreMascota!.isEmpty
                                  ? Colors.grey
                                  : Colors.black)),
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
                    Text(
                      'Dos Lazos: ',
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
                      // width: size.wScreen(100),
                      child: Text(
                          infoPeluqueria.getDosLazos != ''
                              ? '${infoPeluqueria.getDosLazos}'
                              : '--- --- ---',
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: infoPeluqueria.getNombreMascota!.isEmpty
                                  ? Colors.grey
                                  : Colors.black)),
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
                    Text(
                      'Pañuelo: ',
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
                      // width: size.wScreen(100),
                      child: Text(
                          infoPeluqueria.getPanuelo!= ''
                              ? '${infoPeluqueria.getPanuelo}'
                              : '--- --- ---',
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: infoPeluqueria.getNombreMascota!.isEmpty
                                  ? Colors.grey
                                  : Colors.black)),
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
                    Text(
                      'Lazo Central: ',
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
                      // width: size.wScreen(100),
                      child: Text(
                          infoPeluqueria.getLazoCentral!= ''
                              ? '${infoPeluqueria.getLazoCentral}'
                              : '--- --- ---',
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: infoPeluqueria.getNombreMascota!.isEmpty
                                  ? Colors.grey
                                  : Colors.black)),
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
                    Text(
                      'Bufanda: ',
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
                      // width: size.wScreen(100),
                      child: Text(
                          infoPeluqueria.getBufanda!= ''
                              ? '${infoPeluqueria.getBufanda}'
                              : '--- --- ---',
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: infoPeluqueria.getNombreMascota!.isEmpty
                                  ? Colors.grey
                                  : Colors.black)),
                    ),
                  ],
                ),
                //***********************************************/
                SizedBox(
                  height: size.iScreen(1.5),
                ),
                //*****************************************/
                Container(
                  width: size.wScreen(100),
                  child: Text('Otros procesos',
                      style: GoogleFonts.lexendDeca(
                          // fontSize: size.iScreen(2.0),
                          fontWeight: FontWeight.normal,
                          color: Colors.grey)),
                ),
   //***********************************************//
                SizedBox(
                  height: size.iScreen(0.5),
                ),
                //***********************************************//
                Container(
                  width: size.wScreen(100),
                  child: Text(
                      infoPeluqueria.getOtrosProcesos != ''
                          ? '${infoPeluqueria.getOtrosProcesos}'
                          : '--- --- ---',
                      style: GoogleFonts.lexendDeca(
                          // fontSize: size.iScreen(2.0),
                          fontWeight: FontWeight.normal,
                          color: infoPeluqueria.getNombreMascota!.isEmpty
                              ? Colors.grey
                              : Colors.black)),
                ),
                //***************************************************************************/

                SizedBox(
                  height: size.iScreen(1.5),
                ),
                //         //==========================================//
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.iScreen(1.0),
                      vertical: size.iScreen(1.0)),
                  width: size.wScreen(100.0),
                  color: Colors.grey[300],
                  child: Text('ADICIONALES',
                      style: GoogleFonts.lexendDeca(
                          // fontSize: size.iScreen(2.0),
                          fontWeight: FontWeight.normal,
                          color: Colors.grey)),
                ),
                //***********************************************//
                SizedBox(
                  height: size.iScreen(0.5),
                ),
                //***********************************************//


                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'El cliente retira la mascota lista: ',
                        style: GoogleFonts.lexendDeca(
                          // fontSize: size.iScreen(1.8),
                          color: Colors.black45,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    //*****************************************/
                    SizedBox(
                      width: size.iScreen(1.0),
                    ),
                    //*****************************************/
                    Container(
                      // width: size.wScreen(100),
                      child: Text(
                          infoPeluqueria.getRetiraMascota != ''
                              ? '${infoPeluqueria.getRetiraMascota}'
                              : '--- --- ---',
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: infoPeluqueria.getNombreMascota!.isEmpty
                                  ? Colors.grey
                                  : Colors.black)),
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
                    Expanded(
                      child: Text(
                        'Deja carnet de vacunas: ',
                        style: GoogleFonts.lexendDeca(
                          // fontSize: size.iScreen(1.8),
                          color: Colors.black45,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    //*****************************************/
                    SizedBox(
                      width: size.iScreen(1.0),
                    ),
                    //*****************************************/
                    Container(
                      // width: size.wScreen(100),
                      child: Text(
                          infoPeluqueria.getDejaCarnet != ''
                              ? '${infoPeluqueria.getDejaCarnet}'
                              : '--- --- ---',
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: infoPeluqueria.getNombreMascota!.isEmpty
                                  ? Colors.grey
                                  : Colors.black)),
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
                    Expanded(
                      child: Text(
                        'Realizar en presencia del propietario o persona Autorizada : ',
                        style: GoogleFonts.lexendDeca(
                          // fontSize: size.iScreen(1.8),
                          color: Colors.black45,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    //*****************************************/
                    SizedBox(
                      width: size.iScreen(1.0),
                    ),
                    //*****************************************/
                    Container(
                      // width: size.wScreen(100),
                      child: Text(
                          infoPeluqueria.getPresenciaPropietario != ''
                              ? '${infoPeluqueria.getPresenciaPropietario}'
                              : '--- --- ---',
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: infoPeluqueria.getNombreMascota!.isEmpty
                                  ? Colors.grey
                                  : Colors.black)),
                    ),
                  ],
                ),
                 //***********************************************/
                SizedBox(
                  height: size.iScreen(0.5),
                ),
                //*****************************************/
                Container(
                  width: size.wScreen(100),
                  child: Text('Deja accesorios. Cuales?',
                      style: GoogleFonts.lexendDeca(
                          // fontSize: size.iScreen(2.0),
                          fontWeight: FontWeight.normal,
                          color: Colors.grey)),
                ),

                Container(
                  width: size.wScreen(100),
                  child: Text(
                      infoPeluqueria.getDejaAcesorios != ''
                          ? '${infoPeluqueria.getDejaAcesorios}'
                          : '--- --- ---',
                      style: GoogleFonts.lexendDeca(
                          // fontSize: size.iScreen(2.0),
                          fontWeight: FontWeight.normal,
                          color: infoPeluqueria.getNombreMascota!.isEmpty
                              ? Colors.grey
                              : Colors.black)),
                ),
              
                //*****************************************/
                SizedBox(
                  height: size.iScreen(1.5),
                ),
                //*****************************************/
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neitorcont/src/controllers/hospitalizacion_controller.dart';
import 'package:neitorcont/src/controllers/mascotas_controller.dart';
import 'package:neitorcont/src/controllers/propietarios_controller.dart';
import 'package:neitorcont/src/data_table/cabecera_alimento_hospitalizacion.dart';
import 'package:neitorcont/src/data_table/cabecera_medicina_hospitalizacion.dart';
import 'package:neitorcont/src/data_table/cabecera_parametros.hospitalizacion.dart';
import 'package:neitorcont/src/data_table/fluidos_hospitalizacion.dart';
import 'package:neitorcont/src/data_table/horario_alimentos_hospitalizacion.dart';
import 'package:neitorcont/src/data_table/horario_medicina_hospitalizacion.dart';
import 'package:neitorcont/src/data_table/horario_parametros_hospitalzacion.dart';
import 'package:neitorcont/src/data_table/infusion_hospitalizacion.dart';
import 'package:neitorcont/src/utils/responsive.dart';
import 'package:neitorcont/src/utils/theme.dart';
import 'package:neitorcont/src/widgets/no_data.dart';
import 'package:provider/provider.dart';

class DetalleHospitalizacion extends StatelessWidget {
  const DetalleHospitalizacion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final infoHospitalizacion = context.read<HospitalizacionController>().getInfohospitalizacion;
    final infoHospitalizacion = context.read<HospitalizacionController>();
    final Responsive size = Responsive.of(context);
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title:  Text('Detalle del Hospitalización',style:  Theme.of(context).textTheme.headline2,),
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

                  //*****************************************/

                  SizedBox(
                    height: size.iScreen(1.0),
                  ),
                  //         //==========================================//
                  SizedBox(
                    width: size.wScreen(100.0),
                    // color: Colors.blue,
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
                      infoHospitalizacion.getNombreMascota != ''
                          ? '${infoHospitalizacion.getNombreMascota}'
                          : '--- --- --- ',
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                              infoHospitalizacion.getRazaMascota != ''
                                  ? '${infoHospitalizacion.getRazaMascota}'
                                  : '--- --- --- ',
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
                              infoHospitalizacion.getSexoMascota != ''
                                  ? '${infoHospitalizacion.getSexoMascota}'
                                  : '--- --- --- ',
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
                  //==========================================//
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: size.wScreen(40.0),
                            // color: Colors.blue,
                            child: Text('Edad',
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
                              infoHospitalizacion.getEdadMascota != ''
                                  ? '${infoHospitalizacion.getEdadMascota}'
                                  : '--- --- --- ',
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
                            child: Text('Peso',
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
                              infoHospitalizacion.getPesoMascota != ''
                                  ? '${infoHospitalizacion.getPesoMascota} Kg.'
                                  : '--- --- --- ',
                              style: GoogleFonts.lexendDeca(
                                  fontSize: size.iScreen(1.8),
                                  // color: Colors.white,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ), //*****************************************/

                  Row(
                    children: [
                      Container(
                        // width: size.wScreen(40.0),
                        // color: Colors.blue,
                        child: Text('Estado ',
                            style: GoogleFonts.lexendDeca(
                                // fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                        width: size.wScreen(40.0),
                        child: Text(
                          infoHospitalizacion.getEstadoMascota != ''
                              ? '${infoHospitalizacion.getEstadoMascota}'
                              : '--- --- --- ',
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
                    height: size.iScreen(0.5),
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
                      infoHospitalizacion.getNombreMascota != ''
                          ? '${infoHospitalizacion.getNombreMascota}'
                          : '--- --- --- ',
                      style: GoogleFonts.lexendDeca(
                          fontSize: size.iScreen(1.8),
                          // color: Colors.white,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  //*****************************************/
                  SizedBox(
                    height: size.iScreen(0.5),
                  ),
                  //         //==========================================//
                  SizedBox(
                    width: size.wScreen(100.0),
                    // color: Colors.blue,
                    child: Text('Dr. General',
                        style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.normal,
                            color: Colors.grey)),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                    width: size.wScreen(100.0),
                    child: Text(
                      infoHospitalizacion.getVetDoctorNombre != ''
                          ? '${infoHospitalizacion.getVetDoctorNombre}'
                          : '--- --- --- ',
                      style: GoogleFonts.lexendDeca(
                          fontSize: size.iScreen(1.8),
                          // color: Colors.white,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  //*****************************************/
                  SizedBox(
                    height: size.iScreen(0.5),
                  ),
                  //         //==========================================//
                  SizedBox(
                    width: size.wScreen(100.0),
                    // color: Colors.blue,
                    child: Text('Dr. Secundario',
                        style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.normal,
                            color: Colors.grey)),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                    width: size.wScreen(100.0),
                    child: Text(
                      infoHospitalizacion.getVetDoctorSecundarioNombre != ''
                          ? '${infoHospitalizacion.getVetDoctorSecundarioNombre}'
                          : '--- --- --- ',
                      style: GoogleFonts.lexendDeca(
                          fontSize: size.iScreen(1.8),
                          // color: Colors.white,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  //*****************************************/
                  SizedBox(
                    height: size.iScreen(0.5),
                  ),
                  //         //==========================================//
                  SizedBox(
                    width: size.wScreen(100.0),
                    // color: Colors.blue,
                    child: Text('Dr. Nocturno',
                        style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.normal,
                            color: Colors.grey)),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                    width: size.wScreen(100.0),
                    child: Text(
                      infoHospitalizacion.getVetDoctorNocturnoNombre != ''
                          ? '${infoHospitalizacion.getVetDoctorNocturnoNombre}'
                          : '--- --- --- ',
                      style: GoogleFonts.lexendDeca(
                          fontSize: size.iScreen(1.8),
                          // color: Colors.white,
                          fontWeight: FontWeight.normal),
                    ),
                  ),

                  Row(
                    children: [
                      Container(
                        // width: size.wScreen(40.0),
                        // color: Colors.blue,
                        child: Text('Condiciones: ',
                            style: GoogleFonts.lexendDeca(
                                // fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                        width: size.wScreen(40.0),
                        child: Text(
                          infoHospitalizacion.getCondicionesMascota != ''
                              ? ' ${infoHospitalizacion.getCondicionesMascota}'
                              : '--- --- --- ',
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
                    height: size.iScreen(0.5),
                  ),
                  //         //==========================================//
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
                      infoHospitalizacion.getObservacacion != ''
                          ? '${infoHospitalizacion.getObservacacion}'
                          : '--- --- --- ',
                      style: GoogleFonts.lexendDeca(
                          fontSize: size.iScreen(1.8),
                          // color: Colors.white,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  //*****************************************/
                  SizedBox(
                    height: size.iScreen(0.5),
                  ),
                  //         //==========================================//
                  SizedBox(
                    width: size.wScreen(100.0),
                    // color: Colors.blue,
                    child: Text('Diagnóstico:',
                        style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.normal,
                            color: Colors.grey)),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                    width: size.wScreen(100.0),
                    child: Text(
                      infoHospitalizacion.getDiagnostico != ''
                          ? '${infoHospitalizacion.getDiagnostico}'
                          : '--- --- --- ',
                      style: GoogleFonts.lexendDeca(
                          fontSize: size.iScreen(1.8),
                          // color: Colors.white,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  //*****************************************/
                  SizedBox(
                    height: size.iScreen(0.5),
                  ),
                  //         //==========================================//
                  SizedBox(
                    width: size.wScreen(100.0),
                    // color: Colors.blue,
                    child: Text('Exámenes Complemetarios:',
                        style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.normal,
                            color: Colors.grey)),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                    width: size.wScreen(100.0),
                    child: Text(
                      infoHospitalizacion.getExamenesComplementarios != ''
                          ? '${infoHospitalizacion.getExamenesComplementarios}'
                          : '--- --- --- ',
                      style: GoogleFonts.lexendDeca(
                          fontSize: size.iScreen(1.8),
                          // color: Colors.white,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  //==========================================//
                  SizedBox(
                    height: size.iScreen(1.5),
                  ),
                  //         //==========================================//
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.iScreen(1.0),
                        vertical: size.iScreen(1.0)),
                    // width: size.wScreen(100.0),
                    color: Colors.grey[300],
                    child: Row(
                      children: [
                        Text('MEDICAMENTOS:',
                            style: GoogleFonts.lexendDeca(
                                // fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                        SizedBox(
                          width: size.iScreen(2.0),
                        ),
                        Consumer<HospitalizacionController>(
                          builder: (_, valueTotalMedic, __) {
                            return valueTotalMedic
                                    .getNuevoMedicamento.isNotEmpty
                                ? Text(
                                    '${valueTotalMedic.getNuevoMedicamento.length}',
                                    style: GoogleFonts.lexendDeca(
                                        // fontSize: size.iScreen(2.0),
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey))
                                : Container();
                          },
                        ),
                      ],
                    ),
                  ),
                  // //***********************************************/
                  SizedBox(
                    height: size.iScreen(2.0),
                  ),
                  // //*****************************************/

                  Consumer<HospitalizacionController>(
                    builder: (_, values, __) {
                      return (values.getNuevoMedicamento.isNotEmpty)
                          ? PaginatedDataTable(
                              // header: const Text('MEDICAMENTOS'),
                              // headingRowHeight : size.iScreen(0.0),
                              columns: [
                                DataColumn(
                                    label: Row(
                                  children: [
                                    // Text('X'),
                                    SizedBox(width: 30.0),
                                    Text('Nombre',
                                        style: GoogleFonts.lexendDeca(
                                            // fontSize: size.iScreen(2.0),
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey))
                                  ],
                                )),
                                DataColumn(
                                    // numeric: true,
                                    label: Text('Dosis',
                                        style: GoogleFonts.lexendDeca(
                                            // fontSize: size.iScreen(2.0),
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey))),
                                DataColumn(
                                    label: Text('Cantidad',
                                        style: GoogleFonts.lexendDeca(
                                            // fontSize: size.iScreen(2.0),
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey))),
                                DataColumn(
                                    label: Text('Vía',
                                        style: GoogleFonts.lexendDeca(
                                            // fontSize: size.iScreen(2.0),
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey))),
                                DataColumn(
                                    // numeric: true,
                                    label: Text('Inicio',
                                        style: GoogleFonts.lexendDeca(
                                            // fontSize: size.iScreen(2.0),
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey))),
                                DataColumn(
                                    label: Text('Frecuencia',
                                        style: GoogleFonts.lexendDeca(
                                            // fontSize: size.iScreen(2.0),
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey))),
                              ],
                              source: CabeceraMedicinaHospitalizacionDTS(
                                  values.getNuevoMedicamento,
                                  size,
                                  context,
                                  'DETALLE',
                                  false),
                              rowsPerPage: values.getNuevoMedicamento.length,
                            )
                          // : const SizedBox(),
                          : const NoData(
                              label: 'No hay medicametos agregados ');
                    },
                  ),
                  //***********************************************/
                  SizedBox(
                    height: size.iScreen(1.0),
                  ),
                  //*****************************************/
                  Consumer<HospitalizacionController>(
                    builder: (_, values, __) {
                      return (values.getNuevoHorarioMedicamento.isNotEmpty)
                          ? PaginatedDataTable(
                              header: const Text('HORARIOS'),
                              // headingRowHeight : size.iScreen(0.0),
                              columns: [
                                DataColumn(
                                    label: Row(
                                  children: [
                                    // Text('X'),
                                    // SizedBox(width: 30.0),
                                    Text('Fecha',
                                        style: GoogleFonts.lexendDeca(
                                            // fontSize: size.iScreen(2.0),
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey))
                                  ],
                                )),
                                DataColumn(
                                    // numeric: true,
                                    label: Text('Medicamento',
                                        style: GoogleFonts.lexendDeca(
                                            // fontSize: size.iScreen(2.0),
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey))),
                                DataColumn(
                                    // numeric: true,
                                    label: Text('0',
                                        style: GoogleFonts.lexendDeca(
                                            // fontSize: size.iScreen(2.0),
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey))),
                                DataColumn(
                                    label: Text('1',
                                        style: GoogleFonts.lexendDeca(
                                            // fontSize: size.iScreen(2.0),
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey))),
                                DataColumn(
                                    label: Text('2',
                                        style: GoogleFonts.lexendDeca(
                                            // fontSize: size.iScreen(2.0),
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey))),
                                DataColumn(
                                    label: Text('3',
                                        style: GoogleFonts.lexendDeca(
                                            // fontSize: size.iScreen(2.0),
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey))),
                                DataColumn(
                                    label: Text('4',
                                        style: GoogleFonts.lexendDeca(
                                            // fontSize: size.iScreen(2.0),
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey))),
                                DataColumn(
                                    label: Text('5',
                                        style: GoogleFonts.lexendDeca(
                                            // fontSize: size.iScreen(2.0),
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey))),
                                DataColumn(
                                    label: Text('6',
                                        style: GoogleFonts.lexendDeca(
                                            // fontSize: size.iScreen(2.0),
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey))),
                                DataColumn(
                                    label: Text('7',
                                        style: GoogleFonts.lexendDeca(
                                            // fontSize: size.iScreen(2.0),
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey))),
                                DataColumn(
                                    label: Text('8',
                                        style: GoogleFonts.lexendDeca(
                                            // fontSize: size.iScreen(2.0),
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey))),
                                DataColumn(
                                    label: Text('9',
                                        style: GoogleFonts.lexendDeca(
                                            // fontSize: size.iScreen(2.0),
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey))),
                                DataColumn(
                                    label: Text('10',
                                        style: GoogleFonts.lexendDeca(
                                            // fontSize: size.iScreen(2.0),
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey))),
                                DataColumn(
                                    label: Text('11',
                                        style: GoogleFonts.lexendDeca(
                                            // fontSize: size.iScreen(2.0),
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey))),
                                DataColumn(
                                    label: Text('12',
                                        style: GoogleFonts.lexendDeca(
                                            // fontSize: size.iScreen(2.0),
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey))),
                                DataColumn(
                                    label: Text('13',
                                        style: GoogleFonts.lexendDeca(
                                            // fontSize: size.iScreen(2.0),
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey))),
                                DataColumn(
                                    label: Text('14',
                                        style: GoogleFonts.lexendDeca(
                                            // fontSize: size.iScreen(2.0),
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey))),
                                DataColumn(
                                    label: Text('15',
                                        style: GoogleFonts.lexendDeca(
                                            // fontSize: size.iScreen(2.0),
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey))),
                                DataColumn(
                                    label: Text('16',
                                        style: GoogleFonts.lexendDeca(
                                            // fontSize: size.iScreen(2.0),
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey))),
                                DataColumn(
                                    label: Text('17',
                                        style: GoogleFonts.lexendDeca(
                                            // fontSize: size.iScreen(2.0),
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey))),
                                DataColumn(
                                    label: Text('18',
                                        style: GoogleFonts.lexendDeca(
                                            // fontSize: size.iScreen(2.0),
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey))),
                                DataColumn(
                                    label: Text('19',
                                        style: GoogleFonts.lexendDeca(
                                            // fontSize: size.iScreen(2.0),
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey))),
                                DataColumn(
                                    label: Text('20',
                                        style: GoogleFonts.lexendDeca(
                                            // fontSize: size.iScreen(2.0),
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey))),
                                DataColumn(
                                    label: Text('21',
                                        style: GoogleFonts.lexendDeca(
                                            // fontSize: size.iScreen(2.0),
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey))),
                                DataColumn(
                                    label: Text('22',
                                        style: GoogleFonts.lexendDeca(
                                            // fontSize: size.iScreen(2.0),
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey))),
                                DataColumn(
                                    label: Text('23',
                                        style: GoogleFonts.lexendDeca(
                                            // fontSize: size.iScreen(2.0),
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey))),
                              ],
                              source: HorarioMedicinaHospitalizacionDTS(
                                  values.getNuevoHorarioMedicamento,
                                  size,
                                  context,
                                  'DETALLE',
                                  int.parse(values.getInicioMedicina),
                                  int.parse(
                                    values.getFrecuenciaMedicina,
                                  ),
                                  false),
                              rowsPerPage:
                                  values.getNuevoHorarioMedicamento.length,
                            )
                          // : const SizedBox(),
                          : const NoData(label: 'No hay horarios designados ');
                    },
                  ),

                  //==========================================//

                                SizedBox(
                                  height: size.iScreen(1.5),
                                ),
                                //         //==========================================//
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.iScreen(1.0),
                                      vertical: size.iScreen(1.0)),
                                  // width: size.wScreen(100.0),
                                  color: Colors.grey[300],
                                  child: Row(
                                    children: [
                                      Text('ALIMENTOS:',
                                          style: GoogleFonts.lexendDeca(
                                              // fontSize: size.iScreen(2.0),
                                              fontWeight: FontWeight.normal,
                                              color: Colors.grey)),
                                      SizedBox(
                                        width: size.iScreen(2.0),
                                      ),
                                      Consumer<HospitalizacionController>(
                                        builder: (_, valueTotalAlimentos, __) {
                                          return valueTotalAlimentos
                                                  .getNuevoAlimento.isNotEmpty
                                              ? Text(
                                                  '${valueTotalAlimentos.getNuevoAlimento.length}',
                                                  style: GoogleFonts.lexendDeca(
                                                      // fontSize: size.iScreen(2.0),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.grey))
                                              : Container();
                                        },
                                      ),
                                    
                                     
                                    ],
                                  ),
                                ),
                                // // //***********************************************/
                                // SizedBox(
                                //   height: size.iScreen(2.0),
                                // ),
                                // // //*****************************************/
                                //***********************************************/
                                SizedBox(
                                  height: size.iScreen(1.0),
                                ),
                                //*****************************************/
                                Consumer<HospitalizacionController>(
                                  builder: (_, values, __) {
                                    return (values.getNuevoAlimento.isNotEmpty)
                                        ? 
                                        PaginatedDataTable(
                                            header: const Text('ALIMENTOS'),
                                            // headingRowHeight : size.iScreen(0.0),
                                            columns: [
                                              DataColumn(
                                                  label: Row(
                                                children: [
                                                  // Text('X'),
                                                  SizedBox(width: 30.0),
                                                  Text('Nombre',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color:
                                                                  Colors.grey))
                                                ],
                                              )),
                                              DataColumn(
                                                  // numeric: true,
                                                  label: Text('Dosis',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  label: Text('Cantidad',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              // DataColumn(
                                              //     label: Text('Vía',
                                              //         style: GoogleFonts.lexendDeca(
                                              //             // fontSize: size.iScreen(2.0),
                                              //             fontWeight: FontWeight.normal,
                                              //             color: Colors.grey))),
                                              DataColumn(
                                                  // numeric: true,
                                                  label: Text('Inicio',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  label: Text('Frecuencia',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                            ],
                                            source:
                                                CabeceraAlimentoHospitalizacionDTS(
                                                    values.getNuevoAlimento,
                                                    size,
                                                    context,
                                                    'NUEVO',false),
                                            rowsPerPage:
                                                values.getNuevoAlimento.length,
                                          )
                                        
                                        
                                        // : const SizedBox(),
                                        : const NoData(
                                            label:
                                                'No hay alimentos agregados ');
                                  },
                                ),
                                //***********************************************/
                                SizedBox(
                                  height: size.iScreen(1.0),
                                ),
                                //*****************************************/
                                Consumer<HospitalizacionController>(
                                  builder: (_, values, __) {
                                    return (values
                                            .getNuevoHorarioAlimeno.isNotEmpty)
                                        ? PaginatedDataTable(
                                            header: const Text('HORARIOS'),
                                            // headingRowHeight : size.iScreen(0.0),
                                            columns: [
                                              DataColumn(
                                                  label: Row(
                                                children: [
                                                  // Text('X'),
                                                  // SizedBox(width: 30.0),
                                                  Text('Fecha',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color:
                                                                  Colors.grey))
                                                ],
                                              )),
                                              DataColumn(
                                                  // numeric: true,
                                                  label: Text('Alimento',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  // numeric: true,
                                                  label: Text('0',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  label: Text('1',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  label: Text('2',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  label: Text('3',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  label: Text('4',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  label: Text('5',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  label: Text('6',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  label: Text('7',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  label: Text('8',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  label: Text('9',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  label: Text('10',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  label: Text('11',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  label: Text('12',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  label: Text('13',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  label: Text('14',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  label: Text('15',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  label: Text('16',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  label: Text('17',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  label: Text('18',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  label: Text('19',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  label: Text('20',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  label: Text('21',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  label: Text('22',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  label: Text('23',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                            ],
                                            source:
                                                HorarioAlimentosHospitalizacionDTS(
                                              values.getNuevoHorarioAlimeno,
                                              size,
                                              context,
                                              'NUEVO',
                                              int.parse(
                                                  values.getInicioAlimento),
                                              int.parse(
                                                  values.getFrecuenciaAlimento),
                                                  false
                                            ),
                                            rowsPerPage: values
                                                .getNuevoHorarioAlimeno.length,
                                          )
                                        // : const SizedBox(),
                                        : const NoData(
                                            label:
                                                'No hay horarios designados ');
                                  },
                                ),

//==========================================//
                                SizedBox(
                                  height: size.iScreen(1.5),
                                ),
                                //==========================================//
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.iScreen(1.0),
                                      vertical: size.iScreen(1.0)),
                                  // width: size.wScreen(100.0),
                                  color: Colors.grey[300],
                                  child: Row(
                                    children: [
                                      Text('FLUIDOS:',
                                          style: GoogleFonts.lexendDeca(
                                              // fontSize: size.iScreen(2.0),
                                              fontWeight: FontWeight.normal,
                                              color: Colors.grey)),
                                      SizedBox(
                                        width: size.iScreen(2.0),
                                      ),
                                      Consumer<HospitalizacionController>(
                                        builder: (_, valueTotalFluidos, __) {
                                          return valueTotalFluidos
                                                  .getNuevoFluido.isNotEmpty
                                              ? Text(
                                                  '${valueTotalFluidos.getNuevoFluido.length}',
                                                  style: GoogleFonts.lexendDeca(
                                                      // fontSize: size.iScreen(2.0),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.grey))
                                              : Container();
                                        },
                                      ),
                                     
                                    ],
                                  ),
                                ),
                                // //***********************************************/
                                SizedBox(
                                  height: size.iScreen(2.0),
                                ),
                                // //*****************************************/
                                //***********************************************/
                                SizedBox(
                                  height: size.iScreen(1.0),
                                ),
                                //*****************************************/
                                Consumer<HospitalizacionController>(
                                  builder: (_, values, __) {
                                    return (values.getNuevoFluido.isNotEmpty)
                                        ? PaginatedDataTable(
                                            header: const Text('FLUIDOS'),
                                            // headingRowHeight : size.iScreen(0.0),
                                            columns: [
                                              DataColumn(
                                                  label: Row(
                                                children: [
                                                  // Text('X'),
                                                  SizedBox(width: 30.0),
                                                  Text('Nombre',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color:
                                                                  Colors.grey))
                                                ],
                                              )),
                                              DataColumn(
                                                  // numeric: true,
                                                  label: Text('Dosis',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  label: Text('Cantidad',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),

                                              DataColumn(
                                                  // numeric: true,
                                                  label: Text('Inicio',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              // DataColumn(
                                              //     label: Text('Frecuencia',
                                              //         style: GoogleFonts.lexendDeca(
                                              //             // fontSize: size.iScreen(2.0),
                                              //             fontWeight: FontWeight.normal,
                                              //             color: Colors.grey))),
                                            ],
                                            source:
                                                CabeceraFluidoHospitalizacionDTS(
                                                    values.getNuevoFluido,
                                                    size,
                                                    context,
                                                    'NUEVO',false),
                                            rowsPerPage:
                                                values.getNuevoFluido.length,
                                          )
                                        // : const SizedBox(),
                                        : const NoData(
                                            label: 'No hay fluidos agregados ');
                                  },
                                ),

                              //==========================================//
                                SizedBox(
                                  height: size.iScreen(1.5),
                                ),
                                //==========================================//
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.iScreen(1.0),
                                      vertical: size.iScreen(1.0)),
                                  // width: size.wScreen(100.0),
                                  color: Colors.grey[300],
                                  child: Row(
                                    children: [
                                      Text('INFUSIÓN:',
                                          style: GoogleFonts.lexendDeca(
                                              // fontSize: size.iScreen(2.0),
                                              fontWeight: FontWeight.normal,
                                              color: Colors.grey)),
                                      SizedBox(
                                        width: size.iScreen(2.0),
                                      ),
                                      Consumer<HospitalizacionController>(
                                        builder: (_, valueTotalInfusion, __) {
                                          return valueTotalInfusion
                                                  .getNuevoInfusion.isNotEmpty
                                              ? Text(
                                                  '${valueTotalInfusion.getNuevoInfusion.length}',
                                                  style: GoogleFonts.lexendDeca(
                                                      // fontSize: size.iScreen(2.0),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.grey))
                                              : Container();
                                        },
                                      ),
                                      
                                    ],
                                  ),
                                ),
                                // //***********************************************/
                                SizedBox(
                                  height: size.iScreen(2.0),
                                ),
                                // //*****************************************/
                                //***********************************************/
                                SizedBox(
                                  height: size.iScreen(1.0),
                                ),
                                //*****************************************/
                                Consumer<HospitalizacionController>(
                                  builder: (_, values, __) {
                                    return (values.getNuevoInfusion.isNotEmpty)
                                        ? PaginatedDataTable(
                                            header: const Text('INFUSIÓN'),
                                            // headingRowHeight : size.iScreen(0.0),
                                            columns: [
                                              DataColumn(
                                                  label: Row(
                                                children: [
                                                  // Text('X'),
                                                  SizedBox(width: 30.0),
                                                  Text('Nombre',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color:
                                                                  Colors.grey))
                                                ],
                                              )),
                                              DataColumn(
                                                  // numeric: true,
                                                  label: Text('Dosis',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  label: Text('Unidad',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),

                                              // DataColumn(
                                              //     // numeric: true,
                                              //     label: Text('Inicio',
                                              //         style: GoogleFonts.lexendDeca(
                                              //             // fontSize: size.iScreen(2.0),
                                              //             fontWeight: FontWeight.normal,
                                              //             color: Colors.grey))),
                                              // DataColumn(
                                              //     label: Text('Frecuencia',
                                              //         style: GoogleFonts.lexendDeca(
                                              //             // fontSize: size.iScreen(2.0),
                                              //             fontWeight: FontWeight.normal,
                                              //             color: Colors.grey))),
                                            ],
                                            source:
                                                CabeceraInfusionHospitalizacionDTS(
                                                    values.getNuevoInfusion,
                                                    size,
                                                    context,
                                                    'NUEVO',false),
                                            rowsPerPage:
                                                values.getNuevoInfusion.length,
                                          )
                                        // : const SizedBox(),
                                        : const NoData(
                                            label:
                                                'No hay infusiones agregadas ');
                                  },
                                ),

       //==========================================//

                                SizedBox(
                                  height: size.iScreen(1.5),
                                ),
                                //         //==========================================//
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.iScreen(1.0),
                                      vertical: size.iScreen(1.0)),
                                  // width: size.wScreen(100.0),
                                  color: Colors.grey[300],
                                  child: Row(
                                    children: [
                                      Text('PARÁMETROS:',
                                          style: GoogleFonts.lexendDeca(
                                              // fontSize: size.iScreen(2.0),
                                              fontWeight: FontWeight.normal,
                                              color: Colors.grey)),
                                      SizedBox(
                                        width: size.iScreen(2.0),
                                      ),
                                      Consumer<HospitalizacionController>(
                                        builder: (_, valueTotalParametros, __) {
                                          return valueTotalParametros
                                                  .getNuevoParametro.isNotEmpty
                                              ? Text(
                                                  '${valueTotalParametros.getNuevoParametro.length}',
                                                  style: GoogleFonts.lexendDeca(
                                                      // fontSize: size.iScreen(2.0),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.grey))
                                              : Container();
                                        },
                                      ),
                                     
                                    ],
                                  ),
                                ),
                                // //***********************************************/
                                SizedBox(
                                  height: size.iScreen(2.0),
                                ),
                                // //*****************************************/
                                //***********************************************/
                                SizedBox(
                                  height: size.iScreen(1.0),
                                ),
                                //*****************************************/
                                Consumer<HospitalizacionController>(
                                  builder: (_, values, __) {
                                    return (values.getNuevoParametro.isNotEmpty)
                                        ? PaginatedDataTable(
                                            header: const Text('PARÁMETROS'),
                                            // headingRowHeight : size.iScreen(0.0),
                                            columns: [
                                              DataColumn(
                                                  label: Row(
                                                children: [
                                                  // Text('X'),
                                                  SizedBox(width: 30.0),
                                                  Text('Nombre',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color:
                                                                  Colors.grey))
                                                ],
                                              )),
                                              DataColumn(
                                                  // numeric: true,
                                                  label: Text('Dosis',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              // DataColumn(
                                              //     label: Text('Cantidad',
                                              //         style: GoogleFonts.lexendDeca(
                                              //             // fontSize: size.iScreen(2.0),
                                              //             fontWeight: FontWeight.normal,
                                              //             color: Colors.grey))),
                                              // DataColumn(
                                              //     label: Text('Vía',
                                              //         style: GoogleFonts.lexendDeca(
                                              //             // fontSize: size.iScreen(2.0),
                                              //             fontWeight: FontWeight.normal,
                                              //             color: Colors.grey))),
                                              DataColumn(
                                                  // numeric: true,
                                                  label: Text('Inicio',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  label: Text('Frecuencia',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                            ],
                                            source:
                                                CabeceraParametrosHospitalizacionDTS(
                                                    values.getNuevoParametro,
                                                    size,
                                                    context,
                                                    'NUEVO',false),
                                            rowsPerPage:
                                                values.getNuevoParametro.length,
                                          )
                                        // : const SizedBox(),
                                        : const NoData(
                                            label:
                                                'No hay parámetros agregados ');
                                  },
                                ),
                                //***********************************************/
                                SizedBox(
                                  height: size.iScreen(1.0),
                                ),
                                //*****************************************/
                                Consumer<HospitalizacionController>(
                                  builder: (_, values, __) {
                                    return (values.getNuevoHorarioParametro
                                            .isNotEmpty)
                                        ? PaginatedDataTable(
                                            header: const Text('HORARIOS'),
                                            // headingRowHeight : size.iScreen(0.0),
                                            columns: [
                                              DataColumn(
                                                  label: Row(
                                                children: [
                                                  // Text('X'),
                                                  // SizedBox(width: 30.0),
                                                  Text('Fecha',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color:
                                                                  Colors.grey))
                                                ],
                                              )),
                                              DataColumn(
                                                  // numeric: true,
                                                  label: Text('Medicina',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  // numeric: true,
                                                  label: Text('0',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  label: Text('1',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  label: Text('2',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  label: Text('3',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  label: Text('4',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  label: Text('5',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  label: Text('6',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  label: Text('7',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  label: Text('8',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  label: Text('9',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  label: Text('10',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  label: Text('11',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  label: Text('12',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  label: Text('13',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  label: Text('14',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  label: Text('15',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  label: Text('16',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  label: Text('17',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  label: Text('18',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  label: Text('19',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  label: Text('20',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  label: Text('21',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  label: Text('22',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  label: Text('23',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                            ],
                                            source:
                                                HorarioParametrosHospitalizacionDTS(
                                              values.getNuevoHorarioParametro,
                                              size,
                                              context,
                                              'NUEVO',
                                              int.parse(
                                                  values.getInicioParametro),
                                              int.parse(values
                                                  .getFrecuenciaParametro),
                                                  false
                                            ),
                                            rowsPerPage: values
                                                .getNuevoHorarioParametro
                                                .length,
                                          )
                                        // : const SizedBox(),
                                        : const NoData(
                                            label:
                                                'No hay horarios designados ');
                                  },
                                ),




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
                  //       child: Text('Fecha de nacimiento: ',
                  //           style: GoogleFonts.lexendDeca(
                  //               // fontSize: size.iScreen(2.0),
                  //               fontWeight: FontWeight.normal,
                  //               color: Colors.grey)),
                  //     ),
                  //     Container(
                  //       margin:
                  //           EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                  //       // width: size.wScreen(100.0),
                  //       child: Text(
                  //         ' ${infoHospitalizacion['mascFechaNacimiento']}',
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
                  // Row(
                  //   children: [
                  //     SizedBox(
                  //       // width: size.wScreen(100.0),
                  //       // color: Colors.blue,
                  //       child: Text('Edad: ',
                  //           style: GoogleFonts.lexendDeca(
                  //               // fontSize: size.iScreen(2.0),
                  //               fontWeight: FontWeight.normal,
                  //               color: Colors.grey)),
                  //     ),
                  //     Container(
                  //       margin:
                  //           EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                  //       // width: size.wScreen(100.0),
                  //       child: Text(
                  //         ' ${infoHospitalizacion['mascEdad']}',
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
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Column(
                  //       children: [
                  //         Container(
                  //           width: size.wScreen(40.0),
                  //           // color: Colors.blue,
                  //           child: Text('Especie',
                  //               style: GoogleFonts.lexendDeca(
                  //                   // fontSize: size.iScreen(2.0),
                  //                   fontWeight: FontWeight.normal,
                  //                   color: Colors.grey)),
                  //         ),
                  //         Container(
                  //           margin: EdgeInsets.symmetric(
                  //               vertical: size.iScreen(0.5)),
                  //           width: size.wScreen(40.0),
                  //           child: Text(
                  //             '${infoHospitalizacion['mascEspecie']}',
                  //             style: GoogleFonts.lexendDeca(
                  //                 fontSize: size.iScreen(1.8),
                  //                 // color: Colors.white,
                  //                 fontWeight: FontWeight.normal),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //     Column(
                  //       children: [
                  //         Container(
                  //           width: size.wScreen(40.0),
                  //           // color: Colors.blue,
                  //           child: Text('Raza',
                  //               style: GoogleFonts.lexendDeca(
                  //                   // fontSize: size.iScreen(2.0),
                  //                   fontWeight: FontWeight.normal,
                  //                   color: Colors.grey)),
                  //         ),
                  //         Container(
                  //           margin: EdgeInsets.symmetric(
                  //               vertical: size.iScreen(0.5)),
                  //           width: size.wScreen(40.0),
                  //           child: Text(
                  //             '${infoHospitalizacion['mascRaza']}',
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

                  // //*****************************************/

                  // SizedBox(
                  //   height: size.iScreen(0.0),
                  // ),
                  // //         //==========================================//
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Column(
                  //       children: [
                  //         Container(
                  //           width: size.wScreen(40.0),
                  //           // color: Colors.blue,
                  //           child: Text('Alimento',
                  //               style: GoogleFonts.lexendDeca(
                  //                   // fontSize: size.iScreen(2.0),
                  //                   fontWeight: FontWeight.normal,
                  //                   color: Colors.grey)),
                  //         ),
                  //         Container(
                  //           margin: EdgeInsets.symmetric(
                  //               vertical: size.iScreen(0.5)),
                  //           width: size.wScreen(40.0),
                  //           child: Text(
                  //             '${infoHospitalizacion['mascAlimento']}',
                  //             style: GoogleFonts.lexendDeca(
                  //                 fontSize: size.iScreen(1.8),
                  //                 // color: Colors.white,
                  //                 fontWeight: FontWeight.normal),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //     Column(
                  //       children: [
                  //         Container(
                  //           width: size.wScreen(40.0),
                  //           // color: Colors.blue,
                  //           child: Text('Tipo Alimento',
                  //               style: GoogleFonts.lexendDeca(
                  //                   // fontSize: size.iScreen(2.0),
                  //                   fontWeight: FontWeight.normal,
                  //                   color: Colors.grey)),
                  //         ),
                  //         Container(
                  //           margin: EdgeInsets.symmetric(
                  //               vertical: size.iScreen(0.5)),
                  //           width: size.wScreen(40.0),
                  //           child: Text(
                  //             '${infoHospitalizacion['mascTipoAlimento']}',
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

                  // //*****************************************/

                  // SizedBox(
                  //   height: size.iScreen(0.0),
                  // ),
                  // //         //==========================================//
                  // SizedBox(
                  //   width: size.wScreen(100.0),
                  //   // color: Colors.blue,
                  //   child: Text('Caracter',
                  //       style: GoogleFonts.lexendDeca(
                  //           // fontSize: size.iScreen(2.0),
                  //           fontWeight: FontWeight.normal,
                  //           color: Colors.grey)),
                  // ),
                  // Container(
                  //   margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                  //   width: size.wScreen(100.0),
                  //   child: Text(
                  //     infoHospitalizacion['mascCaracter'] != ''
                  //         ? '${infoHospitalizacion['mascCaracter']}'
                  //         : 'No definido',
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
                  //   child: Text('Observación',
                  //       style: GoogleFonts.lexendDeca(
                  //           // fontSize: size.iScreen(2.0),
                  //           fontWeight: FontWeight.normal,
                  //           color: Colors.grey)),
                  // ),
                  // Container(
                  //   margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                  //   width: size.wScreen(100.0),
                  //   child: Text(
                  //     infoHospitalizacion['mascObservacion'] != ''
                  //         ? '${infoHospitalizacion['mascObservacion']}'
                  //         : 'ninguna',
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
                  //     '${infoHospitalizacion['mascPerNombre']}',
                  //     style: GoogleFonts.lexendDeca(
                  //         fontSize: size.iScreen(1.8),
                  //         // color: Colors.white,
                  //         fontWeight: FontWeight.normal),
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
                  // Container(
                  //   padding: EdgeInsets.symmetric(
                  //       vertical: size.iScreen(1.0),
                  //       horizontal: size.iScreen(0.5)),
                  //   width: size.wScreen(100.0),
                  //   color: Colors.grey[200],
                  //   child: Text( 'Contacto Extra ',
                  //       style: GoogleFonts.lexendDeca(
                  //           // fontSize: size.iScreen(2.0),
                  //           fontWeight: FontWeight.normal,
                  //           color: Colors.grey)),
                  // ),
                  // Container(
                  //     margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                  //     width: size.wScreen(100.0),
                  //     child: Wrap(
                  //       children: (infoHospitalizacion['mascContactoExtra'] as List)
                  //           .map(
                  //             (e) => InkWell(
                  //               onDoubleTap: () async {
                  //                 _callNumber(e);
                  //               },
                  //               child: Container(
                  //                 width: size.wScreen(100.0),
                  //                 child: Column(
                  //                   children: [
                  //                     Container(
                  //                       margin: EdgeInsets.symmetric(
                  //                           vertical: size.iScreen(0.5)),
                  //                       width: size.wScreen(100.0),
                  //                       child: Column(
                  //                         children: [
                  //                           Container(
                  //                             width: size.wScreen(100.0),
                  //                             // color: Colors.blue,
                  //                             child: Text('Nombre:',
                  //                                 style: GoogleFonts.lexendDeca(
                  //                                     // fontSize: size.iScreen(2.0),
                  //                                     fontWeight:
                  //                                         FontWeight.normal,
                  //                                     color: Colors.grey)),
                  //                           ),
                  //                           Container(
                  //                             width: size.wScreen(100.0),
                  //                             child: Text(
                  //                               '${e['nombre']}',
                  //                               style: GoogleFonts.lexendDeca(
                  //                                   fontSize: size.iScreen(1.8),
                  //                                   // color: Colors.white,
                  //                                   fontWeight:
                  //                                       FontWeight.normal),
                  //                             ),
                  //                           ),
                  //                         ],
                  //                       ),
                  //                     ),
                  //                     // //*****************************************/

                  //                     SizedBox(
                  //                       height: size.iScreen(0.5),
                  //                     ),
                  //                     //         //==========================================//
                  //                     Container(
                  //                       width: size.wScreen(100.0),
                  //                       child: Text(
                  //                         '${e['correo']}',
                  //                         style: GoogleFonts.lexendDeca(
                  //                             fontSize: size.iScreen(1.8),
                  //                             // color: Colors.white,
                  //                             fontWeight: FontWeight.normal),
                  //                       ),
                  //                     ),
                  //                     // //*****************************************/

                  //                     SizedBox(
                  //                       height: size.iScreen(1.0),
                  //                     ),
                  //                     //         //==========================================//
                  //                     Row(
                  //                       children: [
                  //                         Container(
                  //                           // width: size.wScreen(100.0),
                  //                           decoration: BoxDecoration(
                  //                               color: Colors.grey.shade200,
                  //                               borderRadius:
                  //                                   BorderRadius.circular(5.0)),
                  //                           margin: EdgeInsets.symmetric(
                  //                               vertical: size.iScreen(0.3)),
                  //                           padding: EdgeInsets.symmetric(
                  //                               horizontal: size.iScreen(1.0),
                  //                               vertical: size.iScreen(0.5)),
                  //                           child: Text('${e['celular']}',
                  //                               style: GoogleFonts.lexendDeca(
                  //                                   fontSize: size.iScreen(1.7),
                  //                                   fontWeight:
                  //                                       FontWeight.normal,
                  //                                   color: Colors.black)),
                  //                         ),

                  //                         //***********************************************/
                  //                         SizedBox(
                  //                           width: size.iScreen(3.0),
                  //                         ),
                  //                         //*****************************************/
                  //                         Icon(
                  //                           Icons.phone_forwarded_outlined,
                  //                           size: size.iScreen(3.0),
                  //                           color: primaryColor,
                  //                         )
                  //                       ],
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ),
                  //             ),
                  //           )
                  //           .toList(),
                  //     )
                  // Text(
                  //   '${infoProveedor['perCelular']}',
                  //   style: GoogleFonts.lexendDeca(
                  //       fontSize: size.iScreen(1.8),
                  //       // color: Colors.white,
                  //       fontWeight: FontWeight.normal),
                  // ),
                  // ),
                  // //*****************************************/

                  // SizedBox(
                  //   height: size.iScreen(0.0),
                  // ),
                  //         //==========================================//
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
                  //     margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                  //     width: size.wScreen(100.0),
                  //     child: Wrap(
                  //       children: (infoProveedor['perEmail'] as List)
                  //           .map(
                  //             (e) => Container(
                  //               width: size.wScreen(100.0),
                  //               child: Container(
                  //                 // width: size.wScreen(100.0),
                  //                 decoration: BoxDecoration(
                  //                     color: Colors.grey.shade200,
                  //                     borderRadius: BorderRadius.circular(5.0)),
                  //                 margin: EdgeInsets.symmetric(
                  //                     vertical: size.iScreen(0.3)),
                  //                 padding: EdgeInsets.symmetric(
                  //                     horizontal: size.iScreen(1.0),
                  //                     vertical: size.iScreen(0.5)),
                  //                 child: Text('$e',
                  //                     style: GoogleFonts.lexendDeca(
                  //                         fontSize: size.iScreen(1.7),
                  //                         fontWeight: FontWeight.normal,
                  //                         color: Colors.black)),
                  //               ),
                  //             ),
                  //           )
                  //           .toList(),
                  //     )
                  //     // Text(
                  //     //   '${infoProveedor['perCelular']}',
                  //     //   style: GoogleFonts.lexendDeca(
                  //     //       fontSize: size.iScreen(1.8),
                  //     //       // color: Colors.white,
                  //     //       fontWeight: FontWeight.normal),
                  //     // ),
                  //     ),
                  // //*****************************************/

                  // SizedBox(
                  //   height: size.iScreen(0.0),
                  // ),
                  // //         //==========================================//
                  // SizedBox(
                  //   width: size.wScreen(100.0),
                  //   // color: Colors.blue,
                  //   child: Text('Correos:',
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
                  // //*****************************************/

                  // SizedBox(
                  //   height: size.iScreen(0.0),
                  // ),
                  // //         //==========================================//
                  // SizedBox(
                  //   width: size.wScreen(100.0),
                  //   // color: Colors.blue,
                  //   child: Text('Recomendación:',
                  //       style: GoogleFonts.lexendDeca(
                  //           // fontSize: size.iScreen(2.0),
                  //           fontWeight: FontWeight.normal,
                  //           color: Colors.grey)),
                  // ),
                  // Container(
                  //   margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                  //   width: size.wScreen(100.0),
                  //   child: Text(
                  //     '${infoProveedor['perRecomendacion']}',
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
                  //   child: Text('Observaciones:',
                  //       style: GoogleFonts.lexendDeca(
                  //           // fontSize: size.iScreen(2.0),
                  //           fontWeight: FontWeight.normal,
                  //           color: Colors.grey)),
                  // ),
                  // Container(
                  //   margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                  //   width: size.wScreen(100.0),
                  //   child: Text(
                  //     '${infoProveedor['perObsevacion']}',
                  //     style: GoogleFonts.lexendDeca(
                  //         fontSize: size.iScreen(1.8),
                  //         // color: Colors.white,
                  //         fontWeight: FontWeight.normal),
                  //   ),
                  // ),
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

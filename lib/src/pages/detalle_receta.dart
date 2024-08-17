import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neitorcont/src/controllers/recetas_controller.dart';
import 'package:neitorcont/src/data_table/lista_medicina_datasource.dart';
import 'package:neitorcont/src/utils/responsive.dart';
import 'package:neitorcont/src/utils/theme.dart';
import 'package:neitorcont/src/widgets/no_data.dart';
import 'package:provider/provider.dart';

class DetalleReceta extends StatelessWidget {
  const DetalleReceta({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final infoReceta = context.read<RecetasController>().getInfoReceta;
    final controlReceta = context.read<RecetasController>();
    final Responsive size = Responsive.of(context);
    return Scaffold(
        appBar: AppBar(
          title:  Text('Detalle de Receta'),
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
                      '${infoReceta['recMascNombre']}',
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
                    child: Text('Raza:',
                        style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.normal,
                            color: Colors.grey)),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                    width: size.wScreen(100.0),
                    child: Text(
                      '${infoReceta['recMascRaza']}',
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
                    child: Text('Sexo:',
                        style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.normal,
                            color: Colors.grey)),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                    width: size.wScreen(100.0),
                    child: Text(
                      '${infoReceta['recMascSexo']}',
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
                    child: Text('Edad:',
                        style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.normal,
                            color: Colors.grey)),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                    width: size.wScreen(100.0),
                    child: Text(
                      '${infoReceta['recMascEdad']}',
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
                        child: Text('Peso:',
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
                          '${infoReceta['recPeso']}',
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
                    height: size.iScreen(1.0),
                  ),
                  //         //==========================================//
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: size.iScreen(1.0),
                        horizontal: size.iScreen(1.0)),
                    width: size.wScreen(100.0),
                    color: Colors.grey[200],
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
                      '${infoReceta['recPerNombrePropietario']}',
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
                    child: Text('Dirección:',
                        style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.normal,
                            color: Colors.grey)),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                    width: size.wScreen(100.0),
                    child: Text(
                      '${infoReceta['recPerDireccionPropietario']}',
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
                    child: Text('Celular:',
                        style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.normal,
                            color: Colors.grey)),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                    width: size.wScreen(100.0),
                    child: infoReceta['recPerCelularPropietario']!.isEmpty
                        ? Text('--- --- --- ',
                            style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                            ))
                        : Wrap(
                            children: (infoReceta['recPerCelularPropietario']!
                                    as List)
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
                    child: infoReceta['recPerEmailPropietario']!.isEmpty
                        ? Text('--- --- --- ',
                            style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                            ))
                        : Wrap(
                            children:
                                (infoReceta['recPerEmailPropietario']! as List)
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
                    child: Text('Doctor',
                        style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.normal,
                            color: Colors.grey)),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                    width: size.wScreen(100.0),
                    child: Text(
                      '${infoReceta['recPerNombreDoc']}',
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
                        child: Text('Próxima Cita:',
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
                           infoReceta['recProxCita']!=''? '${infoReceta['recProxCita'].replaceAll('T', "  ")}':'--- --- ---',
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
                    child: Text('Recomendaciones:',
                        style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.normal,
                            color: Colors.grey)),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                    width: size.wScreen(100.0),
                    child: Text(
                       infoReceta['recRecomendacion']!=''? '${infoReceta['recRecomendacion']}':'--- --- ---',
                      style: GoogleFonts.lexendDeca(
                          fontSize: size.iScreen(1.8),
                          // color: Colors.white,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  //***********************************************/
                  SizedBox(
                    height: size.iScreen(2.0),
                  ),
                  //*****************************************/

                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: size.iScreen(0.5),
                        horizontal: size.iScreen(1.0)),
                    width: size.wScreen(100.0),
                    color: Colors.grey[200],
                    child: Row(
                      children: [
                        SizedBox(
                          // width: size.wScreen(100.0),

                          // color: Colors.blue,
                          child: Text('Medicamentos ',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey)),
                        ),
                        SizedBox(
                          width: size.iScreen(2.0),
                        ),
                        Consumer<RecetasController>(
                          builder: (_, valueTotalMedic, __) {
                            return Text(
                                '${valueTotalMedic.getNuevoMedicamento.length}',
                                style: GoogleFonts.lexendDeca(
                                    // fontSize: size.iScreen(2.0),
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey));
                          },
                        ),
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
                  Consumer<RecetasController>(
                    builder: (_, values, __) {
                      return (values.getNuevoMedicamento.isNotEmpty)
                          ? PaginatedDataTable(
                              columns: [
                                DataColumn(
                                    label: Row(
                                  children: [
                                   Text('Nombre',
                                        style: GoogleFonts.lexendDeca(
                                            // fontSize: size.iScreen(2.0),
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey))
                                  ],
                                )),
                                DataColumn(
                                    numeric: true,
                                    label: Text('Cantidad',
                                        style: GoogleFonts.lexendDeca(
                                            // fontSize: size.iScreen(2.0),
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey))),
                                DataColumn(
                                    label: Text('Tratamiento',
                                        style: GoogleFonts.lexendDeca(
                                            // fontSize: size.iScreen(2.0),
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey))),
                                              DataColumn(
                                      label: Text('Serie',
                                          style: GoogleFonts.lexendDeca(
                                              // fontSize: size.iScreen(2.0),
                                              fontWeight: FontWeight.normal,
                                              color: Colors.grey))),
                              ],
                              source: ListaMedimamentosDTS(
                                values.getNuevoMedicamento,
                                size,
                                context,
                                'DETALLE'
                              ),
                              rowsPerPage: values.getNuevoMedicamento.length,
                            )
                          // : const SizedBox(),
                          : const NoData(
                              label: 'No hay medicametos agregados ');
                    },
                  )
                ],
              ),
            )));
  }

  _callNumber(String numero) async {
    await FlutterPhoneDirectCaller.callNumber(numero);
  }
}

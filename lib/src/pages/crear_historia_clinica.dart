import 'dart:io';

// import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neitorcont/src/controllers/historia_clinica.controller.dart';
import 'package:neitorcont/src/controllers/mascotas_controller.dart';
import 'package:neitorcont/src/controllers/recetas_controller.dart';
import 'package:neitorcont/src/pages/views_pdf.dart';
import 'package:neitorcont/src/services/notifications_service.dart';
import 'package:neitorcont/src/services/socket_service.dart';
import 'package:neitorcont/src/theme/themes_app.dart';
import 'package:neitorcont/src/utils/letras_mayusculas_minusculas.dart';

import 'package:neitorcont/src/utils/responsive.dart';
import 'package:neitorcont/src/utils/theme.dart';
import 'package:neitorcont/src/widgets/no_data.dart';
// import 'package:open_file/open_file.dart';

import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class CrearHistiriaClinica extends StatefulWidget {
   final String? tipo;
  const CrearHistiriaClinica({Key? key, this.tipo}) : super(key: key);

  @override
  State<CrearHistiriaClinica> createState() => _CrearHistiriaClinicaState();
}

class _CrearHistiriaClinicaState extends State<CrearHistiriaClinica> {
  TextEditingController _fechaController = TextEditingController();

  late TimeOfDay timeFecha;

  @override
  void initState() {
    timeFecha = TimeOfDay.now();


    super.initState();
  }

  @override
  void dispose() {
    _fechaController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final _action = ModalRoute.of(context)!.settings.arguments;
    final Responsive size = Responsive.of(context);
    final controllerHistoria = context.read<HistoriaClinicaController>();
    
    return GestureDetector(
         onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: widget.tipo == 'CREATE' || widget.tipo == 'SEARCH'
              ?  Text('Crear Historia Clínica')
              :  Text('Editar Historia Clínica'),
          actions: [
            Consumer<SocketService>(builder: (_, valueConexion, __) {
              return valueConexion.serverStatus == ServerStatus.Online
                  ? Container(
                      margin: EdgeInsets.only(right: size.iScreen(1.5)),
                      child: IconButton(
                          splashRadius: 28,
                          onPressed: () {
                            _onSubmit(
                                context, controllerHistoria,);
                          },
                          icon: Icon(
                            Icons.save_outlined,
                            size: size.iScreen(4.0),
                          )),
                    )
                  : Container();
            })
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
            child: 
             SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Form(
                        key: controllerHistoria.historiaclinicaFormKey,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                
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
                                        child: Consumer<AppTheme>(builder: (_, valueTheme, __) {  
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
                                 Consumer<HistoriaClinicaController>(
                              builder: (_, valueFecha, __) {
                                return Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Fecha:',
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
                                          _fecha(context, valueFecha);
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                              valueFecha.getInputfecha, 
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
                                    ]);
                              },
                            ),
                              ],
                            ),
    
                            //***********************************************/
                            SizedBox(
                              height: size.iScreen(1.0),
                            ),
                            //*****************************************/
                            Consumer<HistoriaClinicaController>(
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
                                      child: Consumer<AppTheme>(builder: (_, valueTheme, __) {  
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
                            Consumer<HistoriaClinicaController>(
                              builder: (_, valueDoctor, __) {
                                return SizedBox(
                                  width: size.wScreen(100.0),
    
                                  // color: Colors.blue,
                                  child: Text(
                                      valueDoctor.getVetInternoNombre!.isEmpty
                                          ? 'DEBE SELECCIONAR VERETINARIO INTERNO '
                                          : '${valueDoctor.getVetInternoNombre} ',
                                      style: GoogleFonts.lexendDeca(
                                          // fontSize: size.iScreen(2.0),
                                          fontWeight: FontWeight.normal,
                                          color: valueDoctor
                                                  .getVetInternoNombre!.isEmpty
                                              ? Colors.grey
                                              : Colors.black)),
                                );
                              },
                            ),
                            //*****************************************/
                            // SizedBox(
                            //   height: size.iScreen(1.0),
                            // ),
                            //*****************************************/
    
                            // Consumer<HistoriaClinicaController>(
                            //   builder: (_, valueFecha, __) {
                            //     return Row(
                            //         mainAxisAlignment: MainAxisAlignment.start,
                            //         children: [
                            //           Text(
                            //             'Fecha:',
                            //             style: GoogleFonts.lexendDeca(
                            //               // fontSize: size.iScreen(1.8),
                            //               color: Colors.black45,
                            //               // fontWeight: FontWeight.bold,
                            //             ),
                            //           ),
                            //           SizedBox(
                            //             width: size.iScreen(1.0),
                            //           ),
                            //           GestureDetector(
                            //             onTap: () {
                            //               FocusScope.of(context)
                            //                   .requestFocus(FocusNode());
                            //               _fecha(context, valueFecha);
                            //             },
                            //             child: Row(
                            //               children: [
                            //                 Text(
                            //                   valueFecha.getInputfecha ??
                            //                       'yyyy-mm-dd',
                            //                   style: GoogleFonts.lexendDeca(
                            //                     fontSize: size.iScreen(1.8),
                            //                     color: Colors.black45,
                            //                     fontWeight: FontWeight.bold,
                            //                   ),
                            //                 ),
                            //                 SizedBox(
                            //                   width: size.iScreen(1.0),
                            //                 ),
                            //                 const Icon(
                            //                   Icons.date_range_outlined,
                            //                   color: primaryColor,
                            //                   size: 30,
                            //                 ),
                            //               ],
                            //             ),
                            //           ),
                            //         ]);
                            //   },
                            // ),
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
                                    child: Text('Motivo ',
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
                                            .read<HistoriaClinicaController>()
                                            .buscaAllTipoConsultas('');
    
                                        _buscarTipoConsulta(context, size);
    
                                        //*******************************************/
                                      },
                                      child: Consumer<AppTheme>(builder: (_, valueTheme, __) {  
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
                            Consumer<HistoriaClinicaController>(
                              builder: (_, valueDoctor, __) {
                                return SizedBox(
                                  width: size.wScreen(100.0),
    
                                  // color: Colors.blue,
                                  child: Text(
                                      valueDoctor.getTipoConsulta!.isEmpty
                                          ? 'DEBE SELECCIONAR MOTIVO '
                                          : '${valueDoctor.getTipoConsulta} ',
                                      style: GoogleFonts.lexendDeca(
                                          // fontSize: size.iScreen(2.0),
                                          fontWeight: FontWeight.normal,
                                          color:
                                              valueDoctor.getTipoConsulta!.isEmpty
                                                  ? Colors.grey
                                                  : Colors.black)),
                                );
                              },
                            ),
    
                            //******************************/
                            SizedBox(
                              height: size.iScreen(1.0),
                            ),
                            //*****************************************/
                                 Row(
                                  children: [
                                    Container(
                                      // width: size.wScreen(20.0),
    
                                      // color: Colors.blue,
                                      child: Text('Peso kg',
                                          style: GoogleFonts.lexendDeca(
                                              // fontSize: size.iScreen(2.0),
                                              fontWeight: FontWeight.normal,
                                              color: Colors.grey)),
                                    ),
                                    Container(
                                      width: size.wScreen(20.0),
                                      child: TextFormField(
                                        initialValue: widget.tipo == 'CREATE'
                                            ? ''
                                            : controllerHistoria.getPesoMascota,
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
                                          controllerHistoria.setPesoMascota(text);
                                        },
                                        validator: (text) {
                                          if (text!.trim().isNotEmpty) {
                                            return null;
                                          } else {
                                            return 'Ingrese peso de la mascota';
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                            //******************************/
                            SizedBox(
                              height: size.iScreen(2.0),
                            ),
                            //*****************************************/
    
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
                              // width: size.wScreen(45.0),
                              child: TextFormField(
                                initialValue: widget.tipo == 'CREATE'
                                    ? ''
                                    : controllerHistoria.getDescripcion,
    
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
                                  controllerHistoria.setDescripcion(text);
                                },
                                // validator: (text) {
                                //   if (text!.trim().isNotEmpty) {
                                //     return null;
                                //   } else {
                                //     return 'Ingrese nombre de mascota';
                                //   }
                                // },
                              ),
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
                                    child: Text('Subir Archivo ',
                                        style: GoogleFonts.lexendDeca(
                                            // fontSize: size.iScreen(2.0),
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey)),
                                  ),
                                  SizedBox(
                                    width: size.iScreen(2.0),
                                  ),
                                  Consumer<HistoriaClinicaController>(
                                    builder: (_, valueData, __) {
                                      return valueData.getFotoServer == ''
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: GestureDetector(
                                                onTap: () {
                                                  valueData.setPickFiless();
                                                },
                                                child: Consumer<AppTheme>(builder: (_, valueTheme, __) {  
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
                                          Icons.upload_file_outlined,
                                          color: valueTheme.getSecondryTextColor,
                                          size: size.iScreen(2.0),
                                        ),
                                      );
                                    },
                                    )
                                               
                                              ),
                                            )
                                          : Container();
                                    },
                                  ),
                                ],
                              ),
                            ),
                            //*****************************************/
                            SizedBox(
                              height: size.iScreen(1.0),
                            ),
                            //*****************************************/
    
                            Consumer<HistoriaClinicaController>(
                              builder: (_, valueFiles, __) {
                                return valueFiles.getFilesPicker != null
                                    // ? valueFiles.getFilesPicker!.extension ==
                                    //         'pdf'
                                    ? valueFiles.getFotoServer != ''
                                        ? Container(
                                            width: size.wScreen(100),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: size.iScreen(1.0),
                                                vertical: size.iScreen(0.0)),
                                            // color: Colors.grey[300],
                                            child:
                                                // valueFiles.getFilesPicker!=null?
                                                SizedBox(
                                              width: size.wScreen(100),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      IconButton(
                                                          onPressed: () {
                                                         
                                                            // valueFiles
                                                            //     .uploadImageHTTP(
                                                            //         '${valueFiles.getFotoServer}');

                                                            valueFiles
                                                                .deleteDoc(
                                                                    '${valueFiles.getFotoServer}');

                                                            // print('${valueFiles.getFotoServer}');
                                                          },
                                                          icon: const Icon(
                                                              Icons
                                                                  .delete_forever,
                                                              color: Colors.red)),
                                                      //*****************************************/
                                                      SizedBox(
                                                        width: size.iScreen(1.5),
                                                      ),
                                                      //*****************************************/
                                                      Expanded(
                                                        child: Text(
                                                            // '${valueFiles.getFilesPicker!.name.toString()}  - ${valueFiles.getSizeFile} ',
                                                            'Archivo Seleccionado - ${valueFiles.getSizeFile} ',
                                                            style: GoogleFonts
                                                                .lexendDeca(
                                                                    // fontSize: size.iScreen(2.0),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black54)),
                                                      ),
                                                      //*****************************************/
                                                      SizedBox(
                                                        width: size.iScreen(1.5),
                                                      ),
                                                      //*****************************************/
                                                      IconButton(
                                                          onPressed: () {
                                                            // Navigator.push(
                                                            //   context,
                                                            //   MaterialPageRoute(
                                                            //       builder: (context) =>
                                                            //           ViewsPDFs(
                                                            //               infoPdf:
                                                                         
                                                            //               'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
                                                            //               )),
                                                            // );
                                                               Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) => ViewsPDFs(
                                                                infoPdf:
                                                                    'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
                                                                labelPdf: 'archivo.pdf'
                                                               
                                                                )),
                                                      );
                                                          },
                                                          icon: const Icon(Icons
                                                              .remove_red_eye_outlined))
                                                    ],
                                                  ),
                                                  //*****************************************/
                                                  SizedBox(
                                                    height: size.iScreen(2.5),
                                                  ),
                                                  //*****************************************/
                                                ],
                                              ),
                                            ))
                                        : Center(
                                            child: Text(
                                                'Solo de admite formato PDF ',
                                                style: GoogleFonts.lexendDeca(
                                                    // fontSize: size.iScreen(2.0),
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black54)))
                                    : Center(
                                        child: Text(
                                            'No hay Archivo seleccionado ',
                                            style: GoogleFonts.lexendDeca(
                                                // fontSize: size.iScreen(2.0),
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black54)));
                              },
                            ),
                          
                          
                          
                          
                            //******************************/
                            SizedBox(
                              height: size.iScreen(1.0),
                            ),
                            //*****************************************/
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: size.iScreen(1.0),
                                  horizontal: size.iScreen(1.0)),
                              width: size.wScreen(100.0),
                              color: Colors.grey[200],
                              child: SizedBox(
                                // color: Colors.blue,
                                child: Text('CHECK 1 ',
                                    style: GoogleFonts.lexendDeca(
                                        // fontSize: size.iScreen(2.0),
                                        fontWeight: FontWeight.normal,
                                        color: Colors.grey)),
                              ),
                            ),
                            //***********************************************/
                            SizedBox(
                              height: size.iScreen(1.0),
                            ),
                            //*****************************************/
    
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                           
                                Column(
                                  children: [
                                    Container(
                                      // width: size.wScreen(22.0),
    
                                      // color: Colors.blue,
                                      child: Text('Temperatura',
                                          style: GoogleFonts.lexendDeca(
                                              // fontSize: size.iScreen(2.0),
                                              fontWeight: FontWeight.normal,
                                              color: Colors.grey)),
                                    ),
                                    Container(
                                      width: size.wScreen(20.0),
                                      child: TextFormField(
                                        initialValue: widget.tipo == 'CREATE'
                                            ? ''
                                            : controllerHistoria.getTemperatura,
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
                                          controllerHistoria.setTemperatura(text);
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
                                Column(
                                  children: [
                                    Container(
                                      // width: size.wScreen(22.0),
    
                                      // color: Colors.blue,
                                      child: Text('Hidratación',
                                          style: GoogleFonts.lexendDeca(
                                              // fontSize: size.iScreen(2.0),
                                              fontWeight: FontWeight.normal,
                                              color: Colors.grey)),
                                    ),
                                    Container(
                                      width: size.wScreen(20.0),
                                      child: TextFormField(
                                        initialValue: widget.tipo == 'CREATE'
                                            ? ''
                                            : controllerHistoria.getHidratacion,
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
                                          controllerHistoria.setHidratacion(text);
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
                              ],
                            ),
                            //***********************************************/
                            SizedBox(
                              height: size.iScreen(1.5),
                            ),
                            //*****************************************/
    
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      // width: size.wScreen(20.0),
    
                                      // color: Colors.blue,
                                      child: Text('Fecuencia Card.',
                                          style: GoogleFonts.lexendDeca(
                                              // fontSize: size.iScreen(2.0),
                                              fontWeight: FontWeight.normal,
                                              color: Colors.grey)),
                                    ),
                                    Container(
                                      width: size.wScreen(20.0),
                                      child: TextFormField(
                                        initialValue: widget.tipo == 'CREATE'
                                            ? ''
                                            : controllerHistoria
                                                .getFrecuenciaCardiaca,
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
                                          controllerHistoria
                                              .setFrecuenciaCardiaca(text);
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
                                Column(
                                  children: [
                                    Container(
                                      // width: size.wScreen(22.0),
    
                                      // color: Colors.blue,
                                      child: Text('Pulso',
                                          style: GoogleFonts.lexendDeca(
                                              // fontSize: size.iScreen(2.0),
                                              fontWeight: FontWeight.normal,
                                              color: Colors.grey)),
                                    ),
                                    Container(
                                      width: size.wScreen(20.0),
                                      child: TextFormField(
                                        initialValue: widget.tipo == 'CREATE'
                                            ? ''
                                            : controllerHistoria.getPulso,
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
                                          controllerHistoria.setPulso(text);
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
                                Column(
                                  children: [
                                    Container(
                                      // width: size.wScreen(22.0),
    
                                      // color: Colors.blue,
                                      child: Text('Frecuencia Resp.',
                                          style: GoogleFonts.lexendDeca(
                                              // fontSize: size.iScreen(2.0),
                                              fontWeight: FontWeight.normal,
                                              color: Colors.grey)),
                                    ),
                                    Container(
                                      width: size.wScreen(20.0),
                                      child: TextFormField(
                                        initialValue: widget.tipo == 'CREATE'
                                            ? ''
                                            : controllerHistoria
                                                .getFrecuenciaRespiratoria,
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
                                          controllerHistoria
                                              .setFrecuenciaRespiratoria(text);
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
                              ],
                            ),
                            //***********************************************/
                            SizedBox(
                              height: size.iScreen(1.5),
                            ),
                            //*****************************************/
    
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      // width: size.wScreen(20.0),
    
                                      // color: Colors.blue,
                                      child: Text('General',
                                          style: GoogleFonts.lexendDeca(
                                              // fontSize: size.iScreen(2.0),
                                              fontWeight: FontWeight.normal,
                                              color: Colors.grey)),
                                    ),
                                    Container(
                                      width: size.wScreen(20.0),
                                      child: TextFormField(
                                        initialValue: widget.tipo == 'CREATE'
                                            ? ''
                                            : controllerHistoria.getGeneral,
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
                                          controllerHistoria.setGeneral(text);
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
                                Column(
                                  children: [
                                    Container(
                                      // width: size.wScreen(22.0),
    
                                      // color: Colors.blue,
                                      child: Text('Foong',
                                          style: GoogleFonts.lexendDeca(
                                              // fontSize: size.iScreen(2.0),
                                              fontWeight: FontWeight.normal,
                                              color: Colors.grey)),
                                    ),
                                    Container(
                                      width: size.wScreen(20.0),
                                      child: TextFormField(
                                        initialValue: widget.tipo == 'CREATE'
                                            ? ''
                                            : controllerHistoria.getFoong,
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
                                          controllerHistoria.setFoong(text);
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
                                Column(
                                  children: [
                                    Container(
                                      // width: size.wScreen(22.0),
    
                                      // color: Colors.blue,
                                      child: Text('TP',
                                          style: GoogleFonts.lexendDeca(
                                              // fontSize: size.iScreen(2.0),
                                              fontWeight: FontWeight.normal,
                                              color: Colors.grey)),
                                    ),
                                    Container(
                                      width: size.wScreen(20.0),
                                      child: TextFormField(
                                        initialValue: widget.tipo == 'CREATE'
                                            ? ''
                                            : controllerHistoria.getTP,
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
                                          controllerHistoria.setTP(text);
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
                              ],
                            ),
                            //***********************************************/
                            SizedBox(
                              height: size.iScreen(1.5),
                            ),
                            //*****************************************/
    
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      // width: size.wScreen(20.0),
    
                                      // color: Colors.blue,
                                      child: Text('ME',
                                          style: GoogleFonts.lexendDeca(
                                              // fontSize: size.iScreen(2.0),
                                              fontWeight: FontWeight.normal,
                                              color: Colors.grey)),
                                    ),
                                    Container(
                                      width: size.wScreen(20.0),
                                      child: TextFormField(
                                        initialValue: widget.tipo == 'CREATE'
                                            ? ''
                                            : controllerHistoria.getMe,
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
                                          controllerHistoria.setMe(text);
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
                                Column(
                                  children: [
                                    Container(
                                      // width: size.wScreen(22.0),
    
                                      // color: Colors.blue,
                                      child: Text('Cardio Vascular',
                                          style: GoogleFonts.lexendDeca(
                                              // fontSize: size.iScreen(2.0),
                                              fontWeight: FontWeight.normal,
                                              color: Colors.grey)),
                                    ),
                                    Container(
                                      width: size.wScreen(20.0),
                                      child: TextFormField(
                                        initialValue: widget.tipo == 'CREATE'
                                            ? ''
                                            : controllerHistoria
                                                .getCardioVascular,
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
                                          controllerHistoria
                                              .setCardioVascular(text);
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
                                Column(
                                  children: [
                                    Container(
                                      // width: size.wScreen(22.0),
    
                                      // color: Colors.blue,
                                      child: Text('Respiratorio',
                                          style: GoogleFonts.lexendDeca(
                                              // fontSize: size.iScreen(2.0),
                                              fontWeight: FontWeight.normal,
                                              color: Colors.grey)),
                                    ),
                                    Container(
                                      width: size.wScreen(20.0),
                                      child: TextFormField(
                                        initialValue: widget.tipo == 'CREATE'
                                            ? ''
                                            : controllerHistoria.getRespiratorio,
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
                                          controllerHistoria
                                              .setRespiratorio(text);
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
                              ],
                            ),
                            //***********************************************/
                            SizedBox(
                              height: size.iScreen(1.5),
                            ),
                            //*****************************************/
    
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      // width: size.wScreen(20.0),
    
                                      // color: Colors.blue,
                                      child: Text('Gastro Intestinal',
                                          style: GoogleFonts.lexendDeca(
                                              // fontSize: size.iScreen(2.0),
                                              fontWeight: FontWeight.normal,
                                              color: Colors.grey)),
                                    ),
                                    Container(
                                      width: size.wScreen(20.0),
                                      child: TextFormField(
                                        initialValue: widget.tipo == 'CREATE'
                                            ? ''
                                            : controllerHistoria
                                                .getGastroIntestinal,
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
                                          controllerHistoria
                                              .setGastroIntestinal(text);
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
    
                                Column(
                                  children: [
                                    Container(
                                      // width: size.wScreen(22.0),
    
                                      // color: Colors.blue,
                                      child: Text('GR',
                                          style: GoogleFonts.lexendDeca(
                                              // fontSize: size.iScreen(2.0),
                                              fontWeight: FontWeight.normal,
                                              color: Colors.grey)),
                                    ),
                                    Container(
                                      width: size.wScreen(20.0),
                                      child: TextFormField(
                                        initialValue: widget.tipo == 'CREATE'
                                            ? ''
                                            : controllerHistoria.getGR,
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
                                          controllerHistoria.setGR(text);
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
                                // Column(
                                //   children: [
                                //     Container(
                                //       // width: size.wScreen(22.0),
    
                                //       // color: Colors.blue,
                                //       child: Text('Respiratorio',
                                //           style: GoogleFonts.lexendDeca(
                                //               // fontSize: size.iScreen(2.0),
                                //               fontWeight: FontWeight.normal,
                                //               color: Colors.grey)),
                                //     ),
                                //     Container(
                                //       width: size.wScreen(20.0),
                                //       child:
                                //          TextFormField(
                                //         initialValue: widget.tipo == 'CREATE'
                                //             ? ''
                                //             : controllerHistoria.getPesoMascota,
                                //         keyboardType: TextInputType.number,
                                //         inputFormatters: <TextInputFormatter>[
                                //           FilteringTextInputFormatter.allow(
                                //               RegExp(r'[0-9.]')),
                                //         ],
                                //         decoration: const InputDecoration(
                                //             // suffixIcon: Icon(Icons.beenhere_outlined)
                                //             ),
                                //         textAlign: TextAlign.center,
                                //         style: TextStyle(
                                //           fontSize: size.iScreen(2.0),
                                //           // fontWeight: FontWeight.bold,
                                //           // letterSpacing: 2.0,
                                //         ),
                                //         onChanged: (text) {
                                //           controllerHistoria.setRespiratorio(text);
                                //         },
                                //         // validator: (text) {
                                //         //   if (text!.trim().isNotEmpty) {
                                //         //     return null;
                                //         //   } else {
                                //         //     return 'Ingrese peso de la mascota';
                                //         //   }
                                //         // },
                                //       ),
                                //     ),
                                //   ],
                                // ),
                              ],
                            ),
                            //******************************/
                            SizedBox(
                              height: size.iScreen(1.0),
                            ),
                            //*****************************************/
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: size.iScreen(1.0),
                                  horizontal: size.iScreen(1.0)),
                              width: size.wScreen(100.0),
                              color: Colors.grey[200],
                              child: SizedBox(
                                // color: Colors.blue,
                                child: Text('CHECK 2 ',
                                    style: GoogleFonts.lexendDeca(
                                        // fontSize: size.iScreen(2.0),
                                        fontWeight: FontWeight.normal,
                                        color: Colors.grey)),
                              ),
                            ),
                            //***********************************************/
                            SizedBox(
                              height: size.iScreen(1.0),
                            ),
                            //*****************************************/
    
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      // width: size.wScreen(20.0),
    
                                      // color: Colors.blue,
                                      child: Text('Neurológico',
                                          style: GoogleFonts.lexendDeca(
                                              // fontSize: size.iScreen(2.0),
                                              fontWeight: FontWeight.normal,
                                              color: Colors.grey)),
                                    ),
                                    Container(
                                      width: size.wScreen(20.0),
                                      child: TextFormField(
                                        initialValue: widget.tipo == 'CREATE'
                                            ? ''
                                            : controllerHistoria.getNeurologico,
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
                                          controllerHistoria.setNeurologico(text);
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
                                Column(
                                  children: [
                                    Container(
                                      // width: size.wScreen(22.0),
    
                                      // color: Colors.blue,
                                      child: Text('Linfático',
                                          style: GoogleFonts.lexendDeca(
                                              // fontSize: size.iScreen(2.0),
                                              fontWeight: FontWeight.normal,
                                              color: Colors.grey)),
                                    ),
                                    Container(
                                      width: size.wScreen(20.0),
                                      child: TextFormField(
                                        initialValue: widget.tipo == 'CREATE'
                                            ? ''
                                            : controllerHistoria.getLinfatico,
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
                                          controllerHistoria.setLinfatico(text);
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
                                Column(
                                  children: [
                                    Container(
                                      // width: size.wScreen(22.0),
    
                                      // color: Colors.blue,
                                      child: Text('Patrón Respiratorio',
                                          style: GoogleFonts.lexendDeca(
                                              // fontSize: size.iScreen(2.0),
                                              fontWeight: FontWeight.normal,
                                              color: Colors.grey)),
                                    ),
                                    Container(
                                      width: size.wScreen(20.0),
                                      child: TextFormField(
                                        initialValue: widget.tipo == 'CREATE'
                                            ? ''
                                            : controllerHistoria
                                                .getPatronRespitarorio,
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
                                          controllerHistoria
                                              .setPatronRespitarorio(text);
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
                              ],
                            ),
                            //***********************************************/
                            SizedBox(
                              height: size.iScreen(1.5),
                            ),
                            //*****************************************/
    
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      // width: size.wScreen(20.0),
    
                                      // color: Colors.blue,
                                      child: Text('Grasgow Modificaco',
                                          style: GoogleFonts.lexendDeca(
                                              // fontSize: size.iScreen(2.0),
                                              fontWeight: FontWeight.normal,
                                              color: Colors.grey)),
                                    ),
                                    Container(
                                      width: size.wScreen(20.0),
                                      child: TextFormField(
                                        initialValue: widget.tipo == 'CREATE'
                                            ? ''
                                            : controllerHistoria
                                                .getGrasgowModificado,
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
                                          controllerHistoria
                                              .setGrasgowModificado(text);
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
                                Column(
                                  children: [
                                    Container(
                                      // width: size.wScreen(22.0),
    
                                      // color: Colors.blue,
                                      child: Text('Ritmo Cardiaco',
                                          style: GoogleFonts.lexendDeca(
                                              // fontSize: size.iScreen(2.0),
                                              fontWeight: FontWeight.normal,
                                              color: Colors.grey)),
                                    ),
                                    Container(
                                      width: size.wScreen(20.0),
                                      child: TextFormField(
                                        initialValue: widget.tipo == 'CREATE'
                                            ? ''
                                            : controllerHistoria.getRitmoCardiaco,
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
                                          controllerHistoria
                                              .setRitmoCardiaco(text);
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
                                Column(
                                  children: [
                                    Container(
                                      // width: size.wScreen(22.0),
    
                                      // color: Colors.blue,
                                      child: Text('Reflejo Pupilar',
                                          style: GoogleFonts.lexendDeca(
                                              // fontSize: size.iScreen(2.0),
                                              fontWeight: FontWeight.normal,
                                              color: Colors.grey)),
                                    ),
                                    Container(
                                      width: size.wScreen(20.0),
                                      child: TextFormField(
                                        initialValue: widget.tipo == 'CREATE'
                                            ? ''
                                            : controllerHistoria
                                                .getReflejoPupilar,
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
                                          controllerHistoria
                                              .setReflejoPupilar(text);
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
                              ],
                            ),
                            //***********************************************/
                            SizedBox(
                              height: size.iScreen(1.5),
                            ),
                            //*****************************************/
    
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      // width: size.wScreen(20.0),
    
                                      // color: Colors.blue,
                                      child: Text('Reflejo Tusigeno',
                                          style: GoogleFonts.lexendDeca(
                                              // fontSize: size.iScreen(2.0),
                                              fontWeight: FontWeight.normal,
                                              color: Colors.grey)),
                                    ),
                                    Container(
                                      width: size.wScreen(20.0),
                                      child: TextFormField(
                                        initialValue: widget.tipo == 'CREATE'
                                            ? ''
                                            : controllerHistoria
                                                .getReflejotusigeno,
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
                                          controllerHistoria
                                              .setReflejotusigeno(text);
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
                                Column(
                                  children: [
                                    Container(
                                      // width: size.wScreen(22.0),
    
                                      // color: Colors.blue,
                                      child: Text('T. llenado Vascular',
                                          style: GoogleFonts.lexendDeca(
                                              // fontSize: size.iScreen(2.0),
                                              fontWeight: FontWeight.normal,
                                              color: Colors.grey)),
                                    ),
                                    Container(
                                      width: size.wScreen(20.0),
                                      child: TextFormField(
                                        initialValue: widget.tipo == 'CREATE'
                                            ? ''
                                            : controllerHistoria
                                                .getLlenadoVascular,
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
                                          controllerHistoria
                                              .setLlenadoVascular(text);
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
                                Column(
                                  children: [
                                    Container(
                                      // width: size.wScreen(22.0),
    
                                      // color: Colors.blue,
                                      child: Text('Color Mascota',
                                          style: GoogleFonts.lexendDeca(
                                              // fontSize: size.iScreen(2.0),
                                              fontWeight: FontWeight.normal,
                                              color: Colors.grey)),
                                    ),
                                    Container(
                                      width: size.wScreen(20.0),
                                      child: TextFormField(
                                        initialValue: widget.tipo == 'CREATE'
                                            ? ''
                                            : controllerHistoria.getColorMacota,
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
                                          controllerHistoria.setColorMacota(text);
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
                              ],
                            ),
                            //***********************************************/
                            SizedBox(
                              height: size.iScreen(1.5),
                            ),
                            //*****************************************/
    
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      // width: size.wScreen(20.0),
    
                                      // color: Colors.blue,
                                      child: Text('Amígdalas',
                                          style: GoogleFonts.lexendDeca(
                                              // fontSize: size.iScreen(2.0),
                                              fontWeight: FontWeight.normal,
                                              color: Colors.grey)),
                                    ),
                                    Container(
                                      width: size.wScreen(20.0),
                                      child: TextFormField(
                                        initialValue: widget.tipo == 'CREATE'
                                            ? ''
                                            : controllerHistoria.getAmigdalas,
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
                                          controllerHistoria.setAmigdalas(text);
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
                                Column(
                                  children: [
                                    Container(
                                      // width: size.wScreen(22.0),
    
                                      // color: Colors.blue,
                                      child: Text('Dolor Paciente',
                                          style: GoogleFonts.lexendDeca(
                                              // fontSize: size.iScreen(2.0),
                                              fontWeight: FontWeight.normal,
                                              color: Colors.grey)),
                                    ),
                                    Container(
                                      width: size.wScreen(20.0),
                                      child: TextFormField(
                                        initialValue: widget.tipo == 'CREATE'
                                            ? ''
                                            : controllerHistoria.getDolorPaciente,
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
                                          controllerHistoria
                                              .setDolorPaciente(text);
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
                                Column(
                                  children: [
                                    Container(
                                      // width: size.wScreen(22.0),
    
                                      // color: Colors.blue,
                                      child: Text('Lesiones',
                                          style: GoogleFonts.lexendDeca(
                                              // fontSize: size.iScreen(2.0),
                                              fontWeight: FontWeight.normal,
                                              color: Colors.grey)),
                                    ),
                                    Container(
                                      width: size.wScreen(20.0),
                                      child: TextFormField(
                                        initialValue: widget.tipo == 'CREATE'
                                            ? ''
                                            : controllerHistoria.getLesiones,
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
                                          controllerHistoria.setLesiones(text);
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
                              ],
                            ),
                            //***********************************************/
                            SizedBox(
                              height: size.iScreen(1.5),
                            ),
                            //*****************************************/
    
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      // width: size.wScreen(20.0),
    
                                      // color: Colors.blue,
                                      child: Text('PAS/PAM/PAD',
                                          style: GoogleFonts.lexendDeca(
                                              // fontSize: size.iScreen(2.0),
                                              fontWeight: FontWeight.normal,
                                              color: Colors.grey)),
                                    ),
                                    Container(
                                      width: size.wScreen(20.0),
                                      child: TextFormField(
                                        initialValue: widget.tipo == 'CREATE'
                                            ? ''
                                            : controllerHistoria.getPasPamPad,
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
                                          controllerHistoria.setPasPamPad(text);
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
    
                                Column(
                                  children: [
                                    Container(
                                      // width: size.wScreen(22.0),
    
                                      // color: Colors.blue,
                                      child: Text('Otros',
                                          style: GoogleFonts.lexendDeca(
                                              // fontSize: size.iScreen(2.0),
                                              fontWeight: FontWeight.normal,
                                              color: Colors.grey)),
                                    ),
                                    Container(
                                      width: size.wScreen(20.0),
                                      child: TextFormField(
                                        initialValue: widget.tipo == 'CREATE'
                                            ? ''
                                            : controllerHistoria.getOtros,
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
                                          controllerHistoria.setOtros(text);
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
                                // Column(
                                //   children: [
                                //     Container(
                                //       // width: size.wScreen(22.0),
    
                                //       // color: Colors.blue,
                                //       child: Text('Respiratorio',
                                //           style: GoogleFonts.lexendDeca(
                                //               // fontSize: size.iScreen(2.0),
                                //               fontWeight: FontWeight.normal,
                                //               color: Colors.grey)),
                                //     ),
                                //     Container(
                                //       width: size.wScreen(20.0),
                                //       child:
                                //          TextFormField(
                                //         initialValue: widget.tipo == 'CREATE'
                                //             ? ''
                                //             : controllerHistoria.getPesoMascota,
                                //         keyboardType: TextInputType.number,
                                //         inputFormatters: <TextInputFormatter>[
                                //           FilteringTextInputFormatter.allow(
                                //               RegExp(r'[0-9.]')),
                                //         ],
                                //         decoration: const InputDecoration(
                                //             // suffixIcon: Icon(Icons.beenhere_outlined)
                                //             ),
                                //         textAlign: TextAlign.center,
                                //         style: TextStyle(
                                //           fontSize: size.iScreen(2.0),
                                //           // fontWeight: FontWeight.bold,
                                //           // letterSpacing: 2.0,
                                //         ),
                                //         onChanged: (text) {
                                //           controllerHistoria.setRespiratorio(text);
                                //         },
                                //         // validator: (text) {
                                //         //   if (text!.trim().isNotEmpty) {
                                //         //     return null;
                                //         //   } else {
                                //         //     return 'Ingrese peso de la mascota';
                                //         //   }
                                //         // },
                                //       ),
                                //     ),
                                //   ],
                                // ),
                              ],
                            ),
                            //***********************************************/
                            SizedBox(
                              height: size.iScreen(1.5),
                            ),
                            //*****************************************/
                            Container(
                              width: size.wScreen(100.0),
    
                              // color: Colors.blue,
                              child: Text('Tratamiento',
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
                                    : controllerHistoria.getTratamiento,
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
                                  controllerHistoria.setTratamiento(text);
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
    
                            // //***********************************************//
                            // SizedBox(
                            //   height: size.iScreen(2.0),
                            // ),
                            // //***********************************************//
    
                            // Container(
                            //   padding: EdgeInsets.symmetric(
                            //       vertical: size.iScreen(1.0),
                            //       horizontal: size.iScreen(1.0)),
                            //   width: size.wScreen(100.0),
                            //   color: Colors.grey[200],
                            //   child: Row(
                            //     children: [
                            //       SizedBox(
                            //         // color: Colors.blue,
                            //         child: Text('Subir Archivo ',
                            //             style: GoogleFonts.lexendDeca(
                            //                 // fontSize: size.iScreen(2.0),
                            //                 fontWeight: FontWeight.normal,
                            //                 color: Colors.grey)),
                            //       ),
                            //       SizedBox(
                            //         width: size.iScreen(2.0),
                            //       ),
                            //       Consumer<HistoriaClinicaController>(
                            //         builder: (_, valueData, __) {
                            //           return valueData.getFotoServer == ''
                            //               ? ClipRRect(
                            //                   borderRadius:
                            //                       BorderRadius.circular(8),
                            //                   child: GestureDetector(
                            //                     onTap: () {
                            //                       valueData.setPickFiless();
                            //                     },
                            //                     child: Container(
                            //                       alignment: Alignment.center,
                            //                       color: primaryColor,
                            //                       width: size.iScreen(4.0),
                            //                       padding: EdgeInsets.only(
                            //                         top: size.iScreen(0.5),
                            //                         bottom: size.iScreen(0.5),
                            //                         left: size.iScreen(0.5),
                            //                         right: size.iScreen(0.5),
                            //                       ),
                            //                       child: Icon(
                            //                         Icons.upload_file_outlined,
                            //                         color: Colors.white,
                            //                         size: size.iScreen(3.0),
                            //                       ),
                            //                     ),
                            //                   ),
                            //                 )
                            //               : Container();
                            //         },
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // //*****************************************/
                            // SizedBox(
                            //   height: size.iScreen(1.0),
                            // ),
                            // //*****************************************/
    
                            // Consumer<HistoriaClinicaController>(
                            //   builder: (_, valueFiles, __) {
                            //     return valueFiles.getFilesPicker != null
                            //         // ? valueFiles.getFilesPicker!.extension ==
                            //         //         'pdf'
                            //         ? valueFiles.getFotoServer != ''
                            //             ? Container(
                            //                 width: size.wScreen(100),
                            //                 padding: EdgeInsets.symmetric(
                            //                     horizontal: size.iScreen(1.0),
                            //                     vertical: size.iScreen(0.0)),
                            //                 // color: Colors.grey[300],
                            //                 child:
                            //                     // valueFiles.getFilesPicker!=null?
                            //                     SizedBox(
                            //                   width: size.wScreen(100),
                            //                   child: Column(
                            //                     children: [
                            //                       Row(
                            //                         mainAxisAlignment:
                            //                             MainAxisAlignment
                            //                                 .spaceBetween,
                            //                         children: [
                            //                           IconButton(
                            //                               onPressed: () {
                            //                                 // valueFiles
                            //                                 //     .deleteFile();
                            //                                 // valueFiles.deleteFileServer('${valueFiles.getFotoServer}');
                            //                                 valueFiles
                            //                                     .uploadImageHTTP(
                            //                                         '${valueFiles.getFotoServer}');
                            //                               },
                            //                               icon: const Icon(
                            //                                   Icons
                            //                                       .delete_forever,
                            //                                   color: Colors.red)),
                            //                           //*****************************************/
                            //                           SizedBox(
                            //                             width: size.iScreen(1.5),
                            //                           ),
                            //                           //*****************************************/
                            //                           Expanded(
                            //                             child: Text(
                            //                                 // '${valueFiles.getFilesPicker!.name.toString()}  - ${valueFiles.getSizeFile} ',
                            //                                 'Archivo Seleccionado - ${valueFiles.getSizeFile} ',
                            //                                 style: GoogleFonts
                            //                                     .lexendDeca(
                            //                                         // fontSize: size.iScreen(2.0),
                            //                                         fontWeight:
                            //                                             FontWeight
                            //                                                 .bold,
                            //                                         color: Colors
                            //                                             .black54)),
                            //                           ),
                            //                           //*****************************************/
                            //                           SizedBox(
                            //                             width: size.iScreen(1.5),
                            //                           ),
                            //                           //*****************************************/
                            //                           IconButton(
                            //                               onPressed: () {
                            //                                 Navigator.push(
                            //                                   context,
                            //                                   MaterialPageRoute(
                            //                                       builder: (context) =>
                            //                                           ViewsPDFs(
                            //                                               infoPdf:
                            //                                                   '${valueFiles.getFotoServer}'
                            //                                               // 'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
                            //                                               )),
                            //                                 );
                            //                               },
                            //                               icon: Icon(Icons
                            //                                   .remove_red_eye_outlined))
                            //                         ],
                            //                       ),
                            //                       //*****************************************/
                            //                       SizedBox(
                            //                         height: size.iScreen(2.5),
                            //                       ),
                            //                       //*****************************************/
                            //                     ],
                            //                   ),
                            //                 ))
                            //             : Center(
                            //                 child: Text(
                            //                     'Solo de admite formato PDF ',
                            //                     style: GoogleFonts.lexendDeca(
                            //                         // fontSize: size.iScreen(2.0),
                            //                         fontWeight: FontWeight.bold,
                            //                         color: Colors.black54)))
                            //         : Center(
                            //             child: Text(
                            //                 'No hay Archivo seleccionado ',
                            //                 style: GoogleFonts.lexendDeca(
                            //                     // fontSize: size.iScreen(2.0),
                            //                     fontWeight: FontWeight.bold,
                            //                     color: Colors.black54)));
                            //   },
                            // ),
                          
                          
                          
                          
                          
                          
                          
                          ],
                        ),
                      ),
                    )
                  
            
            
            ),
      ),
    );
  }

  //********************************************************************************************************************//
  void _onSubmit(BuildContext context, HistoriaClinicaController controller,
  ) async {
    final isValid = controller.validateFormHistClinica();
    if (!isValid) return;
    if (isValid) {
      if (controller.getNombreMascota == "") {
        NotificatiosnService.showSnackBarDanger('Debe seleccionar Mascota');
      } else if (controller.getVetInternoNombre == "") {
        NotificatiosnService.showSnackBarDanger(
            'Debe seleccionar Veterinario Interno');
      } else if (controller.getTipoConsulta == "") {
        NotificatiosnService.showSnackBarDanger(
            'Debe seleccionar Motivo de consulta');
      }

      if (controller.getNombreMascota != "" &&
          controller.getVetInternoNombre != "" &&
          controller.getTipoConsulta != "") {
        //   if (image != null) {
        //     ProgressDialog.show(context);
        //     controller.setNewPictureFile(image);
        //     await controller.upLoadImagen();
        //   }

        //   ProgressDialog.dissmiss(context);
        if (widget.tipo == 'CREATE') {
          await controller.creaHistoriaClinica(context);
          Navigator.pop(context);
        }
        if (widget.tipo == 'EDIT') {
          await controller.editaHistoriaClinica(context);
          Navigator.pop(context);
        }
      }
    }
  }

  //********************************************************************************************************************//
  _fecha(BuildContext context, HistoriaClinicaController controller) async {

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
      controller.onInputFechaChange(_fechaInicio);
      // print('FechaInicio: $_fechaInicio');
      // });
    }
  // }
    // _selectFechaNacimiento(
    //                                     context, controller);
    //================================================= SELECCIONA FECHA INICIO ==================================================//
    // _selectFechaInicio(
    //     BuildContext context, MascotasController mascotaController) async {
    // DateTime? picked = await showDatePicker(
    //   context: context,
    //   initialDate: DateTime.now(),
    //   firstDate: DateTime.now(),
    //   lastDate: DateTime(2100),
    //   // locale: const Locale('es', 'ES'),
    // );
    // if (picked != null) {
    //   String? anio, mes, dia;
    //   anio = '${picked.year}';
    //   mes = (picked.month < 10) ? '0${picked.month}' : '${picked.month}';
    //   dia = (picked.day < 10) ? '0${picked.day}' : '${picked.day}';

    //   // setState(() {
    //   final _fechaInicio =
    //       '${anio.toString()}-${mes.toString()}-${dia.toString()}';
    //   // _fechaController.text = _fechaInicio;
    //   controller.onInputFechaChange(_fechaInicio);

    //   // print('FechaInicio: $_fechaInicio');
    //   // });
    }
  // }

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
                                      .read<HistoriaClinicaController>()
                                      .setMascotaInfo(_mascota);

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
                                      .read<HistoriaClinicaController>()
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

  //******************************************************BUSCA VETERINARIO INTERNO**************************************************************//
  Future<bool?> _buscarTipoConsulta(BuildContext context, Responsive size) {
    return showDialog<bool>(
      barrierColor: Colors.black54,
      context: context,
      builder: (context) {
        // final controller = context.read<PropietariosController>();
        final controllerTConsulta = context.read<HistoriaClinicaController>();

        return AlertDialog(
            title: const Text("BUSCAR TIPO CONSULTA"),
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
                          // keyboardType: TextInputType.emailAddress,
                          // textCapitalization: TextCapitalization.none,

                          // autovalidateMode: AutovalidateMode.onUserInteraction,
                          // // validator: (value) {
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
                            controllerTConsulta.onSearchTextTipoConsulta(text);

                            if (controllerTConsulta
                                .nameSearchTipoConsulta.isEmpty) {
                              controllerTConsulta.buscaAllTipoConsultas('');
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

                          Consumer<HistoriaClinicaController>(
                        builder: (_, providerTipoConsulta, __) {
                          if (providerTipoConsulta.getErrorAllTipoConsultas ==
                              null) {
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
                          } else if (providerTipoConsulta
                                  .getErrorAllTipoConsultas ==
                              false) {
                            return const NoData(
                              label: 'No existen datos para mostar',
                            );
                            // Text("Error al cargar los datos");
                          } else if (providerTipoConsulta
                              .getListaAllTipoConsultas.isEmpty) {
                            return const NoData(
                              label: 'No existen datos para mostar',
                            );
                          }
                          // print('esta es la lista*******************: ${providerTipoConsulta.getListaPropietarios.length}');

                          return ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: providerTipoConsulta
                                .getListaAllTipoConsultas.length,
                            itemBuilder: (BuildContext context, int index) {
                              final _tConsulta = providerTipoConsulta
                                  .getListaAllTipoConsultas[index];
                              return GestureDetector(
                                onTap: () {
                                  context
                                      .read<HistoriaClinicaController>()
                                      .setTipoConsultaInfo(_tConsulta);

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
                                                      '${_tConsulta['consNombre']}',
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

//   void _pickFiless() async{

//     FilePickerResult? _result=await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['jpg','png','pdf'],
//       allowMultiple: true

//     );
//  if(_result==null) return;

// PlatformFile? _file= _result.files.first;

// _viewfile(_file);

//   }
  // void _viewfile(PlatformFile _file) {
  //   OpenFile.open(_file.path);
  // }
}

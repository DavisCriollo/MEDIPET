import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neitorcont/src/controllers/hospitalizacion_controller.dart';
import 'package:neitorcont/src/pages/agregar_horario_parametros.dart';
import 'package:neitorcont/src/services/notifications_service.dart';
import 'package:neitorcont/src/utils/letras_mayusculas_minusculas.dart';
import 'package:neitorcont/src/utils/responsive.dart';
import 'package:neitorcont/src/utils/theme.dart';
import 'package:neitorcont/src/widgets/no_data.dart';

import 'package:provider/provider.dart';

class HorarioParametrosHospitalizacionDTS extends DataTableSource {
  final BuildContext context;
  final List<dynamic> _listaHoraParametros;
  final Responsive size;
  final String? accion;
  final int inicio, frecuencia;
      final bool? detalle;


  HorarioParametrosHospitalizacionDTS(this._listaHoraParametros, this.size,
      this.context, this.accion, this.inicio, this.frecuencia, this.detalle);

  @override
  DataRow? getRow(int index) {
    _listaHoraParametros
        .sort((a, b) => b['idCabeceraParametro'].compareTo(a['idCabeceraParametro']));

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Row(
          children: [

               detalle==true? 
            IconButton(
              onPressed: () {
              //  print('INFO PARAMETRO: ${_listaHoraParametros[index]}');
              
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>  AgregarHorariosParametros(
                          action: 'PARAMETROS',
                          infoItemHora:_listaHoraParametros[index] ,

                        )));
              
              
              
              
              },
              icon: const Icon(
                Icons.edit,
                color: tercearyColor,
              ),
              splashRadius: 20.0,
            ):Container(),
            Text(_listaHoraParametros[index]['fecha']),

            //       GestureDetector(
            //   onTap: () {
            //     final controller = context.read<HospitalizacionController>();
            //     FocusScope.of(context).requestFocus(FocusNode());
            //     _fechaHoraParametros(context, controller);
            //   },
            //   child: Row(
            //     children: [
            //       Consumer<HospitalizacionController>(
            //         builder: (_, valueFechaHoraParametros, __) {
            //           return Text(
            //             valueFechaHoraParametros.getFechaHoraParametros ??
            //                 'yyyy-mm-dd',
            //             style: GoogleFonts.lexendDeca(
            //               fontSize: size.iScreen(1.8),
            //               color: Colors.black45,
            //               fontWeight: FontWeight.bold,
            //             ),
            //           );
            //         },
            //       ),
            //       SizedBox(
            //         width: size.iScreen(1.0),
            //       ),
            //       const Icon(
            //         Icons.date_range_outlined,
            //         color: primaryColor,
            //         size: 30,
            //       ),
            //     ],
            //   ),
            // ),



          ],
        )),
        DataCell(Text(
            // '${_listaHoraParametros[index]['H0']} ${_listaHoraParametros[index]['idCabeceraParametro']}')),
  '${_listaHoraParametros[index]['nameParametrosHorarios']}')),
        // DataCell(Text(_listaHoraParametros[index]['H0'] != ""? _listaHoraParametros[index]['H0']
        //     : '====')),
        // DataCell(Text(_listaHoraParametros[index]['H1'] != ""
        //     ? _listaHoraParametros[index]['H1']
        //     : "===")),
        // DataCell(Text(_listaHoraParametros[index]['H2'] != ""
        //     ? _listaHoraParametros[index]['H2']
        //     : "===")),
        // DataCell(Text(_listaHoraParametros[index]['H3'] != ""
        //     ? _listaHoraParametros[index]['H3']
        //     : "===")),
        // DataCell(Text(_listaHoraParametros[index]['H4'] != ""
        //     ? _listaHoraParametros[index]['H4']
        //     : "===")),
        // DataCell(Text(_listaHoraParametros[index]['H5'] != ""
        //     ? _listaHoraParametros[index]['H5']
        //     : "===")),
        // DataCell(Text(_listaHoraParametros[index]['H6'] != ""
        //     ? _listaHoraParametros[index]['H6']
        //     : "===")),
        // DataCell(Text(_listaHoraParametros[index]['H7'] != ""
        //     ? _listaHoraParametros[index]['H7']
        //     : "===")),
        // DataCell(Text(_listaHoraParametros[index]['H8'] != ""
        //     ? _listaHoraParametros[index]['H8']
        //     : "===")),
        // DataCell(Text(_listaHoraParametros[index]['H9'] != ""
        //     ? _listaHoraParametros[index]['H9']
        //     : "===")),
        // DataCell(Text(_listaHoraParametros[index]['H10'] != ""
        //     ? _listaHoraParametros[index]['H10']
        //     : "===")),
        // DataCell(Text(_listaHoraParametros[index]['H11'] != ""
        //     ? _listaHoraParametros[index]['H11']
        //     : "===")),
        // DataCell(Text(_listaHoraParametros[index]['H12'] != ""
        //     ? _listaHoraParametros[index]['H12']
        //     : "===")),
        // DataCell(Text(_listaHoraParametros[index]['H13'] != ""
        //     ? _listaHoraParametros[index]['H13']
        //     : "===")),
        // DataCell(Text(_listaHoraParametros[index]['H14'] != ""
        //     ? _listaHoraParametros[index]['H14']
        //     : "===")),
        // DataCell(Text(_listaHoraParametros[index]['H15'] != ""
        //     ? _listaHoraParametros[index]['H15']
        //     : "===")),
        // DataCell(Text(_listaHoraParametros[index]['H16'] != ""
        //     ? _listaHoraParametros[index]['H16']
        //     : "===")),
        // DataCell(Text(_listaHoraParametros[index]['H17'] != ""
        //     ? _listaHoraParametros[index]['H17']
        //     : "===")),
        // DataCell(Text(_listaHoraParametros[index]['H18'] != ""
        //     ? _listaHoraParametros[index]['H18']
        //     : "===")),
        // DataCell(Text(_listaHoraParametros[index]['H19'] != ""
        //     ? _listaHoraParametros[index]['H19']
        //     : "===")),
        // DataCell(Text(_listaHoraParametros[index]['H20'] != ""
        //     ? _listaHoraParametros[index]['H20']
        //     : "===")),
        // DataCell(Text(_listaHoraParametros[index]['H21'] != ""
        //     ? _listaHoraParametros[index]['H21']
        //     : "===")),
        // DataCell(Text(_listaHoraParametros[index]['H22'] != ""
        //     ? _listaHoraParametros[index]['H22']
        //     : "===")),
        // DataCell(Text(_listaHoraParametros[index]['H23'] != ""
        //     ? _listaHoraParametros[index]['H23']
        //     : "===")),
          DataCell(Text(_listaHoraParametros[index]['H0']!=""?_listaHoraParametros[index]['H0']:'==='),),
        DataCell(Text(_listaHoraParametros[index]['H1']!=""?_listaHoraParametros[index]['H1']:'===')),
        DataCell(Text(_listaHoraParametros[index]['H2']!=""?_listaHoraParametros[index]['H2']:'===')),
        DataCell(Text(_listaHoraParametros[index]['H3']!=""?_listaHoraParametros[index]['H3']:'===')),
        DataCell(Text(_listaHoraParametros[index]['H4']!=""?_listaHoraParametros[index]['H4']:'===')),
        DataCell(Text(_listaHoraParametros[index]['H5']!=""?_listaHoraParametros[index]['H5']:'===')),
        DataCell(Text(_listaHoraParametros[index]['H6']!=""?_listaHoraParametros[index]['H6']:'===')),
        DataCell(Text(_listaHoraParametros[index]['H7']!=""?_listaHoraParametros[index]['H7']:'===')),
        DataCell(Text(_listaHoraParametros[index]['H8']!=""?_listaHoraParametros[index]['H8']:'===')),
        DataCell(Text(_listaHoraParametros[index]['H9']!=""?_listaHoraParametros[index]['H9']:'===')),
        DataCell(Text(_listaHoraParametros[index]['H10']!=""?_listaHoraParametros[index]['H10']:'===')),
        DataCell(Text(_listaHoraParametros[index]['H11']!=""?_listaHoraParametros[index]['H11']:'===')),
        DataCell(Text(_listaHoraParametros[index]['H12']!=""?_listaHoraParametros[index]['H12']:'===')),
        DataCell(Text(_listaHoraParametros[index]['H13']!=""?_listaHoraParametros[index]['H13']:'===')),
        DataCell(Text(_listaHoraParametros[index]['H14']!=""?_listaHoraParametros[index]['H14']:'===')),
        DataCell(Text(_listaHoraParametros[index]['H15']!=""?_listaHoraParametros[index]['H15']:'===')),
        DataCell(Text(_listaHoraParametros[index]['H16']!=""?_listaHoraParametros[index]['H16']:'===')),
        DataCell(Text(_listaHoraParametros[index]['H17']!=""?_listaHoraParametros[index]['H17']:'===')),
        DataCell(Text(_listaHoraParametros[index]['H18']!=""?_listaHoraParametros[index]['H18']:'===')),
        DataCell(Text(_listaHoraParametros[index]['H19']!=""?_listaHoraParametros[index]['H19']:'===')),
        DataCell(Text(_listaHoraParametros[index]['H20']!=""?_listaHoraParametros[index]['H20']:'===')),
        DataCell(Text(_listaHoraParametros[index]['H21']!=""?_listaHoraParametros[index]['H21']:'===')),
        DataCell(Text(_listaHoraParametros[index]['H22']!=""?_listaHoraParametros[index]['H22']:'===')),
        DataCell(Text(_listaHoraParametros[index]['H23']!=""?_listaHoraParametros[index]['H23']:'===')),
      ],
     
    );
  }

  void _eliminaRow(int index) {
    context
        .read<HospitalizacionController>()
        .eliminaParametroAgregada(_listaHoraParametros[index]['idCabeceraParametro']);
  }

//**********************************************BUSCA MASCOTA **********************************************************************//
  // Future<bool?> _agregaHorarios(
  //     BuildContext context, Responsive size, int _inicio, int _frecuencia, int _idCabeceraParametro ) {
  //   return showDialog<bool>(
  //       barrierColor: Colors.black54,
  //       context: context,
  //       builder: (context) {
           
  //         final controllerHospitalizacion =
  //             context.read<HospitalizacionController>();
  //         final List horariosParametro = [];
  //         final List horariosAux = [];
  //         for (var i = 0; i <= 23; i++) {
  //           horariosAux.add(i);
  //         }
        

  //         var _data = horariosAux.where((x) => x <= _inicio);
  //         var _dataCon = horariosAux.where((x) => x >= _inicio);
  //         final List<dynamic> _horariosParametro = [];
  //         final List<dynamic> _auxParametroFercuencia = [];
     
  //         _horariosParametro.addAll(_data.toList());
  //         _auxParametroFercuencia.addAll(_dataCon.toList());


  //         horariosParametro.addAll(_horariosParametro);
      

  //         var i = 1;
  //         while (i <= _auxParametroFercuencia.length) {
  //           horariosParametro.add(_auxParametroFercuencia[i - 1] += _frecuencia);

  //           i += _frecuencia;
  //         }



  //         return AlertDialog(
  //             // title:  Text("AGREGUE FRECUENCIA $_idCabeceraParametro . $_inicio . $_frecuencia "),
  //              title: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 const Expanded(child: Text("INGRESE HORARIO")),
  //                 IconButton(
  //                     splashRadius: 25.0,
  //                     onPressed: () {
  //                       final controlls=context.read<HospitalizacionController>();
  //                         controlls.setInfoRowHorarioParametro(_idCabeceraParametro);
  //                     Navigator.pop(context);
                        
  //                     },
  //                     icon: Icon(Icons.save_outlined,
  //                         size: size.iScreen(3.5), color: primaryColor)),
  //               ],
  //             ),
  //             content: SingleChildScrollView(
  //               physics: const BouncingScrollPhysics(),
  //               child: Center(
  //                 child: Wrap(
  //                     alignment: WrapAlignment.start,
  //                     direction: Axis.horizontal,
  //                     children: 
  //                     List.generate(24, (index) {
  //                       return Column(
  //                         // mainAxisAlignment: MainAxisAlignment.center,
  //                         children: [
  //                           //***********************************************/
  //                           SizedBox(
  //                             height: size.iScreen(1.5),
  //                           ),
  //                           //*****************************************/
  //                           Container(
  //                             width: size.wScreen(5.0),

  //                             // color: Colors.blue,
  //                             // child: Text('${index * _frecuencia+1}',
  //                             child: Text('$index',
  //                                 style: GoogleFonts.lexendDeca(
  //                                     // fontSize: size.iScreen(2.0),
  //                                     fontWeight: FontWeight.normal,
  //                                     color: Colors.grey)),
  //                           ),
  //                           Container(
  //                             margin: EdgeInsets.symmetric(
  //                                 horizontal: size.iScreen(2.0)),
  //                             width: size.wScreen(12.0),
  //                             child: TextFormField(
  //                               readOnly: index >= _inicio
  //                                 ? horariosParametro.contains(index)
  //                                     // index>=_inicio?_frecuencia*index>=index
  //                                     ? false
  //                                     : true
  //                                 : true,
                      
  //                             initialValue: index >= _inicio
  //                                 ? horariosParametro.contains(index)
  //                                     //  index>=_inicio? _frecuencia*index>=index
  //                                     ? ''
  //                                     : '- - -'
  //                                 : '- - -',
                             
  //                             decoration: InputDecoration(
  //                               filled: index >= _inicio
  //                                   ? horariosParametro.contains(index)
  //                                       // filled:  index>=_inicio? _frecuencia*index>=index
  //                                       ? false
  //                                       : true
  //                                   : true,
                      
  //                               // suffixIcon: Icon(Icons.beenhere_outlined)
  //                             ),
  //                               textAlign: TextAlign.center,
  //                               // maxLines: 3,
  //                               // minLines: 1,
  //                               style: TextStyle(
  //                                 fontSize: size.iScreen(2.0),
  //                                 // fontWeight: FontWeight.bold,
  //                                 // letterSpacing: 2.0,
  //                               ),
  //                               onChanged: (text) {
                              
  //                                 controllerHospitalizacion
  //                                     .setHDataParametro(text,index);
  //                               },
  //                               // validator: (text) {
  //                               //   if (text!.trim().isNotEmpty) {
  //                               //     return null;
  //                               //   } else {
  //                               //     return 'Ingrese peso de la mascota';
  //                               //   }
  //                               // },
  //                             ),
  //                           ),
                             
  //                         ],
  //                       );
  //                     })),
                
                
                
  //               ),
  //             ), 
              
  //           //    actions: <Widget>[  
  //           //    Container(
  //           //     width: size.wScreen(100),
  //           //     // color: Colors.red,
  //           //      child:   TextButton(
  //           //                           onPressed: () {
  //           //                             // final isValidS = controllerHosp
  //           //                             //     .validateFormAgregaMedicina();
  //           //                             // if (!isValidS) return;
  //           //                             // if (isValidS) {
  //           //                             //   if (controllerHosp
  //           //                             //           .getNombreMedicina ==
  //           //                             //       '') {
  //           //                             //     FocusScope.of(context).unfocus();
  //           //                             //     NotificatiosnService
  //           //                             //         .showSnackBarDanger(
  //           //                             //             'Debe seleccionar Medicina');
  //           //                             //   }
  //           //                             //   if (controllerHosp
  //           //                             //           .getNombreMedicina !=
  //           //                             //       '') {
  //           //                             //     controllerHosp
  //           //                             //         .addCabeceraMedicamento();
  //           //                             //     Navigator.pop(context);
  //           //                             //   }
  //           //                             // }
  //           //                           },
  //           //                           child: Container(
  //           //                             decoration: BoxDecoration(
  //           //                                 color: primaryColor,
  //           //                                 borderRadius:
  //           //                                     BorderRadius.circular(5.0)),
  //           //                             // color: primaryColor,
  //           //                             padding: EdgeInsets.symmetric(
  //           //                                 vertical: size.iScreen(0.5),
  //           //                                 horizontal: size.iScreen(0.5)),
  //           //                             child: Text('Agregar',
  //           //                                 style: GoogleFonts.lexendDeca(
  //           //                                     // fontSize: size.iScreen(2.0),
  //           //                                     fontWeight: FontWeight.normal,
  //           //                                     color: Colors.white)),
  //           //                           ))
  //           //    )  
  //           // ],  
            
  //           );

          
  //       });
  // }


  //**********************************************BUSCA MASCOTA **********************************************************************//
  // Future<bool?> _buscarMedicina(BuildContext context, Responsive size) {
  //   return showDialog<bool>(
  //     barrierColor: Colors.black54,
  //     context: context,
  //     builder: (context) {
  //       // final controller = context.read<PropietariosController>();
  //       final controllerMedicina = context.read<HospitalizacionController>();

  //       return AlertDialog(
  //           title: const Text("BUSCAR MEDICINA"),
  //           content: Card(
  //             color: Colors.transparent,
  //             elevation: 0.0,
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 SizedBox(
  //                   width: size.iScreen(100.0),
  //                   child: Container(
  //                     // width: size.wScreen(45.0),
  //                     child: SizedBox(
  //                       width: size.iScreen(4.0),
  //                       child: TextFormField(
  //                         // controller: _textAddCorreo,
  //                         autofocus: true,
  //                         keyboardType: TextInputType.emailAddress,
  //                         textCapitalization: TextCapitalization.none,

  //                         autovalidateMode: AutovalidateMode.onUserInteraction,
  //                         // validator: (value) {
  //                         //   final validador = validateEmail(value);
  //                         //   if (validador == null) {
  //                         //     controller.setIsCorreo(true);
  //                         //   }
  //                         //   return validateEmail(value);
  //                         // },
  //                         decoration:
  //                             const InputDecoration(hintText: '  Buscar...'
  //                                 // suffixIcon: Icon(Icons.beenhere_outlined)
  //                                 ),
  //                         inputFormatters: [
  //                           LowerCaseText(),
  //                         ],
  //                         textAlign: TextAlign.center,
  //                         style: const TextStyle(

  //                             // fontSize: size.iScreen(3.5),
  //                             // fontWeight: FontWeight.bold,
  //                             // letterSpacing: 2.0,
  //                             ),
  //                         onChanged: (text) {
  //                           controllerMedicina.onSearchTextMedicina(text);

  //                           if (controllerMedicina.nameSearchMedicina.isEmpty) {
  //                             controllerMedicina.buscaAllMedicinas('');
  //                           }
  //                         },
  //                       ),
  //                     ),
  //                     //===============================================//
  //                   ),
  //                 ),
  //                 SizedBox(
  //                     // color: Colors.red,
  //                     width: size.wScreen(100),
  //                     height: size.hScreen(30.0),
  //                     child:
  //                         // Text('DFD'),

  //                         Consumer<HospitalizacionController>(
  //                       builder: (_, providerMedicina, __) {
  //                         if (providerMedicina.getErrorMedicinas == null) {
  //                           return Center(
  //                             // child: CircularProgressIndicator(),
  //                             child: Column(
  //                               mainAxisSize: MainAxisSize.min,
  //                               children: [
  //                                 Text(
  //                                   'Cargando Datos...',
  //                                   style: GoogleFonts.lexendDeca(
  //                                       fontSize: size.iScreen(1.5),
  //                                       color: Colors.black87,
  //                                       fontWeight: FontWeight.bold),
  //                                 ),
  //                                 //***********************************************/
  //                                 SizedBox(
  //                                   height: size.iScreen(1.0),
  //                                 ),
  //                                 //*****************************************/
  //                                 const CircularProgressIndicator(),
  //                               ],
  //                             ),
  //                           );
  //                         } else if (providerMedicina.getErrorMedicinas ==
  //                             false) {
  //                           return const NoData(
  //                             label: 'No existen datos para mostar',
  //                           );
  //                           // Text("Error al cargar los datos");
  //                         } else if (providerMedicina
  //                             .getListaMedicinas.isEmpty) {
  //                           return const NoData(
  //                             label: 'No existen datos para mostar',
  //                           );
  //                         }
  //                         // print('esta es la lista*******************: ${providerMedicina.getListaPropietarios.length}');

  //                         return ListView.builder(
  //                           physics: const BouncingScrollPhysics(),
  //                           itemCount:
  //                               providerMedicina.getListaMedicinas.length,
  //                           itemBuilder: (BuildContext context, int index) {
  //                             final _medicina =
  //                                 providerMedicina.getListaMedicinas[index];
  //                             return GestureDetector(
  //                               onTap: () {
  //                                 context
  //                                     .read<HospitalizacionController>()
  //                                     .setMedicinaInfo(_medicina);

  //                                 Navigator.pop(context);
  //                               },
  //                               child: Card(
  //                                   color: Colors.white,
  //                                   shape: RoundedRectangleBorder(
  //                                       borderRadius: BorderRadius.circular(8)),
  //                                   margin: EdgeInsets.symmetric(
  //                                       vertical: size.iScreen(0.5),
  //                                       horizontal: size.iScreen(1.0)),
  //                                   elevation: 2,
  //                                   child: ClipRRect(
  //                                     borderRadius: BorderRadius.circular(8),
  //                                     child: Row(
  //                                       children: [
  //                                         Expanded(
  //                                           child: Container(
  //                                             padding: EdgeInsets.symmetric(
  //                                                 horizontal: size.iScreen(0.0),
  //                                                 vertical: size.iScreen(1.0)),
  //                                             child: Column(
  //                                               children: <Widget>[
  //                                                 Container(
  //                                                   width: size.wScreen(100.0),
  //                                                   padding:
  //                                                       EdgeInsets.symmetric(
  //                                                           horizontal: size
  //                                                               .iScreen(1.0),
  //                                                           vertical: size
  //                                                               .iScreen(0.2)),
  //                                                   child: Text(
  //                                                     '${_medicina['invNombre']}',
  //                                                     style: GoogleFonts
  //                                                         .lexendDeca(
  //                                                             // fontSize: size.iScreen(2.45),
  //                                                             // color: Colors.white,
  //                                                             fontWeight:
  //                                                                 FontWeight
  //                                                                     .normal),
  //                                                   ),
  //                                                 ),
  //                                               ],
  //                                             ),
  //                                           ),
  //                                         ),
  //                                       ],
  //                                     ),
  //                                   )),
  //                             );
  //                           },
  //                         );
  //                       },
  //                     ))
  //               ],
  //             ),
  //           )

  //           //  },)

  //           );
  //     },
  //   );
  // }



  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _listaHoraParametros.length;

  @override
  int get selectedRowCount => 0;
}

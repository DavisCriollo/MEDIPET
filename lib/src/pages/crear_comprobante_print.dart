import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neitorcont/src/api/api_provider.dart';
import 'package:neitorcont/src/controllers/comprobantes_controller.dart';
import 'package:neitorcont/src/pages/buscar_productos_varios.dart';
import 'package:neitorcont/src/pages/print.dart';
import 'package:neitorcont/src/services/notifications_service.dart';
import 'package:neitorcont/src/theme/theme_provider.dart';
import 'package:neitorcont/src/utils/dialogs.dart';
import 'package:neitorcont/src/utils/letras_mayusculas_minusculas.dart';
import 'package:neitorcont/src/utils/responsive.dart';
import 'package:neitorcont/src/utils/solo_decimales.dart';
import 'package:provider/provider.dart';

class CrearComprobante extends StatefulWidget {
  final String? tipo;
  const CrearComprobante({Key? key, this.tipo}) : super(key: key);

  @override
  State<CrearComprobante> createState() => _CrearComprobanteState();
}

class _CrearComprobanteState extends State<CrearComprobante> {
  final TextEditingController _rucCliController = TextEditingController();
  final TextEditingController _rucChofController = TextEditingController();

  TextEditingController _controller = TextEditingController();
   TextEditingController _textAddPlaca = TextEditingController();

   @override
  void dispose() {

 _rucCliController.dispose();
   _rucChofController.dispose();

 _controller.dispose();
  _textAddPlaca.dispose();



    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    final ctrl = context.read<ComprobantesController>();
    final ctrlTheme = context.read<ThemeProvider>();
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: widget.tipo == 'CREATE' || widget.tipo == 'SEARCH'
              ? Text('Crear Comprobante')
              : Text('Editar Comprobante'),
          actions: [
            // Consumer<SocketService>(builder: (_, valueConexion, __) {
            //   return valueConexion.serverStatus == ServerStatus.Online
            //       ?
            Container(
              margin: EdgeInsets.only(right: size.iScreen(1.5)),
              child: IconButton(
                  splashRadius: 28,
                  onPressed: () {
                    _onSubmit(
                      context,
                      ctrl,
                    );
                  },
                  icon: Icon(
                    Icons.save_outlined,
                    size: size.iScreen(4.0),
                  )),
            )

            // : Container();
            // });
          ],
        ),
        body: Container(
          color: Colors.white,
          margin: EdgeInsets.only(
              left: size.iScreen(1.0),
              right: size.iScreen(1.0),
              bottom: size.iScreen(1.0)),
          width: size.wScreen(100),
          height: size.hScreen(100),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                // //***********************************************/
                // SizedBox(
                //   height: size.iScreen(1.5),
                // ),
                // //*****************************************/
                // Row(
                //   children: [
                //     SizedBox(
                //       // width: size.wScreen(100.0),

                //       // color: Colors.blue,
                //       child: Text('TIPO CODUMENTO :',
                //           style: GoogleFonts.lexendDeca(
                //               // fontSize: size.iScreen(2.0),
                //               fontWeight: FontWeight.normal,
                //               color: Colors.grey)),
                //     ),
                //     Consumer<ComprobantesController>(
                //       builder: (_, valueTipo, __) {
                //         return Container(
                //           // color: Colors.red,
                //           width: size.wScreen(50.0),

                //           // color: Colors.blue,
                //           child: Text(
                //               valueTipo.getTipoDocumento.isEmpty
                //                   ? ' --- --- --- --- ---'
                //                   : ' ${valueTipo.getTipoDocumento}',
                //               style: GoogleFonts.lexendDeca(
                //                   fontSize: size.iScreen(2.0),
                //                   fontWeight: FontWeight.normal,
                //                   color: valueTipo.getTipoDocumento.isEmpty
                //                       ? Colors.grey
                //                       : Colors.black)),
                //         );
                //       },
                //     ),
                //     Spacer(),
                //     ClipRRect(
                //       borderRadius: BorderRadius.circular(8),
                //       child: GestureDetector(
                //         onTap: () {
                //           // context
                //           //     .read<MascotasController>()
                //           //     .buscaAllMascotas('');

                //           // // _buscarMascota(context, size);
                //           modalTipoDocumento(context, size, ctrl);

                //           // //*******************************************/
                //         },
                //         child: Consumer<ThemeProvider>(
                //           builder: (_, valueTheme, __) {
                //             return Container(
                //               alignment: Alignment.center,
                //               color: valueTheme.appTheme.primaryColor,
                //               width: size.iScreen(3.5),
                //               padding: EdgeInsets.only(
                //                 top: size.iScreen(0.5),
                //                 bottom: size.iScreen(0.5),
                //                 left: size.iScreen(0.5),
                //                 right: size.iScreen(0.5),
                //               ),
                //               child: Icon(
                //                 Icons.add,
                //                 color: Colors.white,
                //                 size: size.iScreen(2.0),
                //               ),
                //             );
                //           },
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                //***********************************************/
                SizedBox(
                  height: size.iScreen(1.0),
                ),
                //*****************************************/
                Container(
                  // color: Colors.grey.shade200,
                  padding: EdgeInsets.only(bottom: size.iScreen(1.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Consumer<ComprobantesController>(
                        builder: (_, tipo, __) {
                          return Container(
                            width: size.iScreen(35),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextField(
                                  decoration: InputDecoration(
                                    label: Text( 'Ingrese Documento'),
                                    labelStyle:TextStyle(color: Colors.grey,fontSize: size.iScreen(1.9)),
                                    // hintText: 'Ingrese Documento', // Texto de sugerencia dentro del campo
                                    // border: OutlineInputBorder(), // Opcional: Añade un borde al campo
                                    helperStyle:
                                        TextStyle(color: Colors.grey,fontSize: size.iScreen(1.5)),
                                  ),
                                  inputFormatters: [
                                    UpperCaseText(), // Limita a 13 dígitos
                                  ],
                                  style: TextStyle(
                                    fontSize: size.iScreen( 3.0), // Ajusta el tamaño de la letra
                                    // fontWeight: FontWeight.bold, // Opcional: Aplica un peso de fuente más grueso
                                  ),
                                  textAlign: TextAlign.center,
                                  onChanged: (text) {
                                    ctrl.setDocumento(text);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                       Consumer<ComprobantesController>(builder: (_, value, __) { 
                          return  ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: GestureDetector(
                          onTap: value.getDocumento!.isNotEmpty
                              ? () async {
                                  ProgressDialog.show(context);
                                  final response = await value.buscaClienteComprobante();
                                  ProgressDialog.dissmiss(context);
                                  if (response != null) {
                                     if(value.getClienteComprobante.isNotEmpty){
                                     NotificatiosnService.showSnackBarDanger( '${value.getClienteComprobante}');
                                   }else{
                                    NotificatiosnService.showSnackBarDanger( 'No se encuentra información,ingrese datos manualmente');
                                 
                                   }
                                   
                                  } else {

                                  }
                                  

                                  //     .searchAllPersinas('');
                                  // Navigator.of(context).push(
                                  //     MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             BuscarPropietario()));
                                }
                              : () {
                                  NotificatiosnService.showSnackBarDanger(
                                      'Debe ingresar Documento para buscar');
                                },
                          child:
                              // Container(
                              //   alignment: Alignment.center,
                              //   color: primaryColor,
                              //   width: size.iScreen(3.5),
                              //   padding: EdgeInsets.only(
                              //     top: size.iScreen(0.5),
                              //     bottom: size.iScreen(0.5),
                              //     left: size.iScreen(0.5),
                              //     right: size.iScreen(0.5),
                              //   ),
                              //   child: Icon(
                              //     Icons.search_outlined,
                              //     color: Colors.white,
                              //     size: size.iScreen(2.0),
                              //   ),
                              // ),
                              Consumer<ThemeProvider>(
                            builder: (_, valueTheme, __) {
                              return Container(
                                alignment: Alignment.center,
                                color: valueTheme.appTheme.primaryColor,
                                width: size.iScreen(4.0),
                                height: size.iScreen(4.0),
                                padding: EdgeInsets.only(
                                  top: size.iScreen(0.5),
                                  bottom: size.iScreen(0.5),
                                  left: size.iScreen(0.5),
                                  right: size.iScreen(0.5),
                                ),
                                child: Icon(
                                  Icons.search_outlined,
                                  color: Colors.white,
                                  size: size.iScreen(2.0),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    
                         },)


                     
                      // SizedBox(
                      //   width: size.iScreen(2.0),
                      // ),

                       
                    
                    
                    
                    
                    
                    
                      // Container(
                      //   width: size.iScreen(4.0), // Ajusta el ancho del contenedor según sea necesario
                      //   height: size.iScreen(4.0), // Ajusta la altura del contenedor según sea necesario
                      //   decoration: BoxDecoration(
                      //     color:ctrlTheme.appTheme.primaryColor, // Color de fondo del contenedor
                      //     borderRadius: BorderRadius.circular(8), // Forma circular
                      //   ),
                      //   child: IconButton(
                      //     icon: Icon(Icons.search, color: Colors.white), // Icono de lupa
                      //   //   onPressed:  ctrl.getDocumento!.isNotEmpty? () async {
                      //   // //  final ctrlPropi=context.read<PropietariosController>();

                      //   //  ProgressDialog.show(context);
                      //   //   final response = await   ctrl.buscaClienteComprobante();
                      //   //   ProgressDialog.dissmiss(context);

                      //   //      if (response != null) {

                      //   //      }else{

                      //   //       // NotificatiosnService.showSnackBarDanger( 'No se encuentra información o Documento incorrecto, ingrese datos manualmente');

                      //   //      }

                      //   //                                       //     .searchAllPersinas('');
                      //   //                                       // Navigator.of(context).push(
                      //   //                                       //     MaterialPageRoute(
                      //   //                                       //         builder: (context) =>
                      //   //                                       //             BuscarPropietario()));
                      //   //                                     }:(){

                      //   //                            NotificatiosnService.showSnackBarDanger( 'Debe ingresar Documento para buscar');

                      //   //                                     },
                      //   onPressed:ctrl.getDocumento!.isEmpty ?(){
                      //     print('EL DATO A BUSCAR VACIO :  ${ctrl.getDocumento}');
                      //   }:(){
                      //     print('EL DATO A BUSCAR  :  ${ctrl.getDocumento}');
                      //   },
                      //   ),
                      // ),
                    ],
                  ),
                ),
                //***********************************************/
                
                SizedBox(
                  height: size.iScreen(1.0),
                ),
                //*****************************************/

Consumer<ComprobantesController>(builder: (_, value, __) {  

return 
value.getClienteComprobante.isNotEmpty?
 Column(
                  children: [
                    Container(
                      width: size.wScreen(100.0),

                      // color: Colors.blue,
                      child:  Text(value.getClienteComprobante.isEmpty?'--- --- --- --- ---':'${value.getClienteComprobante['perNombre']}',
                          style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(2.3),
                            fontWeight: FontWeight.normal,
                            color: value.getClienteComprobante.isEmpty?Colors.grey:Colors.black
                          )),
                    ),
                             //***********************************************/
                // SizedBox(
                //   height: size.iScreen(1.0),
                // ),
                //*****************************************/
                Container(
                  width: size.wScreen(100.0),

                  // color: Colors.blue,
                  child:  Text(value.getClienteComprobante.isEmpty?'--- --- --- --- ---':value.getClienteComprobante['perEmail'].isEmpty?'--- --- --- --- ---':'${value.getClienteComprobante['perEmail'][0]}',
                      style: GoogleFonts.lexendDeca(
                        fontSize: size.iScreen(2.0),
                        fontWeight: FontWeight.normal,
                         color: value.getClienteComprobante.isEmpty?Colors.grey:Colors.black
                      )),
                ),
                  ],
                ):Container();


},),

                
       
                //***********************************************/
                // SizedBox(
                //   height: size.iScreen(1.0),
                // ),
                //*****************************************/
                // Container(
                //   color: Colors.grey.shade200,
                //   padding: EdgeInsets.only(bottom: size.iScreen(1.0)),
                //   child:   Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                //   children: [
                //     Container(
                //       width: size.iScreen(11),
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //          TextField(
                //     inputFormatters: [
                //       FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')), // Solo números y un punto
                //     ],
                //     decoration: InputDecoration(
                //       hintText: 'Kilometraje', // Texto de sugerencia dentro del campo
                //        helperStyle:TextStyle(color: Colors.grey.shade50),
                //     ),
                //     textAlign: TextAlign.center,
                //     keyboardType: TextInputType.numberWithOptions(decimal: true),
                //      style: TextStyle(
                //       fontSize: size.iScreen(2.0), // Ajusta el tamaño de la letra
                //       // fontWeight: FontWeight.bold, // Opcional: Aplica un peso de fuente más grueso
                //     ),// Muestra teclado numérico con punto
                //   ),
                //           // TextField(
                //           //     controller: _rucCiController,
                //           //     keyboardType: TextInputType.number, // Solo permite números
                //           //     decoration: InputDecoration(
                //           //       hintText: 'RUC/CI', // Texto de sugerencia dentro del campo
                //           //       // border: OutlineInputBorder(), // Opcional: Añade un borde al campo
                //           //     ),
                //           //     inputFormatters: [
                //           //       FilteringTextInputFormatter.digitsOnly, // Solo números
                //           //       LengthLimitingTextInputFormatter(13), // Limita a 13 dígitos
                //           //     ],
                //           //     onChanged: (value) {
                //           //       if (value.length < 10) {
                //           //         // Opcional: Mostrar algún mensaje de error si la longitud es menor a 10
                //           //       }
                //           //     },
                //           //   ),
                //         ],
                //       ),
                //     ),
                //     Container(
                //       width: size.iScreen(20),
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           // TextField(
                //           //   decoration: InputDecoration(
                //           //     hintText: 'RUC/CI CONDUCTOR', // Texto de sugerencia dentro del campo
                //           //     // border: OutlineInputBorder(), // Opcional: Añade un borde al campo
                //           //   ),
                //           //    textAlign: TextAlign.center,
                //           // ),
                //           TextField(
                //               controller: _rucCliController,
                //               keyboardType: TextInputType.number, // Solo permite números
                //               decoration: InputDecoration(
                //                 hintText: 'RUC/CI', // Texto de sugerencia dentro del campo
                //                 // border: OutlineInputBorder(), // Opcional: Añade un borde al campo
                //                  helperStyle:TextStyle(color: Colors.grey.shade50),
                //               ),
                //               inputFormatters: [
                //                 FilteringTextInputFormatter.digitsOnly, // Solo números
                //                 LengthLimitingTextInputFormatter(13), // Limita a 13 dígitos
                //               ],
                //                style: TextStyle(
                //       fontSize: size.iScreen(2.0), // Ajusta el tamaño de la letra

                //       // fontWeight: FontWeight.bold, // Opcional: Aplica un peso de fuente más grueso
                //     ),
                //               onChanged: (value) {
                //                 if (value.length < 10) {
                //                   // Opcional: Mostrar algún mensaje de error si la longitud es menor a 10
                //                 }
                //               },
                //                textAlign: TextAlign.center,
                //             ),
                //         ],
                //       ),
                //     ),

                //   ],
                //   ),
                // ),

                //*****************************************/
                SizedBox(
                  height: size.iScreen(1.0),
                ),
                //*****************************************/
                Row(
                  children: [
                    SizedBox(
                      // width: size.wScreen(100.0),

                      // color: Colors.blue,
                      child: Text('Placa: ',
                          style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: Colors.grey)),
                    ),
                 
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: GestureDetector(
                        onTap: () {
                          // context
                          //     .read<MascotasController>()
                          //     .buscaAllMascotas('');

                          // // _buscarMascota(context, size);
                          _agregaPlaca(context,ctrl,size);

                          // //*******************************************/
                        },
                        child: Consumer<ThemeProvider>(
                          builder: (_, valueTheme, __) {
                            return Container(
                              alignment: Alignment.center,
                              color: valueTheme.appTheme.primaryColor,
                              width: size.iScreen(3.5),
                              padding: EdgeInsets.only(
                                top: size.iScreen(0.5),
                                bottom: size.iScreen(0.5),
                                left: size.iScreen(0.5),
                                right: size.iScreen(0.5),
                              ),
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: size.iScreen(2.0),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                  //*****************************************/
                 SizedBox(
                  height: size.iScreen(1.0),
                ),
                  //*****************************************/
                SizedBox(
                   width: size.wScreen(100.0),
                  child: 
                  Consumer<ComprobantesController>(builder: (_, value, __) {  
                    return 
                    value.getlistaAddPlacas!.isNotEmpty?
                    Wrap( children: (value.getlistaAddPlacas as List).map((e) =>
                    GestureDetector(
                      onDoubleTap: () {
                        value.eliminaPlaca(e);
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: size.iScreen(1.0),vertical: size.iScreen(0.5)),
                         padding: EdgeInsets.symmetric(horizontal: size.iScreen(0.5)),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(8)
                        ),
                      
                        child: Text('$e',
                          style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(2.3),
                              fontWeight: FontWeight.normal,
                              color: Colors.black)),
                      ),
                    )
                    ).toList(),)
                    :Text('--- --- --- --- ---',
                          style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(2.3),
                            fontWeight: FontWeight.normal,
                            color: Colors.grey
                          ));
                    
                  },),
                  
                ),

              
                Container(
                  width: size.iScreen(100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // TextField(
                      //   decoration: InputDecoration(
                      //     hintText: 'RUC/CI CONDUCTOR', // Texto de sugerencia dentro del campo
                      //     // border: OutlineInputBorder(), // Opcional: Añade un borde al campo
                      //   ),
                      //    textAlign: TextAlign.center,
                      // ),
                      TextField(
                        inputFormatters: [
                          UpperCaseText(),
                        ],
                        decoration: InputDecoration(
                          label:  const Text( 'Nombre Conductor'),
                          // Texto de sugerencia dentro del campo
                          // border: OutlineInputBorder(), // Opcional: Añade un borde al campo
                          helperStyle: TextStyle(color: Colors.grey.shade50),
                        ),
                        style: TextStyle(
                          fontSize:
                              size.iScreen(2.3), // Ajusta el tamaño de la letra
                          // fontWeight: FontWeight.bold, // Opcional: Aplica un peso de fuente más grueso
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
                //***********************************************/
                SizedBox(
                  height: size.iScreen(1.0),
                ),
                //*****************************************/

                //       Container(
                //         width: size.wScreen(100),
                //         child:
                //        Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                //   children: <Widget>[
                //     RadioButtonWithLabel(value: 1, label: 'Pasaporte'),
                //     RadioButtonWithLabel(value: 2, label: 'Calibración'),
                //     RadioButtonWithLabel(value: 3, label: 'Venta Cupo'),
                //     RadioButtonWithLabel(value: 4, label: 'Prepago'),
                //   ],
                // ),

                //       ),

                // ContainerRow(),

//***********************************************/
                // SizedBox(
                //   height: size.iScreen(1.0),
                // ),
                // //*****************************************/
                // Row(
                //   children: [
                //     SizedBox(
                //       // width: size.wScreen(100.0),

                //       // color: Colors.blue,
                //       child: Text('FORMA DE PAGO: ',
                //           style: GoogleFonts.lexendDeca(
                //               fontSize: size.iScreen(2.0),
                //               fontWeight: FontWeight.normal,
                //               color: Colors.grey)),
                //     ),
                //     Text('EFECTIVO',
                //         style: GoogleFonts.lexendDeca(
                //             fontSize: size.iScreen(2.3),
                //             fontWeight: FontWeight.bold,
                //             color: Colors.green)),
                //   ],
                // ),
                 //***********************************************/
                SizedBox(
                  height: size.iScreen(1.5),
                ),
                //*****************************************/
                Row(
                  children: [
                    SizedBox(
                      width: size.wScreen(16.0),

                      // color: Colors.blue,
                      child: Text('FORMA DE PAGO :',
                          style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: Colors.grey)),
                    ),
                    Consumer<ComprobantesController>(builder: (_, value, __) { 
                       return Container(
                          // color: Colors.red,
                          width: size.wScreen(70.0),

                          // color: Colors.blue,
                          child: Text(
                              value.getFormaDePago.isEmpty
                                  ? ' --- --- --- --- --- --- --- ---'
                                  : ' ${value.getFormaDePago}',
                              style: GoogleFonts.lexendDeca(
                                  fontSize: size.iScreen(2.3),
                                  fontWeight: FontWeight.normal,
                                  color: value.getFormaDePago.isEmpty
                                      ? Colors.grey
                                      : Colors.black)),
                        );
                     },),
                    // Consumer<ComprobantesController>(
                    //   builder: (_, valueForma, __) {
                    //     return Container(
                    //       // color: Colors.red,
                    //       width: size.wScreen(50.0),

                    //       // color: Colors.blue,
                    //       child: Text(
                    //           valueForma.getFormaDePago.isEmpty
                    //               ? ' --- --- --- --- --- --- --- ---'
                    //               : ' ${valueForma.getFormaDePago}',
                    //           style: GoogleFonts.lexendDeca(
                    //               fontSize: size.iScreen(2.0),
                    //               fontWeight: FontWeight.normal,
                    //               color: valueForma.getFormaDePago.isEmpty
                    //                   ? Colors.grey
                    //                   : Colors.black)),
                    //     );
                    //   },
                    // ),
                    Spacer(),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: GestureDetector(
                        onTap: () {
                          // context
                          //     .read<MascotasController>()
                          //     .buscaAllMascotas('');

                          // // _buscarMascota(context, size);
                          modalFormaPago(context, size, ctrl);

                          // //*******************************************/
                        },
                        child: Consumer<ThemeProvider>(
                          builder: (_, valueTheme, __) {
                            return Container(
                              alignment: Alignment.center,
                              color: valueTheme.appTheme.primaryColor,
                              width: size.iScreen(3.5),
                              padding: EdgeInsets.only(
                                top: size.iScreen(0.5),
                                bottom: size.iScreen(0.5),
                                left: size.iScreen(0.5),
                                right: size.iScreen(0.5),
                              ),
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: size.iScreen(2.0),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                // //***********************************************/
                // SizedBox(
                //   height: size.iScreen(1.0),
                // ),
                // //*****************************************/
                //***********************************************/
                // SizedBox(
                //   height: size.iScreen(1.0),
                // ),
                //*****************************************/
                // Container(
                //   width: size.wScreen(100.0),
                //   child: ContainerCombustible()),
                //***********************************************/
                // SizedBox(
                //   height: size.iScreen(1.0),
                // ),
                // //*****************************************/

                //***********************************************/
                SizedBox(
                  height: size.iScreen(1.5),
                ),
                //*****************************************/
                Row(
                  children: [
                    SizedBox(
                      // width: size.wScreen(100.0),

                      // color: Colors.blue,
                      child: Text('TARIFAS POR PASADA ',
                          style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: Colors.grey)),
                    ),
                    Spacer(),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: GestureDetector(
                        onTap: () {
                          ctrl.buscaAllProductos();

                          // // _buscarMascota(context, size);

 Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const BuscarProductosVarios()));

                          // modalTarifas(context, size, ctrl);

                          // //*******************************************/
                        },
                        child: Consumer<ThemeProvider>(
                          builder: (_, valueTheme, __) {
                            return Container(
                              alignment: Alignment.center,
                              color: valueTheme.appTheme.primaryColor,
                              width: size.iScreen(3.5),
                              padding: EdgeInsets.only(
                                top: size.iScreen(0.5),
                                bottom: size.iScreen(0.5),
                                left: size.iScreen(0.5),
                                right: size.iScreen(0.5),
                              ),
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: size.iScreen(2.0),
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    //  Spacer(),
                  ],
                ),
                // //***********************************************/
                // SizedBox(
                //   height: size.iScreen(1.0),
                // ),
                // //*****************************************/

                // Consumer<ComprobantesController>(
                //   builder: (_, valueTipo, __) {
                //     return Container(
                //       // color: Colors.red,
                //       width: size.wScreen(100.0),

                //       // color: Colors.blue,
                //       child: Text(
                //           valueTipo.tipoTarifa.isEmpty
                //               ? ''
                //               : ' ${valueTipo.tipoTarifa['tipo']} - \$${valueTipo.tipoTarifa['valor']}',
                //           style: GoogleFonts.lexendDeca(
                //               fontSize: size.iScreen(2.5),
                //               fontWeight: FontWeight.normal,
                //               color: valueTipo.tipoTarifa.isEmpty
                //                   ? Colors.grey
                //                   : Colors.black)),
                //     );
                //   },
                // ),

                        Consumer<ComprobantesController>(builder: (_, value, __) { 
                return  
                value.getRespuestaCalculoItem.isNotEmpty
               ? Wrap(
                children: value.getRespuestaCalculoItem['venProductos']
                    .map<Widget>(
                      (e) => 
                     e['descripcion'].isEmpty?Container(): Card(
                             child: ListTile(
                               visualDensity: VisualDensity.compact,
                               title: Text(
                                 '${e['descripcion']}',
                                 style: GoogleFonts.lexendDeca(
                                     fontSize: size.iScreen(1.8),
                                     // color: Colors.black54,
                                     fontWeight: FontWeight.normal),
                               ),
                               subtitle: 
                               Row(
                                 children: [
                                   Text(
                                    'Valor Unitario: ',
                                     style: GoogleFonts.lexendDeca(
                                         fontSize: size.iScreen(1.5),
                                         // color: Colors.black54,
                                         fontWeight: FontWeight.normal),
                                   ),
                                    Text(
                                    ' \$ ${e['valorUnitario']}',
                                     style: GoogleFonts.lexendDeca(
                                         fontSize: size.iScreen(2.3),
                                         // color: Colors.black54,
                                         fontWeight: FontWeight.bold),
                                   ),
                                 ],
                               ),
                               trailing: Column(
                                 children: [
                                   Text(
                                    'Cantidad',
                                     style: GoogleFonts.lexendDeca(
                                         fontSize: size.iScreen(1.5),
                                         // color: Colors.black54,
                                         fontWeight: FontWeight.normal),
                                   ),
                                   Text(
                                    '${e['cantidad']}',
                                     style: GoogleFonts.lexendDeca(
                                         fontSize: size.iScreen(2.3),
                                         color:ctrlTheme.appTheme.primaryColor,
                                         fontWeight: FontWeight.normal),
                                   ),
                                 ],
                               ),
                               // provider.getListaDeProductos.isNotEmpty
                               // ?Wrap(children: producto['invprecios'].map<Widget>((e) =>  Text(
                               //   '${e}',
                               //   style: GoogleFonts.lexendDeca(
                               //       fontSize: size.iScreen(1.7),
                               //       // color: Colors.black54,
                               //       fontWeight: FontWeight.normal),
                               // )).toList(),
                               // ):Text(
                               //   '--- --- ---',
                               //   style: GoogleFonts.lexendDeca(
                               //       fontSize: size.iScreen(1.8),
                               //       // color: Colors.black54,
                               //       fontWeight: FontWeight.normal),
                               // ),
                               onTap: () {
                                 value.deleteItem(e);


                                
                                
                                
                                
                               },
                             ),
                           ),
                    )
                    .toList(),
              ):Container();
              
               },),
                //***********************************************/
                SizedBox(
                  height: size.iScreen(1.0),
                ),
                //*****************************************/
                //*****************************************/

//                 Consumer<ComprobantesController>(builder: (_, value, __) { 
//                   return  
                  
//                   value.tipoTarifa.isEmpty? Text(
//                                      '--- --- --- --- --- --- --- --- --- --- ',
//                                       style: GoogleFonts.lexendDeca(
//                                           fontSize: size.iScreen(3.0),
//                                           fontWeight: FontWeight.normal,
//                                           color:  value.tipoTarifa.isEmpty? Colors.grey:Colors.black
//                                               )):
                  
//                   Container(
//                   // color: Colors.grey.shade200,
//                   padding: EdgeInsets.only(bottom: size.iScreen(1.0)),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       Container(
//                         width: size.iScreen(10),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             //       TextField(
//                             //          inputFormatters: [
//                             //                             UpperCaseText(),
//                             //                           ],
//                             //         decoration: InputDecoration(
//                             //           hintText: 'Valor', // Texto de sugerencia dentro del campo
//                             //           // border: OutlineInputBorder(), // Opcional: Añade un borde al campo
//                             //            helperStyle:TextStyle(color: Colors.grey.shade50),
//                             //         ),
//                             //         style: TextStyle(
//                             //   fontSize: size.iScreen(2.0), // Ajusta el tamaño de la letra
//                             //   // fontWeight: FontWeight.bold, // Opcional: Aplica un peso de fuente más grueso
//                             // ),
//                             //         textAlign: TextAlign.center,
//                             //       ),
//                             //  TextField(
//                             //         inputFormatters: [
//                             //           FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')), // Permite números y un solo punto decimal
//                             //         ],
//                             //         keyboardType: TextInputType.numberWithOptions(decimal: true), // Permite punto decimal en el teclado
//                             //         decoration: InputDecoration(
//                             //           hintText: 'Valor', // Texto de sugerencia dentro del campo
//                             //           helperStyle: TextStyle(color: Colors.grey.shade50),
//                             //         ),
//                             //         style: TextStyle(
//                             //           fontSize: size.iScreen(2.2), // Ajusta el tamaño de la letra
//                             //         ),
//                             //         textAlign: TextAlign.center,
//                             //       ),
//                             Consumer<ComprobantesController>(
//                               builder: (_, valueTatifa, __) {
//                                 return Container(
//                                   // color: Colors.red,
//                                   width: size.wScreen(20.0),

//                                   // color: Colors.blue,
//                                   child: Text(
//                                       valueTatifa.tipoTarifa.isEmpty
//                                           ? ' --- ---'
//                                           : ' \$${valueTatifa.tipoTarifa['valor']}',
//                                       style: GoogleFonts.lexendDeca(
//                                           fontSize: size.iScreen(3.0),
//                                           fontWeight: FontWeight.bold,
//                                           color: valueTatifa.tipoTarifa.isEmpty
//                                               ? Colors.grey
//                                               : Colors.red)),
//                                 );
//                               },
//                             ),
//                           ],
//                         ),
//                       ),
//                       Consumer<ComprobantesController>(
//                         builder: (_, values, __) {
//                           return values.tipoTarifa.isNotEmpty
//                               ? Container(
//                                   width: size.iScreen(20),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
// // TextFormField(

// //   // initialValue:values.getCantidad ,
// //   controller: _controller,
// //   inputFormatters: [
// //     FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')), // Permite números y un solo punto decimal
// //   ],
// //   keyboardType: TextInputType.numberWithOptions(decimal: true), // Permite punto decimal en el teclado
// //   decoration: InputDecoration(
// //     hintStyle:TextStyle(
// //       fontSize: size.iScreen(2.0)
// //     ),
// //     hintText: 'Cantidad', // Texto de sugerencia dentro del campo
// //     helperStyle: TextStyle(color: Colors.grey.shade50),
// //   ),
// //   style: TextStyle(
// //     fontSize: size.iScreen(3.5), // Ajusta el tamaño de la letra
// //   ),
// //   textAlign: TextAlign.center,
// //    onChanged: (text) {
// //     if (text=='') {
// //       text==0.00;
// //     }
// //     values.setCantidad(double.parse(text));
// //                       },
// // ),
//                                       TextFormField(
//                                         controller: _controller,
//                                         inputFormatters: [
//                                           FilteringTextInputFormatter.allow(RegExp(
//                                               r'^\d*\.?\d*$')), // Permite números y un solo punto decimal
//                                         ],
//                                         keyboardType:
//                                             TextInputType.numberWithOptions(
//                                                 decimal:
//                                                     true), // Permite punto decimal en el teclado
//                                         decoration: InputDecoration(
//                                           hintStyle: TextStyle(
//                                             fontSize: size.iScreen(2.0),
//                                           ),
//                                           hintText:
//                                               'Cantidad', // Texto de sugerencia dentro del campo
//                                           helperStyle: TextStyle(
//                                               color: Colors.grey.shade50),
//                                         ),
//                                         style: TextStyle(
//                                           fontSize: size.iScreen(
//                                               3.5), // Ajusta el tamaño de la letra
//                                         ),
//                                         textAlign: TextAlign.center,

//                                         // Validación y conversión
//                                         onChanged: (text) {
//                                           double value = 0.0;
//                                           if (text.isNotEmpty) {
//                                             try {
//                                               value = double.parse(text);
//                                             } catch (e) {
//                                               // Manejo del error si el parse falla
//                                               value = 0.0;
//                                             }
//                                           }
//                                           values.setCantidad(value);
//                                         },

//                                         // Validación adicional al enviar el formulario (opcional)
//                                         validator: (text) {
//                                           if (text == null || text.isEmpty) {
//                                             return 'Por favor, ingrese una cantidad';
//                                           }
//                                           final value = double.tryParse(text);
//                                           if (value == null) {
//                                             return 'Ingrese un número válido';
//                                           }
//                                           return null; // Devuelve null si la validación es exitosa
//                                         },
//                                       ),
//                                     ],
//                                   ),
//                                 )
//                               : Container();
//                         },
//                       )
//                       // Container(
//                       //   width: size.iScreen(4.0), // Ajusta el ancho del contenedor según sea necesario
//                       //   height: size.iScreen(4.0), // Ajusta la altura del contenedor según sea necesario
//                       //   decoration: BoxDecoration(
//                       //     color:ctrlTheme.appTheme.primaryColor, // Color de fondo del contenedor
//                       //     borderRadius: BorderRadius.circular(8), // Forma circular
//                       //   ),
//                       //   child: IconButton(
//                       //     icon: Icon(Icons.search, color: Colors.white), // Icono de lupa
//                       //     onPressed: () {
//                       //       // Acción al presionar el icono
//                       //     },
//                       //   ),
//                       // ),
//                     ],
//                   ),
//                 );
                
//                  },),

               //***********************************************/
                // //***********************************************/
                // SizedBox(
                //   height: size.iScreen(1.0),
                // ),
                // //*****************************************/
                // //***********************************************/
                // Container(
                //   color:Colors.grey.shade200,
                //   width: size.wScreen(100),
                //   height: size.iScreen(0.5),
                // ),
                // //*****************************************/
                 //***********************************************/
                SizedBox(
                  height: size.iScreen(1.0),
                ),
                //*****************************************/

                   

                Container(
                  width: size.wScreen(100),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: size.iScreen(10.0),

                                    // color: Colors.blue,
                                    child: Text('SubTotal: ',
                                        style: GoogleFonts.lexendDeca(
                                            fontSize: size.iScreen(2.0),
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey)),
                                  ),
                                  Consumer<ComprobantesController>(
                                builder: (_, valueSubTotal, __) {
                                  return Text(valueSubTotal.getRespuestaCalculoItem['venSubTotal']==null?'0.00':' \$ ${valueSubTotal.getRespuestaCalculoItem['venSubTotal']}',
                                      style: GoogleFonts.lexendDeca(
                                          fontSize: size.iScreen(2.0),
                                          fontWeight: FontWeight.bold,
                                          color: ctrlTheme.appTheme.primaryColor));
                                },
                              ),
                                ],
                              ),
                               Row(
                                children: [
                                  Container(
                                   width: size.iScreen(10.0),

                                    // color: Colors.blue,
                                    child: Text('IVA : ',
                                        style: GoogleFonts.lexendDeca(
                                            fontSize: size.iScreen(2.0),
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey)),
                                  ),
                                  Consumer<ComprobantesController>(
                                builder: (_, valueIvaTotal, __) {
                                  return Text(valueIvaTotal.getRespuestaCalculoItem['venTotalIva']==null?'0.00':' \$ ${valueIvaTotal.getRespuestaCalculoItem['venTotalIva']}',
                                      style: GoogleFonts.lexendDeca(
                                          fontSize: size.iScreen(2.0),
                                          fontWeight: FontWeight.bold,
                                          color: ctrlTheme.appTheme.primaryColor));
                                },
                              ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                width: size.iScreen(10.0),

                                    // color: Colors.blue,s
                                    child: Text('Total: ',
                                        style: GoogleFonts.lexendDeca(
                                            fontSize: size.iScreen(2.5),
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey)),
                                  ),
                                  Consumer<ComprobantesController>(
                                builder: (_, valueTotal, __) {
                                  return Text(valueTotal.getRespuestaCalculoItem['venTotal']==null?'0.00':' \$ ${valueTotal.getRespuestaCalculoItem['venTotal']}',
                                      style: GoogleFonts.lexendDeca(
                                          fontSize: size.iScreen(2.5),
                                          fontWeight: FontWeight.bold,
                                          color: ctrlTheme.appTheme.primaryColor));
                                },
                              ),
                                ],
                              ),
                            ],
                          ),
                        
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const PrintTicket()));
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: size.iScreen(
                                      2.5)), // Espaciado entre contenedores
                              padding: EdgeInsets.all(size.iScreen(
                                  1.0)), // Espaciado interno del contenedor
                              decoration: BoxDecoration(
                                color: ctrlTheme.appTheme
                                    .accentColor, // Color de fondo según selección
                                borderRadius: BorderRadius.circular(
                                    8.0), // Bordes redondeados
                                border: Border.all(
                                    color: Colors.grey, width: 1), // Borde gris
                              ),
                              child: Center(
                                child: Text('Imprimir',
                                    style: GoogleFonts.lexendDeca(
                                      fontSize: size.iScreen(2.0),
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white,
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              
                //***********************************************/
                SizedBox(
                  height: size.iScreen(3.0),
                ),
                //*****************************************/

                //***********************************************/
                SizedBox(
                  height: size.iScreen(1.0),
                ),
                //*****************************************/
              ],
            ),
          ),
        ),
      ),
    );
  }

  //**********************************************MODAL TIPO DE PLACA **********************************************************************//
  Future<bool?> modalFormaPago(
      BuildContext context, Responsive size, ComprobantesController ctrl) {
    return showDialog<bool>(
      barrierColor: Colors.black54,
      context: context,
      builder: (context) {
        List<String> _forma = 
        [
        "EFECTIVO", 
        "TARJETA DE CRÉDITO", 
        "TRANSFERENCIA", 
        'DEPOSITO',
        "CHEQUE", 
        "TARJETA DE DÉBITO", 
        "DINERO ELECTRÓNICO", 
        "TARJETA PREPAGO"
        ];

        return AlertDialog(
          title: const Text("SELECCIONE FORMA DE PAGO"),
          content: SizedBox(
            width: size.wScreen(100),
            height: size.hScreen(20.0), // Ajusta la altura según sea necesario
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: _forma
                    .map((e) => GestureDetector(
                          onTap: () {
                            ctrl.setFormaDePago(e);
                            Navigator.pop(context);
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: size.iScreen(0.5)),
                            padding: EdgeInsets.symmetric(
                                horizontal: size.iScreen(2.0),
                                vertical: size.iScreen(1.0)),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                e,
                                style: GoogleFonts.lexendDeca(
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
          ),
        );
      },
    );
  }

  //**********************************************MODAL TIPO DE PLACA **********************************************************************//
  Future<bool?> modalTipoDocumento(
      BuildContext context, Responsive size, ComprobantesController ctrl) {
    return showDialog<bool>(
      barrierColor: Colors.black54,
      context: context,
      builder: (context) {
        List<String> _tipos = ["CÉDULA/RUC", "PLACA", 'CONSUMIDOR FINAL'];

        return AlertDialog(
          title: const Text("SELECCIONE TIPO DE PLACA"),
          content: SizedBox(
            width: size.wScreen(100),
            height: size.hScreen(20.0), // Ajusta la altura según sea necesario
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: _tipos
                    .map((e) => GestureDetector(
                          onTap: () {
                            ctrl.setTipoDocumento(e);
                            Navigator.pop(context);
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: size.iScreen(0.5)),
                            padding: EdgeInsets.symmetric(
                                horizontal: size.iScreen(2.0),
                                vertical: size.iScreen(1.0)),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                e,
                                style: GoogleFonts.lexendDeca(
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
          ),
        );
      },
    );
  }

//   Future<bool?> _agregaPlaca(BuildContext context,
//       ComprobantesController controller, Responsive size) {
//     return showDialog<bool>(
//       context: context,
//       builder: (context) {
//         return CupertinoAlertDialog(
//             title: Container(child: const Text("AGREGAR PLACA")),
//             content: Card(
//               color: Colors.transparent,
//               elevation: 0.0,
//               child: Form(
//                 key: controller.placaFormKey,
//                 child: 
//                 Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     SizedBox(
//                       width: size.iScreen(50.0),
//                       child: 
//                       Container(
//                         // width: size.wScreen(45.0),
//                         child: TextFormField(
//                          textAlign: TextAlign.center,
//                           autofocus: true,
//                           controller: _textAddPlaca,
//                           decoration: const InputDecoration(
                         

                             
//                               ),
//                               style:TextStyle(
//                                 fontSize:size.iScreen(3.5),
//                                 color:Colors.black
//                               ),
                              
// //  initialCountryCode: 'EC',

//                           // keyboardType: TextInputType.none,
//                           inputFormatters: <TextInputFormatter>[
//                             UpperCaseText(),
//                           ],
//                           onChanged: (text) {
                           
//                             controller.seItemAddPlaca(text);
//                           },
//                            validator: (text) {
//                                           if (text!.trim().isNotEmpty) {
//                                             return null;
//                                           } else {
//                                             return 'Ingrese Placa';
//                                           }
//                                         },
                          
//                         ),
//                       ),
//                     ),
//                    TextButton(
//                         onPressed: () {
//                           final isValidS = controller.validateFormPlaca();
//                           if (!isValidS) return;
//                           if (isValidS) {
//                             _textAddPlaca.text = '';
//                             controller.agregaListaPlacas();
//                             Navigator.pop(context);
//                           }
//                           //  print(countries.firstWhere((element) => element['code'] == phone.countryISOCode)['max_length']);
//                         },
//                         child: 
//                         // Consumer<ThemeProvider>(builder: (_, valueTheme, __) {  
//                         //                 return Container(
//                         //                   alignment: Alignment.center,
//                         //                   color: valueTheme.appTheme.primaryColor,
//                         //                   width: size.iScreen(3.5),
//                         //                   padding: EdgeInsets.only(
//                         //                     top: size.iScreen(0.5),
//                         //                     bottom: size.iScreen(0.5),
//                         //                     left: size.iScreen(0.5),
//                         //                     right: size.iScreen(0.5),
//                         //                   ),
//                         //                   child: Icon(
//                         //                     Icons.add,
//                         //                     color: Colors.white,
//                         //                     size: size.iScreen(2.0),
//                         //                   ),
//                         //                 );
//                         //               },
//                         //               ),
//                      Consumer<ThemeProvider>(builder: (_, valueTheme, __) {  
//                           return    Container(
//                           decoration: BoxDecoration(
//                               color: valueTheme.appTheme.primaryColor,
//                               borderRadius: BorderRadius.circular(5.0)),
//                           // color: primaryColor,
//                           padding: EdgeInsets.symmetric(
//                               vertical: size.iScreen(0.5),
//                               horizontal: size.iScreen(0.5)),
//                           child: Text('Agregar',
//                               style: GoogleFonts.lexendDeca(
//                                   // fontSize: size.iScreen(2.0),
//                                   fontWeight: FontWeight.normal,
//                                   color: Colors.white)),
//                         );

//                        },)
                        
                        
                     
//                     )
//                   ],
//                 ),
//               ),
//             )

//             //  },)

//             );
//       },
//     );
//   }
Future<bool?> _agregaPlaca(BuildContext context,
    ComprobantesController controller, Responsive size) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.white, // Cambia el color de toda la modal a blanco
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(size.iScreen(2.0)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("AGREGAR PLACA", style: TextStyle(fontSize: size.iScreen(2.5))),
              SizedBox(height: size.iScreen(2.0)),
              Form(
                key: controller.placaFormKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: size.iScreen(50.0),
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        autofocus: true,
                        controller: _textAddPlaca,
                        decoration: const InputDecoration(
                          // Aquí puedes agregar más personalización si es necesario
                        ),
                        style: TextStyle(
                          fontSize: size.iScreen(3.5),
                          color: Colors.black,
                        ),
                        inputFormatters: <TextInputFormatter>[
                          UpperCaseText(),
                        ],
                        onChanged: (text) {
                          controller.seItemAddPlaca(text);
                        },
                        validator: (text) {
                          if (text!.trim().isNotEmpty) {
                            return null;
                          } else {
                            return 'Ingrese Placa';
                          }
                        },
                      ),
                    ),
                    SizedBox(height: size.iScreen(2.0)),
                    TextButton(
                      onPressed: () {
                        final isValidS = controller.validateFormPlaca();
                        if (!isValidS) return;
                        if (isValidS) {
                          _textAddPlaca.text = '';
                          controller.agregaListaPlacas();
                          Navigator.pop(context);
                        }
                      },
                      child: Consumer<ThemeProvider>(
                        builder: (_, valueTheme, __) {
                          return Container(
                            decoration: BoxDecoration(
                              color: valueTheme.appTheme.primaryColor,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: size.iScreen(0.5),
                              horizontal: size.iScreen(0.5),
                            ),
                            child: Text('Agregar',
                                style: GoogleFonts.lexendDeca(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                )),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

  //**********************************************MODAL TIPO DE PLACA **********************************************************************//
  Future<bool?> modalTarifas(
      BuildContext context, Responsive size, ComprobantesController ctrl) {
    return showDialog<bool>(
      barrierColor: Colors.black54,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("SELECCIONE TARIFA"),
          content: SizedBox(
            width: size.wScreen(100),
            height: size.hScreen(20.0), // Ajusta la altura según sea necesario
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: ctrl.listTarifas
                    .map((e) => GestureDetector(
                          onTap: () {
                            _controller.text = '1';
                            ctrl.setTotal();
                            ctrl.setCantidad(0.0);
                            ctrl.setTarifa(e);
                            ctrl.calculateTotal();
                            Navigator.pop(context);
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: size.iScreen(0.5)),
                            padding: EdgeInsets.symmetric(
                                horizontal: size.iScreen(2.0),
                                vertical: size.iScreen(1.0)),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                '${e['tipo']} - \$${e['valor']}',
                                style: GoogleFonts.lexendDeca(
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
          ),
        );
      },
    );
  }

  //********************************************************************************************************************//
  void _onSubmit(
    BuildContext context,
    ComprobantesController controller,
  ) async {
    final isValid = controller.validateForm();
    if (!isValid) return;
    if (isValid) {
      // if (controller.getNombreMascota == "") {
      //   NotificatiosnService.showSnackBarDanger('Debe seleccionar Mascota');
      // } else if (controller.getVetInternoNombre == "") {
      //   NotificatiosnService.showSnackBarDanger(
      //       'Debe seleccionar Veterinario Interno');
      // } else if (controller.getTipoConsulta == "") {
      //   NotificatiosnService.showSnackBarDanger(
      //       'Debe seleccionar Motivo de consulta');
      // }

      // if (controller.getNombreMascota != "" &&
      //     controller.getVetInternoNombre != "" &&
      //     controller.getTipoConsulta != "") {
      //   //   if (image != null) {
      //   //     ProgressDialog.show(context);
      //   //     controller.setNewPictureFile(image);
      //   //     await controller.upLoadImagen();
      //   //   }

      //   //   ProgressDialog.dissmiss(context);
      //   if (widget.tipo == 'CREATE') {
      //     await controller.creaHistoriaClinica(context);
      //     Navigator.pop(context);
      //   }
      //   if (widget.tipo == 'EDIT') {
      //     await controller.editaHistoriaClinica(context);
      //     Navigator.pop(context);
      //   }
      // }
    }
  }
}

class RadioButtonWithLabel extends StatelessWidget {
  final int value;
  final String label;

  const RadioButtonWithLabel({
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final radioProvider = context.watch<ComprobantesController>();

    return Column(
      children: <Widget>[
        Text(label),
        Radio<int>(
          value: value,
          groupValue: radioProvider.selectedValue,
          onChanged: (newValue) {
            radioProvider.setSelectedValue(newValue!);
          },
        ),
      ],
    );
  }
}

// class ContainerRow extends StatelessWidget {

//   @override
//   Widget build(BuildContext context) {
//        final Responsive size = Responsive.of(context);
//     return SingleChildScrollView(
//        scrollDirection: Axis.horizontal,
//        physics: const BouncingScrollPhysics(),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           for (int i = 1; i <= 7; i++)
//             Container(
//               margin: EdgeInsets.symmetric(horizontal: size.iScreen(1.0)), // Espaciado entre contenedores
//               padding: EdgeInsets.all(10.0), // Espaciado interno del contenedor
//               decoration: BoxDecoration(
//                 color: Colors.white, // Color de fondo del contenedor
//                 borderRadius: BorderRadius.circular(8.0), // Bordes redondeados
//                 border: Border.all(color: Colors.grey, width: 1), // Borde gris
//               ),
//               child: Center(
//                 child: Text(
//                   getTextForIndex(i),
//                    style: GoogleFonts.lexendDeca(
//                                     fontSize: size.iScreen(2.0),
//                                     fontWeight: FontWeight.normal,
//                                     // color: Colors.grey
//                                     )
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }

//   String getTextForIndex(int index) {
//     switch (index) {
//       case 1:
//         return '\$5';
//       case 2:
//         return '\$10';
//       case 3:
//         return '\$15';
//       case 4:
//         return '\$20';
//       case 5:
//         return '\$25';
//       case 6:
//         return '\$30';
//       case 7:
//         return 'Lleno';
//       default:
//         return '';
//     }
//   }
// }

class ContainerRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          for (int i = 1; i <= 7; i++)
            Consumer<ComprobantesController>(
              builder: (context, selectionProvider, child) {
                final isSelected =
                    selectionProvider.selectedIndex == getTextForIndex(i);
                return GestureDetector(
                  onTap: () {
                    final selectedValue = getTextForIndex(i);
                    selectionProvider.selectIndex(i);
                    selectionProvider.selectValue(selectedValue);
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        horizontal:
                            size.iScreen(0.6)), // Espaciado entre contenedores
                    padding: EdgeInsets.all(
                        size.iScreen(1.0)), // Espaciado interno del contenedor
                    decoration: BoxDecoration(
                      color: selectionProvider.selectedIndex == i
                          ? Colors.blue
                          : Colors
                              .white, // Color de fondo basado en la selección
                      borderRadius:
                          BorderRadius.circular(8.0), // Bordes redondeados
                      border: Border.all(
                          color: Colors.grey, width: 1), // Borde gris
                    ),
                    child: Center(
                      child: Text(
                        getTextForIndex(i),
                        style: GoogleFonts.lexendDeca(
                          fontSize: size.iScreen(2.5),
                          fontWeight: FontWeight.normal,
                          color: selectionProvider.selectedIndex == i
                              ? Colors.white
                              : Colors
                                  .black, // Color del texto basado en la selección
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  String getTextForIndex(int index) {
    switch (index) {
      case 1:
        return '\$5';
      case 2:
        return '\$10';
      case 3:
        return '\$15';
      case 4:
        return '\$20';
      case 5:
        return '\$25';
      case 6:
        return '\$30';
      case 7:
        return 'Lleno';
      default:
        return '';
    }
  }
}

class ContainerCombustible extends StatelessWidget {
  // Método para manejar la selección
  void _onContainerSelected(String text) {
    print('Seleccionado: $text');
  }

  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    return Container(
      width: size.wScreen(60),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          for (String text in ['Super', 'Extra con Ethanol', 'Diesel'])
            GestureDetector(
              onTap: () {
                Provider.of<ComprobantesController>(context, listen: false)
                    .select(text);
              },
              child: Consumer<ComprobantesController>(
                builder: (context, selectionNotifier, child) {
                  final isSelected =
                      selectionNotifier.selectedTextCombustible == text;
                  return Container(
                    margin: EdgeInsets.symmetric(
                        horizontal:
                            size.iScreen(1.0)), // Espaciado entre contenedores
                    padding: EdgeInsets.all(
                        size.iScreen(1.0)), // Espaciado interno del contenedor
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.blue
                          : Colors.white, // Color de fondo según selección
                      borderRadius:
                          BorderRadius.circular(8.0), // Bordes redondeados
                      border: Border.all(
                          color: Colors.grey, width: 1), // Borde gris
                    ),
                    child: Center(
                      child: Text(text,
                          style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.normal,
                            color: isSelected ? Colors.white : Colors.black,
                          )),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neitorcont/src/api/api_provider.dart';
import 'package:neitorcont/src/controllers/comprobantes_controller.dart';
import 'package:neitorcont/src/theme/theme_provider.dart';
import 'package:neitorcont/src/utils/letras_mayusculas_minusculas.dart';
import 'package:neitorcont/src/utils/responsive.dart';
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
  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    final ctrl = context.read<ComprobantesController>();
        final ctrlTheme = context.read<ThemeProvider>();
    return Scaffold(
        appBar: AppBar(
          title: widget.tipo == 'CREATE' || widget.tipo == 'SEARCH'
              ?  Text('Crear Comprobante')
              :  Text('Editar Comprobante'),
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
                                context, ctrl,);
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
        // color: Colors.redAccent,
         margin: EdgeInsets.only(
                left: size.iScreen(1.0),
                right: size.iScreen(1.0),
                bottom: size.iScreen(1.0)),
            width: size.wScreen(100),
            height: size.hScreen(100),
        child: SingleChildScrollView(

          child: Column(
            children: [
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
                          child: Text('TIPO PLACA :',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey)),
                        ),
                         Consumer<ComprobantesController>(
                      builder: (_, valueTipo, __) {
                        return Container(
                          // color: Colors.red,
                          width: size.wScreen(60.0),

                          // color: Colors.blue,
                          child: Text(
                              valueTipo.getTipoPlaca.isEmpty
                                  ? ' --- --- --- --- ---'
                                  : ' ${valueTipo.getTipoPlaca}',
                              style: GoogleFonts.lexendDeca(
                                  fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: valueTipo.getTipoPlaca.isEmpty
                                      ? Colors.grey
                                      : Colors.black)),
                        );
                      },
                    ),
                       Spacer(),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: GestureDetector(
                            onTap: () {
                              // context
                              //     .read<MascotasController>()
                              //     .buscaAllMascotas('');

                              // // _buscarMascota(context, size);
                              modalTipoPlaca(context, size,ctrl);

                              // //*******************************************/
                            },
                            child:  Consumer<ThemeProvider>(builder: (_, valueTheme, __) {  
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
                         //***********************************************/
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/
Container(
  color: Colors.grey.shade200,
  padding: EdgeInsets.only(bottom: size.iScreen(1.0)),
  child:   Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Container(
        width: size.iScreen(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
               inputFormatters: [
                                  UpperCaseText(),
                                ],
              decoration: InputDecoration(
                hintText: 'Placa', // Texto de sugerencia dentro del campo
                // border: OutlineInputBorder(), // Opcional: Añade un borde al campo
                 helperStyle:TextStyle(color: Colors.grey.shade50),
              ),
              style: TextStyle(
        fontSize: size.iScreen(2.0), // Ajusta el tamaño de la letra
        // fontWeight: FontWeight.bold, // Opcional: Aplica un peso de fuente más grueso
      ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      Container(
        width: size.iScreen(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'RUC/CI', // Texto de sugerencia dentro del campo
                // border: OutlineInputBorder(), // Opcional: Añade un borde al campo
                 helperStyle:TextStyle(color: Colors.grey.shade50),
              ),
              inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly, // Solo números
                  LengthLimitingTextInputFormatter(13), // Limita a 13 dígitos
                ],
              style: TextStyle(
        fontSize: size.iScreen(2.0), // Ajusta el tamaño de la letra
        // fontWeight: FontWeight.bold, // Opcional: Aplica un peso de fuente más grueso
      ),
               textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      Container(
        width: size.iScreen(4.0), // Ajusta el ancho del contenedor según sea necesario
        height: size.iScreen(4.0), // Ajusta la altura del contenedor según sea necesario
        decoration: BoxDecoration(
          color:ctrlTheme.appTheme.primaryColor, // Color de fondo del contenedor
          borderRadius: BorderRadius.circular(8), // Forma circular
        ),
        child: IconButton(
          icon: Icon(Icons.search, color: Colors.white), // Icono de lupa
          onPressed: () {
            // Acción al presionar el icono
          },
        ),
      ),
    ],
  ),
),
  //***********************************************/
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/
 Container(
                          width: size.wScreen(100.0),

                          // color: Colors.blue,
                          child: Text('JUAN DANIER RODRIGUEZ ROMERO',
                              style: GoogleFonts.lexendDeca(
                                  fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  // color: Colors.grey
                                  )),
                        ),

       //***********************************************/
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/
 Container(
                          width: size.wScreen(100.0),

                          // color: Colors.blue,
                          child: Text('correo@correo.com',
                              style: GoogleFonts.lexendDeca(
                                  fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  // color: Colors.grey
                                  )),
                        ),
                        //***********************************************/
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/
Container(
  color: Colors.grey.shade200,
  padding: EdgeInsets.only(bottom: size.iScreen(1.0)),
  child:   Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Container(
        width: size.iScreen(11),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           TextField(
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')), // Solo números y un punto
      ],
      decoration: InputDecoration(
        hintText: 'Kilometraje', // Texto de sugerencia dentro del campo
         helperStyle:TextStyle(color: Colors.grey.shade50),
      ),
      textAlign: TextAlign.center,
      keyboardType: TextInputType.numberWithOptions(decimal: true), 
       style: TextStyle(
        fontSize: size.iScreen(2.0), // Ajusta el tamaño de la letra
        // fontWeight: FontWeight.bold, // Opcional: Aplica un peso de fuente más grueso
      ),// Muestra teclado numérico con punto
    ),
            // TextField(
            //     controller: _rucCiController,
            //     keyboardType: TextInputType.number, // Solo permite números
            //     decoration: InputDecoration(
            //       hintText: 'RUC/CI', // Texto de sugerencia dentro del campo
            //       // border: OutlineInputBorder(), // Opcional: Añade un borde al campo
            //     ),
            //     inputFormatters: [
            //       FilteringTextInputFormatter.digitsOnly, // Solo números
            //       LengthLimitingTextInputFormatter(13), // Limita a 13 dígitos
            //     ],
            //     onChanged: (value) {
            //       if (value.length < 10) {
            //         // Opcional: Mostrar algún mensaje de error si la longitud es menor a 10
            //       }
            //     },
            //   ),
          ],
        ),
      ),
      Container(
        width: size.iScreen(20),
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
                controller: _rucCliController,
                keyboardType: TextInputType.number, // Solo permite números
                decoration: InputDecoration(
                  hintText: 'RUC/CI', // Texto de sugerencia dentro del campo
                  // border: OutlineInputBorder(), // Opcional: Añade un borde al campo
                   helperStyle:TextStyle(color: Colors.grey.shade50),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly, // Solo números
                  LengthLimitingTextInputFormatter(13), // Limita a 13 dígitos
                ],
                 style: TextStyle(
        fontSize: size.iScreen(2.0), // Ajusta el tamaño de la letra
        
        // fontWeight: FontWeight.bold, // Opcional: Aplica un peso de fuente más grueso
      ),
                onChanged: (value) {
                  if (value.length < 10) {
                    // Opcional: Mostrar algún mensaje de error si la longitud es menor a 10
                  }
                },
                 textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
  
    ],
  ),
),
  //***********************************************/
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/

                    // //***********************************************/
                    // SizedBox(
                    //   height: size.iScreen(1.0),
                    // ),
                    // //*****************************************/
                    // Consumer<ComprobantesController>(
                    //   builder: (_, valueTipo, __d) {
                    //     return SizedBox(
                    //       width: size.wScreen(100.0),

                    //       // color: Colors.blue,
                    //       child: Text(
                    //           valueTipo.getTipoPlaca.isEmpty
                    //               ? 'Seleccione tipo Placa '
                    //               : '${valueTipo.getTipoPlaca}',
                    //           style: GoogleFonts.lexendDeca(
                    //               // fontSize: size.iScreen(2.0),
                    //               fontWeight: FontWeight.normal,
                    //               color: valueTipo.getTipoPlaca.isEmpty
                    //                   ? Colors.grey
                    //                   : Colors.black)),
                    //     );
                    //   },
                    // ),
                    //***********************************************/
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/
            ],
          ),
        ),
      ),
   );
  }

  //**********************************************MODAL TIPO DE PLACA **********************************************************************//
Future<bool?> modalTipoPlaca(BuildContext context, Responsive size, ComprobantesController ctrl) {
  return showDialog<bool>(
    barrierColor: Colors.black54,
    context: context,
    builder: (context) {
      List<String> _tipos = [
        "CAMIONETA",
        "MOTO",
        "TRAILER",
        "VOQUETA",
        "BUS",
        "TRAILER",
        "VOQUETA",
        "BUS",
        "BUS",
        "TRAILER",
        "VOQUETA",
        "BUS"
      ];

      return AlertDialog(
        title: const Text("SELECCIONE TIPO DE PLACA"),
        content: SizedBox(
          width: size.wScreen(100),
          height: size.hScreen(20.0), // Ajusta la altura según sea necesario
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: _tipos.map((e) => GestureDetector(
                onTap: () {
                  ctrl.setTipoPlaca(e);
                  Navigator.pop(context);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                  padding: EdgeInsets.symmetric(horizontal: size.iScreen(2.0), vertical: size.iScreen(1.0)),
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
              )).toList(),
            ),
          ),
        ),
      );
    },
  );
}


  //********************************************************************************************************************//
  void _onSubmit(BuildContext context, ComprobantesController controller,
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
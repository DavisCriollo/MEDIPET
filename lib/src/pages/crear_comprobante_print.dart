import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neitorcont/src/api/api_provider.dart';
import 'package:neitorcont/src/controllers/comprobantes_controller.dart';
import 'package:neitorcont/src/pages/print.dart';
import 'package:neitorcont/src/theme/theme_provider.dart';
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
  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    final ctrl = context.read<ComprobantesController>();
        final ctrlTheme = context.read<ThemeProvider>();
    return GestureDetector(
      onTap: () {
         FocusScope.of(context).requestFocus( FocusNode());
      },
      child: Scaffold(
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
                  hintText: 'Nombre Conductor', // Texto de sugerencia dentro del campo
                  // border: OutlineInputBorder(), // Opcional: Añade un borde al campo
                   helperStyle:TextStyle(color: Colors.grey.shade50),
                ),
                style: TextStyle(
          fontSize: size.iScreen(2.0), // Ajusta el tamaño de la letra
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



              Container(
                width: size.wScreen(100),
                child: 
               Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            RadioButtonWithLabel(value: 1, label: 'Pasaporte'),
            RadioButtonWithLabel(value: 2, label: 'Calibración'),
            RadioButtonWithLabel(value: 3, label: 'Venta Cupo'),
            RadioButtonWithLabel(value: 4, label: 'Prepago'),
          ],
        ),
             
              ),

                ContainerRow(),

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
                            child: Text('Forma de Pago: ',
                                style: GoogleFonts.lexendDeca(
                                    fontSize: size.iScreen(2.0),
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey)),
                          ),
                           Text('EFECTIVO',
                                style: GoogleFonts.lexendDeca(
                                    fontSize: size.iScreen(2.3),
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red
                                    )),
                        ],
                      ),
                           //***********************************************/
                      SizedBox(
                        height: size.iScreen(1.0),
                      ),
                      //*****************************************/
                      Container(
                        width: size.wScreen(100.0),
                        child: ContainerCombustible()),
                      //***********************************************/
                      SizedBox(
                        height: size.iScreen(1.0),
                      ),
                      //*****************************************/


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
        //       TextField(
        //          inputFormatters: [
        //                             UpperCaseText(),
        //                           ],
        //         decoration: InputDecoration(
        //           hintText: 'Valor', // Texto de sugerencia dentro del campo
        //           // border: OutlineInputBorder(), // Opcional: Añade un borde al campo
        //            helperStyle:TextStyle(color: Colors.grey.shade50),
        //         ),
        //         style: TextStyle(
        //   fontSize: size.iScreen(2.0), // Ajusta el tamaño de la letra
        //   // fontWeight: FontWeight.bold, // Opcional: Aplica un peso de fuente más grueso
        // ),
        //         textAlign: TextAlign.center,
        //       ),
     TextField(
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')), // Permite números y un solo punto decimal
            ],
            keyboardType: TextInputType.numberWithOptions(decimal: true), // Permite punto decimal en el teclado
            decoration: InputDecoration(
              hintText: 'Valor', // Texto de sugerencia dentro del campo
              helperStyle: TextStyle(color: Colors.grey.shade50),
            ),
            style: TextStyle(
              fontSize: size.iScreen(2.2), // Ajusta el tamaño de la letra
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
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')), // Permite números y un solo punto decimal
            ],
            keyboardType: TextInputType.numberWithOptions(decimal: true), // Permite punto decimal en el teclado
            decoration: InputDecoration(
              hintText: 'Cantidad Gl/Lt', // Texto de sugerencia dentro del campo
              helperStyle: TextStyle(color: Colors.grey.shade50),
            ),
            style: TextStyle(
              fontSize: size.iScreen(2.2), // Ajusta el tamaño de la letra
            ),
            textAlign: TextAlign.center,
          ),
            ],
          ),
        ),
        // Container(
        //   width: size.iScreen(4.0), // Ajusta el ancho del contenedor según sea necesario
        //   height: size.iScreen(4.0), // Ajusta la altura del contenedor según sea necesario
        //   decoration: BoxDecoration(
        //     color:ctrlTheme.appTheme.primaryColor, // Color de fondo del contenedor
        //     borderRadius: BorderRadius.circular(8), // Forma circular
        //   ),
        //   child: IconButton(
        //     icon: Icon(Icons.search, color: Colors.white), // Icono de lupa
        //     onPressed: () {
        //       // Acción al presionar el icono
        //     },
        //   ),
        // ),
      ],
      ),
    ),
      //***********************************************/
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
                              SizedBox(
                                // width: size.wScreen(100.0),
    
                                // color: Colors.blue,
                                child: Text('Total: ',
                                    style: GoogleFonts.lexendDeca(
                                        fontSize: size.iScreen(3.0),
                                        fontWeight: FontWeight.normal,
                                        color: Colors.grey)),
                              ),
                             
                               Text(' \$ 29.58',
                                    style: GoogleFonts.lexendDeca(
                                        fontSize: size.iScreen(3.5),
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red
                                        )),
                                        Spacer(),
                                        GestureDetector(
  onTap: () {
    Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const PrintTicket()));
  },
  child:   Container(
  
                     margin: EdgeInsets.symmetric(horizontal: size.iScreen(2.5)), // Espaciado entre contenedores
                  padding: EdgeInsets.all(size.iScreen(1.0)), // Espaciado interno del contenedor
                      decoration: BoxDecoration(
                        color:ctrlTheme.appTheme.accentColor, // Color de fondo según selección
                        borderRadius: BorderRadius.circular(8.0), // Bordes redondeados
                        border: Border.all(color: Colors.grey, width: 1), // Borde gris
                      ),
                      child: Center(
                        child: 
                        Text(
                          'Imprimir',
                             style: GoogleFonts.lexendDeca(
                                      fontSize: size.iScreen(2.0),
                                      fontWeight: FontWeight.normal,
                                   color:  Colors.white ,
                                      )
                        ),
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
                final isSelected = selectionProvider.selectedIndex == getTextForIndex(i);
                return GestureDetector(
                  onTap: () {
                    final selectedValue = getTextForIndex(i);
                    selectionProvider.selectIndex(i);
                    selectionProvider.selectValue(selectedValue);
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: size.iScreen(0.6)), // Espaciado entre contenedores
                    padding: EdgeInsets.all(size.iScreen(1.0)), // Espaciado interno del contenedor
                    decoration: BoxDecoration(
                      color:  selectionProvider.selectedIndex == i ? Colors.blue : Colors.white, // Color de fondo basado en la selección
                      borderRadius: BorderRadius.circular(8.0), // Bordes redondeados
                      border: Border.all(color: Colors.grey, width: 1), // Borde gris
                    ),
                    child: Center(
                      child: Text(
                        getTextForIndex(i),
                        style: GoogleFonts.lexendDeca(
                          fontSize: size.iScreen(2.5),
                          fontWeight: FontWeight.normal,
                          color: selectionProvider.selectedIndex == i ? Colors.white : Colors.black, // Color del texto basado en la selección
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
      child: 
      
 
Row(
  mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          for (String text in ['Super', 'Extra con Ethanol', 'Diesel'])
            GestureDetector(
              onTap: () {
                Provider.of<ComprobantesController>(context, listen: false).select(text);
               
              },
              child: Consumer<ComprobantesController>(
                builder: (context, selectionNotifier, child) {
                  final isSelected = selectionNotifier.selectedTextCombustible == text;
                  return Container(
                   margin: EdgeInsets.symmetric(horizontal: size.iScreen(1.0)), // Espaciado entre contenedores
                padding: EdgeInsets.all(size.iScreen(1.0)), // Espaciado interno del contenedor
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blue : Colors.white, // Color de fondo según selección
                      borderRadius: BorderRadius.circular(8.0), // Bordes redondeados
                      border: Border.all(color: Colors.grey, width: 1), // Borde gris
                    ),
                    child: Center(
                      child: Text(
                        text,
                       
                         style: GoogleFonts.lexendDeca(
                                    fontSize: size.iScreen(2.0),
                                    fontWeight: FontWeight.normal,
                                 color:  isSelected ? Colors.white : Colors.black,
                                    )
                      ),
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
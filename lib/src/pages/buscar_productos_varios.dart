
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neitorcont/src/controllers/comprobantes_controller.dart';
import 'package:neitorcont/src/theme/theme_provider.dart';
import 'package:neitorcont/src/utils/responsive.dart';
import 'package:neitorcont/src/widgets/no_data.dart';
import 'package:provider/provider.dart';

class BuscarProductosVarios extends StatefulWidget {
  const BuscarProductosVarios({Key? key}) : super(key: key);

  @override
  State<BuscarProductosVarios> createState() => _BuscarProductosVariosState();
}

class _BuscarProductosVariosState extends State<BuscarProductosVarios> {
  TextEditingController textSearchGuardiaMulta = TextEditingController();
  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() async {
    textSearchGuardiaMulta.text = '';
  }

  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
  final ctrlTheme = context.read<ThemeProvider>();

         
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xffF2F2F2),
        appBar: AppBar(
          title: Text('Lista de Productos'),
          actions: [
            // Consumer<SocketService>(builder: (_, valueConexion, __) {
            //   return valueConexion.serverStatus == ServerStatus.Online
            //       ?
            Container(
              margin: EdgeInsets.only(right: size.iScreen(1.5)),
              child: IconButton(
                  splashRadius: 28,
                  onPressed: () {
                   Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.close,
                    size: size.iScreen(4.0),
                  )),
            )

            // : Container();
            // });
          ],
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: size.iScreen(1.5)),
          child: Column(
            children: [
              SizedBox(
                height: size.iScreen(1.5),
              ),
              //*****************************************/

              TextFormField(
                controller: textSearchGuardiaMulta,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'búsqueda Personal',
                  suffixIcon: GestureDetector(
                    onTap: () async {},
                    child: const Icon(
                      Icons.search,
                      color: Color(0XFF343A40),
                    ),
                  ),
                ),
                textAlign: TextAlign.start,
                style: const TextStyle(),
                onChanged: (text) {
                    final _ctrl=context.read<ComprobantesController>();
                     _ctrl.search(text);
                },
                validator: (text) {
                  if (text!.trim().isNotEmpty) {
                    return null;
                  } else {
                    return 'Ingrese dato para búsqueda';
                  }
                },
                onSaved: (value) {
               },
              ),
              //*****************************************/
              SizedBox(
                height: size.iScreen(1.0),
              ),

                //************************//

                



                //**************************//



              Consumer<ComprobantesController>(builder: (_, value, __) { 
                return  
                value.getRespuestaCalculoItem.isNotEmpty
               ? Wrap(
                children: value.getRespuestaCalculoItem['venProductos']
                    .map<Widget>(
                      (e) => 
                     e['descripcion'].isEmpty?Container(): GestureDetector(
                        onTap: () {
                            value.deleteItem(e);
  
                        },
                           
                        child: Container(
                          margin: EdgeInsets.all(size.iScreen(0.6)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Container(
                              padding: EdgeInsets.all(size.iScreen(0.2)),
                              decoration:  BoxDecoration(
                                color: ctrlTheme.appTheme.primaryColor,
                              ),
                              width: size.iScreen(13.0),
                              child: Text(
                                '${e['descripcion']}.',
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.lexendDeca(
                                    fontSize: size.iScreen(1.8),
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ):Container();
              
               },),
             //

              Expanded(
                  child: SizedBox(
                      // color: Colors.red,
                      width: size.iScreen(100),
                      child: 
                      Consumer<ComprobantesController>(
                        builder: (_, provider, __) {
                         
                         if (provider.getListaDeProductos.isEmpty) {
                            return const NoData(
                              label: 'No existen datos para mostar',
                            );
                            // Text("sin datos");
                          }

                          return 
                          
                          (provider.allItemsFilters.isEmpty)
                                        ? Center(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              
                                              CircularProgressIndicator(),
                                              Text('Por favor espere ....')
                                            ],
                                          ))
                                        : (provider.allItemsFilters.length > 0)
                                            ?
                          
                          
                          ListView.builder(
                            itemCount: provider.allItemsFilters.length,
                            itemBuilder: (BuildContext context, int index) {
                              final producto =
                                  provider.allItemsFilters[index];
                              return 
                              Card(
                                child: ListTile(
                                  visualDensity: VisualDensity.compact,
                                  title: Text(
                                    '${producto['invNombre']}',
                                    style: GoogleFonts.lexendDeca(
                                        fontSize: size.iScreen(1.8),
                                        // color: Colors.black54,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  subtitle: 
                                  Text(
                                   producto['invprecios'].isNotEmpty? producto['invprecios'][0]: '--- --- ---',
                                    style: GoogleFonts.lexendDeca(
                                        fontSize: size.iScreen(1.8),
                                        // color: Colors.black54,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  trailing: Column(
                                    children: [
                                      Text(
                                       'Stock',
                                        style: GoogleFonts.lexendDeca(
                                            fontSize: size.iScreen(1.5),
                                            // color: Colors.black54,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      Text(
                                       producto['invStock'].isNotEmpty? producto['invStock']: '--- ',
                                        style: GoogleFonts.lexendDeca(
                                            fontSize: size.iScreen(1.8),
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
                                    // provider.setListaDeProductosFactura(producto);
                                    _agregaCantidad(context,provider,size,producto);
                                    
                                    // print('EL ITEM ES : ${provider.getListaDeProductos[index]}');


                                   
                                   
                                   
                                   
                                  },
                                ),
                              );







                              
                            },
                          ) : const NoData(
                              label: 'No existen datos para mostar',
                            );
                        },
                      )
                      ))
            ],
          ),
        ),
      ),
    );
  }




//   Future<bool?> _agregaCantidad(BuildContext context,
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
//                 key: controller.cantidadFormKey,
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
//                           // controller: _textAddPlaca,
//                           decoration: const InputDecoration(
                         

                             
//                               ),
//                               style:TextStyle(
//                                 fontSize:size.iScreen(3.5),
//                                 color:Colors.black
//                               ),
                              
// //  initialCountryCode: 'EC',

//                           // keyboardType: TextInputType.none,
//                           inputFormatters: <TextInputFormatter>[
//                           FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
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
//                           final isValidS = controller.validateFormCantidad();
//                           if (!isValidS) return;
//                           if (isValidS) {
//                             // _textAddPlaca.text = '';
//                             // controller.agregaListaPlacas();
//                             // Navigator.pop(context);
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
Future<bool?> _agregaCantidad(BuildContext context,
    ComprobantesController controller, Responsive size,Map<String,dynamic> _item) {
controller.setPrecio(double.parse(_item['invprecios'][0].toString()));


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
              Text("AGREGAR PRODUCTO", style: TextStyle(fontSize: size.iScreen(2.5),fontWeight: FontWeight.bold)),
              SizedBox(height: size.iScreen(2.0)),
              Form(
                key: controller.cantidadFormKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                     Text("${_item['invNombre']}",
                                style: GoogleFonts.lexendDeca(
                                  fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  // color: Colors.white,
                                )),
                  
                    SizedBox(
  // width: size.iScreen(20.0),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Expanded(
        child: Container(
          width: size.iScreen(18.0),
          child: TextFormField(
            initialValue: '${controller.getPrecio}',
            textAlign: TextAlign.center,
            autofocus: false,
            decoration: InputDecoration(
              label: Text('Precio'),
              labelStyle: TextStyle(fontSize: size.iScreen(1.9)),
              // Aquí puedes agregar más personalización si es necesario
            ),
            style: TextStyle(
              fontSize: size.iScreen(3.0),
              color: Colors.black,
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
            ],
            onChanged: (text) {
              double value = 0.0;
              if (text.isNotEmpty) {
                try {
                  value = double.parse(text);
                } catch (e) {
                  // Manejo del error si el parse falla
                  value = 0.0;
                }
              }
              controller.setPrecio(value);
            },
            validator: (text) {
              if (text == null || text.isEmpty) {
                return 'Por favor, ingrese precio';
              }
              final value = double.tryParse(text);
              if (value == null) {
                return 'Ingrese un número válido';
              }
              return null; // Devuelve null si la validación es exitosa
            },
          ),
        ),
      ),
      SizedBox(width: size.iScreen(3.0)),
      Expanded(
        child: Container(
          width: size.iScreen(10.0),
          child: TextFormField(
            textAlign: TextAlign.center,
            autofocus: true,
            decoration: InputDecoration(
              label: Text('Cantidad'),
              labelStyle: TextStyle(fontSize: size.iScreen(1.9)),
              // Aquí puedes agregar más personalización si es necesario
            ),
            style: TextStyle(
              fontSize: size.iScreen(3.5),
              color: Colors.black,
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
            ],
            onChanged: (text) {
              double value = 0.0;
              if (text.isNotEmpty) {
                try {
                  value = double.parse(text);
                } catch (e) {
                  // Manejo del error si el parse falla
                  value = 0.0;
                }
              }
              controller.setCantidad(value);
            },
            validator: (text) {
              if (text == null || text.isEmpty) {
                return 'Por favor, ingrese cantidad';
              }
              final value = double.tryParse(text);
              if (value == null) {
                return 'Ingrese un número válido';
              }
              return null; // Devuelve null si la validación es exitosa
            },
          ),
        ),
      ),
    ],
  ),
),

                    SizedBox(height: size.iScreen(2.0)),
                    TextButton(
                      onPressed: () {
                        final isValidS = controller.validateFormCantidad();
                        if (!isValidS) return;
                        if (isValidS) {

                          controller.enviaProductoCalculo(_item,1);
                          Navigator.pop(context);
                              // print('EL ITEM ES : $_item}');
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








}

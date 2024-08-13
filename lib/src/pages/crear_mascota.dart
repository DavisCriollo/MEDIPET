import 'dart:io';

import 'package:awesome_calendar/awesome_calendar.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:neitorcont/src/controllers/mascotas_controller.dart';
import 'package:neitorcont/src/controllers/propietarios_controller.dart';
import 'package:neitorcont/src/services/notifications_service.dart';
import 'package:neitorcont/src/services/socket_service.dart';
import 'package:neitorcont/src/theme/themes_app.dart';
import 'package:neitorcont/src/utils/dialogs.dart';
import 'package:neitorcont/src/utils/letras_mayusculas_minusculas.dart';
import 'package:neitorcont/src/utils/responsive.dart';
import 'package:neitorcont/src/utils/theme.dart';
import 'package:neitorcont/src/utils/valida_email.dart';
import 'package:neitorcont/src/widgets/dropdown_estado_animal.dart';
import 'package:neitorcont/src/widgets/no_data.dart';
import 'package:provider/provider.dart';

class CrearMascota extends StatefulWidget {
  // final String? action;
  const CrearMascota({
    Key? key,
  }) : super(key: key);

  @override
  State<CrearMascota> createState() => _CrearMascotaState();
}

class _CrearMascotaState extends State<CrearMascota> {
  final countryPicker = const FlCountryCodePicker();
  CountryCode? countryCode;
  final controlerMascota = MascotasController();
// ======================================//

  File? image;

  Future pickImageGalery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemp = File(image.path);
      // print('imageTemp: $imageTemp');
      controlerMascota.setNewPictureFile(this.image);
// controlerMascota.setNewPictureFile(this.image);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      NotificatiosnService.showSnackBarError(e.message.toString());
      // print('Failed to pick image: $e');
    }
  }

  Future pickImageCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;

      final imageTemp = File(image.path);
// print('imageTemp: $imageTemp');
// controlerMascota.setNewPictureFile(image);
      controlerMascota.setNewPictureFile(this.image);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      NotificatiosnService.showSnackBarError(e.message.toString());
    }
  }

// ======================================//

  // File? _newPicker;

  DateTime initialDate = DateTime.now();

  DateTime? singleSelect;
  DateTime embeddedCalendar = DateTime.now();
  List<DateTime>? multiSelect;
  List<DateTime>? rangeSelect;
  List<DateTime>? multiOrRangeSelect;

  TextEditingController _nombreMascotaController = TextEditingController();
  TextEditingController _colorMascotaController = TextEditingController();
  TextEditingController _microChipMascotaController = TextEditingController();
  TextEditingController _caracterMascotaController = TextEditingController();
  TextEditingController _observacionMascotaController = TextEditingController();
  TextEditingController _fechaController = TextEditingController();

  TextEditingController controllerTextCountry = TextEditingController();
  TextEditingController controllerNombreContacto = TextEditingController();
  TextEditingController _correoController = TextEditingController();

  late TimeOfDay timerFecha;

  // final _listaEspecies = [];
  // final _listaAlimentos = [];
  final _listaSexoAnimal = [];

  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  void dispose() {
    _fechaController.clear();
    _nombreMascotaController.clear();
    _colorMascotaController.clear();
    _microChipMascotaController.clear();
    _observacionMascotaController.clear();

    controllerTextCountry.clear();
    controllerNombreContacto.clear();
    _correoController.clear();

    super.dispose();
  }

  initData() async {
    timerFecha = TimeOfDay.now();
    controlerMascota.resetFormMascota();

    await controlerMascota.buscaSexoMascota();

    final _sexo = controlerMascota.getListaSexoMascota;

    _listaSexoAnimal.addAll(_sexo);
  }

  @override
  Widget build(BuildContext context) {
    final _action = ModalRoute.of(context)!.settings.arguments;
    // print('_action:$_action');

    final Responsive size = Responsive.of(context);
    final controller = context.read<MascotasController>();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          appBar: AppBar(
            title: _action == 'CREATE' || _action == 'SEARCH'
                ?  Text('Crear Mascota',style:  Theme.of(context).textTheme.headline2,)
                :  Text('Editar Mascota',style:  Theme.of(context).textTheme.headline2,),
            actions: [
              Container(
                margin: EdgeInsets.only(right: size.iScreen(1.5)),
                child: IconButton(
                    splashRadius: 28,
                    onPressed: () {
                      _onSubmit(context, controller, _action.toString());
                    },
                    icon: Icon(
                      Icons.save_outlined,
                      size: size.iScreen(4.0),
                    )),
              )
            ],
          ),
          body: Container(
            // color: Colors.red,
            margin: EdgeInsets.only(
                left: size.iScreen(1.5),
                right: size.iScreen(1.5),
                bottom: size.iScreen(1.0)),
            width: size.wScreen(100),
            height: size.hScreen(100),
            child: Consumer<SocketService>(builder: (_, valueMenu, __) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: controller.mascotasFormKey,
                  child: Column(
                    children: [
                      //***********************************************/
                      SizedBox(
                        height: size.iScreen(0.0),
                      ),
                      //*****************************************/

//                         Row(
//                           children: [
//                             SizedBox(
//                               // width: size.wScreen(100.0),

//                               // color: Colors.blue,
//                               child: Text('Propietario  ',
//                                   style: GoogleFonts.lexendDeca(
//                                       // fontSize: size.iScreen(2.0),
//                                       fontWeight: FontWeight.normal,
//                                       color: Colors.grey)),
//                             ),
//                             ClipRRect(
//                               borderRadius: BorderRadius.circular(8),
//                               child: GestureDetector(
//                                 onTap: () async {
//                                   await context
//                                       .read<PropietariosController>()
//                                       .buscaAllPropietarios('');
//                                   _buscarPropietario(context, size);

// //*******************************************/
//                                 },
//                                 child: Container(
//                                   alignment: Alignment.center,
//                                   color: primaryColor,
//                                   width: size.iScreen(3.5),
//                                   padding: EdgeInsets.only(
//                                     top: size.iScreen(0.5),
//                                     bottom: size.iScreen(0.5),
//                                     left: size.iScreen(0.5),
//                                     right: size.iScreen(0.5),
//                                   ),
//                                   child: Icon(
//                                     Icons.add,
//                                     color: Colors.white,
//                                     size: size.iScreen(2.0),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),

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
                            child: Text('Propietario ',
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
                                    .read<PropietariosController>()
                                    .buscaAllPropietarios('');

                                // _buscarPropietario(context, size);
                                _buscarPropietario(context, size);

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
                                    )
                            ),
                          ),
                        ],
                      ),
                      //***********************************************/
                      SizedBox(
                        height: size.iScreen(1.0),
                      ),
                      //*****************************************/
                      Consumer<MascotasController>(
                        builder: (_, valuePropietario, __d) {
                          return SizedBox(
                            width: size.wScreen(100.0),

                            // color: Colors.blue,
                            child: Text(
                                valuePropietario.getNombrePropietario!.isEmpty
                                    ? 'DEBE AGREGAR PROPIETARIO '
                                    : '${valuePropietario.getNombrePropietario}',
                                style: GoogleFonts.lexendDeca(
                                    // fontSize: size.iScreen(2.0),
                                    fontWeight: FontWeight.normal,
                                    color: valuePropietario
                                            .getNombrePropietario!.isEmpty
                                        ? Colors.grey
                                        : Colors.black)),
                          );
                        },
                      ),

                      //***********************************************/
                      SizedBox(
                        height: size.iScreen(2.0),
                      ),
                      //*****************************************/

                      SizedBox(
                        width: size.wScreen(100.0),

                        // color: Colors.blue,
                        child: Text('Nombre de Mascota',
                            style: GoogleFonts.lexendDeca(
                                // fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                      ),
                      Container(
                        // width: size.wScreen(45.0),
                        child: TextFormField(
                          initialValue: _action == 'CREATE'
                              ? ''
                              : controller.getNombreMascota,
                          // controller: _textDireccion,
                          decoration: const InputDecoration(
                              // suffixIcon: Icon(Icons.beenhere_outlined)
                              ),
                          inputFormatters: [
                            UpperCaseText(),
                          ],
                          // textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: size.iScreen(2.0),
                            // fontWeight: FontWeight.bold,
                            // letterSpacing: 2.0,
                          ),
                          onChanged: (text) {
                            controller.setNombreMascota(text);
                          },
                          validator: (text) {
                            if (text!.trim().isNotEmpty) {
                              return null;
                            } else {
                              return 'Ingrese nombre de mascota';
                            }
                          },
                        ),
                      ),

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
                            child: Text('Especies',
                                style: GoogleFonts.lexendDeca(
                                    // fontSize: size.iScreen(2.0),
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey)),
                          ),
                          SizedBox(
                            width: size.iScreen(2.0),
                          ),
                          //*****************************************/
                          Consumer<MascotasController>(
                            builder: (_, valueEspecies, __) {
                              return SizedBox(
                                // width: size.wScreen(100.0),

                                // color: Colors.blue,
                                child: Text(
                                    valueEspecies.getEspecie == null
                                        ? ' Seleccione especie '
                                        : '${valueEspecies.getEspecie}',
                                    style: GoogleFonts.lexendDeca(
                                        // fontSize: size.iScreen(2.0),
                                        fontWeight: FontWeight.normal,
                                        color: valueEspecies.getEspecie == null
                                            ? Colors.grey
                                            : Colors.black)),
                              );
                            },
                          ),

                          //***********************************************/
                          Spacer(),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: GestureDetector(
                              onTap: () async {
                                await controller.buscaEspecies();
                                _modalEspecies_razas(context, size, controller);

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
                                    )
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
                        width: size.wScreen(100.0),

                        // color: Colors.blue,
                        child: Row(
                          children: [
                            Text('Raza:',
                                style: GoogleFonts.lexendDeca(
                                    // fontSize: size.iScreen(2.0),
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey)),
                            //*****************************************/
                            Consumer<MascotasController>(
                              builder: (_, valueRazas, __) {
                                return SizedBox(
                                  // width: size.wScreen(100.0),

                                  // color: Colors.blue,
                                  child: Text(
                                      valueRazas.getRaza == null
                                          ? ' No ha Seleccionado Raza '
                                          : ' ${valueRazas.getRaza}',
                                      style: GoogleFonts.lexendDeca(
                                          // fontSize: size.iScreen(2.0),
                                          fontWeight: FontWeight.normal,
                                          color: valueRazas.getRaza == null
                                              ? Colors.grey
                                              : Colors.black)),
                                );
                              },
                            ),

                            //***********************************************/
                          ],
                        ),
                      ),
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
                            child: Text('Alimento:',
                                style: GoogleFonts.lexendDeca(
                                    // fontSize: size.iScreen(2.0),
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey)),
                          ),
                          SizedBox(
                            width: size.iScreen(2.0),
                          ),
                          //*****************************************/
                          Consumer<MascotasController>(
                            builder: (_, valueAlimentos, __d) {
                              return SizedBox(
                                // width: size.wScreen(100.0),

                                // color: Colors.blue,
                                child: Text(
                                    valueAlimentos.getAlimento == null
                                        ? ' Seleccione Alimento '
                                        : '${valueAlimentos.getAlimento}',
                                    style: GoogleFonts.lexendDeca(
                                        // fontSize: size.iScreen(2.0),
                                        fontWeight: FontWeight.normal,
                                        color:
                                            valueAlimentos.getAlimento == null
                                                ? Colors.grey
                                                : Colors.black)),
                              );
                            },
                          ),

                          //***********************************************/
                          Spacer(),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: GestureDetector(
                              onTap: () async {
                                // context
                                //     .read<PropietariosController>()
                                //     .buscaAllPropietarios('');
                                // _agregaContactoExtra(context, size);

                                await controller.buscaAlimentos();
                                _modalAlimentos_TipoAlimento(
                                    context, size, controller);

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
                                    )
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
                        width: size.wScreen(100.0),

                        // color: Colors.blue,
                        child: Row(
                          children: [
                            Text('Tipo de alimento:',
                                style: GoogleFonts.lexendDeca(
                                    // fontSize: size.iScreen(2.0),
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey)),
                            //*****************************************/
                            Consumer<MascotasController>(
                              builder: (_, valueTipoAlimentos, __d) {
                                return SizedBox(
                                  // width: size.wScreen(100.0),

                                  // color: Colors.blue,
                                  child: Text(
                                      valueTipoAlimentos.getTipoAlimento == null
                                          ? ' No ha Seleccionado Tipo '
                                          : '${valueTipoAlimentos.getTipoAlimento}',
                                      style: GoogleFonts.lexendDeca(
                                          // fontSize: size.iScreen(2.0),
                                          fontWeight: FontWeight.normal,
                                          color: valueTipoAlimentos
                                                      .getTipoAlimento ==
                                                  null
                                              ? Colors.grey
                                              : Colors.black)),
                                );
                              },
                            ),

                            //***********************************************/
                          ],
                        ),
                      ),

                      // //***********************************************/

                      Container(
                        width: size.wScreen(100.0),

                        // color: Colors.blue,
                        child: Row(
                          children: [
                            Text('Sexo:',
                                style: GoogleFonts.lexendDeca(
                                    // fontSize: size.iScreen(2.0),
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey)),
                            // const DropMenuTipoCliente(
                            //   data: [
                            //     'FRECUENTE',
                            //     'TEMPORAL',
                            //     'OCASIONAL',
                            //     'ESPECIAL',
                            //   ],
                            //   hinText: 'Seleccione Provinciaa',
                            // ),
                            Expanded(
                              child: Container(
                                width: size.wScreen(100.0),
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.iScreen(2.0),
                                    vertical: size.iScreen(0)),
                                alignment: Alignment.center,
                                child: Consumer<MascotasController>(
                                  builder: (_, valueSexo, __) {
                                    return DropdownButton<String>(
                                      value: valueSexo.getSexoAnimal,
                                      isExpanded: true,
                                      hint: _action == 'CREATE'
                                          ? const Text('Seleccione sexo ')
                                          : valueSexo.getSexoAnimal != null
                                              ? Text(
                                                  '${valueSexo.getSexoAnimal}')
                                              : const Text('Seleccione Sexo'),

                                      //  const Text(
                                      //     'Seleccione Provincia'),
                                      items:
                                          // _listaDepaises.map((e) {
                                          _listaSexoAnimal.map((e) {
                                        return DropdownMenuItem<String>(
                                          onTap: () {
                                            // print(
                                            //     'object: ${e['nombre']}');
                                            // valueSexo.setTipoAlimento(
                                            //     e['nombre']);
                                          },
                                          value: e['sexNombre'],
                                          child: Text(
                                            e['sexNombre'],
                                            style: GoogleFonts.lexendDeca(
                                                fontSize: size.iScreen(1.7),
                                                color: Colors.black87,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (text) {
                                        valueSexo.setSexoAnimal(text);
                                      },
                                    );
                                  },
                                ),
                              ),
                            )
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
                        // color: Colors.red,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  width: size.wScreen(40.0),

                                  // color: Colors.blue,
                                  child: Text('Color',
                                      style: GoogleFonts.lexendDeca(
                                          // fontSize: size.iScreen(2.0),
                                          fontWeight: FontWeight.normal,
                                          color: Colors.grey)),
                                ),
                                SizedBox(
                                  width: size.wScreen(40.0),

                                  // color: Colors.blue,
                                  child: TextFormField(
                                    initialValue: _action == 'CREATE'
                                        ? ''
                                        : controller.getColor,
                                    // controller: _textCogetColor,
                                    decoration: const InputDecoration(
                                        // suffixIcon: Icon(Icons.beenhere_outlined)
                                        ),
                                    // textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: size.iScreen(2.0),
                                      // fontWeight: FontWeight.bold,
                                      // letterSpacing: 2.0,
                                    ),
                                    onChanged: (text) {
                                      controller.setColor(text);
                                    },
                                    validator: (text) {
                                      if (text!.trim().isNotEmpty) {
                                        return null;
                                      } else {
                                        return 'Ingrese color de mascota';
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  width: size.wScreen(40.0),
                                  margin:
                                      EdgeInsets.only(top: size.iScreen(2.0)),

                                  // color: Colors.blue,
                                  child: Text('Estado',
                                      style: GoogleFonts.lexendDeca(
                                          // fontSize: size.iScreen(2.0),
                                          fontWeight: FontWeight.normal,
                                          color: Colors.grey)),
                                ),
                                const SizedBox(
                                  // width: size.wScreen(.0),

                                  // color: Colors.blue,
                                  child: DropMenuEstadoAnimal(
                                    data: [
                                      'Vivo',
                                      'Fallecido',
                                      'Extraviado',
                                    ],
                                    hinText: 'Seleccione Estado',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.iScreen(1.0),
                      ),
                      //*****************************************/

                      Consumer<MascotasController>(
                        builder: (_, valueEdad, __) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'Fecha de Nacimiento',
                                    style: GoogleFonts.lexendDeca(
                                      // fontSize: size.iScreen(1.8),
                                      color: Colors.black45,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.iScreen(1.0),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      _fechaNacimiento(context, controller);
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          valueEdad.getInputfechaNacimiento ??
                                              'yyyy-mm-dd',
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
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    'Años',
                                    style: GoogleFonts.lexendDeca(
                                      // fontSize: size.iScreen(1.8),
                                      color: Colors.black45,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Container(
                                    width: size.wScreen(15.0),
                                    child: TextFormField(
                                      maxLength: 2,
                                      decoration: const InputDecoration(),
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'[0-9]')),
                                      ],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: size.iScreen(2.0),
                                        // fontWeight: FontWeight.bold,
                                        // letterSpacing: 2.0,
                                      ),
                                      onChanged: (text) {
                                        controller.setInputAnios(text);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    'Meses',
                                    style: GoogleFonts.lexendDeca(
                                      // fontSize: size.iScreen(1.8),
                                      color: Colors.black45,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Container(
                                    width: size.wScreen(15.0),
                                    child: TextFormField(
                                      maxLength: 2,
                                      decoration: const InputDecoration(),
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'[0-9]')),
                                      ],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: size.iScreen(2.0),
                                        // fontWeight: FontWeight.bold,
                                        // letterSpacing: 2.0,
                                      ),
                                      onChanged: (text) {
                                        controller.setInputMeses(text);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),

                      //***********************************************/
                      SizedBox(
                        height: size.iScreen(1.0),
                      ),

                      //*****************************************/
                      //***********************************************/
                      SizedBox(
                        height: size.iScreen(1.0),
                      ),
                      //*****************************************/
                      Container(
                        width: size.wScreen(100.0),
                        // color: Colors.red,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  width: size.wScreen(40.0),

                                  // color: Colors.blue,
                                  child: Text('MicroChip',
                                      style: GoogleFonts.lexendDeca(
                                          // fontSize: size.iScreen(2.0),
                                          fontWeight: FontWeight.normal,
                                          color: Colors.grey)),
                                ),
                                SizedBox(
                                  width: size.wScreen(40.0),

                                  // color: Colors.blue,
                                  child: TextFormField(
                                    initialValue: _action == 'CREATE'
                                        ? ''
                                        : controller.getMicroChip,
                                    // controller: _textDireccion,
                                    decoration: const InputDecoration(
                                        // suffixIcon: Icon(Icons.beenhere_outlined)
                                        ),
                                    // textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: size.iScreen(2.0),
                                      // fontWeight: FontWeight.bold,
                                      // letterSpacing: 2.0,
                                    ),
                                    onChanged: (text) {
                                      controller.setMicroChip(text);
                                    },
                                    // validator: (text) {
                                    //   if (text!.trim().isNotEmpty) {
                                    //     return null;
                                    //   } else {
                                    //     return 'Ingrese color de mascota';
                                    //   }
                                    // },
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  width: size.wScreen(40.0),

                                  // color: Colors.blue,
                                  child: Text('Caracter',
                                      style: GoogleFonts.lexendDeca(
                                          // fontSize: size.iScreen(2.0),
                                          fontWeight: FontWeight.normal,
                                          color: Colors.grey)),
                                ),
                                SizedBox(
                                  width: size.wScreen(40.0),

                                  // color: Colors.blue,
                                  child: TextFormField(
                                    initialValue: _action == 'CREATE'
                                        ? ''
                                        : controller.getCaracter,
                                    // controller: _textDireccion,
                                    decoration: const InputDecoration(
                                        // suffixIcon: Icon(Icons.beenhere_outlined)
                                        ),
                                    // textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: size.iScreen(2.0),
                                      // fontWeight: FontWeight.bold,
                                      // letterSpacing: 2.0,
                                    ),
                                    onChanged: (text) {
                                      controller.setCaracter(text);
                                    },
                                    // validator: (text) {
                                    //   if (text!.trim().isNotEmpty) {
                                    //     return null;
                                    //   } else {
                                    //     return 'Ingrese color de mascota';
                                    //   }
                                    // },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      //***********************************************/
                      SizedBox(
                        height: size.iScreen(1.0),
                      ),
                      //*****************************************/

                      SizedBox(
                        width: size.wScreen(100.0),

                        // color: Colors.blue,
                        child: Text('Observaciones',
                            style: GoogleFonts.lexendDeca(
                                // fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                      ),
                      Container(
                        // width: size.wScreen(45.0),
                        child: TextFormField(
                          initialValue: _action == 'CREATE'
                              ? ''
                              : controller.getObservacionMascota,
                          // controller: _textDireccion,
                          decoration: const InputDecoration(
                              // suffixIcon: Icon(Icons.beenhere_outlined)
                              ),
                          // textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: size.iScreen(2.0),
                            // fontWeight: FontWeight.bold,
                            // letterSpacing: 2.0,
                          ),
                          onChanged: (text) {
                            controller.setObservacionMascota(text);
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
                            child: Text('Contacto Extra ',
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
                                    .resetFormModalContactoExtra();

                                _agregaContactoExtra(context, size);

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
                                          Icons.person_add,
                                          color: valueTheme.getSecondryTextColor,
                                          size: size.iScreen(2.0),
                                        ),
                                      );
                                    },
                                    )
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
                        // color:Colors.green,
                        padding:
                            EdgeInsets.symmetric(horizontal: size.iScreen(0.5)),
                        width: size.wScreen(100),
                        child: Consumer<MascotasController>(
                          builder: (_, valueContacto, __) {
                            return Wrap(
                              children: valueContacto.getListaContactos
                                  .map((e) => GestureDetector(
                                        onDoubleTap: () {
                                          valueContacto.eliminaContactoExtra(e);
                                        },
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                            vertical: size.iScreen(0.5),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              vertical: size.iScreen(0.0),
                                              horizontal: size.iScreen(1.0)),
                                          color: Colors.grey.shade200,
                                          child: Column(
                                            children: [
                                              Container(
                                                width: size.wScreen(100),
                                                margin: EdgeInsets.symmetric(
                                                    vertical:
                                                        size.iScreen(0.5)),
                                                child: Text(
                                                  e['nombre'],
                                                  style: GoogleFonts.lexendDeca(
                                                    // fontSize: size.iScreen(2.0),
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    // color: Colors.grey,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.symmetric(
                                                    vertical:
                                                        size.iScreen(0.5)),
                                                width: size.wScreen(100.0),
                                                child: Text(
                                                  '${e['celular']}',
                                                  style: GoogleFonts.lexendDeca(
                                                      // fontSize: size
                                                      //     .iScreen(
                                                      //         1.8),
                                                      // color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                              ),
                                              // Container(
                                              //   width: size.wScreen(100),
                                              //   margin: EdgeInsets.symmetric(
                                              //       vertical:
                                              //           size.iScreen(0.5)),
                                              //   child: Text(e['celular'],
                                              //       style:
                                              //           GoogleFonts.lexendDeca(
                                              //         // fontSize: size.iScreen(2.0),
                                              //         fontWeight:
                                              //             FontWeight.normal,
                                              //         // color: Colors.grey,
                                              //       )),
                                              // ),
                                              Container(
                                                width: size.wScreen(100),
                                                margin: EdgeInsets.symmetric(
                                                    vertical:
                                                        size.iScreen(0.5)),
                                                child: Text(e['correo'],
                                                    style:
                                                        GoogleFonts.lexendDeca(
                                                      // fontSize: size.iScreen(2.0),
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      // color: Colors.grey,
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            );
                          },
                        ),
                        // height: size.iScreen(6.0),
                      ),

                      // //***********************************************/
                      SizedBox(
                        height: size.iScreen(2.0),
                      ),
                      // //*****************************************/

                      //*****************************************/
                      Consumer<MascotasController>(
                        builder: (_, valueUrl, __) {
                          return valueUrl.getFotUrlTemp != ''
                              ? Column(
                                  children: [
                                    SizedBox(
                                      width: size.wScreen(100.0),

                                      // color: Colors.blue,
                                      child: Text('Foto:',
                                          style: GoogleFonts.lexendDeca(
                                              // fontSize: size.iScreen(2.0),
                                              fontWeight: FontWeight.normal,
                                              color: Colors.grey)),
                                    ),
                                    SizedBox(
                                      height: size.iScreen(1.0),
                                    ),
                                    Stack(
                                      children: [
                                        Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: size.iScreen(1.5)),
                                            child: FadeInImage.assetNetwork(
                                              // fit: BoxFit.fitHeight,
                                              placeholder:
                                                  'assets/imgs/loading.gif',
                                              image: valueUrl
                                                  .getFotUrlTemp!, //'https://picsum.photos/id/237/500/300',
                                            )),
                                        Positioned(
                                          top: 5.0,
                                          left: 3.0,
                                          // bottom: -3.0,
                                          child: IconButton(
                                            color:
                                                tercearyColor, // Colors.red.shade700,
                                            onPressed: () {
                                              ProgressDialog.show(context);

                                              valueUrl.deleteFoto(
                                                  valueUrl.getFotUrlTemp!);
                                              if (valueUrl.getErrorDeleteFoto ==
                                                  false) {
                                                // ProgressDialog.dissmiss(
                                                //     context);
                                              } else if (valueUrl
                                                      .getErrorDeleteFoto ==
                                                  true) {
                                                NotificatiosnService
                                                    .showSnackBarError(
                                                        'Error al Eliminar Foto');
                                              }
                                              ProgressDialog.dissmiss(context);
                                            },
                                            icon: Icon(
                                              Icons.delete_forever,
                                              size: size.iScreen(3.5),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                )
                              : Container();
                        },
                      ),

                      // //***********************************************/
                      SizedBox(
                        height: size.iScreen(2.0),
                      ),
                      // //*****************************************/

// Consumer<MascotasController>(builder: (__, valueFotos, _) {

//   return  valueFotos.getNewPictureFile==null
//   ?
//   Container():

//  },),

                      image != null
                          ? SizedBox(
                              width: size.wScreen(100.0),

                              // color: Colors.blue,
                              child: Text('Foto',
                                  style: GoogleFonts.lexendDeca(
                                      // fontSize: size.iScreen(2.0),
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey)),
                            )
                          : Container(),

                      image != null
                          ? Stack(
                              children: [
                                Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: size.iScreen(1.5)),
                                    child: image != null
                                        ? Image.file(image!)
                                        : Container()),
                                image != null
                                    ? Positioned(
                                        top: 5.0,
                                        right: 3.0,
                                        // bottom: -3.0,
                                        child: IconButton(
                                          color:
                                              tercearyColor, // Colors.red.shade700,
                                          onPressed: () {
                                            setState(() {
                                              // fotoUrl.eliminaFotoUrl(e['url']);
                                              image = null;
                                            });
                                            // bottomSheetMaps(context, size);
                                          },
                                          icon: Icon(
                                            Icons.delete_forever,
                                            size: size.iScreen(3.5),
                                          ),
                                        ),
                                      )
                                    : Container(),
                              ],
                            )
                          : Container(),
                    ],
                  ),
                ),
              );
            }),
          ),
          floatingActionButton: 
          Consumer<MascotasController>(
            builder: (_, valueBtn, __) {
              return  valueBtn.getFotUrlTemp == ''
                  ? FloatingActionButton(
                      child: const Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        bottomSheet(controller, context, size);
                      })
                  : Container();
            },
          )),
    );
  }

  Future<String?> _modalPropietario(
      BuildContext context, Responsive size, MascotasController controller) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Center(child: const Text('Especies')),
        content: Container(
          height: size.hScreen(50.0),
          width: double.maxFinite,
          child: ListView.builder(
            itemCount: controller.getListaTodasLasEspecies.length,
            itemBuilder: (BuildContext context, int index) {
              final especiesList = controller.getListaTodasLasEspecies[index];
              final List razasList =
                  controller.getListaTodasLasEspecies[index]['espRazas'];

              return ExpansionTile(title: Text('${especiesList['espNombre']}'),
                  // subtitle: Text('Trailing expansion arrow icon'),
                  children: [
                    Wrap(
                      children: razasList
                          .map(
                            (e) => ListTile(
                              onTap: () {
// print('ESPECIE: ${especiesList['espNombre']}');
                                controller
                                    .setEspecie(especiesList['espNombre']);
// print('RAZA: ${e['nombre']}');
                                controller.setRaza(e['nombre']);

                                Navigator.pop(context);
                              },
                              title: Text('${e['nombre']}'),
                            ),
                          )
                          .toList(),
                    )
                  ]);
            },
          ),
        ),
        // actions: <Widget>[
        //   TextButton(
        //     onPressed: () => Navigator.pop(context, 'Cancel'),
        //     child: const Text('Cancel'),
        //   ),
        //   TextButton(
        //     onPressed: () => Navigator.pop(context, 'OK'),
        //     child: const Text('OK'),
        //   ),
        // ],
      ),
    );
  }

  Future<String?> _modalEspecies_razas(
      BuildContext context, Responsive size, MascotasController controller) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Center(child: const Text('Especies')),
        content: Container(
          height: size.hScreen(50.0),
          width: double.maxFinite,
          child: ListView.builder(
            itemCount: controller.getListaTodasLasEspecies.length,
            itemBuilder: (BuildContext context, int index) {
              final especiesList = controller.getListaTodasLasEspecies[index];
              final List razasList =
                  controller.getListaTodasLasEspecies[index]['espRazas'];

              return ExpansionTile(title: Text('${especiesList['espNombre']}'),
                  // subtitle: Text('Trailing expansion arrow icon'),
                  children: [
                    Wrap(
                      children: razasList
                          .map(
                            (e) => ListTile(
                              onTap: () {
// print('ESPECIE: ${especiesList['espNombre']}');
                                controller
                                    .setEspecie(especiesList['espNombre']);
// print('RAZA: ${e['nombre']}');
                                controller.setRaza(e['nombre']);

                                Navigator.pop(context);
                              },
                              title: Text('${e['nombre']}'),
                            ),
                          )
                          .toList(),
                    )
                  ]);
            },
          ),
        ),
      ),
    );
  }

  Future<String?> _modalAlimentos_TipoAlimento(
      BuildContext context, Responsive size, MascotasController controller) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Center(child: const Text('Alimntos')),
        content: Container(
          height: size.hScreen(50.0),
          width: double.maxFinite,
          child: ListView.builder(
            itemCount: controller.getListaTodosLosAlimentos.length,
            itemBuilder: (BuildContext context, int index) {
              final _alimentosList =
                  controller.getListaTodosLosAlimentos[index];
              final List _tiposList =
                  controller.getListaTodosLosAlimentos[index]['aliTipo'];

              return _alimentosList.isNotEmpty
                  ? ExpansionTile(title: Text('${_alimentosList['aliNombre']}'),
                      // subtitle: Text('Trailing expansion arrow icon'),
                      children: [
                          Wrap(
                            children: _tiposList
                                .map(
                                  (e) => ListTile(
                                    onTap: () {
// print('ESPECIE: ${especiesList['aliNombre']}');
                                      controller.setAlimento(
                                          _alimentosList['aliNombre']);
// print('RAZA: ${e['nombre']}');
                                      controller.setTipoAlimento(e['nombre']);

                                      Navigator.pop(context);
                                    },
                                    title: Text('${e['nombre']}'),
                                  ),
                                )
                                .toList(),
                          )
                        ])
                  : NoData(label: 'No existen alimentos registrados');
            },
          ),
        ),
      ),
    );
  }

  void bottomSheet(
    MascotasController controller,
    BuildContext context,
    Responsive size,
  ) {
    showCupertinoModalPopup(
        context: context,
        builder: (_) => CupertinoActionSheet(
              // title: Text(title, style: GoogleFonts.lexendDeca(
              //               fontSize: size.dp(1.8),
              //               fontWeight: FontWeight.w500,
              //               // color: Colors.white,
              //             )),

              actions: [
                CupertinoActionSheetAction(
                  onPressed: () {
                    // urls.launchWaze(lat, lng);s
                    // _funcionCamara(ImageSource.camera, controller);
                    pickImageCamera();
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Abrir Cámara',
                          style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(2.2),
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          )),
                      Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: size.iScreen(2.0),
                          ),
                          child: Icon(Icons.camera_alt_outlined,
                              size: size.iScreen(3.0))),
                    ],
                  ),
                ),
                CupertinoActionSheetAction(
                  onPressed: () {
                    // _funcionCamara(ImageSource.gallery, controller);
                    pickImageGalery();
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Abrir Galería',
                          style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(2.2),
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          )),
                      Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: size.iScreen(2.0),
                          ),
                          child: Icon(Icons.image_outlined,
                              size: size.iScreen(3.0))),
                    ],
                  ),
                ),
              ],
              // cancelButton: CupertinoActionSheetAction(
              //   onPressed: () => Navigator.of(context).pop(),
              //   child: Text('Close'),
              // ),
            ));
  }

// ===========================================//

  Future<void> singleSelectPicker() async {
    final DateTime? picked = await showDialog<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return const AwesomeCalendarDialog(
          selectionMode: SelectionMode.single,
        );
      },
    );
    if (picked != null) {
      setState(() {
        singleSelect = picked;
      });
    }
  }

  Future<void> multiSelectPicker() async {
    final List<DateTime>? picked = await showDialog<List<DateTime>>(
      context: context,
      builder: (BuildContext context) {
        return const AwesomeCalendarDialog(
          selectionMode: SelectionMode.multi,
        );
      },
    );
    if (picked != null) {
      setState(() {
        multiSelect = picked;
      });
    }
  }

  Future<void> rangeSelectPicker() async {
    final List<DateTime>? picked = await showDialog<List<DateTime>>(
      context: context,
      builder: (BuildContext context) {
        return const AwesomeCalendarDialog(
          selectionMode: SelectionMode.range,
        );
      },
    );
    if (picked != null) {
      setState(() {
        rangeSelect = picked;
      });
    }
  }

  Future<void> multiOrRangeSelectPicker() async {
    final List<DateTime>? picked = await showDialog<List<DateTime>>(
      context: context,
      builder: (BuildContext context) {
        return const AwesomeCalendarDialog(
          selectionMode: SelectionMode.multi,
          canToggleRangeSelection: true,
        );
      },
    );
    if (picked != null) {
      setState(() {
        multiOrRangeSelect = picked;
      });
    }
  }

  Future<void> pickerWithTitle() async {
    await showDialog<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return const AwesomeCalendarDialog(
          selectionMode: SelectionMode.single,
          title: Padding(
            padding: EdgeInsets.all(16),
            child: Text('This is a custom title'),
          ),
        );
      },
    );
  }

  Future<void> pickerWithCustomDateRange() async {
    await showDialog<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return AwesomeCalendarDialog(
          selectionMode: SelectionMode.single,
          startDate: DateTime(2022),
          endDate: DateTime(2022, 12),
        );
      },
    );
  }

  _fechaNacimiento(BuildContext context, MascotasController controller) async {
    // _selectFechaNacimiento(
    //                                     context, controller);
    //================================================= SELECCIONA FECHA INICIO ==================================================//
    // _selectFechaInicio(
    //     BuildContext context, MascotasController mascotaController) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
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
      _fechaController.text = _fechaInicio;
      controller.onInputFechaNacimientoChange(_fechaInicio);
      // print('FechaInicio: $_fechaInicio');
      // });
    }
  }

  //********************************************************************************************************************//
  void _onSubmit(BuildContext context, MascotasController controller,
      String? _action) async {
    final isValid = controller.validateFormMascota();
    if (!isValid) return;
    if (isValid) {
      if (controller.getEspecie == null) {
        NotificatiosnService.showSnackBarDanger('Debe seleccionar Especie');
      } else if (controller.getRaza == null) {
        NotificatiosnService.showSnackBarDanger('Debe seleccionar Raza');
      } else if (controller.getAlimento == null) {
        NotificatiosnService.showSnackBarDanger('Debe seleccionar Alimento');
      } else if (controller.getTipoAlimento == null) {
        NotificatiosnService.showSnackBarDanger(
            'Debe seleccionar tipo de Alimento');
      } else if (controller.getInputfechaNacimiento == null) {
        NotificatiosnService.showSnackBarDanger(
            'Debe ingresar la edad de la mascota');
      }
      if (controller.getInputfechaNacimiento != null &&
          controller.getEspecie != null &&
          controller.getRaza != null &&
          controller.getAlimento != null &&
          controller.getTipoAlimento != null) {
        if (image != null) {
          // ProgressDialog.show(context);
          // controller.setNewPictureFile(image);
          // await controller.upLoadImagen();
          ProgressDialog.show(context);
          controller.setNewPictureFile(image);
          await controller.guardaImagenMascota();
          ProgressDialog.dissmiss(context);
        }

        if (_action == 'CREATE') {
          await controller.crearMascota(context);
          Navigator.pop(context);
        } else if (_action == 'EDIT') {
          await controller.editarMascota(context);
          Navigator.pop(context);
        }
        // context.read<MascotasController>().resetFormMascota();
        // Navigator.pop(context);
        //  Navigator.pop(context);
      }
    }
  }

  Future<bool?> _buscarPropietario(BuildContext context, Responsive size) {
    return showDialog<bool>(
      barrierColor: Colors.black54,
      context: context,
      builder: (context) {
        final controller = context.read<PropietariosController>();
        final controllerMascota = context.read<MascotasController>();

        return AlertDialog(
            title: const Text("BUSCAR PROPIETARIO"),
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
                            controller.onSearchTextPropietario(text);

                            if (controller.nameSearchPropietario.isEmpty) {
                              controller.buscaAllPropietarios('');
                            }
                          },
                        ),
                      ),
                      //===============================================//
                    ),
                  ),
                  Container(
                      // color: Colors.red,
                      width: size.wScreen(100),
                      height: size.hScreen(30.0),
                      child:
                          // Text('DFD'),

                          Consumer<PropietariosController>(
                        builder: (_, providerPropietarios, __) {
                          if (providerPropietarios.getErrorPropietarios ==
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
                          } else if (providerPropietarios
                                  .getErrorPropietarios ==
                              false) {
                            return const NoData(
                              label: 'No existen datos para mostar',
                            );
                            // Text("Error al cargar los datos");
                          } else if (providerPropietarios
                              .getListaPropietarios.isEmpty) {
                            return const NoData(
                              label: 'No existen datos para mostar',
                            );
                          }
                          // print('esta es la lista*******************: ${providerPropietarios.getListaPropietarios.length}');

                          return ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: controller.getListaPropietarios.length,
                            itemBuilder: (BuildContext context, int index) {
                              final propietario = providerPropietarios
                                  .getListaPropietarios[index];
                              return GestureDetector(
                                onTap: () {
                                  // print('SSSSSSSSSSS :$propietario ');
                                  // controllerMascota.setNombrePropietario(
                                  //     propietario['perNombre']);
                                  controllerMascota
                                      .getInfoPropietarioMascota(propietario);
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
                                                      '${propietario['perNombre']}',
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

  _callNumber(String numero) async {
    await FlutterPhoneDirectCaller.callNumber(numero);
  }

  Future<bool?> _agregaContactoExtra(BuildContext context, Responsive size) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        final controllerMascota = context.read<MascotasController>();
        _correoController.text = '';

        return CupertinoAlertDialog(
            title: const Text("AGREGAR CONTACTO EXTRA"),
            content: Card(
              color: Colors.transparent,
              elevation: 0.0,
              child: Form(
                key: controllerMascota.contactoExtraFormKey,
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
                            autofocus: true,
                            // controller: _textNombre,
                            //  widget.action == 'CREATE'
                            //                       ? _textNombre
                            //                       : null,

                            // initialValue:  controller.getNombres,
                            // initialValue:
                            //     // controller.getNombres,
                            //     widget.action == 'CREATE'
                            //         ? ''
                            //         : controller.getNombres,
                            decoration: const InputDecoration(
                                hintText: '  Ingrese Nombre'),
                            inputFormatters: [
                              UpperCaseText(),
                            ],
                            // suffixIcon: Icon(Icons.beenhere_outlined)

                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: size.iScreen(1.8),
                              // fontWeight: FontWeight.bold,
                              // letterSpacing: 2.0,
                            ),
                            onChanged: (text) {
                              controllerMascota.setNombreContactoExtra(text);
                            },
                            validator: (text) {
                              if (text!.trim().isNotEmpty) {
                                return null;
                              } else {
                                return 'Ingrese Nombres del Propietario';
                              }
                            },
                          ),
                        ),
                        //===============================================//
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
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text('Teléfono:',
                                  style: GoogleFonts.lexendDeca(
                                      // fontSize: size.iScreen(2.0),
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey)),
                              Consumer<MascotasController>(
                                builder: (_, valueFlag, __) {
                                  return Container(
                                      margin: EdgeInsets.only(
                                          left: size.iScreen(1.0)),
                                      child: valueFlag.getCountrys != null
                                          ? valueFlag.getCountrys!.flagImage
                                          : null);
                                },
                              )
                            ],
                          ),
                          Container(
                            // width: size.wScreen(100.0),
                            padding: EdgeInsets.symmetric(
                                // horizontal: size.iScreen(2.0),
                                vertical: size.iScreen(0)),
                            alignment: Alignment.center,
                            child: Consumer<MascotasController>(
                              builder: (_, valueCodes, __) {
                                return GestureDetector(
                                  onTap: () async {
                                    final code = await countryPicker.showPicker(
                                        context: context);
                                    if (code != null) {
                                      // valueCodes.setDataContry(code);
                                      // setState(() {
                                      valueCodes.setContrys(code);
                                      // });
                                    }
                                  },
                                  child: Consumer<MascotasController>(
                                    builder: (_, valueCountry, __) {
                                      return Row(
                                        children: [
                                          // Container(margin:  EdgeInsets.only(left: size.iScreen(1.0)),child:countryCode!=null?countryCode!.flagImage:null),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: size.iScreen(1.0),
                                                vertical: size.iScreen(0.5)),
                                            margin: EdgeInsets.only(
                                                right: size.iScreen(1.5),
                                                left: size.iScreen(0.5)),
                                            decoration: const BoxDecoration(
                                                color: tercearyColor,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0))),
                                            child: Text(
                                                valueCountry.getCountrys != null
                                                    ? valueCountry
                                                        .getCountrys!.dialCode
                                                    : '...',
                                                style: const TextStyle(
                                                    color: Colors.white)),
                                          ),
                                          SizedBox(
                                            width: size.wScreen(30.0),

                                            // color: Colors.blue,
                                            child: TextFormField(
                                              // controllerTextCountry
                                              readOnly:
                                                  valueCountry.getCountrys !=
                                                          null
                                                      ? false
                                                      : true,
                                              autofocus:
                                                  valueCountry.getCountrys !=
                                                          null
                                                      ? true
                                                      : false,
                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: <
                                                  TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .allow(RegExp(r'[0-9]')),
                                              ],
                                              // initialValue: _action == 'CREATE'
                                              //     ? ''
                                              //     :
                                              // valueCountry.getColor,
                                              // controller: _textCogetColor,
                                              decoration: const InputDecoration(
                                                  // suffixIcon: Icon(Icons.beenhere_outlined)
                                                  ),
                                              // textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: size.iScreen(2.0),
                                                // fontWeight: FontWeight.bold,
                                                // letterSpacing: 2.0,
                                              ),
                                              onChanged: (text) {
                                                valueCountry
                                                    .seItemAddCelulars(text);
                                              },
                                              validator: (text) {
                                                if (text!.trim().isNotEmpty) {
                                                  return null;
                                                } else {
                                                  return 'Ingrese Teléfono';
                                                }
                                              },
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),

                    //===============================================//

                    SizedBox(
                      width: size.iScreen(40.0),
                      child: TextFormField(
                        controller: _correoController,
                        keyboardType: TextInputType.emailAddress,
                        textCapitalization: TextCapitalization.none,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          final validador = validateEmail(value);
                          if (validador == null) {
                            controllerMascota.setIsCorreo(true);
                          }
                          return validateEmail(value);
                        },
                        decoration: const InputDecoration(
                            hintText: '  Ingrese un Correo'
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
                          controllerMascota.setCorreoContactoExtra(text);
                        },
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          // controllerMascota.seItemAddCelulars(
                          //     controllerMascota.getItemAddCelulars!.replaceAll(
                          //         '+593',
                          //         controllerMascota.getItemCodeCelular!));

                          final isValidS =
                              controllerMascota.validateFormContactoExtra();
                          if (!isValidS) return;
                          if (isValidS) {
                            if (controllerMascota.getCountrys == null) {
                              NotificatiosnService.showSnackBarDanger(
                                  'Debe seleccionar País');
                            }
                            if (controllerMascota.getCountrys != null) {
                              controllerMascota.agregarContacto();
                              Navigator.pop(context);
                            }
                          }
                          //  print(countries.firstWhere((element) => element['code'] == phone.countryISOCode)['max_length']);
                        },
                        child: Consumer<AppTheme>(builder: (_, value,__) { 
                          return    Container(
                          decoration: BoxDecoration(
                              color: value.getPrimaryTextColor,
                              borderRadius: BorderRadius.circular(5.0)),
                          // color: primaryColor,
                          padding: EdgeInsets.symmetric(
                              vertical: size.iScreen(0.5),
                              horizontal: size.iScreen(0.5)),
                          child: Text('Agregar',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white)),
                        );

                       },))
                  ],
                ),
              ),
            )

            //  },)

            );
      },
    );
  }
}

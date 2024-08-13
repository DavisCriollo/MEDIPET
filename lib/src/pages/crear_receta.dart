import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neitorcont/src/controllers/mascotas_controller.dart';
import 'package:neitorcont/src/controllers/recetas_controller.dart';
import 'package:neitorcont/src/data_table/lista_medicina_datasource.dart';
import 'package:neitorcont/src/services/notifications_service.dart';
import 'package:neitorcont/src/services/socket_service.dart';
import 'package:neitorcont/src/theme/themes_app.dart';
import 'package:neitorcont/src/utils/letras_mayusculas_minusculas.dart';

import 'package:neitorcont/src/utils/responsive.dart';
import 'package:neitorcont/src/utils/theme.dart';
import 'package:neitorcont/src/widgets/no_data.dart';

import 'package:provider/provider.dart';

class CrearReceta extends StatefulWidget {
  final String? tipo;
  const CrearReceta({Key? key, this.tipo}) : super(key: key);

  @override
  State<CrearReceta> createState() => _CrearRecetaState();
}

class _CrearRecetaState extends State<CrearReceta> {
  TextEditingController _fechaController = TextEditingController();
  final TextEditingController _horaInicioController = TextEditingController();

  late TimeOfDay timeInicio;
  @override
  void initState() {
    timeInicio = TimeOfDay.now();
    super.initState();
  }

  @override
  void dispose() {
    _fechaController.clear();
    _horaInicioController.clear();
    super.dispose();
  }

  DateTime initialDate = DateTime.now();

  DateTime? singleSelect;
  DateTime embeddedCalendar = DateTime.now();
  List<DateTime>? multiSelect;
  List<DateTime>? rangeSelect;
  List<DateTime>? multiOrRangeSelect;

  @override
  Widget build(BuildContext context) {
    // final _action = ModalRoute.of(context)!.settings.arguments;
    final Responsive size = Responsive.of(context);
    final controllerReceta = context.read<RecetasController>();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: widget.tipo == 'CREATE' || widget.tipo == 'SEARCH'
              ?  Text('Crear Receta',style:  Theme.of(context).textTheme.headline2,)
              :  Text('Editar Receta',style:  Theme.of(context).textTheme.headline2,),
          actions: [
            Container(
              margin: EdgeInsets.only(right: size.iScreen(1.5)),
              child: IconButton(
                  splashRadius: 28,
                  onPressed: () {
                    _onSubmit(context, controllerReceta, );
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
              left: size.iScreen(1.0),
              right: size.iScreen(1.0),
              bottom: size.iScreen(1.0)),
          width: size.wScreen(100),
          height: size.hScreen(100),
          child: Consumer<SocketService>(builder: (_, valueMenu, __) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: controllerReceta.recetasFormKey,
                child: Column(
                  children: [
                    //***********************************************/
                    SizedBox(
                      height: size.iScreen(0.0),
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
                    //***********************************************/
                    SizedBox(
                      height: size.iScreen(1.0),
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
                    //*****************************************/
                    //***********************************************/
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/
                    Consumer<RecetasController>(
                      builder: (_, valueMascota, __d) {
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
                                  color: valueMascota.getNombreMascota!.isEmpty
                                      ? Colors.grey
                                      : Colors.black)),
                        );
                      },
                    ),

                    //***********************************************/

                    //***********************************************/
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/
                    SizedBox(
                      width: size.wScreen(100.0),

                      // color: Colors.blue,
                      child: Text('Raza',
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: Colors.grey)),
                    ),
                    //*****************************************/
                    //***********************************************/
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/
                    Consumer<RecetasController>(
                      builder: (_, valueMascota, __d) {
                        return SizedBox(
                          width: size.wScreen(100.0),

                          // color: Colors.blue,
                          child: Text(
                              valueMascota.getRazaMascota!.isEmpty
                                  ? '--- --- --- '
                                  : '${valueMascota.getRazaMascota}',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: valueMascota.getRazaMascota!.isEmpty
                                      ? Colors.grey
                                      : Colors.black)),
                        );
                      },
                    ),

                    //***********************************************/
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/
                    SizedBox(
                      width: size.wScreen(100.0),

                      // color: Colors.blue,
                      child: Text('Sexo',
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: Colors.grey)),
                    ),
                    //*****************************************/
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/
                    Consumer<RecetasController>(
                      builder: (_, valueMascota, __d) {
                        return SizedBox(
                          width: size.wScreen(100.0),

                          // color: Colors.blue,
                          child: Text(
                              valueMascota.getSexoMascota!.isEmpty
                                  ? '--- --- --- '
                                  : '${valueMascota.getSexoMascota}',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: valueMascota.getSexoMascota!.isEmpty
                                      ? Colors.grey
                                      : Colors.black)),
                        );
                      },
                    ),

                    //***********************************************/
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/
                    SizedBox(
                      width: size.wScreen(100.0),

                      // color: Colors.blue,
                      child: Text('Edad',
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: Colors.grey)),
                    ),
                    //*****************************************/
                    Consumer<RecetasController>(
                      builder: (_, valueMascota, __d) {
                        return SizedBox(
                          width: size.wScreen(100.0),

                          // color: Colors.blue,
                          child: Text(
                              valueMascota.getEdadMascota!.isEmpty
                                  ? '--- --- --- '
                                  : '${valueMascota.getEdadMascota}',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: valueMascota.getEdadMascota!.isEmpty
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

                    Row(
                      children: [
                        Container(
                          width: size.wScreen(20.0),

                          // color: Colors.blue,
                          child: Text('Peso kg',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey)),
                        ),
                        Container(
                          width: size.wScreen(20.0),
                          child:
                              //       TextField(
                              //   decoration: InputDecoration(
                              //       border: OutlineInputBorder(),
                              //       isDense: true,
                              //       labelText: 'Decimal Number'),
                              //   keyboardType: TextInputType.number,
                              //   inputFormatters: [
                              //     LengthLimitingTextInputFormatter(15),
                              //     ThousandsFormatter(allowFraction: true),
                              //   ],
                              //   style: TextStyle(fontSize: 16.0, color: Colors.black),
                              // ),
                              TextFormField(
                            initialValue: widget.tipo == 'CREATE'
                                ? ''
                                : controllerReceta.getPesoMascota,
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
                              controllerReceta.setPesoMascota(text);
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

                    //***********************************************/
                    SizedBox(
                      height: size.iScreen(1.5),
                    ),
                    //*****************************************/
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
                    //*****************************************/
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/
                    Consumer<RecetasController>(
                      builder: (_, valueMascota, __d) {
                        return SizedBox(
                          width: size.wScreen(100.0),

                          // color: Colors.blue,
                          child: Text(
                              valueMascota.getPropietarioMascota!.isEmpty
                                  ? '--- --- --- '
                                  : '${valueMascota.getPropietarioMascota}',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: valueMascota
                                          .getPropietarioMascota!.isEmpty
                                      ? Colors.grey
                                      : Colors.black)),
                        );
                      },
                    ),

                    //***********************************************/
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/
                    SizedBox(
                      width: size.wScreen(100.0),

                      // color: Colors.blue,
                      child: Text('DocNúmero',
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: Colors.grey)),
                    ),
                    //*****************************************/
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/
                    Consumer<RecetasController>(
                      builder: (_, valueMascota, __d) {
                        return SizedBox(
                          width: size.wScreen(100.0),

                          // color: Colors.blue,
                          child: Text(
                              valueMascota.getPropietarioCedulaMascota!.isEmpty
                                  ? '--- --- --- '
                                  : '${valueMascota.getPropietarioCedulaMascota}',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: valueMascota
                                          .getPropietarioCedulaMascota!.isEmpty
                                      ? Colors.grey
                                      : Colors.black)),
                        );
                      },
                    ),

                    //***********************************************/
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/
                    SizedBox(
                      width: size.wScreen(100.0),

                      // color: Colors.blue,
                      child: Text('Dirección',
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: Colors.grey)),
                    ),
                    //*****************************************/
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/
                    Consumer<RecetasController>(
                      builder: (_, valueMascota, __d) {
                        return SizedBox(
                          width: size.wScreen(100.0),

                          // color: Colors.blue,
                          child: Text(
                              valueMascota
                                      .getPropietarioDirecionMascota!.isEmpty
                                  ? '--- --- --- '
                                  : '${valueMascota.getPropietarioDirecionMascota}',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: valueMascota
                                          .getPropietarioDirecionMascota!
                                          .isEmpty
                                      ? Colors.grey
                                      : Colors.black)),
                        );
                      },
                    ),

                    //***********************************************/
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/
                    SizedBox(
                      width: size.wScreen(100.0),

                      // color: Colors.blue,
                      child: Text('Celular',
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: Colors.grey)),
                    ),
                    //*****************************************/
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/
                    Consumer<RecetasController>(
                      builder: (_, valueMascota, __) {
                        return SizedBox(
                          width: size.wScreen(100.0),

                          // color: Colors.blue,
                          child: valueMascota
                                  .getPropietarioCelularMascota!.isEmpty
                              ? Text('--- --- --- ',
                                  style: GoogleFonts.lexendDeca(
                                    // fontSize: size.iScreen(2.0),
                                    fontWeight: FontWeight.normal,
                                  ))
                              : Wrap(
                                  children: valueMascota
                                      .getPropietarioCelularMascota!
                                      .map(
                                        (e) => Text('$e',
                                            style: GoogleFonts.lexendDeca(
                                                // fontSize: size.iScreen(2.0),
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black)),
                                      )
                                      .toList()),
                        );
                      },
                    ),

                    //***********************************************/
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/
                    SizedBox(
                      width: size.wScreen(100.0),

                      // color: Colors.blue,
                      child: Text('Email',
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: Colors.grey)),
                    ),
                    //*****************************************/
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/
                    Consumer<RecetasController>(
                      builder: (_, valueMascota, __) {
                        return SizedBox(
                          width: size.wScreen(100.0),

                          // color: Colors.blue,
                          child: valueMascota
                                  .getPropietarioEmailMascota!.isEmpty
                              ? Text('--- --- --- ',
                                  style: GoogleFonts.lexendDeca(
                                    // fontSize: size.iScreen(2.0),
                                    fontWeight: FontWeight.normal,
                                  ))
                              : Wrap(
                                  children: valueMascota
                                      .getPropietarioEmailMascota!
                                      .map(
                                        (e) => Text('$e',
                                            style: GoogleFonts.lexendDeca(
                                                // fontSize: size.iScreen(2.0),
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black)),
                                      )
                                      .toList()),
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
                            child: Text('Doctor ',
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
                    Consumer<RecetasController>(
                      builder: (_, valueDoctor, __) {
                        return SizedBox(
                          width: size.wScreen(100.0),

                          // color: Colors.blue,
                          child: Text(
                              valueDoctor.getDoctoNombre!.isEmpty
                                  ? 'DEBE SELECCIONAR DOCTOR '
                                  : '${valueDoctor.getDoctoNombre} ',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: valueDoctor.getDoctoNombre!.isEmpty
                                      ? Colors.grey
                                      : Colors.black)),
                        );
                      },
                    ),

                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/

                    Consumer<RecetasController>(
                      builder: (_, valueFecha, __) {
                        return Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Próxima Cita',
                                style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(1.8),
                                  color: Colors.black45,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: size.iScreen(2.0),
                              ),
                              GestureDetector(
                                onTap: () {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  _fechaProximaCita(context, valueFecha);
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      valueFecha.getInputfechaProximaCita ??
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
                              Container(
                                width: size.wScreen(23.0),
                                margin: EdgeInsets.symmetric(
                                    horizontal: size.wScreen(3.5)),
                                child: Row(
                                  children: [
                                    Consumer<RecetasController>(
                                      builder: (_, valueHora, __) {
                                        return Text(
                                          valueHora.getInputHoraProximaCita !=
                                                  ''
                                              ? valueHora
                                                  .getInputHoraProximaCita
                                              : '----',
                                          style: GoogleFonts.lexendDeca(
                                            fontSize: size.iScreen(1.8),
                                            color: Colors.black45,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        );
                                      },
                                    ),
                                    IconButton(
                                      // color: Colors.red,
                                      splashRadius: 20,
                                      onPressed: () {
                                        FocusScope.of(context)
                                            .requestFocus(FocusNode());
                                        _seleccionaHora(context, valueFecha);
                                      },
                                      icon: const Icon(
                                        Icons.access_time_outlined,
                                        // color: primaryColor,
                                        size: 20,
                                      ),
                                    ),
                                  ],
                                ),

                               
                              ),
                            ]);
                      },
                    ),

                    //******************************/
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/

                    SizedBox(
                      width: size.wScreen(100.0),

                      // color: Colors.blue,
                      child: Text('Recomendaciones',
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
                            : controllerReceta.getRecomendacionesMascota,

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
                          controllerReceta.setRecomendacionesMascota(text);
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
                          SizedBox(
                            width: size.iScreen(2.0),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: GestureDetector(
                              onTap: () {
                                // context
                                //     .read<MascotasController>()
                                //     .buscaAllMascotas('');
                                controllerReceta
                                    .onInputMedicamentoMedicinaChange('');
                                _agregaMedicamento(context, size);

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
                                                  vertical: size.iScreen(0.5)),
                                              child: Text(
                                                e['nombre'],
                                                style: GoogleFonts.lexendDeca(
                                                  // fontSize: size.iScreen(2.0),
                                                  fontWeight: FontWeight.normal,
                                                  // color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: size.iScreen(0.5)),
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
                                                  vertical: size.iScreen(0.5)),
                                              child: Text(e['correo'],
                                                  style: GoogleFonts.lexendDeca(
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

                    // SizedBox(
                    //   width: size.wScreen(100.0),

                    //   // color: Colors.blue,
                    //   child: Text('Color',
                    //       style: GoogleFonts.lexendDeca(
                    //           // fontSize: size.iScreen(2.0),
                    //           fontWeight: FontWeight.normal,
                    //           color: Colors.grey)),
                    // ),
                    // Container(
                    //   // width: size.wScreen(45.0),
                    //   child: TextFormField(
                    //     // initialValue: widget.tipo == 'CREATE'
                    //     //     ? ''
                    //     //     : controller.getDireccion,
                    //     // controller: _textDireccion,
                    //     decoration: const InputDecoration(
                    //         // suffixIcon: Icon(Icons.beenhere_outlined)
                    //         ),
                    //     // textAlign: TextAlign.center,
                    //     style: TextStyle(
                    //       fontSize: size.iScreen(2.0),
                    //       // fontWeight: FontWeight.bold,
                    //       // letterSpacing: 2.0,
                    //     ),
                    //     onChanged: (text) {
                    //       controller.setColor(text);
                    //     },
                    //     validator: (text) {
                    //       if (text!.trim().isNotEmpty) {
                    //         return null;
                    //       } else {
                    //         return 'Ingrese color de mascota';
                    //       }
                    //     },
                    //   ),
                    // ),

                    // // //***********************************************/
                    // SizedBox(
                    //   height: size.iScreen(2.0),
                    // ),
                    // // //*****************************************/

                    // //*****************************************/
                    // Consumer<MascotasController>(
                    //   builder: (_, valueUrl, __) {
                    //     return valueUrl.getFotUrlTemp != ''
                    //         ? Column(
                    //             children: [
                    //               SizedBox(
                    //                 width: size.wScreen(100.0),

                    //                 // color: Colors.blue,
                    //                 child: Text('Foto',
                    //                     style: GoogleFonts.lexendDeca(
                    //                         // fontSize: size.iScreen(2.0),
                    //                         fontWeight: FontWeight.normal,
                    //                         color: Colors.grey)),
                    //               ),
                    //               SizedBox(
                    //                 height: size.iScreen(1.0),
                    //               ),
                    //               Stack(
                    //                 children: [
                    //                   Container(
                    //                       padding: EdgeInsets.symmetric(
                    //                           vertical: size.iScreen(1.5)),
                    //                       child: FadeInImage.assetNetwork(
                    //                         // fit: BoxFit.fitHeight,
                    //                         placeholder:
                    //                             'assets/imgs/loading.gif',
                    //                         image: valueUrl
                    //                             .getFotUrlTemp!, //'https://picsum.photos/id/237/500/300',
                    //                       )),
                    //                   Positioned(
                    //                     top: 5.0,
                    //                     left: 3.0,
                    //                     // bottom: -3.0,
                    //                     child: IconButton(
                    //                       color:
                    //                           tercearyColor, // Colors.red.shade700,
                    //                       onPressed: () {
                    //                         // setState(() {
                    //                         //   // fotoUrl.eliminaFotoUrl(e['url']);
                    //                         valueUrl.setFotoTemp('');
                    //                         // });
                    //                         // bottomSheetMaps(context, size);
                    //                       },
                    //                       icon: Icon(
                    //                         Icons.delete_forever,
                    //                         size: size.iScreen(3.5),
                    //                       ),
                    //                     ),
                    //                   )
                    //                 ],
                    //               )
                    //             ],
                    //           )
                    //         : Container();
                    //   },
                    // ),

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
                                      Text('X'),
                                      SizedBox(width: 30.0),
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
                                    'NUEVO'),
                                rowsPerPage: values.getNuevoMedicamento.length,
                              )
                            // : const SizedBox(),
                            : const NoData(
                                label: 'No hay medicametos agregados ');
                      },
                    )

                    // Consumer<MascotasController>(builder: (__, valueFotos, _) {

                    //   return  valueFotos.getNewPictureFile==null
                    //   ?
                    //   Container():

                    //  },),

                    // image != null
                    //     ? SizedBox(
                    //         width: size.wScreen(100.0),

                    //         // color: Colors.blue,
                    //         child: Text('Foto',
                    //             style: GoogleFonts.lexendDeca(
                    //                 // fontSize: size.iScreen(2.0),
                    //                 fontWeight: FontWeight.normal,
                    //                 color: Colors.grey)),
                    //       )
                    //     : Container(),

                    // image != null
                    //     ? Stack(
                    //         children: [
                    //           Container(
                    //               padding: EdgeInsets.symmetric(
                    //                   vertical: size.iScreen(1.5)),
                    //               child: image != null
                    //                   ? Image.file(image!)
                    //                   : Container()),
                    //           image != null
                    //               ? Positioned(
                    //                   top: 5.0,
                    //                   right: 3.0,
                    //                   // bottom: -3.0,
                    //                   child: IconButton(
                    //                     color:
                    //                         tercearyColor, // Colors.red.shade700,
                    //                     onPressed: () {
                    //                       setState(() {
                    //                         // fotoUrl.eliminaFotoUrl(e['url']);
                    //                         image = null;
                    //                       });
                    //                       // bottomSheetMaps(context, size);
                    //                     },
                    //                     icon: Icon(
                    //                       Icons.delete_forever,
                    //                       size: size.iScreen(3.5),
                    //                     ),
                    //                   ),
                    //                 )
                    //               : Container(),
                    //         ],
                    //       )
                    //     : Container(),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  //********************************************************************************************************************//
  void _onSubmit(BuildContext context, RecetasController controller,
      ) async {
    final isValid = controller.validateFormReceta();
    if (!isValid) return;
    if (isValid) {
      if (controller.getInputfechaProximaCita != '' &&
              controller.getInputHoraProximaCita != '' ||
          controller.getInputfechaProximaCita == '' &&
              controller.getInputHoraProximaCita == '') {
        controller.setisFechaCita(true);
      } else {
        controller.setisFechaCita(false);
      }

      if (controller.getNombreMascota!.isEmpty) {
        NotificatiosnService.showSnackBarDanger('Debe seleccionar Mascota');
      } else if (controller.getDoctoNombre!.isEmpty) {
        NotificatiosnService.showSnackBarDanger('Debe seleccionar Doctor');
      } else if (controller.getIsFechaCita == false) {
        NotificatiosnService.showSnackBarDanger(
            'Debe seleccionar Fecha de Cita');
      } else if (controller.getNuevoMedicamento.isEmpty) {
        NotificatiosnService.showSnackBarDanger('Debe agregar Medicina');
      }

      if (controller.getNombreMascota! != '' &&
          controller.getDoctoNombre! != '' &&
          controller.getNuevoMedicamento.isNotEmpty &&
          controller.getIsFechaCita == true) {
        if (widget.tipo == 'CREATE') {
          await controller.creaReceta(context);
          Navigator.pop(context);
        }
        if (widget.tipo == 'EDIT') {
          await controller.editaReceta(context);
          Navigator.pop(context);
        }
        _fechaController.text = '';
        // context.read<MascotasController>().resetFormMascota();
        // Navigator.pop(context);
      }
    }
  }

  //********************************************************************************************************************//

  void _seleccionaHora(context, RecetasController fechaController) async {
    TimeOfDay? _hora =
        await showTimePicker(context: context, initialTime: timeInicio);

    if (_hora != null) {
      String? dateHora = (_hora.hour < 10) ? '0${_hora.hour}' : '${_hora.hour}';
      String? dateMinutos =
          (_hora.minute < 10) ? '0${_hora.minute}' : '${_hora.minute}';

      setState(() {
        timeInicio = _hora;
        String horaInicio = '${dateHora}:${dateMinutos}';
        // _horaInicioController.text = horaInicio;
        fechaController.onInputHoraProximaCitaChange(horaInicio);
        //  print('si: $horaInicio');
      });
    }
  }

  //********************************************************************************************************************//
  _fechaProximaCita(BuildContext context, RecetasController controller) async {
    // _selectFechaNacimiento(
    //                                     context, controller);
    //================================================= SELECCIONA FECHA INICIO ==================================================//
    // _selectFechaInicio(
    //     BuildContext context, MascotasController mascotaController) async {
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
      controller.onInputFechaProximaCitaChange(_fechaInicio);

      // print('FechaInicio: $_fechaInicio');
      // });
    }
  }

  //********************************************************************************************************************//
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
                                      .read<RecetasController>()
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
                                                  // Container(
                                                  //   width: size.wScreen(100.0),
                                                  //   // color: Colors.red,
                                                  //   padding:
                                                  //       EdgeInsets.symmetric(
                                                  //           horizontal: size
                                                  //               .iScreen(1.0),
                                                  //           vertical: size
                                                  //               .iScreen(0.2)),
                                                  //   child: Container(
                                                  //     // color: Colors.green,
                                                  //     width: size.wScreen(30.0),
                                                  //     child: Text(
                                                  //       '${propietario['perDocNumero']}',
                                                  //       style: GoogleFonts
                                                  //           .lexendDeca(
                                                  //               // fontSize: size.iScreen(2.45),
                                                  //               color:
                                                  //                   Colors.grey,
                                                  //               fontWeight:
                                                  //                   FontWeight
                                                  //                       .normal),
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          // Column(
                                          //   children: <Widget>[
                                          //     Container(
                                          //       // width: size.wScreen(100.0),
                                          //       padding: EdgeInsets.symmetric(
                                          //           horizontal:
                                          //               size.iScreen(1.0),
                                          //           vertical:
                                          //               size.iScreen(0.5)),
                                          //       child: const Icon(
                                          //         Icons.chevron_right,
                                          //         color: Colors.grey,
                                          //       ),
                                          //     ),
                                          //   ],
                                          // ),
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

  //********************************************************************************************************************//
  Future<bool?> _buscarMedicina(BuildContext context, Responsive size) {
    return showDialog<bool>(
      barrierColor: Colors.black54,
      context: context,
      builder: (context) {
        // final controller = context.read<PropietariosController>();
        final controllerRecetas = context.read<RecetasController>();

        return AlertDialog(
            title: const Text("BUSCAR MEDICINA"),
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
                            controllerRecetas.onSearchTextMedicinas(text);

                            if (controllerRecetas.nameSearchMedicinas.isEmpty) {
                              controllerRecetas.buscaAllMedicinas('');
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
                        builder: (_, providerMedicinas, __) {
                          if (providerMedicinas.getErrorMedicinas == null) {
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
                          } else if (providerMedicinas.getErrorMedicinas ==
                              false) {
                            return const NoData(
                              label: 'No existen datos para mostar',
                            );
                            // Text("Error al cargar los datos");
                          } else if (providerMedicinas
                              .getListaMedicinas.isEmpty) {
                            return const NoData(
                              label: 'No existen datos para mostar',
                            );
                          }
                          // print('esta es la lista*******************: ${providerMedicinas.getListaPropietarios.length}');

                          return ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount:
                                providerMedicinas.getListaMedicinas.length,
                            itemBuilder: (BuildContext context, int index) {
                              final _medicina =
                                  providerMedicinas.getListaMedicinas[index];
                              return GestureDetector(
                                onTap: () {
                                  context
                                      .read<RecetasController>()
                                      .setMedicinaInfo(_medicina);

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
                                                      '${_medicina['invNombre']}',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.45),
                                                              // color: Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal),
                                                    ),
                                                  ),
                                                  // Container(
                                                  //   width: size.wScreen(100.0),
                                                  //   // color: Colors.red,
                                                  //   padding:
                                                  //       EdgeInsets.symmetric(
                                                  //           horizontal: size
                                                  //               .iScreen(1.0),
                                                  //           vertical: size
                                                  //               .iScreen(0.2)),
                                                  //   child: Container(
                                                  //     // color: Colors.green,
                                                  //     width: size.wScreen(30.0),
                                                  //     child: Text(
                                                  //       '${propietario['perDocNumero']}',
                                                  //       style: GoogleFonts
                                                  //           .lexendDeca(
                                                  //               // fontSize: size.iScreen(2.45),
                                                  //               color:
                                                  //                   Colors.grey,
                                                  //               fontWeight:
                                                  //                   FontWeight
                                                  //                       .normal),
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          // Column(
                                          //   children: <Widget>[
                                          //     Container(
                                          //       // width: size.wScreen(100.0),
                                          //       padding: EdgeInsets.symmetric(
                                          //           horizontal:
                                          //               size.iScreen(1.0),
                                          //           vertical:
                                          //               size.iScreen(0.5)),
                                          //       child: const Icon(
                                          //         Icons.chevron_right,
                                          //         color: Colors.grey,
                                          //       ),
                                          //     ),
                                          //   ],
                                          // ),
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

  //********************************************************************************************************************//
  Future<bool?> _buscarMedico(BuildContext context, Responsive size) {
    return showDialog<bool>(
      barrierColor: Colors.black54,
      context: context,
      builder: (context) {
        // final controller = context.read<PropietariosController>();
        final controllerMedico = context.read<RecetasController>();

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
                            controllerMedico.onSearchTexPersonas(text);

                            if (controllerMedico.nameSearcPersonas.isEmpty) {
                              controllerMedico.buscaAllDoctores('');
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
                                      .read<RecetasController>()
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

  //********************************************************************************************************************//
  Future<bool?> _agregaMedicamento(BuildContext context, Responsive size) {
    return showDialog<bool>(
      barrierColor: Colors.black54,
      context: context,
      builder: (context) {
        // final controller = context.read<PropietariosController>();
        final controller = context.read<RecetasController>();

        return AlertDialog(
            title: const Text("AGREGAR MEDICAMENTO"),
            content: Card(
              color: Colors.transparent,
              elevation: 0.0,
              child: Form(
                key: controller.recetasMedicamentoFormKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: size.wScreen(20.0),

                          // color: Colors.blue,
                          child: Text('Cantidad',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey)),
                        ),
                        Container(
                          width: size.wScreen(30.0),
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9.]')),
                            ],
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
                              controller.onInputCantidadMedicinaChange(text);
                            },
                            validator: (text) {
                              if (text!.trim().isNotEmpty) {
                                return null;
                              } else {
                                return 'Ingrese Cantidad';
                              }
                            },
                          ),
                        ),
                      ],
                    ),

                    //***********************************************/
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/
                    SizedBox(
                      width: size.wScreen(100.0),

                      // color: Colors.blue,
                      child: Row(
                        children: [
                          Text('Medicina',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey)),
                          //***********************************************/
                          SizedBox(
                            width: size.iScreen(1.5),
                          ),
                          //*****************************************/
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: GestureDetector(
                              onTap: () {
                                context
                                    .read<RecetasController>()
                                    .buscaAllMedicinas('');

                                _buscarMedicina(context, size);

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
                    //***********************************************/
                    // SizedBox(
                    //   height: size.iScreen(1.0),
                    // ),
                    // //*****************************************/
                    // SizedBox(
                    //   width: size.wScreen(100.0),

                    //   // color: Colors.blue,
                    //   child: Text('Nombre de Mascota',
                    //       style: GoogleFonts.lexendDeca(
                    //           // fontSize: size.iScreen(2.0),
                    //           fontWeight: FontWeight.normal,
                    //           color: Colors.grey)),
                    // ),
                    // //*****************************************/
                    //***********************************************/
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/
                    Consumer<RecetasController>(
                      builder: (_, valueMascota, __d) {
                        return SizedBox(
                          width: size.wScreen(100.0),

                          // color: Colors.blue,
                          child: Text(
                              valueMascota.getInputMedicamentoMedicina!.isEmpty
                                  ? 'DEBE SELECCIONAR MEDICINA '
                                  : '${valueMascota.getInputMedicamentoMedicina}',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: valueMascota
                                          .getInputMedicamentoMedicina!.isEmpty
                                      ? Colors.grey
                                      : Colors.black)),
                        );
                      },
                    ),

                    //***********************************************/
                    // Container(
                    //   // width: size.wScreen(45.0),
                    //   child: TextFormField(
                    //     // initialValue: _action == 'CREATE'
                    //     //     ? ''
                    //     //     : controller.getObservacionMascota,

                    //     decoration: const InputDecoration(
                    //         // suffixIcon: Icon(Icons.beenhere_outlined)
                    //         ),
                    //     // textAlign: TextAlign.center,
                    //     style: TextStyle(
                    //       fontSize: size.iScreen(2.0),
                    //       // fontWeight: FontWeight.bold,
                    //       // letterSpacing: 2.0,
                    //     ),
                    //     onChanged: (text) {
                    //       controller.onInputMedicamentoMedicinaChange(text);
                    //     },
                    //     validator: (text) {
                    //       if (text!.trim().isNotEmpty) {
                    //         return null;
                    //       } else {
                    //         return 'Ingrese  Medicina';
                    //       }
                    //     },
                    //   ),
                    // ),
                    //***********************************************/
                    SizedBox(
                      height: size.iScreen(0.5),
                    ),
                    //*****************************************/
                    SizedBox(
                      width: size.wScreen(100.0),

                      // color: Colors.blue,
                      child: Text('Tratamiento',
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: Colors.grey)),
                    ),
                    Container(
                      // width: size.wScreen(45.0),
                      child: TextFormField(
                        // initialValue: _action == 'CREATE'
                        //     ? ''
                        //     : controller.getObservacionMascota,
                        minLines: 1,
                        maxLines: 3,
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
                          controller.onInputTratamientoMedicinaChange(text);
                        },
                        validator: (text) {
                          if (text!.trim().isNotEmpty) {
                            return null;
                          } else {
                            return 'Ingrese Tratamiento';
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: size.iScreen(2.0),
                    ),
                    TextButton(
                        onPressed: () {
                          _onSubmitMedicamento(
                            context,
                            controller,
                          );
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

//=================================== AGREGAMOS EL MEDICAMENTO  ===========================================//
  void _onSubmitMedicamento(
    BuildContext context,
    RecetasController controller,
  ) async {
    final isValid = controller.validateFormMedicamento();
    if (!isValid) return;
    if (isValid) {
      if (controller.getInputMedicamentoMedicina!.isEmpty) {
        NotificatiosnService.showSnackBarDanger('Debe seleccionar Medicina');
      } else {
        controller.addMedicamento();
        Navigator.pop(context);
      }
    }
  }
}

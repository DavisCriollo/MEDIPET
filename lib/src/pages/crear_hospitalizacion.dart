import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neitorcont/src/controllers/hospitalizacion_controller.dart';
import 'package:neitorcont/src/controllers/mascotas_controller.dart';
import 'package:neitorcont/src/controllers/recetas_controller.dart';
import 'package:neitorcont/src/data_table/cabecera_alimento_hospitalizacion.dart';
import 'package:neitorcont/src/data_table/cabecera_medicina_hospitalizacion.dart';
import 'package:neitorcont/src/data_table/cabecera_parametros.hospitalizacion.dart';
import 'package:neitorcont/src/data_table/fluidos_hospitalizacion.dart';
import 'package:neitorcont/src/data_table/horario_alimentos_hospitalizacion.dart';
import 'package:neitorcont/src/data_table/horario_medicina_hospitalizacion.dart';
import 'package:neitorcont/src/data_table/horario_parametros_hospitalzacion.dart';
import 'package:neitorcont/src/data_table/infusion_hospitalizacion.dart';
import 'package:neitorcont/src/services/notifications_service.dart';
import 'package:neitorcont/src/services/socket_service.dart';
import 'package:neitorcont/src/theme/themes_app.dart';
import 'package:neitorcont/src/utils/letras_mayusculas_minusculas.dart';
import 'package:neitorcont/src/utils/responsive.dart';
import 'package:neitorcont/src/utils/theme.dart';
import 'package:neitorcont/src/widgets/no_data.dart';
import 'package:provider/provider.dart';

class CrearHospitalizacion extends StatefulWidget {
   final String? tipo;
  const CrearHospitalizacion({Key? key, this.tipo}) : super(key: key);

  @override
  State<CrearHospitalizacion> createState() => _CrearHospitalizacionState();
}

class _CrearHospitalizacionState extends State<CrearHospitalizacion> {
  final TextEditingController _dosisParametro = TextEditingController();
  @override
  void dispose() {
    _dosisParametro.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final widget.tipo = ModalRoute.of(context)!.settings.arguments;

// print('object: $widget.tipo');

    final Responsive size = Responsive.of(context);
    final controllerHospitalizacion = context.read<HospitalizacionController>();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          appBar: AppBar(
            title: widget.tipo == 'CREATE' || widget.tipo == 'SEARCH'
                ?  Text('Crear Hospitalización',style:  Theme.of(context).textTheme.headline2,)
                :  Text('Editar Hospitalización',style:  Theme.of(context).textTheme.headline2,),
            actions: [
              Consumer<SocketService>(builder: (_, valueConexion, __) {
                return valueConexion.serverStatus == ServerStatus.Online
                    ? Container(
                        margin: EdgeInsets.only(right: size.iScreen(1.5)),
                        child: IconButton(
                            splashRadius: 28,
                            onPressed: () {
                              _onSubmit(context, controllerHospitalizacion,
                                 );
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
              child:  SingleChildScrollView(
                         keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                          physics: const BouncingScrollPhysics(),
                          child: Form(
                            key: controllerHospitalizacion
                                .hospitalizacionFormKey,
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
                                  children: [
                                    SizedBox(
                                      // width: size.wScreen(100.0),

                                      // color: Colors.blue,
                                      child: Text('Paciente ',
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
                                Consumer<HospitalizacionController>(
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
                                //***********************************************/
                                SizedBox(
                                  height: size.iScreen(1.5),
                                ),
                                //*****************************************/
                                Row(
                                  children: [
                                    Container(
                                      // width: size.wScreen(100.0),

                                      // color: Colors.blue,
                                      child: Text('Raza : ',
                                          style: GoogleFonts.lexendDeca(
                                              // fontSize: size.iScreen(2.0),
                                              fontWeight: FontWeight.normal,
                                              color: Colors.grey)),
                                    ),
                                    Consumer<HospitalizacionController>(
                                      builder: (_, valueRaza, __) {
                                        return SizedBox(
                                          // width: size.wScreen(100.0),

                                          // color: Colors.blue,
                                          child: Text(
                                              valueRaza.getRazaMascota!.isEmpty
                                                  ? '--- --- --- '
                                                  : '${valueRaza.getRazaMascota}',
                                              style: GoogleFonts.lexendDeca(
                                                  // fontSize: size.iScreen(2.0),
                                                  fontWeight: FontWeight.normal,
                                                  color: valueRaza
                                                          .getRazaMascota!
                                                          .isEmpty
                                                      ? Colors.grey
                                                      : Colors.black)),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: size.iScreen(2.0),
                                ),
                                //***********************************************/
                                SizedBox(
                                  height: size.iScreen(1.0),
                                ),
                                //*****************************************/

                                //***********************************************/
                                SizedBox(
                                  height: size.iScreen(1.5),
                                ),
                                //*****************************************/
                                Row(
                                  children: [
                                    Container(
                                      // width: size.wScreen(100.0),

                                      // color: Colors.blue,
                                      child: Text('Sexo : ',
                                          style: GoogleFonts.lexendDeca(
                                              // fontSize: size.iScreen(2.0),
                                              fontWeight: FontWeight.normal,
                                              color: Colors.grey)),
                                    ),
                                    //*****************************************/
                                    Consumer<HospitalizacionController>(
                                      builder: (_, valueSexo, __) {
                                        return SizedBox(
                                          // width: size.wScreen(100.0),

                                          // color: Colors.blue,
                                          child: Text(
                                              valueSexo.getSexoMascota == ""
                                                  ? '--- --- --- '
                                                  : '${valueSexo.getSexoMascota}',
                                              style: GoogleFonts.lexendDeca(
                                                  // fontSize: size.iScreen(2.0),
                                                  fontWeight: FontWeight.normal,
                                                  color: valueSexo
                                                              .getSexoMascota ==
                                                          ""
                                                      ? Colors.grey
                                                      : Colors.black)),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: size.iScreen(2.0),
                                ),
                                //***********************************************/
                                SizedBox(
                                  height: size.iScreen(1.0),
                                ),

                                //***********************************************/
                                SizedBox(
                                  height: size.iScreen(1.5),
                                ),
                                //*****************************************/
                                Row(
                                  children: [
                                    Container(
                                      // width: size.wScreen(100.0),

                                      // color: Colors.blue,
                                      child: Text('Edad:  ',
                                          style: GoogleFonts.lexendDeca(
                                              // fontSize: size.iScreen(2.0),
                                              fontWeight: FontWeight.normal,
                                              color: Colors.grey)),
                                    ),
                                    //*****************************************/
                                    Consumer<HospitalizacionController>(
                                      builder: (_, valueEdad, __) {
                                        return SizedBox(
                                          // width: size.wScreen(100.0),

                                          // color: Colors.blue,
                                          child: Text(
                                              valueEdad.getEdadMascota == ""
                                                  ? '--- --- --- '
                                                  : '${valueEdad.getEdadMascota}',
                                              style: GoogleFonts.lexendDeca(
                                                  // fontSize: size.iScreen(2.0),
                                                  fontWeight: FontWeight.normal,
                                                  color: valueEdad
                                                              .getEdadMascota ==
                                                          ""
                                                      ? Colors.grey
                                                      : Colors.black)),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: size.iScreen(2.0),
                                ),
                                //***********************************************/
                                SizedBox(
                                  height: size.iScreen(1.0),
                                ),

                                //***********************************************/
                                SizedBox(
                                  height: size.iScreen(1.0),
                                ),
                                //*****************************************/

                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            // width: size.wScreen(20.0),

                                            // color: Colors.blue,
                                            child: Text('Peso kg:',
                                                style: GoogleFonts.lexendDeca(
                                                    // fontSize: size.iScreen(2.0),
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.grey)),
                                          ), //***********************************************/
                                          SizedBox(
                                            width: size.iScreen(1.0),
                                          ),
                                          //*****************************************/
                                          Container(
                                            width: size.wScreen(20.0),
                                            child: TextFormField(
                                              initialValue: widget.tipo == 'CREATE'
                                                  ? ''
                                                  : controllerHospitalizacion
                                                      .getPesoMascota,
                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: <
                                                  TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .allow(RegExp(r'[0-9.]')),
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
                                                controllerHospitalizacion
                                                    .setPesoMascota(text);
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
                                    ]),
                                SizedBox(
                                  width: size.iScreen(2.0),
                                ),
                                //***********************************************/
                                SizedBox(
                                  height: size.iScreen(1.0),
                                ),
                                //*****************************************/

                                //***********************************************/
                                SizedBox(
                                  height: size.iScreen(1.5),
                                ),
                                //*****************************************/
                                Row(
                                  children: [
                                    Container(
                                      // width: size.wScreen(100.0),

                                      // color: Colors.blue,
                                      child: Text('Estado : ',
                                          style: GoogleFonts.lexendDeca(
                                              // fontSize: size.iScreen(2.0),
                                              fontWeight: FontWeight.normal,
                                              color: Colors.grey)),
                                    ),
                                    //*****************************************/
                                    Consumer<HospitalizacionController>(
                                      builder: (_, valueestado, __) {
                                        return SizedBox(
                                          // width: size.wScreen(100.0),

                                          // color: Colors.blue,
                                          child: GestureDetector(
                                            onTap: () {
                                              _buscarEstado(context, size);
                                            },
                                            child: Text(
                                                valueestado.getEstadoMascota ==
                                                        ""
                                                    ? 'Seleccione Estado  '
                                                    : '${valueestado.getEstadoMascota}',
                                                style: GoogleFonts.lexendDeca(
                                                    // fontSize: size.iScreen(2.0),
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: valueestado
                                                                .getEstadoMascota ==
                                                            ""
                                                        ? Colors.grey
                                                        : Colors.black)),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                //***********************************************/
                                SizedBox(
                                  height: size.iScreen(1.5),
                                ),
                                //*****************************************/
                                Row(
                                  children: [
                                    Container(
                                      // width: size.wScreen(100.0),

                                      // color: Colors.blue,
                                      child: Text('Propietario:  ',
                                          style: GoogleFonts.lexendDeca(
                                              // fontSize: size.iScreen(2.0),
                                              fontWeight: FontWeight.normal,
                                              color: Colors.grey)),
                                    ),
                                    //*****************************************/
                                    Consumer<HospitalizacionController>(
                                      builder: (_, valuePropietario, __) {
                                        return Expanded(
                                          child: Container(
                                            // width: size.wScreen(100.0),

                                            // color: Colors.blue,
                                            child: Text(
                                                valuePropietario
                                                            .getPropietarioMascota ==
                                                        ""
                                                    ? '--- --- --- '
                                                    : '${valuePropietario.getPropietarioMascota}',
                                                style: GoogleFonts.lexendDeca(
                                                    // fontSize: size.iScreen(2.0),
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: valuePropietario
                                                                .getPropietarioMascota ==
                                                            ""
                                                        ? Colors.grey
                                                        : Colors.black)),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: size.iScreen(2.0),
                                ),
                                //***********************************************/
                                SizedBox(
                                  height: size.iScreen(1.0),
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
                                        child: Text('Dr. General ',
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
                                Consumer<HospitalizacionController>(
                                  builder: (_, valueDoctor, __) {
                                    return SizedBox(
                                      width: size.wScreen(100.0),

                                      // color: Colors.blue,
                                      child: Text(
                                          valueDoctor
                                                  .getVetDoctorNombre!.isEmpty
                                              ? 'DEBE SELECCIONAR Dr.General '
                                              : '${valueDoctor.getVetDoctorNombre} ',
                                          style: GoogleFonts.lexendDeca(
                                              // fontSize: size.iScreen(2.0),
                                              fontWeight: FontWeight.normal,
                                              color: valueDoctor
                                                      .getVetDoctorNombre!
                                                      .isEmpty
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
                                        child: Text('Dr. Secundario ',
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
                                Consumer<HospitalizacionController>(
                                  builder: (_, valueDoctor, __) {
                                    return SizedBox(
                                      width: size.wScreen(100.0),

                                      // color: Colors.blue,
                                      child: Text(
                                          valueDoctor
                                                  .getVetDoctorNombre!.isEmpty
                                              ? 'DEBE SELECCIONAR Dr.Secundario '
                                              : '${valueDoctor.getVetDoctorNombre} ',
                                          style: GoogleFonts.lexendDeca(
                                              // fontSize: size.iScreen(2.0),
                                              fontWeight: FontWeight.normal,
                                              color: valueDoctor
                                                      .getVetDoctorNombre!
                                                      .isEmpty
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
                                        child: Text('Dr. Nocturno ',
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
                                Consumer<HospitalizacionController>(
                                  builder: (_, valueDoctor, __) {
                                    return SizedBox(
                                      width: size.wScreen(100.0),

                                      // color: Colors.blue,
                                      child: Text(
                                          valueDoctor
                                                  .getVetDoctorNombre!.isEmpty
                                              ? 'DEBE SELECCIONAR Dr.Nocturno '
                                              : '${valueDoctor.getVetDoctorNombre} ',
                                          style: GoogleFonts.lexendDeca(
                                              // fontSize: size.iScreen(2.0),
                                              fontWeight: FontWeight.normal,
                                              color: valueDoctor
                                                      .getVetDoctorNombre!
                                                      .isEmpty
                                                  ? Colors.grey
                                                  : Colors.black)),
                                    );
                                  },
                                ),

                                //***********************************************/
                                SizedBox(
                                  height: size.iScreen(1.5),
                                ),
                                //*****************************************/
                                Row(
                                  children: [
                                    Container(
                                      // width: size.wScreen(100.0),

                                      // color: Colors.blue,
                                      child: Text('Condiciones : ',
                                          style: GoogleFonts.lexendDeca(
                                              // fontSize: size.iScreen(2.0),
                                              fontWeight: FontWeight.normal,
                                              color: Colors.grey)),
                                    ),
                                    //*****************************************/
                                    Consumer<HospitalizacionController>(
                                      builder: (_, valueCondiciones, __) {
                                        return SizedBox(
                                          // width: size.wScreen(100.0),

                                          // color: Colors.blue,
                                          child: GestureDetector(
                                            onTap: () {
                                              _buscarCondicionesMascota(
                                                  context, size);
                                            },
                                            child: Text(
                                                valueCondiciones
                                                            .getCondicionesMascota ==
                                                        ""
                                                    ? 'Seleccione Condiciones  '
                                                    : '${valueCondiciones.getCondicionesMascota}',
                                                style: GoogleFonts.lexendDeca(
                                                    // fontSize: size.iScreen(2.0),
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: valueCondiciones
                                                                .getCondicionesMascota ==
                                                            ""
                                                        ? Colors.grey
                                                        : Colors.black)),
                                          ),
                                        );
                                      },
                                    ),
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
                                  child: Text('Observación',
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
                                        : controllerHospitalizacion
                                            .getObservacacion,
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
                                      controllerHospitalizacion
                                          .setObservacacion(text);
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
                                //***********************************************/
                                SizedBox(
                                  height: size.iScreen(1.5),
                                ),
                                //*****************************************/
                                Container(
                                  width: size.wScreen(100.0),

                                  // color: Colors.blue,
                                  child: Text('Diagnóstico',
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
                                        : controllerHospitalizacion
                                            .getObservacacion,
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
                                      controllerHospitalizacion
                                          .setDiagnostico(text);
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
                                //***********************************************/
                                SizedBox(
                                  height: size.iScreen(1.5),
                                ),
                                //*****************************************/
                                Container(
                                  width: size.wScreen(100.0),

                                  // color: Colors.blue,
                                  child: Text('Exámenes Complementarios',
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
                                        : controllerHospitalizacion
                                            .getExamenesComplementarios,
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
                                      controllerHospitalizacion
                                          .setExamenesComplementarios(text);
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
                                                  .getNuevoMedicamento
                                                  .isNotEmpty
                                              ? Text(
                                                  '${valueTotalMedic.getNuevoMedicamento.length}',
                                                  style: GoogleFonts.lexendDeca(
                                                      // fontSize: size.iScreen(2.0),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.grey))
                                              : Container();
                                        },
                                      ),
                                      SizedBox(
                                        width: size.iScreen(2.0),
                                      ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: GestureDetector(
                                          onTap: () {
                                            controllerHospitalizacion
                                                .resetFormAddMedicina();
                                            controllerHospitalizacion
                                                .resetHoraMedicina();
                                            _agregaCabeceraMedicamentos(
                                                context, size, 'NUEVO');

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
                                    return (values
                                            .getNuevoMedicamento.isNotEmpty)
                                        ? PaginatedDataTable(
                                            header: const Text('MEDICAMENTOS'),
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
                                                  label: Text('Vía',
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
                                                CabeceraMedicinaHospitalizacionDTS(
                                                    values.getNuevoMedicamento,
                                                    size,
                                                    context,
                                                    'NUEVO',true),
                                            rowsPerPage: values
                                                .getNuevoMedicamento.length,
                                          )
                                        // : const SizedBox(),
                                        : const NoData(
                                            label:
                                                'No hay medicametos agregados ');
                                  },
                                ),
                                //***********************************************/
                                SizedBox(
                                  height: size.iScreen(1.0),
                                ),
                                //*****************************************/
                                Consumer<HospitalizacionController>(
                                  builder: (_, values, __) {
                                    return (values.getNuevoHorarioMedicamento
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
                                                  label: Text('Medicamento',
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
                                                HorarioMedicinaHospitalizacionDTS(
                                              values.getNuevoHorarioMedicamento,
                                              size,
                                              context,
                                              'NUEVO',
                                              int.parse(
                                                  values.getInicioMedicina),
                                              int.parse(
                                                  values.getFrecuenciaMedicina),
                                                  true
                                            ),
                                            rowsPerPage: values
                                                .getNuevoHorarioMedicamento
                                                .length,
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
                                      SizedBox(
                                        width: size.iScreen(2.0),
                                      ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: GestureDetector(
                                          onTap: () {
                                            controllerHospitalizacion
                                                .resetFormAddAlimentos();
                                            controllerHospitalizacion
                                                .resetHoraAlimento();
                                            _agregaCabeceraAlimentos(
                                                context, size, 'NUEVO');

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
                                    return (values.getNuevoAlimento.isNotEmpty)
                                        ? PaginatedDataTable(
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
                                                    'NUEVO',true),
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
                                                  true
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
                                      SizedBox(
                                        width: size.iScreen(2.0),
                                      ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: GestureDetector(
                                          onTap: () {
                                            controllerHospitalizacion
                                                .resetFormAddAlimentos();
                                            _agregaCabeceraFluidos(
                                                context, size, 'NUEVO');

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
                                                    'NUEVO',true),
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
                                      SizedBox(
                                        width: size.iScreen(2.0),
                                      ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: GestureDetector(
                                          onTap: () {
                                            controllerHospitalizacion
                                                .resetFormAddInfusion();
                                            _agregaCabeceraInfusion(
                                                context, size, 'NUEVO');

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
                                                    'NUEVO',true),
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
                                      SizedBox(
                                        width: size.iScreen(2.0),
                                      ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: GestureDetector(
                                          onTap: () {
                                            // controllerHospitalizacion
                                            //     .resetFormAddParametro();
                                            // _agregaCabeceraParametros(
                                            //     context, size, 'NUEVO');
                                             controllerHospitalizacion
                                                .resetFormAddParametro();
                                            controllerHospitalizacion
                                                .resetHoraParametros();
                                            _agregaCabeceraParametros(
                                                context, size, 'NUEVO');

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
                                                    'NUEVO',true),
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
                                                  true
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
                                )
                              ],
                            ),
                          ),
                        )
                     )),
    );
  }

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
                                      .read<HospitalizacionController>()
                                      .setMascotaInfo(_mascota);

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

  //**********************************************BUSCA MASCOTA **********************************************************************//
  Future<bool?> _buscarMedicina(BuildContext context, Responsive size) {
    return showDialog<bool>(
      barrierColor: Colors.black54,
      context: context,
      builder: (context) {
        // final controller = context.read<PropietariosController>();
        final controllerMedicina = context.read<HospitalizacionController>();

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
                            controllerMedicina.onSearchTextMedicina(text);

                            if (controllerMedicina.nameSearchMedicina.isEmpty) {
                              controllerMedicina.buscaAllMedicinas('');
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

                          Consumer<HospitalizacionController>(
                        builder: (_, providerMedicina, __) {
                          if (providerMedicina.getErrorMedicinas == null) {
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
                          } else if (providerMedicina.getErrorMedicinas ==
                              false) {
                            return const NoData(
                              label: 'No existen datos para mostar',
                            );
                            // Text("Error al cargar los datos");
                          } else if (providerMedicina
                              .getListaMedicinas.isEmpty) {
                            return const NoData(
                              label: 'No existen datos para mostar',
                            );
                          }
                          // print('esta es la lista*******************: ${providerMedicina.getListaPropietarios.length}');

                          return ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount:
                                providerMedicina.getListaMedicinas.length,
                            itemBuilder: (BuildContext context, int index) {
                              final _medicina =
                                  providerMedicina.getListaMedicinas[index];
                              return GestureDetector(
                                onTap: () {
                                  context
                                      .read<HospitalizacionController>()
                                      .setMedicinaInfo(_medicina);

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

  //**********************************************BUSCA MASCOTA **********************************************************************//
  Future<bool?> _buscarParametro(BuildContext context, Responsive size) {
    return showDialog<bool>(
      barrierColor: Colors.black54,
      context: context,
      builder: (context) {
        // final controller = context.read<PropietariosController>();
        final controllerParametro = context.read<HospitalizacionController>();

        return AlertDialog(
            title: const Text("BUSCAR PARÁMETRO"),
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
                            controllerParametro.onSearchTextParametro(text);

                            if (controllerParametro
                                .nameSearchParametro.isEmpty) {
                              controllerParametro.buscaAllParametros('');
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

                          Consumer<HospitalizacionController>(
                        builder: (_, providerParametro, __) {
                          if (providerParametro.getErrorParametros == null) {
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
                          } else if (providerParametro.getErrorParametros ==
                              false) {
                            return const NoData(
                              label: 'No existen datos para mostar',
                            );
                            // Text("Error al cargar los datos");
                          } else if (providerParametro
                              .getListaParametros.isEmpty) {
                            return const NoData(
                              label: 'No existen datos para mostar',
                            );
                          }
                          // print('esta es la lista*******************: ${providerParametro.getListaPropietarios.length}');

                          return ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount:
                                providerParametro.getListaParametros.length,
                            itemBuilder: (BuildContext context, int index) {
                              final _parametro =
                                  providerParametro.getListaParametros[index];
                              return GestureDetector(
                                onTap: () {
                                  context
                                      .read<HospitalizacionController>()
                                      .setParametroInfo(_parametro);
                                  // print('esta es la lista*******************: ${providerParametro.getDosisParametro}');
                                  setState(() {
                                    _dosisParametro.text =
                                        providerParametro.getDosisParametro;
                                  });

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
                                                      '${_parametro['paramNombre']}',
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

  //**********************************************BUSCA MASCOTA **********************************************************************//
  Future<bool?> _buscarEstado(BuildContext context, Responsive size) {
    return showDialog<bool>(
        barrierColor: Colors.black54,
        context: context,
        builder: (context) {
          // final controller = context.read<PropietariosController>();
          final controllerHospitalizacion =
              context.read<HospitalizacionController>();

          List _estadoMascota = [
            "HOSPITALIZADO",
            "ALTA",
            "FALLECIDO",
            "SOLICITADO",
          ];

          return AlertDialog(
              title: const Text("SELECCIONE ESTADO"),
              content: Card(
                  color: Colors.transparent,
                  elevation: 0.0,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        // color: Colors.red,
                        width: size.wScreen(100),
                        height: size.hScreen(30.0),
                        child: Wrap(
                            children: _estadoMascota
                                .map((e) => GestureDetector(
                                      onTap: () {
                                        // context
                                        //     .read<PeluqueriaController>()
                                        controllerHospitalizacion
                                            .setEstadoMascota(e);

                                        Navigator.pop(context);
                                      },
                                      child: Card(
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          margin: EdgeInsets.symmetric(
                                              vertical: size.iScreen(0.5),
                                              horizontal: size.iScreen(1.0)),
                                          elevation: 2,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: size
                                                                .iScreen(0.0),
                                                            vertical: size
                                                                .iScreen(1.0)),
                                                    child: Column(
                                                      children: <Widget>[
                                                        Container(
                                                          width: size
                                                              .wScreen(100.0),
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal: size
                                                                      .iScreen(
                                                                          1.0),
                                                                  vertical: size
                                                                      .iScreen(
                                                                          0.2)),
                                                          child: Text(
                                                            e,
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
                                    ))
                                .toList()),
                        // Text('data')
                      ),
                    ],
                  )

                  //  },)

                  ));
        });
  }

  //**********************************************BUSCA MASCOTA **********************************************************************//
  Future<bool?> _agregaHorarios(BuildContext context, Responsive size) {
    return showDialog<bool>(
        barrierColor: Colors.black54,
        context: context,
        builder: (context) {
          // final controller = context.read<PropietariosController>();
          final controllerHospitalizacion =
              context.read<HospitalizacionController>();

          List _estadoMascota = [
            "HOSPITALIZADO",
            "ALTA",
            "FALLECIDO",
            "SOLICITADO",
          ];

          return AlertDialog(
              title: const Text("SELECCIONE ESTADO"),
              content: Card(
                  color: Colors.transparent,
                  elevation: 0.0,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        // color: Colors.red,
                        width: size.wScreen(100),
                        height: size.hScreen(30.0),
                        child: Wrap(
                            children: _estadoMascota
                                .map((e) => GestureDetector(
                                      onTap: () {
                                        // context
                                        //     .read<PeluqueriaController>()
                                        controllerHospitalizacion
                                            .setEstadoMascota(e);

                                        Navigator.pop(context);
                                      },
                                      child: Card(
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          margin: EdgeInsets.symmetric(
                                              vertical: size.iScreen(0.5),
                                              horizontal: size.iScreen(1.0)),
                                          elevation: 2,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: size
                                                                .iScreen(0.0),
                                                            vertical: size
                                                                .iScreen(1.0)),
                                                    child: Column(
                                                      children: <Widget>[
                                                        Container(
                                                          width: size
                                                              .wScreen(100.0),
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal: size
                                                                      .iScreen(
                                                                          1.0),
                                                                  vertical: size
                                                                      .iScreen(
                                                                          0.2)),
                                                          child: Text(
                                                            e,
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
                                    ))
                                .toList()),
                        // Text('data')
                      ),
                    ],
                  )

                  //  },)

                  ));
        });
  }

  //**********************************************BUSCA CONDICIONES **********************************************************************//
  Future<bool?> _buscarCondicionesMascota(
      BuildContext context, Responsive size) {
    return showDialog<bool>(
        barrierColor: Colors.black54,
        context: context,
        builder: (context) {
          // final controller = context.read<PropietariosController>();
          final controllerHospitalizacion =
              context.read<HospitalizacionController>();

          List _estadoMascota = [
            "ESTABLE",
            "CRITICO",
            "INFECCIOSO",
            "NO INFECCIOSO",
          ];

          return AlertDialog(
              title: const Text("SELECCIONE ESTADO"),
              content: Card(
                  color: Colors.transparent,
                  elevation: 0.0,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        // color: Colors.red,
                        width: size.wScreen(100),
                        height: size.hScreen(30.0),
                        child: Wrap(
                            children: _estadoMascota
                                .map((e) => GestureDetector(
                                      onTap: () {
                                        // context
                                        //     .read<PeluqueriaController>()
                                        controllerHospitalizacion
                                            .setCondicionesMascota(e);

                                        Navigator.pop(context);
                                      },
                                      child: Card(
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          margin: EdgeInsets.symmetric(
                                              vertical: size.iScreen(0.5),
                                              horizontal: size.iScreen(1.0)),
                                          elevation: 2,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: size
                                                                .iScreen(0.0),
                                                            vertical: size
                                                                .iScreen(1.0)),
                                                    child: Column(
                                                      children: <Widget>[
                                                        Container(
                                                          width: size
                                                              .wScreen(100.0),
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal: size
                                                                      .iScreen(
                                                                          1.0),
                                                                  vertical: size
                                                                      .iScreen(
                                                                          0.2)),
                                                          child: Text(
                                                            e,
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
                                    ))
                                .toList()),
                        // Text('data')
                      ),
                    ],
                  )

                  //  },)

                  ));
        });
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
                                      .read<HospitalizacionController>()
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
  void _onSubmit(BuildContext context, HospitalizacionController controller,
     ) async {
    final isValid = controller.validateForm();
    if (!isValid) return;
    if (isValid) {
      if (controller.getNombreMascota == '') {
        NotificatiosnService.showSnackBarDanger('Debe seleccionar Mascota');
      } else if (controller.getPesoMascota == '') {
        NotificatiosnService.showSnackBarDanger('Agregar Peso');
      } else if (controller.getVetDoctorNombre == '') {
        NotificatiosnService.showSnackBarDanger(
            'Debe seleccionar Vet Responsable');
      } else if (controller.getEstadoMascota == '') {
        NotificatiosnService.showSnackBarDanger(
            'Debe seleccionar Estado mascota');
      } else if (controller.getNuevoMedicamento.isEmpty) {
        NotificatiosnService.showSnackBarDanger('Debe agregar Medicamento');
      } else if (controller.getNuevoHorarioMedicamento.isEmpty) {
        NotificatiosnService.showSnackBarDanger('Agregar horario medicamento');
      } else if (controller.getNuevoAlimento.isEmpty) {
        NotificatiosnService.showSnackBarDanger('Debe agregar Alimento');
      } else if (controller.getNuevoHorarioAlimeno.isEmpty) {
        NotificatiosnService.showSnackBarDanger('Agregar horario Alimento');
      } else if (controller.getNuevoFluido.isEmpty) {
        NotificatiosnService.showSnackBarDanger('Agregar Fluido');
      } else if (controller.getNuevoInfusion.isEmpty) {
        NotificatiosnService.showSnackBarDanger('Agregar Infusión');
      } else if (controller.getNuevoParametro.isEmpty) {
        NotificatiosnService.showSnackBarDanger('Debe agregar Parámetro');
      } else if (controller.getNuevoHorarioParametro.isEmpty) {
        NotificatiosnService.showSnackBarDanger('Agregar horario Parámetro');
      }

      // // else if (controller.getVetDoctorNombre == '') {
      // //   NotificatiosnService.showSnackBarDanger('Debe seleccionar Veterinario');
      // // }
      if (controller.getNombreMascota != '' &&
          controller.getPesoMascota != '' &&
          controller.getEstadoMascota != '' &&
          controller.getVetDoctorNombre != '' &&
          controller.getNuevoMedicamento.isNotEmpty &&
          controller.getNuevoHorarioMedicamento.isNotEmpty &&
          controller.getNuevoAlimento.isNotEmpty &&
          controller.getNuevoHorarioAlimeno.isNotEmpty &&
          controller.getNuevoFluido.isNotEmpty &&
          controller.getNuevoInfusion.isNotEmpty &&
          controller.getNuevoParametro.isNotEmpty &&
          controller.getNuevoHorarioParametro.isNotEmpty &&
          controller.getVetDoctorNombre != '') {
        if (widget.tipo == 'CREATE') {
          await controller.creaHospitalizacion(context);
          Navigator.pop(context);
        }
        if (widget.tipo == 'EDIT') {
          await controller.editaHospitalizacion(context);
          Navigator.pop(context);
        }
      }
    }
  }

//*********************************************ALIMENTOS**********************************************************************//
  Future<bool?> _agregaCabeceraMedicamentos(
      BuildContext context, Responsive size, String _estado) {
    return showDialog<bool>(
        barrierColor: Colors.black54,
        context: context,
        builder: (context) {
          // final controller = context.read<PropietariosController>();
          final controllerHosp = context.read<HospitalizacionController>();

          return AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(child: Text("INGRESE MEDICAMENTO")),
                  IconButton(
                      splashRadius: 25.0,
                      onPressed: () {
                        final isValidS =
                            controllerHosp.validateFormAgregaMedicina();
                        if (!isValidS) return;
                        if (isValidS) {
                          if (controllerHosp.getNombreMedicina == '') {
                            FocusScope.of(context).unfocus();
                            NotificatiosnService.showSnackBarDanger(
                                'Debe seleccionar Medicina');
                          }
                          if (controllerHosp.getNombreMedicina != '') {
                            controllerHosp.addCabeceraMedicamento();
                            Navigator.pop(context);
                          }
                        }
                      },
                      icon: Icon(Icons.save_outlined,
                          size: size.iScreen(3.5), )),
                ],
              ),
              content: Card(
                  color: Colors.transparent,
                  elevation: 0.0,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          // color: Colors.red,
                          width: size.wScreen(100),
                          height: size.hScreen(50.0),

                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Form(
                              key:
                                  controllerHosp.hospitalizacionMedicinaFormKey,
                              child: Column(
                                children: [
                              //***********************************************/
                                  // SizedBox(
                                  //   height: size.iScreen(1.5),
                                  // ),
                                  //*****************************************/
                                  Consumer<HospitalizacionController>(
                                    builder: (_, valuefechaMedicina, __) {
                                      return Row(
                                        children: [
                                          Text(
                                            'Fecha: ',
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
                                              _fechaHoraMedicina(
                                                  context, valuefechaMedicina);
                                            },
                                            child: Row(
                                              children: [
                                                Text(
                                                  valuefechaMedicina
                                                          .getFechaHoraMedicina ??
                                                      'yyyy-mm-dd',
                                                  style: GoogleFonts.lexendDeca(
                                                    fontSize: size.iScreen(1.8),
                                                    // color: Colors.black45,
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
                                      );
                                    },
                                  ),
                                   SizedBox(
                                    height: size.iScreen(1.5),
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        // width: size.wScreen(100.0),

                                        // color: Colors.blue,
                                        child: Text('Medicina ',
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
                                                .read<
                                                    HospitalizacionController>()
                                                .buscaAllMedicinas('');

                                            // _buscarMascota(context, size);
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
                                  //***********************************************/
                                  SizedBox(
                                    height: size.iScreen(1.0),
                                  ),
                                  //*****************************************/
                                  Consumer<HospitalizacionController>(
                                    builder: (_, valueMascota, __) {
                                      return SizedBox(
                                        width: size.wScreen(100.0),

                                        // color: Colors.blue,
                                        child: Text(
                                            valueMascota.getNombreMedicina == ''
                                                ? 'DEBE AGREGAR MEDICINA '
                                                : '${valueMascota.getNombreMedicina}',
                                            style: GoogleFonts.lexendDeca(
                                                // fontSize: size.iScreen(2.0),
                                                fontWeight: FontWeight.normal,
                                                color: valueMascota
                                                            .getNombreMedicina ==
                                                        ''
                                                    ? Colors.grey
                                                    : Colors.black)),
                                      );
                                    },
                                  ),
                                 
                                  //***********************************************/
                                  SizedBox(
                                    height: size.iScreen(1.5),
                                  ),
                                  //*****************************************/
                                  Row(
                                    children: [
                                      Container(
                                        width: size.wScreen(12.0),

                                        // color: Colors.blue,
                                        child: Text('Dosis:',
                                            style: GoogleFonts.lexendDeca(
                                                // fontSize: size.iScreen(2.0),
                                                fontWeight: FontWeight.normal,
                                                color: Colors.grey)),
                                      ),
                                      Expanded(
                                        child: Container(
                                          // width: size.wScreen(20.0),
                                          child: TextFormField(
                                            initialValue: _estado == 'NUEVO'
                                                ? ""
                                                : controllerHosp
                                                    .getDosisMedicina,
                                            // keyboardType: TextInputType.number,
                                            // inputFormatters: <TextInputFormatter>[
                                            //   FilteringTextInputFormatter.allow(
                                            //       RegExp(r'[0-9.]')),
                                            // ],
                                            decoration: const InputDecoration(
                                                // suffixIcon: Icon(Icons.beenhere_outlined)
                                                ),
                                            textAlign: TextAlign.center,
                                            //  maxLines: 3,
                                            //  minLines: 1,
                                            style: TextStyle(
                                              fontSize: size.iScreen(2.0),
                                              // fontWeight: FontWeight.bold,
                                              // letterSpacing: 2.0,
                                            ),
                                            onChanged: (text) {
                                              controllerHosp
                                                  .setDosisMedicina(text);
                                            },
                                            validator: (text) {
                                              if (text!.trim().isNotEmpty) {
                                                return null;
                                              } else {
                                                return 'Ingrese la Dosis';
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  //***********************************************/
                                  SizedBox(
                                    height: size.iScreen(1.5),
                                  ),
                                  //*****************************************/
                                  Row(
                                    children: [
                                      Container(
                                        width: size.wScreen(18.0),

                                        // color: Colors.blue,
                                        child: Text('Cantidad:',
                                            style: GoogleFonts.lexendDeca(
                                                // fontSize: size.iScreen(2.0),
                                                fontWeight: FontWeight.normal,
                                                color: Colors.grey)),
                                      ),
                                      Expanded(
                                        child: Container(
                                          width: size.wScreen(10.0),
                                          child: TextFormField(
                                            initialValue: _estado == 'NUEVO'
                                                ? "1"
                                                : controllerHosp
                                                    .getCantidadMedicina,

                                            keyboardType: TextInputType.number,
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter.allow(
                                                  RegExp(r'[0-9]')),
                                            ],
                                            decoration: const InputDecoration(
                                                // suffixIcon: Icon(Icons.beenhere_outlined)
                                                ),
                                            textAlign: TextAlign.center,
                                            //  maxLines: 3,
                                            //  minLines: 1,
                                            style: TextStyle(
                                              fontSize: size.iScreen(2.0),
                                              // fontWeight: FontWeight.bold,
                                              // letterSpacing: 2.0,s
                                            ),
                                            onChanged: (text) {
                                              controllerHosp
                                                  .setCantidadMedicina(text);
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
                                      ),
                                    ],
                                  ),
                                  //***********************************************/
                                  SizedBox(
                                    height: size.iScreen(1.5),
                                  ),
                                  //*****************************************/
                                  Row(
                                    children: [
                                      Container(
                                        width: size.wScreen(12.0),

                                        // color: Colors.blue,
                                        child: Text('Vía :',
                                            style: GoogleFonts.lexendDeca(
                                                // fontSize: size.iScreen(2.0),
                                                fontWeight: FontWeight.normal,
                                                color: Colors.grey)),
                                      ),
                                      Expanded(
                                        child: Container(
                                          // width: size.wScreen(20.0),
                                          child: TextFormField(
                                            initialValue: _estado == 'NUEVO'
                                                ? ""
                                                : controllerHosp.getViaMedicina,
                                            //     ? ''
                                            //     : controllerHospitalizacion.getExamenesComplementarios,
                                            // keyboardType: TextInputType.number,
                                            // inputFormatters: <TextInputFormatter>[
                                            //   FilteringTextInputFormatter.allow(
                                            //       RegExp(r'[0-9.]')),
                                            // ],
                                            decoration: const InputDecoration(
                                                // suffixIcon: Icon(Icons.beenhere_outlined)
                                                ),
                                            textAlign: TextAlign.center,
                                            //  maxLines: 3,
                                            //  minLines: 1,
                                            style: TextStyle(
                                              fontSize: size.iScreen(2.0),
                                              // fontWeight: FontWeight.bold,
                                              // letterSpacing: 2.0,
                                            ),
                                            onChanged: (text) {
                                              controllerHosp
                                                  .setViaMedicina(text);
                                            },
                                            validator: (text) {
                                              if (text!.trim().isNotEmpty) {
                                                return null;
                                              } else {
                                                return 'Ingrese Vía';
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  //***********************************************/
                                  SizedBox(
                                    height: size.iScreen(1.5),
                                  ),
                                  //*****************************************/
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                            // width: size.wScreen(18.0),

                                            // color: Colors.blue,
                                            child: Text('Inicio ',
                                                style: GoogleFonts.lexendDeca(
                                                    // fontSize: size.iScreen(2.0),
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.grey)),
                                          ),
                                          Container(
                                            width: size.wScreen(15.0),
                                            child: TextFormField(
                                              initialValue: _estado == 'NUEVO'
                                                  ? "0"
                                                  : controllerHosp
                                                      .getInicioMedicina,

                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: <
                                                  TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .allow(RegExp(r'[0-9]')),
                                              ],
                                              decoration: const InputDecoration(
                                                  // suffixIcon: Icon(Icons.beenhere_outlined)
                                                  ),
                                              textAlign: TextAlign.center,
                                              //  maxLines: 3,
                                              //  minLines: 1,
                                              style: TextStyle(
                                                fontSize: size.iScreen(2.0),
                                                // fontWeight: FontWeight.bold,
                                                // letterSpacing: 2.0,s
                                              ),
                                              onChanged: (text) {
                                                controllerHosp
                                                    .setInicioMedicina(text);
                                                // if(text.isNotEmpty){

                                                // controllerHosp
                                                //     .setInicioMedicina(text);
                                                // }
                                                // else{
                                                // controllerHosp
                                                //     .setInicioMedicina('0');

                                                // }
                                              },
                                              validator: (text) {
                                                if (text!.trim().isNotEmpty) {
                                                  return null;
                                                } else {
                                                  return 'Ingrese Inicio';
                                                }
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                            // width: size.wScreen(18.0),

                                            // color: Colors.blue,
                                            child: Text('Frecuencia ',
                                                style: GoogleFonts.lexendDeca(
                                                    // fontSize: size.iScreen(2.0),
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.grey)),
                                          ),
                                          Container(
                                            width: size.wScreen(15.0),
                                            child: TextFormField(
                                              initialValue: _estado == 'NUEVO'
                                                  ? "1"
                                                  : controllerHosp
                                                      .getFrecuenciaMedicina,
                                              //     ? ''
                                              //     : controllerHosp.getExamenesComplementarios,
                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: <
                                                  TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .allow(RegExp(r'[0-9]')),
                                              ],
                                              decoration: const InputDecoration(
                                                  // suffixIcon: Icon(Icons.beenhere_outlined)
                                                  ),
                                              textAlign: TextAlign.center,
                                              //  maxLines: 3,
                                              //  minLines: 1,
                                              style: TextStyle(
                                                fontSize: size.iScreen(2.0),
                                                // fontWeight: FontWeight.bold,
                                                // letterSpacing: 2.0,s
                                              ),
                                              onChanged: (text) {
                                                controllerHosp
                                                    .setFrecuenciaMedicina(
                                                        text);
                                                //  if(text.isNotEmpty){
                                                // }
                                                // else{
                                                //   controllerHosp
                                                //     .setFrecuenciaMedicina('1');
                                                // }
                                              },
                                              validator: (text) {
                                                if (text!.trim().isNotEmpty) {
                                                  return null;
                                                } else {
                                                  return 'Ingrese Frecuencia';
                                                }
                                              },
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

                                  // TextButton(
                                  //     onPressed: () {
                                  //       // final isValidS = controllerHosp
                                  //       //     .validateFormAgregaMedicina();
                                  //       // if (!isValidS) return;
                                  //       // if (isValidS) {
                                  //       //   if (controllerHosp
                                  //       //           .getNombreMedicina ==
                                  //       //       '') {
                                  //       //     FocusScope.of(context).unfocus();
                                  //       //     NotificatiosnService
                                  //       //         .showSnackBarDanger(
                                  //       //             'Debe seleccionar Medicina');
                                  //       //   }
                                  //       //   if (controllerHosp
                                  //       //           .getNombreMedicina !=
                                  //       //       '') {
                                  //       //     controllerHosp
                                  //       //         .addCabeceraMedicamento();
                                  //       //     Navigator.pop(context);
                                  //       //   }
                                  //       // }
                                  //     },
                                  //     child: Container(
                                  //       decoration: BoxDecoration(
                                  //           color: primaryColor,
                                  //           borderRadius:
                                  //               BorderRadius.circular(5.0)),
                                  //       // color: primaryColor,
                                  //       padding: EdgeInsets.symmetric(
                                  //           vertical: size.iScreen(0.5),
                                  //           horizontal: size.iScreen(0.5)),
                                  //       child: Text('Agregar',
                                  //           style: GoogleFonts.lexendDeca(
                                  //               // fontSize: size.iScreen(2.0),
                                  //               fontWeight: FontWeight.normal,
                                  //               color: Colors.white)),
                                  //     ))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )

                  //  },)

                  ));
        });
  }

  //================================================= SELECCIONA FECHA MEDICINA ==================================================//
  _fechaHoraMedicina(
      BuildContext context, HospitalizacionController controller) async {
    // _selectFechaNacimiento(
    //                                     context, controller);
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
      controller.setFechaHoraMedicina(_fechaInicio);
      // print('FechaInicio: $_fechaInicio');
      // });
    }
  }
  //================================================= SELECCIONA FECHA ALIMENTOS ==================================================//
  _fechaHoraAlimentos(
      BuildContext context, HospitalizacionController controller) async {
    // _selectFechaNacimiento(
    //                                     context, controller);
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
      controller.setFechaHoraAlimentos(_fechaInicio);
      // print('FechaInicio: $_fechaInicio');
      // });
    }
  }
    //================================================= SELECCIONA FECHA PARAMETROS ==================================================//
  _fechaHoraParametros(
      BuildContext context, HospitalizacionController controller) async {
    // _selectFechaNacimiento(
    //                                     context, controller);
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
      controller.setFechaHoraParametros(_fechaInicio);
      // print('FechaInicio: $_fechaInicio');
      // });
    }
  }
//*********************************************ALIMENTOS**********************************************************************//
  Future<bool?> _agregaCabeceraAlimentos(
      BuildContext context, Responsive size, String _estado) {
    return showDialog<bool>(
        barrierColor: Colors.black54,
        context: context,
        builder: (context) {
          // final controller = context.read<PropietariosController>();
          final controllerHosp = context.read<HospitalizacionController>();

          return AlertDialog(
              // title: const Text("INGRESE ALIMENTO"),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(child: Text("INGRESE ALIMENTO")),
                  IconButton(
                      splashRadius: 25.0,
                      onPressed: () {
                        final isValidS =
                            controllerHosp.validateFormAgregaAlimento();
                        if (!isValidS) return;
                        if (isValidS) {
                          if (controllerHosp.getNombreAlimento == '') {
                            FocusScope.of(context).unfocus();
                            NotificatiosnService.showSnackBarDanger(
                                'Debe seleccionar Alimento');
                          }
                          if (controllerHosp.getNombreAlimento != '') {
                            controllerHosp.addCabeceraAlimento();
                            Navigator.pop(context);
                          }
                        }
                      },
                      icon: Icon(Icons.save_outlined,
                          size: size.iScreen(3.5), )),
                ],
              ),
              content: Card(
                  color: Colors.transparent,
                  elevation: 0.0,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          // color: Colors.red,
                          width: size.wScreen(100),
                          height: size.hScreen(40.0),

                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Form(
                              key:
                                  controllerHosp.hospitalizacionAlimentoFormKey,
                              child: Column(
                                children: [
                                  //***********************************************/
                                  // SizedBox(
                                  //   height: size.iScreen(1.5),
                                  // ),
                                  //*****************************************/
                                  // Row(
                                  //   children: [
                                  //     SizedBox(
                                  //       // width: size.wScreen(100.0),

                                  //       // color: Colors.blue,
                                  //       child: Text('Alimento ',
                                  //           style: GoogleFonts.lexendDeca(
                                  //               // fontSize: size.iScreen(2.0),
                                  //               fontWeight: FontWeight.normal,
                                  //               color: Colors.grey)),
                                  //     ),
                                  //     SizedBox(
                                  //       width: size.iScreen(2.0),
                                  //     ),
                                  //     ClipRRect(
                                  //       borderRadius: BorderRadius.circular(8),
                                  //       child: GestureDetector(
                                  //         onTap: () {
                                  //           // context
                                  //           //     .read<
                                  //           //         HospitalizacionController>()
                                  //           //     .buscaAllMedicinas('');

                                  //           // _buscarMedicina(context, size);

                                  //           //*******************************************/
                                  //         },
                                  //         child: Container(
                                  //           alignment: Alignment.center,
                                  //           color: primaryColor,
                                  //           width: size.iScreen(3.5),
                                  //           padding: EdgeInsets.only(
                                  //             top: size.iScreen(0.5),
                                  //             bottom: size.iScreen(0.5),
                                  //             left: size.iScreen(0.5),
                                  //             right: size.iScreen(0.5),
                                  //           ),
                                  //           child: Icon(
                                  //             Icons.search_outlined,
                                  //             color: Colors.white,
                                  //             size: size.iScreen(2.0),
                                  //           ),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  // //***********************************************/
                                  // SizedBox(
                                  //   height: size.iScreen(1.0),
                                  // ),
                                  // //*****************************************/
                                  // Consumer<HospitalizacionController>(
                                  //   builder: (_, valueMascota, __) {
                                  //     return SizedBox(
                                  //       width: size.wScreen(100.0),

                                  //       // color: Colors.blue,
                                  //       child: Text(
                                  //           valueMascota.getNombreAlimento == ''
                                  //               ? 'DEBE AGREGAR ALIMENTO '
                                  //               : '${valueMascota.getNombreAlimento}',
                                  //           style: GoogleFonts.lexendDeca(
                                  //               // fontSize: size.iScreen(2.0),
                                  //               fontWeight: FontWeight.normal,
                                  //               color: valueMascota
                                  //                           .getNombreAlimento ==
                                  //                       ''
                                  //                   ? Colors.grey
                                  //                   : Colors.black)),
                                  //     );
                                  //   },
                                  // ),
                                  // //***********************************************/
                                  // SizedBox(
                                  //   height: size.iScreen(1.5),
                                  // ),
                                  // //*****************************************/
                                  // //***********************************************/
                                  // SizedBox(
                                  //   height: size.iScreen(1.5),
                                  // ),
                                  // //*****************************************/
                                  Consumer<HospitalizacionController>(
                                    builder: (_, valuefechaAlimento, __) {
                                      return Row(
                                        children: [
                                          Text(
                                            'Fecha: ',
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
                                              _fechaHoraAlimentos(
                                                  context, valuefechaAlimento);
                                            },
                                            child: Row(
                                              children: [
                                                Text(
                                                  valuefechaAlimento
                                                          .getFechaHoraAlimentos ??
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
                                      );
                                    },
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: size.wScreen(17.0),

                                        // color: Colors.blue,
                                        child: Text('Alimento:',
                                            style: GoogleFonts.lexendDeca(
                                                // fontSize: size.iScreen(2.0),
                                                fontWeight: FontWeight.normal,
                                                color: Colors.grey)),
                                      ),
                                      Expanded(
                                        child: Container(
                                          // width: size.wScreen(20.0),
                                          child: TextFormField(
                                            initialValue: _estado == 'NUEVO'
                                                ? ""
                                                : controllerHosp
                                                    .getNombreAlimento,
                                            // keyboardType: TextInputType.number,
                                            // inputFormatters: <TextInputFormatter>[
                                            //   FilteringTextInputFormatter.allow(
                                            //       RegExp(r'[0-9.]')),
                                            // ],
                                            decoration: const InputDecoration(
                                                // suffixIcon: Icon(Icons.beenhere_outlined)
                                                ),
                                            textAlign: TextAlign.center,
                                            //  maxLines: 3,
                                            //  minLines: 1,
                                            style: TextStyle(
                                              fontSize: size.iScreen(2.0),
                                              // fontWeight: FontWeight.bold,
                                              // letterSpacing: 2.0,
                                            ),
                                            onChanged: (text) {
                                              controllerHosp
                                                  .setNombreAlimento(text);
                                            },
                                            validator: (text) {
                                              if (text!.trim().isNotEmpty) {
                                                return null;
                                              } else {
                                                return 'Ingrese Alimento';
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  //***********************************************/
                                  SizedBox(
                                    height: size.iScreen(1.5),
                                  ),
                                  //*****************************************/
                                  Row(
                                    children: [
                                      Container(
                                        width: size.wScreen(12.0),

                                        // color: Colors.blue,
                                        child: Text('Dosis : ',
                                            style: GoogleFonts.lexendDeca(
                                                // fontSize: size.iScreen(2.0),
                                                fontWeight: FontWeight.normal,
                                                color: Colors.grey)),
                                      ),
                                      Expanded(
                                        child: Container(
                                          // width: size.wScreen(20.0),
                                          child: TextFormField(
                                            initialValue: _estado == 'NUEVO'
                                                ? ""
                                                : controllerHosp
                                                    .getDosisAlimento,
                                            // keyboardType: TextInputType.number,
                                            // inputFormatters: <TextInputFormatter>[
                                            //   FilteringTextInputFormatter.allow(
                                            //       RegExp(r'[0-9.]')),
                                            // ],
                                            decoration: const InputDecoration(
                                                // suffixIcon: Icon(Icons.beenhere_outlined)
                                                ),
                                            textAlign: TextAlign.center,
                                            //  maxLines: 3,
                                            //  minLines: 1,
                                            style: TextStyle(
                                              fontSize: size.iScreen(2.0),
                                              // fontWeight: FontWeight.bold,
                                              // letterSpacing: 2.0,
                                            ),
                                            onChanged: (text) {
                                              controllerHosp
                                                  .setDosisAlimento(text);
                                            },
                                            validator: (text) {
                                              if (text!.trim().isNotEmpty) {
                                                return null;
                                              } else {
                                                return 'Ingrese la Dosis';
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  //***********************************************/
                                  SizedBox(
                                    height: size.iScreen(1.5),
                                  ),
                                  //*****************************************/
                                  Row(
                                    children: [
                                      Container(
                                        width: size.wScreen(18.0),

                                        // color: Colors.blue,
                                        child: Text('Cantidad:',
                                            style: GoogleFonts.lexendDeca(
                                                // fontSize: size.iScreen(2.0),
                                                fontWeight: FontWeight.normal,
                                                color: Colors.grey)),
                                      ),
                                      Expanded(
                                        child: Container(
                                          width: size.wScreen(10.0),
                                          child: TextFormField(
                                            initialValue: _estado == 'NUEVO'
                                                ? "1"
                                                : controllerHosp
                                                    .getCantidadAlimento,

                                            keyboardType: TextInputType.number,
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter.allow(
                                                  RegExp(r'[0-9]')),
                                            ],
                                            decoration: const InputDecoration(
                                                // suffixIcon: Icon(Icons.beenhere_outlined)
                                                ),
                                            textAlign: TextAlign.center,
                                            //  maxLines: 3,
                                            //  minLines: 1,
                                            style: TextStyle(
                                              fontSize: size.iScreen(2.0),
                                              // fontWeight: FontWeight.bold,
                                              // letterSpacing: 2.0,s
                                            ),
                                            onChanged: (text) {
                                              controllerHosp
                                                  .setCantidadAlimento(text);
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
                                      ),
                                    ],
                                  ),
                                  // //***********************************************/
                                  // SizedBox(
                                  //   height: size.iScreen(1.5),
                                  // ),
                                  // //*****************************************/
                                  // Row(
                                  //   children: [
                                  //     Container(
                                  //       width: size.wScreen(12.0),

                                  //       // color: Colors.blue,
                                  //       child: Text('Vía : ',
                                  //           style: GoogleFonts.lexendDeca(
                                  //               // fontSize: size.iScreen(2.0),
                                  //               fontWeight: FontWeight.normal,
                                  //               color: Colors.grey)),
                                  //     ),
                                  //     Expanded(
                                  //       child: Container(
                                  //         // width: size.wScreen(20.0),
                                  //         child: TextFormField(
                                  //           initialValue: _estado == 'NUEVO'
                                  //               ? ""
                                  //               : controllerHosp.getViaAlimento,
                                  //           //     ? ''
                                  //           //     : controllerHospitalizacion.getExamenesComplementarios,
                                  //           // keyboardType: TextInputType.number,
                                  //           // inputFormatters: <TextInputFormatter>[
                                  //           //   FilteringTextInputFormatter.allow(
                                  //           //       RegExp(r'[0-9.]')),
                                  //           // ],
                                  //           decoration: const InputDecoration(
                                  //               // suffixIcon: Icon(Icons.beenhere_outlined)
                                  //               ),
                                  //           textAlign: TextAlign.center,
                                  //           //  maxLines: 3,
                                  //           //  minLines: 1,
                                  //           style: TextStyle(
                                  //             fontSize: size.iScreen(2.0),
                                  //             // fontWeight: FontWeight.bold,
                                  //             // letterSpacing: 2.0,
                                  //           ),
                                  //           onChanged: (text) {
                                  //             controllerHosp
                                  //                 .setViaAlimento(text);
                                  //           },
                                  //           validator: (text) {
                                  //             if (text!.trim().isNotEmpty) {
                                  //               return null;
                                  //             } else {
                                  //               return 'Ingrese Vía';
                                  //             }
                                  //           },
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),

                                  //***********************************************/
                                  SizedBox(
                                    height: size.iScreen(1.5),
                                  ),
                                  //*****************************************/
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                            // width: size.wScreen(18.0),

                                            // color: Colors.blue,
                                            child: Text('Inicio ',
                                                style: GoogleFonts.lexendDeca(
                                                    // fontSize: size.iScreen(2.0),
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.grey)),
                                          ),
                                          Container(
                                            width: size.wScreen(15.0),
                                            child: TextFormField(
                                              initialValue: _estado == 'NUEVO'
                                                  ? "0"
                                                  : controllerHosp
                                                      .getInicioAlimento,

                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: <
                                                  TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .allow(RegExp(r'[0-9]')),
                                              ],
                                              decoration: const InputDecoration(
                                                  // suffixIcon: Icon(Icons.beenhere_outlined)
                                                  ),
                                              textAlign: TextAlign.center,
                                              //  maxLines: 3,
                                              //  minLines: 1,
                                              style: TextStyle(
                                                fontSize: size.iScreen(2.0),
                                                // fontWeight: FontWeight.bold,
                                                // letterSpacing: 2.0,s
                                              ),
                                              onChanged: (text) {
                                                controllerHosp
                                                    .setInicioAlimento(text);
                                                // if(text.isNotEmpty){

                                                // controllerHosp
                                                //     .setInicioAlimento(text);
                                                // }
                                                // else{
                                                // controllerHosp
                                                //     .setInicioAlimento('0');

                                                // }
                                              },
                                              validator: (text) {
                                                if (text!.trim().isNotEmpty) {
                                                  return null;
                                                } else {
                                                  return 'Ingrese Inicio';
                                                }
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                            // width: size.wScreen(18.0),

                                            // color: Colors.blue,
                                            child: Text('Frecuencia ',
                                                style: GoogleFonts.lexendDeca(
                                                    // fontSize: size.iScreen(2.0),
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.grey)),
                                          ),
                                          Container(
                                            width: size.wScreen(15.0),
                                            child: TextFormField(
                                              initialValue: _estado == 'NUEVO'
                                                  ? "1"
                                                  : controllerHosp
                                                      .getFrecuenciaAlimento,
                                              //     ? ''
                                              //     : controllerHosp.getExamenesComplementarios,
                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: <
                                                  TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .allow(RegExp(r'[0-9]')),
                                              ],
                                              decoration: const InputDecoration(
                                                  // suffixIcon: Icon(Icons.beenhere_outlined)
                                                  ),
                                              textAlign: TextAlign.center,
                                              //  maxLines: 3,
                                              //  minLines: 1,
                                              style: TextStyle(
                                                fontSize: size.iScreen(2.0),
                                                // fontWeight: FontWeight.bold,
                                                // letterSpacing: 2.0,s
                                              ),
                                              onChanged: (text) {
                                                controllerHosp
                                                    .setFrecuenciaAlimento(
                                                        text);
                                                //  if(text.isNotEmpty){
                                                // }
                                                // else{
                                                //   controllerHosp
                                                //     .setFrecuenciaMedicina('1');
                                                // }
                                              },
                                              validator: (text) {
                                                if (text!.trim().isNotEmpty) {
                                                  return null;
                                                } else {
                                                  return 'Ingrese Frecuencia';
                                                }
                                              },
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

                                  // TextButton(
                                  //     onPressed: () {
                                  //       final isValidS = controllerHosp
                                  //           .validateFormAgregaAlimento();
                                  //       if (!isValidS) return;
                                  //       if (isValidS) {
                                  //         if (controllerHosp
                                  //                 .getNombreAlimento ==
                                  //             '') {
                                  //           FocusScope.of(context).unfocus();
                                  //           NotificatiosnService
                                  //               .showSnackBarDanger(
                                  //                   'Debe seleccionar Alimento');
                                  //         }
                                  //         if (controllerHosp
                                  //                 .getNombreAlimento !=
                                  //             '') {
                                  //           controllerHosp
                                  //               .addCabeceraAlimento();
                                  //           Navigator.pop(context);
                                  //         }
                                  //       }
                                  //     },
                                  //     child: Container(
                                  //       decoration: BoxDecoration(
                                  //           color: primaryColor,
                                  //           borderRadius:
                                  //               BorderRadius.circular(5.0)),
                                  //       // color: primaryColor,
                                  //       padding: EdgeInsets.symmetric(
                                  //           vertical: size.iScreen(0.5),
                                  //           horizontal: size.iScreen(0.5)),
                                  //       child: Text('Agregar',
                                  //           style: GoogleFonts.lexendDeca(
                                  //               // fontSize: size.iScreen(2.0),
                                  //               fontWeight: FontWeight.normal,
                                  //               color: Colors.white)),
                                  //     ))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )

                  //  },)

                  ));
        });
  }

//*********************************************ALIMENTOS**********************************************************************//
  Future<bool?> _agregaCabeceraFluidos(
      BuildContext context, Responsive size, String _estado) {
    return showDialog<bool>(
        barrierColor: Colors.black54,
        context: context,
        builder: (context) {
          // final controller = context.read<PropietariosController>();
          final controllerHospital = context.read<HospitalizacionController>();

          return AlertDialog(
              // title: const Text("INGRESE FLUIDO"),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(child: Text("INGRESE FLUIDO")),
                  IconButton(
                      splashRadius: 25.0,
                      onPressed: () {
                        final isValidS =
                            controllerHospital.validateFormAgregaFluido();
                        if (!isValidS) return;
                        if (isValidS) {
                          if (controllerHospital.getNombreFluido == '') {
                            FocusScope.of(context).unfocus();
                            NotificatiosnService.showSnackBarDanger(
                                'Debe agregar Fluido');
                          }
                          if (controllerHospital.getNombreFluido != '') {
                            controllerHospital.addCabeceraFluido();
                            Navigator.pop(context);
                          }
                        }
                      },
                      icon: Icon(Icons.save_outlined,
                          size: size.iScreen(3.5))),
                ],
              ),
              content: Card(
                  color: Colors.transparent,
                  elevation: 0.0,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          // color: Colors.red,
                          width: size.wScreen(100),
                          height: size.hScreen(35.0),

                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Form(
                              key: controllerHospital
                                  .hospitalizacionFluidoFormKey,
                              child: Column(
                                children: [
                                  //***********************************************/
                                  // SizedBox(
                                  //   height: size.iScreen(1.5),
                                  // ),

                                  //***********************************************/
                                  // SizedBox(
                                  //   height: size.iScreen(1.5),
                                  // ),
                                  //*****************************************/
                                  Row(
                                    children: [
                                      Container(
                                        width: size.wScreen(16.0),

                                        // color: Colors.blue,
                                        child: Text('Fluido:',
                                            style: GoogleFonts.lexendDeca(
                                                // fontSize: size.iScreen(2.0),
                                                fontWeight: FontWeight.normal,
                                                color: Colors.grey)),
                                      ),
                                      Expanded(
                                        child: Container(
                                          // width: size.wScreen(20.0),
                                          child: TextFormField(
                                            initialValue: _estado == 'NUEVO'
                                                ? ""
                                                : controllerHospital
                                                    .getNombreFluido,
                                            // keyboardType: TextInputType.number,
                                            // inputFormatters: <TextInputFormatter>[
                                            //   FilteringTextInputFormatter.allow(
                                            //       RegExp(r'[0-9.]')),
                                            // ],
                                            decoration: const InputDecoration(
                                                // suffixIcon: Icon(Icons.beenhere_outlined)
                                                ),
                                            textAlign: TextAlign.center,
                                            //  maxLines: 3,
                                            //  minLines: 1,
                                            style: TextStyle(
                                              fontSize: size.iScreen(2.0),
                                              // fontWeight: FontWeight.bold,
                                              // letterSpacing: 2.0,
                                            ),
                                            onChanged: (text) {
                                              controllerHospital
                                                  .setNombreFluido(text);
                                            },
                                            validator: (text) {
                                              if (text!.trim().isNotEmpty) {
                                                return null;
                                              } else {
                                                return 'Ingrese Alimento';
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  //***********************************************/
                                  SizedBox(
                                    height: size.iScreen(1.5),
                                  ),
                                  //*****************************************/
                                  Row(
                                    children: [
                                      Container(
                                        width: size.wScreen(12.0),

                                        // color: Colors.blue,
                                        child: Text('Dosis:',
                                            style: GoogleFonts.lexendDeca(
                                                // fontSize: size.iScreen(2.0),
                                                fontWeight: FontWeight.normal,
                                                color: Colors.grey)),
                                      ),
                                      Expanded(
                                        child: Container(
                                          // width: size.wScreen(20.0),
                                          child: TextFormField(
                                            initialValue: _estado == 'NUEVO'
                                                ? ""
                                                : controllerHospital
                                                    .getDosisFluido,
                                            // keyboardType: TextInputType.number,
                                            // inputFormatters: <TextInputFormatter>[
                                            //   FilteringTextInputFormatter.allow(
                                            //       RegExp(r'[0-9.]')),
                                            // ],
                                            decoration: const InputDecoration(
                                                // suffixIcon: Icon(Icons.beenhere_outlined)
                                                ),
                                            textAlign: TextAlign.center,
                                            //  maxLines: 3,
                                            //  minLines: 1,
                                            style: TextStyle(
                                              fontSize: size.iScreen(2.0),
                                              // fontWeight: FontWeight.bold,
                                              // letterSpacing: 2.0,
                                            ),
                                            onChanged: (text) {
                                              controllerHospital
                                                  .setDosisFluido(text);
                                            },
                                            validator: (text) {
                                              if (text!.trim().isNotEmpty) {
                                                return null;
                                              } else {
                                                return 'Ingrese la Dosis';
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  // //***********************************************/
                                  // SizedBox(
                                  //   height: size.iScreen(1.5),
                                  // ),
                                  // //*****************************************/
                                  // Row(
                                  //   children: [
                                  //     Container(
                                  //       width: size.wScreen(18.0),

                                  //       // color: Colors.blue,
                                  //       child: Text('Cantidad : ',
                                  //           style: GoogleFonts.lexendDeca(
                                  //               // fontSize: size.iScreen(2.0),
                                  //               fontWeight: FontWeight.normal,
                                  //               color: Colors.grey)),
                                  //     ),
                                  //     Expanded(
                                  //       child: Container(
                                  //         width: size.wScreen(10.0),
                                  //         child: TextFormField(
                                  //           initialValue: _estado == 'NUEVO'
                                  //               ? "1"
                                  //               : controllerHospital
                                  //                   .getCantidadFluido,

                                  //           keyboardType: TextInputType.number,
                                  //           inputFormatters: <
                                  //               TextInputFormatter>[
                                  //             FilteringTextInputFormatter.allow(
                                  //                 RegExp(r'[0-9]')),
                                  //           ],
                                  //           decoration: const InputDecoration(
                                  //               // suffixIcon: Icon(Icons.beenhere_outlined)
                                  //               ),
                                  //           textAlign: TextAlign.center,
                                  //           //  maxLines: 3,
                                  //           //  minLines: 1,
                                  //           style: TextStyle(
                                  //             fontSize: size.iScreen(2.0),
                                  //             // fontWeight: FontWeight.bold,
                                  //             // letterSpacing: 2.0,s
                                  //           ),
                                  //           onChanged: (text) {
                                  //             controllerHospital
                                  //                 .setCantidadFluido(text);
                                  //           },
                                  //           validator: (text) {
                                  //             if (text!.trim().isNotEmpty) {
                                  //               return null;
                                  //             } else {
                                  //               return 'Ingrese Cantidad';
                                  //             }
                                  //           },
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),

                                  //***********************************************/
                                  SizedBox(
                                    height: size.iScreen(1.5),
                                  ),
                                  //*****************************************/
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                            // width: size.wScreen(18.0),

                                            // color: Colors.blue,
                                            child: Text('Cantidad:',
                                                style: GoogleFonts.lexendDeca(
                                                    // fontSize: size.iScreen(2.0),
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.grey)),
                                          ),
                                          Container(
                                            width: size.wScreen(15.0),
                                            child: TextFormField(
                                              initialValue: _estado == 'NUEVO'
                                                  ? "1"
                                                  : controllerHospital
                                                      .getCantidadFluido,

                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: <
                                                  TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .allow(RegExp(r'[0-9]')),
                                              ],
                                              decoration: const InputDecoration(
                                                  // suffixIcon: Icon(Icons.beenhere_outlined)
                                                  ),
                                              textAlign: TextAlign.center,
                                              //  maxLines: 3,
                                              //  minLines: 1,
                                              style: TextStyle(
                                                fontSize: size.iScreen(2.0),
                                                // fontWeight: FontWeight.bold,
                                                // letterSpacing: 2.0,s
                                              ),
                                              onChanged: (text) {
                                                controllerHospital
                                                    .setCantidadFluido(text);
                                                // if(text.isNotEmpty){

                                                // controllerHospital
                                                //     .setInicioAlimento(text);
                                                // }
                                                // else{
                                                // controllerHospital
                                                //     .setInicioAlimento('0');

                                                // }
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
                                      Column(
                                        children: [
                                          Container(
                                            // width: size.wScreen(18.0),

                                            // color: Colors.blue,
                                            child: Text('Inicio ',
                                                style: GoogleFonts.lexendDeca(
                                                    // fontSize: size.iScreen(2.0),
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.grey)),
                                          ),
                                          Container(
                                            width: size.wScreen(15.0),
                                            child: TextFormField(
                                              initialValue: _estado == 'NUEVO'
                                                  ? "0"
                                                  : controllerHospital
                                                      .getInicioFluido,

                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: <
                                                  TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .allow(RegExp(r'[0-9]')),
                                              ],
                                              decoration: const InputDecoration(
                                                  // suffixIcon: Icon(Icons.beenhere_outlined)
                                                  ),
                                              textAlign: TextAlign.center,
                                              //  maxLines: 3,
                                              //  minLines: 1,
                                              style: TextStyle(
                                                fontSize: size.iScreen(2.0),
                                                // fontWeight: FontWeight.bold,
                                                // letterSpacing: 2.0,s
                                              ),
                                              onChanged: (text) {
                                                controllerHospital
                                                    .setInicioFluido(text);
                                                // if(text.isNotEmpty){

                                                // controllerHospital
                                                //     .setInicioAlimento(text);
                                                // }
                                                // else{
                                                // controllerHospital
                                                //     .setInicioAlimento('0');

                                                // }
                                              },
                                              validator: (text) {
                                                if (text!.trim().isNotEmpty) {
                                                  return null;
                                                } else {
                                                  return 'Ingrese Inicio';
                                                }
                                              },
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

                                  // TextButton(
                                  //     onPressed: () {
                                  //       final isValidS = controllerHospital
                                  //           .validateFormAgregaFluido();
                                  //       if (!isValidS) return;
                                  //       if (isValidS) {
                                  //         if (controllerHospital
                                  //                 .getNombreFluido ==
                                  //             '') {
                                  //           FocusScope.of(context).unfocus();
                                  //           NotificatiosnService
                                  //               .showSnackBarDanger(
                                  //                   'Debe agregar Fluido');
                                  //         }
                                  //         if (controllerHospital
                                  //                 .getNombreFluido !=
                                  //             '') {
                                  //           controllerHospital
                                  //               .addCabeceraFluido();
                                  //           Navigator.pop(context);
                                  //         }
                                  //       }
                                  //     },
                                  //     child: Container(
                                  //       decoration: BoxDecoration(
                                  //           color: primaryColor,
                                  //           borderRadius:
                                  //               BorderRadius.circular(5.0)),
                                  //       // color: primaryColor,
                                  //       padding: EdgeInsets.symmetric(
                                  //           vertical: size.iScreen(0.5),
                                  //           horizontal: size.iScreen(0.5)),
                                  //       child: Text('Agregar',
                                  //           style: GoogleFonts.lexendDeca(
                                  //               // fontSize: size.iScreen(2.0),
                                  //               fontWeight: FontWeight.normal,
                                  //               color: Colors.white)),
                                  //     ))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )

                  //  },)

                  ));
        });
  }

//*********************************************ALIMENTOS**********************************************************************//
  Future<bool?> _agregaCabeceraInfusion(
      BuildContext context, Responsive size, String _estado) {
    return showDialog<bool>(
        barrierColor: Colors.black54,
        context: context,
        builder: (context) {
          // final controller = context.read<PropietariosController>();
          final controllerHospital = context.read<HospitalizacionController>();

          return AlertDialog(
              // title: const Text("INGRESE INFUSIÓN"),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(child: Text("INGRESE INFUSIÓN")),
                  IconButton(
                      splashRadius: 25.0,
                      onPressed: () {
                        final isValidS =
                            controllerHospital.validateFormAgregaInfusion();
                        if (!isValidS) return;
                        if (isValidS) {
                          if (controllerHospital.getNombreInfusion == '') {
                            FocusScope.of(context).unfocus();
                            NotificatiosnService.showSnackBarDanger(
                                'Debe agregar Infusión');
                          }
                          if (controllerHospital.getNombreInfusion != '') {
                            controllerHospital.addCabeceraInfusion();
                            Navigator.pop(context);
                          }
                        }
                      },
                      icon: Icon(Icons.save_outlined,
                          size: size.iScreen(3.5), )),
                ],
              ),
              content: Card(
                  color: Colors.transparent,
                  elevation: 0.0,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          // color: Colors.red,
                          width: size.wScreen(100),
                          height: size.hScreen(35.0),

                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Form(
                              key: controllerHospital
                                  .hospitalizacionInfusionFormKey,
                              child: Column(
                                children: [
                                  //***********************************************/
                                  // SizedBox(
                                  //   height: size.iScreen(1.5),
                                  // ),
                                  //*****************************************/
                                  Row(
                                    children: [
                                      Container(
                                        width: size.wScreen(16.0),

                                        // color: Colors.blue,
                                        child: Text('Infusión: ',
                                            style: GoogleFonts.lexendDeca(
                                                // fontSize: size.iScreen(2.0),
                                                fontWeight: FontWeight.normal,
                                                color: Colors.grey)),
                                      ),
                                      Expanded(
                                        child: Container(
                                          // width: size.wScreen(20.0),
                                          child: TextFormField(
                                            initialValue: _estado == 'NUEVO'
                                                ? ""
                                                : controllerHospital
                                                    .getNombreInfusion,
                                            // keyboardType: TextInputType.number,
                                            // inputFormatters: <TextInputFormatter>[
                                            //   FilteringTextInputFormatter.allow(
                                            //       RegExp(r'[0-9.]')),
                                            // ],
                                            decoration: const InputDecoration(
                                                // suffixIcon: Icon(Icons.beenhere_outlined)
                                                ),
                                            textAlign: TextAlign.center,
                                            //  maxLines: 3,
                                            //  minLines: 1,
                                            style: TextStyle(
                                              fontSize: size.iScreen(2.0),
                                              // fontWeight: FontWeight.bold,
                                              // letterSpacing: 2.0,
                                            ),
                                            onChanged: (text) {
                                              controllerHospital
                                                  .setNombreInfusion(text);
                                            },
                                            validator: (text) {
                                              if (text!.trim().isNotEmpty) {
                                                return null;
                                              } else {
                                                return 'Ingrese Infusión';
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  //***********************************************/
                                  SizedBox(
                                    height: size.iScreen(1.5),
                                  ),
                                  //*****************************************/
                                  Row(
                                    children: [
                                      Container(
                                        width: size.wScreen(12.0),

                                        // color: Colors.blue,
                                        child: Text('Dosis : ',
                                            style: GoogleFonts.lexendDeca(
                                                // fontSize: size.iScreen(2.0),
                                                fontWeight: FontWeight.normal,
                                                color: Colors.grey)),
                                      ),
                                      Expanded(
                                        child: Container(
                                          // width: size.wScreen(20.0),
                                          child: TextFormField(
                                            initialValue: _estado == 'NUEVO'
                                                ? ""
                                                : controllerHospital
                                                    .getDosisInfusion,
                                            // keyboardType: TextInputType.number,
                                            // inputFormatters: <TextInputFormatter>[
                                            //   FilteringTextInputFormatter.allow(
                                            //       RegExp(r'[0-9.]')),
                                            // ],
                                            decoration: const InputDecoration(
                                                // suffixIcon: Icon(Icons.beenhere_outlined)
                                                ),
                                            textAlign: TextAlign.center,
                                            //  maxLines: 3,
                                            //  minLines: 1,
                                            style: TextStyle(
                                              fontSize: size.iScreen(2.0),
                                              // fontWeight: FontWeight.bold,
                                              // letterSpacing: 2.0,
                                            ),
                                            onChanged: (text) {
                                              controllerHospital
                                                  .setDosisInfusion(text);
                                            },
                                            validator: (text) {
                                              if (text!.trim().isNotEmpty) {
                                                return null;
                                              } else {
                                                return 'Ingrese la Dosis';
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  // //***********************************************/
                                  // SizedBox(
                                  //   height: size.iScreen(1.5),
                                  // ),
                                  // //*****************************************/
                                  // Row(
                                  //   children: [
                                  //     Container(
                                  //       width: size.wScreen(18.0),

                                  //       // color: Colors.blue,
                                  //       child: Text('Cantidad : ',
                                  //           style: GoogleFonts.lexendDeca(
                                  //               // fontSize: size.iScreen(2.0),
                                  //               fontWeight: FontWeight.normal,
                                  //               color: Colors.grey)),
                                  //     ),
                                  //     Expanded(
                                  //       child: Container(
                                  //         width: size.wScreen(10.0),
                                  //         child: TextFormField(
                                  //           initialValue: _estado == 'NUEVO'
                                  //               ? "1"
                                  //               : controllerHospital
                                  //                   .getCantidadFluido,

                                  //           keyboardType: TextInputType.number,
                                  //           inputFormatters: <
                                  //               TextInputFormatter>[
                                  //             FilteringTextInputFormatter.allow(
                                  //                 RegExp(r'[0-9]')),
                                  //           ],
                                  //           decoration: const InputDecoration(
                                  //               // suffixIcon: Icon(Icons.beenhere_outlined)
                                  //               ),
                                  //           textAlign: TextAlign.center,
                                  //           //  maxLines: 3,
                                  //           //  minLines: 1,
                                  //           style: TextStyle(
                                  //             fontSize: size.iScreen(2.0),
                                  //             // fontWeight: FontWeight.bold,
                                  //             // letterSpacing: 2.0,s
                                  //           ),
                                  //           onChanged: (text) {
                                  //             controllerHospital
                                  //                 .setCantidadFluido(text);
                                  //           },
                                  //           validator: (text) {
                                  //             if (text!.trim().isNotEmpty) {
                                  //               return null;
                                  //             } else {
                                  //               return 'Ingrese Cantidad';
                                  //             }
                                  //           },
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),

                                  // //***********************************************/
                                  // SizedBox(
                                  //   height: size.iScreen(1.5),
                                  // ),
                                  // //*****************************************/
                                  // Row(
                                  //   mainAxisAlignment:
                                  //       MainAxisAlignment.spaceAround,
                                  //   children: [
                                  //     Column(
                                  //       children: [
                                  //         Container(
                                  //           // width: size.wScreen(18.0),

                                  //           // color: Colors.blue,
                                  //           child: Text('Cantidad ',
                                  //               style: GoogleFonts.lexendDeca(
                                  //                   // fontSize: size.iScreen(2.0),
                                  //                   fontWeight:
                                  //                       FontWeight.normal,
                                  //                   color: Colors.grey)),
                                  //         ),
                                  //         Container(
                                  //           width: size.wScreen(15.0),
                                  //           child: TextFormField(
                                  //             initialValue: _estado == 'NUEVO'
                                  //                 ? "1"
                                  //                 : controllerHospital
                                  //                     .getCantidadFluido,

                                  //             keyboardType:
                                  //                 TextInputType.number,
                                  //             inputFormatters: <
                                  //                 TextInputFormatter>[
                                  //               FilteringTextInputFormatter
                                  //                   .allow(RegExp(r'[0-9]')),
                                  //             ],
                                  //             decoration: const InputDecoration(
                                  //                 // suffixIcon: Icon(Icons.beenhere_outlined)
                                  //                 ),
                                  //             textAlign: TextAlign.center,
                                  //             //  maxLines: 3,
                                  //             //  minLines: 1,
                                  //             style: TextStyle(
                                  //               fontSize: size.iScreen(2.0),
                                  //               // fontWeight: FontWeight.bold,
                                  //               // letterSpacing: 2.0,s
                                  //             ),
                                  //             onChanged: (text) {
                                  //               controllerHospital
                                  //                   .setCantidadFluido(text);
                                  //               // if(text.isNotEmpty){

                                  //               // controllerHospital
                                  //               //     .setInicioAlimento(text);
                                  //               // }
                                  //               // else{
                                  //               // controllerHospital
                                  //               //     .setInicioAlimento('0');

                                  //               // }
                                  //             },
                                  //             validator: (text) {
                                  //               if (text!.trim().isNotEmpty) {
                                  //                 return null;
                                  //               } else {
                                  //                 return 'Ingrese Cantidad';
                                  //               }
                                  //             },
                                  //           ),
                                  //         ),
                                  //       ],
                                  //     ),

                                  //     Column(
                                  //       children: [
                                  //         Container(
                                  //           // width: size.wScreen(18.0),

                                  //           // color: Colors.blue,
                                  //           child: Text('Inicio ',
                                  //               style: GoogleFonts.lexendDeca(
                                  //                   // fontSize: size.iScreen(2.0),
                                  //                   fontWeight:
                                  //                       FontWeight.normal,
                                  //                   color: Colors.grey)),
                                  //         ),
                                  //         Container(
                                  //           width: size.wScreen(15.0),
                                  //           child: TextFormField(
                                  //             initialValue: _estado == 'NUEVO'
                                  //                 ? "0"
                                  //                 : controllerHospital
                                  //                     .getInicioFluido,

                                  //             keyboardType:
                                  //                 TextInputType.number,
                                  //             inputFormatters: <
                                  //                 TextInputFormatter>[
                                  //               FilteringTextInputFormatter
                                  //                   .allow(RegExp(r'[0-9]')),
                                  //             ],
                                  //             decoration: const InputDecoration(
                                  //                 // suffixIcon: Icon(Icons.beenhere_outlined)
                                  //                 ),
                                  //             textAlign: TextAlign.center,
                                  //             //  maxLines: 3,
                                  //             //  minLines: 1,
                                  //             style: TextStyle(
                                  //               fontSize: size.iScreen(2.0),
                                  //               // fontWeight: FontWeight.bold,
                                  //               // letterSpacing: 2.0,s
                                  //             ),
                                  //             onChanged: (text) {
                                  //               controllerHospital
                                  //                   .setInicioFluido(text);
                                  //               // if(text.isNotEmpty){

                                  //               // controllerHospital
                                  //               //     .setInicioAlimento(text);
                                  //               // }
                                  //               // else{
                                  //               // controllerHospital
                                  //               //     .setInicioAlimento('0');

                                  //               // }
                                  //             },
                                  //             validator: (text) {
                                  //               if (text!.trim().isNotEmpty) {
                                  //                 return null;
                                  //               } else {
                                  //                 return 'Ingrese Inicio';
                                  //               }
                                  //             },
                                  //           ),
                                  //         ),
                                  //       ],
                                  //     ),

                                  //   ],
                                  // ),
                                  //***********************************************/
                                  SizedBox(
                                    height: size.iScreen(1.5),
                                  ),
                                  //*****************************************/
                                  Row(
                                    children: [
                                      Container(
                                        width: size.wScreen(14.0),

                                        // color: Colors.blue,
                                        child: Text('Unidad:',
                                            style: GoogleFonts.lexendDeca(
                                                // fontSize: size.iScreen(2.0),
                                                fontWeight: FontWeight.normal,
                                                color: Colors.grey)),
                                      ),
                                      Expanded(
                                        child: Container(
                                          // width: size.wScreen(20.0),
                                          child: TextFormField(
                                            initialValue: _estado == 'NUEVO'
                                                ? ""
                                                : controllerHospital
                                                    .getUnidadInfusion,
                                            // keyboardType: TextInputType.number,
                                            // inputFormatters: <TextInputFormatter>[
                                            //   FilteringTextInputFormatter.allow(
                                            //       RegExp(r'[0-9.]')),
                                            // ],
                                            decoration: const InputDecoration(
                                                // suffixIcon: Icon(Icons.beenhere_outlined)
                                                ),
                                            textAlign: TextAlign.center,
                                            //  maxLines: 3,
                                            //  minLines: 1,
                                            style: TextStyle(
                                              fontSize: size.iScreen(2.0),
                                              // fontWeight: FontWeight.bold,
                                              // letterSpacing: 2.0,
                                            ),
                                            onChanged: (text) {
                                              controllerHospital
                                                  .setUnidadInfusion(text);
                                            },
                                            validator: (text) {
                                              if (text!.trim().isNotEmpty) {
                                                return null;
                                              } else {
                                                return 'Ingrese la unidad';
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  //***********************************************/
                                  SizedBox(
                                    height: size.iScreen(1.5),
                                  ),
                                  //*****************************************/

                                  // TextButton(
                                  //     onPressed: () {
                                  //       final isValidS = controllerHospital
                                  //           .validateFormAgregaInfusion();
                                  //       if (!isValidS) return;
                                  //       if (isValidS) {
                                  //         if (controllerHospital
                                  //                 .getNombreInfusion ==
                                  //             '') {
                                  //           FocusScope.of(context).unfocus();
                                  //           NotificatiosnService
                                  //               .showSnackBarDanger(
                                  //                   'Debe agregar Infusión');
                                  //         }
                                  //         if (controllerHospital
                                  //                 .getNombreInfusion !=
                                  //             '') {
                                  //           controllerHospital
                                  //               .addCabeceraInfusion();
                                  //           Navigator.pop(context);
                                  //         }
                                  //       }
                                  //     },
                                  //     child: Container(
                                  //       decoration: BoxDecoration(
                                  //           color: primaryColor,
                                  //           borderRadius:
                                  //               BorderRadius.circular(5.0)),
                                  //       // color: primaryColor,
                                  //       padding: EdgeInsets.symmetric(
                                  //           vertical: size.iScreen(0.5),
                                  //           horizontal: size.iScreen(0.5)),
                                  //       child: Text('Agregar',
                                  //           style: GoogleFonts.lexendDeca(
                                  //               // fontSize: size.iScreen(2.0),
                                  //               fontWeight: FontWeight.normal,
                                  //               color: Colors.white)),
                                  //     ))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )

                  //  },)

                  ));
        });
  }

//*********************************************ALIMENTOS**********************************************************************//
  Future<bool?> _agregaCabeceraParametros(
      BuildContext context, Responsive size, String _estado) {
    return showDialog<bool>(
        barrierColor: Colors.black54,
        context: context,
        builder: (context) {
          // final controller = context.read<PropietariosController>();
          final controllerHosp = context.read<HospitalizacionController>();
          _dosisParametro.text = '';

          return AlertDialog(
              // title: const Text("INGRESE PARÁMETRO"),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(child: Text("INGRESE PARÁMETRO")),
                  IconButton(
                      splashRadius: 25.0,
                      onPressed: () {
                        final isValidS =
                            controllerHosp.validateFormAgregaParametro();
                        if (!isValidS) return;
                        if (isValidS) {
                          if (controllerHosp.getNombreParametro == '') {
                            FocusScope.of(context).unfocus();
                            NotificatiosnService.showSnackBarDanger(
                                'Debe seleccionar Parametro');
                          }
                          if (controllerHosp.getNombreParametro != '') {
                            controllerHosp.addCabeceraParametro();
                            Navigator.pop(context);
                          }
                        }
                      },
                      icon: Icon(Icons.save_outlined,
                          size: size.iScreen(3.5), )),
                ],
              ),
              content: Card(
                  color: Colors.transparent,
                  elevation: 0.0,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          // color: Colors.red,
                          width: size.wScreen(100),
                          height: size.hScreen(35.0),

                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Form(
                              key: controllerHosp
                                  .hospitalizacionParametroFormKey,
                              child: Column(
                                children: [
                                  //***********************************************/
                                  // SizedBox(
                                  //   height: size.iScreen(1.5),
                                  // ),
                                  //*****************************************/
                                  //       //***********************************************/
                                  // SizedBox(
                                  //   height: size.iScreen(1.5),
                                  // ),
                                  // //*****************************************/
                                  Consumer<HospitalizacionController>(
                                    builder: (_, valuefechaParametro, __) {
                                      return Row(
                                        children: [
                                          Text(
                                            'Fecha: ',
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
                                              _fechaHoraParametros(
                                                  context, valuefechaParametro);
                                            },
                                            child: Row(
                                              children: [
                                                Text(
                                                  valuefechaParametro
                                                          .getFechaHoraParametros ??
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
                                      );
                                    },
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
                                        // child: GestureDetector(
                                        //   onTap: (){
                                        //         final controllerData=  context.read<HospitalizacionController>();
                                        //     setState(() {
                                        //         _dosisParametro.text=controllerData.getDosisParametro;

                                        //     });
                                        //     print('object${controllerData.getDosisParametro}');

                                        //   },
                                        child: Text('Parámetro ',
                                            style: GoogleFonts.lexendDeca(
                                                // fontSize: size.iScreen(2.0),
                                                fontWeight: FontWeight.normal,
                                                color: Colors.grey)),
                                      ),
                                      // ),
                                      SizedBox(
                                        width: size.iScreen(2.0),
                                      ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: GestureDetector(
                                          onTap: () {
                                            context
                                                .read<
                                                    HospitalizacionController>()
                                                .buscaAllParametros('');

                                            _buscarParametro(context, size);

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
                                  Consumer<HospitalizacionController>(
                                    builder: (_, valueParametro, __) {
                                      return SizedBox(
                                        width: size.wScreen(100.0),

                                        // color: Colors.blue,
                                        child: Text(
                                            valueParametro.getNombreParametro ==
                                                    ''
                                                ? 'DEBE AGREGAR PARÁMETRO '
                                                : '${valueParametro.getNombreParametro}',
                                            style: GoogleFonts.lexendDeca(
                                                // fontSize: size.iScreen(2.0),
                                                fontWeight: FontWeight.normal,
                                                color: valueParametro
                                                            .getNombreParametro ==
                                                        ''
                                                    ? Colors.grey
                                                    : Colors.black)),
                                      );
                                    },
                                  ),
                                  //***********************************************/
                                  // SizedBox(
                                  //   height: size.iScreen(1.5),
                                  // ),
                                  // //*****************************************/
                                  // Row(
                                  //   children: [
                                  //     Container(
                                  //       width: size.wScreen(16.0),

                                  //       // color: Colors.blue,
                                  //       child: Text('Parámetro: ',
                                  //           style: GoogleFonts.lexendDeca(
                                  //               // fontSize: size.iScreen(2.0),
                                  //               fontWeight: FontWeight.normal,
                                  //               color: Colors.grey)),
                                  //     ),
                                  //     Expanded(
                                  //       child: Container(
                                  //         // width: size.wScreen(20.0),
                                  //         child: TextFormField(
                                  //           initialValue: _estado == 'NUEVO'
                                  //               ? ""
                                  //               : controllerHosp
                                  //                   .getNombreParametro,
                                  //           // keyboardType: TextInputType.number,
                                  //           // inputFormatters: <TextInputFormatter>[
                                  //           //   FilteringTextInputFormatter.allow(
                                  //           //       RegExp(r'[0-9.]')),
                                  //           // ],
                                  //           decoration: const InputDecoration(
                                  //               // suffixIcon: Icon(Icons.beenhere_outlined)
                                  //               ),
                                  //           textAlign: TextAlign.center,
                                  //           //  maxLines: 3,
                                  //           //  minLines: 1,
                                  //           style: TextStyle(
                                  //             fontSize: size.iScreen(2.0),
                                  //             // fontWeight: FontWeight.bold,
                                  //             // letterSpacing: 2.0,
                                  //           ),
                                  //           onChanged: (text) {
                                  //             controllerHosp
                                  //                 .setNombreParametro(text);
                                  //           },
                                  //           validator: (text) {
                                  //             if (text!.trim().isNotEmpty) {
                                  //               return null;
                                  //             } else {
                                  //               return 'Ingrese Parámetro';
                                  //             }
                                  //           },
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  //***********************************************/
                                  SizedBox(
                                    height: size.iScreen(1.5),
                                  ),
                                  //*****************************************/
                                  Row(
                                    children: [
                                      Container(
                                        width: size.wScreen(12.0),

                                        // color: Colors.blue,
                                        child: Text('Dosis : ',
                                            style: GoogleFonts.lexendDeca(
                                                // fontSize: size.iScreen(2.0),
                                                fontWeight: FontWeight.normal,
                                                color: Colors.grey)),
                                      ),
                                      // Consumer<HospitalizacionController>(
                                      //   builder: (_, valueDosisParm,
                                      //      __) {
                                      //         _dosisParametro.text=valueDosisParm.getDosisParametro;

                                      //     return Text('');

                                      //   },
                                      // ),
                                      Expanded(
                                        child: Container(
                                          // width: size.wScreen(20.0),
                                          child: TextFormField(
                                            controller: _dosisParametro,
                                            // initialValue: _estado == 'NUEVO'
                                            //     ? ""
                                            //     : controllerHosp
                                            //         .getDosisParametro,
                                            // keyboardType: TextInputType.number,
                                            // inputFormatters: <TextInputFormatter>[
                                            //   FilteringTextInputFormatter.allow(
                                            //       RegExp(r'[0-9.]')),
                                            // ],
                                            decoration: const InputDecoration(
                                                // suffixIcon: Icon(Icons.beenhere_outlined)
                                                ),
                                            textAlign: TextAlign.center,
                                            //  maxLines: 3,
                                            //  minLines: 1,
                                            style: TextStyle(
                                              fontSize: size.iScreen(2.0),
                                              // fontWeight: FontWeight.bold,
                                              // letterSpacing: 2.0,
                                            ),
                                            onChanged: (text) {
                                              controllerHosp
                                                  .setDosisParametro(text);
                                            },
                                            validator: (text) {
                                              if (text!.trim().isNotEmpty) {
                                                return null;
                                              } else {
                                                return 'Ingrese la Dosis';
                                              }
                                            },
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  // //***********************************************/
                                  // SizedBox(
                                  //   height: size.iScreen(1.5),
                                  // ),
                                  // //*****************************************/
                                  // Row(
                                  //   children: [
                                  //     Container(
                                  //       width: size.wScreen(18.0),

                                  //       // color: Colors.blue,
                                  //       child: Text('Cantidad : ',
                                  //           style: GoogleFonts.lexendDeca(
                                  //               // fontSize: size.iScreen(2.0),
                                  //               fontWeight: FontWeight.normal,
                                  //               color: Colors.grey)),
                                  //     ),
                                  //     Expanded(
                                  //       child: Container(
                                  //         width: size.wScreen(10.0),
                                  //         child: TextFormField(
                                  //           initialValue: _estado == 'NUEVO'
                                  //               ? "1"
                                  //               : controllerHosp
                                  //                   .getCantidadAlimento,

                                  //           keyboardType: TextInputType.number,
                                  //           inputFormatters: <
                                  //               TextInputFormatter>[
                                  //             FilteringTextInputFormatter.allow(
                                  //                 RegExp(r'[0-9]')),
                                  //           ],
                                  //           decoration: const InputDecoration(
                                  //               // suffixIcon: Icon(Icons.beenhere_outlined)
                                  //               ),
                                  //           textAlign: TextAlign.center,
                                  //           //  maxLines: 3,
                                  //           //  minLines: 1,
                                  //           style: TextStyle(
                                  //             fontSize: size.iScreen(2.0),
                                  //             // fontWeight: FontWeight.bold,
                                  //             // letterSpacing: 2.0,s
                                  //           ),
                                  //           onChanged: (text) {
                                  //             controllerHosp
                                  //                 .setCantidadAlimento(text);
                                  //           },
                                  //           validator: (text) {
                                  //             if (text!.trim().isNotEmpty) {
                                  //               return null;
                                  //             } else {
                                  //               return 'Ingrese Cantidad';
                                  //             }
                                  //           },
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  // //***********************************************/
                                  // SizedBox(
                                  //   height: size.iScreen(1.5),
                                  // ),
                                  // //*****************************************/
                                  // Row(
                                  //   children: [
                                  //     Container(
                                  //       width: size.wScreen(12.0),

                                  //       // color: Colors.blue,
                                  //       child: Text('Vía : ',
                                  //           style: GoogleFonts.lexendDeca(
                                  //               // fontSize: size.iScreen(2.0),
                                  //               fontWeight: FontWeight.normal,
                                  //               color: Colors.grey)),
                                  //     ),
                                  //     Expanded(
                                  //       child: Container(
                                  //         // width: size.wScreen(20.0),
                                  //         child: TextFormField(
                                  //           initialValue: _estado == 'NUEVO'
                                  //               ? ""
                                  //               : controllerHosp.getViaAlimento,
                                  //           //     ? ''
                                  //           //     : controllerHospitalizacion.getExamenesComplementarios,
                                  //           // keyboardType: TextInputType.number,
                                  //           // inputFormatters: <TextInputFormatter>[
                                  //           //   FilteringTextInputFormatter.allow(
                                  //           //       RegExp(r'[0-9.]')),
                                  //           // ],
                                  //           decoration: const InputDecoration(
                                  //               // suffixIcon: Icon(Icons.beenhere_outlined)
                                  //               ),
                                  //           textAlign: TextAlign.center,
                                  //           //  maxLines: 3,
                                  //           //  minLines: 1,
                                  //           style: TextStyle(
                                  //             fontSize: size.iScreen(2.0),
                                  //             // fontWeight: FontWeight.bold,
                                  //             // letterSpacing: 2.0,
                                  //           ),
                                  //           onChanged: (text) {
                                  //             controllerHosp
                                  //                 .setViaAlimento(text);
                                  //           },
                                  //           validator: (text) {
                                  //             if (text!.trim().isNotEmpty) {
                                  //               return null;
                                  //             } else {
                                  //               return 'Ingrese Vía';
                                  //             }
                                  //           },
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),

                                  //***********************************************/
                                  SizedBox(
                                    height: size.iScreen(1.5),
                                  ),
                                  //*****************************************/
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                            // width: size.wScreen(18.0),

                                            // color: Colors.blue,
                                            child: Text('Inicio ',
                                                style: GoogleFonts.lexendDeca(
                                                    // fontSize: size.iScreen(2.0),
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.grey)),
                                          ),
                                          Container(
                                            width: size.wScreen(15.0),
                                            child: TextFormField(
                                              initialValue: _estado == 'NUEVO'
                                                  ? "0"
                                                  : controllerHosp
                                                      .getInicioParametro,

                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: <
                                                  TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .allow(RegExp(r'[0-9]')),
                                              ],
                                              decoration: const InputDecoration(
                                                  // suffixIcon: Icon(Icons.beenhere_outlined)
                                                  ),
                                              textAlign: TextAlign.center,
                                              //  maxLines: 3,
                                              //  minLines: 1,
                                              style: TextStyle(
                                                fontSize: size.iScreen(2.0),
                                                // fontWeight: FontWeight.bold,
                                                // letterSpacing: 2.0,s
                                              ),
                                              onChanged: (text) {
                                                controllerHosp
                                                    .setInicioParametro(text);
                                                // if(text.isNotEmpty){

                                                // controllerHosp
                                                //     .setInicioParametro(text);
                                                // }
                                                // else{
                                                // controllerHosp
                                                //     .setInicioParametro('0');

                                                // }
                                              },
                                              validator: (text) {
                                                if (text!.trim().isNotEmpty) {
                                                  return null;
                                                } else {
                                                  return 'Ingrese Inicio';
                                                }
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                            // width: size.wScreen(18.0),

                                            // color: Colors.blue,
                                            child: Text('Frecuencia ',
                                                style: GoogleFonts.lexendDeca(
                                                    // fontSize: size.iScreen(2.0),
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.grey)),
                                          ),
                                          Container(
                                            width: size.wScreen(15.0),
                                            child: TextFormField(
                                              initialValue: _estado == 'NUEVO'
                                                  ? "1"
                                                  : controllerHosp
                                                      .getFrecuenciaParametro,
                                              //     ? ''
                                              //     : controllerHosp.getExamenesComplementarios,
                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: <
                                                  TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .allow(RegExp(r'[0-9]')),
                                              ],
                                              decoration: const InputDecoration(
                                                  // suffixIcon: Icon(Icons.beenhere_outlined)
                                                  ),
                                              textAlign: TextAlign.center,
                                              //  maxLines: 3,
                                              //  minLines: 1,
                                              style: TextStyle(
                                                fontSize: size.iScreen(2.0),
                                                // fontWeight: FontWeight.bold,
                                                // letterSpacing: 2.0,s
                                              ),
                                              onChanged: (text) {
                                                controllerHosp
                                                    .setFrecuenciaParametro(
                                                        text);
                                                //  if(text.isNotEmpty){
                                                // }
                                                // else{
                                                //   controllerHosp
                                                //     .setFrecuenciaMedicina('1');
                                                // }
                                              },
                                              validator: (text) {
                                                if (text!.trim().isNotEmpty) {
                                                  return null;
                                                } else {
                                                  return 'Ingrese Frecuencia';
                                                }
                                              },
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

                                  // TextButton(
                                  //     onPressed: () {
                                  //       final isValidS = controllerHosp
                                  //           .validateFormAgregaParametro();
                                  //       if (!isValidS) return;
                                  //       if (isValidS) {
                                  //         if (controllerHosp
                                  //                 .getNombreParametro ==
                                  //             '') {
                                  //           FocusScope.of(context).unfocus();
                                  //           NotificatiosnService
                                  //               .showSnackBarDanger(
                                  //                   'Debe seleccionar Parametro');
                                  //         }
                                  //         if (controllerHosp
                                  //                 .getNombreParametro !=
                                  //             '') {
                                  //           controllerHosp
                                  //               .addCabeceraParametro();
                                  //           Navigator.pop(context);
                                  //         }
                                  //       }
                                  //     },
                                  //     child: Container(
                                  //       decoration: BoxDecoration(
                                  //           color: primaryColor,
                                  //           borderRadius:
                                  //               BorderRadius.circular(5.0)),
                                  //       // color: primaryColor,
                                  //       padding: EdgeInsets.symmetric(
                                  //           vertical: size.iScreen(0.5),
                                  //           horizontal: size.iScreen(0.5)),
                                  //       child: Text('Agregar',
                                  //           style: GoogleFonts.lexendDeca(
                                  //               // fontSize: size.iScreen(2.0),
                                  //               fontWeight: FontWeight.normal,
                                  //               color: Colors.white)),
                                  //     ))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )

                  //  },)

                  ));
        });
  }
}

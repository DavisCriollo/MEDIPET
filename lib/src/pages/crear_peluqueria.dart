

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neitorcont/src/controllers/mascotas_controller.dart';
import 'package:neitorcont/src/controllers/peluqueria_controller.dart';
import 'package:neitorcont/src/controllers/recetas_controller.dart';
import 'package:neitorcont/src/services/notifications_service.dart';
import 'package:neitorcont/src/services/socket_service.dart';
import 'package:neitorcont/src/theme/themes_app.dart';
import 'package:neitorcont/src/utils/letras_mayusculas_minusculas.dart';

import 'package:neitorcont/src/utils/responsive.dart';
import 'package:neitorcont/src/utils/theme.dart';
import 'package:neitorcont/src/widgets/no_data.dart';
import 'package:provider/provider.dart';

class CreaPeluqueria extends StatefulWidget {
  final String? tipo;
  const CreaPeluqueria({Key? key, this.tipo}) : super(key: key);

  @override
  State<CreaPeluqueria> createState() => _CreaPeluqueriaState();
}

enum Llamar { si, no }
enum Declaro { si, no }
enum Oidos { si, no }
enum LavadoDientes { si, no }
enum UniasDedos { si, no }
enum Drenaje{ si, no }
enum Secado{ si, no }
enum Perfume{ si, no }
enum LimpiezaOcular{ si, no }
enum CorteUnias{ si, no }
enum RapadoGenital{ si, no }
enum Banio{ si, no }
enum CorteYAcabados{ si, no }
enum LazoCentral{ si, no }
enum Bufanda{ si, no }
enum DosLazos{ si, no }
enum Panuelo{ si, no }
enum RetiraMacota{ si, no }
enum DejaCarnet{ si, no }
enum PresenciaPropietario{ si, no }

class _CreaPeluqueriaState extends State<CreaPeluqueria> {
  late TimeOfDay timeFecha;
  late TimeOfDay timeIngreso;
  late TimeOfDay timeSalida;
  late TimeOfDay timeCita;
  @override
  void initState() {
    timeFecha = TimeOfDay.now();
    timeIngreso = TimeOfDay.now();
    timeSalida = TimeOfDay.now();
    timeCita = TimeOfDay.now();
    super.initState();
  }

  Llamar _llamar = Llamar.si;
  Declaro _declaro = Declaro.no;
  Oidos _oidos = Oidos.no;
  LavadoDientes _lavadoDientes = LavadoDientes.no;
  UniasDedos _uniasDedos = UniasDedos.no;
  Drenaje _drenaje = Drenaje.no;
  Secado _secado = Secado.no;
  Perfume _perfume = Perfume.no;
  LimpiezaOcular _limpiezaOcular = LimpiezaOcular.no;
  CorteUnias _corteUnias = CorteUnias.no;
  RapadoGenital _rapadoGenital = RapadoGenital.no;
  Banio _banio = Banio.no;
  CorteYAcabados _corteYAcabados = CorteYAcabados.no;
  LazoCentral _lazoCentral = LazoCentral.no;
  Bufanda _bufanda = Bufanda.no;
  DosLazos _dosLazos = DosLazos.no;
  Panuelo _panuelo = Panuelo.no;
  RetiraMacota _retiraMacota = RetiraMacota.no;
  DejaCarnet _dejaCarnet = DejaCarnet.no;
  PresenciaPropietario _presenciaPropietario = PresenciaPropietario.no;



  @override
  Widget build(BuildContext context) {
    // final _action = ModalRoute.of(context)!.settings.arguments;
    final Responsive size = Responsive.of(context);
    final controllerPeluqueria = context.read<PeluqueriaController>();
   

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          appBar: AppBar(
            title: widget.tipo == 'CREATE' || widget.tipo == 'SEARCH'
                ?  Text('Crear Peluquería',style:  Theme.of(context).textTheme.headline2,)
                :  Text('Editar Peluquería',style:  Theme.of(context).textTheme.headline2,),
            actions: [
              Consumer<SocketService>(builder: (_, valueConexion, __) {
                return valueConexion.serverStatus == ServerStatus.Online
                    ? Container(
                        margin: EdgeInsets.only(right: size.iScreen(1.5)),
                        child: IconButton(
                            splashRadius: 28,
                            onPressed: () {
                              _onSubmit(context, controllerPeluqueria,
                                  widget.tipo.toString());
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
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: controllerPeluqueria.peluqueriaFormKey,
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
                            child:  Consumer<AppTheme>(builder: (_, valueTheme, __) {  
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
                    Consumer<PeluqueriaController>(
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
                                  color: valueMascota.getNombreMascota!.isEmpty
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
                        SizedBox(
                          // width: size.wScreen(100.0),

                          // color: Colors.blue,
                          child: Text('Tempermento ',
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
                              // context
                              //     .read<MascotasController>()
                              //     .buscaAllMascotas('');

                              // // _buscarMascota(context, size);
                              // _buscarMascota(context, size);
                              _buscarTemperamento(context, size);

                              //*******************************************/
                            },
                            child: 
                            
                             Consumer<AppTheme>(builder: (_, valueTheme, __) {  
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
                                          Icons.arrow_drop_down,
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
                    Consumer<PeluqueriaController>(
                      builder: (_, valueTemperamento, __) {
                        return SizedBox(
                          width: size.wScreen(100.0),

                          // color: Colors.blue,
                          child: Text(
                              valueTemperamento.getTemperamentoMascota!.isEmpty
                                  ? 'DEBE AGREGAR TEMPERAMENTO '
                                  : '${valueTemperamento.getTemperamentoMascota}',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: valueTemperamento
                                          .getTemperamentoMascota!.isEmpty
                                      ? Colors.grey
                                      : Colors.black)),
                        );
                      },
                    ),
                    //***********************************************//

                    //***********************************************/
                    SizedBox(
                      height: size.iScreen(1.5),
                    ),
                    //*****************************************/
                    Container(
                      width: size.wScreen(100.0),

                      // color: Colors.blue,
                      child: Text('Autorizado por:',
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
                            : controllerPeluqueria.getAutorizadoPor,

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
                          controllerPeluqueria.setAutorizadoPor(text);
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
                            child: Text('Mvz. Responsable ',
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
                    Consumer<PeluqueriaController>(
                      builder: (_, valueDoctor, __) {
                        return SizedBox(
                          width: size.wScreen(100.0),

                          // color: Colors.blue,
                          child: Text(
                              valueDoctor.getVetDoctorNombre!.isEmpty
                                  ? 'DEBE SELECCIONAR VERETINARIO '
                                  : '${valueDoctor.getVetDoctorNombre} ',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: valueDoctor.getVetDoctorNombre!.isEmpty
                                      ? Colors.grey
                                      : Colors.black)),
                        );
                      },
                    ),
                    //*****************************************/
                    SizedBox(
                      height: size.iScreen(2.0),
                    ),
                    //*****************************************/

                    Consumer<PeluqueriaController>(
                      builder: (_, valuFechas, __) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Fecha : ',
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
                                    _fecha(context, valuFechas);
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                              
                                         valuFechas.getFecha!=""? valuFechas.getFecha:'${DateTime.now().year}-${(DateTime.now().month) < 10 ? '0${DateTime.now().month}' : '${DateTime.now().month}'}-${(DateTime.now().day) < 10 ? '0${DateTime.now().day}' : '${DateTime.now().day}'}',
                                        style: GoogleFonts.lexendDeca(
                                          fontSize: size.iScreen(1.8),
                                          color: Colors.black45,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        width: size.iScreen(0.5),
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
                            //*****************************************/
                            SizedBox(
                              height: size.iScreen(1.5),
                            ),
                            //*****************************************/

                            Row(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Turno : ',
                                      style: GoogleFonts.lexendDeca(
                                        // fontSize: size.iScreen(1.8),
                                        color: Colors.black45,
                                        // fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    //*****************************************/
                                    SizedBox(
                                      width: size.iScreen(1.0),
                                    ),
                                    //*****************************************/
                                    Container(
                                      width: size.wScreen(15.0),
                                      child: TextFormField(
                                        // maxLength: 2,
                                        initialValue: widget.tipo == 'CREATE'
                                            ? ''
                                            : valuFechas.getTurno,
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
                                          valuFechas.setTurno(text);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      'Hora Ingreso',
                                      style: GoogleFonts.lexendDeca(
                                        // fontSize: size.iScreen(1.8),
                                        color: Colors.black45,
                                        // fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      width: size.iScreen(1.0),
                                    ),
                                    Container(
                                      width: size.wScreen(23.0),
                                      margin: EdgeInsets.symmetric(
                                          horizontal: size.wScreen(3.5)),
                                      child: Row(
                                        children: [
                                          Consumer<PeluqueriaController>(
                                            builder: (_, valueHoraIngreso, __) {
                                              return Text(
                                                valueHoraIngreso
                                                            .getInputHoraIngreso !=
                                                        ''
                                                    ? valueHoraIngreso
                                                        .getInputHoraIngreso
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
                                              _seleccionaHoraIngreso(context,
                                                  controllerPeluqueria);
                                            },
                                            icon: const Icon(
                                              Icons.access_time_outlined,
                                              // color: primaryColor,
                                              size: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      'Hora Salida',
                                      style: GoogleFonts.lexendDeca(
                                        // fontSize: size.iScreen(1.8),
                                        color: Colors.black45,
                                        // fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      width: size.iScreen(1.0),
                                    ),
                                    Container(
                                      width: size.wScreen(23.0),
                                      margin: EdgeInsets.symmetric(
                                          horizontal: size.wScreen(3.5)),
                                      child: Row(
                                        children: [
                                          Consumer<PeluqueriaController>(
                                            builder: (_, valueHoraSalida, __) {
                                              return Text(
                                                valueHoraSalida
                                                            .getInputHoraSalida !=
                                                        ''
                                                    ? valueHoraSalida
                                                        .getInputHoraSalida
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
                                              _seleccionaHoraSalida(context,
                                                  controllerPeluqueria);
                                            },
                                            icon: const Icon(
                                              Icons.access_time_outlined,
                                              // color: primaryColor,
                                              size: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            //*****************************************/
                            SizedBox(
                              height: size.iScreen(1.0),
                            ),
                            //*****************************************/
                          ],
                        );
                      },
                    ),

                    //***********************************************/
                    SizedBox(
                      height: size.iScreen(0.0),
                    ),
                    //*****************************************/
                    Row(
                      children: [
                        SizedBox(
                          // width: size.wScreen(100.0),

                          // color: Colors.blue,
                          child: Text('Estado',
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
                              // context
                              //     .read<MascotasController>()
                              //     .buscaAllMascotas('');

                              // // _buscarMascota(context, size);
                              // _buscarMascota(context, size);
                              _buscarEstado(context, size);

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
                    Consumer<PeluqueriaController>(
                      builder: (_, valueEstado, __) {
                        return SizedBox(
                          width: size.wScreen(100.0),

                          // color: Colors.blue,
                          child: Text(
                              valueEstado.getEstadoCabello!.isEmpty
                                  ? 'DEBE AGREGAR ESTADO '
                                  : '${valueEstado.getEstadoCabello}',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: valueEstado.getEstadoCabello!.isEmpty
                                      ? Colors.grey
                                      : Colors.black)),
                        );
                      },
                    ),
                    //***********************************************//

                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/

                    Consumer<PeluqueriaController>(
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
                                  _fechaProximaCita(
                                      context, controllerPeluqueria);
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      valueFecha.getInputfechaProximaCita ??
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
                              Container(
                                // width: size.wScreen(40.0),
                                margin: EdgeInsets.symmetric(
                                    horizontal: size.wScreen(3.5)),
                                child: Row(
                                  children: [
                                    Consumer<PeluqueriaController>(
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
                    //***********************************************//

                    SizedBox(
                      height: size.iScreen(0.5),
                    ),
                    //*****************************************/
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Llamar 30 minuots antes : ',
                          style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(1.8),
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        //*****************************************/
                        // SizedBox(
                        //   width: size.iScreen(1.0),
                        // ),
                        //*****************************************/
                        Container(
                          // width: size.wScreen(20.0),
                          child: Row(
                            children: [
                              Container(
                                  // color: Colors.red,
                                  width: size.wScreen(10.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text('Si'),
                                      Radio<Llamar?>(
                                        visualDensity: VisualDensity.compact,
                                        // activeColor: primaryColor,
                                        value: Llamar.si,
                                        groupValue: _llamar,
                                        onChanged: (Llamar? value) {
                                          setState(() {
                                            _llamar = value!;
                                              controllerPeluqueria.setProcesoLlamar('SI');
                                          });
                                        },
                                      ),
                                    ],
                                  )

                                  ),
                              Container(
                                  // color: Colors.green,
                                  width: size.wScreen(10.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text('No'),
                                      Radio<Llamar?>(
                                        visualDensity: VisualDensity.compact,
                                        // activeColor: primaryColor,
                                        value: Llamar.no,
                                        groupValue: _llamar,
                                        onChanged: (Llamar? value) {
                                          setState(() {
                                            _llamar = value!;

                                            controllerPeluqueria.setProcesoLlamar('NO');



                                          });
                                        },
                                      ),
                                    ],
                                  )),
                              
                            ],
                          ),
                        ),
                      ],
                    ),

                    //***********************************************/
                    SizedBox(
                      height: size.iScreen(1.5),
                    ),
                    //*****************************************/
                    SizedBox(
                      width: size.wScreen(100.0),

                      // color: Colors.blue,
                      child: Text('Observaciones al ingreso de la mascota',
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: Colors.grey)),
                    ),
                    TextFormField(
                      initialValue:    widget.tipo == 'CREATE'
                          ? ''
                          : controllerPeluqueria.getObservacionIngresoMascota,
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
                        controllerPeluqueria
                            .onInputObservacionIngresoMascota(text);
                      },
                      // validator: (text) {
                      //   if (text!.trim().isNotEmpty) {
                      //     return null;
                      //   } else {
                      //     return 'Ingrese Tratamiento';
                      //   }
                      // },
                    ),

                    SizedBox(
                      height: size.iScreen(1.5),
                    ),
                    //         //==========================================//
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.iScreen(1.0),
                          vertical: size.iScreen(1.0)),
                      width: size.wScreen(100.0),
                      color: Colors.grey[300],
                      child: Text('PEDIDOS CLIENTE:',
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: Colors.grey)),
                    ),

                     //***********************************************/
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/
                    Row(
                      children: [
                        SizedBox(
                          // width: size.wScreen(100.0),

                          // color: Colors.blue,
                          child: Text('Cara : ',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey)),
                        ),
                        SizedBox(
                          width: size.iScreen(2.0),
                        ),
                         //*****************************************/
                    Consumer<PeluqueriaController>(
                      builder: (_, valueCara, __) {
                        return SizedBox(
                          // width: size.wScreen(100.0),

                          // color: Colors.blue,
                          child: GestureDetector(
                             onTap: () {
                              List<String> _pedidoCliente = [];

                              controllerPeluqueria.getListaPedidosPeluqueria
                                  ?.forEach((e) {
                                if (e['pedipeNombre'] == 'CARA') {
                                  for (var item in e['pedipeOptions']) {
                                    _pedidoCliente.add(item['nombre']);
                                  }
                                }
                              });

                              _buscarPedidoCliente(
                                  context, size, _pedidoCliente, 'CARA');

                              //*******************************************/
                            },
                            child: Text(
                                valueCara.getPedidoCara!.isEmpty
                                    ? '--- --- --- '
                                    : '${valueCara.getPedidoCara}',
                                style: GoogleFonts.lexendDeca(
                                    // fontSize: size.iScreen(2.0),
                                    fontWeight: FontWeight.normal,
                                    color: valueCara.getPedidoCara!.isEmpty
                                        ? Colors.grey
                                        : Colors.black)),
                          ),
                        );
                      },
                    ),
                     //***********************************************/
                        // ClipRRect(
                        //   borderRadius: BorderRadius.circular(8),
                        //   child: GestureDetector(
                        //     onTap: () {
                        //       List<String> _pedidoCliente = [];

                        //       controllerPeluqueria.getListaPedidosPeluqueria
                        //           ?.forEach((e) {
                        //         if (e['pedipeNombre'] == 'CARA') {
                        //           for (var item in e['pedipeOptions']) {
                        //             _pedidoCliente.add(item['nombre']);
                        //           }
                        //         }
                        //       });

                        //       _buscarPedidoCliente(
                        //           context, size, _pedidoCliente, 'CARA');

                        //       //*******************************************/
                        //     },
                        //     child: Container(
                        //       alignment: Alignment.center,
                        //       color: primaryColor,
                        //       width: size.iScreen(3.5),
                        //       padding: EdgeInsets.only(
                        //         top: size.iScreen(0.5),
                        //         bottom: size.iScreen(0.5),
                        //         left: size.iScreen(0.5),
                        //         right: size.iScreen(0.5),
                        //       ),
                        //       child: Icon(
                        //         Icons.arrow_drop_down,
                        //         color: Colors.white,
                        //         size: size.iScreen(2.0),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                    //// ***********************************************/
                    // SizedBox(
                    //   height: size.iScreen(1.0),
                    // ),
                    // //*****************************************/
                    // Consumer<PeluqueriaController>(
                    //   builder: (_, valueCara, __) {
                    //     return SizedBox(
                    //       width: size.wScreen(100.0),

                    //       // color: Colors.blue,
                    //       child: Text(
                    //           valueCara.getPedidoCara!.isEmpty
                    //               ? 'SELECCIONE '
                    //               : '${valueCara.getPedidoCara}',
                    //           style: GoogleFonts.lexendDeca(
                    //               // fontSize: size.iScreen(2.0),
                    //               fontWeight: FontWeight.normal,
                    //               color: valueCara.getPedidoCara!.isEmpty
                    //                   ? Colors.grey
                    //                   : Colors.black)),
                    //     );
                    //   },
                    // ),
                    //  //***********************************************/
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/
                    Row(
                      children: [
                        SizedBox(
                          // width: size.wScreen(100.0),

                          // color: Colors.blue,
                          child: Text('Copete: ',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey)),
                        ),
                        SizedBox(
                          width: size.iScreen(2.0),
                        ),
                         //*****************************************/
                    Consumer<PeluqueriaController>(
                      builder: (_, valueCopete, __) {
                        return SizedBox(
                          // width: size.wScreen(100.0),

                          // color: Colors.blue,
                          child: GestureDetector(
   onTap: () {
                              List<String> _pedidoCliente = [];

                              controllerPeluqueria.getListaPedidosPeluqueria
                                  ?.forEach((e) {
                                if (e['pedipeNombre'] == 'COPETE') {
                                  for (var item in e['pedipeOptions']) {
                                    _pedidoCliente.add(item['nombre']);
                                  }
                                }
                              });

                              _buscarPedidoCliente(
                                  context, size, _pedidoCliente, 'COPETE');

                              //*******************************************/
                            },
                            child: Text(
                                valueCopete.getPedidoCopete!.isEmpty
                                    ? '--- --- --- '
                                    : '${valueCopete.getPedidoCopete}',
                                style: GoogleFonts.lexendDeca(
                                    // fontSize: size.iScreen(2.0),
                                    fontWeight: FontWeight.normal,
                                    color: valueCopete.getPedidoCopete!.isEmpty
                                        ? Colors.grey
                                        : Colors.black)),
                          ),
                        );
                      },
                    ),
                     //***********************************************/
                        // ClipRRect(
                        //   borderRadius: BorderRadius.circular(8),
                        //   child: GestureDetector(
                        //     onTap: () {
                        //       List<String> _pedidoCliente = [];

                        //       controllerPeluqueria.getListaPedidosPeluqueria
                        //           ?.forEach((e) {
                        //         if (e['pedipeNombre'] == 'COPETE') {
                        //           for (var item in e['pedipeOptions']) {
                        //             _pedidoCliente.add(item['nombre']);
                        //           }
                        //         }
                        //       });

                        //       _buscarPedidoCliente(
                        //           context, size, _pedidoCliente, 'COPETE');

                        //       //*******************************************/
                        //     },
                        //     child: Container(
                        //       alignment: Alignment.center,
                        //       color: primaryColor,
                        //       width: size.iScreen(3.5),
                        //       padding: EdgeInsets.only(
                        //         top: size.iScreen(0.5),
                        //         bottom: size.iScreen(0.5),
                        //         left: size.iScreen(0.5),
                        //         right: size.iScreen(0.5),
                        //       ),
                        //       child: Icon(
                        //         Icons.arrow_drop_down,
                        //         color: Colors.white,
                        //         size: size.iScreen(2.0),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                    // //***********************************************/
                    // SizedBox(
                    //   height: size.iScreen(1.0),
                    // ),
                    // //*****************************************/
                    // Consumer<PeluqueriaController>(
                    //   builder: (_, valueCopete, __) {
                    //     return SizedBox(
                    //       width: size.wScreen(100.0),

                    //       // color: Colors.blue,
                    //       child: Text(
                    //           valueCopete.getPedidoCopete!.isEmpty
                    //               ? 'SELECCIONE '
                    //               : '${valueCopete.getPedidoCopete}',
                    //           style: GoogleFonts.lexendDeca(
                    //               // fontSize: size.iScreen(2.0),
                    //               fontWeight: FontWeight.normal,
                    //               color: valueCopete.getPedidoCopete!.isEmpty
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
                    Row(
                      children: [
                        SizedBox(
                          // width: size.wScreen(100.0),

                          // color: Colors.blue,
                          child: Text(' Bigotes:',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey)),
                        ),
                        SizedBox(
                          width: size.iScreen(2.0),
                        ),
  //*****************************************/
                    Consumer<PeluqueriaController>(
                      builder: (_, valueBigotes, __) {
                        return SizedBox(
                          // width: size.wScreen(100.0),

                          // color: Colors.blue,
                          child: GestureDetector(
                             onTap: () {
                              List<String> _pedidoCliente = [];

                              controllerPeluqueria.getListaPedidosPeluqueria
                                  ?.forEach((e) {
                                if (e['pedipeNombre'] == 'BIGOTES') {
                                  for (var item in e['pedipeOptions']) {
                                    _pedidoCliente.add(item['nombre']);
                                  }
                                }
                              });

                              _buscarPedidoCliente(
                                  context, size, _pedidoCliente, 'BIGOTES');

                              //*******************************************/
                            },
                            child: Text(
                                valueBigotes.getPedidoBigotes!.isEmpty
                                    ? '--- --- --- '
                                    : '${valueBigotes.getPedidoBigotes}',
                                style: GoogleFonts.lexendDeca(
                                    // fontSize: size.iScreen(2.0),
                                    fontWeight: FontWeight.normal,
                                    color: valueBigotes.getPedidoBigotes!.isEmpty
                                        ? Colors.grey
                                        : Colors.black)),
                          ),
                        );
                      },
                    ),
                    //***************************************************************************/


                        // ClipRRect(
                        //   borderRadius: BorderRadius.circular(8),
                        //   child: GestureDetector(
                        //     onTap: () {
                        //       List<String> _pedidoCliente = [];

                        //       controllerPeluqueria.getListaPedidosPeluqueria
                        //           ?.forEach((e) {
                        //         if (e['pedipeNombre'] == 'BIGOTES') {
                        //           for (var item in e['pedipeOptions']) {
                        //             _pedidoCliente.add(item['nombre']);
                        //           }
                        //         }
                        //       });

                        //       _buscarPedidoCliente(
                        //           context, size, _pedidoCliente, 'BIGOTES');

                        //       //*******************************************/
                        //     },
                        //     child: Container(
                        //       alignment: Alignment.center,
                        //       color: primaryColor,
                        //       width: size.iScreen(3.5),
                        //       padding: EdgeInsets.only(
                        //         top: size.iScreen(0.5),
                        //         bottom: size.iScreen(0.5),
                        //         left: size.iScreen(0.5),
                        //         right: size.iScreen(0.5),
                        //       ),
                        //       child: Icon(
                        //         Icons.arrow_drop_down,
                        //         color: Colors.white,
                        //         size: size.iScreen(2.0),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                    //***********************************************/
                    // SizedBox(
                    //   height: size.iScreen(1.0),
                    // ),
                    // //*****************************************/
                    // Consumer<PeluqueriaController>(
                    //   builder: (_, valueBigotes, __) {
                    //     return SizedBox(
                    //       width: size.wScreen(100.0),

                    //       // color: Colors.blue,
                    //       child: Text(
                    //           valueBigotes.getPedidoBigotes!.isEmpty
                    //               ? 'SELECCIONE '
                    //               : '${valueBigotes.getPedidoBigotes}',
                    //           style: GoogleFonts.lexendDeca(
                    //               // fontSize: size.iScreen(2.0),
                    //               fontWeight: FontWeight.normal,
                    //               color: valueBigotes.getPedidoBigotes!.isEmpty
                    //                   ? Colors.grey
                    //                   : Colors.black)),
                    //     );
                    //   },
                    // ),
                    // //***************************************************************************/
                     //***********************************************/
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/
                    Row(
                      children: [
                        SizedBox(
                          // width: size.wScreen(100.0),

                          // color: Colors.blue,
                          child: Text(' Cejas:',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey)),
                        ),
                        SizedBox(
                          width: size.iScreen(2.0),
                        ),
                         Consumer<PeluqueriaController>(
                      builder: (_, valueCejas, __) {
                        return SizedBox(
                          // width: size.wScreen(100.0),

                          // color: Colors.blue,
                          child: GestureDetector(
                            onTap: () {
                              List<String> _pedidoCliente = [];

                              controllerPeluqueria.getListaPedidosPeluqueria
                                  ?.forEach((e) {
                                if (e['pedipeNombre'] == 'CEJAS') {
                                  for (var item in e['pedipeOptions']) {
                                    _pedidoCliente.add(item['nombre']);
                                  }
                                }
                              });

                              _buscarPedidoCliente(
                                  context, size, _pedidoCliente, 'CEJAS');

                              //*******************************************/
                            },
                            child: Text(
                                valueCejas.getPedidoCejas!.isEmpty
                                    ? '--- --- --- '
                                    : '${valueCejas.getPedidoCejas}',
                                style: GoogleFonts.lexendDeca(
                                    // fontSize: size.iScreen(2.0),
                                    fontWeight: FontWeight.normal,
                                    color: valueCejas.getPedidoCejas!.isEmpty
                                        ? Colors.grey
                                        : Colors.black)),
                          ),
                        );
                      },
                    ),
                        // ClipRRect(
                        //   borderRadius: BorderRadius.circular(8),
                        //   child: GestureDetector(
                        //     onTap: () {
                        //       List<String> _pedidoCliente = [];

                        //       controllerPeluqueria.getListaPedidosPeluqueria
                        //           ?.forEach((e) {
                        //         if (e['pedipeNombre'] == 'CEJAS') {
                        //           for (var item in e['pedipeOptions']) {
                        //             _pedidoCliente.add(item['nombre']);
                        //           }
                        //         }
                        //       });

                        //       _buscarPedidoCliente(
                        //           context, size, _pedidoCliente, 'CEJAS');

                        //       //*******************************************/
                        //     },
                        //     child: Container(
                        //       alignment: Alignment.center,
                        //       color: primaryColor,
                        //       width: size.iScreen(3.5),
                        //       padding: EdgeInsets.only(
                        //         top: size.iScreen(0.5),
                        //         bottom: size.iScreen(0.5),
                        //         left: size.iScreen(0.5),
                        //         right: size.iScreen(0.5),
                        //       ),
                        //       child: Icon(
                        //         Icons.arrow_drop_down,
                        //         color: Colors.white,
                        //         size: size.iScreen(2.0),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                    //***********************************************/
                    // SizedBox(
                    //   height: size.iScreen(1.0),
                    // ),
                    //*****************************************/
                    // Consumer<PeluqueriaController>(
                    //   builder: (_, valueCejas, __) {
                    //     return SizedBox(
                    //       width: size.wScreen(100.0),

                    //       // color: Colors.blue,
                    //       child: GestureDetector(
                    //         onTap: () {
                    //           List<String> _pedidoCliente = [];

                    //           controllerPeluqueria.getListaPedidosPeluqueria
                    //               ?.forEach((e) {
                    //             if (e['pedipeNombre'] == 'CEJAS') {
                    //               for (var item in e['pedipeOptions']) {
                    //                 _pedidoCliente.add(item['nombre']);
                    //               }
                    //             }
                    //           });

                    //           _buscarPedidoCliente(
                    //               context, size, _pedidoCliente, 'CEJAS');

                    //           //*******************************************/
                    //         },
                    //         child: Text(
                    //             valueCejas.getPedidoCejas!.isEmpty
                    //                 ? 'SELECCIONE '
                    //                 : '${valueCejas.getPedidoCejas}',
                    //             style: GoogleFonts.lexendDeca(
                    //                 // fontSize: size.iScreen(2.0),
                    //                 fontWeight: FontWeight.normal,
                    //                 color: valueCejas.getPedidoCejas!.isEmpty
                    //                     ? Colors.grey
                    //                     : Colors.black)),
                    //       ),
                    //     );
                    //   },
                    // ),
                    //***************************************************************************/
        
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/
                    Row(
                      children: [
                        SizedBox(
                          // width: size.wScreen(100.0),

                          // color: Colors.blue,
                          child: Text(' Solo Lomo:',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey)),
                        ),
                        SizedBox(
                          width: size.iScreen(2.0),
                        ),
                         Consumer<PeluqueriaController>(
                      builder: (_, valueSoloLomo, __) {
                        return SizedBox(
                          // width: size.wScreen(100.0),

                          // color: Colors.blue,
                          child: GestureDetector(
                            onTap: () {
                              List<String> _pedidoCliente = [];

                              controllerPeluqueria.getListaPedidosPeluqueria
                                  ?.forEach((e) {
                                if (e['pedipeNombre'] == 'SOLO LOMO') {
                                  for (var item in e['pedipeOptions']) {
                                    _pedidoCliente.add(item['nombre']);
                                  }
                                }
                              });

                              _buscarPedidoCliente(
                                  context, size, _pedidoCliente, 'SOLO LOMO');

                              //*******************************************/
                            },
                            child: Text(
                                valueSoloLomo.getPedidoSoloLomo!.isEmpty
                                    ? '--- --- --- '
                                    : '${valueSoloLomo.getPedidoSoloLomo}',
                                style: GoogleFonts.lexendDeca(
                                    // fontSize: size.iScreen(2.0),
                                    fontWeight: FontWeight.normal,
                                    color: valueSoloLomo.getPedidoSoloLomo!.isEmpty
                                        ? Colors.grey
                                        : Colors.black)),
                          ),
                        );
                      },
                    ),
                   
                      ],
                    ),
                    //***************************************************************************/
        
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/
                    Row(
                      children: [
                        SizedBox(
                          // width: size.wScreen(100.0),

                          // color: Colors.blue,
                          child: Text('Cola:',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey)),
                        ),
                        SizedBox(
                          width: size.iScreen(2.0),
                        ),
                         Consumer<PeluqueriaController>(
                      builder: (_, valueCola, __) {
                        return SizedBox(
                          // width: size.wScreen(100.0),

                          // color: Colors.blue,
                          child: GestureDetector(
                            onTap: () {
                              List<String> _pedidoCliente = [];

                              controllerPeluqueria.getListaPedidosPeluqueria
                                  ?.forEach((e) {
                                if (e['pedipeNombre'] == 'COLA') {
                                  for (var item in e['pedipeOptions']) {
                                    _pedidoCliente.add(item['nombre']);
                                  }
                                }
                              });

                              _buscarPedidoCliente(
                                  context, size, _pedidoCliente, 'COLA');

                              //*******************************************/
                            },
                            child: Text(
                                valueCola.getPedidoCola!.isEmpty
                                    ? '--- --- --- '
                                    : '${valueCola.getPedidoCola}',
                                style: GoogleFonts.lexendDeca(
                                    // fontSize: size.iScreen(2.0),
                                    fontWeight: FontWeight.normal,
                                    color: valueCola.getPedidoCola!.isEmpty
                                        ? Colors.grey
                                        : Colors.black)),
                          ),
                        );
                      },
                    ),
                   
                      ],
                    ),
                    //***************************************************************************/
        
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/
                    Row(
                      children: [
                        SizedBox(
                          // width: size.wScreen(100.0),

                          // color: Colors.blue,
                          child: Text('Manos y Patas:',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey)),
                        ),
                        SizedBox(
                          width: size.iScreen(2.0),
                        ),
                         Consumer<PeluqueriaController>(
                      builder: (_, valueManosPatas, __) {
                        return SizedBox(
                          // width: size.wScreen(100.0),

                          // color: Colors.blue,
                          child: GestureDetector(
                            onTap: () {
                              List<String> _pedidoCliente = [];

                              controllerPeluqueria.getListaPedidosPeluqueria
                                  ?.forEach((e) {
                                if (e['pedipeNombre'] == 'MANOS Y PATITAS') {
                                  for (var item in e['pedipeOptions']) {
                                    _pedidoCliente.add(item['nombre']);
                                  }
                                }
                              });

                              _buscarPedidoCliente(
                                  context, size, _pedidoCliente, 'MANOS Y PATITAS');

                              //*******************************************/
                            },
                            child: Text(
                                valueManosPatas.getPedidoManosYPatas!.isEmpty
                                    ? '--- --- --- '
                                    : '${valueManosPatas.getPedidoManosYPatas}',
                                style: GoogleFonts.lexendDeca(
                                    // fontSize: size.iScreen(2.0),
                                    fontWeight: FontWeight.normal,
                                    color: valueManosPatas.getPedidoManosYPatas!.isEmpty
                                        ? Colors.grey
                                        : Colors.black)),
                          ),
                        );
                      },
                    ),
                   
                      ],
                    ),
                    //***************************************************************************/
        
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/
                    Row(
                      children: [
                        SizedBox(
                          // width: size.wScreen(100.0),

                          // color: Colors.blue,
                          child: Text('Forma de la Cabeza:',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey)),
                        ),
                        SizedBox(
                          width: size.iScreen(2.0),
                        ),
                         Consumer<PeluqueriaController>(
                      builder: (_, valueFormaCabeza, __) {
                        return SizedBox(
                          // width: size.wScreen(100.0),

                          // color: Colors.blue,
                          child: GestureDetector(
                            onTap: () {
                              List<String> _pedidoCliente = [];

                              controllerPeluqueria.getListaPedidosPeluqueria
                                  ?.forEach((e) {
                                if (e['pedipeNombre'] == 'FORMA DE LA CABEZA') {
                                  for (var item in e['pedipeOptions']) {
                                    _pedidoCliente.add(item['nombre']);
                                  }
                                }
                              });

                              _buscarPedidoCliente(
                                  context, size, _pedidoCliente, 'FORMA DE LA CABEZA');

                              //*******************************************/
                            },
                            child: Text(
                                valueFormaCabeza.getPedidoFormaDeLaCabeza!.isEmpty
                                    ? '--- --- --- '
                                    : '${valueFormaCabeza.getPedidoFormaDeLaCabeza}',
                                style: GoogleFonts.lexendDeca(
                                    // fontSize: size.iScreen(2.0),
                                    fontWeight: FontWeight.normal,
                                    color: valueFormaCabeza.getPedidoFormaDeLaCabeza!.isEmpty
                                        ? Colors.grey
                                        : Colors.black)),
                          ),
                        );
                      },
                    ),
                   
                      ],
                    ),
                    //***************************************************************************/
        
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/
                    Row(
                      children: [
                        SizedBox(
                          // width: size.wScreen(100.0),

                          // color: Colors.blue,
                          child: Text('Orejas:',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey)),
                        ),
                        SizedBox(
                          width: size.iScreen(2.0),
                        ),
                         Consumer<PeluqueriaController>(
                      builder: (_, valueFormaOrelas, __) {
                        return SizedBox(
                          // width: size.wScreen(100.0),

                          // color: Colors.blue,
                          child: GestureDetector(
                            onTap: () {
                              List<String> _pedidoCliente = [];

                              controllerPeluqueria.getListaPedidosPeluqueria
                                  ?.forEach((e) {
                                if (e['pedipeNombre'] == 'OREJAS') {
                                  for (var item in e['pedipeOptions']) {
                                    _pedidoCliente.add(item['nombre']);
                                  }
                                }
                              });

                              _buscarPedidoCliente(
                                  context, size, _pedidoCliente, 'OREJAS');

                              //*******************************************/
                            },
                            child: Text(
                                valueFormaOrelas.getPedidoOrejas!.isEmpty
                                    ? '--- --- --- '
                                    : '${valueFormaOrelas.getPedidoOrejas}',
                                style: GoogleFonts.lexendDeca(
                                    // fontSize: size.iScreen(2.0),
                                    fontWeight: FontWeight.normal,
                                    color: valueFormaOrelas.getPedidoOrejas!.isEmpty
                                        ? Colors.grey
                                        : Colors.black)),
                          ),
                        );
                      },
                    ),
                   
                      ],
                    ),
                    //***************************************************************************/
        
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/
                    Row(
                      children: [
                        SizedBox(
                          // width: size.wScreen(100.0),

                          // color: Colors.blue,
                          child: Text('Bigotes Forma:',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey)),
                        ),
                        SizedBox(
                          width: size.iScreen(2.0),
                        ),
                         Consumer<PeluqueriaController>(
                      builder: (_, valueFormaBigotesForma, __) {
                        return SizedBox(
                          // width: size.wScreen(100.0),

                          // color: Colors.blue,
                          child: GestureDetector(
                            onTap: () {
                              List<String> _pedidoCliente = [];

                              controllerPeluqueria.getListaPedidosPeluqueria
                                  ?.forEach((e) {
                                if (e['pedipeNombre'] == 'BIGOTES FORMA') {
                                  for (var item in e['pedipeOptions']) {
                                    _pedidoCliente.add(item['nombre']);
                                  }
                                }
                              });

                              _buscarPedidoCliente(
                                  context, size, _pedidoCliente, 'BIGOTES FORMA');

                              //*******************************************/
                            },
                            child: Text(
                                valueFormaBigotesForma.getPedidoBigotesForma!.isEmpty
                                    ? '--- --- --- '
                                    : '${valueFormaBigotesForma.getPedidoBigotesForma}',
                                style: GoogleFonts.lexendDeca(
                                    // fontSize: size.iScreen(2.0),
                                    fontWeight: FontWeight.normal,
                                    color: valueFormaBigotesForma.getPedidoBigotesForma!.isEmpty
                                        ? Colors.grey
                                        : Colors.black)),
                          ),
                        );
                      },
                    ),
                   
                      ],
                    ),
                    //***************************************************************************/
        
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/
                    Row(
                      children: [
                        SizedBox(
                          // width: size.wScreen(100.0),

                          // color: Colors.blue,
                          child: Text('Todo el Cuerpo:',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey)),
                        ),
                        SizedBox(
                          width: size.iScreen(2.0),
                        ),
                         Consumer<PeluqueriaController>(
                      builder: (_, valueFormaTodoElCuerpo, __) {
                        return SizedBox(
                          // width: size.wScreen(100.0),

                          // color: Colors.blue,
                          child: GestureDetector(
                            onTap: () {
                              List<String> _pedidoCliente = [];

                              controllerPeluqueria.getListaPedidosPeluqueria
                                  ?.forEach((e) {
                                if (e['pedipeNombre'] == 'TODO EL CUERPO') {
                                  for (var item in e['pedipeOptions']) {
                                    _pedidoCliente.add(item['nombre']);
                                  }
                                }
                              });

                              _buscarPedidoCliente(
                                  context, size, _pedidoCliente, 'TODO EL CUERPO');

                              //*******************************************/
                            },
                            child: Text(
                                valueFormaTodoElCuerpo.getPedidoTodoElCuerpo!.isEmpty
                                    ? '--- --- --- '
                                    : '${valueFormaTodoElCuerpo.getPedidoTodoElCuerpo}',
                                style: GoogleFonts.lexendDeca(
                                    // fontSize: size.iScreen(2.0),
                                    fontWeight: FontWeight.normal,
                                    color: valueFormaTodoElCuerpo.getPedidoTodoElCuerpo!.isEmpty
                                        ? Colors.grey
                                        : Colors.black)),
                          ),
                        );
                      },
                    ),
                   
                      ],
                    ),
                    //***************************************************************************/
        
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/
                    Column(
                      children: [
                        SizedBox(
                          width: size.wScreen(100.0),

                          // color: Colors.blue,
                          child: Text('Faldón-pecho-patitas:',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey)),
                        ),
                        SizedBox(
                          width: size.iScreen(2.0),
                        ),
                         Consumer<PeluqueriaController>(
                      builder: (_, valueFormaFaldonPechoPatitas, __) {
                        return SizedBox(
                          // width: size.wScreen(100.0),

                          // color: Colors.blue,
                          child: GestureDetector(
                            onTap: () {
                              List<String> _pedidoCliente = [];

                              controllerPeluqueria.getListaPedidosPeluqueria
                                  ?.forEach((e) {
                                if (e['pedipeNombre'] == 'FALDON-PECHO-PATAS') {
                                  for (var item in e['pedipeOptions']) {
                                    _pedidoCliente.add(item['nombre']);
                                  }
                                }
                              });

                              _buscarPedidoCliente(
                                  context, size, _pedidoCliente, 'FALDON-PECHO-PATAS');

                              //*******************************************/s
                            },
                            
                            child: Container(
                                 width: size.iScreen(100.0),
                              child: Text(
                                                     
                                  valueFormaFaldonPechoPatitas.getPedidoFaldonPechoPatitas!.isEmpty
                                      ? '--- --- --- '
                                      : '${valueFormaFaldonPechoPatitas.getPedidoFaldonPechoPatitas}',
                                  
                                  style: GoogleFonts.lexendDeca(
                                      // fontSize: size.iScreen(2.0),
                                      fontWeight: FontWeight.normal,
                                      color: valueFormaFaldonPechoPatitas.getPedidoFaldonPechoPatitas!.isEmpty
                                          ? Colors.grey
                                          : Colors.black,),    overflow:TextOverflow.ellipsis,
                                          ),
                            ),
                          ),
                        );
                      },
                    ),
                   
                      ],
                    ),
                    //***************************************************************************/
        
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/
                    Row(
                      children: [
                        SizedBox(
                          // width: size.wScreen(100.0),

                          // color: Colors.blue,
                          child: Text('Cola Forma:',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey)),
                        ),
                        SizedBox(
                          width: size.iScreen(2.0),
                        ),
                         Consumer<PeluqueriaController>(
                      builder: (_, valueFormaColaForma, __) {
                        return SizedBox(
                          // width: size.wScreen(100.0),

                          // color: Colors.blue,
                          child: GestureDetector(
                            onTap: () {
                              List<String> _pedidoCliente = [];

                              controllerPeluqueria.getListaPedidosPeluqueria
                                  ?.forEach((e) {
                                if (e['pedipeNombre'] == 'COLA FORMA') {
                                  for (var item in e['pedipeOptions']) {
                                    _pedidoCliente.add(item['nombre']);
                                  }
                                }
                              });

                              _buscarPedidoCliente(
                                  context, size, _pedidoCliente, 'COLA FORMA');

                              //*******************************************/
                            },
                            child: Container(
                                 width: size.iScreen(25.0),
                              child: Text(
                                                     
                                  valueFormaColaForma.getPedidoColaForma!.isEmpty
                                      ? '--- --- --- '
                                      : '${valueFormaColaForma.getPedidoColaForma}',
                                  style: GoogleFonts.lexendDeca(
                                     
                                      // fontSize: size.iScreen(2.0),
                                      fontWeight: FontWeight.normal,
                                      color: valueFormaColaForma.getPedidoColaForma!.isEmpty
                                          ? Colors.grey
                                          : Colors.black,),    overflow:TextOverflow.ellipsis,),
                            ),
                          ),
                        );
                      },
                    ),
                   
                      ],
                    ),
                    //***************************************************************************/

  SizedBox(
                      height: size.iScreen(1.5),
                    ),
                    //         //==========================================//
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.iScreen(1.0),
                          vertical: size.iScreen(1.0)),
                      width: size.wScreen(100.0),
                      color: Colors.grey[300],
                      child: Text('PROCESOS DE PELUQUERIA',
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: Colors.grey)),
                    ),
 //***************************************************************************/
        
                    SizedBox(
                      height: size.iScreen(1.5),
                    ),
                    //*****************************************/
                      // SizedBox(
                      //     width: size.wScreen(100.0),

                      //     // color: Colors.blue,
                      //     child: Text('Declaro haber pedido el corte al gusto de la veterinaria',
                      //         style: GoogleFonts.lexendDeca(
                      //             // fontSize: size.iScreen(2.0),
                      //             fontWeight: FontWeight.normal,
                      //             color: Colors.grey[600])),
                      //   ),

 //***************************************************************************/
  //***********************************************//
                    SizedBox(
                      height: size.iScreen(0.5),
                    ),
                    //*****************************************/
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Declaro haber pedido el corte al gusto de la veterinaria ',
                            style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(1.8),
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                     
                        Row(
                          children: [
                            SizedBox(
                                // color: Colors.red,
                                // width: size.wScreen(10.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text('Si'),
                                    Radio<Declaro?>(
                                      visualDensity: VisualDensity.compact,
                                      // activeColor: primaryColor,
                                      value: Declaro.si,
                                      groupValue: _declaro,
                                      onChanged: (Declaro? value) {
                                        setState(() {
                                          _declaro = value!;
                                             controllerPeluqueria.setDeclaro('SI');
                                        });
                                      },
                                    ),
                                  ],
                                )

                                ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text('No'),
                                Radio<Declaro?>(
                                  visualDensity: VisualDensity.compact,
                                  // activeColor: primaryColor,
                                  value: Declaro.no,
                                  groupValue: _declaro,
                                  onChanged: (Declaro? value) {
                                    setState(() {
                                      _declaro = value!;
                                        controllerPeluqueria.setCorteYAcabados('NO');
                                    });
                                  },
                                ),
                              ],
                            ),
                            
                          ],
                        ),
                      ],
                    ),
        
                  //***********************************************//

                    SizedBox(
                      height: size.iScreen(0.5),
                    ),
                    //*****************************************/
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Oidos: ',
                          style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(1.8),
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        //*****************************************/
                        // SizedBox(
                        //   width: size.iScreen(1.0),
                        // ),
                        //*****************************************/
                        Container(
                          // width: size.wScreen(20.0),
                          child: Row(
                            children: [
                              Container(
                                  // color: Colors.red,
                                  // width: size.wScreen(10.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text('Si'),
                                      Radio<Oidos?>(
                                        visualDensity: VisualDensity.compact,
                                        // activeColor: primaryColor,
                                        value: Oidos.si,
                                        groupValue: _oidos,
                                        onChanged: (Oidos? value) {
                                          setState(() {
                                            _oidos = value!;
                                               controllerPeluqueria.setProcesoOidos('SI');
                                          });
                                        },
                                      ),
                                    ],
                                  )

                                  ),
                              Container(
                                  // color: Colors.green,
                                  // width: size.wScreen(10.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text('No'),
                                      Radio<Oidos?>(
                                        visualDensity: VisualDensity.compact,
                                        // activeColor: primaryColor,
                                        value: Oidos.no,
                                        groupValue: _oidos,
                                        onChanged: (Oidos? value) {
                                          setState(() {
                                            _oidos = value!;
                                              controllerPeluqueria.setProcesoOidos('NO');
                                          });
                                        },
                                      ),
                                    ],
                                  )),
                              
                            ],
                          ),
                        ),
                      ],
                    ),
 //***************************************************************************/
        
                  //***********************************************//

                    SizedBox(
                      height: size.iScreen(0.5),
                    ),
                    //*****************************************/
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Lavado de dientes: ',
                          style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(1.8),
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        //*****************************************/
                        // SizedBox(
                        //   width: size.iScreen(1.0),
                        // ),
                        //*****************************************/
                        Container(
                          // width: size.wScreen(20.0),
                          child: Row(
                            children: [
                              Container(
                                  // color: Colors.red,
                                  // width: size.wScreen(10.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text('Si'),
                                      Radio<LavadoDientes?>(
                                        visualDensity: VisualDensity.compact,
                                        // activeColor: primaryColor,
                                        value: LavadoDientes.si,
                                        groupValue: _lavadoDientes,
                                        onChanged: (LavadoDientes? value) {
                                          setState(() {
                                            _lavadoDientes = value!;
                                               controllerPeluqueria.setLavadoDientes('SI');
                                          });
                                        },
                                      ),
                                    ],
                                  )

                                  ),
                              Container(
                                  // color: Colors.green,
                                  // width: size.wScreen(10.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text('No'),
                                      Radio<LavadoDientes?>(
                                        visualDensity: VisualDensity.compact,
                                        // activeColor: primaryColor,
                                        value: LavadoDientes.no,
                                        groupValue: _lavadoDientes,
                                        onChanged: (LavadoDientes? value) {
                                          setState(() {
                                            _lavadoDientes = value!;
                                              controllerPeluqueria.setLavadoDientes('NO');
                                          });
                                        },
                                      ),
                                    ],
                                  )),
                              
                            ],
                          ),
                        ),
                      ],
                    ),
                  //***********************************************//

                    SizedBox(
                      height: size.iScreen(0.5),
                    ),
                    //*****************************************/
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Uñas dedos supernumerarios: ',
                          style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(1.8),
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                     
                        Container(
                          // width: size.wScreen(20.0),
                          child: Row(
                            children: [
                              Container(
                                  // color: Colors.red,
                                  // width: size.wScreen(10.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text('Si'),
                                      Radio<UniasDedos?>(
                                        visualDensity: VisualDensity.compact,
                                        // activeColor: primaryColor,
                                        value: UniasDedos.si,
                                        groupValue: _uniasDedos,
                                        onChanged: (UniasDedos? value) {
                                          setState(() {
                                            _uniasDedos = value!;
                                               controllerPeluqueria.setUniasDedos('SI');
                                          });
                                        },
                                      ),
                                    ],
                                  )

                                  ),
                              Container(
                                  // color: Colors.green,
                                  // width: size.wScreen(10.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text('No'),
                                      Radio<UniasDedos?>(
                                        visualDensity: VisualDensity.compact,
                                        // activeColor: primaryColor,
                                        value: UniasDedos.no,
                                        groupValue: _uniasDedos,
                                        onChanged: (UniasDedos? value) {
                                          setState(() {
                                            _uniasDedos = value!;
                                              controllerPeluqueria.setUniasDedos('NO');
                                          });
                                        },
                                      ),
                                    ],
                                  )),
                              
                            ],
                          ),
                        ),
                      ],
                    ),
                  //***********************************************//
                    SizedBox(
                      height: size.iScreen(0.5),
                    ),
                    //*****************************************/
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Drenaje G. Perinales: ',
                          style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(1.8),
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                     
                        Container(
                          // width: size.wScreen(20.0),
                          child: Row(
                            children: [
                              Container(
                                  // color: Colors.red,
                                  // width: size.wScreen(10.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text('Si'),
                                      Radio<Drenaje?>(
                                        visualDensity: VisualDensity.compact,
                                        // activeColor: primaryColor,
                                        value: Drenaje.si,
                                        groupValue: _drenaje,
                                        onChanged: (Drenaje? value) {
                                          setState(() {
                                            _drenaje = value!;
                                               controllerPeluqueria.setDrenaje('SI');
                                          });
                                        },
                                      ),
                                    ],
                                  )

                                  ),
                              Container(
                                  // color: Colors.green,
                                  // width: size.wScreen(10.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text('No'),
                                      Radio<Drenaje?>(
                                        visualDensity: VisualDensity.compact,
                                        // activeColor: primaryColor,
                                        value: Drenaje.no,
                                        groupValue: _drenaje,
                                        onChanged: (Drenaje? value) {
                                          setState(() {
                                            _drenaje = value!;
                                              controllerPeluqueria.setDrenaje('NO');
                                          });
                                        },
                                      ),
                                    ],
                                  )),
                              
                            ],
                          ),
                        ),
                      ],
                    ),
                  //***********************************************//

                    SizedBox(
                      height: size.iScreen(0.5),
                    ),
                    //*****************************************/
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Secado: ',
                          style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(1.8),
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                     
                        Container(
                          // width: size.wScreen(20.0),
                          child: Row(
                            children: [
                              Container(
                                  // color: Colors.red,
                                  // width: size.wScreen(10.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text('Si'),
                                      Radio<Secado?>(
                                        visualDensity: VisualDensity.compact,
                                        // activeColor: primaryColor,
                                        value: Secado.si,
                                        groupValue: _secado,
                                        onChanged: (Secado? value) {
                                          setState(() {
                                            _secado = value!;
                                               controllerPeluqueria.setSecado('SI');
                                          });
                                        },
                                      ),
                                    ],
                                  )

                                  ),
                              Container(
                                  // color: Colors.green,
                                  // width: size.wScreen(10.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text('No'),
                                      Radio<Secado?>(
                                        visualDensity: VisualDensity.compact,
                                        // activeColor: primaryColor,
                                        value: Secado.no,
                                        groupValue: _secado,
                                        onChanged: (Secado? value) {
                                          setState(() {
                                            _secado = value!;
                                              controllerPeluqueria.setSecado('NO');
                                          });
                                        },
                                      ),
                                    ],
                                  )),
                              
                            ],
                          ),
                        ),
                      ],
                    ),
                  //***********************************************//
                    SizedBox(
                      height: size.iScreen(0.5),
                    ),
                    //*****************************************/
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Perfume: ',
                          style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(1.8),
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                     
                        Row(
                          children: [
                            SizedBox(
                                // color: Colors.red,
                                // width: size.wScreen(10.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text('Si'),
                                    Radio<Perfume?>(
                                      visualDensity: VisualDensity.compact,
                                      // activeColor: primaryColor,
                                      value: Perfume.si,
                                      groupValue: _perfume,
                                      onChanged: (Perfume? value) {
                                        setState(() {
                                          _perfume = value!;
                                             controllerPeluqueria.setSecado('SI');
                                        });
                                      },
                                    ),
                                  ],
                                )

                                ),
                            SizedBox(
                                // color: Colors.green,
                                // width: size.wScreen(10.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text('No'),
                                    Radio<Perfume?>(
                                      visualDensity: VisualDensity.compact,
                                      // activeColor: primaryColor,
                                      value: Perfume.no,
                                      groupValue: _perfume,
                                      onChanged: (Perfume? value) {
                                        setState(() {
                                          _perfume = value!;
                                            controllerPeluqueria.setPerfume('NO');
                                        });
                                      },
                                    ),
                                  ],
                                )),
                            
                          ],
                        ),
                      ],
                    ),
                  //***********************************************//
                    SizedBox(
                      height: size.iScreen(0.5),
                    ),
                    //*****************************************/
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Limpieza Ocular: ',
                          style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(1.8),
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                     
                        Row(
                          children: [
                            SizedBox(
                                // color: Colors.red,
                                // width: size.wScreen(10.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text('Si'),
                                    Radio<LimpiezaOcular?>(
                                      visualDensity: VisualDensity.compact,
                                      // activeColor: primaryColor,
                                      value: LimpiezaOcular.si,
                                      groupValue: _limpiezaOcular,
                                      onChanged: (LimpiezaOcular? value) {
                                        setState(() {
                                          _limpiezaOcular = value!;
                                             controllerPeluqueria.setLimpiezaOcular('SI');
                                        });
                                      },
                                    ),
                                  ],
                                )

                                ),
                            Container(
                                // color: Colors.green,
                                // width: size.wScreen(10.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text('No'),
                                    Radio<LimpiezaOcular?>(
                                      visualDensity: VisualDensity.compact,
                                      // activeColor: primaryColor,
                                      value: LimpiezaOcular.no,
                                      groupValue: _limpiezaOcular,
                                      onChanged: (LimpiezaOcular? value) {
                                        setState(() {
                                          _limpiezaOcular = value!;
                                            controllerPeluqueria.setLimpiezaOcular('NO');
                                        });
                                      },
                                    ),
                                  ],
                                )),
                            
                          ],
                        ),
                      ],
                    ),
                  //***********************************************//
                    SizedBox(
                      height: size.iScreen(0.5),
                    ),
                    //*****************************************/
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Corte de uñas: ',
                          style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(1.8),
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                     
                        Row(
                          children: [
                            SizedBox(
                                // color: Colors.red,
                                // width: size.wScreen(10.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text('Si'),
                                    Radio<CorteUnias?>(
                                      visualDensity: VisualDensity.compact,
                                      // activeColor: primaryColor,
                                      value: CorteUnias.si,
                                      groupValue: _corteUnias,
                                      onChanged: (CorteUnias? value) {
                                        setState(() {
                                          _corteUnias = value!;
                                             controllerPeluqueria.setCorteUnias('SI');
                                        });
                                      },
                                    ),
                                  ],
                                )

                                ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text('No'),
                                Radio<CorteUnias?>(
                                  visualDensity: VisualDensity.compact,
                                  // activeColor: primaryColor,
                                  value: CorteUnias.no,
                                  groupValue: _corteUnias,
                                  onChanged: (CorteUnias? value) {
                                    setState(() {
                                      _corteUnias = value!;
                                        controllerPeluqueria.setCorteUnias('NO');
                                    });
                                  },
                                ),
                              ],
                            ),
                            
                          ],
                        ),
                      ],
                    ),
                  //***********************************************//
                    SizedBox(
                      height: size.iScreen(0.5),
                    ),
                    //*****************************************/
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Rapado Genital: ',
                          style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(1.8),
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                     
                        Row(
                          children: [
                            SizedBox(
                                // color: Colors.red,
                                // width: size.wScreen(10.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text('Si'),
                                    Radio<RapadoGenital?>(
                                      visualDensity: VisualDensity.compact,
                                      // activeColor: primaryColor,
                                      value: RapadoGenital.si,
                                      groupValue: _rapadoGenital,
                                      onChanged: (RapadoGenital? value) {
                                        setState(() {
                                          _rapadoGenital = value!;
                                             controllerPeluqueria.setRapadoGenital('SI');
                                        });
                                      },
                                    ),
                                  ],
                                )

                                ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text('No'),
                                Radio<RapadoGenital?>(
                                  visualDensity: VisualDensity.compact,
                                  // activeColor: primaryColor,
                                  value: RapadoGenital.no,
                                  groupValue: _rapadoGenital,
                                  onChanged: (RapadoGenital? value) {
                                    setState(() {
                                      _rapadoGenital = value!;
                                        controllerPeluqueria.setRapadoGenital('NO');
                                    });
                                  },
                                ),
                              ],
                            ),
                            
                          ],
                        ),
                      ],
                    ),
                  //***********************************************//
                    SizedBox(
                      height: size.iScreen(0.5),
                    ),
                    //*****************************************/
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Baño: ',
                          style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(1.8),
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                     
                        Row(
                          children: [
                            SizedBox(
                                // color: Colors.red,
                                // width: size.wScreen(10.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text('Si'),
                                    Radio<Banio?>(
                                      visualDensity: VisualDensity.compact,
                                      // activeColor: primaryColor,
                                      value: Banio.si,
                                      groupValue: _banio,
                                      onChanged: (Banio? value) {
                                        setState(() {
                                          _banio = value!;
                                             controllerPeluqueria.setBanio('SI');
                                        });
                                      },
                                    ),
                                  ],
                                )

                                ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text('No'),
                                Radio<Banio?>(
                                  visualDensity: VisualDensity.compact,
                                  // activeColor: primaryColor,
                                  value: Banio.no,
                                  groupValue: _banio,
                                  onChanged: (Banio? value) {
                                    setState(() {
                                      _banio = value!;
                                        controllerPeluqueria.setBanio('NO');
                                    });
                                  },
                                ),
                              ],
                            ),
                            
                          ],
                        ),
                      ],
                    ),
                  //***********************************************//
                    SizedBox(
                      height: size.iScreen(0.5),
                    ),
                    //*****************************************/
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Corte y acabados: ',
                          style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(1.8),
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                     
                        Row(
                          children: [
                            SizedBox(
                                // color: Colors.red,
                                // width: size.wScreen(10.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text('Si'),
                                    Radio<CorteYAcabados?>(
                                      visualDensity: VisualDensity.compact,
                                      // activeColor: primaryColor,
                                      value: CorteYAcabados.si,
                                      groupValue: _corteYAcabados,
                                      onChanged: (CorteYAcabados? value) {
                                        setState(() {
                                          _corteYAcabados = value!;
                                             controllerPeluqueria.setCorteYAcabados('SI');
                                        });
                                      },
                                    ),
                                  ],
                                )

                                ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text('No'),
                                Radio<CorteYAcabados?>(
                                  visualDensity: VisualDensity.compact,
                                  // activeColor: primaryColor,
                                  value: CorteYAcabados.no,
                                  groupValue: _corteYAcabados,
                                  onChanged: (CorteYAcabados? value) {
                                    setState(() {
                                      _corteYAcabados = value!;
                                        controllerPeluqueria.setCorteYAcabados('NO');
                                    });
                                  },
                                ),
                              ],
                            ),
                            
                          ],
                        ),
                      ],
                    ),
                     //***********************************************//
                    SizedBox(
                      height: size.iScreen(0.5),
                    ),
                    //*****************************************/
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Dos Lazos: ',
                          style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(1.8),
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                     
                        Row(
                          children: [
                            SizedBox(
                                // color: Colors.red,
                                // width: size.wScreen(10.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text('Si'),
                                    Radio<DosLazos?>(
                                      visualDensity: VisualDensity.compact,
                                      // activeColor: primaryColor,
                                      value: DosLazos.si,
                                      groupValue: _dosLazos,
                                      onChanged: (DosLazos? value) {
                                        setState(() {
                                          _dosLazos = value!;
                                             controllerPeluqueria.setDosLazos('SI');
                                        });
                                      },
                                    ),
                                  ],
                                )

                                ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text('No'),
                                Radio<DosLazos?>(
                                  visualDensity: VisualDensity.compact,
                                  // activeColor: primaryColor,
                                  value: DosLazos.no,
                                  groupValue: _dosLazos,
                                  onChanged: (DosLazos? value) {
                                    setState(() {
                                      _dosLazos = value!;
                                        controllerPeluqueria.setDosLazos('NO');
                                    });
                                  },
                                ),
                              ],
                            ),
                            
                          ],
                        ),
                      ],
                    ),
                  //***********************************************//
                    SizedBox(
                      height: size.iScreen(0.5),
                    ),
                    //*****************************************/
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Pañuelo: ',
                          style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(1.8),
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                     
                        Row(
                          children: [
                            SizedBox(
                                // color: Colors.red,
                                // width: size.wScreen(10.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text('Si'),
                                    Radio<Panuelo?>(
                                      visualDensity: VisualDensity.compact,
                                      // activeColor: primaryColor,
                                      value: Panuelo.si,
                                      groupValue: _panuelo,
                                      onChanged: (Panuelo? value) {
                                        setState(() {
                                          _panuelo = value!;
                                             controllerPeluqueria.setPanuelo('SI');
                                        });
                                      },
                                    ),
                                  ],
                                )

                                ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text('No'),
                                Radio<Panuelo?>(
                                  visualDensity: VisualDensity.compact,
                                  // activeColor: primaryColor,
                                  value: Panuelo.no,
                                  groupValue: _panuelo,
                                  onChanged: (Panuelo? value) {
                                    setState(() {
                                      _panuelo = value!;
                                        controllerPeluqueria.setPanuelo('NO');
                                    });
                                  },
                                ),
                              ],
                            ),
                            
                          ],
                        ),
                      ],
                    ),
                  //***********************************************//
                    SizedBox(
                      height: size.iScreen(0.5),
                    ),
                    //*****************************************/
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Lazo Central: ',
                          style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(1.8),
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                     
                        Row(
                          children: [
                            SizedBox(
                                // color: Colors.red,
                                // width: size.wScreen(10.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text('Si'),
                                    Radio<LazoCentral?>(
                                      visualDensity: VisualDensity.compact,
                                      // activeColor: primaryColor,
                                      value: LazoCentral.si,
                                      groupValue: _lazoCentral,
                                      onChanged: (LazoCentral? value) {
                                        setState(() {
                                          _lazoCentral = value!;
                                             controllerPeluqueria.setLazoCentral('SI');
                                        });
                                      },
                                    ),
                                  ],
                                )

                                ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text('No'),
                                Radio<LazoCentral?>(
                                  visualDensity: VisualDensity.compact,
                                  // activeColor: primaryColor,
                                  value: LazoCentral.no,
                                  groupValue: _lazoCentral,
                                  onChanged: (LazoCentral? value) {
                                    setState(() {
                                      _lazoCentral = value!;
                                        controllerPeluqueria.setLazoCentral('NO');
                                    });
                                  },
                                ),
                              ],
                            ),
                            
                          ],
                        ),
                      ],
                    ),
                  //***********************************************//
                    SizedBox(
                      height: size.iScreen(0.5),
                    ),
                    //*****************************************/
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Bufanda: ',
                          style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(1.8),
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                     
                        Row(
                          children: [
                            SizedBox(
                                // color: Colors.red,
                                // width: size.wScreen(10.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text('Si'),
                                    Radio<Bufanda?>(
                                      visualDensity: VisualDensity.compact,
                                      // activeColor: primaryColor,
                                      value: Bufanda.si,
                                      groupValue: _bufanda,
                                      onChanged: (Bufanda? value) {
                                        setState(() {
                                          _bufanda = value!;
                                             controllerPeluqueria.setBufanda('SI');
                                        });
                                      },
                                    ),
                                  ],
                                )

                                ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text('No'),
                                Radio<Bufanda?>(
                                  visualDensity: VisualDensity.compact,
                                  // activeColor: primaryColor,
                                  value: Bufanda.no,
                                  groupValue: _bufanda,
                                  onChanged: (Bufanda? value) {
                                    setState(() {
                                      _bufanda = value!;
                                        controllerPeluqueria.setBufanda('NO');
                                    });
                                  },
                                ),
                              ],
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
                    SizedBox(
                      width: size.wScreen(100.0),

                      // color: Colors.blue,
                      child: Text('Otros procesos',
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: Colors.grey)),
                    ),
                    TextFormField(
                      initialValue: widget.tipo == 'CREATE'
                          ? ''
                          : controllerPeluqueria.getOtrosProcesos,
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
                        controllerPeluqueria
                            .onInputOtrosProcesos(text);
                      },
                      // validator: (text) {
                      //   if (text!.trim().isNotEmpty) {
                      //     return null;
                      //   } else {
                      //     return 'Ingrese Tratamiento';
                      //   }
                      // },
                    ),
                      //***************************************************************************/

  SizedBox(
                      height: size.iScreen(1.5),
                    ),
                    //         //==========================================//
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.iScreen(1.0),
                          vertical: size.iScreen(1.0)),
                      width: size.wScreen(100.0),
                      color: Colors.grey[300],
                      child: Text('ADICIONALES',
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: Colors.grey)),
                    ),
                     //***********************************************//
                    SizedBox(
                      height: size.iScreen(0.5),
                    ),
                    //*****************************************/
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'El cliente retira la mascota lista ',
                            style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(1.8),
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                     
                        Row(
                          children: [
                            SizedBox(
                                // color: Colors.red,
                                // width: size.wScreen(10.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text('Si'),
                                    Radio<RetiraMacota?>(
                                      visualDensity: VisualDensity.compact,
                                      // activeColor: primaryColor,
                                      value: RetiraMacota.si,
                                      groupValue: _retiraMacota,
                                      onChanged: (RetiraMacota? value) {
                                        setState(() {
                                          _retiraMacota = value!;
                                             controllerPeluqueria.setRetiraMascota('SI');
                                        });
                                      },
                                    ),
                                  ],
                                )

                                ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text('No'),
                                Radio<RetiraMacota?>(
                                  visualDensity: VisualDensity.compact,
                                  // activeColor: primaryColor,
                                  value: RetiraMacota.no,
                                  groupValue: _retiraMacota,
                                  onChanged: (RetiraMacota? value) {
                                    setState(() {
                                      _retiraMacota = value!;
                                        controllerPeluqueria.setRetiraMascota('NO');
                                    });
                                  },
                                ),
                              ],
                            ),
                            
                          ],
                        ),
                      ],
                    ),
                     //***********************************************//
                    SizedBox(
                      height: size.iScreen(0.5),
                    ),
                    //*****************************************/
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Deja Carnet de Vacunas ',
                            style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(1.8),
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                     
                        Row(
                          children: [
                            SizedBox(
                                // color: Colors.red,
                                // width: size.wScreen(10.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text('Si'),
                                    Radio<DejaCarnet?>(
                                      visualDensity: VisualDensity.compact,
                                      // activeColor: primaryColor,
                                      value: DejaCarnet.si,
                                      groupValue: _dejaCarnet,
                                      onChanged: (DejaCarnet? value) {
                                        setState(() {
                                          _dejaCarnet = value!;
                                             controllerPeluqueria.setDejaCarnet('SI');
                                        });
                                      },
                                    ),
                                  ],
                                )

                                ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text('No'),
                                Radio<DejaCarnet?>(
                                  visualDensity: VisualDensity.compact,
                                  // activeColor: primaryColor,
                                  value: DejaCarnet.no,
                                  groupValue: _dejaCarnet,
                                  onChanged: (DejaCarnet? value) {
                                    setState(() {
                                      _dejaCarnet = value!;
                                        controllerPeluqueria.setDejaCarnet('NO');
                                    });
                                  },
                                ),
                              ],
                            ),
                            
                          ],
                        ),
                      ],
                    ),
                     //***********************************************//
                    SizedBox(
                      height: size.iScreen(0.5),
                    ),
                    //*****************************************/
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Realizar en presencia del propietario o persona Autorizada ',
                            style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(1.8),
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                     
                        Row(
                          children: [
                            SizedBox(
                                // color: Colors.red,
                                // width: size.wScreen(10.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text('Si'),
                                    Radio<PresenciaPropietario?>(
                                      visualDensity: VisualDensity.compact,
                                      // activeColor: primaryColor,
                                      value: PresenciaPropietario.si,
                                      groupValue: _presenciaPropietario,
                                      onChanged: (PresenciaPropietario? value) {
                                        setState(() {
                                          _presenciaPropietario = value!;
                                             controllerPeluqueria.setPresenciaPropietario('SI');
                                        });
                                      },
                                    ),
                                  ],
                                )

                                ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text('No'),
                                Radio<PresenciaPropietario?>(
                                  visualDensity: VisualDensity.compact,
                                  // activeColor: primaryColor,
                                  value: PresenciaPropietario.no,
                                  groupValue: _presenciaPropietario,
                                  onChanged: (PresenciaPropietario? value) {
                                    setState(() {
                                      _presenciaPropietario = value!;
                                        controllerPeluqueria.setPresenciaPropietario('NO');
                                    });
                                  },
                                ),
                              ],
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
                    SizedBox(
                      width: size.wScreen(100.0),

                      // color: Colors.blue,
                      child: Text('Deja accesorios. Cuales?',
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: Colors.grey)),
                    ),
                    TextFormField(
                      initialValue: widget.tipo == 'CREATE'
                          ? ''
                          : controllerPeluqueria.getDejaAcesorios,
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
                        controllerPeluqueria
                            .onInputDejaAcesorios(text);
                      },
                      // validator: (text) {
                      //   if (text!.trim().isNotEmpty) {
                      //     return null;
                      //   } else {
                      //     return 'Ingrese Tratamiento';
                      //   }
                      // },
                    ),
                    //***************************************************************************/





















































                  ],
                ),
              ),
            ),
          )),
    );
  }

  //********************************************************************************************************************//
  void _onSubmit(BuildContext context, PeluqueriaController controller,
      String? _actions) async {
    final isValid = controller.validateForm();
    if (!isValid) return;
    if (isValid) {
      if (controller.getNombreMascota == '') {
        NotificatiosnService.showSnackBarDanger('Debe seleccionar Mascota');
      }
      else if (controller.getVetDoctorNombre== '') {
        NotificatiosnService.showSnackBarDanger('Debe seleccionar Vet Responsable');
      }
      else if (controller.getTemperamentoMascota== '') {
        NotificatiosnService.showSnackBarDanger('Debe seleccionar Temperamento');
      }
      else if (controller.getInputHoraIngreso == '') {
        NotificatiosnService.showSnackBarDanger('Debe seleccionar Hora Ingreso');
      }

      // else if (controller.getVetDoctorNombre == '') {
      //   NotificatiosnService.showSnackBarDanger('Debe seleccionar Veterinario');
      // }
      if (controller.getNombreMascota != '' &&
          controller.getTemperamentoMascota != ''&&
          controller.getInputHoraIngreso != '' &&
          controller.getVetDoctorNombre != '') {

        if (widget.tipo == 'CREATE') {
          await controller.creaPeluqueria(context);
          Navigator.pop(context);
        }
        if (widget.tipo == 'EDIT') {
            await controller.editaPeluqueria(context);
          Navigator.pop(context);
        }
          // context.read<controller>().resetFormVacuna();
        // Navigator.pop(context);
      }

    }
  }

  //********************************************************************************************************************//
  _fechaProximaCita(
      BuildContext context, PeluqueriaController controller) async {
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

  void _seleccionaHora(context, PeluqueriaController fechaController) async {
    TimeOfDay? _hora =
        await showTimePicker(context: context, initialTime: timeCita);

    if (_hora != null) {
      String? dateHora = (_hora.hour < 10) ? '0${_hora.hour}' : '${_hora.hour}';
      String? dateMinutos =
          (_hora.minute < 10) ? '0${_hora.minute}' : '${_hora.minute}';

      setState(() {
        timeCita = _hora;
        String horaInicio = '${dateHora}:${dateMinutos}';
        // _horaInicioController.text = horaInicio;
        fechaController.onInputHoraProximaCitaChange(horaInicio);
        //  print('si: $horaInicio');
      });
    }
  }
  //********************************************************************************************************************//

  void _seleccionaHoraIngreso(
      context, PeluqueriaController horaController) async {
    TimeOfDay? _hora =
        await showTimePicker(context: context, initialTime: timeIngreso);

    if (_hora != null) {
      String? dateHora = (_hora.hour < 10) ? '0${_hora.hour}' : '${_hora.hour}';
      String? dateMinutos =
          (_hora.minute < 10) ? '0${_hora.minute}' : '${_hora.minute}';

      setState(() {
        timeIngreso = _hora;
        String horaIngreso = '${dateHora}:${dateMinutos}';
        // _horaInicioController.text = horaInicio;
        horaController.onInputHoraIngresoChange(horaIngreso);
        //  print('si: $horaInicio');
      });
    }
  }

  void _seleccionaHoraSalida(
      context, PeluqueriaController fechaController) async {
    TimeOfDay? _hora =
        await showTimePicker(context: context, initialTime: timeSalida);

    if (_hora != null) {
      String? dateHora = (_hora.hour < 10) ? '0${_hora.hour}' : '${_hora.hour}';
      String? dateMinutos =
          (_hora.minute < 10) ? '0${_hora.minute}' : '${_hora.minute}';

      setState(() {
        timeSalida = _hora;
        String horaIngreso = '${dateHora}:${dateMinutos}';
        // _horaInicioController.text = horaInicio;
        fechaController.onInputHoraSalidaChange(horaIngreso);
        //  print('si: $horaInicio');
      });
    }
  }

  _fecha(BuildContext context, PeluqueriaController controller) async {
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
      controller.setFecha(_fechaInicio);
      // print('FechaInicio: $_fechaInicio');
      // });
    }
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
                                      .read<PeluqueriaController>()
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
  Future<bool?> _buscarTemperamento(BuildContext context, Responsive size) {
    return showDialog<bool>(
        barrierColor: Colors.black54,
        context: context,
        builder: (context) {
          // final controller = context.read<PropietariosController>();
          final controllerMascota = context.read<PeluqueriaController>();

          List _temperamento = [
            "AGRESIVO",
            "NERVIOSO",
            "DOCIL",
            "INQUIETO",
            "REQ. SEDACIÓN"
          ];

          return AlertDialog(
              title: const Text("SELECCIONE TEMPERAMENTO"),
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
                            children: _temperamento
                                .map((e) => GestureDetector(
                                      onTap: () {
                                        // context
                                        //     .read<PeluqueriaController>()
                                        controllerMascota
                                            .setTemperamentoMascota(e);

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
  Future<bool?> _buscarEstado(BuildContext context, Responsive size) {
    return showDialog<bool>(
        barrierColor: Colors.black54,
        context: context,
        builder: (context) {
          // final controller = context.read<PropietariosController>();
          final controllerMascota = context.read<PeluqueriaController>();

          List _estadoCabello = [
            "NORMAL",
            "POCO ENREDADO",
            "ENREDADO",
            "MUY ENREDADO",
            "ANULADA",
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
                            children: _estadoCabello
                                .map((e) => GestureDetector(
                                      onTap: () {
                                        // context
                                        //     .read<PeluqueriaController>()
                                        controllerMascota.setEstadoCabello(e);

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
  Future<bool?> _buscarPedidoCliente(BuildContext context, Responsive size,
      List<String> _listPedido, String _pedido) {
    return showDialog<bool>(
        barrierColor: Colors.black54,
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text(_pedido),
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
                        child: SingleChildScrollView(
                             physics:const  BouncingScrollPhysics(),
                          child: Wrap(
                              children: _listPedido
                                  .map((e) => GestureDetector(
                                        onTap: () {
                                          final controll = context
                                              .read<PeluqueriaController>();
                                          
                                            if(_pedido=='CARA'){
                                          
                                          controll.setPedidoCara(e);
                                            }
                                           else if(_pedido=='COPETE'){
                                          
                                          controll.setPedidoCopete(e);
                                            }
                                           else if(_pedido=='BIGOTES'){
                                          
                                          controll.setPedidoBigotes(e);
                                            }
                                           else if(_pedido=='CEJAS'){
                                          
                                          controll.setPedidoCejas(e);
                                            }
                                           else if(_pedido=='SOLO LOMO'){
                                          
                                          controll.setPedidoSoloLomo(e);
                                            }
                                           else if(_pedido=='COLA'){
                                          
                                          controll.setPedidoCola(e);
                                            }
                                           else if(_pedido=='MANOS Y PATITAS'){
                                          
                                          controll.setPedidoManosYPatas(e);
                                            }
                                           else if(_pedido=='FORMA DE LA CABEZA'){
                                          
                                          controll.setPedidoFormaDeLaCabeza(e);
                                            }
                                           else if(_pedido=='OREJAS'){
                                          
                                          controll.setPedidoOrejas(e);
                                            }
                                           else if(_pedido=='BIGOTES FORMA'){
                                          
                                          controll.setPedidoBigotesForma(e);
                                            }
                                           else if(_pedido=='TODO EL CUERPO'){
                                          
                                          controll.setPedidoTodoElCuerpo(e);
                                            }
                                           else if(_pedido=='FALDON-PECHO-PATAS'){
                                          
                                          controll.setPedidoFaldonPechoPatitas(e);
                                            }
                                           else if(_pedido=='COLA FORMA'){
                                          
                                          controll.setPedidoColaForma(e);
                                            }
                                          
                                          
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
                        ),
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
                                      .read<PeluqueriaController>()
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
}

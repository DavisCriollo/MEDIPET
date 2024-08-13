import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neitorcont/src/controllers/mascotas_controller.dart';
import 'package:neitorcont/src/controllers/recetas_controller.dart';
// import 'package:neitorcont/src/controllers/recetas_controller.dart';
import 'package:neitorcont/src/controllers/reservas_controller.dart';
import 'package:neitorcont/src/data_table/lista_medicina_datasource.dart';
import 'package:neitorcont/src/services/notifications_service.dart';
import 'package:neitorcont/src/services/socket_service.dart';
import 'package:neitorcont/src/theme/themes_app.dart';
import 'package:neitorcont/src/utils/letras_mayusculas_minusculas.dart';

import 'package:neitorcont/src/utils/responsive.dart';
import 'package:neitorcont/src/utils/theme.dart';
import 'package:neitorcont/src/widgets/no_data.dart';

import 'package:provider/provider.dart';

class CrearReserva extends StatefulWidget {
     final String? tipo;
  const CrearReserva({Key? key, this.tipo}) : super(key: key);

  @override
  State<CrearReserva> createState() => _CrearReservaState();
}
enum IgualAnteror { si, no }






class _CrearReservaState extends State<CrearReserva> {
  // TextEditingController _fechaController = TextEditingController();
  final TextEditingController _horaInicioController = TextEditingController();
  

  late TimeOfDay timeInicio;
  @override
  void initState() {
    timeInicio = TimeOfDay.now();
    super.initState();
  }

  @override
  void dispose() {
    // _fechaController.clear();
    _horaInicioController.clear();
    super.dispose();
  }

 IgualAnteror _igualAnteror = IgualAnteror.no;



  DateTime initialDate = DateTime.now();

  DateTime? singleSelect;
  DateTime embeddedCalendar = DateTime.now();
  List<DateTime>? multiSelect;
  List<DateTime>? rangeSelect;
  List<DateTime>? multiOrRangeSelect;

  @override
  Widget build(BuildContext context) {
    // final widget.tipo = ModalRoute.of(context)!.settings.arguments;
    final Responsive size = Responsive.of(context);
    final controllerReserva = context.read<ReservasController>();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: widget.tipo == 'CREATE' || widget.tipo == 'SEARCH'
              ?  Text('Crear Reserva',style:  Theme.of(context).textTheme.headline2,)
              :  Text('Editar Reserva',style:  Theme.of(context).textTheme.headline2,),
          actions: [
            Container(
              margin: EdgeInsets.only(right: size.iScreen(1.5)),
              child: IconButton(
                  splashRadius: 28,
                  onPressed: () {
                    _onSubmit(context);
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
                key: controllerReserva.reservasFormKey,
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
                            child: Container(
                              alignment: Alignment.center,
                              color: primaryColor,
                              width: size.iScreen(3.5),
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
                    // SizedBox(
                    //   width: size.wScreen(100.0),

                    //   // color: Colors.blue,
                    //   child: Text('Nombre de Mascota',
                    //       style: GoogleFonts.lexendDeca(
                    //           // fontSize: size.iScreen(2.0),
                    //           fontWeight: FontWeight.normal,
                    //           color: Colors.grey)),
                    // ),
                    //*****************************************/
                    //***********************************************/
                    // SizedBox(
                    //   height: size.iScreen(1.0),
                    // ),
                    //*****************************************/
                    Consumer<ReservasController>(
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
                    Consumer<ReservasController>(
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
                    Consumer<ReservasController>(
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

                   

                    

                    // //*****************************************/
                    // SizedBox(
                    //   height: size.iScreen(1.0),
                    // ),
                    // //*****************************************/

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
                            child: Text('Tipo de Reserva ',
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
                                    .read<ReservasController>()
                                    .buscaAllTipoReservas('');

                                _buscarTipoReserva(context, size);

                                //*******************************************/
                              },
                              child: Container(
                                alignment: Alignment.center,
                                color: primaryColor,
                                width: size.iScreen(3.5),
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
                    Consumer<ReservasController>(
                      builder: (_, valueDoctor, __) {
                        return SizedBox(
                          width: size.wScreen(100.0),

                          // color: Colors.blue,
                          child: Text(
                              valueDoctor.getTipoReservaNombre!.isEmpty
                                  ? 'DEBE SELECCIONAR TIPO DE RESERVA '
                                  : '${valueDoctor.getTipoReservaNombre} ',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),S
                                  fontWeight: FontWeight.normal,
                                  color: valueDoctor.getTipoReservaNombre!.isEmpty
                                      ? Colors.grey
                                      : Colors.black)),
                        );
                      },
                    ),
                    Consumer<ReservasController>(
                      builder: (_, valueFecha, __) {
                        return Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Fecha',
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
                                      valueFecha.getInputfechaProximaCita!=""
                                          ?valueFecha.getInputfechaProximaCita:'${DateTime.now().year}-${(DateTime.now().month) < 10 ? '0${DateTime.now().month}' : '${DateTime.now().month}'}-${(DateTime.now().day) < 10 ? '0${DateTime.now().day}' : '${DateTime.now().day}'}',
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
                                      color: primaryColor,
                                      size: 30,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                // color:Colors.red,
                                width: size.wScreen(23.0),
                                margin: EdgeInsets.symmetric(
                                    horizontal: size.wScreen(3.5)),
                                child: Row(
                                  children: [
                                    Consumer<ReservasController>(
                                      builder: (_, valueHora, __) {
                                        return Text(
                                          valueHora.getInputHoraProximaCita !=
                                                  ''
                                              ? valueHora
                                                  .getInputHoraProximaCita
                                              : '${DateTime.now().hour}:${DateTime.now().minute}',
                                          style: GoogleFonts.lexendDeca(
                                            fontSize: size.iScreen(1.8),
                                            color: Colors.black45,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        );
                                      },
                                    ),
                                    IconButton(
                                      color: Colors.red,
                                      splashRadius: 20,
                                      onPressed: () {
                                        FocusScope.of(context)
                                            .requestFocus(FocusNode());
                                        _seleccionaHora(context, valueFecha);
                                      },
                                      icon: const Icon(
                                        Icons.access_time_outlined,
                                        color: primaryColor,
                                        size: 20,
                                      ),
                                    ),
                                  ],
                                ),

                               
                              ),
                            ]);
                      },
                    ),
                    
                    // //*****************************************/
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Como la última vez : ',
                          style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(1.8),
                            color: Colors.grey,
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
                                      Radio<IgualAnteror?>(
                                        visualDensity: VisualDensity.compact,
                                        activeColor: primaryColor,
                                        value: IgualAnteror.si,
                                        groupValue: _igualAnteror,
                                        onChanged: (IgualAnteror? value) {
                                          setState(() {
                                            _igualAnteror = value!;
                                              controllerReserva.setProcesoIgualAnterior('SI');
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
                                      Radio<IgualAnteror?>(
                                        visualDensity: VisualDensity.compact,
                                        activeColor: primaryColor,
                                        value: IgualAnteror.no,
                                        groupValue: _igualAnteror,
                                        onChanged: (IgualAnteror? value) {
                                          setState(() {
                                            _igualAnteror = value!;

                                            controllerReserva.setProcesoIgualAnterior('NO');



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
                    // SizedBox(
                    //   height: size.iScreen(2.0),
                    // ),
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
                              child: Container(
                                alignment: Alignment.center,
                                color: primaryColor,
                                width: size.iScreen(3.5),
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
                    Consumer<ReservasController>(
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
                    //******************************/
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
                        initialValue: widget.tipo == 'CREATE'
                            ? ''
                            : controllerReserva.getObservaciones,

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
                          controllerReserva.setObservaciones(text);
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
                   
                    //*****************************************/
                   
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
  void _onSubmit(BuildContext context,
      ) async {


final controller=context.read<ReservasController>();

    final isValid = controller.validateForm();
    if (!isValid) return;
    if (isValid) {
   
      if (controller.getNombreMascota!.isEmpty) {
        NotificatiosnService.showSnackBarDanger('Debe seleccionar Mascota');
      } else if (controller.getDoctoNombre!.isEmpty) {
        NotificatiosnService.showSnackBarDanger('Debe seleccionar Doctor');
      } else if (controller.getTipoReservaNombre!.isEmpty) {
        NotificatiosnService.showSnackBarDanger(
            'Debe seleccionar Tipo de Reserva');
      } 

      if (controller.getNombreMascota! != '' &&
          controller.getDoctoNombre! != '' &&
          controller.getTipoReservaNombre!.isNotEmpty 
         ) {
        if (widget.tipo == 'CREATE') {
          await controller.creaReserva(context);
          Navigator.pop(context);
        //  controller.buscaAllReservasPaginacion('', false);
        }
        if (widget.tipo == 'EDIT') {
          await controller.editaReserva(context);
          Navigator.pop(context);
        }
        // _fechaController.text = '';
        // context.read<MascotasController>().resetFormMascota();
        // Navigator.pop(context);
      }
    }
  }

  //********************************************************************************************************************//

  void _seleccionaHora(context, ReservasController fechaController) async {
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
  _fechaProximaCita(BuildContext context, ReservasController controller) async {
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
                                      .read<ReservasController>()
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
        final controllerReservas = context.read<RecetasController>();

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
                            controllerReservas.onSearchTextMedicinas(text);

                            if (controllerReservas.nameSearchMedicinas.isEmpty) {
                              controllerReservas.buscaAllMedicinas('');
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
        final controlleDoctor = context.read<RecetasController>();

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
                            controlleDoctor.onSearchTexPersonas(text);

                            if (controlleDoctor.nameSearcPersonas.isEmpty) {
                              controlleDoctor.buscaAllDoctores('');
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
                                      .read<ReservasController>()
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
  Future<bool?> _buscarTipoReserva(BuildContext context, Responsive size) {
    return showDialog<bool>(
      barrierColor: Colors.black54,
      context: context,
      builder: (context) {
        // final controller = context.read<PropietariosController>();
        final controllerReservas = context.read<ReservasController>();

        return AlertDialog(
            title: const Text("BUSCAR TIPO DE RESERVA"),
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
                            controllerReservas.onSearchTextTipoReserva(text);

                            if (controllerReservas.nameSearchTipoReserva.isEmpty) {
                              controllerReservas.buscaAllTipoReservas('');
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

                          Consumer<ReservasController>(
                        builder: (_, providerReservas, __) {
                          if (providerReservas.getErrorAllTipoReservas == null) {
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
                          } else if (providerReservas.getErrorAllTipoReservas ==
                              false) {
                            return const NoData(
                              label: 'No existen datos para mostar',
                            );
                            // Text("Error al cargar los datos");
                          } else if (providerReservas
                              .getListaAllTipoReservas.isEmpty) {
                            return const NoData(
                              label: 'No existen datos para mostar',
                            );
                          }
                          // print('esta es la lista*******************: ${providerReservas.getListaPropietarios.length}');

                          return ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount:
                                providerReservas.getListaAllTipoReservas.length,
                            itemBuilder: (BuildContext context, int index) {
                              final _tipo =
                                  providerReservas.getListaAllTipoReservas[index];
                              return GestureDetector(
                                onTap: () {
                                  context
                                      .read<ReservasController>()
                                      .setTipoReservaInfo(_tipo);

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
                                                      '${_tipo['tiporesNombre']}',
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
                              child: Container(
                                alignment: Alignment.center,
                                color: primaryColor,
                                width: size.iScreen(3.5),
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
                    //     // initialValue: widget.tipo == 'CREATE'
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
                        // initialValue: widget.tipo == 'CREATE'
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
                          // _onSubmitMedicamento(
                          //   context,
                          //   controller,
                          // );
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

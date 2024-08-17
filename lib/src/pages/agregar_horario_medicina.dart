import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neitorcont/src/controllers/hospitalizacion_controller.dart';
import 'package:neitorcont/src/services/socket_service.dart';
import 'package:neitorcont/src/utils/responsive.dart';
import 'package:provider/provider.dart';

class AgregarHorarios extends StatelessWidget {
   AgregarHorarios(
      {Key? key, required this.action, required this.infoItemHora})
      : super(key: key);

  final String action;
  final Map<String, dynamic> infoItemHora;


  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    final controllers = context.read<HospitalizacionController>();

    //AGREGAR SI DA PROBLEMA

      controllers.setH0(infoItemHora['H0']);
      controllers.setH1(infoItemHora['H1']);
      controllers.setH2(infoItemHora['H2']);
      controllers.setH3(infoItemHora['H3']);
      controllers.setH4(infoItemHora['H4']);
      controllers.setH5(infoItemHora['H5']);
      controllers.setH6(infoItemHora['H6']);
      controllers.setH7(infoItemHora['H7']);
      controllers.setH8(infoItemHora['H8']);
      controllers.setH9(infoItemHora['H9']);
      controllers.setH10(infoItemHora['H10']);
      controllers.setH11(infoItemHora['H11']);
      controllers.setH12(infoItemHora['H12']);
      controllers.setH13(infoItemHora['H13']);
      controllers.setH14(infoItemHora['H14']);
      controllers.setH15(infoItemHora['H15']);
      controllers.setH16(infoItemHora['H16']);
      controllers.setH17(infoItemHora['H17']);
      controllers.setH18(infoItemHora['H18']);
      controllers.setH19(infoItemHora['H19']);
      controllers.setH20(infoItemHora['H20']);
      controllers.setH21(infoItemHora['H21']);
      controllers.setH22(infoItemHora['H22']);
      controllers.setH23(infoItemHora['H23']);
      controllers.setOrderMedicina(infoItemHora['order']);

     

//==================PROCESOS DE HORARIOS========================//
    final controllerHospitalizacion = context.read<HospitalizacionController>();
    final List horariosMedicina = [];
    final List horariosAux = [];
    for (var i = 0; i <= 23; i++) {
      horariosAux.add(i);
    }

    var _data = horariosAux.where(
      (x) => x <= int.parse(infoItemHora['_inicio'].toString()),
    );
    var _dataCon = horariosAux.where(
      (x) => x >= int.parse(infoItemHora['_inicio'].toString()),
    );
    final List<dynamic> _horariosMmedicina = [];
    final List<dynamic> _auxMedicinaFercuencia = [];

    _horariosMmedicina.addAll(_data.toList());
    _auxMedicinaFercuencia.addAll(_dataCon.toList());

    horariosMedicina.addAll(_horariosMmedicina);

    var i = 1;
    while (i <= _auxMedicinaFercuencia.length) {
      horariosMedicina.add(
        _auxMedicinaFercuencia[i - 1] += int.parse(infoItemHora['_frecuencia'].toString()),
      );

      i += int.parse(infoItemHora['_frecuencia'].toString());
    }

//===============================================================//

    return Scaffold(
      appBar: AppBar(
        title:  Text('Horario Medicina'),
        actions: [
          Consumer<SocketService>(builder: (_, valueConexion, __) {
            return valueConexion.serverStatus == ServerStatus.Online
                ? Container(
                    margin: EdgeInsets.only(right: size.iScreen(1.5)),
                    child: IconButton(
                        splashRadius: 28,
                        onPressed: () {
                          _onSubmit(
                            context,
                            controllers,
                            action,
                            infoItemHora['idCabecera'],
                            infoItemHora['nameMedicinaHorarios'],
                            infoItemHora['_inicio'].toString(),
                            infoItemHora['_frecuencia'].toString(),
                            infoItemHora['order'],
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
        margin: EdgeInsets.only(
            left: size.iScreen(1.0),
            right: size.iScreen(1.0),
            bottom: size.iScreen(1.0)),
        width: size.wScreen(100),
        height: size.hScreen(100),
        child: SingleChildScrollView(
          // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: size.iScreen(2.0)),
                  width: size.wScreen(100.0),
                  child: Text(
                    // 'item Novedad: ${controllerActividades.getItemMulta}',
                    '" ${infoItemHora['nameMedicinaHorarios']} "',
                    textAlign: TextAlign.center,
                    //
                    style: GoogleFonts.lexendDeca(
                        fontSize: size.iScreen(2.3),
                        // color: Colors.white,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                Form(
                  key: controllers.hospitalizacionHorariosFormKey,
                  child: Wrap(
                      alignment: WrapAlignment.start,
                      direction: Axis.horizontal,
                      children: List.generate(24, (index) {
                        return Consumer<HospitalizacionController>(
                          builder: (_, valueInput, __) {
                            return Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                //***********************************************/
                                SizedBox(
                                  height: size.iScreen(1.5),
                                ),
                                //*****************************************/
                                Container(
                                  width: size.wScreen(5.0),

                                  // color: Colors.blue,
                                  // child: Text('${index * _frecuencia+1}',
                                  child: Text('$index',
                                      style: GoogleFonts.lexendDeca(
                                          // fontSize: size.iScreen(2.0),
                                          fontWeight: FontWeight.normal,
                                          color: Colors.grey)),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: size.iScreen(2.0)),
                                  width: size.wScreen(12.0),
                                  child: TextFormField(
                                    readOnly: index >=
                                            int.parse(infoItemHora['_inicio'].toString())
                                        ? horariosMedicina.contains(index)
                                            // index>=_inicio?_frecuencia*index>=index
                                            ? false
                                            : true
                                        : true,

                                    initialValue: index >=
                                            int.parse(infoItemHora['_inicio'].toString())
                                        ? horariosMedicina.contains(index)
                                            //  index>=_inicio? _frecuencia*index>=index
                                            ? index == 0
                                                ? infoItemHora['H0']
                                                : index == 1
                                                    ? infoItemHora['H1']
                                                    : index == 2
                                                        ? infoItemHora['H2']
                                                        : index == 3
                                                            ? infoItemHora[
                                                                'H3']
                                                            : index == 4
                                                                ? infoItemHora[
                                                                    'H4']
                                                                : index == 5
                                                                    ? infoItemHora[
                                                                        'H5']
                                                                    : index ==
                                                                            6
                                                                        ? infoItemHora[
                                                                            'H6']
                                                                        : index == 7
                                                                            ? infoItemHora['H7']
                                                                            : index == 8
                                                                                ? infoItemHora['H8']
                                                                                : index == 9
                                                                                    ? infoItemHora['H9']
                                                                                    : index == 10
                                                                                        ? infoItemHora['H10']
                                                                                        : index == 11
                                                                                            ? infoItemHora['H11']
                                                                                            : index == 12
                                                                                                ? infoItemHora['H12']
                                                                                                : index == 13
                                                                                                    ? infoItemHora['H13']
                                                                                                    : index == 14
                                                                                                        ? infoItemHora['H14']
                                                                                                        : index == 15
                                                                                                            ? infoItemHora['H15']
                                                                                                            : index == 16
                                                                                                                ? infoItemHora['H16']
                                                                                                                : index == 17
                                                                                                                    ? infoItemHora['H17']
                                                                                                                    : index == 18
                                                                                                                        ? infoItemHora['H18']
                                                                                                                        : index == 19
                                                                                                                            ? infoItemHora['H19']
                                                                                                                            : index == 20
                                                                                                                                ? infoItemHora['H20']
                                                                                                                                : index == 21
                                                                                                                                    ? infoItemHora['H21']
                                                                                                                                    : index == 22
                                                                                                                                        ? infoItemHora['H22']
                                                                                                                                        : index == 23
                                                                                                                                            ? infoItemHora['H23']
                                                                                                                                            : ''
                                            : '- - - '
                                        : '- - -',

                                    // _hora0,
                                    decoration: InputDecoration(
                                      filled: index >=
                                              int.parse(
                                                  infoItemHora['_inicio'].toString())
                                          ? horariosMedicina.contains(index)
                                              // filled:  index>=_inicio? _frecuencia*index>=index
                                              ? false
                                              : true
                                          : true,

                                      // suffixIcon: Icon(Icons.beenhere_outlined)
                                    ),
                                    textAlign: TextAlign.center,
                                    // maxLines: 3,
                                    // minLines: 1,
                                    style: TextStyle(
                                      fontSize: size.iScreen(2.0),
                                      // fontWeight: FontWeight.bold,
                                      // letterSpacing: 2.0,
                                    ),
                                    onChanged: (text) {
                                      controllers.setHData(text, index);
                                    },
                                    // validator: (text) {
                                    //   if (text!.trim().isNotEmpty) {
                                    //     return null;
                                    //   } else {
                                    //     return 'Ingrese Hora';
                                    //   }
                                    // },
                                  ),
                                ),
                                 //***********************************************/
                                SizedBox(
                                  height: size.iScreen(2.0),
                                ),
                                //*****************************************/
                              ],
                            );
                          },
                        );
                      })),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //********************************************************************************************************************//
  void _onSubmit(
      BuildContext context,
      HospitalizacionController controller,
      String _action,
      int _cabecera,
      String _nomMedicamento,
      String _inicio,
      String _frecuencia,
      String _order) async {
    final isValid = controller.validateFormHorarios();
    if (!isValid) return;
    if (isValid) {
      controller.setHorarioMedicina(
          _cabecera, _nomMedicamento, _inicio, _frecuencia, _order);



      // if (_action == 'MEDICAMENTOS') {
      //   // await controller.creaHospitalizacion(context);

      //     controller.setInfoRowHorarioMedicina(
      //                          _cabecera, _nomMedicamento, _inicio, _frecuencia
      //                                                    );
      // }
      // controller.setNombreMedicina(
      //             _nomMedicamento);
      //         controller.setInicioMedicina(
      //             _inicio);
      //         controller.setFrecuenciaMedicina(
      //            _frecuencia);
      //         controller.setOrderMedicina(
      //            _order);

      Navigator.pop(context);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neitorcont/src/controllers/hospitalizacion_controller.dart';
import 'package:neitorcont/src/pages/agregar_horario_medicina.dart';
import 'package:neitorcont/src/services/notifications_service.dart';
import 'package:neitorcont/src/utils/letras_mayusculas_minusculas.dart';
import 'package:neitorcont/src/utils/responsive.dart';
import 'package:neitorcont/src/utils/theme.dart';
import 'package:neitorcont/src/widgets/no_data.dart';

import 'package:provider/provider.dart';

class HorarioMedicinaHospitalizacionDTS extends DataTableSource {
  final BuildContext context;
  final List<dynamic> _listaHoraMedicamentos;
  final Responsive size;
  final String? accion;
  final int inicio, frecuencia;
    final bool? detalle;

  HorarioMedicinaHospitalizacionDTS(this._listaHoraMedicamentos, this.size,
      this.context, this.accion, this.inicio, this.frecuencia, this.detalle);

  final controller = HospitalizacionController();
  @override
  DataRow? getRow(int index) {
    // if(detalle==false){

    // }
    // _listaHoraMedicamentos
    //     .sort((a, b) => b['idCabecera'].compareTo(a['idCabecera']));

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Row(
          children: [
            detalle==true? 
            IconButton(
              onPressed: () {
         
             
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>  AgregarHorarios(
                          action: 'MEDICAMENTOS',
                          infoItemHora:_listaHoraMedicamentos[index] ,

                        )));

//              

                //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++//
              },
              icon: const Icon(
                Icons.edit,
                color: tercearyColor,
              ),
              splashRadius: 20.0,
            ):Container(),
            // :        Text(''),
            Text(_listaHoraMedicamentos[index]['fecha']),
          ],
        )),
        DataCell(Text('${_listaHoraMedicamentos[index]['idCabecera']}'
            '${_listaHoraMedicamentos[index]['nameMedicinaHorarios']}')),
        DataCell(Text(_listaHoraMedicamentos[index]['H0'] != ""
            ? _listaHoraMedicamentos[index]['H0']
            : '====')),
        DataCell(Text(_listaHoraMedicamentos[index]['H1'] != "" 
            ? _listaHoraMedicamentos[index]['H1']
            : "===")),
        DataCell(Text(_listaHoraMedicamentos[index]['H2'] != "" 
            ? _listaHoraMedicamentos[index]['H2']
            : "===")),
        DataCell(Text(_listaHoraMedicamentos[index]['H3'] != "" 
            ? _listaHoraMedicamentos[index]['H3']
            : "===")),
        DataCell(Text(_listaHoraMedicamentos[index]['H4'] != "" 
            ? _listaHoraMedicamentos[index]['H4']
            : "===")),
        DataCell(Text(_listaHoraMedicamentos[index]['H5'] != "" 
            ? _listaHoraMedicamentos[index]['H5']
            : "===")),
        DataCell(Text(_listaHoraMedicamentos[index]['H6'] != "" 
            ? _listaHoraMedicamentos[index]['H6']
            : "===")),
        DataCell(Text(_listaHoraMedicamentos[index]['H7'] != "" 
            ? _listaHoraMedicamentos[index]['H7']
            : "===")),
        DataCell(Text(_listaHoraMedicamentos[index]['H8'] != "" 
            ? _listaHoraMedicamentos[index]['H8']
            : "===")),
        DataCell(Text(_listaHoraMedicamentos[index]['H9'] != "" 
            ? _listaHoraMedicamentos[index]['H9']
            : "===")),
        DataCell(Text(_listaHoraMedicamentos[index]['H10'] != "" 
            ? _listaHoraMedicamentos[index]['H10']
            : "===")),
        DataCell(Text(_listaHoraMedicamentos[index]['H11'] != "" 
            ? _listaHoraMedicamentos[index]['H11']
            : "===")),
        DataCell(Text(_listaHoraMedicamentos[index]['H12'] != "" 
            ? _listaHoraMedicamentos[index]['H12']
            : "===")),
        DataCell(Text(_listaHoraMedicamentos[index]['H13'] != "" 
            ? _listaHoraMedicamentos[index]['H13']
            : "===")),
        DataCell(Text(_listaHoraMedicamentos[index]['H14'] != "" 
            ? _listaHoraMedicamentos[index]['H14']
            : "===")),
        DataCell(Text(_listaHoraMedicamentos[index]['H15'] != "" 
            ? _listaHoraMedicamentos[index]['H15']
            : "===")),
        DataCell(Text(_listaHoraMedicamentos[index]['H16'] != "" 
            ? _listaHoraMedicamentos[index]['H16']
            : "===")),
        DataCell(Text(_listaHoraMedicamentos[index]['H17'] != "" 
            ? _listaHoraMedicamentos[index]['H17']
            : "===")),
        DataCell(Text(_listaHoraMedicamentos[index]['H18'] != "" 
            ? _listaHoraMedicamentos[index]['H18']
            : "===")),
        DataCell(Text(_listaHoraMedicamentos[index]['H19'] != "" 
            ? _listaHoraMedicamentos[index]['H19']
            : "===")),
        DataCell(Text(_listaHoraMedicamentos[index]['H20'] != "" 
            ? _listaHoraMedicamentos[index]['H20']
            : "===")),
        DataCell(Text(_listaHoraMedicamentos[index]['H21'] != "" 
            ? _listaHoraMedicamentos[index]['H21']
            : "===")),
        DataCell(Text(_listaHoraMedicamentos[index]['H22'] != "" 
            ? _listaHoraMedicamentos[index]['H22']
            : "===")),
        DataCell(Text(_listaHoraMedicamentos[index]['H23'] != "" 
            ? _listaHoraMedicamentos[index]['H23']
            : "===")),
      ],
    );
  }



  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _listaHoraMedicamentos.length;

  @override
  int get selectedRowCount => 0;
}

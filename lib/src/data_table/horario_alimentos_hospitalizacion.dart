import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neitorcont/src/controllers/hospitalizacion_controller.dart';
import 'package:neitorcont/src/pages/agregar_horario_alimento.dart';
import 'package:neitorcont/src/services/notifications_service.dart';
import 'package:neitorcont/src/utils/letras_mayusculas_minusculas.dart';
import 'package:neitorcont/src/utils/responsive.dart';
import 'package:neitorcont/src/utils/theme.dart';
import 'package:neitorcont/src/widgets/no_data.dart';

import 'package:provider/provider.dart';

class HorarioAlimentosHospitalizacionDTS extends DataTableSource {
  final BuildContext context;
  final List<dynamic> _listaHoraAlimentos;
  final Responsive size;
  final String? accion;
  final int inicio, frecuencia;
   final bool? detalle;

  HorarioAlimentosHospitalizacionDTS(this._listaHoraAlimentos, this.size,
      this.context, this.accion, this.inicio, this.frecuencia, this.detalle);

  @override
  DataRow? getRow(int index) {
    // _listaHoraAlimentos
    //     .sort((a, b) => b['idCabeceraAlimento'].compareTo(a['idCabeceraAlimento']));

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Row(
          children: [
         detalle==true?    IconButton(
              onPressed: () {
                // _agregaHorariosAlimentos(context, size, int.parse(_listaHoraAlimentos[index]['_inicio']), int.parse(_listaHoraAlimentos[index]['_frecuencia']),_listaHoraAlimentos[index]['idCabeceraAlimento']);
              
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>  AgregarHorariosAlimento(
                          action: 'ALIMENTOS',
                          infoItemHora:_listaHoraAlimentos[index] ,

                        )));
              
              
              },
              icon: const Icon(
                Icons.edit,
                color: tercearyColor,
              ),
              splashRadius: 20.0,
            ):Container(),
            Text(_listaHoraAlimentos[index]['fecha']),
    
          ],
        )),
        DataCell(Text(
          
               '${_listaHoraAlimentos[index]['nameAlimentosHorarios']}')),
        DataCell(Text(_listaHoraAlimentos[index]['H0']!=""?_listaHoraAlimentos[index]['H0']:'==='),),
        DataCell(Text(_listaHoraAlimentos[index]['H1']!=""?_listaHoraAlimentos[index]['H1']:'===')),
        DataCell(Text(_listaHoraAlimentos[index]['H2']!=""?_listaHoraAlimentos[index]['H2']:'===')),
        DataCell(Text(_listaHoraAlimentos[index]['H3']!=""?_listaHoraAlimentos[index]['H3']:'===')),
        DataCell(Text(_listaHoraAlimentos[index]['H4']!=""?_listaHoraAlimentos[index]['H4']:'===')),
        DataCell(Text(_listaHoraAlimentos[index]['H5']!=""?_listaHoraAlimentos[index]['H5']:'===')),
        DataCell(Text(_listaHoraAlimentos[index]['H6']!=""?_listaHoraAlimentos[index]['H6']:'===')),
        DataCell(Text(_listaHoraAlimentos[index]['H7']!=""?_listaHoraAlimentos[index]['H7']:'===')),
        DataCell(Text(_listaHoraAlimentos[index]['H8']!=""?_listaHoraAlimentos[index]['H8']:'===')),
        DataCell(Text(_listaHoraAlimentos[index]['H9']!=""?_listaHoraAlimentos[index]['H9']:'===')),
        DataCell(Text(_listaHoraAlimentos[index]['H10']!=""?_listaHoraAlimentos[index]['H10']:'===')),
        DataCell(Text(_listaHoraAlimentos[index]['H11']!=""?_listaHoraAlimentos[index]['H11']:'===')),
        DataCell(Text(_listaHoraAlimentos[index]['H12']!=""?_listaHoraAlimentos[index]['H12']:'===')),
        DataCell(Text(_listaHoraAlimentos[index]['H13']!=""?_listaHoraAlimentos[index]['H13']:'===')),
        DataCell(Text(_listaHoraAlimentos[index]['H14']!=""?_listaHoraAlimentos[index]['H14']:'===')),
        DataCell(Text(_listaHoraAlimentos[index]['H15']!=""?_listaHoraAlimentos[index]['H15']:'===')),
        DataCell(Text(_listaHoraAlimentos[index]['H16']!=""?_listaHoraAlimentos[index]['H16']:'===')),
        DataCell(Text(_listaHoraAlimentos[index]['H17']!=""?_listaHoraAlimentos[index]['H17']:'===')),
        DataCell(Text(_listaHoraAlimentos[index]['H18']!=""?_listaHoraAlimentos[index]['H18']:'===')),
        DataCell(Text(_listaHoraAlimentos[index]['H19']!=""?_listaHoraAlimentos[index]['H19']:'===')),
        DataCell(Text(_listaHoraAlimentos[index]['H20']!=""?_listaHoraAlimentos[index]['H20']:'===')),
        DataCell(Text(_listaHoraAlimentos[index]['H21']!=""?_listaHoraAlimentos[index]['H21']:'===')),
        DataCell(Text(_listaHoraAlimentos[index]['H22']!=""?_listaHoraAlimentos[index]['H22']:'===')),
        DataCell(Text(_listaHoraAlimentos[index]['H23']!=""?_listaHoraAlimentos[index]['H23']:'===')),
      ],
     
    );
  }

  void _eliminaRow(int index) {
    context
        .read<HospitalizacionController>()
        .eliminaAlimentoAgregada(_listaHoraAlimentos[index]['idCabeceraAlimento']);
  }





  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _listaHoraAlimentos.length;

  @override
  int get selectedRowCount => 0;
}

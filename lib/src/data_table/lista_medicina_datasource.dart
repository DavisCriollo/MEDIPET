import 'package:flutter/material.dart';
import 'package:neitorcont/src/controllers/recetas_controller.dart';
import 'package:neitorcont/src/utils/responsive.dart';

import 'package:provider/provider.dart';

class ListaMedimamentosDTS extends DataTableSource {
  final BuildContext context;
  final List<dynamic> _listaMedicamentos;
  final Responsive size;
  final String? accion;

  ListaMedimamentosDTS(this._listaMedicamentos, this.size, this.context, this.accion);

  

// final List<Map<String, dynamic>>itemsPedido=[];


  @override
  DataRow? getRow(int index) {

 _listaMedicamentos.sort((a, b) => b['order'].compareTo(a['order']));



    return DataRow.byIndex(
    
      index: index,
      cells: [
         DataCell(Text(_listaMedicamentos[index]['medicina'])),
        DataCell(Text(_listaMedicamentos[index]['cantidad'])),
        // DataCell(Text(_listaMedicamentos[index]['serie']!+null?_listaMedicamentos[index]['serie']:'000')),
        DataCell(Text(_listaMedicamentos[index]['tratamiento'])),
        DataCell(Text(_listaMedicamentos[index]['serie']??'----')),
        
      ],
        onLongPress: accion=='NUEVO'?() {
          context.read<RecetasController>().eliminaMedicinaAgregada(_listaMedicamentos[index]['order']);
        // print('ESTE SE ELIMINARA: ${_listaMedicamentos[index]['idItem']}');

      }:null,
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _listaMedicamentos.length;

  @override
  int get selectedRowCount => 0;
}

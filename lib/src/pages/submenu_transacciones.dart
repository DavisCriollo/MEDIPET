import 'package:flutter/material.dart';
import 'package:neitorcont/src/controllers/anuladas_controller.dart';
import 'package:neitorcont/src/controllers/comprobantes_controller.dart';
import 'package:neitorcont/src/controllers/facturas_controller.dart';
import 'package:neitorcont/src/controllers/notas_creditos_controller.dart';
import 'package:neitorcont/src/controllers/prefacturas_controller.dart';
import 'package:neitorcont/src/controllers/proformas_controller.dart';
import 'package:neitorcont/src/pages/crear_comprobante_print.dart';
import 'package:neitorcont/src/pages/listar_anuladas_paginacion.dart';
import 'package:neitorcont/src/pages/listar_facturas.dart';
import 'package:neitorcont/src/pages/listar_facturas_paginacion.dart';
import 'package:neitorcont/src/pages/listar_notas_credito.dart';
import 'package:neitorcont/src/pages/listar_notas_credito_paginacion.dart';
import 'package:neitorcont/src/pages/listar_prefacturas.dart';
import 'package:neitorcont/src/pages/listar_prefacturas_paginacion.dart';
import 'package:neitorcont/src/pages/listar_proformas.dart';
import 'package:neitorcont/src/pages/listar_proformas_paginacion.dart';

import 'package:neitorcont/src/services/socket_service.dart';
import 'package:neitorcont/src/utils/responsive.dart';
import 'package:neitorcont/src/widgets/elementos_submenu.dart';
import 'package:neitorcont/src/widgets/no_data.dart';
import 'package:provider/provider.dart';

class SubmenuTransacciones extends StatelessWidget {
  const SubmenuTransacciones({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title:  Text('TRANSACCIONES'),
        ),
        body: Container(
            width: size.wScreen(100),
            height: size.hScreen(100),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF973592).withOpacity(0.5),
                  const Color(0xFF0092D0).withOpacity(0.3),
                ],
                stops: const [0.1, 0.6],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Center(
                      child: Wrap(children: [
                        ElementosSubmenu(
                          enabled: true,
                          size: size,
                          image: 'assets/imgs/factura.png',
                          label: "FACTURAS",
                          color: Colors.green,
                          // onTap: () => Navigator.pushNamed(context, 'mascotas'),
                          onTap: () {
                            final _controllerFacturas =
                                context.read<FacturasController>();

                            _controllerFacturas
                                .onSearchTextFacturaPaginacion("");

                            _controllerFacturas
                                .setBtnSearchFacturaPaginacion(false);
                            _controllerFacturas
                                .setErrorFacturasPaginacion(null);

                            _controllerFacturas
                                .setError401FacturasPaginacion(false);

                            _controllerFacturas.resetFormFacturas();
                            _controllerFacturas.setPage(0);
                            _controllerFacturas.setIsNext(false);
                            _controllerFacturas
                                .setInfoBusquedaFacturasPaginacion([]);
                            _controllerFacturas.buscaAllFacturasPaginacion(
                                '',false,0);

                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const ListarFacturasPaginacion()));
                          },
                        ),
                        ElementosSubmenu(
                          enabled: true,
                          size: size,
                          image: 'assets/imgs/prefactura.png',
                          label: 'PREFACTURAS',
                          color: Colors.pink,
                          // onTap: () => Navigator.pushNamed(context, 'mascotas'),
                          onTap: () {
                            final _controllerPreFacturas =
                                context.read<PreFacturasController>();

                            _controllerPreFacturas
                                .onSearchTextPreFacturaPaginacion("");

                            _controllerPreFacturas
                                .setBtnSearchPreFacturaPaginacion(false);
                            _controllerPreFacturas
                                .setErrorPreFacturasPaginacion(null);

                            _controllerPreFacturas
                                .setError401PreFacturasPaginacion(false);

                            _controllerPreFacturas.resetFormPreFacturas();
                            _controllerPreFacturas.setPage(0);
                            _controllerPreFacturas.setIsNext(false);
                            _controllerPreFacturas
                                .setInfoBusquedaPreFacturasPaginacion([]);
                            _controllerPreFacturas
                                .buscaAllPreFacturasPaginacion('', true,0);

                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const ListarPreFacturasPaginacion()));
                          },
                        ),
                        ElementosSubmenu(
                          enabled: true,
                          size: size,
                          image: 'assets/imgs/proforma.png',
                          label: 'PROFORMAS',
                          color: Colors.blue,
                          // onTap: () => Navigator.pushNamed(context, 'mascotas'),
                          onTap: () {
                            final _controllerProformas =
                                context.read<ProformasController>();

                            _controllerProformas
                                .onSearchTextProformasPaginacion("");

                            _controllerProformas
                                .setBtnSearchProformasPaginacion(false);
                            _controllerProformas
                                .setErrorProformasPaginacion(null);

                            _controllerProformas
                                .setError401ProformasPaginacion(false);

                            _controllerProformas.resetFormProformas();
                            _controllerProformas.setPage(0);
                            _controllerProformas.setIsNext(false);
                            _controllerProformas
                                .setInfoBusquedaProformasPaginacion([]);
                            _controllerProformas.buscaAllProformasPaginacion(
                                '', true,0);

                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const ListarProformasProformas()));
                          },
                        ),
                        ElementosSubmenu(
                          enabled: true,
                          size: size,
                          image: 'assets/imgs/nota_credito.png',
                          label: 'NOTAS CREDITO',
                          color: Colors.brown,
                          // onTap: () => Navigator.pushNamed(context, 'mascotas'),
                          onTap: () {


                      final _controllerNotasCredito =
                                context.read<NotasCreditosController>();

                            _controllerNotasCredito
                                .onSearchTextNotasCreditoPaginacion("");

                            _controllerNotasCredito
                                .setBtnSearchNotasCreditoPaginacion(false);
                            _controllerNotasCredito
                                .setErrorNotasCreditosPaginacion(null);

                            _controllerNotasCredito
                                .setError401NotasCreditosPaginacion(false);

                            _controllerNotasCredito.resetFormNotasCreditos();
                            _controllerNotasCredito.setPage(0);
                            _controllerNotasCredito.setIsNext(false);
                            _controllerNotasCredito
                                .setInfoBusquedaNotasCreditosPaginacion([]);
                            _controllerNotasCredito.buscaAllNotasCreditosPaginacion(
                                '', true,0);




                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const ListarNotasCreditoPaginacion()));
                          },
                        ),
                        ElementosSubmenu(
                          enabled: true,
                          size: size,
                          image: 'assets/imgs/fac_rejected.png',
                          label: 'SIN AUTORIZAR / ANULADAS',
                          color: Colors.redAccent,
                          // onTap: () => Navigator.pushNamed(context, 'mascotas'),
                          onTap: () {


                      final _controllerAnuladas =
                                context.read<AnuladasController>();

                            _controllerAnuladas
                                .onSearchTextAnuladaPaginacion("");

                            _controllerAnuladas
                                .setBtnSearchAnuladaPaginacion(false);
                            _controllerAnuladas
                                .setErrorAnuladasPaginacion(null);

                            _controllerAnuladas
                                .setError401AnuladasPaginacion(false);

                            _controllerAnuladas.resetFormAnuladas();
                            _controllerAnuladas.setPage(0);
                            _controllerAnuladas.setIsNext(false);
                            _controllerAnuladas
                                .setInfoBusquedaAnuladasPaginacion([]);
                            _controllerAnuladas.buscaAllAnuladasPaginacion(
                                '', true,0);


                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const ListarAnuladasPaginacion()));
                          },
                        ),
                        //   ElementosSubmenu(
                        //   enabled: true,
                        //   size: size,
                        //   image: 'assets/imgs/time.png',
                        //   label: 'COMPROBANTE',
                        //   color: Colors.purple,
                        //   // onTap: () => Navigator.pushNamed(context, 'mascotas'),
                        //   onTap: () {

                        //         final _ctrl =context.read<ComprobantesController>();

                        //       _ctrl.setTotal();
                        //       _ctrl.setTarifa({});
                        //        _ctrl.setTipoDocumento('');
                        //     Navigator.of(context).push(MaterialPageRoute(
                        //         builder: (context) =>
                        //             const CrearComprobante(
                        //               tipo: 'CREATE',
                        //             )));
                        //   },
                        // ),
                     
                      ]),
                    )
              ));
  }
}

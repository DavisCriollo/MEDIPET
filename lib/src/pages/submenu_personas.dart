import 'package:flutter/material.dart';
import 'package:neitorcont/src/controllers/propietarios_controller.dart';
import 'package:neitorcont/src/utils/responsive.dart';
import 'package:neitorcont/src/widgets/elementos_submenu.dart';
import 'package:provider/provider.dart';

class SubmenuPersonas extends StatelessWidget {
  const SubmenuPersonas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title:  Text('PERSONAS',style:  Theme.of(context).textTheme.headline2,),
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
                  image: 'assets/imgs/client.png',
                  label: "CLIENTES",
                  color: Colors.green,
                  // onTap: () => Navigator.pushNamed(context, 'mascotas'),
                  onTap: () {

                    context
                        .read<PropietariosController>()
                        .searchAllPersinas('');

                    Navigator.pushNamed(context, 'ListaClientes');


                  },
                ),
                ElementosSubmenu(
                  enabled: true,
                  size: size,
                  image: 'assets/imgs/owner.png',
                  label: 'PROPIETARIOS',
                  color: Colors.pink,
                  // onTap: () => Navigator.pushNamed(context, 'mascotas'),
                  onTap: () {
                    context
                        .read<PropietariosController>()
                        .buscaAllPropietarios('');

                    Navigator.pushNamed(context, 'listaPropietarios');
                  },
                ),
                // ElementosSubmenu(
                //   enabled: true,
                //   size: size,
                //   image: 'assets/imgs/prescription.png',
                //   label: 'RECETAS',
                //   color: Colors.blue,
                //   // onTap: () => Navigator.pushNamed(context, 'mascotas'),
                //   onTap: () {},
                // ),
                // ElementosSubmenu(
                //   enabled: true,
                //   size: size,
                //   image: 'assets/imgs/syringe.png',
                //   label: 'VACUNAS',
                //   color: Colors.brown,
                //   // onTap: () => Navigator.pushNamed(context, 'mascotas'),
                //   onTap: () {},
                // ),
                // ElementosSubmenu(
                //   enabled: true,
                //   size: size,
                //   image: 'assets/imgs/hospital_medical.png',
                //   label: 'HOSPITALIZACIÓN',
                //   color: Colors.purple.shade900,
                //   // onTap: () => Navigator.pushNamed(context, 'mascotas'),
                //   onTap: () {},
                // ),
                // ElementosSubmenu(
                //   enabled: true,
                //   size: size,
                //   image: 'assets/imgs/calendar.png',
                //   label: 'PELUQUERIA',
                //     color: Colors.purple,
                //   // onTap: () => Navigator.pushNamed(context, 'mascotas'),
                //   onTap: () {},
                // ),
              ]),
            )));
  }
}

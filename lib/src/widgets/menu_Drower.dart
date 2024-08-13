import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neitorcont/src/api/authentication_client.dart';
import 'package:neitorcont/src/models/sesison_model.dart';
import 'package:neitorcont/src/utils/dialogs.dart';
import 'package:neitorcont/src/utils/responsive.dart';
import 'package:neitorcont/src/utils/theme.dart';
import 'package:share_plus/share_plus.dart';

//

class MenuPrincipal extends StatelessWidget {
  final Session? user;

  const MenuPrincipal({Key? key, this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // final authService = Provider.of<AuthService>(context);
    // final socketService = Provider.of<SocketService>(context);
    // final usuario = authService.usuario;

    // print('codigo: ${user!.codigo}');
    // print('usuario: ${user!.usuario}');

    final Responsive size = Responsive.of(context);
    return Drawer(
      child: Column(
        children: [
          SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: size.iScreen(2.0)),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  // color: Colors.red,
                  // border: Border.all(color: Colors.blue),
                  ),
              width: size.wScreen(100),
              // height: size.wScreen(46.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(size.iScreen(0.1)),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                          color: primaryColor, width: size.iScreen(0.5)),
                    ),
                    width: size.iScreen(13),
                    height: size.iScreen(13),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: user!.logo != ''
                          ? FadeInImage(
                              image: NetworkImage(
                                '${user!.foto}',
                                scale: size.wScreen(30.0),
                              ),
                              placeholder: const AssetImage(
                                'assets/imgs/loader.gif',
                              ),
                              imageErrorBuilder: (context, error, stackTrace) {
                                return Image.asset('assets/imgs/profile.png',
                                    width: size.iScreen(10.0));
                              },
                              fit: BoxFit.fitWidth,
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: const Image(
                                image: AssetImage('assets/imgs/profile.png'),
                                fit: BoxFit.cover,
                              )

                              // const Image(
                              //   image: AssetImage('assets/imgs/profile.png'),
                              //   fit: BoxFit.cover,
                              ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    // color:Colors .red,
                    margin: EdgeInsets.only(top: size.iScreen(2.0)),
                    child: Column(
                      children: [
                        Text('${user!.nombre}',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                                // fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.bold
                                // color: Colors.white,
                                )),
                        SizedBox(
                          height: size.iScreen(0.5),
                        ),
                        Text('${user!.usuario}',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                                // fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.bold
                                // color: Colors.white,
                                )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: _ListaOpciones(),
          ),
          ListTile(
            title: Text('Acerca de',
                style: GoogleFonts.roboto(
                    fontSize: size.iScreen(2.0), fontWeight: FontWeight.bold
                    // color: Colors.white,
                    )),
            leading: const Icon(FontAwesomeIcons.questionCircle,
                color: primaryColor),
            trailing: Icon(
              FontAwesomeIcons.chevronRight,
              size: size.iScreen(1.6),
            ),
            onTap: () {},
          ),
          ListTile(
            title: Text('Cerrar Sesión',
                style: GoogleFonts.roboto(
                    fontSize: size.iScreen(2.0), fontWeight: FontWeight.bold
                    // color: Colors.white,
                    )),
            leading: const Icon(FontAwesomeIcons.signOutAlt,
                color: Color(0xFF963494)),
            trailing: Icon(
              FontAwesomeIcons.chevronRight,
              size: size.iScreen(1.6),
            ),
            onTap: () async {
              // socketService.disconnect();
              // Navigator.pushReplacementNamed(context, 'login');
              // AuthService.deleteToken();

              //==================================================//
              // ProgressDialog.show(context);
              Navigator.pop(context);

              // final response = await homeController.sentTokenDelete();
              // ProgressDialog.dissmiss(context);

              // final recuerdaCredenciales=  await Auth.instance.getDataRecordarme();
              // loginController.getCredenciales(recuerdaCredenciales);
              // await Auth.instance.deleteDataRecordarme();
              await Auth.instance.deleteSesion(context);
              // await Auth.instance.deleteIdRegistro();

              //==================================================//
              // ProgressDialog.show(context);
// //
//                  homeController.setBotonTurno(false);
//                   final response = await homeController.sentTokenDelete();
//                   ProgressDialog.dissmiss(context);

//                   Auth.instance.deleteSesion(context);
//                   Auth.instance.deleteIdRegistro();
//                   Auth.instance.deleteTurnoSesion();

              //==================================================//
            },
          ),
        ],
      ),
    );
  }
}

class _ListaOpciones extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);

    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        // _ItemsMenu(
        //   enabled: true,
        //   icon: FontAwesomeIcons.addressBook,
        //   title: 'Agendar Cita',
        //   page: '',
        //   size: size,
        // ),
        // _ItemsMenu(
        //   enabled: true,
        //   icon: FontAwesomeIcons.paw,
        //   title: 'Mis Mascotas',
        //   page: '',
        //   size: size,
        // ),
        // _ItemsMenu(
        //   enabled: true,
        //   icon: FontAwesomeIcons.fileInvoiceDollar,
        //   title: 'Mis Facturas',
        //   page: '',
        //   size: size,
        // ),
        // _ItemsMenu(
        //   enabled: false,
        //   icon: FontAwesomeIcons.cartPlus,
        //   title: 'Compras',
        //   // page: 'compras',
        //   page: '',
        //   size: size,
        // ),
        // _ItemsMenu(
        //   enabled: false,
        //   icon: FontAwesomeIcons.commentAlt,
        //   title: 'Chat',
        //   // page: 'usuarios',
        //   page: '',
        //   size: size,
        // ),
        Container(
          child: Column(
            children: [
              Ink(
                color: Colors.transparent,
                child: ListTile(
                  enabled: true,
                  dense: true,
                  leading: Icon(
                    Icons.share_outlined,
                    color: Color(0xFF963494),
                  ),
                  title: Text(
                    'Compartir',
                    style: GoogleFonts.roboto(
                      fontSize: size.iScreen(2.0),
                      color: Colors.black,
                    ),
                  ),
                  trailing: Icon(
                    FontAwesomeIcons.chevronRight,
                    size: size.iScreen(2.2),
                  ),
                  onTap: () {
                    // _showAlertDialogShared(context);

                    Navigator.pop(context);
                    _modalShare(context, size);
                  },
                ),
              ),
              Divider(
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),

        // _ItemsMenu(
        //   enabled: false,
        //   icon: Icons.share_outlined,
        //   title: 'Compartir',
        //   page: '',
        //   size: size,
        // ),
        _ItemsMenu(
          enabled: true,
          icon: Icons.video_settings_outlined,
          // FontAwesomeIcons.shareAlt,
          title: 'Tutoriales',
          page: 'listaVideos',
          size: size,
        ),
      ],
    );
  }

  Future<void> _modalShare(BuildContext context, Responsive size) {
    return showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(
          'Compatir',
          style: GoogleFonts.roboto(
              fontSize: size.iScreen(2.0),
              color: primaryColor,
              fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: () {
               Navigator.pop(context);
                // _onShare(context, 'https://play.google.com/store/apps/details?id=com.neitor.neitor_vet');
                _onShare(context, 'https://acortar.link/2vcGR4');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Android',
                    style: GoogleFonts.roboto(
                        fontSize: size.iScreen(2.2),
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: size.iScreen(1.0),
                  ),
                  const Icon(
                    Icons.android_outlined,
                    color: Colors.green,
                  )
                ],
              ),
            ),
            TextButton(
              onPressed: () {
               Navigator.pop(context);
                // _onShare(context, 'https://play.google.com/store/apps/details?id=com.neitor.neitor_vet');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'IOS',
                    style: GoogleFonts.roboto(
                        fontSize: size.iScreen(2.2),
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: size.iScreen(1.0),
                  ),
                  const Icon(
                    Icons.apple_outlined,
                    color: Colors.black,
                  )
                ],
              ),
            ),

           
          ],
        ),
   
      ),
    );
  }

  void _onShare(BuildContext context,String _urlApp) async {
    final box = context.findRenderObject() as RenderBox?;

    await Share.share(
        _urlApp,
        subject: 'NeitorVet App',
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }
}

class _ItemsMenu extends StatelessWidget {
  final Responsive size;
  final bool enabled;
  final String title;
  final IconData icon;
  final String page;
  const _ItemsMenu({
    required this.title,
    required this.enabled,
    required this.icon,
    required this.page,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Ink(
          color: (enabled == false) ? Colors.grey[300] : Colors.transparent,
          child: ListTile(
            enabled: enabled,
            dense: true,
            leading: Icon(
              icon,
              color: Color(0xFF963494),
            ),
            title: Text(
              title,
              style: GoogleFonts.roboto(
                fontSize: size.iScreen(2.0),
                color: Colors.black,
              ),
            ),
            trailing: Icon(
              FontAwesomeIcons.chevronRight,
              size: size.iScreen(2.2),
            ),
            onTap: () {
              Navigator.popAndPushNamed(context, page);
            },
          ),
        ),
        Divider(
          color: Theme.of(context).primaryColor,
        ),
      ],
    );
  }

//=========================================//

}
  

//=========================================//



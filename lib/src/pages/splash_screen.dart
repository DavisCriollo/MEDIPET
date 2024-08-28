import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:neitorcont/src/api/api_provider.dart';
import 'package:neitorcont/src/api/authentication_client.dart';
import 'package:neitorcont/src/controllers/home_controller.dart';
import 'package:neitorcont/src/controllers/login_controller.dart';
import 'package:neitorcont/src/models/auth_response.dart';
import 'package:neitorcont/src/models/sesison_model.dart';
import 'package:neitorcont/src/pages/home_page.dart';
import 'package:neitorcont/src/pages/login_page.dart';
import 'package:neitorcont/src/theme/theme_provider.dart';
import 'package:neitorcont/src/theme/themes_app.dart';
import 'package:neitorcont/src/utils/responsive.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final controllerLogin = LoginController();
  final controllerHome = HomeController();
  // final controllerAppTheme = AppTheme();
    final controllerTheme = ThemeProvider();
    final _api = ApiProvider();
   Session? session ;

  @override
  void initState() {
    super.initState();
// VERIFICO SI EL CONTEXTO  ESTA INICIALIZADO//
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _chechLogin();
      
    });
  }

  _chechLogin() async {
   session = await Auth.instance.getSession();
 

// Future.delayed(Duration(seconds: 1),(){
  // final BuildContext _size;




// final _size=Responsive.of(context);
//      int? _primColor=int.parse(session!.colorPrimario!.replaceAll("#",'0xff'));
//   int? _secColor=int.parse(session.colorSecundario!.replaceAll("#",'0xff'));
// Color? _colorPrimario=Color(_primColor);
// Color? _colorSecundario=Color(_secColor);

// Provider.of<AppTheme>(context,listen: false).setAppTheme(true,'',_colorPrimario,Colors.white,_colorSecundario,_size);
// print('veces q repite:');
//   });


    if (session != null) {
  

    controllerHome.setUsuarioInfo(session);

   final primaryColorHex = session!.colorPrimario ?? '#2196fd'; // Valor por defecto
    final accentColorHex = session!.colorSecundario ?? '#FF4081'; // Valor por defecto

    final primaryColor = hexToColor(primaryColorHex);
    final accentColor = hexToColor(accentColorHex);

    Provider.of<ThemeProvider>(context, listen: false)
        .setTheme(primaryColorHex, accentColorHex);
    
 




      final   response = await _api. revisaToken(session!.token);
      // print('revisa token============> :$response');
       
       if(response==404||response==401){
           Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginPage()),
          (Route<dynamic> route) => false);
       }else{

         controllerTheme.setTheme(session!.colorSecundario, session!.colorSecundario);
          Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomePage(user: session)),
          (Route<dynamic> route) => false);
       }
      
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginPage()),
          (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
  //  Provider.of<AppTheme>(context,listen: false).setResponsive(size);
  // controllerAppTheme.setResponsive(size);

// Future.delayed(Duration(seconds: 1),(){
//   // final BuildContext _size;
//      int? _primColor=int.parse(session!.colorPrimario!.replaceAll("#",'0xff'));
//   int? _secColor=int.parse(session!.colorSecundario!.replaceAll("#",'0xff'));
// Color? _colorPrimario=Color(_primColor);
// Color? _colorSecundario=Color(_secColor);
// // final _size=Responsive.of(context);
// Provider.of<AppTheme>(context,listen: false).setAppTheme(true,'',_colorPrimario,Colors.white,size,_colorSecundario);
// print('veces q repite:');
//   });









    
    
    return Scaffold(
      body: SizedBox(
        width: size.wScreen(100.0),
        height: size.hScreen(100.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              SizedBox(
                height: size.iScreen(2.0),
              ),
              const Text('Preparando Contenido.... '),
            ],
          ),
        ),
      ),
    );
  }


Color hexToColor(String hexString) {
  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
  buffer.write(hexString.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}

}

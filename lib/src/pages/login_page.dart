// import 'package:awesome_icons/awesome_icons.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neitorcont/src/api/authentication_client.dart';
import 'package:neitorcont/src/controllers/login_controller.dart';
import 'package:neitorcont/src/pages/home_page.dart';
import 'package:neitorcont/src/pages/splash_screen.dart';
import 'package:neitorcont/src/services/notifications_service.dart';
import 'package:neitorcont/src/utils/dialogs.dart';
import 'package:neitorcont/src/utils/letras_mayusculas_minusculas.dart';
import 'package:neitorcont/src/utils/responsive.dart';
import 'package:neitorcont/src/utils/theme.dart';

import 'package:provider/provider.dart';
// import 'package:neitor_vet_app/src/widgets/inputs.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final logData = LoginController();
TextEditingController? _textEmpresa= TextEditingController();
TextEditingController? _textUsuario= TextEditingController();
TextEditingController? _textClave= TextEditingController();

@override
  void initState() {
 inicialData();
    super.initState();
  }


void inicialData() async{

final datosRecordarme=await Auth.instance.getDataRecordarme();
//  logData.getCredenciales(datosRecordarme);
// print('dddd ${datosRecordarme}');
if(datosRecordarme!=null && datosRecordarme[0]=='true'){
_textEmpresa!.text= '${datosRecordarme[1]}';
_textUsuario!.text= '${datosRecordarme[2]}';
_textClave!.text= '${datosRecordarme[3]}';

 logData.onRecuerdaCredenciales(true);
// setState(() {
//    _isCheck=logData.getRecuerdaCredenciales!;
// });
 logData.onChangeEmpresa(datosRecordarme[1]);
 logData.onChangeUser(datosRecordarme[2]);
 logData.onChangeClave(datosRecordarme[3]);

}else if(datosRecordarme==null ||datosRecordarme[0]=='false'){
_textEmpresa!.text= '';
_textUsuario!.text= '';
_textClave!.text= '';
}

}


  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    return SafeArea(
      child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: ChangeNotifierProvider(
            create: (_) => LoginController(),
            builder: (context, __) {

               final controller = Provider.of<LoginController>(context);
              return Scaffold(
                // backgroundColor: const Color(0xFFDEEAF6),
                backgroundColor: Colors.white,
                body: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Container(
                        //   width: size.wScreen(100),
                        //   // margin: EdgeInsets.only(bottom: size.iScreen(2.0)),
                        //   height: size.hScreen(35),
                        //   child: Stack(
                        //     alignment: Alignment.center,
                        //     children: [
                        //       // Header(),
                        // Center(
                        //   child: Container(
                        //     width: size.wScreen(50),
                        //     height: size.hScreen(50),
                        //     // color: Colors.red,
                        //     // padding: EdgeInsets.all(5.0),
                        //     child: Image.asset(
                        //       'assets/imgs/logo_neitor.png',
                        //       fit: BoxFit.contain,
                        //     ),
                        //   ),
                        // ),
                        //     ],
                        //   ),
                        // ),
                    
                        Container(
                          // height: size.hScreen(50.0),
                          // color: Color(0xFFDEEAF6),
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(
                            horizontal: size.wScreen(8.0),
                          ),
                          child: Form(
                            key: controller.loginFormKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Container(
                                //   margin:
                                //       EdgeInsets.symmetric(vertical: size.iScreen(1.0)),
                                //   child: ClipRRect(
                                //     borderRadius: BorderRadius.circular(6.0),
                                //     child: Container(
                                //       height: size.iScreen(5.5),
                                //       decoration: BoxDecoration(
                                //         border: Border.all(
                                //             width: 0.50, color: Colors.black87),
                                //         borderRadius: BorderRadius.circular(6.0),
                                //       ),
                                //       child: Row(
                                //         children: [
                                //           Container(
                                //             decoration: BoxDecoration(
                                //               color: Color(0xFF22398E),
                                //               border: Border.all(
                                //                   width: 0.5, color: Color(0xFF22398E)),
                                //             ),
                                //             width: size.iScreen(5.5),
                                //             height: size.iScreen(5.5),
                                //             child: const Icon(
                                //               FontAwesomeIcons.userTie,
                                //               color: Colors.white,
                                //             ),
                                //           ),
                                //           Expanded(
                                //             child: Container(
                                //               padding: EdgeInsets.symmetric(
                                //                   horizontal: size.iScreen(0.5)),
                                //               child: InputsText(
                                //                 textColtroller: emailControl,
                                //                 size: size,
                                //                 hintsText: ' Correo',
                                //                 obscureText: false,
                                //                 keyboardType:
                                //                     TextInputType.emailAddress,
                                //               ),
                                //             ),
                                //           ),
                                //         ],
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                // Container(
                                //   margin:
                                //       EdgeInsets.symmetric(vertical: size.iScreen(1.0)),
                                //   child: ClipRRect(
                                //     borderRadius: BorderRadius.circular(6.0),
                                //     child: Container(
                                //       height: size.iScreen(5.5),
                                //       decoration: BoxDecoration(
                                //         border: Border.all(
                                //             width: 0.50, color: Colors.black87),
                                //         borderRadius: BorderRadius.circular(6.0),
                                //       ),
                                //       child: Row(
                                //         children: [
                                //           Container(
                                //             width: size.iScreen(5.5),
                                //             height: size.iScreen(5.5),
                                //             color: Color(0xFF22398E),
                                //             child: Icon(
                                //               FontAwesomeIcons.lock,
                                //               color: Colors.white,
                                //             ),
                                //           ),
                                //           Expanded(
                                //             child: Container(
                                //               padding: EdgeInsets.symmetric(
                                //                   horizontal: size.iScreen(0.5)),
                                //               child: InputsText(
                                //                 size: size,
                                //                 textColtroller: passwordControl,
                                //                 hintsText: ' Contraseña',
                                //                 obscureText: true,
                                //                 keyboardType: TextInputType.text,
                                //               ),
                                //             ),
                                //           ),
                                //         ],
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                Center(
                                  child: Container(
                                    // width: size.wScreen(50),
                                    // height: size.hScreen(50),
                                    // color: Colors.red,
                                    // padding: EdgeInsets.all(5.0),
                                    child: Image.asset(
                                      'assets/imgs/logoNeitor.png',
                                      width: size.wScreen(45.0),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                //***********************************************/
                                SizedBox(
                                  height: size.iScreen(2.0),
                                ),
                    
                                //*****************************************/
                                SizedBox(
                                  width: size.wScreen(100.0),
                                  // color: Colors.blue,
                                  child: Text('Empresa',
                                      style: GoogleFonts.lexendDeca(
                                        // fontSize: size.iScreen(2.0),
                                        fontWeight: FontWeight.normal,
                                        color: Colors.grey,
                                      )),
                                ),
                                TextFormField(
                                  controller: _textEmpresa,
                                  // initialValue: 'demo',
                                  // initialValue: (textUsuario.text==true)? textUsuario.text:'',
                    
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.business_outlined,
                                      color: primaryColor,
                                    ),
                                  ),
                                   inputFormatters: [
                                  UpperCaseText(),
                                ],
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                    
                                      // fontSize: size.iScreen(3.5),
                                      // fontWeight: FontWeight.bold,
                                      // letterSpacing: 2.0,
                                      ),
                                  onChanged: (text) {
                                    controller.onChangeEmpresa(text);
                                  },
                                  validator: (text) {
                                    if (text!.trim().isNotEmpty) {
                                      return null;
                                    } else {
                                      return 'Debe ingresar Veterinaria';
                                    }
                                  },
                                  onSaved: (value) {
                                    // codigo = value;
                                    controller.onChangeEmpresa(value!);
                                  },
                                ),
                                //***********************************************/
                                SizedBox(
                                  height: size.iScreen(2.0),
                                ),
                    
                                //*****************************************/
                                SizedBox(
                                  width: size.wScreen(100.0),
                                  // color: Colors.blue,
                                  child: Text('Usuario',
                                      style: GoogleFonts.lexendDeca(
                                        // fontSize: size.iScreen(2.0),
                                        fontWeight: FontWeight.normal,
                                        color: Colors.grey,
                                      )),
                                ),
                                TextFormField(
                                  controller: _textUsuario,
                                  // initialValue: 'demo',
                                  // initialValue: (textUsuario.text==true)? textUsuario.text:'',
                    
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.person_outline_outlined,
                                      color: primaryColor,
                                    ),
                                  ),
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                    
                                      // fontSize: size.iScreen(3.5),
                                      // fontWeight: FontWeight.bold,
                                      // letterSpacing: 2.0,
                                      ),
                                  onChanged: (text) {
                                    controller.onChangeUser(text);
                                  },
                                  validator: (text) {
                                    if (text!.trim().isNotEmpty) {
                                      return null;
                                    } else {
                                      return 'Debe ingresar Usuario';
                                    }
                                  },
                                  onSaved: (value) {
                                    // codigo = value;
                                    controller.onChangeUser(value!);
                                  },
                                ),
                    
                                //***********************************************/
                                SizedBox(
                                  height: size.iScreen(2.0),
                                ),
                    
                                //*****************************************/
                                SizedBox(
                                  width: size.wScreen(100.0),
                                  // color: Colors.blue,
                                  child: Text('Clave',
                                      style: GoogleFonts.lexendDeca(
                                        // fontSize: size.iScreen(2.0),
                                        fontWeight: FontWeight.normal,
                                        color: Colors.grey,
                                      )),
                                ),
                                TextFormField(
                                  obscureText: _obscureText,
                                  controller: _textClave,
                                  // initialValue: 'demo',
                                  // initialValue: (textUsuario.text==true)? textUsuario.text:'',
                    
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.lock_open_rounded,
                                      color: primaryColor,
                                    ),
                                    suffixIcon: IconButton(
                                        splashRadius: 5.0,
                                        onPressed: () {
                                          setState(() {
                                            _obscureText = !_obscureText;
                                          });
                                        },
                                        icon: _obscureText
                                            ? const Icon(
                                                Icons.visibility_off_outlined)
                                            : const Icon(
                                                Icons.remove_red_eye_outlined,
                                                color: primaryColor,
                                              )),
                                  ),
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                    
                                      // fontSize: size.iScreen(3.5),
                                      // fontWeight: FontWeight.bold,
                                      // letterSpacing: 2.0,
                                      ),
                                  onChanged: (text) {
                                    controller.onChangeClave(text);
                                  },
                                  validator: (text) {
                                    if (text!.trim().isNotEmpty) {
                                      return null;
                                    } else {
                                      return 'Debe ingresar Clave';
                                    }
                                  },
                    
                                  onSaved: (value) {
                                    // codigo = value;
                                    controller.onChangeClave(value!);
                                  },
                                ),
                    
                                //***********************************************/
                                SizedBox(
                                  height: size.iScreen(2.0),
                                ),
                                //*****************************************/
                    
                                //===========================================//
                                Container(
                                  // color: Colors.red,
                                  width: size.wScreen(100.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        // color: Colors.redAccent,
                                        alignment: Alignment.centerRight,
                                        margin: EdgeInsets.only(
                                          top: size.iScreen(1.0),
                                          bottom: size.iScreen(3.0),
                                          left: size.iScreen(0.0),
                                          right: size.iScreen(0.0),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Consumer<LoginController>(
                                              builder: (_, provider, __) {
                                                return Row(
                                                  children: [
                                                    Container(
                                                      // color: Colors.red,
                                                      child: Checkbox(
                                                          activeColor: primaryColor,
                                                          // checkColor: Colors.green,
                                                          // fillColor: Colors.red,
                                                          focusColor:
                                                              Colors.white,
                                                          value: provider
                                                              .getRecuerdaCredenciales,
                                                          // value: true,
                                                          onChanged: (value) {
                                                            provider
                                                                .onRecuerdaCredenciales(
                                                                    value!);
                                                            // print(value);
                                                          }),
                                                    ),
                                                    Text(
                                                      'Recordarme',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              fontSize: size
                                                                  .iScreen(1.7),
                                                              // fontWeight: FontWeight.bold,
                                                              color:
                                                                  Colors.grey),
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, 'password');
                                        },
                                        child: Ink(
                                          child: Container(
                                            // width: size.wScreen(100.0),
                                            // alignment: Alignment.centerRight,
                                            // color: Colors.red,
                                            margin: EdgeInsets.only(
                                              top: size.iScreen(0.0),
                                              bottom: size.iScreen(2.0),
                                              left: size.iScreen(0.0),
                                              right: size.iScreen(0.0),
                                            ),
                                            padding: EdgeInsets.only(
                                              top: size.iScreen(0.5),
                                              bottom: size.iScreen(0.5),
                                              left: size.iScreen(2.0),
                                              right: size.iScreen(.0),
                                            ),
                                            child: Text(
                                              '¿Olvidé mi Clave?',
                                              style: GoogleFonts.lexendDeca(
                                                  fontSize: size.iScreen(1.7),
                                                  fontWeight: FontWeight.bold,
                                                  color: primaryColor),
                                            ),
                                          ),
                                        ),
                                      ),
                    
                                      // GestureDetector(
                                      //   onTap: () {
                                      //     Navigator.pushNamed(context, 'password');
                                      //   },
                                      //   child: Ink(
                                      //     child: Container(
                                      //       // alignment: Alignment.centerRight,
                                      //       // color: Colors.red,
                                      //       margin: EdgeInsets.only(
                                      //           top: size.iScreen(2.0),
                                      //           bottom: size.iScreen(2.0),
                                      //           left: size.iScreen(2.0),
                                      //           right: size.iScreen(4.0),
                                      //           ),
                                      //           padding: EdgeInsets.only(
                                      //           top: size.iScreen(0.5),
                                      //           bottom: size.iScreen(0.5),
                                      //           left: size.iScreen(2.0),
                                      //           right: size.iScreen(.0),
                                      //           ),
                                      //       child: Text(
                                      //         '¿Olvidé mi Clave?',
                                      //         style: GoogleFonts.lexendDeca(
                                      //             fontSize: size.iScreen(1.7),
                                      //             fontWeight: FontWeight.bold,
                                      //             color: primaryColor),
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                    
                                SizedBox(height: size.iScreen(1.0)),
                    
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: const Color(0XFF963594),
                                        border: Border.all(
                                            width: 1.5, color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                    width: size.wScreen(100.0),
                                    height: size.iScreen(5.0),
                                    child: TextButton(
                                      // splashColor: Colors.transparent,
                                      // padding: EdgeInsets.symmetric(horizontal: size.iScreen(2.0)),
                                      onPressed: () {
                                        // Navigator.pushReplacementNamed(
                                        //     context, 'home');
                    
                    
                    _onSubmit(context,controller);
                    
                    
                    
                    
                    
                    
                                      },
                                      child: Text(
                                        'Ingresar',
                                        style: GoogleFonts.lexendDeca(
                                          fontSize: size.iScreen(2.0),
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                // BtnLogin(
                                //   size: size,
                                //   onpressed: () async {
                                //     FocusScope.of(context).unfocus();
                                //     final loginOk = await authService.login(
                                //         emailControl.text.trim(),
                                //         passwordControl.text.trim());
                                //     emailControl.text = "";
                                //     passwordControl.text = "";
                    
                                //     if (loginOk) {
                                //       socketService.connect();
                                //       Navigator.pushReplacementNamed(context, 'home');
                                //     } else {
                                //       mostarAlerta(context, 'Login Incorrecto',
                                //           'Revise sus credenciales');
                                //     }
                                //   },
                                // ),
                                // Container(
                                //   margin: EdgeInsets.only(
                                //       top: size.iScreen(2.0),
                                //       bottom: size.iScreen(8.0)),
                                //   alignment: Alignment.centerRight,
                                //   width: size.wScreen(100),
                                //   padding: EdgeInsets.symmetric(vertical: 4.0),
                                //   child: GestureDetector(
                                //     onTap: () {
                                //       Navigator.pushNamed(
                                //           context, 'recuperarContrasena');
                                //     },
                                //     child: Text(
                                //       'Olvidé contraseña',
                                //       style: GoogleFonts.lexendDeca(
                                //         fontSize: size.iScreen(2.0),
                                //         fontWeight: FontWeight.bold,
                                //         color: Colors.black87,
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                // ClipRRect(
                                //   borderRadius: BorderRadius.circular(10.0),
                                //   child: Container(
                                //     decoration: BoxDecoration(
                                //         color: Color(0XFF0092D0),
                                //         border:
                                //             Border.all(width: 1.5, color: Colors.white),
                                //         borderRadius: BorderRadius.circular(10.0)),
                                //     width: size.wScreen(60.0),
                                //     height: size.iScreen(5.05),
                                //     child: TextButton(
                                //       // splashColor: Colors.transparent,
                                //       // padding: EdgeInsets.symmetric(
                                //       //     horizontal: size.iScreen(1.0)),
                                //       onPressed: () {
                                //         // Navigator.pushReplacementNamed(context, 'zona');
                                //       },
                                //       child: Text(
                                //         'Seleccionar otra Veterinaria',
                                //         style: GoogleFonts.lexendDeca(
                                //           fontSize: size.iScreen(1.8),
                                //           color: Colors.white,
                                //           fontWeight: FontWeight.bold,
                                //         ),
                                //       ),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          )),
    );
  }







  void _onSubmit(BuildContext context, LoginController controller) async {
    final isValid = controller.validateForm();
     controller.loginFormKey.currentState?.save();
    if (!isValid) return;
    if (isValid) {
        final conexion = await Connectivity().checkConnectivity();
      // if (controller.getlNombreEmpresa==null) {
      //     NotificatiosnService.showSnackBarError('Seleccione Empresa');
      //   }
    if (conexion == ConnectivityResult.none) {
        NotificatiosnService.showSnackBarError('N A INTERNET');
      } else if (conexion == ConnectivityResult.wifi ||
          conexion == ConnectivityResult.mobile) {
            


 ProgressDialog.show(context);
            final response = await controller.loginApp(context);
            ProgressDialog.dissmiss(context);
              
              
              
               if (response != null) {
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute<void>(
              //       builder: (BuildContext context) => const HomePage(
              //          )),
              
              Navigator.pushReplacement(
                context,
                MaterialPageRoute<void>(
                    builder: (BuildContext context) => const SplashPage())
                      
              );
            }



//  Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute<void>(
//                     builder: (BuildContext context) => const SplashScreen())
                      
//               );




    //     final controllerHome = HomeController();
    //     final status = await Permission.location.request();
    //  if (status == PermissionStatus.granted) {
    //       // print('============== SI TIENE PERMISOS');
    //       await controllerHome.getCurrentPosition();
    //       if (controllerHome.getCoords != '') {
    //         ProgressDialog.show(context);
    //         final response = await controller.loginApp(context);
    //         ProgressDialog.dissmiss(context);
    //         if (response != null) {
    //           // Navigator.pushReplacement(
    //           //   context,
    //           //   MaterialPageRoute<void>(
    //           //       builder: (BuildContext context) => HomeMenu(
    //           //           tipo: controller.infoUser!.rol,
    //           //           user: controller.infoUser,
    //           //           ubicacionGPS: controllerHome.getCoords)),
              
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute<void>(
              //       builder: (BuildContext context) => const SplashPage())
                      
              // );
    //         }
    //       }
    //     } else {
    //       // print('============== NOOOO TIENE PERMISOS');
    //       Navigator.pushNamed(context, 'gps');
    //     }
      }
    }
  }


}

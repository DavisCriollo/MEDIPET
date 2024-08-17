// import 'package:flutter/material.dart';
// import 'package:neitorcont/src/services/notifications_service.dart';

// import 'package:provider/provider.dart';


// // import 'package:socket_io_client/socket_io_client.dart' as IO;

// import 'package:socket_io_client/socket_io_client.dart' as IO;

// enum ServerStatus {
//   Online,
//   Ofline,
//   Connecting,
// }

// class SocketService extends ChangeNotifier {
//   ServerStatus _serverStatus = ServerStatus.Connecting;

  

// // EXPONER DE MANERA PRIVADA PARA CONTROLAR LA MANERA DE EXPOSICION AL MUBDO , PANTALLA, CLASE
//   late IO.Socket? _socket;

//   ServerStatus get serverStatus => _serverStatus;
//   // String? _serverResponses;
//   // String? get serverResponses => _serverResponses;

//   IO.Socket? get socket => _socket;

//   SocketService() {
   
//     _initConfig();
//   }

//   void _initConfig() {
//     // Dart client
//     // _socket = IO.io('https://contabackend.neitor.com', {
//     // _socket = IO.io('http://192.168.1.4:3000', {
//     //       'transports': ['websocket'],
//     //   'autoConnect': true,
//     // });
//     _socket = IO.io(
//     'https://contabackend.neitor.com',
//         IO.OptionBuilder()
//             .setTransports(['websocket']) // for Flutter or Dart VM
//             .enableAutoConnect()
//             // .setExtraHeaders({'foo': 'bar'}) // optional
//             .build());


 

//     _socket?.onConnect((_) {
//       print('David conectado desde Flutter !!! ');
//       _serverStatus = ServerStatus.Online;
      
//       // NotificatiosnService.showSnackBarSuccsses("Bienvenido");


//       notifyListeners();
//     });

//     _socket?.onDisconnect((_) {
//       print('disconnect desde Flutter !!!');
//       _serverStatus = ServerStatus.Ofline;

      

//       // NotificatiosnService.showSnackBarError("Sin conexión");
//       // _socket = null;
//       notifyListeners();
//     });

   
   
//   }
// }


import 'package:flutter/material.dart';
import 'package:neitorcont/src/controllers/home_controller.dart';
import 'package:neitorcont/src/controllers/propietarios_controller.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:neitorcont/src/services/notifications_service.dart';

// enum ServerStatus {
//   Online,
//   Offline,
//   Connecting,
// }

// class SocketService extends ChangeNotifier {
//   ServerStatus _serverStatus = ServerStatus.Connecting;
//   late IO.Socket? _socket;
//   bool _snackbarShown = false;

//   ServerStatus get serverStatus => _serverStatus;
//   IO.Socket? get socket => _socket;

//   SocketService() {
//     _initConfig();
//   }

//   void _initConfig() {
//     _socket = IO.io(
//       'https://contabackend.neitor.com',
//       IO.OptionBuilder()
//           .setTransports(['websocket'])
//           .enableAutoConnect()
//           .build(),
//     );

//     _socket?.onConnect((_) {
//       print('Conectado desde Flutter !!!');
//       _serverStatus = ServerStatus.Online;
//       _showSnackbar("Conexión exitosa");
//       notifyListeners();
//     });

//     _socket?.onDisconnect((_) {
//       print('Desconectado desde Flutter !!!');
//       _serverStatus = ServerStatus.Offline;
//       _showSnackbar("Sin conexión");
//       notifyListeners();
//     });
//   }

//   void _showSnackbar(String message) {
//     if (!_snackbarShown) {
//       NotificatiosnService.showSnackBarDanger(message);
//       _snackbarShown = true;
//       Future.delayed(Duration(seconds: 2), () {
//         _snackbarShown = false;
//       });
//     }
//   }
// }




//****************************//

// enum ServerStatus {
//   Online,
//   Offline,
//   Connecting,
// }

// class SocketService extends ChangeNotifier {
//   static final SocketService _instance = SocketService._internal();
  
//   factory SocketService() => _instance;

//   SocketService._internal() {
//     _initConfig();
//   }

//   ServerStatus _serverStatus = ServerStatus.Connecting;
//   late IO.Socket? _socket;
//   bool _snackbarShown = false;

//   ServerStatus get serverStatus => _serverStatus;
//   IO.Socket? get socket => _socket;

//   void _initConfig() {
//     _socket = IO.io(
//       'https://contabackend.neitor.com',
//       IO.OptionBuilder()
//           .setTransports(['websocket'])
//           .enableAutoConnect()
//           .build(),
//     );

//     _socket?.onConnect((_) {
//       print('Conectado desde Flutter !!!');
//       _serverStatus = ServerStatus.Online;
//       _showSnackbar("Conexión exitosa");
//       notifyListeners();
//     });

//     _socket?.onDisconnect((_) {
//       print('Desconectado desde Flutter !!!');
//       _serverStatus = ServerStatus.Offline;
//       _showSnackbar("Sin conexión");
//       notifyListeners();
//     });

//     _socket?.on('response', (data) {
//       // Maneja la respuesta del servidor aquí
//       print('Respuesta del servidor: $data');
//       notifyListeners();
//     });
//   }

//   void _showSnackbar(String message) {
//     if (!_snackbarShown) {
//       NotificatiosnService.showSnackBarDanger(message);
//       _snackbarShown = true;
//       Future.delayed(Duration(seconds: 2), () {
//         _snackbarShown = false;
//       });
//     }
//   }

//   void sendMessage(String event, Map<String, dynamic> message) {
//     _socket?.emit(event, message);
//   }
// }



//************************//

enum ServerStatus {
  Online,
  Offline,
  Connecting,
}

class SocketService extends ChangeNotifier {


  
  static final SocketService _instance = SocketService._internal();
  
  factory SocketService() => _instance;

  SocketService._internal() {
    _initConfig();
  }

  ServerStatus _serverStatus = ServerStatus.Connecting;
  late IO.Socket? _socket;
  bool _snackbarShown = false;

  ServerStatus get serverStatus => _serverStatus;
  IO.Socket? get socket => _socket;

  void _initConfig() {
    _socket = IO.io(
      'https://contabackend.neitor.com',
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .enableAutoConnect()
          .build(),
    );

    _socket?.onConnect((_) {
      print('Conectado desde Flutter !!!');
      _serverStatus = ServerStatus.Online;
      // _showSnackbar("Conexión exitosa", 'success');
      notifyListeners();
    });

    _socket?.onDisconnect((_) {
      print('Desconectado desde Flutter !!!');
      _serverStatus = ServerStatus.Offline;
      // _showSnackbar("Sin conexión", 'error');
      notifyListeners();
    });

//     _socket?.on('response', (data) {

//       final _ctrlPropietario=PropietariosController();


//       // Maneja la respuesta del servidor aquí
//       _showSnackbar('Respuesta del servidor: $data', 'info');

// //  //******************************//
// //   serviceSocket.socket!.on('server:guardadoExitoso', (data) async {
// //       if (data['tabla'] == 'proveedor') {
// //         loadInfo.buscaAllPropietarios('');
// //         // NotificatiosnService.showSnackBarSuccsses(data['msg']);
// //       }
// //     });
// //     serviceSocket.socket!.on('server:actualizadoExitoso', (data) async {
// //       if (data['tabla'] == 'proveedor') {
// //         loadInfo.buscaAllPropietarios('');
// //         // NotificatiosnService.showSnackBarSuccsses(data['msg']);
// //       }
// //     });
// //     serviceSocket.socket!.on('server:eliminadoExitoso', (data) async {
// //       if (data['tabla'] == 'proveedor') {
// //         loadInfo.buscaAllPropietarios('');
// //         // NotificatiosnService.showSnackBarSuccsses(data['msg']);
// //       }
// //     });
// //     serviceSocket.socket?.on('server:error', (data) {
// //       NotificatiosnService.showSnackBarError(data['msg']);
// //     });

// // //********************************//


//       notifyListeners();
//     });

        //=================GUARDADO=====================//
    _socket?.on('server:guardadoExitoso', (data) {
        final _ctrlPropietario=PropietariosController();
        if (data['tabla'] == 'proveedor') {
        _ctrlPropietario.buscaAllPropietarios('');
         // Maneja la respuesta del servidor aquí
        _showSnackbar('$data',);
         notifyListeners();
        }
       
    });
       //=================ACTUALIZADO=====================//
    _socket?.on('server:actualizadoExitoso', (data) {
        final _ctrlPropietario=PropietariosController();
        if (data['tabla'] == 'proveedor') {
        _ctrlPropietario.buscaAllPropietarios('');
         // Maneja la respuesta del servidor aquí
        _showSnackbar('$data');
         notifyListeners();
        }
       
    });
        //=================ELIMINADO=====================//
    _socket?.on('server:eliminadoExitoso', (data) {
        final _ctrlPropietario=PropietariosController();
        if (data['tabla'] == 'proveedor') {
        _ctrlPropietario.buscaAllPropietarios('');
         // Maneja la respuesta del servidor aquí
        _showSnackbar('$data');
         notifyListeners();
        }
       
    });
          //=================ERROR=====================//
    _socket?.on('server:error', (data) {
        final _ctrlPropietario=PropietariosController();
        if (data['tabla'] == 'proveedor') {
        _ctrlPropietario.buscaAllPropietarios('');
         // Maneja la respuesta del servidor aquí
        _showSnackbarError('${data['msg']}');
         notifyListeners();
        }
       
    });




  }

  void _showSnackbar( String result) {
    NotificatiosnService.showSnackBarDanger(result);
  }
  void _showSnackbarError( String result) {
    NotificatiosnService.showSnackBarDanger(result);
  }
  void sendMessage(String event, Map<String, dynamic> message) {
    _socket?.emit(event, message);
  }
}
// // import 'package:better_player/better_player.dart';
// import 'package:chewie/chewie.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:neitorcont/src/utils/responsive.dart';
// import 'package:video_player/video_player.dart';

// import '../utils/theme.dart';

// class VideoScreenPage extends StatefulWidget {
//   final Map<String,dynamic> infoVideo;
//    const VideoScreenPage({Key? key, required this.infoVideo}) : super(key: key);

//   @override
//   State<VideoScreenPage> createState() => _VideoScreenPageState();
// }

// class _VideoScreenPageState extends State<VideoScreenPage> {
//   VideoPlayerController? _videoPlayerController;
//   ChewieController? _chewieController;
//   @override
//   void initState() {
//     super.initState();
//     _inicio();
//   }

//   void _inicio() {

//     print('======> ${widget.infoVideo['url']}');
//     _videoPlayerController = VideoPlayerController.network(
//         // "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4");
//        '${widget.infoVideo['url']}');
//     _videoPlayerController!.initialize().then((_) {
//       _chewieController =
//           ChewieController(videoPlayerController: _videoPlayerController!);
//       setState(() {
//         print('Video cargado');
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _videoPlayerController!.dispose();
//     _chewieController!.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Responsive size = Responsive.of(context);
//     // final _info = ModalRoute.of(context)!.settings.arguments;

//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         // backgroundColor: primaryColor,
//         title: Text(
//           '${widget.infoVideo['label']}',
//           style: GoogleFonts.lexendDeca(
//               fontSize: size.iScreen(2.0),
//               color: Colors.white,
//               fontWeight: FontWeight.normal),
//         ),
//       ),
//       body: Container(
//         color: Colors.black,
//         width: size.wScreen(100),
//         height: size.hScreen(100),
//         child: _chewieVideoPlayer(),
//         // child:
//         // BetterPlayer.network(
//         //   '${_info['url']}',
//         //   betterPlayerConfiguration: const BetterPlayerConfiguration(
//         //     aspectRatio: 16 / 16,
//         //   ),
//         // ),
//       ),
//     );
//   }

//   Widget _chewieVideoPlayer() {
//     return _chewieController != null && _videoPlayerController != null
//         ? Chewie(controller: _chewieController!)
//         : const Center(child: Text('Cargando...'));
//   }
// }

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neitorcont/src/utils/responsive.dart';
import 'package:webview_flutter/webview_flutter.dart';


class VideoScreenPage extends StatefulWidget {
  final Map<String, dynamic> infoVideo;
  const VideoScreenPage({Key? key, required this.infoVideo}) : super(key: key);

  @override
  State<VideoScreenPage> createState() => _VideoScreenPageState();
}

class _VideoScreenPageState extends State<VideoScreenPage> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    _inicio();
  }

  void _inicio() {
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Responsive size = Responsive.of(context);

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          // backgroundColor: primaryColor,
          title: Text(
            '${widget.infoVideo['label']}',style:  Theme.of(context).textTheme.headline2,
            // style: GoogleFonts.lexendDeca(
            //     fontSize: size.iScreen(2.0),
            //     color: Colors.white,
            //     fontWeight: FontWeight.normal),
          ),
        ),
        body: Container(
            color: Colors.black,
            width: size.wScreen(100),
            height: size.hScreen(100),
            child:
                //  _chewieVideoPlayer(),
                WebView(
              initialUrl: '${widget.infoVideo['url']}',
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
            )));
  }
}

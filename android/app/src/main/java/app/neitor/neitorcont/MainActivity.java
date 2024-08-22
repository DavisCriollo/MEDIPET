package app.neitor.neitorcont;

import io.flutter.embedding.android.FlutterActivity;

public class MainActivity extends FlutterActivity {


}




// import android.os.Bundle;
// import android.os.RemoteException;
// import androidx.annotation.NonNull;
// import io.flutter.embedding.android.FlutterActivity;
// import io.flutter.plugin.common.MethodCall;
// import io.flutter.plugin.common.MethodChannel;
// import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
// import io.flutter.plugin.common.MethodChannel.Result;


// import com.sunmi.peripheral.printer.SunmiPrinterService;
// import com.sunmi.peripheral.printer.InnerResultCallbcak;


// public class MainActivity extends FlutterActivity {
//     private static final String CHANNEL = "app.neitor.neitorcont";
//     private SunmiPrinterService sunmiPrinterService;

//     @Override
//     protected void onCreate(Bundle savedInstanceState) {
//         super.onCreate(savedInstanceState);

//         new MethodChannel(getFlutterEngine().getDartExecutor().getBinaryMessenger(), CHANNEL).setMethodCallHandler(
//             new MethodCallHandler() {
//                 @Override
//                 public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
//                     if (call.method.equals("printText")) {
//                         String textToPrint = call.arguments.toString();
//                         try {
//                             sunmiPrinterService.printText(textToPrint + "\n", new InnerResultCallbcak() {
//                                 @Override
//                                 public void onRunResult(boolean isSuccess) throws RemoteException {
//                                     result.success(isSuccess);
//                                 }

//                                 @Override
//                                 public void onReturnString(String result) throws RemoteException {}

//                                 @Override
//                                 public void onRaiseException(int code, String msg) throws RemoteException {
//                                     result.error("PRINT_ERROR", msg, null);
//                                 }

//                                 @Override
//                                 public void onPrintResult(int code, String msg) throws RemoteException {}
//                             });
//                         } catch (RemoteException e) {
//                             e.printStackTrace();
//                             result.error("REMOTE_EXCEPTION", e.getMessage(), null);
//                         }
//                     } else {
//                         result.notImplemented();
//                     }
//                 }
//             }
//         );
//     }
// }
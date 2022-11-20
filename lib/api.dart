import 'package:firebase_dart/firebase_dart.dart';
import 'package:firebase_dart/implementation/testing.dart';
import 'package:logger/logger.dart';

class Api {
  late FirebaseApp app;
  Future initApi() async {
    var options = FirebaseOptions(
        appId: '1:468822594426:web:d715615473840b7f4cfcc3',
        apiKey: 'AIzaSyCs9rVzcDTY5D7pw0pT49aLt9mmUMKaKLQ',
        projectId: 'foodcurt-f6b2d',
        messagingSenderId: '468822594426',
        authDomain: 'foodcurt-f6b2d.firebaseapp.com');
    FirebaseTesting.setup();
    //  Firebase.app();
    app = await Firebase.initializeApp(options: options);
  }

  Future<Map> getMsg() async {
    var db = FirebaseDatabase(
        app: app,
        databaseURL:
            "https://foodcurt-f6b2d-default-rtdb.europe-west1.firebasedatabase.app");
    Map res = await db.reference().get();
    Logger().d(res);
    return res;
  }
}

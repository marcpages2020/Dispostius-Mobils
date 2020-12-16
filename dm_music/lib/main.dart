import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

import 'App.dart';
import 'sign_in_flow/auth_state_switch.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
  await Firebase.initializeApp();
  runApp(
    AuthStateSwitch(
      app: DmMusic(),
    ),
  );
}

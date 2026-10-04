import 'package:flutter/material.dart';
import 'app.dart';
import 'config/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize service locator
  await sl.setup();

  // NOTE: Once firebase_options.dart is generated via `flutterfire configure`,
  // uncomment the following lines:
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  runApp(const HasthakalaApp());
}

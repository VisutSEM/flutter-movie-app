import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tos_merl/firebase_options.dart';
import 'package:tos_merl/view/home_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'controller/movie_controller.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tos Merl',
      home: HomeView(),
    );
  }
}

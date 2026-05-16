import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'services/hive_service.dart';
import 'services/session_service.dart';
import 'controllers/auth_controller.dart'; // Pastikan di-import
import 'views/login_view.dart';
import 'views/main_wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveService.init();

  Get.put(AuthController());

  bool loggedIn = await SessionService.isLoggedIn();

  runApp(MyApp(isLoggedIn: loggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Responsi App',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? MainWrapper() : LoginView(),
    );
  }
}

import 'package:belajar_provider_api_inventory/helper/sharedpref_helper.dart';
import 'package:belajar_provider_api_inventory/provider/barang_provider.dart';
import 'package:belajar_provider_api_inventory/screen/halaman_home.dart';
import 'package:belajar_provider_api_inventory/screen/halaman_login.dart';
import 'package:belajar_provider_api_inventory/screen/halaman_splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPrefHelper _sharedPref = SharedPrefHelper();
  var loginPref = await _sharedPref.read('login_pref');

  runApp(ChangeNotifierProvider(
    create: (_) => BarangProvider(),
    child: MaterialApp(
      title: 'Aplikasi Inventory',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      routes: {
        HalamanSplash.id: (context) => HalamanSplash(),
        HalamanHome.id: (context) => HalamanHome(),
        HalamanLogin.id: (context) => HalamanLogin(),
      },
      home: loginPref ? HalamanHome() : HalamanLogin(),
    ),
  ));
}
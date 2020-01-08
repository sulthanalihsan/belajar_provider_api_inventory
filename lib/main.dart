import 'package:belajar_provider_api_inventory/provider/barang_provider.dart';
import 'package:belajar_provider_api_inventory/screen/halaman_home.dart';
import 'package:belajar_provider_api_inventory/screen/halaman_login.dart';
import 'package:belajar_provider_api_inventory/screen/halaman_splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BarangProvider(),
      child: MaterialApp(
        title: 'Aplikasi Inventory',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        initialRoute: HalamanLogin.id,
        routes: {
          HalamanSplash.id: (context) => HalamanSplash(),
          HalamanHome.id: (context) => HalamanHome(),
          HalamanLogin.id: (context) => HalamanLogin(),
          // HalamanTambahEdit.id: (context) => HalamanTambahEdit(),
        },
      ),
    );
  }

}

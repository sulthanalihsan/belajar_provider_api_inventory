import 'package:belajar_provider_api_inventory/helper/sharedpref_helper.dart';
import 'package:belajar_provider_api_inventory/model/response_barang_model.dart';
import 'package:belajar_provider_api_inventory/provider/barang_provider.dart';
import 'package:belajar_provider_api_inventory/screen/halaman_login.dart';
import 'package:belajar_provider_api_inventory/screen/halaman_search.dart';
import 'package:belajar_provider_api_inventory/screen/halaman_tambah.dart';
import 'package:belajar_provider_api_inventory/ui/item_barang.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HalamanHome extends StatefulWidget {
  static const String id = "HOME";

  @override
  _HalamanHomeState createState() => _HalamanHomeState();
}

class _HalamanHomeState extends State<HalamanHome> {
  BarangProvider barangProv;

//  List<Barang> listBarang;

  void getData() async {
    barangProv.getListBarang();
  }

  @override
  void initState()  {
    super.initState();

//    Future.microtask(() {
    barangProv = Provider.of<BarangProvider>(context, listen: false);
//    });
    getData();
//    print('yeah' + barangProv.toString());

//    barangProv.getListBarang();
  }

  @override
  Widget build(BuildContext context) {
//    BarangProvider barangProv =
//        Provider.of<BarangProvider>(context);
//    barangProv.getListBarang();
//    print('yeah' + barangProv.listBarang.toString());

    List<Barang> listBarang = barangProv.listBarang;

//    List<Barang> listBarang = barangProv.listBarang;

    return Scaffold(
      appBar: AppBar(
        title: Text('Aplikasi Inventory'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HalamanSearch()));
            },
          ),
          IconButton(
            icon: Icon(Icons.lock_open),
            onPressed: () async {
              SharedPrefHelper _sharedPref = SharedPrefHelper();
              var loginPref = await _sharedPref.remove('login_pref');
              // var loginPref = await _sharedPref.read('login_pref');
              print(loginPref);
              Navigator.of(context).popAndPushNamed(HalamanLogin.id);
            },
          )
        ],
      ),
      body: Center(
        child: listBarang != null
            ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: listBarang.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      splashColor: Colors.green,
                      borderRadius: BorderRadius.circular(10.0),
                      child: itemBarang(listBarang[index]),
                      onTap: () {
                        barangProv.detailBarang = listBarang[index];
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HalamanTambahEdit(
                                      listBarang[index],
                                    )));
                      },
                    );
                  },
                ),
              )
            : CircularProgressIndicator(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => HalamanTambahEdit(null)));
        },
      ),
    );
  }
}

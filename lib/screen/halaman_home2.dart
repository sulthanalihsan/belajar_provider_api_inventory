import 'package:belajar_provider_api_inventory/helper/sharedpref_helper.dart';
import 'package:belajar_provider_api_inventory/provider/barang_provider.dart';
import 'package:belajar_provider_api_inventory/screen/halaman_login.dart';
import 'package:belajar_provider_api_inventory/screen/halaman_search.dart';
import 'package:belajar_provider_api_inventory/screen/halaman_tambah.dart';
import 'package:belajar_provider_api_inventory/ui/item_barang.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HalamanHome2 extends StatefulWidget {
  static const String id = "HOME2";

  @override
  _HalamanHome2State createState() => _HalamanHome2State();
}

class _HalamanHome2State extends State<HalamanHome2> {
  BarangProvider barangProv;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final barangProv = Provider.of<BarangProvider>(context);
    if (this.barangProv != barangProv) {
      this.barangProv = barangProv;
      Future.microtask(() => barangProv.getListBarang());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aplikasi Inventory2'),
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
              Navigator.of(context).pushReplacementNamed(HalamanLogin.id);
            },
          )
        ],
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: barangProv.isFetching
            ? CircularProgressIndicator()
            : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: barangProv.listBarang.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    splashColor: Colors.green,
                    borderRadius: BorderRadius.circular(10.0),
                    child: itemBarang(barangProv.listBarang[index]),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HalamanTambahEdit(
                                    barangProv.listBarang[index],
                                  )));
                    },
                  );
                },
              ),
      )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => HalamanTambahEdit(null)));
        },
      ),
    );
  }
}

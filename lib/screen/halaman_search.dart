import 'package:belajar_provider_api_inventory/model/response_barang_model.dart';
import 'package:belajar_provider_api_inventory/provider/barang_provider.dart';
import 'package:belajar_provider_api_inventory/ui/item_barang.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'halaman_tambah.dart';

class HalamanSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<BarangProvider>(
          builder: (context, barangProv, _) => TextFormField(
            decoration: InputDecoration(
                hintText: 'Masukan kata kunci',
                filled: true,
                fillColor: Colors.white),
            onChanged: (search) {
              barangProv.seacrhBarang(search);
            },
          ),
        ),
      ),
      body: Consumer<BarangProvider>(
        builder: (context, barangProv, _) {
          barangProv.getListBarang();
          List<Barang> listBarang = barangProv.listBarangSearch;

          if (listBarang != null) {
            return GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
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
            );
          } else {
            return Center(child: Text('Pencarian'));
          }
        },
      ),
    );
  }
}

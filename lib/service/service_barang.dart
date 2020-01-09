import 'dart:convert';

import 'package:belajar_provider_api_inventory/model/response_barang_model.dart';
import 'package:belajar_provider_api_inventory/model/response_post_model.dart';
import 'package:http/http.dart' as http;

class ServiceBarang {
  // final _host = '192.168.60.87'; //idn lama
  final _host = '192.168.84.146'; //idn baru
  // final _host = '192.168.43.182'; //hotspot hape

  Future<List<Barang>> getListBarang() async {
    final uri = Uri.http(_host, 'server_inventory/index.php/api/getbarang');
    List<Barang> listBarang = [];
    final response = await http.get(uri); //data json

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      ResponseBarang respBarang = ResponseBarang.fromJson(json);

      respBarang.barang.forEach((item) {
        listBarang.add(item);
      });

      return listBarang;
    } else {
      return [];
    }
  }

  Future<ResponseRequest> postBarang(nama, jumlah, gambar) async {
    final uri = Uri.http(_host, 'server_inventory/index.php/api/insertbarang');
//    if (gambar == null){
//      print('null');
//      return null;
//    }
//    String base64Image = base64Encode(gambar.readAsBytesSync());
    // String fileName = file.path.split("/").last;

//    final response = await http
//        .post(uri, body: {'nama': nama, 'jumlah': jumlah, 'gambar': base64Image});
//
    final response = await http
        .post(uri, body: {'nama': nama, 'jumlah': jumlah, 'gambar': gambar});

    if (response.statusCode == 200) {
      ResponseRequest responseRequest =
          ResponseRequest.fromJson(jsonDecode(response.body));

      return responseRequest;
    } else {
      return null;
    }
  }

  Future<ResponseRequest> updateBarang(id, nama, jumlah, gambar) async {
    final uri = Uri.http(_host, 'server_inventory/index.php/api/updatebarang');

    final response = await http.post(uri,
        body: {"id": id, 'nama': nama, 'jumlah': jumlah, 'gambar': gambar});

    if (response.statusCode == 200) {
      ResponseRequest responseRequest =
          ResponseRequest.fromJson(jsonDecode(response.body));
      return responseRequest;
    } else {
      return null;
    }
  }

  Future<ResponseRequest> delBarang(id) async {
    final uri = Uri.http(_host, 'server_inventory/index.php/api/deletebarang');

    final response = await http.post(uri, body: {'id': id});

    if (response.statusCode == 200) {
      ResponseRequest responseRequest =
          ResponseRequest.fromJson(jsonDecode(response.body));

      return responseRequest;
    } else {
      return null;
    }
  }
}

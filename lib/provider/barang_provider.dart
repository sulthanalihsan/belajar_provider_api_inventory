import 'package:belajar_provider_api_inventory/model/response_barang_model.dart';
import 'package:belajar_provider_api_inventory/model/response_post_model.dart';
import 'package:belajar_provider_api_inventory/service/service_barang.dart';
import 'package:flutter/foundation.dart';

class BarangProvider extends ChangeNotifier {
  ServiceBarang _service = ServiceBarang();

  List<Barang> _listBarang;

  List<Barang> get listBarang => _listBarang;

  set listBarang(List<Barang> value) {
    _listBarang = value;
    notifyListeners();
  }

  // ignore: missing_return
  Future<List<Barang>> getListBarang() async {
    listBarang = await _service.getListBarang();
    if (listBarang != null) {
      return listBarang;
    }
  }

  List<Barang> _listBarangSearch;

  List<Barang> get listBarangSearch => _listBarangSearch;

  set listBarangSearch(List<Barang> value) {
    _listBarangSearch = value;
    notifyListeners();
  }

  void seacrhBarang(String cari) {
    List<Barang> listSearch = [];

    if (cari.isEmpty) {
      listSearch.clear();
      listBarangSearch = listSearch;
    } else {
      _listBarang.forEach((item) {
        if (item.barangNama.toLowerCase().contains(cari)) {
          listSearch.add(item);
        }
      });
      listBarangSearch = listSearch;
    }
  }

  ResponseRequest _responseRequest;

  ResponseRequest get responseRequest => _responseRequest;

  set responseRequest(ResponseRequest value) {
    _responseRequest = value;
    notifyListeners();
  }

  Future<void> postBarang(nama, jumlah, gambar) async {
//    final response = await _service.postBarang(nama, jumlah, gambar);
    final response = await _service.postBarang(nama, jumlah, gambar);
    _responseRequest = response;
  }

  Future<void> updateBarang(id, nama, jumlah, gambar) async {
    final response = await _service.updateBarang(id, nama, jumlah, gambar);
    _responseRequest = response;
  }

  Future<void> deleteBarang(id) async {
    final response = await _service.delBarang(id);
    _responseRequest = response;
  }

//  Barang _detailBarang;
//
//  Barang get detailBarang => _detailBarang;
//
//  set detailBarang(Barang barang) {
//    _detailBarang = barang;
//    notifyListeners();
//  }
}

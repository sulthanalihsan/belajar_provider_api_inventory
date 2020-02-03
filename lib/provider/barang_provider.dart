import 'package:belajar_provider_api_inventory/model/response_barang_model.dart';
import 'package:belajar_provider_api_inventory/model/response_post_model.dart';
import 'package:belajar_provider_api_inventory/service/service_barang.dart';
import 'package:flutter/foundation.dart';

class BarangProvider extends ChangeNotifier {

  BarangProvider() {
    getListBarang();
  }

  ServiceBarang _service = ServiceBarang();

  bool _isFetching = false;
  bool get isFetching => _isFetching;
  List<Barang> _listBarang;
  List<Barang> get listBarang => _listBarang;

  // ignore: missing_return
  Future<void> getListBarang() async {
    _isFetching = true;
    notifyListeners();
    _listBarang = await _service.getListBarang();
    _isFetching = false;
    notifyListeners();
  }


  ResponseRequest _responseRequest;
  ResponseRequest get responseRequest => _responseRequest;

  Future<void> postBarang(nama, jumlah, gambar) async {
    final response = await _service.postBarang(nama, jumlah, gambar);
    _responseRequest = response;

    Barang barang = Barang();
    barang.barangNama = nama;
    barang.barangJumlah = jumlah;
    barang.barangGambar = gambar;
    barang.barangId = response.lastId.toString();

    _listBarang.add(barang);
    notifyListeners();
  }

  Future<void> updateBarang(id, nama, jumlah, gambar) async {
    final response = await _service.updateBarang(id, nama, jumlah, gambar);
    _responseRequest = response;

    var index = _listBarang.indexWhere((item) => item.barangId == id);
    _listBarang[index] = Barang(
        barangId: id,
        barangNama: nama,
        barangJumlah: jumlah,
        barangGambar: gambar);

    notifyListeners();
  }

  Future<void> deleteBarang(id) async {
    final response = await _service.delBarang(id);
    _responseRequest = response;
    _listBarang.removeWhere((item) => item.barangId == id);
    notifyListeners();
  }


  /* search */

  List<Barang> _listBarangSearch;
  List<Barang> get listBarangSearch => _listBarangSearch;

  void seacrhBarang(String cari) {
    List<Barang> listSearch = [];

    if (cari.isEmpty) {
      listSearch.clear();
      _listBarangSearch = listSearch;
    } else {
      _listBarang.forEach((item) {
        if (item.barangNama.toLowerCase().contains(cari)) {
          listSearch.add(item);
        }
      });
      _listBarangSearch = listSearch;
    }
    notifyListeners();
  }

}

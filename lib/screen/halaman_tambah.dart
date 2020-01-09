import 'package:belajar_provider_api_inventory/model/response_barang_model.dart';
import 'package:belajar_provider_api_inventory/provider/barang_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class HalamanTambahEdit extends StatefulWidget {
  static const String id = "HALAMANTAMBAHEDIT";
  final Barang barang;

  HalamanTambahEdit(this.barang);

  @override
  _HalamanTambahEditState createState() => _HalamanTambahEditState();
}

class _HalamanTambahEditState extends State<HalamanTambahEdit> {
  final _formKey = GlobalKey<FormState>();
  bool _validate = false;
  bool _isUpdate = false;

  Barang barang;

  String _idBarang;
  final _nmBarangContr = TextEditingController();
  final _jmlBarangContr = TextEditingController();
  final _urlBarangContr = TextEditingController();

//  File _file;
//  void _pilihImageCamera() async {
//    _file = await ImagePicker.pickImage(source: ImageSource.camera);
//  }
//
//  void _pilihImageGallery() async {
//    _file = await ImagePicker.pickImage(source: ImageSource.gallery);
//  }

  @override
  void initState() {
    super.initState();
    if (widget.barang != null) {
      _isUpdate = true;
      _idBarang = widget.barang.barangId;
      barang = widget.barang;
      _nmBarangContr.text = barang.barangNama;
      _jmlBarangContr.text = barang.barangJumlah;
      _urlBarangContr.text = barang.barangGambar;
    }
  }

  @override
  Widget build(BuildContext context) {
    BarangProvider barangProv = Provider.of<BarangProvider>(context);

    String validator(String value) {
      if (value.isEmpty)
        return "jangan kosong";
      else
        return null;
    }

    void cekValidasi() async {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        bool _sukses = false;

        if (_isUpdate) {
          await barangProv.updateBarang(_idBarang, _nmBarangContr.text,
              _jmlBarangContr.text, _urlBarangContr.text);
        } else {
           await barangProv.postBarang(
               _nmBarangContr.text, _jmlBarangContr.text, _urlBarangContr.text);
//          await barangProv.postBarang(
//              _nmBarangContr.text, _jmlBarangContr.text, _file);
        }

        _sukses = barangProv.responseRequest.sukses;

        if (_sukses) {
          Navigator.pop(context,"hai");
          Toast.show('Berhasil', context);
        } else {
          Toast.show('Gagal', context);
        }
      } else {
        _validate = true;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: _isUpdate ? Text('Update Data') : Text('Tambah Data'),
        actions: <Widget>[
          _isUpdate
              ? IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    await barangProv.deleteBarang(_idBarang);
                    if (barangProv.responseRequest.sukses) {
                      Navigator.pop(context);
                      Toast.show('Berhasil Menghapus', context);
                    } else {
                      Toast.show('Gagal Menghapus', context);
                    }
                  },
                )
              : Text('')
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            autovalidate: _validate,
            key: _formKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: TextFormField(
                    controller: _nmBarangContr,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Nama Barang'),
                    validator: validator,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: TextFormField(
                    controller: _jmlBarangContr,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Jumlah Barang'),
                    validator: validator,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: TextFormField(
                    controller: _urlBarangContr,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Url Barang'),
                    validator: validator,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50.0,
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      'SIMPAN',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: cekValidasi,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                ),
//                Container(
//                  padding: EdgeInsets.only(top: 12.0),
//                  width: MediaQuery.of(context).size.width,
//                  height: 50.0,
//                  child: RaisedButton(
//                    color: Theme.of(context).primaryColor,
//                    child: Text(
//                      'Pilih Gambar',
//                      style: TextStyle(color: Colors.white),
//                    ),
//                    onPressed: _pilihImageGallery,
//                    shape: RoundedRectangleBorder(
//                        borderRadius: BorderRadius.circular(10.0)),
//                  ),
//                ),
//                _file == null ? Text('No Image Selected') : Image.file(_file)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

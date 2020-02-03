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

  String _idBarang;
  TextEditingController _nmBarang, _jmlBarang, _urlBarang;

  BarangProvider barangProv;

  void cekValidasi() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      if (_isUpdate) {
        await barangProv.updateBarang(
            _idBarang, _nmBarang.text, _jmlBarang.text, _urlBarang.text);
      } else {
        await barangProv.postBarang(
            _nmBarang.text, _jmlBarang.text, _urlBarang.text);
      }

      bool _sukses = barangProv.responseRequest.sukses;

      if (_sukses) {
        Navigator.pop(context);
        Toast.show('Berhasil', context);
      } else {
        Toast.show('Gagal', context);
      }
    } else {
      _validate = true;
    }
  }

  String validator(String value) {
    if (value.isEmpty)
      return "jangan kosong";
    else
      return null;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final barangProv = Provider.of<BarangProvider>(context);

    if (this.barangProv != barangProv) {
      this.barangProv = barangProv;
    }
  }

  @override
  void initState() {
    super.initState();

    if(widget.barang != null){
      _isUpdate = true;
      _idBarang = widget.barang.barangId;
    }

    _nmBarang = TextEditingController(text: widget.barang.barangNama);
    _jmlBarang = TextEditingController(text: widget.barang.barangJumlah);
    _urlBarang = TextEditingController(text: widget.barang.barangGambar);
  }

  @override
  Widget build(BuildContext context) {
    BarangProvider barangProv = Provider.of<BarangProvider>(context);

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
                    controller: _nmBarang,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Nama Barang'),
                    validator: validator,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: TextFormField(
                    controller: _jmlBarang,
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
                    controller: _urlBarang,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:convert';

ResponseBarang responseBarangFromJson(String str) => 
ResponseBarang.fromJson(json.decode(str));

String responseBarangToJson(ResponseBarang data) => 
json.encode(data.toJson());

class ResponseBarang {
    String pesan;
    bool sukses;
    List<Barang> barang;

    ResponseBarang({
        this.pesan,
        this.sukses,
        this.barang,
    });

    factory ResponseBarang.fromJson(Map<String, dynamic> json) => 
    ResponseBarang(
        pesan: json["pesan"],
        sukses: json["sukses"],
        barang: List<Barang>.from(json["barang"].map((x) => 
        Barang.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "pesan": pesan,
        "sukses": sukses,
        "barang": List<dynamic>.from(barang.map((x) => x.toJson())),
    };
}

class Barang {
    String barangId;
    String barangNama;
    String barangJumlah;
    String barangGambar;

    Barang({
        this.barangId,
        this.barangNama,
        this.barangJumlah,
        this.barangGambar,
    });

    factory Barang.fromJson(Map<String, dynamic> json) => Barang(
        barangId: json["barang_id"],
        barangNama: json["barang_nama"] == null ? null : json["barang_nama"],
        barangJumlah: json["barang_jumlah"] == null ? null : json["barang_jumlah"],
        barangGambar: json["barang_gambar"] == null ? null : json["barang_gambar"],
    );

    Map<String, dynamic> toJson() => {
        "barang_id": barangId,
        "barang_nama": barangNama == null ? null : barangNama,
        "barang_jumlah": barangJumlah == null ? null : barangJumlah,
        "barang_gambar": barangGambar == null ? null : barangGambar,
    };
}

import 'dart:convert';

ResponseRequest responseRequestFromJson(String str) =>
    ResponseRequest.fromJson(json.decode(str));

String responseRequestToJson(ResponseRequest data) =>
    json.encode(data.toJson());

class ResponseRequest {
  bool sukses;
  String pesan;
  int lastId;

  ResponseRequest({this.sukses, this.pesan, this.lastId});

  factory ResponseRequest.fromJson(Map<String, dynamic> json) =>
      ResponseRequest(
          sukses: json["sukses"],
          pesan: json["pesan"],
          lastId: json["last_id"]);

  Map<String, dynamic> toJson() =>
      {"sukses": sukses, "pesan": pesan, "last_id": lastId};
}

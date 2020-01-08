import 'dart:convert';

ResponseRequest responseRequestFromJson(String str) =>
    ResponseRequest.fromJson(json.decode(str));

String responseRequestToJson(ResponseRequest data) => json.encode(data.toJson());

class ResponseRequest {
  bool sukses;
  String pesan;

  ResponseRequest({
    this.sukses,
    this.pesan,
  });

  factory ResponseRequest.fromJson(Map<String, dynamic> json) => ResponseRequest(
        sukses: json["sukses"],
        pesan: json["pesan"],
      );

  Map<String, dynamic> toJson() => {
        "sukses": sukses,
        "pesan": pesan,
      };
}

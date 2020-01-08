import 'package:belajar_provider_api_inventory/model/response_login_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ServiceAuth {
  // final _host = '192.168.60.87'; //idn lama
  final _host = '192.168.84.146'; //idn baru
  // final _host = '192.168.43.182'; //hotspot hape

  Future<ResponseLogin> login(email, password) async {
    final uri = Uri.http(_host, 'server_inventory/index.php/api/login');

    final response =
        await http.post(uri, body: {'email': email, 'password': password});

    if (response.statusCode == 200) {
      ResponseLogin responseRequest =
          ResponseLogin.fromJson(jsonDecode(response.body));
      return responseRequest;
    } else {

      return null;
    }
  }
}

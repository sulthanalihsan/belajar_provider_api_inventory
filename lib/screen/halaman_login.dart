import 'package:belajar_provider_api_inventory/helper/sharedpref_helper.dart';
import 'package:belajar_provider_api_inventory/model/response_login_model.dart';
import 'package:belajar_provider_api_inventory/screen/halaman_home.dart';
import 'package:belajar_provider_api_inventory/service/service_auth.dart';
import 'package:belajar_provider_api_inventory/styling/style_text_input.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class HalamanLogin extends StatefulWidget {
  static const String id = "HALAMAN_LOGIN";

  @override
  _HalamanLoginState createState() => _HalamanLoginState();
}

class _HalamanLoginState extends State<HalamanLogin> {
  String email, password;
  bool showSpinner = false;
  ServiceAuth _auth = ServiceAuth();
  SharedPrefHelper _sharedPref = SharedPrefHelper();

//  void cekLoginSession() async {
//    var loginPref = await _sharedPref.read('login_pref');
//    if (loginPref != null) {
//      Navigator.of(context).popAndPushNamed(HalamanHome.id);
//    }
//  }

  @override
  void initState() {
    super.initState();
//    cekLoginSession();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Flexible(
                  child: Container(
                    height: 200.0,
                    child: Image.asset(
                      'images/ima-putih.png',
                      color: Colors.green,
                    ),
                  ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: loginTextInputDecoration('Masukan email anda'),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  obscureText: true,
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: loginTextInputDecoration('Masukan password anda'),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Material(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    elevation: 5.0,
                    child: MaterialButton(
                      onPressed: () async {
                        setState(() {
                          showSpinner = true;
                        });

                        ResponseLogin statusLogin =
                            await _auth.login(email, password);

                        if (statusLogin.sukses) {
                          await _sharedPref.save('login_pref', true);
                          Navigator.of(context)
                              .pushReplacementNamed(HalamanHome.id);
                        } else {
                          setState(() {
                            showSpinner = false;
                          });
                        }
                      },
                      minWidth: 200.0,
                      height: 42.0,
                      child: Text(
                        'Log In',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
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

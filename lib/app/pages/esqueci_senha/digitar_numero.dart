import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:rmcheckin/app/pages/esqueci_senha/esqueci_senha_sms.dart';
import 'package:rmcheckin/app/services/esqueci_senha_sms.dart';
import 'package:rmcheckin/app/widget/app_color.dart';

class DigitarNumero extends StatefulWidget {
  const DigitarNumero({super.key});

  @override
  State<DigitarNumero> createState() => _DigitarNumeroState();
}

class _DigitarNumeroState extends State<DigitarNumero> {
  var maskFormatter = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );
  bool _isButtonEnabled = true;
  bool apiSuccess = false;
  Map<String, dynamic>? apiResponse;
  String? errorMessage;
  final _formKey = GlobalKey<FormState>();
  TextEditingController digitarNumero = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: darkBlueColor,
        title: Image.asset(
          'assets/iconAppTop.png',
          fit: BoxFit.contain,
          height: 150,
          width: 150,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            Text(
              'Digite seu numero de telefone',
              style: GoogleFonts.dosis(
                textStyle: TextStyle(
                  color: darkBlueColor,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: TextFormField(
                      controller: digitarNumero,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [maskFormatter],
                      cursorColor: Colors.black,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Digite um numero de telefone válido';
                        }

                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "(00) 00000-0000",
                        prefixIcon: const Icon(
                          Icons.phone,
                          color: Colors.grey,
                        ),
                        filled: true,
                        fillColor: Colors.grey[300],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            12.0,
                          ),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: yellowColor,
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: _isButtonEnabled
                    ? () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _isButtonEnabled = false;
                          });
                          apiResponse = await EsqueciSenhaDataSorceSMS().esqueciSenhaService(telefone: digitarNumero.text);

                          if (apiResponse!['data'] == 'ok') {
                            apiSuccess = true;
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => EsqueciSenhaSMS(
                                  telefone: digitarNumero.text,
                                ),
                              ),
                            );
                          } else {
                            setState(() {
                              errorMessage = apiResponse!['errors'][0];
                            });
                          }

                          setState(() {
                            _isButtonEnabled = true;
                          });
                        }
                      }
                    : null,
                child: _isButtonEnabled
                    ? Text(
                        "Continuar",
                        style: GoogleFonts.dosis(
                          textStyle: const TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                          ),
                        ),
                      )
                    : const CircularProgressIndicator(),
              ),
            ),
            errorMessage != null
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      errorMessage!,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rmcheckin/app/pages/login/login_page.dart';
import 'package:rmcheckin/app/widget/app_color.dart';

class AdicionarNovaSenha extends StatefulWidget {
  const AdicionarNovaSenha({super.key});

  @override
  State<AdicionarNovaSenha> createState() => _AdicionarNovaSenhaState();
}

class _AdicionarNovaSenhaState extends State<AdicionarNovaSenha> {
  TextEditingController senhaNova = TextEditingController();
  TextEditingController confirmarSenha = TextEditingController();
  bool _showPassword = false;
  final _formKey = GlobalKey<FormState>();
  String? _validatePasswordMatch(String value) {
    if (value != senhaNova.text) {
      return 'As senhas não coincidem';
    }
    return null;
  }

  bool isLoading = false;
  bool validarSenha(String senha) {
    if (senha.length < 6) {
      return false;
    }

    if (!senha.contains(RegExp(r'\d'))) {
      return false;
    }

    if (!senha.contains(RegExp(r'[A-Z]'))) {
      return false;
    }

    if (!senha.contains(RegExp(r'[a-z]'))) {
      return false;
    }

    if (!senha.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'))) {
      return false;
    }

    if (senha.contains(RegExp(r'\s'))) {
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
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
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(
            height: 30,
          ),
          Text('Adicione sua nova senha:',
              style: GoogleFonts.dosis(
                textStyle: TextStyle(
                  color: darkBlueColor,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              )),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 2.0),
            child: Text(
              'Senha',
              style: GoogleFonts.dosis(
                textStyle: TextStyle(
                  fontSize: 18,
                  color: darkBlueColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          TextFormField(
            controller: senhaNova,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira uma senha.';
              }
              if (!validarSenha(value)) {
                return 'A senha não atende aos critérios de validação.';
              }
              return null; // A senha é válida
            },
            obscureText: _showPassword == false ? true : false,
            cursorColor: Colors.grey,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[300],
              suffixIcon: GestureDetector(
                child: Icon(_showPassword == false ? Icons.visibility_off : Icons.visibility, color: Colors.grey),
                onTap: () {
                  setState(() {
                    _showPassword = !_showPassword;
                  });
                },
              ),
              hintText: "Senha",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  12.0,
                ),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 2.0),
            child: Text(
              'Confirmar Senha',
              style: GoogleFonts.dosis(
                textStyle: TextStyle(
                  fontSize: 18,
                  color: darkBlueColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          TextFormField(
            controller: confirmarSenha,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira uma senha.';
              }
              if (!validarSenha(value)) {
                return 'A senha não atende aos critérios de validação.';
              }
              if (_validatePasswordMatch(value) != null) {
                return 'Senhas diferentes';
              }
              return null;
            },
            obscureText: _showPassword == false ? true : false,
            cursorColor: Colors.grey,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[300],
              suffixIcon: GestureDetector(
                child: Icon(_showPassword == false ? Icons.visibility_off : Icons.visibility, color: Colors.grey),
                onTap: () {
                  setState(() {
                    _showPassword = !_showPassword;
                  });
                },
              ),
              hintText: "Confirmar senha",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  12.0,
                ),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: yellowColor,
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: const Text('Confirmar'),
            ),
          )
        ]),
      ),
    );
  }
}

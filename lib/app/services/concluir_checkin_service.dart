import 'dart:convert';

import 'package:rmcheckin/app/const/const.dart';
import 'package:http/http.dart' as http;

Future<bool> concluirCheckin({
  required String cpf,
  required int checkInId,
}) async {
  var url = Uri.parse(ConstsApi.concluirCheckin);
  var response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json',
      'authorization': ConstsApi.basicAuth,
    },
    body: jsonEncode(
      <String, dynamic>{'cpf': cpf, 'checkInId': checkInId},
    ),
  );
  print(response.body);
  if (response.statusCode == 200) {
    final responseData = jsonDecode(response.body);
    print('Deu tudo certo no cadastro');
    print(response.body);

    return true;
  } else {
    print('Erro na chamada da API: ${response.statusCode}');
    return false;
  }
}

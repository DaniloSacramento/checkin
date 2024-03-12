import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rmcheckin/app/const/const.dart';

class ExcluirNF {
  Future<bool> excluirNf({required String cpf, required int checkInId, required int nfCompraId}) async {
    var url = Uri.parse(ConstsApi.inativarUser);
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'authorization': ConstsApi.basicAuth,
      },
      body: jsonEncode(
        <String, dynamic>{
          'cpf': cpf,
          'nfCompraId': nfCompraId,
          'checkInId': checkInId,
        },
      ),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['data'] == 'ok') {
        print('Sucesso');
        return true;
      } else {
        final errors = responseData['errors'];
        print('Erro: $errors');
        return false;
      }
    }
    return false;
  }
}

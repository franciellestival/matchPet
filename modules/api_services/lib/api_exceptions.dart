import 'package:dio/dio.dart';

class APIExceptions implements Exception {
  late String message;
  late Map<String, List<String>> erros;

  APIExceptions.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        message = "Requisição para o servidor foi cancelada";
        break;
      case DioErrorType.connectTimeout:
        message = "Tempo de conexão com o servidor excedido";
        break;
      case DioErrorType.receiveTimeout:
        message = "Tempo de resposta do servidor excedido";
        break;
      case DioErrorType.response:
        message = _handleError(
          dioError.response?.statusCode,
          dioError.response?.data,
        );
        break;
      case DioErrorType.sendTimeout:
        message = "Tempo de envio da conexão para o servidor excedido";
        break;
      case DioErrorType.other:
        if (dioError.message.contains("SocketException")) {
          message = 'Sem conectividade';
          break;
        }
        message = "Um erro inesperado ocorreu";
        break;
      default:
        message = "Algo deu errado";
        break;
    }
  }

  String _handleError(int? statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 401:
        return 'Unauthorized';
      case 403:
        return 'Forbidden';
      case 404:
        return error['message'];
      case 500:
        return 'Internal server error';
      case 502:
        return 'Bad gateway';
      default:
        _mapFromJson(error);
        return 'Oops something went wrong';
    }
  }

  void _mapFromJson(Map<String, dynamic>? json) {
    erros = {};
    if (json == null) return;
    var novoJson = json["message"] as List;
    for (var element in novoJson) {
      element.forEach((key, value) {
        if (erros.containsKey(key)) {
          erros[key]?.add(value);
        } else {
          erros[key] = <String>[];
          erros[key]?.add(value);
        }
      });
    }
  }

  @override
  String toString() => message;
}

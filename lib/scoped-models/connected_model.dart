import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

import 'package:gardana/helpers/constants.dart';
import 'package:gardana/models/device.dart';

typedef Future<void> AdditionalSuccessProcess(
    Map<String, dynamic> responseData);

mixin ConnectedModel on Model {
  Device _deviceData = Device();
  Future<bool> checkConnection() async {
    bool connected = false;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        connected = true;
      }
    } on SocketException catch (_) {}
    return connected;
  }

  Future<Map<String, dynamic>> httpPost(String url, String method,
      Map<String, dynamic> data, String successMessage, BuildContext context,
      {AdditionalSuccessProcess successProcess, var id}) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    String baseUrl = SERVER_URL + url;
    String message = '';
    bool hasError = true;
    http.Response response;

    if (await checkConnection()) {
      print('data $url');
      print(data);
      Map<String, dynamic> responseData = {};
      try {
        switch (method) {
          case 'GET':
            response = await http
                .get(
                  baseUrl,
                  headers: headers,
                )
                .timeout(Duration(seconds: 15));
            break;
          case 'PUT':
            response = await http
                .put(
                  baseUrl + "/$id",
                  body: json.encode(data),
                  headers: headers,
                )
                .timeout(Duration(seconds: 15));
            break;
          case 'DELETE':
            response = await http
                .delete(
                  baseUrl + "/$id",
                  headers: headers,
                )
                .timeout(Duration(seconds: 15));
            break;
          case 'POST':
            response = await http
                .post(
                  baseUrl,
                  body: json.encode(data),
                  headers: headers,
                )
                .timeout(Duration(seconds: 15));
            break;
        }
        print("status code:" + response.statusCode.toString());
        switch (response.statusCode) {
          case 404:
            responseData = json.decode(response.body);
            message = HTTP_404;
            break;
          case 400:
            responseData = json.decode(response.body);
            message = HTTP_400;
            break;
          case 500:
            responseData = json.decode(response.body);
            message = HTTP_500;
            break;
          case 200:
            responseData = json.decode(response.body);
            print(responseData);
            if (responseData['message'] == 'success') {
              hasError = false;
              responseData = responseData['data'];
            }
            break;
        }
      } on TimeoutException catch (_) {
        message = HTTP_TIMEOUT;
      } catch (error) {
        print('error $url');
        print(error);
        message = HTTP_ERROR;
      }
      return {
        'success': !hasError,
        'message': message,
        'response': responseData
      };
    } else {
      return {'success': !hasError, 'message': NO_CONNECTION, 'response': ''};
    }
  }
}

mixin UserModel on ConnectedModel {
  Device get device {
    return _deviceData;
  }
}

mixin EmployeeModel on ConnectedModel {
  Future<Map<String, dynamic>> createEmployee(
      BuildContext context, Map<String, dynamic> data) {
    return httpPost('/pegawai', 'POST', data, '', context);
  }

  Future<Map<String, dynamic>> getEmployeeList(BuildContext context) {
    Map<String, String> data = {};
    return httpPost('/pegawai', 'GET', data, '', context);
  }

  Future<Map<String, dynamic>> deleteEmployee(BuildContext context, int id) {
    Map<String, String> data = {};
    return httpPost('/pegawai', 'DELETE', data, '', context, id: id);
  }

  Future<Map<String, dynamic>> updateEmployee(
      BuildContext context, Map<String, dynamic> data, int id) {
    return httpPost('/pegawai', 'PUT', data, '', context, id: id);
  }
}

mixin UtilityModel on ConnectedModel {
  GlobalKey<NavigatorState> navigatorKey;
}

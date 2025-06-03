// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:wiespl/common/common_log.dart';
import 'package:wiespl/common/utils.dart';
import 'package:wiespl/utils/preference.dart';
import 'package:wiespl/utils/string.dart';
import 'package:wiespl/utils/widget.dart';

class NetworkUtil {
  static final NetworkUtil _instance = NetworkUtil.internal();

  NetworkUtil.internal();

  factory NetworkUtil() => _instance;

  final JsonDecoder _decoder = const JsonDecoder();

  Future<dynamic> get({String? url, Uri? uri, bool? isLoadVisible}) async {
    var isNetwork = await Utils.checkInternetConnection();

    if (!isNetwork) {
      toastMassage(checkInternetPermission);
      return;
    }

    if (isLoadVisible!) {
      EasyLoading.instance.userInteractions = false;
      EasyLoading.show(status: 'loading...');
    }

    Map<String, String> headers = {
      "Authorization": "Bearer " + PreferenceData.getToken(),
      "Accept": "application/json",
      //"Content-Type": "application/json",
    };

    if (url != null) {
      uri = Uri.parse(url);
    }

    //print("REQUEST URL : " + url);
    CommonLog.printLog("REQUEST URL : " + uri.toString());

    CommonLog.printLog("Header : " + headers.toString());

    return http.get(uri!, headers: headers).then((http.Response response) {
      CommonLog.printLog("RESPONSE CODE : " + response.statusCode.toString());
      CommonLog.printLog("RESPONSE : " + response.body);

      final String res = response.body;
      final int statusCode = response.statusCode;
      EasyLoading.dismiss();

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw Exception(statusCode);
      }
      return _decoder.convert(res);
    });
  }

  Future<dynamic> getQueryParameters(
      String url, Map<String, dynamic> queryParam) async {
    Map<String, String> headers = {
      "Authorization": "Bearer " + PreferenceData.getToken(),
    };
    var uri = Uri.parse(url);
    uri = uri.replace(query: 'user=x');
    CommonLog.printLog("Header : " + headers.toString());

    return http.get(uri, headers: headers).then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw Exception(statusCode);
      }
      return _decoder.convert(res);
    });
  }

  Future<dynamic> post(String url,
      {Map? headers, body, encoding, bool? loading}) async {
    loading ??= true;

    var isNetwork = await Utils.checkInternetConnection();

    if (!isNetwork) {
      toastMassage(checkInternetPermission);
      return;
    }

    if (loading) {
      EasyLoading.instance.userInteractions = false;
      EasyLoading.show(status: 'loading...');
    }

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer " + PreferenceData.getToken(),
    };

    CommonLog.printLog("Header : " + headers.toString());
    CommonLog.printLog("REQUEST URL : " + url);
    CommonLog.printLog("REQUEST : " + jsonEncode(body));

    return await http
        .post(Uri.parse(url),
            body: jsonEncode(body), headers: headers, encoding: encoding)
        .then((http.Response response) {
      CommonLog.printLog("RESPONSE CODE : " + response.statusCode.toString());
      CommonLog.printLog("RESPONSE : " + response.body);

      final String res = response.body;
      final int statusCode = response.statusCode;

      if (loading!) {
        EasyLoading.dismiss();
      }
      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw Exception(statusCode);
      }

      if (res.isEmpty) {
        throw Exception(statusCode);
      }

      return _decoder.convert(res);
    });
  }

  Future<dynamic> put(String url, {Map? headers, body, encoding}) async {
    var isNetwork = await Utils.checkInternetConnection();

    if (!isNetwork) {
      toastMassage(checkInternetPermission);
      return;
    }

    Map<String, String> headers = {
      "Authorization": "Bearer " + PreferenceData.getToken(),
      "Content-Type": "application/json"
    };

    CommonLog.printLog("Header : " + headers.toString());
    //CommonLog.printLog(jsonEncode(body));

    CommonLog.printLog("REQUEST URL : " + url);
    CommonLog.printLog("REQUEST : " + jsonEncode(body));

    return await http
        .put(Uri.parse(url),
            body: jsonEncode(body), headers: headers, encoding: encoding)
        .then((http.Response response) {
      CommonLog.printLog("RESPONSE CODE : " + response.statusCode.toString());
      CommonLog.printLog("RESPONSE : " + response.body);

      final String res = response.body;
      final int statusCode = response.statusCode;
      //hideLoader();

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw Exception(statusCode);
      }

      if (res.isEmpty) {
        throw Exception(statusCode);
      }

      return _decoder.convert(res);
    });
  }

  Future<dynamic> putImage(String url, Map<String, File> _files) async {
    Map<String, String> headers = {
      "Authorization": "Bearer " + PreferenceData.getToken(),
      "Content-Type": "multipart/form-data"
    };

    CommonLog.printLog("Header : " + headers.toString());

    var request = http.MultipartRequest('PUT', Uri.parse(url));
    request.headers.addAll(headers);

    for (var entry in _files.entries) {
      //print(entry.key);
      //print(entry.value);

      if (entry.value != null) {
        request.files.add(
            await http.MultipartFile.fromPath(entry.key, entry.value.path));
      }
    }

    var response = await request.send();

    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw Exception(statusCode);
    }
    /*if (statusCode < 200 || statusCode > 400 || json == null) {
      CheckResponseCode.getResponseCode(statusCode, context);
      hideLoader();
      throw  Exception("Error while fetching data");
    }*/

    final respStr = await response.stream.bytesToString();

    CommonLog.printLog(respStr);

    return _decoder.convert(respStr);
  }

  Future<dynamic> postRequestWithFormDataNew(
      String url, MultipartRequest request) async {
    EasyLoading.instance.userInteractions = false;
    EasyLoading.show(status: 'loading...');

    Map<String, String> headers = {
      "Authorization": "Bearer " + PreferenceData.getToken(),
      "Content-Type": "multipart/form-data"
    };

    CommonLog.printLog("Header : " + headers.toString());

    CommonLog.printLog("REQUEST URL : " + url);
    CommonLog.printLog("REQUEST BODY : " + request.fields.toString());

    request.headers.addAll(headers); //i
    var res = await request.send();
    final respStr = await res.stream.bytesToString();

    CommonLog.printLog("Upload " + respStr.toString());
    EasyLoading.dismiss();

    int statusCode = res.statusCode;
    if (statusCode < 200 || statusCode > 400) {
      throw Exception(statusCode);
    }
    return _decoder.convert(respStr);
  }
}

// import 'dart:convert';

// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:injectable/injectable.dart';
import 'package:provider/provider.dart';
import 'package:rao_academy/application/auth/auth_provider.dart';
import 'package:rao_academy/core/utli/error_handle.dart';
import 'package:rao_academy/core/utli/logger.dart';
// import 'package:rao_academy/core/utli/logger.dart';
import 'package:rao_academy/core/utli/loops_urls.dart';
import 'package:rao_academy/main.dart';
// import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class APIClient {
  // String? baseUrl;
  APIClient() {
    _initiliseStorage();
    _initialize();
  }

  SharedPreferences? permitsTokens;
  final storage = const FlutterSecureStorage();

  Future<String> getUserId() {
    return navigatorKey.currentContext!
        .read<AuthProvider>()
        .getUserId()
        .then((value) => value.toString());
  }

  Future<String> getAuthToken() async {
    return storage.read(key: 'AuthToken').then((value) {
      return value ?? '0';
    }).onError((error, stackTrace) async {
      await _initiliseStorage();
      final SharedPreferences prefs = permitsTokens!;
      return prefs.getString('AuthToken') ?? '0';
    });
  }

  Future<bool> deleteAuthToken() async {
    return storage.delete(key: 'AuthToken').then((value) {
      return true;
    }).onError((error, stackTrace) async {
      await _initiliseStorage();
      final SharedPreferences prefs = permitsTokens!;
      return prefs.setString('AuthToken', '0');
    }).onError((error, stackTrace) {
      return false;
    });
  }

  Future<bool> setNotFirstTime({required bool notFirstTime}) async {
    await _initiliseStorage();
    final SharedPreferences prefs = permitsTokens!;
    return prefs.setBool('notFirstTime', notFirstTime);
  }

  Future<bool> getNotFirstTime() async {
    await _initiliseStorage();
    final SharedPreferences prefs = permitsTokens!;
    return prefs.getBool('notFirstTime') ?? false;
  }

  Future<bool> setAuthToken(String token) async {
    return storage.write(key: 'AuthToken', value: token).then((value) {
      return true;
    }).onError((error, stackTrace) async {
      await _initiliseStorage();
      final SharedPreferences prefs = permitsTokens!;
      return prefs.setString('AuthToken', token);
    });
  }

  Future _initiliseStorage() async {
    permitsTokens = await SharedPreferences.getInstance();
  }

  final Dio _dio = Dio();
  Future<Dio> _initialize() async {
    _dio.options.followRedirects = true;
    _dio.options.headers['Content-Type'] = 'application/json';
    _dio.options.headers['Accept'] = '*/*';
    _dio.options.headers['token'] = await getAuthToken();
    _dio.options.baseUrl = LoopsUrls.baseUrl;

    /* await getAuthToken().then(
      (token) => {
        if (token != '') {_dio.options.headers['Authorization'] = token}
      },
    ); */
    // _dio.interceptors.add(PrettyDioLogger());
// customization
    // _dio.interceptors
    //     .add(PrettyDioLogger(requestHeader: true, requestBody: true));

    return _dio;
  }

//Requests

/* //GET
  Future<Response> get(String path, {Map<String, dynamic>? query}) async {
    final String reqPath = path;
    await _initialize();
    logger.d('Path: $path');
    logger.d('Query: ${jsonEncode(query)}');

    return _dio.get(reqPath, queryParameters: query).then((value) async {
      final Response response = value;
      /* final Map<String, dynamic> responseData =
          response.data as Map<String, dynamic>;
      if (responseData['code'] != 'SUCCESS') {
        await Fluttertoast.showToast(msg: responseData['message'] as String);
      } */
      if (response.statusCode == 401) {
        await deleteAuthToken();
        await Fluttertoast.showToast(
            msg: 'Unauthenticated!\n Please login again.');
        throw response.statusMessage ?? response.statusCode ?? 'Error';
      } else if (response.statusCode == 200 || response.statusCode == 201) {
        logger.d('Response: ${jsonEncode(response.data)}');
        return response;
      } else {
        throw response.statusMessage ?? response.statusCode ?? 'Error';
      }
    });
  } */

  //POST
  Future<Response> post(
    String path, {
    Map? data,
    Map<String, dynamic>? query,
  }) async {
    await _initialize();
    String reqPath = path;
    reqPath = reqPath;

    // ignore: prefer_typing_uninitialized_variables
    var formData;
    if (data != null) {
      formData = FormData.fromMap(convertMapToJson(data));
    }
    log('Path: ${_dio.options.baseUrl + reqPath}');
    log('Data: ${jsonEncode(data)}');
    log('Query: ${jsonEncode(query)}');

    return _dio.post(reqPath, data: formData, queryParameters: query).then(
      (value) async {
        final Response response = value;
        /*final Map<String, dynamic> responseData =
            response.data as Map<String, dynamic>;
         if (responseData['newUser'] != true &&
            responseData['code'] != 'SUCCESS') {
          await Fluttertoast.showToast(msg: responseData['message'] as String);
        } */

        if (response.statusCode == 401) {
          await deleteAuthToken();
          await Fluttertoast.showToast(
              msg: 'Unauthenticated!\n Please login again.');
          throw response.statusMessage ??
              response.statusCode ??
              'Error in POST';
        } else if (response.statusCode == 200 || response.statusCode == 201) {
          try {
            log('Response: $response');
            // ignore: avoid_catches_without_on_clauses
          } catch (_) {
            logger.e(_);
          }
          // try {
          //   if (response.data['msg'] != null) {
          //     throw response.data['msg'].toString();
          //   }
          //   // ignore: avoid_catches_without_on_clauses
          // } catch (_) {
          //   rethrow;
          // }
          return response;
        } else {
          throw response.statusMessage ??
              response.statusCode ??
              'Error in POST';
        }
      },
    ).onError((error, stackTrace) {
      handleError(error);
      throw error!;
    });
  }

  //PUT
  /* Future<Response> put(
    String path, {
    Map? data,
    Map<String, dynamic>? query,
  }) async {
    await _initialize();
    String reqPath = path;
    reqPath = reqPath;

    return _dio.put(reqPath, data: data, queryParameters: query).then(
      (value) async {
        final Response response = value;
        // final Map<String, dynamic> responseData =
        //     response.data as Map<String, dynamic>;
        /*  if (responseData['code'] != 'SUCCESS') {
          await Fluttertoast.showToast(msg: responseData['message'] as String);
          throw response.statusMessage ??
              response.statusCode ??
              'Error in POST';
        } else */
        if (response.statusCode == 401) {
          await deleteAuthToken();
          await Fluttertoast.showToast(
              msg: 'Unauthenticated!\n Please login again.');
          throw response.statusMessage ?? response.statusCode ?? 'Error in PUT';
        } else if (response.statusCode == 200 || response.statusCode == 201) {
          return response;
        } else {
          throw response.statusMessage ?? response.statusCode ?? 'Error in PUT';
        }
      },
    );
  } */

//DELETE
  /* Future<Response> delete(
    String path, {
    Map? data,
    Map<String, dynamic>? query,
  }) async {
    String reqPath = path;
    await _initialize();
    reqPath = reqPath;

    return _dio
        .delete(reqPath, data: data, queryParameters: query)
        .then((value) async {
      final Response response = value;
      /* final Map<String, dynamic> responseData =
          response.data as Map<String, dynamic>;
      if (responseData['code'] != 'SUCCESS') {
        await Fluttertoast.showToast(msg: responseData['message'] as String);
      } */

      if (response.statusCode == 401) {
        await deleteAuthToken();
        await Fluttertoast.showToast(
            msg: 'Unauthenticated!\n Please login again.');
        throw response.statusMessage ??
            response.statusCode ??
            'Error in DELETE';
      } else if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        throw response.statusMessage ??
            response.statusCode ??
            'Error in DELETE';
      }
    });
  } */
}

Map<String, dynamic> convertMapToJson(Map val) {
  final Map<String, dynamic> returnVal = {};
  val.keys.forEach((elementx) {
    returnVal.putIfAbsent(elementx.toString(), () => val[elementx]);
  });

  return returnVal;
}

// ignore_for_file: camel_case_types

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:EdTestz/phone_pay/fetchPaymentResult.dart';
import 'package:EdTestz/presentation/core/success_popup.dart';
import 'package:http/http.dart' as http;
import 'package:EdTestz/core/utli/api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

// import 'package:EdTestz/application/payment/payment_provider.dart';

class PhonePayApp extends StatefulWidget {
  PhonePayApp(
      {Key? key,
      required this.amount,
      required this.coins,
      required this.coupenId,
      required this.subId,
      required this.userId})
      : super(key: key);
  final num amount;
  final String userId, coupenId, coins, subId;
  @override
  State<PhonePayApp> createState() => _PhonePayAppState();
}

class _PhonePayAppState extends State<PhonePayApp> {

  late InAppWebViewController _webViewController;
  static late String tId;
  static const platform = MethodChannel('samples.flutter.dev/battery');
  String _apps = 'Unknown.';
  late String url;
  bool _isLoading = true;
  static const stream = EventChannel(
      'com.chamelalaboratory.demo.flutter_event_channel/eventChannel');

  late StreamSubscription _streamSubscription;
  double _currentValue = 0.0;

  // void _startListener() {
  //   _streamSubscription = stream.receiveBroadcastStream().listen(_listenStream);
  // }
  //
  // void _cancelListener() {
  //   _streamSubscription.cancel();
  //   setState(() {
  //     _currentValue = 0;
  //   });
  // }

  late Timer timer;

  @override
  void initState() {
    _intentFlow();
    timer = Timer.periodic(const Duration(seconds: 2), (timer) async {
      String webUrl = (await _webViewController.getUrl()).toString();
      debugPrint("timer web url :: " + webUrl);
      if (webUrl == "https://raoacademy.com/paymentphonepe/") {
        // call api here

        await Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => FetchPaymentStatus(
              amount: widget.amount.toString(),
              coins: widget.coins.toString(),
              mTID: tId.toString(),
              subId: widget.subId,
            ),
          ),
        );
      }
    });
    // _initPayemnt("com.phonepe.app", widget.amount);
    super.initState();
  }
  Future<void> _listenStream(value) async {
    debugPrint("Received From Native:  $value\n");
    final jsonData = jsonDecode(value.toString());
    debugPrint("result_code :: ${jsonData["result_code"]}");
    debugPrint("request_code :: ${jsonData["request_code"]}");

    if (jsonData["result_code"].toString() == "-1") {
      var dio = Dio();
      debugPrint("tID :: $tId");
      debugPrint("userId :: ${widget.userId}");
      debugPrint("couponId :: ${widget.coupenId.toString()}");
      debugPrint("amount :: ${widget.amount}");
      debugPrint("coins :: ${widget.coins}");
      FormData formData = FormData.fromMap({
        'userId': await APIClient().getUserId(),
        'couponId': widget.coupenId.toString(),
        'amount': widget.amount.toString(),
        'coins': widget.coins.toString(),
        'subsId': widget.subId,
        'paymentMethod': "UPI",
        'transactionId': tId.toString(),
        'status': "True",
        'comments': "smooth"
      });
      // var result = await dio.post(
      //     Uri.parse('https://3.111.215.74/fpayment/').toString(),
      //     data: formData);
      final result = await APIClient()
          .post(Uri.parse('https://3.111.215.74/fpayment/').toString(), data: {
        'userId': await APIClient().getUserId(),
        'couponId': widget.coupenId.toString(),
        'amount': widget.amount.toString(),
        'coins': widget.coins.toString(),
        'subsId': widget.subId,
        'merchantTransactionId': tId.toString(),
      });
      if (result.statusCode == 200 || result.statusCode == 201) {
        debugPrint(result.statusCode.toString());
        debugPrint(result.toString());
        // Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => LoaderPopup(
        //             text: "Payment Success", getValue: (value) {})));
        await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Payment Status"),
              content: Text("Payment Success"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Ok"))
              ],
            ));
      } else {
        throw result.statusMessage!;
      }
    } else {
      await showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Payment Status"),
                content: Text("Payment Failed"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Ok"))
                ],
              ));
      // Navigator.pop(context);
    }
  }

  //
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  final _random = new Random();
  int next(int min, int max) => min + _random.nextInt(max - min);
  Future<void> _intentFlow() async {
    try {
      tId = "MT${next(0000000000000000, pow(2, 32).toInt())}";
      // final result = await platform.invokeMethod('intentFlow');
      // debugPrint(result.toString());
      Map<String, dynamic> data = {
        "merchantId": "RAOACADEMYONLINE",
        "merchantTransactionId": tId,
        "merchantUserId": "MUID123",
        "amount": widget.amount * 100,
        "redirectUrl": "https://raoacademy.com/paymentphonepe",
        "redirectMode": "POST",
        "callbackUrl":
            "https://webhook.site/token/c1769b7d-8273-4100-a560-c98d6aa8cf73/requests",
        "mobileNumber": "8431757301",
        "paymentInstrument": {"type": "PAY_PAGE"}
      };

      String base64Str = base64.encode(jsonEncode(data).codeUnits);
      debugPrint("base64Str :: $base64Str");
      String apiEndPoint = "/pg/v1/pay";
      String salt = '1b6c088b-0e0c-4fb5-9924-9a8759e606f3';
      //

      String batteryLevel;
      final bytes = utf8.encode(base64Str + apiEndPoint + salt);
      var digest = sha256.convert(bytes);
      debugPrint("Digest 1 :: $digest");
      String checksum = "$digest###1";
      final response = await http.post(
        Uri.parse('https://api.phonepe.com/apis/hermes/pg/v1/pay'),
        headers: {
          "Content-Type": "application/json",
          "accept": "application/json",
          "X-VERIFY": checksum
        },
        body: jsonEncode(<String, dynamic>{"request": base64Str}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint("response :: " + response.body);
        Map<String, dynamic> res =
            jsonDecode(response.body) as Map<String, dynamic>;
        url =
            res['data']['instrumentResponse']['redirectInfo']["url"].toString();
        debugPrint("Launch URL :: " + url);
        setState(() {
          _isLoading = false;
        });
        // InAppWebView(
        //
        //   URLRequest: "https://flutter.dev/",
        //     initialOptions: InAppWebViewGroupOptions(
        //         crossPlatform: InAppWebViewOptions(
        //           debuggingEnabled: true,
        //         )
        //     ),);
      } else {
        await showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text("Payment Status"),
                  content: Text("Payment Failed"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Ok"))
                  ],
                ));
        Navigator.pop(context);
      }
      debugPrint("Launch URL :: " + "Launching URL");

      // _initPayemnt("com.phonepe.app", widget.amount);
      //todo verfication of payment form server side and then show the response
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
  }

  // Future<void> _initPayemnt(String packageName, num amount) async {
  //   tId = "MT${next(0000000000000000, pow(2, 32).toInt())}";
  //   final jsonBody = {
  //     "merchantId": "RAOACADEMYONLINE",
  //     "merchantTransactionId": tId,
  //     "merchantUserId": "MUID123",
  //     "amount": amount * 100,
  //     // "redirectUrl": "https://webhook.site/redirect-url",
  //     "redirectMode": "POST",
  //     "callbackUrl": "https://raoacademy.com/callbackurl",
  //     "mobileNumber": "9999999999",
  //     "paymentInstrument": {"type": "PAY_PAGE", "targetApp": packageName},
  //     "deviceContext": {"deviceOS": "ANDROID"}
  //   };
  //
  //   String base64Str = base64.encode(jsonEncode(jsonBody).codeUnits);
  //   debugPrint("base64Str :: $base64Str");
  //   String apiEndPoint = "/pg/v1/pay";
  //   String salt = '1b6c088b-0e0c-4fb5-9924-9a8759e606f3';
  //   //
  //
  //   String batteryLevel;
  //   final bytes = utf8.encode(base64Str + apiEndPoint + salt);
  //   var digest = sha256.convert(bytes);
  //   debugPrint("Digest 1 :: $digest");
  //   String checksum = "$digest###1";
  //   try {
  //     final String result = (await platform.invokeMethod('initPayment', {
  //       'base64': base64Str,
  //       'checksum': checksum,
  //       'apiEndPoint': apiEndPoint,
  //       'packageName': packageName
  //     }))
  //         .toString();
  //     _startListener();
  //     debugPrint("Result jj $result");
  //     batteryLevel = 'Payment apps $result.';
  //
  //     //todo verfication of payment form server side and then show the response
  //   } on PlatformException catch (e) {
  //     batteryLevel = '${e.message}';
  //   }
  //
  //   setState(() {
  //     _apps = batteryLevel;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (_isLoading)
              CircularProgressIndicator()
            else
              Expanded(
                child: SafeArea(
                  child: InAppWebView(
                    initialUrlRequest: URLRequest(url: Uri.parse(url)),
                    onWebViewCreated: (InAppWebViewController controller) {
                      _webViewController = controller;
                    },
                    // onLoadStop:(InAppWebViewController controller, uri) {
                    //   setState(() {
                    //     _webViewController.loadUrl(urlRequest: URLRequest(url: Uri.parse(uri!.path)));
                    //   });
                    //   debugPrint("url ::" + url);
                    // } ,
                    onLoadStart: (InAppWebViewController controller, uri) {
                      _webViewController = controller;
                      // setState(() {
                      //   _webViewController.loadUrl(urlRequest: URLRequest(url: Uri.parse(uri!.path)));
                      // });
                      debugPrint("url ::" + url);
                      if (uri?.path ==
                          "https://raoacademy.com/paymentphonepe") {
                        controller.goBack();
                        debugPrint("web view :: navigat redirect");
                        //navigate to the desired screen with arguments
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoaderPopup(
                                    text: "Payment Success",
                                    getValue: (value) {})));
                      }
                    },
                    // onLoadStart: (_webViewController, String url) {
                    //   setState(() {
                    //     _con.url = url;
                    //   });
                    //   if (url == "return_url") {
                    //     //close the webview
                    //     _con.webView.goBack();
                    //
                    //     //navigate to the desired screen with arguments
                    //     Navigator.of(context).pushReplacementNamed('/OrderSuccess',
                    //         arguments:
                    //         new RouteArgument(param: 'Credit Card (Paytabs)'));
                    //   }
                    // },
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}

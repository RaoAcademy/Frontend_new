import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:EdTestz/application/test/test_provider.dart';
import 'package:EdTestz/application/other/other_provider.dart';
import 'package:EdTestz/core/utli/loops_urls.dart';
import 'package:provider/provider.dart';
import 'package:EdTestz/presentation/test_screens/widget/test_history_widget.dart';

class TestHistory extends StatefulWidget {
  TestHistory({Key? key}) : super(key: key);

  @override
  State<TestHistory> createState() => _TestHistoryState();
}

class _TestHistoryState extends State<TestHistory> {



  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TestProvider>();
    if (kDebugMode) {
      print("HISTORY");
      print(provider.testHistoryEntity.filter1?.length);
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            Provider
                .of<OtherProvider>(context, listen: false)
                .routeNames
                .remove(Provider
                .of<OtherProvider>(context, listen: false)
                .routeNames
                .last);
          },
          icon: Icon(
            Icons.arrow_back,
            color: LoopsColors.whiteBkground,
            size: 24.sp,
          ),
        ),
        backgroundColor: LoopsColors.primaryColor,
        title: Text(
          'Test History',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: TestHistoryWidget(),
    );
    }
  }

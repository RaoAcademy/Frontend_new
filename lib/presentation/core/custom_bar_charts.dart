import 'package:curved_progress_bar/curved_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:EdTestz/core/utli/loops_urls.dart';
import 'package:EdTestz/domain/entities/analytics_data_entity.dart';

class CustomBarChart extends StatelessWidget {
  const CustomBarChart({
    Key? key,
    required this.data,
  }) : super(key: key);
  final List<AnalyticData> data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 280.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            /*  width: MediaQuery.of(context).size.width,
            height: 200, */
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Align(
                  child: Container(
                    width:
                        MediaQuery.of(context).size.width / (data.length + 2),
                    height: 180.h,
                    constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          // width: MediaQuery.of(context).size.width /
                          //     (data.length + 2),
                          // height: 140.h,
                          child: Stack(
                            alignment: AlignmentDirectional.bottomStart,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  RotatedBox(
                                    quarterTurns: 1,
                                    child: SizedBox(
                                      width: data[index].tests * 2.h,
                                      height: 2.sp,
                                      child: CurvedLinearProgressIndicator(
                                        color: LoopsColors.primaryColor,
                                        backgroundColor: LoopsColors.colorGrey
                                            .withOpacity(0.3),
                                        value: 1,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Positioned(
                                bottom: (data[index].tests * 2.h) + 3.h,
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width /
                                      (data.length + 2),
                                  child: Center(
                                    child: Text(
                                      data[index].tests.toString(),
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width /
                              (data.length + 2),
                          height: 40,
                          child: Center(
                            child: Text(
                              data[index].day,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

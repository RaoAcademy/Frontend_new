import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:EdTestz/application/home/home_provider.dart';
import 'package:EdTestz/application/other/other_provider.dart';
import 'package:EdTestz/core/utli/loops_urls.dart';
import 'package:EdTestz/core/widgets/container_with_border.dart';
import 'package:EdTestz/presentation/other/widgets/cached_network_image.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.read<HomeProvider>();
    if (kDebugMode) {
      print("Notificatiın");
      // print(provider.notificationHistoryEntity.notifications?[0].imagePath);
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ContainerWithBorder(
              boxShadow: [
                BoxShadow(
                    blurRadius: 10,
                    color: LoopsColors.lightGrey.withOpacity(0.4),
                    offset: Offset(5.sp, 5.sp))
              ],
              height: 64.h,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Provider.of<OtherProvider>(context, listen: false)
                          .routeNames
                          .remove(
                              Provider.of<OtherProvider>(context, listen: false)
                                  .routeNames
                                  .last);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: LoopsColors.tertiaryColor,
                      size: 24.sp,
                    ),
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  Text(
                    'Notification',
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: LoopsColors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            Expanded(
              child: ContainerWithBorder(
                width: MediaQuery.of(context).size.width,
                borderRadius: 10.sp,

                // margin: EdgeInsets.symmetric(horizontal: 1.w),

                boxShadow: [
                  BoxShadow(
                      blurRadius: 10,
                      color: LoopsColors.lightGrey.withOpacity(0.4),
                      offset: Offset(4.sp, 4.sp))
                ],
                child:  provider.notificationHistoryEntity.notifications?.isEmpty ?? false ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Image.asset("assets/images/other/notification.png",height: 60,width: 60,color: Colors.black54,),
                      ),
                      Text("No notifications yet",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black38,fontSize: 22),),
                      Text("When you get notifications, they'll show up here",style: TextStyle(fontWeight: FontWeight.w400,color: Colors.black38,fontSize: 14),),
                      SizedBox(height: 80,),
                    ],
                  ),
                ) : ListView.builder(
                  itemCount:
                      provider.notificationHistoryEntity.notifications?.length,
                  itemBuilder: (context, index) => ContainerWithBorder(
                    margin: EdgeInsets.symmetric(vertical: 14.h),
                    borderRadius: 12.sp,
                    borderColor: LoopsColors.textColor,
                    child: Row(
                      children: [
                        ContainerWithBorder(
                          margin: EdgeInsets.all(10.sp),
                          width: 50.sp,
                          height: 50.sp,
                          borderRadius: 50.sp,
                          boxColor: LoopsColors.lightGrey,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(40.sp),
                            child: LoopsImage(
                              path: provider.notificationHistoryEntity
                                      .notifications?[index].imagePath ??
                                  '',
                              fit: BoxFit.fill,
                              // scale: 0.2,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  provider.notificationHistoryEntity
                                          .notifications?[index].title ??
                                      '',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  maxLines: 10,
                                ),
                                Text(
                                  provider.notificationHistoryEntity
                                          .notifications?[index].message ??
                                      '',
                                  // style: TextStyle(fontWeight: FontWeight.bold),
                                  maxLines: 10,
                                ),
                              ]),
                        ),
                        // Column(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Container(
                        //       height: 50.h,
                        //     ),
                        //     IconButton(
                        //         onPressed: () {},
                        //         icon: Icon(
                        //           Icons.delete_forever_outlined,
                        //           color: LoopsColors.colorRed,
                        //         ))
                        //   ],
                        // )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

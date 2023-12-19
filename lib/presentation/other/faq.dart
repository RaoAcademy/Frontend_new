import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rao_academy/application/home/home_provider.dart';
import 'package:rao_academy/application/other/other_provider.dart';
import 'package:rao_academy/core/theme/custom_scroll_behaviour.dart';
import 'package:rao_academy/core/utli/loops_urls.dart';
import 'package:rao_academy/core/widgets/container_with_border.dart';
import 'package:rao_academy/core/widgets/expandable_panel_with_child.dart';

class FAQ extends StatelessWidget {
  const FAQ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.read<HomeProvider>();
    return SafeArea(
      child: Scaffold(
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
                            .remove(Provider.of<OtherProvider>(context,
                                    listen: false)
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
                      'FAQ',
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
                height: 8.h,
              ),
              ContainerWithBorder(
                width: MediaQuery.of(context).size.width,
                borderRadius: 10.sp,
                height: MediaQuery.of(context).size.height - 140.h,
                // margin: EdgeInsets.symmetric(horizontal: 1.w),

                boxShadow: [
                  BoxShadow(
                      blurRadius: 10,
                      color: LoopsColors.lightGrey.withOpacity(0.4),
                      offset: Offset(5.sp, 5.sp))
                ],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ScrollConfiguration(
                    behavior: MyBehavior(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 16.h,
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: provider.allfaqs.length,
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (provider.allfaqs[index].isNotEmpty &&
                                      provider.allfaqs[index].first.type !=
                                          null)
                                    Text(
                                      provider.allfaqs[index].first.type!,
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: LoopsColors.colorBlack,
                                      ),
                                    ),
                                  if (provider.allfaqs[index].isNotEmpty &&
                                      provider.allfaqs[index].first.type !=
                                          null)
                                    for (int i = 0;
                                        i < provider.allfaqs[index].length;
                                        i++)
                                      showExpandablePanelWC(
                                        provider.allfaqs[index][i].question ??
                                            '',
                                        Text(
                                            provider.allfaqs[index][i].answer ??
                                                ''),
                                      ),
                                  if (provider.faqs[index].isNotEmpty &&
                                      provider.faqs[index].first.type != null)
                                    SizedBox(
                                      height: 24.h,
                                    ),
                                ],
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rao_academy/application/auth/auth_provider.dart';
import 'package:rao_academy/application/other/other_provider.dart';
import 'package:rao_academy/application/splash/splash_provider.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:rao_academy/core/theme/theme.dart';
import 'package:rao_academy/core/utli/loops_urls.dart';
import 'package:rao_academy/presentation/splash/widgets/indicators.dart';

class Info01 extends StatelessWidget {
  const Info01({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SplashProvider splashProvider = context.watch<SplashProvider>();
    final AuthProvider authProvider = context.watch<AuthProvider>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: LoopsColors.primaryColor,
        body: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: PageView.builder(
                  itemCount: authProvider.splashScreens.length,
                  // controller: _pageController,
                  onPageChanged: (pageIndex) {
                    splashProvider.currentIndex = pageIndex;
                    splashProvider.setState();
                  },
                  itemBuilder: (context, pagePosition) {
                    return AnimatedContainer(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOutCubic,
                      child: Stack(
                        children: [
                          Positioned(
                            top: 0.h,
                            left: 0,
                            right: 0,
                            child: Image.asset(
                             'assets/images/other/Splashscreen${pagePosition + 1}.png',
                             fit: BoxFit.fill,
                              ),
                          ),
                          /* Positioned(
                            top: 50,
                            left: -300,
                            right: -300,
                            child: Transform.rotate(
                              angle: 12,
                              child: Center(
                                child: Container(
                                  height: MediaQuery.of(context).size.height,
                                  width: 800.h,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: <Color>[
                                    LoopsColors.primaryColor.withOpacity(0),
                                    Colors.white.withOpacity(0.01),
                                    Colors.white.withOpacity(0.2),
                                  ])),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 200,
                            left: -300,
                            right: -300,
                            child: Transform.rotate(
                              angle: 12,
                              child: Center(
                                child: Container(
                                  height: 96.h,
                                  width: 800.h,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: <Color>[
                                    LoopsColors.primaryColor.withOpacity(0),
                                    LoopsColors.primaryColor.withOpacity(0),
                                    Colors.white.withOpacity(0.01),
                                    Colors.white.withOpacity(0.1),
                                  ])),
                                ),
                              ),
                            ),
                          ), */
                          /* SvgPicture.asset(
                            'assets/images/bgs/info01.svg',
                          ), */
                          Padding(
                            padding: EdgeInsets.all(24.sp),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 1.8,
                                ),
                                Center(
                                  child: Text(
                                    authProvider.splashScreens[pagePosition]
                                            .text1 ??
                                        '',
                                    style: appTheme.textTheme.displayMedium!
                                        .copyWith(
                                            color: LoopsColors.colorWhite),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(
                                  height: 23.h,
                                ),
                                Text(
                                  authProvider
                                          .splashScreens[pagePosition].text2 ??
                                      '',
                                  style: appTheme.textTheme.headlineSmall!
                                      .copyWith(color: LoopsColors.colorWhite),
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
            Positioned(
              bottom: 50,
              left: 0,
              right: 0,
              child: Center(
                child: splashProvider.currentIndex !=
                        (authProvider.splashScreens.length - 1)
                    ? Indicators(
                        count: authProvider.splashScreens.length,
                        activeIndex: splashProvider.currentIndex,
                      )
                    : InkWell(
                        onTap: () {
                          Provider.of<OtherProvider>(context, listen: false)
                              .routeNames
                              .add('/signIn');
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/signIn',
                            (route) => false,
                          );
                        },
                        child: Text(
                          'Get Started >',
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: LoopsColors.colorWhite,
                            fontWeight: FontWeight.w600,
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

// import 'package:firebase_auth/firebase_auth.dart';
// ignore_for_file: avoid_catches_without_on_clauses, avoid_dynamic_calls

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:injectable/injectable.dart';
// import 'package:EdTestz/domain/entities/user_entity.dart';
import 'package:provider/provider.dart';
import 'package:EdTestz/application/auth/auth_provider.dart';
import 'package:EdTestz/application/firebase/firebase_notification_provider.dart';
import 'package:EdTestz/application/home/home_provider.dart';
import 'package:EdTestz/core/utli/api_client.dart';
import 'package:EdTestz/core/utli/goto_pages.dart';
import 'package:EdTestz/core/utli/logger.dart';
import 'package:EdTestz/core/utli/loops_urls.dart';
import 'package:EdTestz/core/utli/show_error_toast.dart';
// import 'package:EdTestz/core/widgets/container_with_border.dart';
import 'package:EdTestz/domain/auth/auth_repo.dart';
import 'package:EdTestz/domain/entities/avatars_entity.dart';
import 'package:EdTestz/domain/entities/bookmark_questions_entity.dart';
import 'package:EdTestz/domain/entities/bookmark_test_entity.dart';
import 'package:EdTestz/domain/entities/login_entity.dart';
import 'package:EdTestz/domain/entities/profile_details_entity.dart';
import 'package:EdTestz/domain/entities/profile_entity.dart';
import 'package:EdTestz/domain/entities/profile_update_entity.dart';
import 'package:EdTestz/domain/entities/referal_validate_entity.dart';
import 'package:EdTestz/domain/entities/school_exist_entity.dart';
import 'package:EdTestz/domain/entities/sign_up_entity.dart';
import 'package:EdTestz/domain/entities/splash_screen_entity.dart';
import 'package:EdTestz/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../application/other/other_provider.dart';

@LazySingleton(as: AuthRepo)
class ImpAuthRepo extends AuthRepo {
  ImpAuthRepo(this._apiClient);
  final APIClient _apiClient;

  FirebaseAuth auth = FirebaseAuth.instance;
  String? verificationId;
  UserCredential? credential;
  final AuthAppProvider? provider =
      navigatorKey.currentContext?.read<AuthAppProvider>();

  @override
  Future<void> getOtp(String mobileNumber, BuildContext context) async {
    try {
      await auth.verifyPhoneNumber(
          phoneNumber: '+91$mobileNumber',
          timeout: const Duration(seconds: 60),
          codeAutoRetrievalTimeout: (String verificationId) {
            showErrorToast('Timeout!');
          },
          codeSent: (String verificationId, num? forceResendingToken) async {
            otpStream.listen((value) async {
              logger.d(value);
              if (value.isNotEmpty) {
                logger.d(value);
                /* await showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => AlertDialog(
                    backgroundColor: Colors.transparent,
                    content: ContainerWithBorder(
                      boxColor: Colors.transparent,
                      height: 32.sp,
                      width: 32.sp,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                ); */

                credential = await auth
                    .signInWithCredential(PhoneAuthProvider.credential(
                        verificationId: verificationId, smsCode: value))
                    .onError((error, stackTrace) {
                  Navigator.pop(context);
                  showErrorToast(error!);
                  throw error;
                }).then((_) {
                  logger.d(value);
                  return loginNextSteps(mobileNumber, context, _);
                });
              }
            });
          },
          verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {
            verificationId = phoneAuthCredential.verificationId;
          },
          verificationFailed: (FirebaseAuthException error) {
            Navigator.pop(context);
            showErrorToast(error);
          });
    } catch (e) {
      Navigator.pop(context);
      rethrow;
    }
    // Wait for the user to complete the reCAPTCHA & for an SMS code to be sent.
  }

  Future<UserCredential> loginNextSteps(
      String mobileNumber, BuildContext context, UserCredential credential) async {
    if (credential.additionalUserInfo!.isNewUser) {

      Provider.of<OtherProvider>(context, listen: false)
          .routeNames
          .add('/signUpForm');
      await Navigator.pushNamedAndRemoveUntil(
        context,
        '/signUpForm',
            (route) => false,
      );
      }else{
        await flogin(mobile: mobileNumber, fcmToken: fcmTokenGlobal)
          .then((loginEntity)  async {
        logger.d(credential);
        await Future.delayed(Duration(seconds: 3)).then((value) {
          Provider.of<AuthAppProvider>(context, listen: false).loginEntity =
              loginEntity;
        });

        if (credential.additionalUserInfo!.isNewUser) {
          if (loginEntity.newUser!) {
            await Future.delayed(Duration(seconds: 2)).then((value) async {
              await gotoSignupPage(context);
            });
          } else {
            await provider?.setUserId(int.parse(loginEntity.userId.toString()));
            await _apiClient
                .setAuthToken(loginEntity.token.toString())
                .then((value) async {
              await Provider.of<AuthAppProvider>(context, listen: false)
                  .setUserId(loginEntity.userId!.toInt())
                  .then((value) async {
                await Provider.of<HomeProvider>(context, listen: false)
                    .fhome()
                    .then((_) {
                      Provider.of<HomeProvider>(context,listen: false).fhomeReports("This week");
                  // Navigator.pop(context);
                  gotoHomePage(context);
                }).onError((error, stackTrace) {
                  Fluttertoast.showToast(msg: 'Error in fhome API:\n$error');
                });
              });
            });
          }
        } else {
          if (loginEntity.newUser! == false) {
            await provider?.setUserId(int.parse(loginEntity.userId.toString()));
            await _apiClient
                .setAuthToken(loginEntity.token.toString())
                .then((value) async {
              await Provider.of<AuthAppProvider>(context, listen: false)
                  .setUserId(loginEntity.userId!.toInt())
                  .then((value) async {
                await Provider.of<AuthAppProvider>(context, listen: false)
                    .fprofileDetailed()
                    .then((_) {
                  // Navigator.pop(context);
                  gotoHomePage(context);
                });
              });
            });
          } else {
            // Navigator.pop(context);
            await Future.delayed(Duration.zero).then((value) async {
              await gotoSignupPage(context);
            });
          }
        }

      });
    }
    return credential;
  }

  @override
  Future<Profile> fprofile() async {
    final result = await _apiClient.post(LoopsUrls.fprofile, data: {
      'userId': await _apiClient.getUserId(),
    });
    if (result.statusCode == 200 || result.statusCode == 201) {
      return Profile.fromJson(result.data as Map<String, dynamic>);
    } else {
      throw result.statusMessage!;
    }
  }

  @override
  Future<AvatarsEntity> favatar({num? avatarId, bool? update}) async {
    final result = await _apiClient.post(LoopsUrls.favatar, data: {
      'userId': await _apiClient.getUserId(),
      if (avatarId != null) 'avatarId': avatarId,
      if (update != null) 'update': update,
    });
    if (result.statusCode == 200 || result.statusCode == 201) {
      return AvatarsEntity.fromJson(result.data as Map<String, dynamic>);
    } else {
      throw result.statusMessage!;
    }
  }

  @override
  Future<BookmarkQuestionsEntity> fbookmarkQuestion({num? subjectId}) async {
    final result = await _apiClient.post(LoopsUrls.fbookmarkQuestion, data: {
      'userId': await _apiClient.getUserId(),
      'subjectId': subjectId ?? 1,
    });
    if (result.statusCode == 200 || result.statusCode == 201) {
      return BookmarkQuestionsEntity.fromJson(
          result.data as Map<String, dynamic>);
    } else {
      throw result.statusMessage!;
    }
  }

  @override
  Future<BookmarkTestEntity> fbookmarkTest({num? subjectId}) async {
    final result = await _apiClient.post(LoopsUrls.fbookmarkTest, data: {
      'userId': await _apiClient.getUserId(),
      /* if (subjectId != null) */ 'subjectId': subjectId ?? 1,
    });
    if (result.statusCode == 200 || result.statusCode == 201) {
      return BookmarkTestEntity.fromJson(result.data as Map<String, dynamic>);
    } else {
      throw result.statusMessage!;
    }
  }

  @override
  Future<LoginEntity> flogin(
      {String? mobile,
      String? mac,
      String? location,
      String? ip,
      required String fcmToken}) async {
    final result = await _apiClient.post(LoopsUrls.flogin, data: {
      if (mobile != null) 'mobile': mobile,
      if (mac != null) 'mac': mac,
      if (location != null) 'location': location,
      if (ip != null) 'ip': ip,
      'fcmToken': fcmToken,
    });
    if (result.statusCode == 200 || result.statusCode == 201) {
      return LoginEntity.fromJson(result.data as Map<String, dynamic>);
    } else {
      throw result.statusMessage!;
    }
  }

  @override
  Future<ProfileDetailsEntity> fprofileDetailed() async {
    final result = await _apiClient.post(LoopsUrls.fprofileDetailed, data: {
      'userId': await _apiClient.getUserId(),
    });
    if (result.statusCode == 200 || result.statusCode == 201) {
      return ProfileDetailsEntity.fromJson(result.data as Map<String, dynamic>);
    } else {
      throw result.statusMessage!;
    }
  }

  @override
  Future<ProfileUpdateEntity> fprofileUpdate(
      ProfileUpdateEntity profileUpdateEntity, int updateFlag) async {
    profileUpdateEntity.userId = int.parse(await _apiClient.getUserId());
    if (kDebugMode) {
      print("Update_Debug");
      print(updateFlag);
    }
    final result = await _apiClient.post(LoopsUrls.fprofileUpdate,
        data: ((updateFlag == 1)
            ? profileUpdateEntity.toJson()
            : {'userId': profileUpdateEntity.userId}));
    if (result.statusCode == 200 || result.statusCode == 201) {
      return ProfileUpdateEntity.fromJson(result.data as Map<String, dynamic>);
    } else {
      throw result.statusMessage!;
    }
  }

  @override
  Future<SchoolExistEntity> fschool(
      {String? schoolName,
      String? schoolAddress,
      String? schoolCity,
      String? board}) async {
    final result = await _apiClient.post(LoopsUrls.fschool, data: {
      if (schoolName != null) 'schoolName': schoolName,
      if (schoolAddress != null) 'schoolAddress': schoolAddress,
      if (schoolCity != null) 'schoolCity': schoolCity,
      if (board != null) 'board': board,
    });
    if (result.statusCode == 200 || result.statusCode == 201) {
      return SchoolExistEntity.fromJson(result.data as Map<String, dynamic>);
    } else {
      throw result.statusMessage!;
    }
  }

  @override
  Future<SignUpEntity> fsignup(
      {String? firstname,
      String? lastname,
      String? gender,
      String? dob,
      num? board,
      num? grade,
      String? school,
      String? mobile,
      String? peerReferral,
      bool? update,
      required String fcmToken}) async {
    final result = await _apiClient.post(LoopsUrls.fsignup, data: {
      if (firstname != null) 'firstname': firstname,
      if (lastname != null) 'lastname': lastname,
      if (gender != null) 'gender': gender,
      if (dob != null) 'dob': dob,
      if (board != null) 'board': board,
      if (grade != null) 'grade': grade,
      if (school != null) 'school': school,
      if (mobile != null) 'mobile': mobile,
      if (peerReferral != '') 'peerReferral': peerReferral,
      if (update != null) 'update': update,
      'fcmToken': fcmToken
    });
    if (result.statusCode == 200 || result.statusCode == 201) {
      try {
        if (result.data['Added'] as bool) {
          await flogin(mobile: mobile, fcmToken: fcmToken)
              .then((response) async {
            // await provider?.setUserId(int.parse(response.userId.toString()));
            SharedPreferences preferences = await SharedPreferences.getInstance();
          await  preferences.setInt('UserId', int.parse(response.userId.toString()));
            await _apiClient.setAuthToken(response.token.toString());
          });
        }
      } catch (_) {}
      return SignUpEntity.fromJson(result.data as Map<String, dynamic>);
    } else {
      throw result.statusMessage!;
    }
  }

  @override
  Future<void> fuserActive() async {
    final result = await _apiClient.post(LoopsUrls.fuserActive, data: {
      'userId': await _apiClient.getUserId(),
    });
    if (result.statusCode == 200 || result.statusCode == 201) {
      return;
    } else {
      throw result.statusMessage!;
    }
  }

  @override
  Future<ValidateReferalEntity> fvalidateReferral(String referral) async {
    final result = await _apiClient.post(LoopsUrls.fvalidateReferral, data: {
      'referral': referral,
    });
    if (result.statusCode == 200 || result.statusCode == 201) {
      return ValidateReferalEntity.fromJson(
          result.data as Map<String, dynamic>);
    } else {
      throw result.statusMessage!;
    }
  }

  @override
  Future<List<SplashScreenEntity>> fsplashScreen() async {
    final List<SplashScreenEntity> list = [];
    final result = await _apiClient.post(
      LoopsUrls.fsplashScreen,
    );
    if (result.statusCode == 200 || result.statusCode == 201) {
      (result.data['list'] as List).forEach((element) {
        list.add(SplashScreenEntity.fromJson(element as Map<String, dynamic>));
      });
      return list;
    } else {
      throw result.statusMessage!;
    }
  }
}

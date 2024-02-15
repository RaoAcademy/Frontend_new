// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
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
// import 'package:EdTestz/domain/entities/user_entity.dart';

abstract class AuthRepo {
  Future<void> getOtp(String mobileNumber, BuildContext context);
  Future<List<SplashScreenEntity>> fsplashScreen();
  // Future<void> signUp(UserEntity formData);
  Future<LoginEntity> flogin({
    String? mobile,
    String? mac,
    String? location,
    String? ip,
    required String fcmToken,
  });
  Future<SignUpEntity> fsignup({
    String? firstname,
    String? lastname,
    String? gender,
    String? dob,
    num? board,
    num? grade,
    String? school,
    String? mobile,
    String? peerReferral,
    bool? update,
    required String fcmToken,
  });
  Future<void> fuserActive();
  Future<Profile> fprofile();
  Future<ProfileDetailsEntity> fprofileDetailed();
  Future<ProfileUpdateEntity> fprofileUpdate(
      ProfileUpdateEntity profileUpdateEntity, int updateFlag);

  Future<ValidateReferalEntity> fvalidateReferral(String referral);
  Future<AvatarsEntity> favatar({
    num? avatarId,
    bool? update,
  });
  Future<SchoolExistEntity> fschool({
    String? schoolName,
    String? schoolAddress,
    String? schoolCity,
    String? board,
  });

  Future<BookmarkTestEntity> fbookmarkTest({
    num? subjectId,
  });


  Future<BookmarkQuestionsEntity> fbookmarkQuestion({
    num? subjectId,
  });
}

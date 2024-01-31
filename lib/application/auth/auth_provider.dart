import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rao_academy/core/utli/api_client.dart';
import 'package:rao_academy/core/utli/error_handle.dart';
import 'package:rao_academy/domain/auth/auth_repo.dart';
import 'package:rao_academy/domain/entities/avatars_entity.dart';
import 'package:rao_academy/domain/entities/bookmark_questions_entity.dart';
import 'package:rao_academy/domain/entities/bookmark_test_entity.dart';
import 'package:rao_academy/domain/entities/login_entity.dart';
import 'package:rao_academy/domain/entities/profile_details_entity.dart';
import 'package:rao_academy/domain/entities/profile_entity.dart';
import 'package:rao_academy/domain/entities/profile_update_entity.dart';
import 'package:rao_academy/domain/entities/referal_validate_entity.dart';
import 'package:rao_academy/domain/entities/school_exist_entity.dart';
import 'package:rao_academy/domain/entities/sign_up_entity.dart';
import 'package:rao_academy/domain/entities/splash_screen_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:version/version.dart';

StreamController<String> _otpStream = StreamController<String>();
StreamSink<String> otpSink = _otpStream.sink;
Stream<String> otpStream = _otpStream.stream;

@injectable
class AuthAppProvider with ChangeNotifier {
  AuthAppProvider(
    this.repo,
  );
  final AuthRepo repo;

  bool locationPermission = false;
  bool waiting = false;
  bool authenticated = false;
  Version currentVersion = Version(1, 0, 0);

  SignUpEntity signUpEntity = SignUpEntity();
  Profile profile = Profile();
  ProfileDetailsEntity profileDetailsEntity = ProfileDetailsEntity();
  ProfileUpdateEntity profileUpdateEntity = ProfileUpdateEntity();
  ValidateReferalEntity validateReferalEntity = ValidateReferalEntity();
  AvatarsEntity avatarsEntity = AvatarsEntity();
  BookmarkTestEntity bookmarkTestEntity = BookmarkTestEntity();
  BookmarkQuestionsEntity bookmarkQuestionsEntity = BookmarkQuestionsEntity();
  SchoolExistEntity schoolExistEntity = SchoolExistEntity();
  List<SplashScreenEntity> splashScreens = [];

  TextEditingController phoneController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController dobController = TextEditingController(text: '');
  TextEditingController boardController = TextEditingController();
  TextEditingController classController = TextEditingController();
  TextEditingController schoolController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController parentController = TextEditingController();
  TextEditingController lastResultController = TextEditingController();
  TextEditingController otpController = TextEditingController(text: '');
  DateTime dob = DateTime.now();

  LoginEntity loginEntity = LoginEntity();

  String otp = '';
  bool showTest = true;

  final APIClient apiClient = APIClient();

  // ignore: use_late_for_private_fields_and_variables
  SharedPreferences? _preferences;
  Future _initiliseSharedPreferences() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<void> logout() async {
    await apiClient.deleteAuthToken();
    await setUserId(0);
    try {
      final appDir = (await getTemporaryDirectory()).path;
      await Directory(appDir).delete(recursive: true);
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      await handleError(e);
    }
  }

  Future<void> checkReferralCode() async {
    // await apiClient.;
    await setUserId(0);
    try {
      final appDir = (await getTemporaryDirectory()).path;
      await Directory(appDir).delete(recursive: true);
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      await handleError(e);
    }
  }

  Future<int> getUserId() async {
    await _initiliseSharedPreferences();
    return _preferences?.getInt('UserId') ?? 0;
    // return 1; // Supsressed for the emulator you should open relase
  }

  Future<bool> setUserId(int value) async {
    await _initiliseSharedPreferences();
    return _preferences!.setInt('UserId', value);
  }

  Future<bool> setOnceInstallKey() async {
    await _initiliseSharedPreferences();
    return _preferences!.setInt('intro', 1);
  }

  Future<int> getInstallKey() async {
    await _initiliseSharedPreferences();
    return _preferences?.getInt('intro') ?? 0;
  }

  // Future<bool> flogin(String mobile) async {
  //   final resp = await repo.flogin(mobile: mobile);
  //   return setUserId(resp.userId ?? 0);
  // }

  Future<void> fsplashScreen() async {
    splashScreens = await repo.fsplashScreen();
    notifyListeners();
  }

  Future<void> getOtp(String phone, BuildContext context) async {
    await repo.getOtp(phone, context).then((_) {}).onError((error, stackTrace) {
      throw error!;
    });
  }

  Future<void> setWaiting({required bool isWaiting}) async {
    waiting = isWaiting;
    notifyListeners();
  }

  void setState() {
    notifyListeners();
  }

  void setDOB(DateTime val) {
    dob = val;
    dobController.text = '${val.year}-${val.month}-${val.day}';
    notifyListeners();
  }

  // String getMonth(int val) {
  //   switch (val) {
  //     case 1:
  //       return 'Jan';
  //     case 2:
  //       return 'Feb';
  //     case 3:
  //       return 'Mar';
  //     case 4:
  //       return 'Apr';
  //     case 5:
  //       return 'May';
  //     case 6:
  //       return 'Jun';
  //     case 7:
  //       return 'Jul';
  //     case 8:
  //       return 'Aug';
  //     case 9:
  //       return 'Sep';
  //     case 10:
  //       return 'Oct';
  //     case 11:
  //       return 'Nov';
  //     case 12:
  //       return 'Dec';

  //     default:
  //       return '';
  //   }
  // }

  Future<dynamic> getVersionData() async {
    await PackageInfo.fromPlatform().then((packageInfo) {
      final String version = packageInfo.version;
      final Version currentVersion = Version.parse(version);
      final Version versionWithBuildNumber = Version(
          currentVersion.major, currentVersion.minor, currentVersion.patch,
          build: packageInfo.buildNumber);
      this.currentVersion = versionWithBuildNumber;
    });

    notifyListeners();
  }

  Future<void> fsignup(
      {String? firstname,
      String? lastname,
      String? gender,
      String? dob,
      num? board,
      num? grade,
      String? school,
      String? mobile,
      String? peerReferral,
      required String fcmToken,
      bool? update}) async {
    signUpEntity = await repo.fsignup(
      firstname: firstname,
      lastname: lastname,
      gender: gender?.toLowerCase(),
      dob: dob,
      board: board,
      grade: grade,
      school: school,
      mobile: mobile,
      peerReferral: peerReferral,
      update: update,
      fcmToken: fcmToken,
    );
    notifyListeners();
  }

  Future<void> fuserActive() async {
    await repo.fuserActive();
    notifyListeners();
  }

  Future<void> fprofile() async {
    profile = await repo.fprofile();
    notifyListeners();
  }

  Future<void> fValidateRefrral() async {
    profile = await repo.fprofile();
    notifyListeners();
  }

  Future<void> fprofileDetailed() async {
    profileDetailsEntity = await repo.fprofileDetailed();
    notifyListeners();
  }

  Future<void> fprofileUpdate(
      ProfileUpdateEntity profileUpdate, int updateFlag) async {
    profileUpdateEntity = await repo.fprofileUpdate(profileUpdate, updateFlag);
    notifyListeners();
  }

  Future<void> fvalidateReferral(String referral) async {
    validateReferalEntity = await repo.fvalidateReferral(referral);
    notifyListeners();
  }

  Future<void> favatar({
    num? avatarId,
    bool? update,
  }) async {
    avatarsEntity = await repo.favatar(
      avatarId: avatarId,
      update: update,
    );
    notifyListeners();
  }

  Future<bool> fschool({
    String? schoolName,
    String? schoolAddress,
    String? schoolCity,
    String? board,
  }) async {
    schoolExistEntity = await repo.fschool(
      schoolName: schoolName,
      schoolAddress: schoolAddress,
      schoolCity: schoolCity,
      board: board,
    );
    notifyListeners();
    return schoolExistEntity.school == 'exists';
  }

  Future<void> fbookmarkTest({
    num? subjectId,
  }) async {
    showTest = true;
    bookmarkTestEntity = await repo.fbookmarkTest(
      subjectId: subjectId,
    );
    notifyListeners();
  }

  Future<void> fbookmarkQuestion({
    num? subjectId,
  }) async {
    showTest = false;
    bookmarkQuestionsEntity = await repo.fbookmarkQuestion(
      subjectId: subjectId,
    );
    notifyListeners();
  }
}

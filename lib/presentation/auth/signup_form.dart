import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:EdTestz/application/auth/auth_provider.dart';
import 'package:EdTestz/application/firebase/firebase_notification_provider.dart';
// import 'package:EdTestz/core/theme/custom_scroll_behaviour.dart';
import 'package:EdTestz/core/theme/theme.dart';
import 'package:EdTestz/core/utli/error_handle.dart';
import 'package:EdTestz/core/utli/goto_pages.dart';
import 'package:EdTestz/core/utli/loops_urls.dart';
import 'package:EdTestz/core/utli/validations.dart';
import 'package:EdTestz/core/widgets/container_with_border.dart';
import 'package:EdTestz/core/widgets/custom_button.dart';
import 'package:EdTestz/core/widgets/custom_text_field.dart';

bool _male = true;
final _formKey = GlobalKey<FormState>();

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key, this.fromProfile = false}) : super(key: key);
  final bool fromProfile;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

final List<String> _schools = [];
final List<String> _schoolsOnSearch = [];
final List<String> _boards = [];
final List<String> _grades = [];

bool isReferralVerify = false;
String selectedSchool = '';
int selectedSchoolID = 1;
var selectedBoard;
int selectedBoardID = 1;
String selectedGrade = '';
int selectedGradeID = 1;

class _SignUpFormState extends State<SignUpForm> {
  @override
  void initState() {
    _boards.clear();
    _grades.clear();
    _schools.clear();
    _schoolsOnSearch.clear();
     context.read<AuthAppProvider>().fsignup(fcmToken: fcmTokenGlobal);
    // Provider.of<AuthProvider>(context, listen: false)
    //     .fsignup(fcmToken: fcmTokenGlobal);


    // context.read<AuthProvider>()
    //     .signUpEntity
    //     .schools
    //     ?.forEach((element) {
    //   _schools.add(element.school!);
    // });
    // context.read<AuthProvider>()
    //     .profileUpdateEntity
    //     .schools
    //     ?.forEach((element) {
    //   _schools.add(element.school!);
    // });

    if (kDebugMode) {
      print("BOARDS CHECK");
      // print(_boards[Provider.of<AuthProvider>(context, listen: false)
      //             .profileUpdateEntity
      //             .board! -
      //         1 ??
      //     0]);
    }

    context.read<AuthAppProvider>().dobController.clear();
    if(widget.fromProfile){
      context.read<AuthAppProvider>()
          .profileUpdateEntity
          .boards
          ?.forEach((element) {
        _boards.add(element.board!);
      });
      Provider.of<AuthAppProvider>(context, listen: false).schoolController.text = Provider.of<AuthAppProvider>(context, listen: false)
          .profileUpdateEntity
          .school ?? "";
      // Provider.of<AuthProvider>(context, listen: false).schoolController.text
      Provider.of<AuthAppProvider>(context, listen: false).dobController.text = Provider.of<AuthAppProvider>(context, listen: false)
          .profileUpdateEntity
          .dob ?? "";
      Provider.of<AuthAppProvider>(context, listen: false)
          .profileUpdateEntity
          .gender ==
          "male"
          ? (_male = true)
          : (_male = false);
      for(int i=0 ; i< Provider.of<AuthAppProvider>(context, listen: false)
          .profileUpdateEntity.boards!.length ; i++){
        if(Provider.of<AuthAppProvider>(context, listen: false)
            .profileUpdateEntity
            .board! == Provider.of<AuthAppProvider>(context, listen: false)
            .profileUpdateEntity.boards![i].id){
          selectedBoard = Provider.of<AuthAppProvider>(context, listen: false)
              .profileUpdateEntity.boards![i].board!;
        }
      }

      for(int i=0 ; i< Provider.of<AuthAppProvider>(context, listen: false)
          .profileUpdateEntity.grades!.length ; i++){
        if(Provider.of<AuthAppProvider>(context, listen: false)
            .profileUpdateEntity
            .grade! == Provider.of<AuthAppProvider>(context, listen: false)
            .profileUpdateEntity.grades![i].grade){
          selectedGrade = Provider.of<AuthAppProvider>(context, listen: false)
              .profileUpdateEntity.grades![i].grade!.toString();
        }
      }
    }

    // selectedGrade = Provider.of<AuthProvider>(context, listen: false)
    //     .profileUpdateEntity
    //     .grade
    //     .toString();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if(_boards.isEmpty){
      context.read<AuthAppProvider>().signUpEntity.boards
          ?.forEach((element) {
        _boards.add(element.board!);
      });
    }
  if(_grades.isEmpty){
    context.read<AuthAppProvider>()
        .signUpEntity
        .grades
        ?.forEach((element) {
      _grades.add(element.grade.toString());
    });
  }
  }

  Future<File> copyAsset() async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    File tempFile = File('$tempPath/RaoAcademy_TnC.pdf');
    ByteData bd = await rootBundle.load('assets/docs/Terms_and_Conditions.pdf');
    await tempFile.writeAsBytes(bd.buffer.asUint8List(), flush: true);
    return tempFile;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthAppProvider>(context);
    if (kDebugMode) {
      print(provider.profileUpdateEntity.gender);
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Code to go back
            Navigator.pop(context);
          },
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      resizeToAvoidBottomInset: true,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.only(bottom: 35.sp, left: 35, right: 35, top: 0),
          child: ScrollConfiguration(
            behavior: ScrollBehavior(),
            child: ListView(
shrinkWrap: true,
              children: [
                SizedBox(
                  height: 5.h,
                ),
                if (!widget.fromProfile)
                  Center(
                    child: Text(
                      'Let’s create an Account',
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w500,
                        color: LoopsColors.colorBlack,
                      ),
                    ),
                  )
                else
                  Center(
                      child: Text(
                    'Your Profile',
                    style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w600,
                        color: LoopsColors.primaryColor),
                  )),
                SizedBox(
                  height: 18.h,
                ),
                /*  Text(
                  'SignUp',
                  style: TextStyle(
                      letterSpacing: 1.sp,
                      color: LoopsColors.textColor,
                      fontWeight: FontWeight.w600),
                ), */
                CustomTextField(
                  // onTap: () => _formKey.currentState!.reset(),
                  controller: provider.firstNameController,
                  hintText: 'Enter to change first name',
                  labelText:
                      provider.profileUpdateEntity.firstname ?? 'FIRST NAME',
                  validator: LoopsValidation.name,
                  inputType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                ),
                SizedBox(
                  height: 8.h,
                ),
                CustomTextField(
                  // onTap: () => _formKey.currentState!.reset(),
                  controller: provider.lastNameController,
                  hintText: 'Enter to change last name',
                  labelText:
                      provider.profileUpdateEntity.lastname ?? 'LAST NAME',
                  validator: LoopsValidation.name,
                  inputType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                ),
                SizedBox(
                  height: 18.h,
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        _male = true;
                        provider.setState();
                      },
                      child: Row(
                        children: [
                          ContainerWithBorder(
                            borderColor: LoopsColors.textColor,
                            boxColor: _male
                                ? LoopsColors.textColor
                                : LoopsColors.colorWhite,
                            borderRadius: 10.sp,
                            height: 12.sp,
                            width: 12.sp,
                          ),
                          SizedBox(
                            width: 12.w,
                          ),
                          Text(
                            'MALE',
                            style: TextStyle(
                                letterSpacing: 1.sp,
                                color: !_male
                                    ? LoopsColors.colorGrey.withOpacity(0.5)
                                    : LoopsColors.textColor,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 32.w,
                    ),
                    InkWell(
                      onTap: () {
                        _male = false;
                        provider.setState();
                      },
                      child: Row(
                        children: [
                          ContainerWithBorder(
                            borderColor: LoopsColors.textColor,
                            boxColor: _male
                                ? LoopsColors.colorWhite
                                : LoopsColors.textColor,
                            borderRadius: 10.sp,
                            height: 12.sp,
                            width: 12.sp,
                          ),
                          SizedBox(
                            width: 12.w,
                          ),
                          Text(
                            'FEMALE',
                            style: TextStyle(
                                letterSpacing: 1.sp,
                                color: _male
                                    ? LoopsColors.colorGrey.withOpacity(0.5)
                                    : LoopsColors.textColor,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 18.h,
                ),
                CustomTextField(
                  controller: provider.dobController,
                  hintText: "DATE OF BIRTH",
                  labelText:
                      provider.profileUpdateEntity.dob ?? 'DATE OF BIRTH',
                  validator: LoopsValidation.requiredField,
                  inputType: TextInputType.datetime,
                  readOnly: true,
                  onTap: () async {

                     await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1999),
                            lastDate: DateTime.now())
                        .then((value) {
                      provider.setDOB(value!);
                    });

                    // await showModalBottomSheet(
                    //     context: context,
                    //     builder: (BuildContext builder) {
                          // return ContainerWithBorder(
                          //   borderRadius: 12.sp,
                          //   height:
                          //       MediaQuery.of(context).copyWith().size.height /
                          //           3,
                          //   child: CupertinoDatePicker(
                          //     initialDateTime: DateTime.now(),
                          //     onDateTimeChanged: (DateTime newdate) {
                          //       provider.setDOB(newdate);
                          //     },
                          //     maximumDate: DateTime.now(),
                          //     minimumYear: 1900,
                          //     maximumYear: DateTime.now().year,
                          //     mode: CupertinoDatePickerMode.date,
                          //   ),
                          // );
                        // });
                    // _formKey.currentState!.reset();

                  },
                ),
                 SizedBox(
                  height: 8.h,
                ),
                /*  CustomTextField(
                  // onTap: () => _formKey.currentState!.reset(),
                  controller: provider.boardController,
                  hintText: 'Select Board',
                  labelText: 'BOARD',
                  validator: LoopsValidation.requiredField,
                ),
                SizedBox(
                  height: 8.h,
                ),
                CustomTextField(
                  // onTap: () => _formKey.currentState!.reset(),
                  controller: provider.classController,
                  hintText: 'Select Class',
                  labelText: 'CLASS',
                  validator: LoopsValidation.numericValue,
                  inputType: TextInputType.number,
                ), */
                // SizedBox(
                //   height: 18.h,
                // ),
                // SizedBox(
                //   height: selectedSchool == '' ||
                //           Provider.of<AuthProvider>(context, listen: false)
                //                   .signUpEntity
                //                   .schools
                //                   ?.firstWhere(
                //                       (element) =>
                //                           element.school == selectedSchool,
                //                       orElse: () => Schools(id: 0))
                //                   .id !=
                //               0
                //       ? 46.h
                //       : (_schoolsOnSearch.length + 1) * 46.h,
                //   child: SearchableDropDown(
                //     items: _schools,
                //     onChanged: (newValue) {
                //       setState(() {
                //         _schoolsOnSearch.clear();
                //         _schools.forEach((element) {
                //           if (element
                //               .toUpperCase()
                //               .contains(newValue!.toUpperCase())) {
                //             _schoolsOnSearch.add(element);
                //           }
                //         });
                //         if (_schoolsOnSearch.isEmpty &&
                //             newValue != null &&
                //             newValue != '') {
                //           _schoolsOnSearch.add('');
                //         }
                //         selectedSchool = newValue.toString();
                //         for(int i =0 ; i< Provider.of<AuthProvider>(context, listen: false)
                //             .signUpEntity
                //             .schools!.length ; i++){
                //           var val = Provider.of<AuthProvider>(context, listen: false)
                //               .signUpEntity
                //               .schools![i];
                //           if(val.school!.startsWith(newValue!)){
                //             selectedSchoolID = int.parse(val.id.toString());
                //           }
                //         }
                //         // selectedSchoolID =
                //         //     Provider.of<AuthProvider>(context, listen: false)
                //         //         .signUpEntity
                //         //         .schools!
                //         //         .firstWhere(
                //         //             (element) =>
                //         //                 element.school == newValue.toString(),
                //         //             orElse: () => Schools(id: 0))
                //         //         .id!
                //         //         .toInt();
                //       });
                //     },
                //     hintText: provider
                //             .profileUpdateEntity
                //             .schools?[provider.profileUpdateEntity.school! - 1]
                //             .school
                //             ??
                //         'SEARCH YOUR SCHOOL',
                //   ),
                // ),
                //
                CustomTextField(
                  // onTap: () => _formKey.currentState!.reset(),
                  controller: provider.schoolController,
                  hintText: 'Ex.(Your School Name, Address, City)',
                  labelText:
                  provider.profileUpdateEntity.school ?? 'SCHOOL',
                  inputType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                ),
                SizedBox(
                  height: 8.h,
                ),
                widget.fromProfile ? Text((_boards[Provider.of<AuthAppProvider>(context, listen: false)
                    .profileUpdateEntity
                    .board! -
                    1 ??
                    0]),style: TextStyle(color: LoopsColors.textColor,fontSize: 18)) : DropdownButtonFormField(
                  hint: Text(
                  !widget.fromProfile ?  'BOARD' : (_boards[Provider.of<AuthAppProvider>(context, listen: false)
                                    .profileUpdateEntity
                                    .board! -
                                1 ??
                            0])
                        ,
                    style: TextStyle(color: LoopsColors.textColor),
                  ),
                  // value: selectedBoard != '' ? selectedBoard : _boards.first,
                  items: _boards.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 1.5,
                        child: Text(
                          value,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: LoopsColors.textColor),
                        ),
                      ),
                    );
                  }).toList(),
                  value: selectedBoard,
                  onChanged: (newValue) {
                    setState(() {
                      selectedBoard = newValue.toString();
                      selectedBoardID = Provider.of<AuthAppProvider>(context,
                              listen: false)
                          .signUpEntity
                          .boards!
                          .firstWhere(
                              (element) => element.board == newValue.toString())
                          .id!
                          .toInt();
                    });
                  },
                ),
                SizedBox(
                  height: 18.h,
                ),
                widget.fromProfile ?  Text(provider.profileUpdateEntity.grade.toString(),style: TextStyle(color: LoopsColors.textColor,fontSize: 18)) : ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButtonFormField(
                    isExpanded: true,
                    hint: Text(
                    widget.fromProfile ?   provider.profileUpdateEntity.grade.toString() : 'GRADE',
                      style: TextStyle(color: LoopsColors.textColor),
                    ),
                    items:
                        _grades.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 1.5,
                          child: Text(
                            value,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: LoopsColors.textColor),
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectedGrade = newValue.toString();
                        selectedGradeID = Provider.of<AuthAppProvider>(context,
                                listen: false)
                            .signUpEntity
                            .grades!
                            .firstWhere((element) =>
                                element.grade.toString() == newValue.toString())
                            .id!
                            .toInt();
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 18.h,
                ),
                /* CustomTextField(
                  // onTap: () => _formKey.currentState!.reset(),
                  controller: provider.schoolController,
                  hintText: 'Select School',
                  labelText: 'SCHOOL',
                  validator: LoopsValidation.requiredField,
                  inputType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                ),
                SizedBox(
                  height: 8.h,
                ), */
                if (!widget.fromProfile)
                  CustomTextField(
                    // onTap: () => _formKey.currentState!.reset(),
                    onChanged: (p0) async{
                      if(p0.length >= 10){
                        await Provider.of<AuthAppProvider>(context,
                            listen: false).fvalidateReferral(p0).then((value) {
                              if(context.read<AuthAppProvider>().validateReferalEntity != null){
                              isReferralVerify =  context.read<AuthAppProvider>().validateReferalEntity.valid ?? false;
setState(() {

});
                              }
                        });
                      }else{
                        setState(() {
                          isReferralVerify = false;
                        });
                      }
                    },
                    controller: provider.codeController,
                    hintText: 'Enter Code',
                    labelText: 'REFERRAL CODE',
                    textCapitalization: TextCapitalization.characters,
                    suffixIcon: Icon(Icons.verified_outlined,color:isReferralVerify ? Colors.green : Colors.grey,size: 25),
                    // suffixIcon: Icon(Icons.verified,color: Colors.green,),
                  ),
                if (!widget.fromProfile)
                  SizedBox(
                    height: 18.h,
                  ),
                if (widget.fromProfile)
                  CustomTextField(
                    // onTap: () => _formKey.currentState!.reset(),
                    controller: provider.parentController,
                    hintText: 'Enter Parents Name',
                    labelText: provider.profileUpdateEntity.parentName ??
                        'PARENT NAME',
                    textCapitalization: TextCapitalization.characters,
                  ),
                if (widget.fromProfile)
                  SizedBox(
                    height: 8.h,
                  ),
                if (widget.fromProfile)
                  CustomTextField(
                    // onTap: () => _formKey.currentState!.reset(),
                    controller: provider.phoneController,
                    hintText: 'Enter Parents Contact Number',
                    labelText: provider.profileUpdateEntity.parentMobile ??
                        'PARENT CONTACT NUMBER',
                    textCapitalization: TextCapitalization.characters,
                  ),
                if (widget.fromProfile)
                  SizedBox(
                    height: 8.h,
                  ),
                // if (widget.fromProfile)
                //   CustomTextField(
                //     // onTap: () => _formKey.currentState!.reset(),
                //     // controller: _provider.codeController,
                //     hintText: 'Enter Parents Occupation',
                //     labelText: 'Parents Occupation'.toUpperCase(),
                //     textCapitalization: TextCapitalization.characters,
                //   ),
                if (widget.fromProfile)
                  SizedBox(
                    height: 8.h,
                  ),
                // if (widget.fromProfile)
                //   CustomTextField(
                //     // onTap: () => _formKey.currentState!.reset(),
                //     controller: provider.lastResultController,
                //     hintText: 'Enter Last Academic Year Marks',
                //     labelText: provider
                //             .profileUpdateEntity.previousClassPercentageGPA
                //             .toString() ??
                //         'LAST ACADEMIC YEAR MARKS',
                //     textCapitalization: TextCapitalization.characters,
                //   ),
                if (widget.fromProfile)
                  SizedBox(
                    height: 32.h,
                  ),
                CustomButton(
                  color: LoopsColors.secondaryColor,
                  onTap: () async {
                    /* if (selectedSchoolID==0) {
                      provider.fschool(schoolName: )
                    } */
                    if (widget.fromProfile) {
                      if (kDebugMode) {
                        print("DUPDATE");
                        print(provider.firstNameController.text);
                      }

                      if (provider.firstNameController.text != "")
                        provider.profileUpdateEntity.firstname =
                            provider.firstNameController.text;
                      if (provider.lastNameController.text != "")
                        provider.profileUpdateEntity.lastname =
                            provider.lastNameController.text;
                      provider.profileUpdateEntity.gender =
                          (_male ? 'male' : 'female');
                      if (provider.dobController.text != "")
                        provider.profileUpdateEntity.dob =
                            provider.dobController.text;
                      else
                        provider.profileUpdateEntity.dob = formatDate(
                            provider.profileUpdateEntity.dob.toString());
                      provider.profileUpdateEntity.board = null;
                      provider.profileUpdateEntity.grade = null;
                      provider.profileUpdateEntity.school = provider.schoolController.text;
                      provider.schoolController.text;
                      provider.profileUpdateEntity.parentName = provider.parentController.text;
                      provider.profileUpdateEntity.mobile =
                          provider.phoneController.text.isEmpty ?  provider.profileUpdateEntity.mobile:provider.phoneController.text;
                      provider.profileUpdateEntity.previousClassPercentageGPA = provider.lastResultController.text.isEmpty ? provider.profileUpdateEntity.previousClassPercentageGPA : int.parse(provider.lastResultController.text);
                      provider.profileUpdateEntity.updated = true;
                      var userId = await provider.getUserId();
                      provider.profileUpdateEntity.userId = userId;
                     await provider
                          .fprofileUpdate(provider.profileUpdateEntity, 1)
                          .then((_) {
                        Navigator.pop(context);
                        // gotoProfile(context);
                        // Navigator.pushReplacementNamed(context, '/profile');
                      }).onError((error, stackTrace) async {
                        await handleError(error);
                      });
                    } else if (_formKey.currentState!.validate()) {
                      provider
                          .fsignup(
                              firstname: provider.firstNameController.text,
                              lastname: provider.lastNameController.text,
                              gender: _male ? 'male' : 'female',
                              dob: provider.dobController.text,
                              board: selectedBoardID,
                              grade: selectedGradeID,
                              school: provider.schoolController.text,
                              mobile: provider.phoneController.text,
                              peerReferral: provider.codeController.text,
                              update: true,
                              fcmToken: fcmTokenGlobal)
                          .then((_) {
                            Fluttertoast.showToast(msg: "You have signed up succefully..");
                        // showSuccessPopup(context, (_) {}, 'You have signed up succefully.\nEnjoy the Journey.');
                        /* provider
                            .flogin(provider.phoneController.text)
                            .then((value) {
                          if (value) { */
                        Provider.of<AuthAppProvider>(context, listen: false)
                            .getUserId()
                            .then((uid) {
                          if (uid != 0) {
                            Provider.of<AuthAppProvider>(context, listen: false)
                                .fprofile()
                                .onError((error, stackTrace) async {
                              await handleError(error);
                            });
                            Provider.of<AuthAppProvider>(context, listen: false)
                                .fprofileDetailed()
                                .then((_) {
                              gotoHomePage(context)
                                  .onError((error, stackTrace) {
                                Fluttertoast.showToast(
                                    msg: 'Error in fhome API:\n$error');
                              });
                            }).onError((error, stackTrace) {
                              Fluttertoast.showToast(
                                  msg:
                                      'Error in fprofileDetailed API:\n$error');
                            });
                          } /* else {
                            handleError('Error in fsignup API:\nAdded false.');
                          } */
                          // });
                          /* } else {
                            Fluttertoast.showToast(msg: 'Error in flogin API');
                          } */
                        }).onError((error, stackTrace) async {
                          await handleError(error);
                        });
                      }).onError((error, stackTrace) async {
                        await handleError(error);
                      });
                    }
                  },
                  child: Text(
                    widget.fromProfile ? 'Update Profile' : 'Create an Account',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: LoopsColors.colorWhite,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.sp,
                    ),
                  ),
                ),
                SizedBox(
                  height: 18.h,
                ),
                if (!widget.fromProfile)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'By continuing, you agree to ',
                        style: appTheme.textTheme.bodyMedium!
                            .copyWith(fontSize: 12.sp),
                      ),
                      InkWell(
                        onTap: () async {
                          // launchURL(
                          //   'https://www.raoacademy.com/docx/tnc',
                          //   forceExternalApp: false,
                          //   forceWebView: true,
                          // );
                              await copyAsset().then((value) {
                                OpenFilex.open(value.path);
                              });
                          // PdfDocument.openAsset("assets/docs/Terms and Conditions.pdf");

                        },
                        child: Text(
                          'Terms & Conditions',
                          style: appTheme.textTheme.titleLarge!.copyWith(
                              fontSize: 12.sp, color: LoopsColors.colorRed),
                        ),
                      ),
                      /* Text(
                        ' | ',
                        style: appTheme.textTheme.bodyMedium!
                            .copyWith(fontSize: 12.sp),
                      ), */
                      /* InkWell(
                        onTap: () {},
                        child: Text(
                          'Privacy policy',
                          style: appTheme.textTheme.titleLarge!.copyWith(
                              fontSize: 12.sp, color: LoopsColors.colorRed),
                        ),
                      ), */
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String formatDate(String dateStr) {
    if ((dateStr == null) & (dateStr == "")) {
      return "";
    }
    final List<String> dateParts = dateStr.split(' ');
    final List<String> monthAbbreviations = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '';
    final int monthIndex = monthAbbreviations.indexOf(dateParts[2]) + 1;
    final String month = monthIndex.toString().padLeft(2, '0');
    final String day = dateParts[1].padLeft(2, '0');
    final String year = dateParts[3];
    return '$year-$month-$day';
  }
}

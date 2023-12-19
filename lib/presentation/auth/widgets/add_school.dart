import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rao_academy/application/auth/auth_provider.dart';
import 'package:rao_academy/application/firebase/firebase_notification_provider.dart';
import 'package:rao_academy/core/theme/custom_scroll_behaviour.dart';
import 'package:rao_academy/core/utli/error_handle.dart';
import 'package:rao_academy/core/utli/loops_urls.dart';
import 'package:rao_academy/core/widgets/custom_button.dart';
import 'package:rao_academy/core/widgets/custom_text_field.dart';
import 'package:rao_academy/domain/entities/boards_entity.dart';

Future addSchool(BuildContext context) {
  final TextEditingController name = TextEditingController();
  final TextEditingController board = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController city = TextEditingController();
  return showModalBottomSheet(
    isScrollControlled: true,
    enableDrag: true,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(12.sp)),
    ),
    backgroundColor: LoopsColors.colorWhite,
    builder: (context) => ScrollConfiguration(
      behavior: MyBehavior(),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.sp,
                vertical: 15.sp,
              ),
              child: const Text('Add your School'),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.sp,
                vertical: 15.sp,
              ),
              child: Form(
                child: Column(
                  children: [
                    CustomTextField(
                      hintText: 'Enter School Name',
                      controller: name,
                    ),
                    // SizedBox(height: 18.h,),
                    DropdownButtonFormField(
                      hint: Text(
                        'Select School Board',
                        style: TextStyle(
                          color: LoopsColors.lightGrey,
                          fontSize: 14.sp,
                        ),
                      ),
                      // value: selectedBoard != '' ? selectedBoard : _boards.first,
                      items: Provider.of<AuthProvider>(context, listen: false)
                          .signUpEntity
                          .boards!
                          .map<DropdownMenuItem<String>>((Boards value) {
                        return DropdownMenuItem<String>(
                          value: value.board.toString(),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: Text(
                              value.board!,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: LoopsColors.textColor),
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        board.text = newValue.toString();
                      },
                    ),
                    SizedBox(height: 18.h,),

                    CustomTextField(
                      hintText: 'Enter School Address',
                      controller: address,
                    ),
                    SizedBox(height: 18.h,),

                    CustomTextField(
                      hintText: 'Enter City',
                      controller: city,
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    CustomButton(
                      onTap: () {
                        Provider.of<AuthProvider>(context, listen: false)
                            .fschool(
                          schoolName: name.text,
                          schoolAddress: address.text,
                          board: board.text,
                          schoolCity: city.text,
                        )
                            .then((_) {
                          Provider.of<AuthProvider>(context, listen: false)
                              .fsignup(fcmToken: fcmTokenGlobal)
                              .then((_) {
                            Navigator.pop(context);
                          }).onError((error, stackTrace) async {
                            await handleError(error);
                          });
                        }).onError((error, stackTrace) async {
                          await handleError(error);
                        });
                      },
                      lable: 'Add School',
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

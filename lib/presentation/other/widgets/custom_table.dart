import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rao_academy/core/utli/loops_urls.dart';

class CustomTable extends StatelessWidget {
  const CustomTable({Key? key, required this.columns, required this.rows})
      : super(key: key);
  final List<String> columns;
  final List<List<dynamic>> rows;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int index = 0; index < columns.length; index++)
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    columns[index],
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: LoopsColors.textColor.withOpacity(0.8),
                    ),
                  ),
                ),
                for (int index2 = 0; index2 < rows[index].length; index2++)
                  Expanded(
                    child: Center(
                      child: Text(
                        rows[index][index2].toString(),
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: index == 0
                              ? LoopsColors.textColor.withOpacity(0.8)
                              : LoopsColors.colorBlack,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          )
      ],
    );
  }
}

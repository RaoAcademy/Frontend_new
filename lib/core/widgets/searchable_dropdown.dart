import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:EdTestz/application/auth/auth_provider.dart';
import 'package:EdTestz/core/utli/loops_urls.dart';
import 'package:EdTestz/core/widgets/container_with_border.dart';
import 'package:EdTestz/core/widgets/custom_text_field.dart';
import 'package:EdTestz/presentation/auth/widgets/add_school.dart';

final List<String> _items = [];

class SearchableDropDown extends StatefulWidget {
  const SearchableDropDown(
      {Key? key, this.items, this.onChanged, this.hintText, this.labelText})
      : super(key: key);
  final List<String>? items;
  final Function(String?)? onChanged;
  final String? hintText;
  final String? labelText;

  @override
  State<SearchableDropDown> createState() => _SearchableDropDownState();
}

class _SearchableDropDownState extends State<SearchableDropDown> {
  @override
  void initState() {
    /*  widget.items?.forEach((element) {
      _items.add(element);
    }); */
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (_items.length + 1) * 46.h,
      // constraints: BoxConstraints(maxHeight: 100.h, minHeight: 46.h),
      child: Stack(
        children: [
          SizedBox(
            height: 46.h,
            child: CustomTextField(
              textCapitalization: TextCapitalization.characters,
              hintText: widget.hintText,
              labelText: widget.labelText,
              controller: Provider.of<AuthAppProvider>(context, listen: false)
                  .schoolController,
              onChanged: (val) {
                setState(() {
                  widget.onChanged?.call(val);
                  _items.clear();
                  widget.items?.forEach((element) {
                    if (element.toUpperCase().contains(val.toUpperCase())) {
                      _items.add(element);
                    }
                  });
                });
              },
            ),
          ),
          if (Provider.of<AuthAppProvider>(context, listen: false)
                      .schoolController
                      .text !=
                  '' &&
              _items.isNotEmpty)
            SizedBox(
              height: (_items.length + 1) * 46.h,
              child: Column(
                children: [
                  SizedBox(
                    height: 46.h,
                  ),
                  SizedBox(
                    height: _items.length * 46.h,
                    // constraints: BoxConstraints(maxHeight: 100.h, minHeight: 46.h),
                    child: ListView.builder(
                      itemCount: _items.length,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          setState(() {
                            widget.onChanged?.call(_items[index]);
                            Provider.of<AuthAppProvider>(context, listen: false)
                                .schoolController
                                .text = _items[index];
                            _items.clear();
                          });
                        },
                        child: ContainerWithBorder(
                          margin: EdgeInsets.all(1.sp),
                          height: 40.h,
                          width: MediaQuery.of(context).size.width,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${_items[index].split(',').first},',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  _items[index]
                                      .split(
                                          '${_items[index].split(',').first},')
                                      .last,
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w300,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          if (Provider.of<AuthAppProvider>(context, listen: false)
                      .schoolController
                      .text !=
                  '' &&
              _items.isEmpty &&
              !widget.items!.contains(
                  Provider.of<AuthAppProvider>(context, listen: false)
                      .schoolController
                      .text))
            Column(
              children: [
                SizedBox(
                  height: 46.h,
                ),
                ContainerWithBorder(
                  margin: EdgeInsets.all(1.sp),
                  height: 40.h,
                  width: MediaQuery.of(context).size.width,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: Text.rich(
                      TextSpan(
                        children: <InlineSpan>[
                          TextSpan(
                            text: 'Coudnt find your school, Then',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          WidgetSpan(
                            child: InkWell(
                              onTap: () {
                                addSchool(context);
                              },
                              child: Text(
                                'add your School',
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    color: LoopsColors.secondaryColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          /*  DropdownButtonFormField(
            items: items?.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: Text(
                    value,
                    overflow: TextOverflow.ellipsis,
                    style:
                        TextStyle(color: LoopsColors.colorWhite.withOpacity(0)),
                  ),
                ),
              );
            }).toList(),
            onChanged: (newValue) {
              _controller.text = newValue.toString();
              onChanged?.call(newValue.toString());
            },
          ), */
        ],
      ),
    );
  }
}

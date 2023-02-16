import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:innon/resources/styles.dart';

class AddColumn extends StatefulWidget {
  final Function addColumnHandler;

  const AddColumn({super.key, required this.addColumnHandler});

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddColumn> {
  final TextEditingController _textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Form(
        key: _formKey,
        child: Container(
          decoration: BoxDecoration(
            color: Palette.black,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(6.r),
              topRight: Radius.circular(6.r),
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 8.h,
                ),
                Padding(
                  padding: EdgeInsets.all(8.0.w),
                  child: Container(
                    padding: EdgeInsets.only(bottom: 6.h),
                    color: Palette.grey3,
                    child: TextFormField(
                      autofocus: true,
                      style: TextStyles.textSize16Weight400.copyWith(
                        color: Palette.white,
                      ),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                      controller: _textController,
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 16.h,
                      bottom: 30.h,
                    ),
                    child: ButtonTheme(
                      minWidth: 200.w,
                      height: 50.h,
                      child: GestureDetector(
                        onTap: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            Navigator.of(context).pop();
                            widget.addColumnHandler(
                              _textController.text.trim(),
                            );
                          }
                        },
                        child: Text(
                          'Add',
                          style: TextStyles.textSize18Weight500.copyWith(
                            color: Palette.blue2,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

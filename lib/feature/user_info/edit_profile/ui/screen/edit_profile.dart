import 'package:flutter/material.dart';
import 'package:halqahquran/core/theme/color.dart';
import 'package:halqahquran/core/theme/size.dart';
import 'package:halqahquran/core/theme/style.dart';
import 'package:halqahquran/feature/Auth/ui/widget/custtom_button.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});
  TextEditingController nameControlar = TextEditingController();
  TextEditingController emialControlar = TextEditingController();
  TextEditingController phoneControlar = TextEditingController();
  String oldName = "Ali Ayman";
  String oldEmial = "hamodi90.com@gmial.com";
  String oldPhone = "01210631530";
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 8),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 26,
                      ),
                    ),
                    Text(
                      "Edit Profile",
                      style: TextAppStyle.mainTittel.copyWith(
                        color: Colors.black,
                        fontSize: 22,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.more_vert,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                AppSize.hight(18),
                Stack(
                  children: [
                    Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border:
                              Border.all(width: 4, color: AppColor.primeColor)),
                      child: const Padding(
                        padding: EdgeInsets.all(2.0),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://img.freepik.com/free-vector/hand-drawn-korean-drawing-style-character-illustration_23-2149623257.jpg?size=338&ext=jpg&ga=GA1.2.647470437.1685963067&semt=robertav1_2_sidr"),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      top: 100,
                      right: 0,
                      left: 100,
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: AppColor.primeColor),
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.camera_alt_outlined,
                            size: 35,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                AppSize.hight(25),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        "Name",
                        style: TextAppStyle.normalTittel,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: CustomTextField(
                        oldcontroller: oldName,
                        controller: nameControlar,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        "Emial",
                        style: TextAppStyle.normalTittel,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: CustomTextField(
                        oldcontroller: oldEmial,
                        controller: emialControlar,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        "Phone",
                        style: TextAppStyle.normalTittel,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: CustomTextField(
                        oldcontroller: oldPhone,
                        controller: phoneControlar,
                      ),
                    ),
                  ],
                ),
                AppSize.hight(50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: CustomButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        print("Form is valid");
                      } else {
                        print("Form is not valid");
                      }
                    },
                    widgetButton: Text(
                      "تسجيل",
                      style: TextAppStyle.mainTittel.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String oldcontroller;
  CustomTextField({required this.controller, required this.oldcontroller});
  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final TextEditingController controller = TextEditingController();

  bool _isEditable = false;

  void _toggleEditMode() {
    setState(() {
      _isEditable = !_isEditable;
      if (_isEditable) {
        widget.controller.clear();
      } else {
        widget.controller.text = widget.oldcontroller; // reset for old
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color.fromARGB(255, 223, 226, 225),
      ),
      padding: const EdgeInsets.only(left: 8, bottom: 5),
      child: TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: _isEditable ? '' : widget.oldcontroller,
          hintStyle: const TextStyle(fontSize: 18, color: AppColor.subText),
          suffixIcon: IconButton(
            icon: Icon(
              _isEditable ? Icons.cancel : Icons.edit,
              color: AppColor.primeColor,
            ),
            onPressed: _toggleEditMode,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Field cannot be empty';
          }
          return null;
        },
        readOnly: !_isEditable,
      ),
    );
  }
}
/**
 * فاضل كدا نزبط التلفون
 * ونزبط لو داس على الزرار عشان يحفظ نزبط الحالات بتاعتها 
 * ولما ندوس على التلات زراير نغير ساعتها الباسورد بطريقه اننا نبعت للايميل
 */
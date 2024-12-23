import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halqahquran/core/theme/color.dart';

class SearchTextField extends StatefulWidget {
  final String hint;
  const SearchTextField({super.key, required this.hint});

  @override
  _SearchTextFieldState createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  TextEditingController _controller = TextEditingController();
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _isTyping = _controller.text.isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(.8),
      height: 60,
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: widget.hint,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 0.9),
            borderRadius: BorderRadius.circular(12.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 0.9),
            borderRadius: BorderRadius.circular(12.0),
          ),
          suffixIcon: _isTyping
              ? IconButton(
                  icon: Icon(
                    Icons.close,
                    size: 32.sp,
                  ),
                  onPressed: () {
                    _controller.clear();
                    setState(() {
                      _isTyping = false;
                    });
                  },
                )
              : Icon(
                  Icons.search,
                  size: 32.sp,
                  color: AppColor.primeColor,
                ),
        ),
        onChanged: (value) {
          // You can handle search logic here
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

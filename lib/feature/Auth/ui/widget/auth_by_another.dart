import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:halqahquran/core/theme/size.dart';

class AuthByAnotherWidget extends StatelessWidget {
  const AuthByAnotherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            print("googal");
          },
          child: SvgPicture.asset(
            "assets/images/googal.svg",
            height: 40,
          ),
        ),
        AppSize.width(8),
        Container(
          color: Colors.grey,
          width: 2,
          height: 40,
        ),
        AppSize.width(8),
        InkWell(
          onTap: () {
            print("face");
          },
          child: SvgPicture.asset(
            "assets/images/face.svg",
            height: 40,
          ),
        )
      ],
    );
  }
}

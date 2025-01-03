import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:halqahquran/core/theme/size.dart';
import 'package:halqahquran/core/util/asset_app.dart';
import 'package:halqahquran/feature/Auth/ui/cubit/social_auth/social_auth_cubit.dart';

class AuthByAnotherWidget extends StatelessWidget {
  const AuthByAnotherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            context.read<SocialAuthCubit>().signUseGoogal();
          },
          child: SvgPicture.asset(
            AssetApp.googalSvg,
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
            context.read<SocialAuthCubit>().signUseFacebook();
          },
          child: SvgPicture.asset(
            AssetApp.faceBookSvg,
            height: 40,
          ),
        )
      ],
    );
  }
}

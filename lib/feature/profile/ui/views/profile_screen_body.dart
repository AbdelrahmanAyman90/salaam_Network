import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halqahquran/core/global/global_function/get_user_data.dart';
import 'package:halqahquran/core/theme/color.dart';
import 'package:halqahquran/core/theme/size.dart';
import 'package:halqahquran/core/theme/text_style.dart';
import 'package:halqahquran/feature/Auth/ui/widget/custtom_button.dart';
import 'package:halqahquran/feature/change_password/ui/view/change_password_scree.dart';
import 'package:halqahquran/feature/edit_profile/ui/screen/edit_profile_body.dart';
import 'package:halqahquran/feature/edit_profile/ui/screen/edit_profile_screen.dart';
import 'package:halqahquran/feature/notfication/local_notfication_helper.dart';
import 'package:halqahquran/feature/profile/ui/cubit/profile_cubit.dart';
import 'package:halqahquran/feature/profile/ui/widget/notfication_body.dart';
import 'package:halqahquran/feature/profile/ui/widget/profile_action_widget.dart';
import 'package:halqahquran/feature/theam/cubit/theam_cubit.dart';

class ProfileScreenBody extends StatefulWidget {
  const ProfileScreenBody({super.key});

  @override
  State<ProfileScreenBody> createState() => _ProfileScreenBodyState();
}

class _ProfileScreenBodyState extends State<ProfileScreenBody> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 35.r,
                  backgroundImage: NetworkImage(getUserData().image!.isEmpty
                      ? "https://static.vecteezy.com/ti/vetor-gratis/p1/26434417-padrao-avatar-perfil-icone-do-social-meios-de-comunicacao-do-utilizador-foto-vetor.jpg"
                      : getUserData().image!),
                ),
                AppSize.width(20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      getUserData().name,
                      style: TextStyles.bold18,
                    ),
                    SizedBox(
                      width: 200.w,
                      child: Text(
                        textAlign: TextAlign.end,
                        getUserData().email,
                        style: TextStyles.medium16.copyWith(
                          color: AppColor.subText2,
                        ),
                        textDirection: TextDirection.ltr,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                )
              ],
            ),
            AppSize.hight(20),
            const Text(
              "عام",
              style: TextStyles.semiBold18,
            ),
            AppSize.hight(20),
            ProfileActionWidget(
              tittel: "الملف الشخصي",
              icon: Icons.person_outlined,
              onTapped: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const EditProfileScreen();
                    },
                  ),
                ).then((value) => setState(() {}));
              },
            ),
            AppSize.hight(10),
            ProfileActionWidget(
              tittel: "تغيير كلمة المرور",
              icon: Icons.lock_outlined,
              onTapped: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const ChangePasswordScreen();
                    },
                  ),
                );
              },
            ),
            AppSize.hight(10),
            ProfileActionWidget(
              tittel: "مشاركه التطبيق",
              icon: Icons.share_outlined,
              onTapped: () {},
            ),
            AppSize.hight(10),
            ProfileActionWidget(
              tittel: "الاشعارات",
              icon: Icons.notifications_none_outlined,
              onTapped: () {},
              trailing: const SizedBox(
                width: 45,
                child: NotficationBody(),
              ),
            ),
            ProfileActionWidget(
              tittel: "الوضع الليلي",
              icon: Icons.brightness_2_outlined,
              onTapped: () {},
              trailing: SizedBox(
                width: 45,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: BlocBuilder<TheamCubit, TheamState>(
                    builder: (context, state) {
                      return Switch(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        activeTrackColor: AppColor.primeColor,
                        inactiveTrackColor: AppColor.backgroundColor,
                        value: context
                            .read<TheamCubit>()
                            .isDarkTheme, // Use the current theme state
                        onChanged: (value) {
                          context
                              .read<TheamCubit>()
                              .toggleTheme(); // Toggle theme on switch change
                        },
                        activeColor: AppColor.backgroundColor,
                      );
                    },
                  ),
                ),
              ),
            ),
            AppSize.hight(10),
            const Text(
              "مساعده",
              style: TextStyles.semiBold18,
            ),
            AppSize.hight(15),
            ProfileActionWidget(
              tittel: "من نحن",
              icon: Icons.info_outlined,
              onTapped: () {},
            ),
            AppSize.hight(20),
            CustomButton(
              onPressed: () {
                showDialog(
                  context: context, //! Pass the parent context to the dialog
                  builder: (dialogContext) {
                    //! dialogContext is new
                    return AlertDialog(
                      title: const Text("تأكيد"),
                      content: const Text("هل انت متاكد من انك تريد الخروج"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(dialogContext);
                          },
                          child: const Text("الغاء"),
                        ),
                        TextButton(
                          onPressed: () {
                            //! Use the parent context here to access the Cubit
                            context.read<ProfileCubit>().logOutUser();
                            Navigator.pop(
                                dialogContext); //! Close dialog after action
                          },
                          child: const Text("نعم"),
                        ),
                      ],
                    );
                  },
                );
              },
              widgetButton: Text(
                "تسجيل الخروج",
                style: TextStyles.semiBold18.copyWith(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}

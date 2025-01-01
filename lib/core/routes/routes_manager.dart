import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halqahquran/core/routes/argumnt_class.dart';
import 'package:halqahquran/core/service/get_it_service.dart';
import 'package:halqahquran/feature/Auth/data/model/user_model.dart';
import 'package:halqahquran/feature/Auth/domain/repos/auth_repo.dart';
import 'package:halqahquran/feature/Auth/ui/cubit/login/login_cubit.dart';
import 'package:halqahquran/feature/Auth/ui/cubit/register/register_cubit.dart';
import 'package:halqahquran/feature/Auth/ui/cubit/social_auth/social_auth_cubit.dart';
import 'package:halqahquran/feature/Auth/ui/views/login/login_screen.dart';
import 'package:halqahquran/feature/Auth/ui/views/register/register_screen.dart';
import 'package:halqahquran/feature/change_password/ui/view/change_password_body.dart';
import 'package:halqahquran/feature/change_password/ui/view/change_password_scree.dart';
import 'package:halqahquran/feature/chat/ui/screen/chat_page.dart';
import 'package:halqahquran/feature/edit_profile/ui/screen/edit_profile_screen.dart';
import 'package:halqahquran/feature/forget_password/cubit/forget_password_cubit.dart';
import 'package:halqahquran/feature/forget_password/ui/views/forget_password_screen.dart';
import 'package:halqahquran/feature/forget_password/ui/views/update_password/update_password_screen.dart';
import 'package:halqahquran/feature/forget_password/ui/views/verifiy_code/verify_code_screen.dart';
import 'package:halqahquran/feature/forget_password/ui/views/write_phone/write_phone_screen.dart';
import 'package:halqahquran/feature/home/ui/screen/bootom_bar.dart';
import 'package:halqahquran/feature/muslem_service/ui/screen/zekr_screen.dart';
import 'package:halqahquran/feature/quran/ui/screen/audio_player_screen.dart';
import 'package:halqahquran/feature/quran/ui/screen/reder_name_screen.dart';
import 'package:halqahquran/feature/quran/ui/widgets/quran_page.dart';
import 'package:halqahquran/feature/stream/data/model/stream_model.dart';
import 'package:halqahquran/feature/stream/ui/views/audience_stream_page.dart';
import 'package:halqahquran/feature/stream/ui/views/host_stream_page.dart';

Route<dynamic> ongenerateRoute(RouteSettings settings) {
  WidgetBuilder builder;

  switch (settings.name) {
    //login
    case LoginView.routeName:
      builder = (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => LoginCubit(
                  authRepo: getIt<AuthRepo>(),
                ),
              ),
              BlocProvider(
                create: (context) => SocialAuthCubit(
                  authRepo: getIt<AuthRepo>(),
                ),
              ),
            ],
            child: const LoginView(),
          );
      break;

    //register
    case RegisterView.routeName:
      builder = (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => RegisterCubit(
                  authRepo: getIt<AuthRepo>(),
                ),
              ),
              BlocProvider(
                create: (context) => SocialAuthCubit(
                  authRepo: getIt<AuthRepo>(),
                ),
              ),
            ],
            child: const RegisterView(),
          );
      break;

    //forget password
    case ForgetPasswordScreen.routeName:
      builder = (context) => BlocProvider(
            create: (context) => ForgetPasswordCubit(),
            child: const ForgetPasswordScreen(),
          );
      break;

    //update password
    case UpdatePasswordView.routeName:
      final forgetPasswordCubit = settings.arguments as ForgetPasswordCubit;

      builder = (context) => BlocProvider.value(
            value: forgetPasswordCubit,
            child: const UpdatePasswordView(),
          );
      break;
    //verify code
    case VerifyCodeScreen.routeName:
      final forgetPasswordCubit = settings.arguments as ForgetPasswordCubit;

      builder = (context) => BlocProvider.value(
            value: forgetPasswordCubit,
            child: const VerifyCodeScreen(),
          );
      break;
    //write phone
    case WritePhoneScreen.routeName:
      builder = (context) => BlocProvider.value(
            value: BlocProvider.of<ForgetPasswordCubit>(context),
            child: const WritePhoneScreen(),
          );
      break;
    //home
    case HomeScreen.routeName:
      builder = (context) => const HomeScreen();
      break;
    //massages
    case MassagesScreen.routeName:
      final args = settings.arguments as MessagesScreenArguments;
      builder = (context) => MassagesScreen(
            chatId: args.chatId,
            userDate: args.userData,
          );
      break;
    //zekr
    case ZekrScreen.routeName:
      final args = settings.arguments as ZekrScreenArguments;
      builder = (context) => ZekrScreen(
            tittel: args.tittel,
            iteamListData: args.iteamListData,
          );
      break;
    //audio
    case AudioPlayScreen.routeName:
      final args = settings.arguments as AudioPlayScreenArgumnt;
      builder = (context) => AudioPlayScreen(
          nameSorah: args.nameSorah,
          linkAudio: args.linkAudio,
          rederName: args.rederName);
      break;
    //quran
    case QuranImageScreen.routeName:
      final args = settings.arguments as QuranImageScreenArgumnt;
      builder = (context) => QuranImageScreen(
            numberPage: args.numberPage,
          );
      break;
    //edit profile
    case EditProfileScreen.routeName:
      builder = (context) => const EditProfileScreen();
    //change password
    case ChangePasswordScreen.routeName:
      builder = (context) => const ChangePasswordScreen();
      break;
    //host stream
    case HostStreamPage.routeName:
      final arg = settings.arguments as StreamScreenArgumnts;
      builder = (context) => HostStreamPage(
            streamModel: arg.streamModel,
            streamCubit: arg.streamCubit,
          );
      break;
    //audience stream
    case AudienceStreamPage.routeName:
      final StreamModel arg = settings.arguments as StreamModel;
      builder = (context) => AudienceStreamPage(
            streamModel: arg,
          );
      break;
    //reder name
    case RederNameScreen.routeName:
      final arg = settings.arguments as RederNameScreenArgument;
      builder = (context) => RederNameScreen(
            surahName: arg.surahName,
            indexSurah: arg.indexSurah,
          );
      break;
    default:
      builder = (context) => ChangePasswordBody();
  }

  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => builder(context),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0); // Start from right
      const end = Offset.zero; // End at the current position
      const curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
    transitionDuration: const Duration(milliseconds: 400),
  );
}

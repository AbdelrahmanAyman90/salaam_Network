part of 'route_import.dart';

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
    case HomeView.routeName:
      builder = (context) => const HomeView();
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
    case EditProfileView.routeName:
      builder = (context) => const EditProfileView();
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

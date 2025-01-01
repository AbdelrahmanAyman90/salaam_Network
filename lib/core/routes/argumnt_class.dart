import 'package:halqahquran/feature/Auth/data/model/user_model.dart';
import 'package:halqahquran/feature/stream/data/model/stream_model.dart';
import 'package:halqahquran/feature/stream/ui/cubit/stream_cubit_cubit.dart';

class MessagesScreenArguments {
  final String chatId;
  final UserModel userData;

  MessagesScreenArguments({required this.chatId, required this.userData});
}

class ZekrScreenArguments {
  final String tittel;
  List<dynamic> iteamListData;
  ZekrScreenArguments({required this.tittel, required this.iteamListData});
}

class AudioPlayScreenArgumnt {
  final String nameSorah;
  final String linkAudio;
  final String rederName;
  AudioPlayScreenArgumnt({
    required this.nameSorah,
    required this.linkAudio,
    required this.rederName,
  });
}

class QuranImageScreenArgumnt {
  int numberPage;
  QuranImageScreenArgumnt({required this.numberPage});
}

class RederNameScreenArgument {
  final int indexSurah;
  final String surahName;

  RederNameScreenArgument({required this.indexSurah, required this.surahName});
}

class StreamScreenArgumnts {
  final StreamModel streamModel;
  final StreamCubit streamCubit;

  StreamScreenArgumnts({required this.streamModel, required this.streamCubit});
}

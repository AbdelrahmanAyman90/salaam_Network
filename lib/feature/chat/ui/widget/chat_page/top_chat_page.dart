import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halqahquran/core/theme/color.dart';
import 'package:halqahquran/core/theme/size.dart';
import 'package:halqahquran/core/theme/text_style.dart';
import 'package:halqahquran/feature/chat/data/firebase_chat_operation.dart';
import 'package:halqahquran/feature/chat/data/model/user_model.dart';

class TopCahtPage extends StatelessWidget {
  const TopCahtPage({
    super.key,
    required this.userData,
    required this.firebaseChatOperation,
  });

  final UserModel userData;
  final FirebaseChatOperation firebaseChatOperation;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.primeColor.withOpacity(.15),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        child: Row(
          children: [
            const Icon(Icons.arrow_back_ios),
            AppSize.width(8),
            CircleAvatar(
              radius: 26.sp,
              backgroundImage: const AssetImage("assets/images/imaes.jpeg"),
            ),
            AppSize.width(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userData.name,
                    style: TextAppStyle.normalTittel,
                  ),
                  StreamBuilder<String>(
                    stream: firebaseChatOperation
                        .getlastSeanUser(userData.userId), // Pass the user's ID
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text("Loading last seen...");
                      } else if (snapshot.hasError) {
                        return Text("Error: ${snapshot.error}");
                      } else {
                        final lastSeen = snapshot.data ?? "offline";
                        return Text(
                          lastSeen == "online"
                              ? "متصل الان"
                              : "اخر ظهور: $lastSeen",
                          style: TextAppStyle.subTittel,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.phone_outlined,
              size: 28,
            ),
          ],
        ),
      ),
    );
  }
}

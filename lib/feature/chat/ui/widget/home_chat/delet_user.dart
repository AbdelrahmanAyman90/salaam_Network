import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:halqahquran/core/global/global_widget/error_snakbar.dart';
import 'package:halqahquran/feature/chat/data/repo/chat_repo_impl.dart';

class DeleteConfirmation extends StatelessWidget {
  const DeleteConfirmation(
      {super.key,
      required this.chatId,
      required this.userNmae,
      required this.firebaseChatOperation});
  final String chatId;
  final String userNmae;
  final ChatRepoImpl firebaseChatOperation;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '"$userNmae"',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text("Are you sure you want to delete this user?"),
          const SizedBox(height: 20),
          ListTile(
            leading: const Icon(Icons.delete, color: Colors.red),
            title: const Text("Delete", style: TextStyle(color: Colors.red)),
            onTap: () async {
              bool stuts =
                  await firebaseChatOperation.deletUser(chatId: chatId);
              if (stuts) {
                Navigator.pop(context);
                showCustomSnackBar(
                    context, "delet '${userNmae}' succses", Icons.check, true);
                // Close bottom sheet on cancel
              } else {
                showCustomSnackBar(
                    context, "delet '${userNmae}' fiald", Icons.close, false);
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.cancel),
            title: const Text("Cancel"),
            onTap: () {
              Navigator.pop(context); // Close bottom sheet on cancel
            },
          ),
        ],
      ),
    );
  }
}

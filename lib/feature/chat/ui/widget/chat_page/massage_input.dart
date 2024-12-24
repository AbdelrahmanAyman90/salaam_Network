import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halqahquran/core/global/global_function/fun_to_convert_hour.dart';
import 'package:halqahquran/core/theme/color.dart';
import 'package:halqahquran/core/theme/size.dart';
import 'package:halqahquran/feature/chat/data/firebase_chat_operation.dart';
import 'package:halqahquran/feature/chat/data/model/massage_model.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

class MessageInputWidget extends StatefulWidget {
  const MessageInputWidget(
      {Key? key,
      required this.chatId,
      required this.usersendId,
      required this.scrollController})
      : super(key: key);
  final String chatId;
  final String usersendId;
  final ScrollController scrollController;

  @override
  _MessageInputWidgetState createState() => _MessageInputWidgetState();
}

class _MessageInputWidgetState extends State<MessageInputWidget> {
  final TextEditingController massageController = TextEditingController();
  bool _isComposing = false; // To check if the user is typing
  final ImagePicker picker = ImagePicker(); // ImagePicker instance

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
        child: Row(
          children: [
            // Attach Button
            IconButton(
              icon: const Icon(
                Icons.camera_alt_outlined,
                size: 30,
                color: Colors.black,
              ),
              onPressed: () {
                _showImagePickerOptions(context);
              },
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200], // Text field background color
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Row(
                  children: [
                    // Text Input Field
                    Expanded(
                      child: TextField(
                        controller: massageController,
                        // To write Arabic
                        decoration: const InputDecoration(
                          hintText: "مراسله",
                          border: InputBorder.none,
                        ),
                        onChanged: (text) {
                          // Check if the user is typing to toggle send button state
                          setState(() {
                            _isComposing = text.isNotEmpty;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            AppSize.width(4),
            // Send Button
            Container(
              decoration: BoxDecoration(
                  color: AppColor.primeColor,
                  borderRadius: BorderRadius.circular(12.r)),
              child: IconButton(
                icon: const Icon(Icons.send),
                color: Colors.white, // Enable color change
                onPressed: _isComposing
                    ? () {
                        sendMessageUI(
                            chatIdd: widget.chatId,
                            content: massageController.text,
                            senderId: widget.usersendId,
                            type: 'text');
                        massageController.clear();

                        setState(() {
                          _isComposing = false;
                        });
                        widget.scrollController.animateTo(
                          0,
                          curve: Curves.easeOut,
                          duration: const Duration(milliseconds: 500),
                        );
                      }
                    : null, // Disable button if no text
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Bottom sheet for camera or gallery
  void _showImagePickerOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('Camera'),
                  onTap: () {
                    _pickImage(ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Gallery'),
                  onTap: () {
                    _pickImage(ImageSource.gallery);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Method to pick image
  Future<void> _pickImage(ImageSource source) async {
    File? file;
    final XFile? pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      file = File(pickedFile.path); //convert to file
      var imageName = basename(pickedFile.path); //get image name

      var metadata = SettableMetadata(contentType: 'image/jpeg');
      var ref = FirebaseStorage.instance.ref().child('imageChats').child(
          imageName); //reates a reference to a specific location in Firebase Storage where the image will be stored.

      await ref.putFile(file, metadata);
      sendMessageUI(
        chatIdd: widget.chatId,
        content: await ref.getDownloadURL(),
        senderId: widget.usersendId,
        type: 'image',
      );
    } else {
      print('No image selected');
    }
  }

  Future<void> sendMessageUI(
      {required String chatIdd,
      required String content,
      required String senderId,
      required String type}) async {
    FirebaseChatOperation f = FirebaseChatOperation();

    MessageModel newMessage = MessageModel(
      senderId: senderId,
      messageText: content,
      timestamp: DateTime.now().microsecondsSinceEpoch,
      isRead: false,
      type: type,
      timeSendMassage:
          convertToArabicAmPm(DateFormat.Hm().format(DateTime.now())),
    );

    try {
      await f.sendMessage(chatId: chatIdd, message: newMessage);
    } catch (e) {
      print("Error sending message: $e");
    }
  }
}

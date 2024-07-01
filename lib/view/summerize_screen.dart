import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:wezee_tool/components/color.dart';

import 'package:wezee_tool/widgets/custom_button.dart';

import '../widgets/cutom_textfield.dart';

enum MessageType {
  user,
  bot,
}

class Message {
  final String text;
  final MessageType type;

  Message(this.text, this.type);
}

class SummerizeScreen extends StatefulWidget {
  const SummerizeScreen({super.key});

  @override
  State<SummerizeScreen> createState() => _SummerizeScreenState();
}

class _SummerizeScreenState extends State<SummerizeScreen> {
  final TextEditingController _controller = TextEditingController();

  String summary = '';
  bool isloading = false;
  List<Message> data = [];
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      animatedtobottom();
    });
    super.initState();
  }

  void animatedtobottom() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent + 600,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  Future<void> summarizeArticle() async {
    final url = Uri.parse('http://127.0.0.1:8080/summarize');
    try {
      setState(() {
        isloading = true;
      });
      animatedtobottom();
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'article': _controller.text}),
      );
      if (response.statusCode == 500) {
        setState(() {
          summary = 'Failed to summarize article.';
          data.add(Message(summary, MessageType.bot));
        });
      }

      if (response.statusCode == 200) {
        final summaryText = jsonDecode(response.body)['summary'];
        setState(() {
          summary = summaryText;
          data.add(Message(summaryText, MessageType.bot));
        });
      } else {
        setState(() {
          summary = 'Failed to summarize article.';
        });
      }
    } catch (e) {
      setState(() {
        summary = 'Failed to summarize article.';
        isloading = false;
      });
    } finally {
      setState(() {
        isloading = false;
      });
      animatedtobottom();
    }
  }

  Future<void> _copyToClipboard(String text) async {
    await Clipboard.setData(ClipboardData(text: text));

    Fluttertoast.showToast(
        msg: "Copied to clipboard",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM_RIGHT,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.mainpurple,
        textColor: AppColors.mainblack,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: true,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.buttonyellow),
                  borderRadius: BorderRadius.circular(20)),
              child: Text(
                "Summarize Text",
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(20.0),
                itemCount: data.length,
                controller: scrollController,
                itemBuilder: (context, index) {
                  Message message = data[index];

                  bool isUserMessage = message.type == MessageType.user;

                  Alignment alignment = isUserMessage
                      ? Alignment.centerRight
                      : Alignment.centerLeft;
                  return Align(
                    alignment: alignment,
                    child: Row(
                      mainAxisAlignment: isUserMessage
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      crossAxisAlignment: isUserMessage
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        if (!isUserMessage)
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: AppColors.buttonyellow, width: 3),
                                image: const DecorationImage(
                                    image: AssetImage(
                                      'assets/bot.png',
                                    ),
                                    fit: BoxFit.cover)),
                          ),
                        Flexible(
                          child: GestureDetector(
                            onLongPress: () {
                              _copyToClipboard(message.text);
                            },
                            child: Container(
                              constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.7,
                              ),
                              margin: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 8),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  color: isUserMessage
                                      ? AppColors.mainLblack
                                      : AppColors.mainLblack,
                                  border: Border.all(
                                      color: isUserMessage
                                          ? AppColors.buttonLpurple
                                          : AppColors.buttonLyellow),
                                  borderRadius: isUserMessage
                                      ? const BorderRadius.only(
                                          bottomLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                          topLeft: Radius.circular(20),
                                        )
                                      : const BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                          topLeft: Radius.circular(20),
                                        )),
                              child: Text(
                                message.text,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        if (isUserMessage)
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                color: AppColors.mainpurple,
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: AppColors.buttonyellow),
                                image: const DecorationImage(
                                    image: AssetImage(
                                      'assets/person.png',
                                    ),
                                    fit: BoxFit.cover)),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
            !isloading
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        CustomTextfield(
                          controller: _controller,
                          hintText: 'Enter Text',
                        ),
                        const SizedBox(height: 10),
                        CustomButton(
                            height: 30,
                            width: 170,
                            bgColor: AppColors.mainLblack,
                            sideColor: AppColors.buttonyellow,
                            title: "Summarize",
                            onPressed: () {
                              if (_controller.text.isNotEmpty) {
                                data.add(Message(
                                    _controller.text.trim(), MessageType.user));
                                summarizeArticle();
                                _controller.clear();
                              }
                            }),
                      ],
                    ),
                  )
                : LoadingAnimationWidget.waveDots(
                    color: AppColors.buttonLpurple,
                    size: 100,
                  ),
          ],
        ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:wezee_tool/components/color.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Alignment> _topAlignmentAnimation;
  late Animation<Alignment> _bottomAlignmentAnimation;
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));
    _topAlignmentAnimation = TweenSequence<Alignment>([
      TweenSequenceItem(
          tween: Tween(begin: Alignment.topLeft, end: Alignment.topRight),
          weight: 1),
      TweenSequenceItem(
          tween: Tween(begin: Alignment.topRight, end: Alignment.bottomRight),
          weight: 1),
      TweenSequenceItem(
          tween: Tween(begin: Alignment.bottomLeft, end: Alignment.topLeft),
          weight: 1),
    ]).animate(_controller);
    _bottomAlignmentAnimation = TweenSequence<Alignment>([
      TweenSequenceItem(
          tween: Tween(begin: Alignment.bottomRight, end: Alignment.bottomLeft),
          weight: 1),
      TweenSequenceItem(
          tween: Tween(begin: Alignment.bottomLeft, end: Alignment.topLeft),
          weight: 1),
      TweenSequenceItem(
          tween: Tween(begin: Alignment.topLeft, end: Alignment.topRight),
          weight: 1),
      TweenSequenceItem(
          tween: Tween(begin: Alignment.topRight, end: Alignment.bottomRight),
          weight: 1),
    ]).animate(_controller);
    _controller.repeat();
    super.initState();
  }

  List<dynamic> ainame = [
    {
      "id": "grammer",
      "discription":
          "Implies that using the AI will refine and perfect the text",
      "name": "Grammar AI",
    },
    {
      "id": "Summerize",
      "discription": "Highlights the AI aspect\nand its purpose",
      "name": "Summarization AI",
    },
  ];
  List<dynamic> ainame2 = [
    {
      "discription": "Focuses on converting text into images",
      "name": "Text2Pic AI",
    },
    {
      "discription":
          "Emphasizes generating text based on various inputs or prompts",
      "name": "GenText AI",
    },
  ];
  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        bottom: true,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage('assets/person.png'),
                    ),
                    const SizedBox(width: 30),
                    SizedBox(
                      width: 200,
                      child: Text(
                        "Hello, ${auth.currentUser!.email}",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            color: AppColors.mainpurple,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          FontAwesomeIcons.solidBell,
                          color: AppColors.buttonLyellow,
                        )),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'EduGen AI Models',
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 300,
                child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(15),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: 20,
                  ),
                  itemCount: ainame.length,
                  itemBuilder: (BuildContext context, int index) {
                    return mycontainer(
                      ainame[index]['name'],
                      ainame[index]['discription'],
                      () {
                        if (ainame[index]['id'] == "grammer") {
                          return Navigator.pushNamed(context, 'grammer');
                        } else if (ainame[index]['id'] == "Summerize") {
                          return Navigator.pushNamed(context, 'summerize');
                        }
                      },
                      AppColors.mainpurple,
                      AppColors.mainblack,
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Others',
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                height: 270,
                child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(15),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: 20,
                  ),
                  itemCount: ainame2.length,
                  itemBuilder: (BuildContext context, int index) {
                    return mycontainer(
                      ainame2[index]['name'],
                      ainame2[index]['discription'],
                      () {},
                      AppColors.mainlightYellow,
                      AppColors.buttonpurple,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget mycontainer(String title, String discription, Function()? ontap,
      Color bcolor, Color ecolor) {
    return GestureDetector(
      onTap: ontap,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget? child) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            decoration: BoxDecoration(
                color: AppColors.mainpurple,
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [
                    bcolor,
                    ecolor,
                  ],
                  begin: _topAlignmentAnimation.value,
                  end: _bottomAlignmentAnimation.value,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                  )
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w500),
                ),
                Center(
                  child: Text(
                    discription,
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

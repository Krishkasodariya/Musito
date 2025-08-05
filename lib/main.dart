import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:musicapp/Fourthpage.dart';
import 'Firstpage.dart';
import 'Secondpage.dart';
import 'Thirdpage.dart';
import 'controller/MusicController.dart';

Future<void> main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await Get.put(MusicController());
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: Myapp(),
  ));
}

class Myapp extends StatefulWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  int selectIndex = 0;
  List pages = [Firstpage(), Secondpage(), Thirdpage(), Fourthpage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff232542),
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: Container(
                width: double.infinity,
                height: 75,
                decoration: BoxDecoration(
                    color: Color(0xff35364a).withOpacity(0.5),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xff60607a),
                        blurRadius: 1,
                        blurStyle: BlurStyle.outer,
                      )
                    ]),
                child: BottomNavigationBar(
                  onTap: (int index) {
                    setState(() {
                      selectIndex = index;
                    });
                  },
                  backgroundColor: Color(0xff35364a).withOpacity(0.5),
                  elevation: 0,
                  selectedItemColor: Colors.white,
                  unselectedItemColor: Color(0xff676171),
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  currentIndex: selectIndex,
                  selectedFontSize: 0,
                  unselectedFontSize: 0,
                  type: BottomNavigationBarType.fixed,
                  items: [
                    BottomNavigationBarItem(
                      icon: Image(
                          image: AssetImage("images/home.png"),
                          color: selectIndex == 0
                              ? Colors.white
                              : Color(0xff676171),
                          height: 33,
                          width: 33),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Image(
                          image: AssetImage("images/search.png"),
                          color: selectIndex == 1
                              ? Colors.white
                              : Color(0xff676171),
                          height: 38,
                          width: 38),
                      label: 'Search',
                    ),
                    BottomNavigationBarItem(
                      icon: Image(
                          image: AssetImage("images/music.png"),
                          color: selectIndex == 2
                              ? Colors.white
                              : Color(0xff676171),
                          height: 32,
                          width: 32),
                      label: 'Settings',
                    ),
                    BottomNavigationBarItem(
                      icon: Image(
                          image: AssetImage("images/person.png"),
                          color: selectIndex == 3
                              ? Colors.white
                              : Color(0xff676171),
                          height: 32,
                          width: 32),
                      label: 'Person',
                    ),
                  ],
                ))),
        body: pages[selectIndex]);
  }
}

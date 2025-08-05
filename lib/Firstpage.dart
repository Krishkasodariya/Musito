import 'dart:math';
import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicapp/Fourthpage.dart';
import 'package:musicapp/controller/MusicController.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musicapp/Secondpage.dart';
import 'package:musicapp/Thirdpage.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class Firstpage extends StatefulWidget {
  const Firstpage({Key? key}) : super(key: key);

  @override
  State<Firstpage> createState() => _FirstpageState();
}

class _FirstpageState extends State<Firstpage> {
  var _currenttab = 0;
  List<String> _tablist = [
    "Trending right now",
    "Rock",
    "Hip Hop",
    "Electro",
    "Soul",
    "Funk",
    "Rhythm and blues",
    "Reggae"
  ];

  late List<SongModel> _foundsong;
  FocusNode myfocus = FocusNode();

  MusicController _musicController = Get.find();
  OnAudioQuery _audioQuery = new OnAudioQuery();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _foundsong = _musicController.songs;
    _requestStoragePermission();
    songquery();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff232542),
        body: ListView(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              //height: MediaQuery.of(context).size.height,
              color: Color(0xff232542),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      children: [
                        Container(
                          width: 55,
                          height: 55,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Color(0xff423a59)),
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: Image(
                              image: AssetImage("images/menu.png"),
                              color: Color(0xffc4c4c4),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Container(
                              height: 55,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: Color(0xff423a59)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: TextField(
                                  onChanged: (value) {
                                    _search(value);
                                  },
                                  focusNode: myfocus,
                                  cursorColor: Color(0xffc4c4c4),
                                  decoration: InputDecoration(
                                    icon: Image(
                                      image: AssetImage("images/search.png"),
                                      width: 40,
                                      height: 40,
                                      color: Color(0xff676171),
                                    ),
                                    hintText: "Search",
                                    hintStyle: TextStyle(
                                      fontSize: 20,
                                      color: Color(0xff676171),
                                    ),
                                    border: InputBorder.none,
                                  ),
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xffc4c4c4),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Text(
                      "Trending right now",
                      style: GoogleFonts.rubik(
                          fontSize: 32,
                          color: Color(0xfffcfcff),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Container(
                      width: double.infinity,
                      height: 230,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: ListView.builder(
                        itemCount: _musicController.songs.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Container(
                              width: 260,
                              height: 230,
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: QueryArtworkWidget(
                                        id: _musicController.songs[index].id,
                                        type: ArtworkType.AUDIO,
                                        artworkWidth: 260,
                                        artworkHeight: 230,
                                        artworkBorder:
                                            BorderRadius.circular(20),
                                        nullArtworkWidget: Container(
                                          width: 260,
                                          height: 230,
                                          color: Color(0xff35364a),
                                        )),
                                  ),
                                  Align(
                                      alignment: Alignment.topRight,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 30, top: 15),
                                        child: Icon(Icons.more_horiz,
                                            color: Colors.white, size: 30),
                                      )),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, bottom: 12),
                                      child: Container(
                                          width: 260,
                                          height: 80,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15)),
                                              color: Color(Random()
                                                      .nextInt(0xffffffff))
                                                  .withAlpha(0xff)
                                                  .withOpacity(0.9)),
                                          child: Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 10,
                                                    ),
                                                    child: Container(
                                                      width: 155,
                                                      child: Text(
                                                        _musicController
                                                            .songs[index].title,
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10, top: 3),
                                                    child: Container(
                                                      width: 155,
                                                      child: Text(
                                                        "${_musicController.songs[index].artist}",
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            color:
                                                                Colors.white),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Expanded(
                                                child: Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 10),
                                                      child: InkWell(
                                                        onTap: () async {
                                                          _musicController
                                                              .tindex
                                                              .value = index;
                                                          _musicController
                                                                  .addsong =
                                                              _musicController
                                                                  .songs;

                                                          _musicController
                                                              .playsong(
                                                                  _musicController
                                                                      .songs[
                                                                          index]
                                                                      .uri);
                                                          Get.to(Thirdpage());

                                                          if (_musicController
                                                              .audioPlayer
                                                              .playing) {
                                                            _musicController
                                                                .pause();
                                                          } else {
                                                            _musicController.playsong(
                                                                _musicController
                                                                    .songs[
                                                                        index]
                                                                    .uri);
                                                          }

                                                          // bool a=!_musicController.songs[index].isplay;
                                                          // _musicController.songs[index].setPlay(a);

                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(SnackBar(
                                                                  content: Text(
                                                                      "${_musicController.songs[index].title}")));
                                                        },
                                                        child: !_musicController
                                                                .songs[index]
                                                                .isplay
                                                            ? Icon(
                                                                Icons
                                                                    .play_circle,
                                                                color: Colors
                                                                    .white,
                                                                size: 50,
                                                              )
                                                            : Icon(
                                                                Icons
                                                                    .pause_circle_filled_outlined,
                                                                color: Colors
                                                                    .white,
                                                                size: 50,
                                                              ),
                                                      ),
                                                    )),
                                              )
                                            ],
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Text(
                      "All Song",
                      style: GoogleFonts.rubik(
                          fontSize: 32,
                          color: Color(0xfffcfcff),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  /*  Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: SizedBox(
                          height: 50,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _tablist.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _currenttab = index;
                                  });
                                },
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 1000),
                                  child: Container(
                                    margin: EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                      color: _currenttab == index
                                          ? Color(0xff2a2685)
                                          : Color(0xff232542),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(13)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: Center(
                                          child: Text(
                                        _tablist[index],
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      )),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),*/
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: ListView.builder(
                      itemCount: _foundsong.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Container(
                              height: 75,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      _musicController.tindex.value = index;
                                      _musicController.addsong =
                                          _musicController.songs;

                                      _musicController.playsong(
                                          _musicController.songs[index].uri);
                                      Get.to(Thirdpage());
                                    },
                                    child: Row(
                                      children: [
                                        Center(
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)),
                                            child: QueryArtworkWidget(
                                              artworkWidth: 60,
                                              artworkHeight: 60,
                                              id: _foundsong[index].id,
                                              type: ArtworkType.AUDIO,
                                              artworkBorder: BorderRadius.zero,
                                              nullArtworkWidget: Container(
                                                  width: 60,
                                                  height: 60,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.rectangle,
                                                      color: CupertinoColors
                                                          .lightBackgroundGray),
                                                  child: const Icon(
                                                    Icons.music_note_rounded,
                                                    color: Colors.black,
                                                    size: 38,
                                                  )),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 200,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20),
                                                child: Text(
                                                  _foundsong[index].title,
                                                  style: GoogleFonts.rubik(
                                                      color: Colors.white,
                                                      fontSize: 20),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 3),
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        left: 20,
                                                      ),
                                                      child: Icon(
                                                        Icons.person,
                                                        color:
                                                            Color(0xffc4c4c4),
                                                        size: 15,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 5),
                                                      child: Container(
                                                        width: 100,
                                                        child: Text(
                                                          "${_foundsong[index].artist}",
                                                          style:
                                                              GoogleFonts.rubik(
                                                                  color: Color(
                                                                      0xffc4c4c4),
                                                                  fontSize: 15),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        print(
                                            "---------------)${_foundsong[index]}");
                                        bool a = !_foundsong[index].islike;
                                        print("aa------------)${a}");
                                        _foundsong[index].setLike(a);
                                        if (a) {
                                          _musicController.favSongs.add(_foundsong[index]);
                                        } else {
                                          for (int i = 0; i < _musicController.favSongs.length; i++) {
                                            if (_foundsong[index].id ==_musicController.favSongs[i].id) {
                                              _musicController.favSongs.remove(_foundsong[index]);
                                            }
                                          }
                                        }
                                      });
                                    },
                                    child: Center(
                                        child: !_foundsong[index].islike
                                            ? Icon(
                                                CupertinoIcons.heart,
                                                color: Colors.white,
                                                size: 31,
                                              )
                                            : Icon(
                                                CupertinoIcons.heart_fill,
                                                color: CupertinoColors
                                                    .lightBackgroundGray,
                                                size: 31,
                                              )),
                                  ),
                                ],
                              )),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _requestStoragePermission() async {
    PermissionStatus permission = await Permission.storage.request();
    bool status = await permission.isGranted;
    setState(() {
      if (permission != PermissionStatus.granted) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            title: Text("Storage permission required"),
            content: Text(
                "This app requires storage permission to function properly."),
            actions: [
              TextButton(
                onPressed: () {
                  if (!status) {
                    if (status) {
                      Navigator.pop(context);
                    }
                    openAppSettings();
                  }
                },
                child: Text("OK"),
              ),
            ],
          ),
        );
      }
    });
  }

  // void _playsong(String? uri) async {
  //   await _musicController.audioPlayer
  //       .setAudioSource(AudioSource.uri(Uri.parse(uri!)));
  //   await _musicController.audioPlayer.play();
  //   print("--------(${uri}");
  // }
  //
  // void _pause() async {
  //   await _musicController.audioPlayer.pause();
  //   //super.dispose();
  // }
  //
  void songquery() async {
    if (_musicController.songs.isEmpty) {
      await _audioQuery
          .querySongs(
        sortType: SongSortType.TITLE,
        orderType: OrderType.ASC_OR_SMALLER,
        uriType: UriType.EXTERNAL,
        ignoreCase: true,
      )
          .then((value) {
        setState(() {
          _musicController.songs.value = value;
          _musicController.setsong();
        });
      });
    }
  }

  void _search(String value) {
    List<SongModel> _result;
    if (value.isEmpty) {
      myfocus.unfocus();
      _result = _musicController.songs;
    } else {
      _result = _musicController.songs
          .where((p0) => p0.title.toLowerCase().contains(value.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundsong = _result;
    });
  }
}

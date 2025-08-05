import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:rxdart/rxdart.dart';
import 'controller/MusicController.dart';

class Thirdpage extends StatefulWidget {
  Thirdpage({Key? key}) : super(key: key);

  @override
  State<Thirdpage> createState() => _ThirdpageState();
}

class _ThirdpageState extends State<Thirdpage> {
  // var _ChangeSondIcon = false;
  var repeat=false;
  var isShuffle = false;
  AudioPlayer _audioPlayer = new AudioPlayer();
  MusicController _musicController = Get.find();

  String formatTime(int seconds) {
    return "${Duration(seconds: seconds)}".split('.')[0].padLeft(8, '0');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (_musicController.addsong.isEmpty) {
      _musicController.addsong = _musicController.songs;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color(0xff232542),
          body: Container(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                      child: Obx(
                    () =>
                        Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Container(
                              width: 300,
                              height: 320,
                              child: Center(
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  child: QueryArtworkWidget(
                                    artworkWidth: 300,
                                    artworkHeight: 340,
                                    id: _musicController
                                        .addsong[_musicController.tindex.value]
                                        .id,
                                    type: ArtworkType.AUDIO,
                                    artworkBorder:
                                        BorderRadius.all(Radius.circular(15)),
                                    nullArtworkWidget: Container(
                                        width: 300,
                                        height: 340,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            color: CupertinoColors
                                                .lightBackgroundGray,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15))),
                                        child: const Icon(
                                          Icons.music_note_rounded,
                                          color: Colors.black,
                                          size: 100,
                                        )),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            _musicController
                                .addsong[_musicController.tindex.value].title,
                            style: GoogleFonts.rubik(
                              fontSize: 30,
                              color: Color(0xfffdfdfd),
                              fontWeight: FontWeight.w500,
                            ),
                            // overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "${_musicController.addsong[_musicController.tindex.value].artist}",
                            style: GoogleFonts.rubik(
                                fontSize: 22,
                                color: Color(0xffc4c4c4),
                                fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Obx(
                              () => Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  InkWell(
                                    onTap: (){
                                      setState(() {
                                        repeat=!repeat;
                                        if(repeat==true){
                                           _musicController.audioPlayer.setLoopMode(LoopMode.all);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                              content: Text( 'Repeat On')));
                                        }else{
                                           _musicController.audioPlayer.setLoopMode(LoopMode.off);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                              content: Text( 'Repeat Off')));
                                        }


                                      });

                                    },
                                    child: Image(
                                      image: AssetImage("images/repeat.png"),
                                      width: 33,
                                      height: 33,
                                      color: Color(0xfffdfdfd),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          _musicController.back();
                                        },
                                        child: Image(
                                          image: AssetImage("images/back.png"),
                                          width: 40,
                                          height: 40,
                                          color: Color(0xfffdfdfd),
                                        ),
                                      ),
                                      Center(
                                        child: IconButton(
                                            padding: EdgeInsets.only(bottom: 5),
                                            iconSize: 80,
                                            onPressed: () {
                                              setState(() {
                                                _musicController
                                                        .ChangeSondIcon.value =
                                                    !_musicController
                                                        .ChangeSondIcon.value;
                                                if (_musicController
                                                    .audioPlayer.playing) {
                                                  _musicController.pause();
                                                  print("{pause-----------)}");
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                          content:
                                                              Text("Pause")));
                                                } else {
                                                  _musicController.playsong(
                                                      _musicController
                                                          .addsong[
                                                              _musicController
                                                                  .tindex.value]
                                                          .uri);
                                                  print(
                                                      "{favsongmatch------not-----)}");

                                                  if (_musicController.favSongs[_musicController.tindex.value].id ==
                                                      _musicController
                                                          .addsong[
                                                              _musicController
                                                                  .tindex.value]
                                                          .id) {
                                                    _musicController.playfavsong(
                                                        _musicController
                                                            .favSongs[
                                                                _musicController
                                                                    .tindex
                                                                    .value]
                                                            .uri);
                                                    print(
                                                        "{favsongmatch-----------)}");
                                                  }

                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                          content:
                                                              Text("Play")));
                                                }
                                              });
                                            },
                                            icon: _musicController
                                                        .ChangeSondIcon.value ==
                                                    false
                                                ? Icon(
                                                    Icons
                                                        .pause_circle_filled_outlined,
                                                    color: Color(0xfffdfdfd),
                                                    //size: 80,
                                                  )
                                                : Icon(
                                                    Icons.play_circle,
                                                    color: Color(0xfffdfdfd),
                                                    //size: 80,
                                                  )),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          _musicController.next();
                                        },
                                        child: Image(
                                          image: AssetImage("images/next.png"),
                                          width: 40,
                                          height: 40,
                                          color: Color(0xfffdfdfd),
                                        ),
                                      ),
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        isShuffle=!isShuffle;
                                        if(isShuffle==true){
                                           _musicController.audioPlayer.setShuffleModeEnabled(true);
                                           _musicController.audioPlayer.setLoopMode(LoopMode.off);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                              content: Text( 'Shuffle On')));
                                          print("k----->${_musicController.songs[_musicController.tindex.value].title}");
                                        }else{
                                           _musicController.audioPlayer.setShuffleModeEnabled(false);;
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                              content: Text( 'Shuffle Off')));
                                          print("k----->${_musicController.songs[_musicController.tindex.value].title}");
                                        }


                                      });
                                    },
                                    child: Image(
                                      image: AssetImage("images/shuffle.png"),
                                      width: 31,
                                      height: 31,
                                      color: Color(0xfffdfdfd),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Obx(
                              () => Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                        _musicController.startposition.value,
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white)),
                                  ),
                                  Expanded(
                                    flex: 8,
                                    child: Slider(
                                      min: Duration(seconds: 0)
                                          .inSeconds
                                          .toDouble(),
                                      max: _musicController.max.value,
                                      value: _musicController.min.value,
                                      onChanged: (newValue) {
                                        _musicController
                                            .changeseekbar(newValue.toInt());
                                        newValue = newValue;
                                     //   _musicController.oldSelectIndex=_musicController.tindex;
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                        _musicController.endposition.value,
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("It can never last \n Must erase it",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500)),
                                  Text("\nfast",
                                      style: TextStyle(
                                          color: Color(0xffc4c4c4),
                                          fontSize: 18))
                                ],
                              ),
                              Text("But  it could have been right\n",
                                  style: TextStyle(
                                      color: Color(0xffc4c4c4), fontSize: 18)),
                              Text(
                                  "Love is our resistance \n They'll keep us apart. and\nThey wont stop breaking us",
                                  style: TextStyle(
                                      color: Color(0xffc4c4c4), fontSize: 18)),
                            ],
                          )
                        ],
                      ),
                    ),
                  )),
                ),
              ],
            ),
          )),
    );
  }
}

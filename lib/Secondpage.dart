import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musicapp/Thirdpage.dart';
import 'package:musicapp/controller/MusicController.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'Firstpage.dart';
import 'Fourthpage.dart';

class Secondpage extends StatefulWidget {
  const Secondpage({Key? key}) : super(key: key);

  @override
  State<Secondpage> createState() => _SecondpageState();
}

class _SecondpageState extends State<Secondpage> {
  MusicController _musicController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff232542),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          width: 55,
                          height: 55,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Color(0xff423a59)),
                          child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: Icon(
                                CupertinoIcons.back,
                                size: 30,
                                color: Color(0xffc4c4c4),
                              )),
                        ),
                      ),
                      Spacer(),
                      Container(
                          width: 55,
                          height: 55,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Color(0xff423a59)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Row(
                              children: [
                                Center(
                                    child: Icon(
                                  CupertinoIcons.heart,
                                  color: Colors.white,
                                  size: 31,
                                ))
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    "Recent favourites",
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
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: GridView.builder(
                    itemCount: _musicController.favSongs.length,
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 250,
                        crossAxisSpacing: 10),
                    itemBuilder: (context, index) {
                      return Container(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _musicController.tindex.value = index;
                              _musicController.addsong = _musicController.favSongs;

                              _musicController.playfavsong(_musicController.favSongs[_musicController.tindex.value].uri);
                              Get.to(Thirdpage());
                            });
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: QueryArtworkWidget(
                                    artworkWidth: 200,
                                    artworkHeight: 175,
                                    id: _musicController.favSongs[index].id,
                                    type: ArtworkType.AUDIO,
                                    artworkBorder:
                                        BorderRadius.all(Radius.circular(15)),
                                    nullArtworkWidget: Container(
                                        width: 200,
                                        height: 175,
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
                                  )),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, left: 13, right: 13),
                                  child: Text(
                                    _musicController.favSongs[index].title,
                                    style: GoogleFonts.rubik(
                                      color: Color(0xfffcfcff),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                              ),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 13, right: 13),
                                  child: Text(
                                    "${_musicController.favSongs[index].artist}",
                                    style: GoogleFonts.rubik(
                                      color: Color(0xffc4c4c4),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

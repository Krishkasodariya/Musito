import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MusicController extends GetxController {
  AudioPlayer audioPlayer = new AudioPlayer();
  RxList<SongModel> songs = <SongModel>[].obs;
  RxList<SongModel> albumsongs = <SongModel>[].obs;
  RxList<SongModel> favSongs = <SongModel>[].obs;
  RxList<SongModel> addsong = <SongModel>[].obs;
  var tindex = 0.obs;
  var startposition = "".obs;
  var endposition = "".obs;
  var min = 0.0.obs;
  var max = 0.0.obs;
  var ChangeSondIcon = false.obs;
  var oldSelectIndex = 0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        print("aaaaaaa");
        print(tindex);
        //next();
      }
    });
    audioPlayer.processingStateStream.listen((state) {
      if (state == ProcessingState.completed) {

        print("$oldSelectIndex");
        print("$tindex");
        var a=tindex;

        if(a==0)
          {
            next();
          }else {
          if (oldSelectIndex == (a - 1) || a == 0) {
            print("eeeeeeeee");

            next();
          }
        }
      }
    });

    audioPlayer.currentIndexStream.listen((index) async {
      if (index != null) {

        print("----------------------");
        print(index);
       // _updateCurrentPlayingSongDetails(index);
      }
    });
  }

  void updatesong() {
    audioPlayer.positionStream.listen((position) {
      startposition.value = position.toString().split(".")[0];
      min.value = position.inSeconds.toDouble();
      // if(min.value==max.value){
      //   next();
      //   audioPlayer.seek(Duration.zero);
      // }
    });

    audioPlayer.durationStream.listen((duration) {
      endposition.value = duration.toString().split(".")[0];
      max.value = duration!.inSeconds.toDouble();
    });
  }

  void changeseekbar(seconds) {
    var duration = Duration(seconds: seconds);
    audioPlayer.seek(duration);
  }

  setsong() {
    List<AudioSource> list = [];

    for (int i = 0; i < songs.length; i++) {
      list.add(AudioSource.uri(Uri.parse("${songs[i].uri}"),
          tag: MediaItem(
            id: '${songs[i].id}',
            album: '${songs[i].album}',
            title: '${songs[i].title}',
            artUri: Uri.parse("${songs[i].uri}"),
          )));
    }

    playerList = ConcatenatingAudioSource(children: list);
  }

  var playerList;

  void playsong(String? uri) async {
    try {
      await audioPlayer.setAudioSource(playerList[tindex.value],initialIndex: tindex.value);
      updatesong();
      await audioPlayer.play();

      oldSelectIndex = tindex;
      print("uri--------(${uri}");
    } catch (e) {
      print("E============)${e}");
    }
  }

  void playfavsong(String? uri) async {
    await audioPlayer.setAudioSource(
        AudioSource.uri(Uri.parse("${favSongs[tindex.value].uri}"),
            tag: MediaItem(
              id: '${favSongs[tindex.value].id}',
              album: '${favSongs[tindex.value].album}',
              title: '${favSongs[tindex.value].title}',
              artUri: Uri.parse("${favSongs[tindex.value].uri}"),
            )));
    updatesong();
    await audioPlayer.play();
  }

  void dispose() async {
    await audioPlayer.dispose();
    // super.dispose();
  }

  void pause() async {
    await audioPlayer.pause();
    //super.dispose();
  }

  void back() {
    if (tindex.value.isGreaterThan(0)) {
      tindex.value--;
    }
    print("-------------)${tindex.value}");
    //_musicController.audioPlayer.pause();
    if (tindex.value >= 0) {
      audioPlayer.setAudioSource(
          AudioSource.uri(Uri.parse("${addsong[tindex.value].uri}"),
              tag: MediaItem(
                id: '${addsong[tindex.value].id}',
                album: '${addsong[tindex.value].album}',
                title: '${addsong[tindex.value].title}',
                artUri: Uri.parse("${addsong[tindex.value].uri}"),
              )));

      audioPlayer.play();
    }
  }

  Future<void> next() async {
    if (tindex.value! < addsong.length - 1) {
      tindex=oldSelectIndex+1;
      print("i++${tindex}");
    }
    print("p++${tindex.value}");
    if (tindex.value <= addsong.length) {
      await audioPlayer.setAudioSource(
          AudioSource.uri(Uri.parse("${addsong[tindex.value].uri}"),
              tag: MediaItem(
                id: '${addsong[tindex.value].id}',
                album: '${addsong[tindex.value].album}',
                title: '${addsong[tindex.value].title}',
                artUri: Uri.parse("${addsong[tindex.value].uri}"),
              )));
      print("-------------)${addsong[tindex.value].title}");

      //await audioPlayer.seek(Duration.zero, index: tindex.value);

      // String? nextSong = songs[tindex.value].uri;
      // await audioPlayer.setUrl(nextSong!);

      await audioPlayer.play();
    }
  }
}

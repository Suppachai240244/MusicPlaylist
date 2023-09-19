import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

class MusicList extends StatefulWidget {
  const MusicList({super.key});

  @override
  State<MusicList> createState() => _MusicListState();
}

class _MusicListState extends State<MusicList> {
  final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();
  double screenHeight = 0;
  double screenWidth = 0;
  final Color mainColor = Color(0xff181c27);
  final Color inactiveColor = Color(0xff5d6169);
  List<Audio> audioList = [
    Audio(
      'assets/Atom.mp3',
      metas: Metas(
        title: 'Atom',
        artist: 'Atom',
        image: MetasImage.asset('assets/Atom.jpg'),
      ),
    ),
    Audio(
      'assets/Cocktail.mp3',
      metas: Metas(
        title: 'Cocktail',
        artist: 'Cocktail',
        image: MetasImage.asset('assets/Cocktail.jpg'),
      ),
    ),
    Audio(
      'assets/Preasun.mp3',
      metas: Metas(
        title: 'Preasun',
        artist: 'Preasun',
        image: MetasImage.asset('assets/Preasun.jpg'),
      ),
    ),
    Audio(
      'assets/PURPEECH.mp3',
      metas: Metas(
        title: 'PURPEECH',
        artist: 'PURPEECH',
        image: MetasImage.asset('assets/purpeech.jpg'),
      ),
    ),
    Audio(
      'assets/ThreeManDown.mp3',
      metas: Metas(
        title: 'ThreeManDown',
        artist: 'ThreeManDown',
        image: MetasImage.asset('assets/threemandown.jpg'),
      ),
    ),
    Audio(
      'assets/Newery.mp3',
      metas: Metas(
        title: 'Newery',
        artist: 'Newery',
        image: MetasImage.asset('assets/Newery.jpg'),
      ),
    ),
    Audio(
      'assets/Nontanon.mp3',
      metas: Metas(
        title: 'Non tanon',
        artist: 'Non tanon',
        image: MetasImage.asset('assets/Nontanon.jpg'),
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    setupPlaylist();
  }

  void setupPlaylist() async {
    await audioPlayer.open(Playlist(audios: audioList),
        autoStart: false, loopMode: LoopMode.playlist);
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.dispose();
  }

  Widget playButton() {
    return Container(
      width: screenHeight * 0.25,
      child: TextButton(
        onPressed: () => audioPlayer.playlistPlayAtIndex(0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.play_circle_outline_rounded,
              color: mainColor,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              'Play',
              style: TextStyle(color: mainColor),
            ),
          ],
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateColor.resolveWith(
            (states) => Colors.white,
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }

  Widget playlist(RealtimePlayingInfos realtimePlayingInfos) {
    return Container(
      height: screenHeight * 0.35,
      alignment: Alignment.bottomLeft,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return playlistItem(index);
        },
        shrinkWrap: true,
        itemCount: audioList.length,
      ),
    );
  }

  Widget playlistItem(int index) {
    return InkWell(
      onTap: () => audioPlayer.playlistPlayAtIndex(index),
      splashColor: Colors.transparent,
      highlightColor: mainColor,
      child: Container(
        height: screenHeight * 0.07,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            children: [
              Text(
                '0${index + 1}',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: screenWidth * 0.04),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      audioList[index].metas.title ?? '',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.005),
                    Text(
                      audioList[index].metas.artist ?? '',
                      style: TextStyle(
                        fontSize: 13,
                        color: inactiveColor,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.menu_rounded,
                color: inactiveColor,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomPlayContainer(RealtimePlayingInfos realtimePlayingInfos) {
    return Container(
      height: screenHeight * 0.12,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Row(
          children: [
            Container(
              height: screenHeight * 0.1,
              width: screenWidth * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  realtimePlayingInfos.current?.audio.audio.metas.image?.path ??
                      '',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: screenWidth * 0.03),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    realtimePlayingInfos.current?.audio.audio.metas.title ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.005),
                  Text(
                    realtimePlayingInfos.current?.audio.audio.metas.artist ??
                        '',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.favorite_outline_outlined, color: mainColor),
            SizedBox(width: screenWidth * 0.03),
            IconButton(
              icon: Icon(realtimePlayingInfos.isPlaying
                  ? Icons.pause_circle_filled_outlined
                  : Icons.play_circle_fill_outlined),
              iconSize: screenHeight * 0.07,
              splashColor: Colors.transparent,
              color: mainColor,
              onPressed: () => audioPlayer.playOrPause(),
            ),
          ],
        ),
      ),
    );
  }

  Widget playlistImage(RealtimePlayingInfos realtimePlayingInfos) {
    return Container(
      height: screenHeight * 0.25,
      width: screenWidth * 0.6,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          realtimePlayingInfos.current?.audio.audio.metas.image?.path ?? '',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget playlistTitle() {
    return Text(
      'Chill Playlist',
      style: TextStyle(
        color: Colors.white,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: mainColor,
      body: audioPlayer.builderRealtimePlayingInfos(
        builder: (context, realtimePlayingInfos) {
          if (realtimePlayingInfos != null) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                playlistImage(realtimePlayingInfos),
                SizedBox(height: screenHeight * 0.02),
                playlistTitle(),
                SizedBox(height: screenHeight * 0.02),
                playButton(),
                SizedBox(height: screenHeight * 0.02),
                playlist(realtimePlayingInfos),
                bottomPlayContainer(realtimePlayingInfos)
              ],
            );
          } else {
            return Column();
          }
        },
      ),
    );
  }
}

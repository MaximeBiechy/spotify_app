import 'package:dartz/dartz.dart';
import 'package:spotify_app/data/sources/song/song_firebase_service.dart';
import 'package:spotify_app/domain/repository/song/song.dart';

import '../../../service_locator.dart';

class SongRepositoryImpl extends SongRepository {
  @override
  Future<Either> getNewsSongs() async {
    return await sl<SongFirebaseService>().getNewsSongs();
  }

  @override
  Future<Either> getPlaylist() async {
    return sl<SongFirebaseService>().getPlaylist();
  }

  @override
  Future<Either> addOrRemoveFavoriteSongs(String songId) async {
    return sl<SongFirebaseService>().addOrRemoveFavoriteSongs(songId);
  }

  @override
  Future<bool> isFavoriteSong(String songId) async {
    return sl<SongFirebaseService>().isFavoriteSong(songId);
  }

  @override
  Future<Either> getUserFavoriteSongs() {
    return sl<SongFirebaseService>().getUserFavoriteSongs();
  }

}
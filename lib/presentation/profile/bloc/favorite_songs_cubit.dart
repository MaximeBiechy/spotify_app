import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_app/domain/entities/song/song.dart';
import 'package:spotify_app/presentation/home/bloc/play_list_state.dart';
import 'package:spotify_app/presentation/profile/bloc/favorite_songs_state.dart';

import '../../../domain/repository/song/song.dart';
import '../../../service_locator.dart';

class FavoriteSongsCubit extends Cubit<FavoriteSongsState> {
  FavoriteSongsCubit() : super(FavoriteSongsLoading());

  List<SongEntity> favoriteSongs = [];

  Future<void> getFavoriteSongs() async {
    var result = await sl<SongRepository>().getUserFavoriteSongs();

    result.fold(
      (l) => emit(FavoriteSongsFailure()),
      (songs) {
        favoriteSongs = songs;
        emit(FavoriteSongsLoaded(favoriteSongs));
      }
    );
  }

  void removeSong(int index) {
    favoriteSongs.removeAt(index);
    emit(FavoriteSongsLoaded(favoriteSongs));
  }
}
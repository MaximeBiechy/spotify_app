import 'package:spotify_app/domain/entities/song/song.dart';

abstract class PlaylistState {}

class PlaylistLoading extends PlaylistState {}

class PlaylistLoaded extends PlaylistState {
  final List<SongEntity> songs;
  PlaylistLoaded(this.songs);
}

class PlaylistLoadFailure extends PlaylistState {}
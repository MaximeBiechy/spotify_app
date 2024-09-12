import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_app/presentation/home/bloc/play_list_state.dart';

import '../../../domain/usecases/song/get_playlist.dart';
import '../../../service_locator.dart';

class PlaylistCubit extends Cubit<PlaylistState> {
  PlaylistCubit() : super(PlaylistLoading());

  Future<void> getPlaylist() async {
    var returnedSongs = await sl<GetPlaylistUseCase>().call();

    returnedSongs.fold(
          (l) => emit(PlaylistLoadFailure()),
          (data) => emit(PlaylistLoaded(data)),
    );
  }

}
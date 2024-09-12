import 'package:get_it/get_it.dart';
import 'package:spotify_app/data/repository/auth/auth_repository_impl.dart';
import 'package:spotify_app/data/sources/auth/auth_firebase_service.dart';
import 'package:spotify_app/data/sources/song/song_firebase_service.dart';
import 'package:spotify_app/domain/repository/auth/auth.dart';
import 'package:spotify_app/domain/usecases/auth/signin.dart';
import 'package:spotify_app/domain/usecases/auth/signup.dart';
import 'package:spotify_app/domain/usecases/song/add_or_remove_favorite_song.dart';
import 'package:spotify_app/domain/usecases/song/get_news_songs.dart';
import 'package:spotify_app/domain/usecases/song/get_playlist.dart';
import 'package:spotify_app/domain/usecases/song/is_favorite_song.dart';

import 'data/repository/song/song_repository_impl.dart';
import 'domain/repository/song/song.dart';

final sl = GetIt.instance;

Future<void> initializeDependecies() async {
  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImpl());
  sl.registerSingleton<SongFirebaseService>(SongFirebaseServiceImpl());
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  sl.registerSingleton<SongRepository>(SongRepositoryImpl());
  sl.registerSingleton<SignUpUseCase>(SignUpUseCase());
  sl.registerSingleton<SignInUseCase>(SignInUseCase());
  sl.registerSingleton<GetNewsSongsUseCase>(GetNewsSongsUseCase());
  sl.registerSingleton<GetPlaylistUseCase>(GetPlaylistUseCase());
  sl.registerSingleton<AddOrRemoveFavoriteSongUseCase>(AddOrRemoveFavoriteSongUseCase());
  sl.registerSingleton<IsFavoriteSongUseCase>(IsFavoriteSongUseCase());
}

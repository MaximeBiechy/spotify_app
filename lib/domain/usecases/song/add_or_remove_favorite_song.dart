import 'package:dartz/dartz.dart';
import 'package:spotify_app/core/usecase/usecase.dart';
import 'package:spotify_app/domain/repository/song/song.dart';

import '../../../service_locator.dart';

class AddOrRemoveFavoriteSongUseCase implements UseCase<Either, String> {
  @override
  Future<Either> call({String? params}) async {
    return await sl<SongRepository>().addOrRemoveFavoriteSongs(params!);
  }



}
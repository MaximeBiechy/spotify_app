import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_app/common/bloc/favorite_button/favorite_button_cubit.dart';
import 'package:spotify_app/domain/entities/song/song.dart';

import '../../../core/configs/theme/app_colors.dart';
import '../../bloc/favorite_button/favorite_button_state.dart';

class FavoriteButton extends StatelessWidget {
  final SongEntity songEntity;
  final Function? function;

  const FavoriteButton({super.key, required this.songEntity, this.function});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteButtonCubit(),
      child: BlocBuilder<FavoriteButtonCubit, FavoriteButtonState>(
        builder: (context, state) {
          if (state is FavoriteButtonInitial) {
            return IconButton(
              icon: Icon(
                songEntity.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_outline_outlined,
                size: 25,
                color: AppColors.darkGrey,
              ),
              onPressed: () async {
                await context
                    .read<FavoriteButtonCubit>()
                    .favoriteButtonUpdated(songEntity.songId);

                if (function != null) {
                  function!();
                }
              },
            );
          }

          if (state is FavoriteButtonUpdated) {
            return IconButton(
              icon: state.isFavorite
                  ? const Icon(Icons.favorite)
                  : const Icon(Icons.favorite_outline_outlined),
              onPressed: () {
                context
                    .read<FavoriteButtonCubit>()
                    .favoriteButtonUpdated(songEntity.songId);
              },
            );
          }

          return Container();
        },
      ),
    );
  }
}

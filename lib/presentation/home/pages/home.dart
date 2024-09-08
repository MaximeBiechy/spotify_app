import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify_app/common/widgets/appbar/app_bar.dart';
import 'package:spotify_app/core/configs/assets/app_images.dart';
import 'package:spotify_app/core/configs/assets/app_vectors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        hideBack: true,
        title: SvgPicture.asset(
          AppVectors.logo,
          width: 40,
          height: 40,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _homeTopCard(),
          ],
        ),
      ),
    );
  }

  Widget _homeTopCard() {
    return SizedBox(
      height: 140,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: SvgPicture.asset(
              AppVectors.homeTopCard,
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 40),
              child: Image.asset(
                AppImages.homeArtist,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

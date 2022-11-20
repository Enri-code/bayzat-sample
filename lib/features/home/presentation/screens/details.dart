import 'package:bayzat_test/app/theme/colors.dart';
import 'package:bayzat_test/features/home/domain/entities/stats.dart';
import 'package:bayzat_test/features/home/presentation/bloc/favourites/favourites_bloc.dart';
import 'package:bayzat_test/features/home/presentation/widgets/details_body_info.dart';
import 'package:flutter/material.dart';

import 'package:bayzat_test/features/home/domain/entities/pokemon_details.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class _TitleCard extends StatelessWidget {
  const _TitleCard(this.data);

  final PokemonDetails data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 216,
      child: ColoredBox(
        color: data.backgroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 24, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.pokemon.name,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      data.pokemon.formattedTypes,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      data.pokemon.idHash,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Transform.translate(
                    offset: const Offset(0, 16),
                    child: const Image(
                      height: 190,
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/pokemon_bg.png'),
                    ),
                  ),
                  Hero(
                    tag: 'image-${data.pokemon.idHash}',
                    child: Image.network(
                      data.pokemon.imageUrl,
                      width: 136,
                      height: 136,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const SizedBox(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatsInfo extends StatelessWidget {
  const _StatsInfo(this.stats);

  final List<Stat> stats;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Base stats',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const Divider(height: 32, thickness: 1),
          ...stats.map((e) {
            final double value = (e.value * 0.01).clamp(0, 1);
            return Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: '${e.title}  ',
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        color: ColorPalette.darkPurple,
                        fontSize: 15,
                      ),
                      children: [
                        TextSpan(
                          text: e.value.toString(),
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      thumbColor: Colors.transparent,
                      thumbShape: SliderComponentShape.noThumb,
                      overlayShape: SliderComponentShape.noOverlay,
                      disabledActiveTrackColor: () {
                        if (value >= 0.67) return ColorPalette.darkGreen;
                        if (value > 0.33) return ColorPalette.darkYellow;
                        return ColorPalette.darkPink;
                      }(),
                    ),
                    child: Slider(value: value, onChanged: null),
                  ),
                ],
              ),
            );
          })
        ],
      ),
    );
  }
}

class DetailsScreen extends StatefulWidget {
  ///Argument is [PokemonDetails]
  static const routeName = 'DetailsScreen';
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late PokemonDetails data;
  late bool isFavourited;

  _changeFavouriteState() {
    if (isFavourited) {
      context.read<FavouritesBloc>().add(UnfavouritePokemon(data.pokemon));
    } else {
      context.read<FavouritesBloc>().add(FavouritePokemon(data.pokemon));
    }
    setState(() => isFavourited = !isFavourited);
  }

  @override
  void didChangeDependencies() {
    data = ModalRoute.of(context)!.settings.arguments as PokemonDetails;
    isFavourited = context.read<FavouritesBloc>().state.contains(data.pokemon);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: _FavFab(
        favourited: isFavourited,
        onPressed: _changeFavouriteState,
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: data.backgroundColor,
            foregroundColor: ColorPalette.darkPurple,
            leading: IconButton(
              onPressed: Navigator.of(context).pop,
              icon: const Icon(Icons.arrow_back_ios_new, size: 20),
            ),
          ),
          const SliverToBoxAdapter(child: Divider(height: 2, thickness: 2)),
          SliverToBoxAdapter(child: _TitleCard(data)),
          SliverToBoxAdapter(child: BodyInfo(data.pokemon)),
          const SliverToBoxAdapter(child: Divider(height: 8, thickness: 8)),
          SliverPadding(
            padding: const EdgeInsets.only(bottom: 80),
            sliver: SliverToBoxAdapter(
              child: _StatsInfo(data.pokemon.allStats),
            ),
          ),
        ],
      ),
    );
  }
}

class _FavFab extends StatelessWidget {
  const _FavFab({required this.favourited, required this.onPressed});

  final bool favourited;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      extendedTextStyle: const TextStyle(fontWeight: FontWeight.bold),
      label: Text(
        favourited ? 'Remove from favourites' : 'Mark as favourite',
      ),
      backgroundColor: Color.lerp(
        Theme.of(context).primaryColor,
        Colors.white,
        favourited ? 0.8 : 0,
      ),
      foregroundColor:
          favourited ? Theme.of(context).primaryColor : Colors.white,
      onPressed: onPressed,
    );
  }
}

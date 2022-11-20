import 'package:bayzat_test/features/home/domain/entities/pokemon.dart';
import 'package:flutter/material.dart';

class PokemonCard extends StatelessWidget {
  const PokemonCard(
    this.pokemon, {
    super.key,
    this.backgroundColor,
    this.onPressed,
  });

  final Pokemon pokemon;
  final Color? backgroundColor;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.hardEdge,
      borderRadius: const BorderRadius.all(Radius.circular(6)),
      child: Stack(
        children: [
          ColoredBox(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 5,
                  child: ColoredBox(
                    color: backgroundColor ?? Colors.white,
                    child: Hero(
                      tag: 'image-${pokemon.idHash}',
                      child: Image.network(
                        pokemon.imageUrl,
                        fit: BoxFit.cover,
                        key: const ValueKey('image'),
                        frameBuilder: (_, child, frame, __) {
                          if (frame == null) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else {
                            return child;
                          }
                        },
                        errorBuilder: (_, __, ___) {
                          return const Icon(Icons.error_outline);
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(pokemon.idHash),
                        Text(
                          pokemon.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14.5,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(pokemon.formattedTypes),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Material(
            type: MaterialType.transparency,
            child: InkResponse(
              onTap: onPressed,
              containedInkWell: true,
              highlightShape: BoxShape.rectangle,
            ),
          ),
        ],
      ),
    );
  }
}

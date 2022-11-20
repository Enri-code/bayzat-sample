import 'package:bayzat_test/features/home/domain/entities/pokemon.dart';
import 'package:flutter/material.dart';

class BodyInfo extends StatelessWidget {
  const BodyInfo(this.pokemon, {super.key});

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _InfoSection(title: 'Height', value: pokemon.height.toString()),
        const SizedBox(width: 18),
        _InfoSection(title: 'Weight', value: pokemon.weight.toString()),
        const SizedBox(width: 18),
        _InfoSection(title: 'BMI', value: pokemon.bmi),
      ],
    );
  }
}

class _InfoSection extends StatelessWidget {
  const _InfoSection({required this.title, required this.value});

  final String title, value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

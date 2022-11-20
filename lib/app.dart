import 'package:bayzat_test/app/theme/colors.dart';
import 'package:bayzat_test/app/theme/theme_data.dart';
import 'package:bayzat_test/core/constants/config.dart';
import 'package:bayzat_test/core/constants/server_config.dart';
import 'package:bayzat_test/core/utils/api_client.dart';
import 'package:bayzat_test/features/home/data/models/pokemon.dart';
import 'package:bayzat_test/features/home/data/repos/store.dart';
import 'package:bayzat_test/features/home/data/repos/pokemons_repo.dart';
import 'package:bayzat_test/features/home/domain/repos/pokemons_repo.dart';
import 'package:bayzat_test/features/home/presentation/bloc/favourites/favourites_bloc.dart';
import 'package:bayzat_test/features/home/presentation/bloc/pokemons/pokemons_bloc.dart';
import 'package:bayzat_test/features/home/presentation/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: ApiClient(ServerConfig.baseurl),
      child: RepositoryProvider<IPokemonsRepo>(
        create: (context) => PokemonsRepoImpl(
          context.read<ApiClient>(),
          converter: PokemonModel.fromJson,
        ),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => FavouritesBloc(
                store: HivePokeStore(),
                repo: context.read<IPokemonsRepo>(),
              )..add(const GetFavourites()),
            ),
            BlocProvider(
              create: (context) => PokemonsBloc(context.read<IPokemonsRepo>()),
            ),
          ],
          child: MaterialApp(
            title: AppConfig.appName,
            routes: AppConfig.appRoutes,
            initialRoute: HomeScreen.routeName,
            theme: LightThemeProvider(ColorPalette.primaryColor).theme,
            themeMode: ThemeMode.light,
          ),
        ),
      ),
    );
  }
}

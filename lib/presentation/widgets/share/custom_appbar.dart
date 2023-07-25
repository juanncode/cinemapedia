import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/bloc/search/search_bloc.dart';
import 'package:cinemapedia/presentation/delegates/search_movie_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;
    return Container(
      color: Colors.yellow,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Icon(
                  Icons.movie_outlined,
                  color: colors.primary,
                ),
                const SizedBox(width: 5),
                Text('Cinemapedia', style: titleStyle),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      showSearch<Movie?>(
                              query: context.read<SearchBloc>().state.query,
                              context: context,
                              delegate: SearchMovieDelegate())
                          .then((movie) {
                        if (movie == null) return;
                        context.push('/movie/${movie.id}');
                      });
                    },
                    icon: const Icon(Icons.search))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

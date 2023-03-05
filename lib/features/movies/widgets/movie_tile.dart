import 'package:flutter/material.dart';
import 'package:movies/models/movie.dart';

class MovieTile extends StatelessWidget {
  final Function() onPressed;
  final Movie movie;
  const MovieTile({super.key, required this.onPressed, required this.movie});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Card(
        child: Column(
          children: [
            SizedBox(
              width: double.maxFinite,
              height: 80,
              child: Image.network(
                movie.poster,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
              child: Text(movie.title),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:equatable/equatable.dart';
import 'package:movies/models/movie_detailed.dart';

import '../../../core/state_management/bloc_event.dart';

class SearchEvent extends BlocEvent {
  final String text;

  SearchEvent(this.text);

  @override
  List<Object?> get props => [text];
}

class LoadFavouritesEvent extends BlocEvent {
  @override
  List<Object?> get props => [];
}

class LoadDetailsEvent extends BlocEvent {
  final String title;

  LoadDetailsEvent(this.title);

  @override
  List<Object?> get props => [title];
}

class AddToFavouriteEvent extends BlocEvent {
  final MovieDetailed movieDetailed;

  AddToFavouriteEvent(this.movieDetailed);

  @override
  List<Object?> get props => [movieDetailed];
}

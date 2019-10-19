import 'package:equatable/equatable.dart';
import 'package:infinite_list_bloc/models/post.dart';

abstract class PostState extends Equatable {
  @override
  List<Object> get props => [];
}

class PostUninitialised extends PostState {}

class PostError extends PostState {}

class PostLoaded extends PostState {
  final List<Post> posts;
  final bool hasReachedMax;

  PostLoaded({
    this.posts,
    this.hasReachedMax,
  });

  PostLoaded copyWith({ List<Post> posts, bool hasReachedMax }) {
    return PostLoaded(
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [ props, hasReachedMax ];

  @override
  String toString() => 'PostLoaded { posts: ${posts.length}, hasReachedMax: $hasReachedMax';
}
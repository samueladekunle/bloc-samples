import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';
import 'package:infinite_list_bloc/models/post.dart';
import 'package:infinite_list_bloc/blocs/post_event.dart';
import 'package:infinite_list_bloc/blocs/post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final http.Client httpClient;

  PostBloc({
    this.httpClient,
  });

  @override
  PostState get initialState => PostUninitialised();

  @override
  Stream<PostState> transformEvents(Stream<PostEvent> events, Stream<PostState> Function(PostEvent event) next) {
    return super.transformEvents((events as Observable<PostEvent>).debounceTime(Duration(milliseconds: 500)), next);
  }

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    final PostState currentState = state;
    if (event is Fetch && !_hasReachedMax(currentState)) {
      try {
        if (currentState is PostUninitialised) {
          final posts = await _fetchPosts(0, 20);
          yield PostLoaded(posts: posts, hasReachedMax: false);
        }
        if (currentState is PostLoaded) {
          final posts = await _fetchPosts(currentState.posts.length, 20);
          yield posts.isEmpty ? currentState.copyWith(posts: posts, hasReachedMax: true) : PostLoaded(posts: currentState.posts + posts, hasReachedMax: false);
        }
      } catch(_) {
        yield PostError();
      }
    }
  }

  bool _hasReachedMax(PostState state) => state is PostLoaded && state.hasReachedMax;

  Future<List<Post>> _fetchPosts(int startIndex, int limit) async {
    final response = await httpClient.get('https://jsonplaceholder.typicode.com/posts?_start=$startIndex&_limit=$limit');
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data.map<Post>((rawPost) {
        return Post(
          id: rawPost['id'],
          title: rawPost['title'],
          body: rawPost['body']
        );
      }).toList();
    } else {
      throw Exception('Error fetching posts');
    }
  }
}
import 'package:flutter/material.dart';
import 'package:infinite_list_bloc/models/post.dart';

class PostTile extends StatelessWidget {
  final Post post;

  PostTile({
    this.post,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        '${post.id}',
        style: TextStyle(fontSize: 10),
      ),
      title: Text(post.title),
      subtitle: Text(post.body),
      isThreeLine: true,
      dense: true,
    );
  }
}
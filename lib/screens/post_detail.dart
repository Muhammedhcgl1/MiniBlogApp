import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniblog/blocs/posts/post_bloc.dart';
import 'package:miniblog/blocs/posts/post_event.dart';
import 'package:miniblog/blocs/posts/post_state.dart';
import 'package:miniblog/models/post_model.dart';
import 'package:miniblog/screens/homepage.dart';
import 'package:miniblog/screens/update.dart';

class PostDetail extends StatefulWidget {
  const PostDetail({super.key, required this.postModel});
  final PostModel postModel;

  @override
  State<PostDetail> createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<PostBloc, PostState>(
      listener: (context, state) async {
        if (state is DeleteDataSuccess && context.mounted) {
          context.read<PostBloc>().add(FetchPost());
          await Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const Homepage(),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  context.read<PostBloc>().add(
                        DeletePost(id: widget.postModel.id),
                      );
                },
                icon: const Icon(Icons.delete)),
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => UpdatePost(
                        postModel: widget.postModel,
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.edit))
          ],
          title: Text(widget.postModel.title),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.postModel.author,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Image.network(widget.postModel.thumbnail),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Text(
                  widget.postModel.content,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

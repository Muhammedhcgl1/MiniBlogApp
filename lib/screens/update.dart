import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniblog/blocs/posts/post_bloc.dart';
import 'package:miniblog/blocs/posts/post_event.dart';
import 'package:miniblog/blocs/posts/post_state.dart';
import 'package:miniblog/models/post_model.dart';
import 'package:miniblog/screens/homepage.dart';
import 'package:miniblog/screens/post_detail.dart';

class UpdatePost extends StatefulWidget {
  const UpdatePost({super.key, required this.postModel});
  final PostModel postModel;

  @override
  State<UpdatePost> createState() => _UpdatePostState();
}

class _UpdatePostState extends State<UpdatePost> {
  @override
  void initState() {
    super.initState();
    contentController.text = widget.postModel.content;
  }

  TextEditingController contentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<PostBloc, PostState>(
      listener: (context, state) async {
        if (state is UpdateSuccess && context.mounted) {
          context.read<PostBloc>().add(FetchPost());
          await Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (context) =>
                    const Homepage() /*PostDetail(postModel: postModel)*/),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Güncelle"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                TextFormField(
                  maxLines: null,
                  controller: contentController,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: ElevatedButton(
                      onPressed: () {
                        PostModel updateData = widget.postModel
                            .copyWith(content: contentController.text);
                        context
                            .read<PostBloc>()
                            .add(UpdateDataPost(postModel: updateData));
                      },
                      child: const Text("Güncelle")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

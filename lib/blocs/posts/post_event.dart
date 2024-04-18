// import 'package:image_picker/image_picker.dart';

import 'package:miniblog/models/post_model.dart';

abstract class PostEvent {}

class FetchPost extends PostEvent {}

class DeletePost extends PostEvent {
  final String id;

  DeletePost({required this.id});
}

class UpdateDataPost extends PostEvent {
  final PostModel postModel;

  UpdateDataPost({required this.postModel});
}

class AddPost extends PostEvent {
  final String blogTitle;
  final String blogContent;
  final String imagePath;
  final String author;

  AddPost(
      {required this.blogTitle,
      required this.blogContent,
      required this.imagePath,
      required this.author});
}

class GoAddPage extends PostEvent {}

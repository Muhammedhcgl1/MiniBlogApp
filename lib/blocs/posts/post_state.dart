import 'package:miniblog/models/post_model.dart';

abstract class PostState {}

//fetcData States
class PostNotLoaded extends PostState {}

class PostLoaded extends PostState {
  final List<PostModel> blogs;

  PostLoaded({required this.blogs});
}

class PostLoading extends PostState {}

class PostLoadFail extends PostState {}

//Add data States

class AddDataFail extends PostState {}

class AddDataSuccess extends PostState {}

//Delete Data

class DeleteDataFail extends PostState {}

class DeleteDataSuccess extends PostState {}

// Update Data

class UpdateSuccess extends PostState {}

class UpdateFail extends PostState {}

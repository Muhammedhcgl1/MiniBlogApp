import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniblog/blocs/posts/post_event.dart';
import 'package:miniblog/blocs/posts/post_state.dart';
import 'package:miniblog/repos/post_repo.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepo postRepo;
  //Başlangıç olarak gelen state belirtip sonrasında o state de çalışacak olan eventi belirliyoruz.
  PostBloc({required this.postRepo}) : super(PostNotLoaded()) {
    //on Fonksiyonuna ilk çalışacak eventi yazıyoruz ve sonrasında parameteri olarak o eventte çalışacak fonksiyonu yazıyoruz.
    on<FetchPost>(_fetchPost);
    on<AddPost>(_addPost);
    on<DeletePost>(_deletePost);
    on<UpdateDataPost>(_updatePost);
  }
  //Bu eventlerin fonksiyonları parametre olarak eventin kendisini ve Emitter türünden State i alır.
  void _fetchPost(FetchPost event, Emitter<PostState> emit) async {
    //iş kodları burakısımlara yazılıp emit edilir(State değiştirilir)
    emit(PostLoading());
    try {
      final blogs = await postRepo.getPost();
      emit(PostLoaded(blogs: blogs));
    } catch (e) {
      emit(PostLoadFail());
    }
  }

  void _addPost(AddPost event, Emitter<PostState> emit) async {
    try {
      await postRepo.addPostRepo(
          blogTitle: event.blogTitle,
          blogContent: event.blogContent,
          imagePath: event.imagePath,
          author: event.author);
      emit(AddDataSuccess());
    } catch (e) {
      emit(AddDataFail());
    }
  }

  void _deletePost(DeletePost event, Emitter<PostState> emit) async {
    try {
      await postRepo.deletePost(event.id);
      emit(DeleteDataSuccess());
    } catch (e) {
      emit(DeleteDataFail());
    }
  }

  void _updatePost(UpdateDataPost event, Emitter<PostState> emit) async {
    try {
      await postRepo.guncelle(postModel: event.postModel);
      emit(UpdateSuccess());
    } catch (e) {
      emit(UpdateFail());
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniblog/blocs/posts/post_bloc.dart';
import 'package:miniblog/blocs/posts/post_event.dart';
import 'package:miniblog/blocs/posts/post_state.dart';
import 'package:miniblog/cards/post_card.dart';
import 'package:miniblog/models/post_model.dart';
import 'package:miniblog/screens/add_blog.dart';

//Put işlemi      +++++++++++++++
//future builder  +++
//Ters Çevirme    ++++++++
//Silme işlemi    ++++++++
//makyaj          ++++++++
//overFlow        ++++++++
//animasyon
//controller

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late Future<List<PostModel>> dataFromApi;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        if (state is PostNotLoaded) {
          context.read<PostBloc>().add(FetchPost());
          return const Scaffold(
            body: Center(
              child: Text("Yükleme İşlemi Başlamadı"),
            ),
          );
        }

        if (state is PostLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (state is PostLoaded) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Ana Sayfa"),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (ctx) => AddBlog()));
                    },
                    icon: const Icon(Icons.add)),
                IconButton(
                  onPressed: () {
                    context.read<PostBloc>().add(FetchPost());
                  },
                  icon: const Icon(Icons.refresh),
                )
              ],
            ),
            body: ListView.builder(
              itemBuilder: (context, index) {
                return PostCard(postModel: state.blogs[index]);
              },
              itemCount: state.blogs.length,
            ),
          );
        }
        return const Text("Bir Hata Oluştu");
      },
    );
  }
}

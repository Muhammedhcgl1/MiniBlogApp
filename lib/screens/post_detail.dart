import 'package:flutter/material.dart';
import 'package:miniblog/models/post_model.dart';
import 'package:http/http.dart' as http;
import 'package:miniblog/screens/homepage.dart';
import 'package:miniblog/screens/update.dart';

class PostDetail extends StatefulWidget {
  const PostDetail({super.key, required this.postModel});
  final PostModel postModel;

  @override
  State<PostDetail> createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  void _deletePost(id, BuildContext context) async {
    Uri url = Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles/$id");
    http.Response res = await http.delete(url);
    if (res.statusCode == 200) {
      showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (context) => AlertDialog(
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const Homepage()));
                      },
                      child: const Text("Tamam"))
                ],
                title: const Text("Başarılı!"),
                content: Text(
                    "${widget.postModel.title} adlı Postu Silme İşlemi Başarılı"),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                _deletePost(widget.postModel.id, context);
              },
              icon: const Icon(Icons.delete)),
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => UpdatePost(
                          postModel: widget.postModel,
                        )));
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
            // Padding(
            //   padding: const EdgeInsets.all(3),
            //   child: Text(
            //     widget.postModel.title,
            //     style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
            //   ),
            // ),
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
    );
  }
}

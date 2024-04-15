import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:miniblog/models/post_model.dart';

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

  Future<void> _guncelle(PostModel postModel) async {
    Uri url = Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles");

    var headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };

    // var post = PostModel(
    //   id: widget.postModel.id,
    //   title: widget.postModel.title,
    //   content: newContent,
    //   thumbnail: widget.postModel.thumbnail,
    //   author: widget.postModel.author,
    // );
    // var body = jsonEncode(post.toJson());

    var response =
        await http.put(url, headers: headers, body: postModel.toJson());
    if (response.statusCode == 200) {
      print('PUT isteği başarılı: ${response.body}');
    } else {
      print('PUT isteği başarısız: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    onPressed: () async {
                      PostModel updateData = widget.postModel
                          .copyWith(content: contentController.text);
                      await _guncelle(updateData);
                    },
                    child: const Text("Güncelle")),
              )
            ],
          ),
        ),
      ),
    );
  }
}

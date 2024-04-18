import 'package:http/http.dart' as http;
import 'package:miniblog/models/post_model.dart';
import 'dart:convert' as convert;

class PostRepo {
  Future<void> deletePost(String id) async {
    Uri url = Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles/$id");
    /*http.Response res =*/ await http.delete(url);
    // if (res.statusCode == 200) {
    //   print("Başarılı");
    // }
  }

  //Post ekleme
  Future<void> addPostRepo({
    required String blogTitle,
    required String blogContent,
    required String imagePath,
    required String author,
  }) async {
    Uri url = Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles");

    var request = http.MultipartRequest("POST", url);
    request.fields["Title"] = blogTitle;
    request.fields["Content"] = blogContent;
    request.fields["Author"] = author;

    final file = await http.MultipartFile.fromPath("File", imagePath);
    request.files.add(file);

    final response = await request.send();
    if (response.statusCode == 201) {
      print("Başarılı");
    } else {
      print("${response.statusCode}");
    }
  }

//// Postları Getirmek ve Listelemek için
  Future<List<PostModel>> getPost() async {
    Uri url = Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles");
    http.Response res = await http.get(url);
    if (res.statusCode == 200) {
      List jsonresponse = convert.jsonDecode(res.body);
      List data = jsonresponse.reversed.toList();
      return data.map((e) => PostModel.fromMap(e)).toList();
    } else {
      throw Exception("Hata ${res.statusCode}");
    }
  }

  // Postları Güncellemek için

  Future<void> guncelle({required PostModel postModel}) async {
    Uri url = Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles");

    var headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };
    await http.put(url, headers: headers, body: postModel.toJson());
  }
}

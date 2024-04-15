import 'package:flutter/material.dart';
import 'package:miniblog/cards/post_card.dart';
import 'package:miniblog/models/post_model.dart';
import 'package:miniblog/screens/add_blog.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

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
  // _changeTheme(bool value) {
  //   setState(() {
  //     _writeThemeData(value);
  //   });
  // }

  // _writeThemeData(bool value) async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   preferences.setBool("DARKTHEME", value);
  // }
  Future<List<PostModel>> _getPost() async {
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

  late Future<List<PostModel>> dataFromApi;

  @override
  Widget build(BuildContext context) {
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
                  setState(() {});
                  dataFromApi = _getPost();
                },
                icon: const Icon(Icons.refresh))
          ],
        ),
        body: Container(
          color: const Color.fromARGB(255, 255, 255, 255),
          padding: const EdgeInsets.all(5),
          child: RefreshIndicator(
            child: FutureBuilder(
              future: _getPost(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return PostCard(postModel: snapshot.data![index]);
                    },
                    itemCount: snapshot.data!.length,
                  );
                }
              },
            ),
            onRefresh: () {
              setState(() {});
              return _getPost();
            },
          ),
        ));
  }
}

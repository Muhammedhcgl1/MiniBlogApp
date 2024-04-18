import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:miniblog/blocs/posts/post_bloc.dart';
import 'package:miniblog/blocs/posts/post_event.dart';
import 'package:miniblog/blocs/posts/post_state.dart';
import 'package:miniblog/screens/homepage.dart';

class AddBlog extends StatefulWidget {
  const AddBlog({Key? key}) : super(key: key);

  @override
  _AddBlogState createState() => _AddBlogState();
}

class _AddBlogState extends State<AddBlog> {
  void _pickImage() async {
    final imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      selectedImage = file;
    });
  }

  final _formKey = GlobalKey<FormState>();
  String blogTitle = "";
  String blogContent = "";
  XFile? selectedImage;
  String author = "";

  @override
  Widget build(BuildContext context) {
    return BlocListener<PostBloc, PostState>(
      listener: (context, state) async {
        if (state is AddDataSuccess && context.mounted) {
          context.read<PostBloc>().add(FetchPost());
          await Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const Homepage(),
            ),
          );
        }
        if (state is AddDataFail && context.mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Data Gitmedi")));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Yeni Blog Ekle"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(children: [
                if (selectedImage != null) //xxx
                  Image.file(
                    File(selectedImage!.path),
                    height: 250,
                  ),
                ElevatedButton(
                    onPressed: () {
                      _pickImage();
                    },
                    child: const Text("Fotoğraf Seç")),
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text("Blog Başlığı Giriniz"),
                  ),
                  onSaved: (newValue) {
                    blogTitle = newValue!;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Blog başlığı boş olamaz.";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  maxLines: null,
                  decoration: const InputDecoration(
                    label: Text("Blog İçeriği Giriniz"),
                  ),
                  onSaved: (newValue) {
                    blogContent = newValue!;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Blog içeriği boş olamaz.";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text("Yazar İsmi Giriniz"),
                  ),
                  onSaved: (newValue) {
                    author = newValue!;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Yazar ismi boş olamaz.";
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                    onPressed: () {
                      if (selectedImage != null) {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          context.read<PostBloc>().add(AddPost(
                              blogTitle: blogTitle,
                              blogContent: blogContent,
                              imagePath: selectedImage!.path,
                              author: author));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Lütfen Resim seç!")));
                      }
                    },
                    child: const Text("Kaydet"))
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

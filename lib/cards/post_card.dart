import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:miniblog/models/post_model.dart';
import 'package:miniblog/screens/post_detail.dart';

class PostCard extends StatefulWidget {
  final PostModel postModel;
  const PostCard({super.key, required this.postModel});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("${widget.postModel.title} Başlıklı Posta tıklandı");

        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return PostDetail(postModel: widget.postModel);
        }));
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(2, 5, 2, 5),
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 233, 233, 233),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: const Color.fromARGB(255, 80, 57, 57),
              width: 1,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(3),
                child: Text(
                  widget.postModel.title,
                  style: const TextStyle(
                      fontSize: 26, fontWeight: FontWeight.w500),
                ),
              ),
              Image.network(widget.postModel.thumbnail),
              Text(
                widget.postModel.author,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

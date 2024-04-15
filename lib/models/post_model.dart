import 'dart:convert';

class PostModel {
  final String id;
  final String title;
  final String content;
  final String thumbnail;
  final String author;

  PostModel({
    required this.id,
    required this.title,
    required this.content,
    required this.thumbnail,
    required this.author,
  });

  PostModel copyWith({
    String? id,
    String? title,
    String? content,
    String? thumbnail,
    String? author,
  }) {
    return PostModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      thumbnail: thumbnail ?? this.thumbnail,
      author: author ?? this.author,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'thumbnail': thumbnail,
      'author': author,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      thumbnail: map['thumbnail'] ?? '',
      author: map['author'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) =>
      PostModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PostModel(id: $id, title: $title, content: $content, thumbnail: $thumbnail, author: $author)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PostModel &&
        other.id == id &&
        other.title == title &&
        other.content == content &&
        other.thumbnail == thumbnail &&
        other.author == author;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        content.hashCode ^
        thumbnail.hashCode ^
        author.hashCode;
  }
}

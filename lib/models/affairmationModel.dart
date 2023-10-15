import 'dart:convert';

class AffirmationModel {
  String text;
  bool isFavorite;

  AffirmationModel(this.text, {this.isFavorite = false});

  AffirmationModel.fromJson(String json)
      : text = jsonDecode(json)['text'] ?? '',
        isFavorite = jsonDecode(json)['isFavorite'] ?? false;

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'isFavorite': isFavorite,
    };
  }
}
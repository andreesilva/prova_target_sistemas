class TypedText {
  String text;

  TypedText({required this.text});

  factory TypedText.fromJson(Map<String, dynamic> json) =>
      TypedText(text: json["texto"]);

  Map<String, dynamic> toJson() => {"text": text};
}

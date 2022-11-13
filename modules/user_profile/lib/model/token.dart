class Token {
  String? token;
  int? id;

  Token({this.token, this.id});

  Token.empty();

  factory Token.fromJson(Map<String, dynamic> json) =>
      Token(token: json["token"], id: json["id"]);
}

class Boards {
  Boards({this.board, this.id});

  Boards.fromJson(Map<String, dynamic> json) {
    board = json['board'] as String?;
    id = json['id'] as num?;
  }
  String? board;
  num? id;
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['board'] = board;
    data['id'] = id;
    return data;
  }
}

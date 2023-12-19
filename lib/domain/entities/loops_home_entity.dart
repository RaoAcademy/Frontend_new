import 'package:rao_academy/domain/entities/faqs_entity.dart';
import 'package:rao_academy/domain/entities/loops_entity.dart';
import 'package:rao_academy/domain/entities/subjects_entity.dart';

class LoopsHomeEntity {
  LoopsHomeEntity({this.fAQs, this.loops, this.subjects});

  LoopsHomeEntity.fromJson(Map<String, dynamic> json) {
    if (json['FAQs'] != null) {
      fAQs = <FAQsEntity>[];
      (json['FAQs'] as List).forEach((v) {
        fAQs!.add(FAQsEntity.fromJson(v as Map<String, dynamic>));
      });
    }
    if (json['loops'] != null) {
      loops = <LoopsEntity>[];
      (json['loops'] as List).forEach((v) {
        loops!.add(LoopsEntity.fromJson(v as Map<String, dynamic>));
      });
    }
    if (json['subjects'] != null) {
      subjects = <Subjects>[];
      (json['subjects'] as List).forEach((v) {
        subjects!.add(Subjects.fromJson(v as Map<String, dynamic>));
      });
    }
  }

  List<FAQsEntity>? fAQs;
  List<LoopsEntity>? loops;
  List<Subjects>? subjects;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (fAQs != null) {
      data['FAQs'] = fAQs!.map((v) => v.toJson()).toList();
    }
    if (loops != null) {
      data['loops'] = loops!.map((v) => v.toJson()).toList();
    }
    if (subjects != null) {
      data['subjects'] = subjects!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

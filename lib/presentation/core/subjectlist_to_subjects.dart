import 'package:rao_academy/domain/entities/subject_list_entity.dart';
import 'package:rao_academy/domain/entities/subjects_entity.dart';

List<Subjects> subjectListToSubjects(List<SubjectList> subjects) {
  final List<Subjects> list = [];
  subjects.forEach((element) {
    list.add(Subjects(id: element.id, name: element.name));
  });
  return list;
}

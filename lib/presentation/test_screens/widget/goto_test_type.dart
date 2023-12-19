import 'package:flutter/material.dart';
import 'package:rao_academy/domain/entities/test_start_entity.dart';
import 'package:rao_academy/presentation/test_screens/test_types/dnd.dart';
import 'package:rao_academy/presentation/test_screens/test_types/fill.dart';
import 'package:rao_academy/presentation/test_screens/test_types/mcq.dart';
import 'package:rao_academy/presentation/test_screens/test_types/msq.dart';
import 'package:rao_academy/presentation/test_screens/test_types/mtf.dart';
import 'package:rao_academy/presentation/test_screens/test_types/sequence.dart';
import 'package:rao_academy/presentation/test_screens/test_types/tof.dart';

Widget getTestType(Question question, {required bool practice}) {
  switch (question.format) {
    case 'MCQ':
      return MCQ(
        question: question,
        practice: practice,
      );
    case 'Fill':
      // final TextEditingController controller = TextEditingController(text: '');
      return Fill(
        question: question,
        practice: practice,
      );
    case 'MSQ':
      return MSQ(
       question: question,
        practice: practice,
      );
    case 'Match':
      return MathTheFollowing(
       question: question,
        practice: practice,
      );
    case 'Drag & Drop':
      return DragNDrop(
        question: question,
        practice: practice,
      );
    case 'Sequence':
      return Sequence(
        question: question,
        practice: practice,
      );
    case 'True/False':
      return TOF(
        question: question,
        practice: practice,
      );
    default:
      return Fill(
        question: question,
        practice: practice,
      );
  }
}

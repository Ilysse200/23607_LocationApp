import 'package:flutter/material.dart';
import 'package:hive/hive.dart';


class QuestionWidget extends StatelessWidget {
String questionText;

QuestionWidget(this.questionText, {super.key});

@override
Widget build(BuildContext context) {
	return Container(
	width: double.infinity,
	margin: const EdgeInsets.all(10),
	child: Text(
		questionText,
		style: const TextStyle(fontSize: 28),
		textAlign: TextAlign.center,
	), //Text
	); //Contaier
}
}
